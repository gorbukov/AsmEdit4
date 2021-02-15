unit FilesUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, Dialogs, LazUTF8, LazFileUtils,
  SourceTextUnit;

type
  TRecType=(rtStart, rtFile, rtDir);

  TRecInfo=class(tobject)
    RecType:TRecType;// тип узла
    name:string;     // имя узла
  end;

  { TEditorFile }

  TEditorFile=class(TObject)
     private
        FileList:TList;

        OpenedFileListBox: TListBox;
        ProjectTree:TTreeView;
        ProjectModeCombo:TComboBox;

        procedure OpenedFileSelectionChange(Sender: TObject; {%H-}User: boolean);
        procedure LoadProjectTree(Root: String; Node: TTreeNode);
        function  RecPath(Node: TTreeNode): string;
        procedure OpenProTreeFile(Sender: TObject);

        procedure ProjectModeComboChange(Sender: TObject);
     public
       pro_path:string;

       constructor create(LB:TListBox; PT:TTreeView; CM:TComboBox);
       destructor  free;



       procedure   SetEditorFile(ST:TSourceText);  // установить открытый в редакторе файл

       procedure   UpdateStatus;                   // обновить статус файлов

       function    Count:integer;
       function    Get(num:integer):TSourceText;   // получить текстовый файл  по номеру

       function    Add:TSourceText;                         // добавить текстовый файл
       function    Open(name:string):TSourceText;           // открыть текстовый файл
       function    CloseFile(ST: TSourceText): TSourceText; // закрыть редактируемый файл

       function    GetNum(ST:TSourceText):integer; // получить номер текста в списке



       procedure   SetProjectPath(path: string);    // установка пути проекта
  end;

implementation

uses MainUnit, ConfigUnit;

{ TEditorFile }

// выбор файла из списка открытых для показа в редакторе
procedure TEditorFile.OpenedFileSelectionChange(Sender: TObject; User: boolean);
begin
  Editor.SetSourceText(TSourceText(OpenedFileListBox.Items.Objects[OpenedFileListBox.ItemIndex]));

end;

procedure TEditorFile.LoadProjectTree(Root: String; Node: TTreeNode);
var
  SearchRec : TSearchRec;
  tmpNode:TTreeNode;
  fList:TStringList;
  dirList:TStringList;
  i:integer;
  RecInfo:TRecInfo;
begin
   fList:=TStringList.Create;
   dirList:=TStringList.Create;

   // поиск по текущей директории
   if FindFirstUTF8(Root + '*.*', faAnyFile, SearchRec) = 0 then
     repeat
       if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
         begin
           if ((SearchRec.Attr and faDirectory) <> 0) then dirList.Add(SearchRec.Name)  // нашли папку
            else
             if ((SearchRec.Attr and faDirectory)=0) then fList.Add(SearchRec.Name)  // нашли файл
         end;
     until FindNextUTF8(SearchRec) <> 0;

    FindCloseUTF8(SearchRec);

    dirList.Sort;
    fList.Sort;

    // делаем поиск по другим директориям
    for i:=0 to dirList.Count-1 do
      begin
        // тип добавляемого узла - директория
        RecInfo:=TRecInfo.create;
        RecInfo.RecType:=rtDir;
        RecInfo.name:=dirList.Strings[i];

        // добавим директорию в дерево
        tmpNode:=Node.TreeView.Items.AddChildObject(Node, dirList.Strings[i], RecInfo);
        tmpNode.ImageIndex:=0; tmpNode.SelectedIndex:=0;

        // проведем поиск в найденной директории (папке)
        LoadProjectTree(Root+dirList.Strings[i]+'\', tmpNode);
      end;

    // добавляем обнаруженные файлы в текущую директорию (папку)
    for i:=0 to fList.Count-1 do
      begin
        // тип записи - файл
         RecInfo:=TRecInfo.create;
         RecInfo.RecType:=rtFile;
         RecInfo.name:=fList.Strings[i];

        // добавим файл в дерево
        tmpNode:=Node.TreeView.Items.AddChildObject(Node, fList.Strings[i], RecInfo);


        // в зависимости от расширения назначаем иконки
        case ExtractFileExt(fList.Strings[i]) of
          '.aep': begin tmpNode.ImageIndex:=14; tmpNode.SelectedIndex:=14; end;
          '.asm': begin
                    tmpNode.ImageIndex:=12; tmpNode.SelectedIndex:=12;
                    Open(pro_path+RecPath(tmpnode));
                  end;
          '.bin': begin tmpNode.ImageIndex:=6; tmpNode.SelectedIndex:=6; end;
          '.dfu': begin tmpNode.ImageIndex:=15; tmpNode.SelectedIndex:=15; end;
          '.inc': begin
                    tmpNode.ImageIndex:=3; tmpNode.SelectedIndex:=3;
                    Open(pro_path+RecPath(tmpnode));
                  end;
          '.ld': begin
                    tmpNode.ImageIndex:=9; tmpNode.SelectedIndex:=9;
                    Open(pro_path+RecPath(tmpnode));
                  end;
          '.bat': begin tmpNode.ImageIndex:=20; tmpNode.SelectedIndex:=20; end;
          '.exe': begin tmpNode.ImageIndex:=20; tmpNode.SelectedIndex:=20; end;
          '.lst': begin tmpNode.ImageIndex:=2;  tmpNode.SelectedIndex:=2;  end;
          '.elf': begin tmpNode.ImageIndex:=13; tmpNode.SelectedIndex:=13; end;
          '.hex': begin tmpNode.ImageIndex:=10; tmpNode.SelectedIndex:=10; end;
        end;

      end;
end;

// получение пути к выбранному узлу дерева в виде строки файловой системы
function TEditorFile.RecPath(Node: TTreeNode): string;
begin
  RecPath:=Node.Text;
    while(Node.Level>1) do
      begin
        Node:=Node.Parent;
        RecPath:=Node.Text+'\'+RecPath;
      end;

    Node:=Node.Parent;
    if Node.Text='Source' then RecPath:='src\'+RecPath;
end;

// открытие файла из дерева файлов проекта
procedure TEditorFile.OpenProTreeFile(Sender: TObject);
var
  RecInfo:TRecInfo;
  ST:TSourceText;
begin
   if ProjectTree.Selected=nil then exit;

   // если выбранный узел файл - откроем его
   RecInfo:=TRecInfo(ProjectTree.Selected.Data);
   if RecInfo.RecType=rtFile then
     begin
        //ShowMessage(pro_path+RecPath(ProjectTree.Selected));
        ST:=EditorFiles.Open(pro_path+RecPath(ProjectTree.Selected)); // откроем файл
        Editor.SetSourceText(ST);                   // зададим его редактирование  в редакторе
        EditorFiles.SetEditorFile(ST);              // добавим в список редактируемых
     end;

end;

// смена режима отображения дерева проекта
procedure TEditorFile.ProjectModeComboChange(Sender: TObject);
begin
//  SetProjectPath(ExtractFilePath(Config.project_file));
end;

constructor TEditorFile.create(LB: TListBox; PT: TTreeView; CM: TComboBox);
begin
   // список открытых файлов
  OpenedFileListBox:=LB;
  OpenedFileListBox.OnSelectionChange:=@OpenedFileSelectionChange;
  // дерево файлов проекта
  ProjectTree:=PT;
  ProjectTree.OnDblClick:=@OpenProTreeFile;
  ProjectTree.Enabled:=false;
  // режим показа дерева проекта
  ProjectModeCombo:=CM;
  ProjectModeCombo.Enabled:=false;
  ProjectModeCombo.OnChange:=@ProjectModeComboChange;

  pro_path:='';

  FileList:=TList.Create;
end;

destructor TEditorFile.free;
begin
  FileList.Free;
end;

// установка пути проекта
procedure TEditorFile.SetProjectPath(path: string);
var
  TreeNode:TTreeNode;
  RecInfo:TRecInfo;
  str, wp:string;
begin
  if path='' then exit;

  ProjectModeCombo.Enabled:=true;
  ProjectTree.Enabled:=true;

  pro_path:=path;

  RecInfo:=TRecInfo.create;
  RecInfo.RecType:=rtStart;

  ProjectTree.Items.Clear;

  str:='Project';
  wp:=pro_path;
  if ProjectModeCombo.ItemIndex=1 then
    begin
      wp:=pro_path+'src\';
      str:='Source';
    end;
  // корневой узел
  treenode:=ProjectTree.Items.AddObject(nil, str , RecInfo);
  treenode.ImageIndex:=1; treenode.SelectedIndex:=1;

  LoadProjectTree(wp, treenode); // ищет сразу папки и файлы, сортирует их

  treenode.Expanded:=true; // развернем узел проекта
end;

// установить открытый в редакторе файл
procedure TEditorFile.SetEditorFile(ST: TSourceText);
var
  i:integer;
begin
  for i:=0 to OpenedFileListBox.Count-1 do
    if OpenedFileListBox.Items.Objects[i]=ST then
      begin
        OpenedFileListBox.ItemIndex:=i;
        exit;
      end;

  OpenedFileListBox.ItemIndex:=OpenedFileListBox.Items.AddObject(ExtractFileName(ST.FileName), ST);
end;

procedure TEditorFile.UpdateStatus;
var
  ST:TSourceText;
  i:integer;
  str:string;
begin
  for i:=0 to OpenedFileListBox.Count-1 do
    begin
      ST:=TSourceText(OpenedFileListBox.Items.Objects[i]);
      str:=ExtractFileName(ST.FileName);
      if ST.TextChange then str:=str+' [*]';
      OpenedFileListBox.Items.Strings[i]:=str;
    end;
end;

function TEditorFile.Count: integer;
begin
  Count:=FileList.Count;
end;

// добавить текстовый файл
function TEditorFile.Add: TSourceText;
var
  ST:TSourceText;
begin
  ST:=TSourceText.Create;
  FileList.Add(ST);
  Add:=ST;
end;

// открыть текстовый файл
function TEditorFile.Open(name: string): TSourceText;
var
  ST:TSourceText;
  i:integer;
begin
  // проверим наличие файла
  for i:=0 to FileList.Count-1 do
    if UTF8UpperCase(TSourceText(FileList.Items[i]).FileName)=UTF8UpperCase(name) then
      begin
        Open:=TSourceText(FileList.Items[i]);
        exit;
      end;
  // файла с такими именем нет - создадим его и откроем файл
  ST:=TSourceText.Create;
  FileList.Add(ST);
  ST.OpenFile(name);
  Open:=ST;
end;

function TEditorFile.Get(num: integer): TSourceText;
begin
  Get:=TSourceText(FileList.Items[num]);
end;

// закрыть редактируемый файл
function TEditorFile.CloseFile(ST: TSourceText):TSourceText;
var
  i, n:integer;
begin
  n:=-1;
  for i:=0 to OpenedFileListBox.Count-1 do
    if OpenedFileListBox.Items.Objects[i]=ST then
      begin
        n:=i;
        ST.CloseFile;
        ST.Free;
        break;
      end;
  OpenedFileListBox.Items.Delete(n);

  if n=OpenedFileListBox.Count then
    OpenedFileListBox.ItemIndex:=OpenedFileListBox.Count-1
  else OpenedFileListBox.ItemIndex:=n;

  if (OpenedFileListBox.ItemIndex>=0) then
    CloseFile:=TSourceText(OpenedFileListBox.Items.Objects[OpenedFileListBox.ItemIndex])
            else CloseFile:=nil;
end;

// получить номер текста в списке файлов
function TEditorFile.GetNum(ST: TSourceText): integer;
var
  i:integer;
begin
  GetNum:=-1;
  for i:=0 to FileList.Count-1 do
    if TSourceText(FileList.Items[i])=ST then
      begin
        GetNum:=i;
        exit;
      end;
end;

end.

