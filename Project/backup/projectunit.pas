unit ProjectUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ComCtrls, StdCtrls, LazUTF8, LazFileUtils, IniFiles,
  UITypes, FileUtil,
  SourceTextUnit,
  LDTextParserUnit,
  SymbolsUnit,
  ModulesUnit,
  FormValueInitUnit,
  ProjectConfigUnit,  // форма конфигурации проекта
  CompileUnit,        // модуль компилятора
  ErrMessNavigateUnit,
  GNUConfUnit;        // форма настройки компиляции

type

  // классы для навигатора файлов проекта
  TRecType=(rtStart, rtFile, rtDir);

  TRecInfo=class(tobject)
    RecType:TRecType;// тип узла
    name:string;     // имя узла
  end;

  { TProject }

  TProject=class(TObject)
    private
      ProjectOpened:boolean;           // проект открыт
      ProjectFile:string;              // файл проекта

      PModePath:string;                // путь проекта который нужно показывать

      PTree:TTreeView;
      PMode:TComboBox;

      LD_ST:TSourceText;               // файл сборки проекта

      ProjectConfigForm:TProjectConfigForm; // форма настройки

      function getDeviceInfo: string;
      function getEditorTempPath: string;
      function getOUTPath: string;
      function getProjectCpu: string;
      function getProjectFpu: string;
      function getProjectMCU: string;
      function getProjectMCUConfFile: string;
      function getProjectMCUOpenOCD: string;
      function getProjectSyntax: string;
      function getProjectTargetAdr: string;
      function getProjectThumb: string;
      function getProject_Path: string;
      function getProject_SourcePath: string;

      function GetTreeState: TStringList;  // получить данные о состоянии дерева файлов

      procedure PModeChange(Sender: TObject);
      procedure ProjectTreeBuild;
      procedure CreateProTree(Root: String; Node: TTreeNode; ext: TStringList); // построение дерева файлов проекта

      procedure OpenProTreeFile(Sender: TObject); // открытие файла из дерева файлов проекта (по дабл клику)

    public
      GlobalSymbols:TSymbolList;

      ModulesForm: TModulesForm; // управление модулями
      GNUConfForm: TGNUConfForm;            // форма настройки компиляции

      property Project_Opened:boolean read ProjectOpened;     // проект открыт
      property Project_File:string read ProjectFile;          // имя файла проекта
      property Project_Path:string read getProject_Path;      // путь к проекту
      property SourcePath:string read getProject_SourcePath;  // путь к исходным файлам
      property EditorTempPath:string read getEditorTempPath;  // путь к временным файлам проекта
      property Out_Path:string   read getOUTPath;             // путь к каталогу компиляции

      property Project_Syntax:string read getProjectSyntax;   // .syntax
      property Project_Cpu:string read getProjectCpu;         // .cpu
      property Project_Thumb:string read getProjectThumb;     // .Thumb
      property Project_Fpu:string read getProjectFpu;         // .cpu
      property Project_MCU:string read getProjectMCU;         // MCU
      property Project_MCU_FILE:string read getProjectMCUConfFile; // Project_MCU_CONF_FILE
      property Project_MCU_OpenOCD:string read getProjectMCUOpenOCD; // путь к конфигурации микроконтроллера openOCD
      property Project_MCU_TargetAdr:string read getProjectTargetAdr; // адрес программирования
      property Project_MCU_DeviceInfo:string read getDeviceInfo; // информция о периферии
      constructor Create(PT:TTreeView; PM:TComboBox);
      destructor  Free;

      procedure   Update; // обновить визуальные компоненты

      procedure   OpenOldProject;

      procedure   New(filename:string);      // создать проект
      procedure   Open(filename:string);     // открыть проект
      procedure   Config;                    // настройки проекта
      procedure   Close;                     // закрыть проект

      procedure   FullCompile;               // компиляция проекта
      procedure   GNU_Clear_Path;            // очистка каталога компиляции

      procedure   ClearFileGlobalSymbols(filename:string);
      function    GetCodeSectionsList:TStringList;         // список секций кода
      function    CodeSectionPresent(sec:string):boolean;  // проверка наличия секции по имени

      procedure   AddModule(fname: string);   // добавление модуля в список файлов проекта
      procedure   ErrMessNavigateDbClick(Sender: TObject);  // двойной клик на списке ошибок

      function  GetProTreePath(Node: TTreeNode): string;      // получение пути к выбранному узлу дерева в виде строки файловой системы
  end;

implementation

uses MainUnit;

{ TProject }

// путь к приложению
function TProject.getProject_Path: string;
begin
  Result:=UTF8LowerCase(ExtractFilePath(ProjectFile));
end;

// путь к временным файлам проекта
function TProject.getEditorTempPath: string;
begin
  Result:=Project_Path+ProjectConfigForm.EDIT_PATH.Text;
end;

// файл информации о периферии
function TProject.getDeviceInfo: string;
begin
  Result:=app_path+ProjectConfigForm.MCU_DEVICEINFO.Text;
end;

// путь к каталогу компилятора
function TProject.getOUTPath: string;
begin
  Result:=UTF8LowerCase(Project_Path + ProjectConfigForm.OUT_PATH.Text);
end;

function TProject.getProjectCpu: string;
begin
  Result:=ProjectConfigForm.MCU_CPU.Text;
end;

function TProject.getProjectFpu: string;
begin
  Result:=ProjectConfigForm.MCU_FPU.Text;
end;

function TProject.getProjectMCU: string;
begin
  Result:=ProjectConfigForm.MCU_NAME.Text;
end;

function TProject.getProjectMCUConfFile: string;
begin
  Result:=ProjectConfigForm.MCU_CONF_FILE.Text;
end;

// путь к конфигурации микроконтроллера openOCD
function TProject.getProjectMCUOpenOCD: string;
begin
  Result:=UTF8LowerCase(app_path+ProjectConfigForm.MCU_OPENOCD.Text);
end;

function TProject.getProjectSyntax: string;
begin
  Result:=ProjectConfigForm.MCU_SYNTAX.Text;
end;

//адрес программирования микроконтроллера
function TProject.getProjectTargetAdr: string;
begin
  Result:=ProjectConfigForm.MCU_TARGET_ADR.Text;
end;

function TProject.getProjectThumb: string;
begin
  Result:=ProjectConfigForm.MCU_THUMB.Text;
end;

// путь к исходным файлам
function TProject.getProject_SourcePath: string;
begin
  Result:=UTF8LowerCase(Project_Path+ProjectConfigForm.SRC_PATH.Text);
end;

// получить данные о состоянии дерева файлов
function TProject.GetTreeState: TStringList;
var
//  Node:TTreeNode;
  res:TStringList;
  i:integer;
begin
  res:=TStringList.Create;
  for i:=0 to PTree.Items.Count-1 do
    if TTreeNode(PTree.Items.Item[i]).Expanded then
        res.Add(GetProTreePath(TTreeNode(PTree.Items.Item[i])));
  Result:=res;
end;

// смена режима отображения
procedure TProject.PModeChange(Sender: TObject);
begin
  Update;
end;

// построение дерева файлов проекта
procedure TProject.ProjectTreeBuild;
var
  TreeNode:TTreeNode;
  RecInfo:TRecInfo;
  state:TStringList;
  str:string;
begin
  state:=GetTreeState;  // получим состояние дерева

  PTree.Items.Clear;

  case PMode.ItemIndex of
    0: PModePath:=Project_Path;
    1: PModePath:=SourcePath;
    2: PModePath:=Out_Path;
  end;

  if UTF8Copy(PModePath, UTF8Length(PModePath), 1)<>'\' then PModePath:=PModePath+'\';

  RecInfo:=TRecInfo.create;
  RecInfo.RecType:=rtStart;

  TreeNode:=PTree.Items.AddObject(nil, ExtractFileName(Project_File), RecInfo);
  treenode.ImageIndex:=1; treenode.SelectedIndex:=1;

  str:=PModePath;
  CreateProTree(str, TreeNode, state);
  TreeNode.Expanded:=true;
end;

// рекурсивная процедура построения дерева
procedure TProject.CreateProTree(Root: String; Node: TTreeNode; ext:TStringList);
var
  SearchRec : TSearchRec;
  tmpNode:TTreeNode;
  fList:TStringList;
  dirList:TStringList;
  i, t:integer;
  RecInfo:TRecInfo;
  str:string;
//  ST:TSourceText;
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
             if ((SearchRec.Attr and faDirectory)=0) then fList.Add(SearchRec.Name)     // нашли файл
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
        CreateProTree(Root+dirList.Strings[i]+'\', tmpNode, ext);

        // проверим нужно ли развернуть дерево
        str:=GetProTreePath(tmpNode);
        for t:=0 to ext.Count-1 do
          if UTF8Pos(str, ext.Strings[t], 1)=1 then tmpNode.Expanded:=true;

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

//        MainForm.SetStatus1(GetProTreePath(tmpnode));
        // в зависимости от расширения назначаем иконки
        case ExtractFileExt(fList.Strings[i]) of
          '.aep': begin tmpNode.ImageIndex:=14; tmpNode.SelectedIndex:=14; end;
          '.asm': begin
                    tmpNode.ImageIndex:=12; tmpNode.SelectedIndex:=12;
                    str:=GetProTreePath(tmpnode);
                    EditorFiles.Open(str);
                  end;
          '.-asm': begin
                    tmpNode.ImageIndex:=22; tmpNode.SelectedIndex:=22;
                  end;
          '.bin': begin tmpNode.ImageIndex:=6; tmpNode.SelectedIndex:=6; end;
          '.dfu': begin tmpNode.ImageIndex:=15; tmpNode.SelectedIndex:=15; end;
          '.inc': begin
                    tmpNode.ImageIndex:=3; tmpNode.SelectedIndex:=3;
                    str:=GetProTreePath(tmpnode);
                    EditorFiles.Open(str);
                  end;
          '.ld': begin
                    tmpNode.ImageIndex:=9; tmpNode.SelectedIndex:=9;
                    LD_ST:=EditorFiles.Open(GetProTreePath(tmpnode));
                    EditorFiles.ReloadLDFile;
                  end;
          '.ini': begin tmpNode.ImageIndex:=5;  tmpNode.SelectedIndex:=5;  end;
          '.bat': begin tmpNode.ImageIndex:=20; tmpNode.SelectedIndex:=20;  end;
          '.exe': begin tmpNode.ImageIndex:=20; tmpNode.SelectedIndex:=20;  end;
          '.lst': begin tmpNode.ImageIndex:=2;  tmpNode.SelectedIndex:=2;   end;
          '.elf': begin tmpNode.ImageIndex:=13; tmpNode.SelectedIndex:=13;  end;
          '.hex': begin tmpNode.ImageIndex:=10; tmpNode.SelectedIndex:=10;  end;
          '.txt': begin tmpNode.ImageIndex:=21;  tmpNode.SelectedIndex:=21; end;
          '.obj': begin tmpNode.ImageIndex:=16;  tmpNode.SelectedIndex:=16; end;
          '.dasm','.sasm': begin tmpNode.ImageIndex:=8;  tmpNode.SelectedIndex:=8; end;
          else begin tmpNode.ImageIndex:=23;  tmpNode.SelectedIndex:=23; end;
        end;

      end;
end;

// получение пути к выбранному узлу дерева в виде строки файловой системы
function TProject.GetProTreePath(Node: TTreeNode): string;
begin
  GetProTreePath:=Node.Text;
      while(Node.Level>1) do
        begin
          Node:=Node.Parent;
          GetProTreePath:=Node.Text+'\'+GetProTreePath;
        end;
  // в зависимости от типа дерева - расчет пути к файлу
  GetProTreePath:=UTF8LowerCase(PModePath+GetProTreePath); // путь при дереве проекта
end;


// открытие файла из дерева файлов проекта (по дабл клику)
procedure TProject.OpenProTreeFile(Sender: TObject);
var
  RI:TRecInfo;
  str:string;
begin
  if  PTree.Selected=nil then exit;  // если нет выделенного узла - выходим

  RI:=TRecInfo(PTree.Selected.Data);
  if RI.RecType<>rtFile then exit; // если не файл - то выходим

  str:=GetProTreePath(PTree.Selected);

 // MainForm.Caption:=str; //отладка !!!!!!!!!!!!!!!1

  EditorFiles.OpenInEditor(str); // откроем файл в редакторе
end;

constructor TProject.Create(PT: TTreeView; PM: TComboBox);

begin
  PTree:=PT;
  PTree.OnDblClick:=@OpenProTreeFile;
  PMode:=PM;
  PMode.OnChange:=@PModeChange;

  ProjectConfigForm:=TProjectConfigForm.Create(MainForm);

  GNUConfForm:=TGNUConfForm.Create(MainForm);

  GlobalSymbols:=TSymbolList.Create;

  ProjectOpened:=false;
end;

procedure TProject.OpenOldProject;
var
  inif:TIniFile;
begin
inif:=TIniFile.Create(app_conf_name);

  if inif.ReadBool('PROJECT', 'present', false) then
     Open(inif.ReadString('PROJECT', 'file', ''));    // откроем проект

  inif.Free;
end;

destructor TProject.Free;
var
  inif:TIniFile;
begin
  inif:=TIniFile.Create(app_conf_name);

  inif.EraseSection('PROJECT');
  inif.WriteBool('PROJECT', 'present', ProjectOpened);

  if ProjectOpened then // если проект есть - сохраним его данные
    begin
       inif.WriteString('PROJECT', 'file', Project_File);

    end;

  inif.UpdateFile;
  inif.Free;

  Project.Close; // обновим файл проекта закрытием

  GlobalSymbols.Free;

  GNUConfForm.Free;

  ProjectConfigForm.Free;
end;

// обновить визуальные компоненты
procedure TProject.Update;
begin
  if not ProjectOpened then exit;

   ProjectTreeBuild; // построим дерево проекта
end;

// создать проект
procedure TProject.New(filename: string);
begin
  // если открыт проект - закроем его
  if ProjectOpened then Close;

  ProjectFile:=filename;

  ProjectConfigForm.NewPro;
  if ProjectConfigForm.ShowModal=mrOk then
    begin
      SaveFormValues(ProjectConfigForm, 'CONFIG',    filename); // записываем настройки проекта в файл

      GNUConfForm.DefaultValues;
      SaveFormValues(GNUConfForm,       'GNUConfig', filename);

      Open(filename);
    end
  else ProjectFile:='';
end;

// открытие проекта
procedure TProject.Open(filename: string);
var
  inif:TIniFile;
  i, n:integer;
  str:string;
  chs:string;
  ST:TSourceText;
begin
  if  (filename='') or not FileExists(filename) then exit;

  // если открыт проект - закроем его
  if ProjectOpened then Close;

  LD_ST:=nil;

  ProjectOpened:=true;
  ProjectFile:=filename;

  LoadFormValues(ProjectConfigForm,  'CONFIG',    ProjectFile); // читаем настройки проекта из файла
  LoadFormValues(GNUConfForm,        'GNUConfig', ProjectFile);

  PMode.ItemIndex:=0;
  PModePath:=Project_Path;

  // включаем элементы управления и строем дерево файлов проекта
  PTree.Enabled:=true; PMode.Enabled:=true; PMode.ItemIndex:=0;
  PTree.Items.Clear;
  ProjectTreeBuild;

  GlobalSymbols.Clear;
  EditorFiles.UpdateSTSymbolInfo;

  // откроем файлы проекта
  inif:=TIniFile.Create(ProjectFile);
  n:=inif.ReadInteger('OPENFILES', 'count', -1);
  i:=0;
  while i<n do
    begin
      str:=inif.ReadString('OPENFILES', 'file'+inttostr(i)+'name', '');       // имя файла
      chs:=inif.ReadString('OPENFILES', 'file'+inttostr(i)+'chs',  'CP1251'); // имя файла
      ST:=TSourceText(EditorFiles.Get(SourcePath+str));                       // получим файл
      if ST<>nil then
        begin
          if inif.ReadBool('OPENFILES', 'file'+inttostr(i)+'changed', false) then
            begin
             ST.CharSet:=chs;
             ST.OpenFile(EditorTempPath+'\ed-temp'+inttostr(i));
             ST.FileName:=SourcePath+str;
             ST.TextChange:=true;
            end;
          EditorFiles.OpenInEditor(ST);  // откроем в редакторе
        end;
      i:=i+1;
    end;

  //откроем файл который был открыт в редакторе при закрытии
  str:=inif.ReadString('OPENFILES', 'selected', '-');
  if str<>'-' then
    begin
      ST:=EditorFiles.Get(str);
      if ST<>nil then EditorFiles.OpenInEditor(ST);  // откроем в редакторе
    end;

   ModulesForm:=TModulesForm.Create(MainForm); // управление модулями
   for i:=0 to inif.ReadInteger('MODULES', 'mod_count', 0)-1 do
    ModulesForm.AddModuleFile(Project.Project_Path+'modules\'+ inif.ReadString('MODULES', 'mod'+inttostr(i), ''));

  inif.Free;
  EditorFiles.Update;
end;

// настройки проекта
procedure TProject.Config;
begin
  if not ProjectOpened then exit;

  if ProjectConfigForm.ShowModal=mrOk then
    SaveFormValues(ProjectConfigForm, 'CONFIG', ProjectFile); // запишем настройки проекта из файла
end;

// закрыть проект
procedure TProject.Close;
var
  i,n:integer;
  ST:TSourceText;
  inif:TIniFile;
  str, sel:string;
begin
  if not ProjectOpened then exit;

  ModulesForm.Free;

  PTree.Items.Clear; // очистим дерево файлов

  PTree.Enabled:=false;
  PMode.Enabled:=false;

  SaveFormValues(ProjectConfigForm,  'CONFIG',    ProjectFile); // запишем настройки проекта из файла
  SaveFormValues(GNUConfForm,        'GNUConfig', ProjectFile);


  // закроем файлы проекта
  inif:=TIniFile.Create(ProjectFile);
  inif.EraseSection('OPENFILES');
  i:=0; n:=0;
  sel:=EditorFiles.GetNameSelected;
  while i<EditorFiles.Count do
    begin
      ST:=TSourceText(EditorFiles.Get(i));
      if UTF8Pos(UTF8UpperCase(Project_Path), UTF8UpperCase(ST.FileName), 1)=1 then // файл входит в проект
        begin
          if ST.OpenInEditor then  // если файл был открыт в редакторе - запомним
             begin
               str:=UTF8Copy(ST.FileName, UTF8Length(SourcePath)+1, UTF8Length(ST.FileName)-UTF8Length(SourcePath)+1);
               inif.WriteString('OPENFILES', 'file'+inttostr(n)+'name', str);
               inif.WriteString('OPENFILES', 'file'+inttostr(n)+'chs', ST.CharSet);
               if ST.TextChange then // если текст содержит не сохраненные изменения
                  begin
                    inif.WriteBool('OPENFILES', 'file'+inttostr(n)+'changed', true);
                    ST.FileName:=EditorTempPath+'\ed-temp'+inttostr(n);
                    ST.SaveFile;
                  end;
               n:=n+1;
             end;
          EditorFiles.Close(ST, false);
          i:=0;
        end else i:=i+1;
    end;
  if n>0 then
    begin
     inif.WriteInteger('OPENFILES', 'count', n);
     inif.WriteString('OPENFILES', 'selected', sel);
    end;

  inif.UpdateFile;
  inif.Free;

  if EditorFiles.Count>0 then EditorFiles.OpenInEditor(0)
                         else Editor.SetSourceText(nil);

  ProjectOpened:=false;
  ProjectFile:='';
  EditorFiles.Update;
end;



// очистка глобальных символов файла
procedure TProject.ClearFileGlobalSymbols(filename: string);
var
  i:integer;
  str:string;
begin
  str:=UTF8LowerCase(filename);
  i:=0;
  while i<GlobalSymbols.Count do
    if TSymbol(GlobalSymbols.GetSymb(i)).FileName=str then GlobalSymbols.DelSymb(i)
                           else i:=i+1;
end;

// список секций кода
function TProject.GetCodeSectionsList: TStringList;
begin
  Result:=nil;
  if LD_ST=nil then exit;
  if (LD_ST.TextParser is TLDTextParser) then
    Result:=TStringList(TLDTextParser(LD_ST.TextParser).CodeSectionList);
end;

// проверка наличия секции по имени
function TProject.CodeSectionPresent(sec: string): boolean;
var
  i:integer;
  lst:TStringList;
  str:string;
begin
  Result:=false;
  lst:=GetCodeSectionsList;
  if lst=nil then exit;
  str:=UTF8UpperCase(sec);
  for i:=0 to lst.Count-1 do
    if UTF8UpperCase(lst.Strings[i])=str then
      begin
         Result:=true;
         exit;
      end;
end;

procedure TProject.AddModule(fname: string);
var
  inif:TIniFile;
  newnam:string;
  i, modc:integer;
begin
  // откроем файлы проекта
  inif:=TIniFile.Create(ProjectFile);

   // проверим не включался ли модуль ранее
  modc:=inif.ReadInteger('MODULES', 'mod_count', 0);
  for i:=0 to modc-1 do
    if inif.ReadString('MODULES', 'mod'+inttostr(i), '')=ExtractFileName(fname) then exit;

  // копируем настроечный файл модуля
  newnam:=Project_Path+'modules\'+ExtractFileName(fname);
  CopyFile(fname, newnam);

  inif.WriteInteger('MODULES', 'mod_count', modc+1);
  inif.WriteString('MODULES', 'mod'+inttostr(modc), ExtractFileName(newnam));

  inif.UpdateFile;
  inif.Free;

  ModulesForm.AddModuleFile(newnam);   // добавим модуль в список
end;


// компиляция проекта
procedure TProject.FullCompile;
var
  ProjectFiles:TStringList;
  i, pos, ln:integer;
  str, relatName, outPath, asExe:string;
  outStrList:TStringList;
  errFl:boolean;
  objFiles:TStringList;
  MessType:TMessType;
begin
  // если выбрано сохраним проект перед компиляцией
  if GNUConfForm.SaveBeforeCompile.Checked then MainForm.Menu_File_SaveAll.Click;

  errFl:=false;
  objFiles:=TStringList.Create;


  GNU_Clear_Path; // очистим каталоги компиляции
//  DeleteDirectory(Out_Path+'\internal\', true); // удалим старые файлы

  MainForm.MessagesListBox.OnDblClick:=@ErrMessNavigateDbClick;

  // компиляция
  ProjectFiles:=FindAllFiles(SourcePath, '*.asm;*.ASM', true);
  for i:=0 to ProjectFiles.Count-1 do
   begin
     // компилируемый файл ?
     if UTF8UpperCase(ExtractFileExt(ProjectFiles.Strings[i]))='.ASM' then
       begin
         // получим относительное имя файла
         str:=UTF8LowerCase(ProjectFiles.Strings[i]);
         pos:=UTF8Length(SourcePath)+2;
         ln:=UTF8Length(str)-pos+1;
         relatName:=Out_Path+'\internal\'+UTF8Copy(str, pos, ln-4);

         // создадим выходной каталог (если его нет)
         outPath:=ExtractFilePath(relatName+'.o');
         ForceDirectoriesUTF8(outPath);

         asExe:=GNUConfForm.AsFile.Text;
//         MainForm.MessagesListBox.Items.Add('Компиляция: '+str);

         outStrList:=TStringList.Create;
         CompileAsmFile(AsExe,
                        str,
                        relatName+'.o',
                        UTF8Copy(Project_Path, 1, UTF8Length(Project_Path)-1),
                        outStrList);

         if outStrList.Count>0 then
           begin
             errFl:=true; // возникла ошибка !
             MainForm.MessagesListBox.Items.Add('Найденные ошибки компиляции проекта:');

             // вывод результатов компиляции
             for pos:=1 to outStrList.Count-1 do
               begin
                 MessType:=TMessType.Create(mtGNU_As, str);
                 MainForm.MessagesListBox.Items.AddObject(outStrList.Strings[pos], MessType);
               end;
           end
         else
           begin
             objFiles.Add(relatName+'.o'); // нет ошибки

             // вывод раздельных результатов компиляции
             if GNUConfForm.FileSectionInfoCheckBox.Checked then
               begin
                 asExe:=GNUConfForm.ObjDumpFile.Text;
                 outStrList:=TStringList.Create;
                 DumpInfoFileD(asExe, relatName+'.o', outStrList);
                 outStrList.SaveToFile(relatName+'.dasm');
               end;
           end;
           outStrList.Free;
       end;
   end;
  ProjectFiles.Free;

  // сборка
  if not errFl then
    begin
      ProjectFiles:=FindAllFiles(SourcePath, '*.ld', true);
      case ProjectFiles.Count of
        0: begin
              MainForm.MessagesListBox.Items.Add('Не найден файл сборки (*.ld)');
              errFl:=true;
              exit;
        end;
        1: begin // сборка
             outStrList:=TStringList.Create;
             LinkFiles(GNUConfForm.LdFile.Text,
                       ProjectFiles.Strings[0],
                       Out_Path+'\sys.elf',
                       objFiles,
                       outStrList);
             if outStrList.Count>0 then
               begin
                 MainForm.MessagesListBox.Items.Add('Найденные ошибки сборки проекта:');
                 // вывод результатов сборки
                 pos:=0;
                 while pos<outStrList.Count do
                   begin
                     str:=outStrList.Strings[pos];
                     if (pos+1<outStrList.Count) and (UTF8Copy(str, UTF8Length(str), 1)=':') then
                       begin
                         pos:=pos+1;
                         str:=str+outStrList.Strings[pos];
                       end;

                      MessType:=TMessType.Create(mtGNU_ld, ProjectFiles.Strings[0]);
                      MainForm.MessagesListBox.Items.AddObject(str, MessType);

                     pos:=pos+1;
                   end;
                 errFl:=true;
               end
             else
              MainForm.MessagesListBox.Items.Add('Скомпилированный файл проекта: '+Out_Path+'\sys.elf'+' создан');
             outStrList.Free;
             objFiles.Free;
        end;
        else begin
               MainForm.MessagesListBox.Items.Add('Ошибка! Найдено несколько файлов сборки '+ProjectFiles.Text);
               errFl:=true;
               exit;
             end
      end;
      ProjectFiles.Free;
    end
  else exit; // если ошибка где нить то можно выходить

  // доп информация по прошивке целиком дизассемблер всего проекта
  if (not errFl) and GNUConfForm.ProjectDAsmCheckBox.Checked then
    begin
      asExe:=GNUConfForm.ObjDumpFile.Text;
              outStrList:=TStringList.Create;
              DumpInfoFileD(asExe, Out_Path+'\sys.elf', outStrList);
              outStrList.SaveToFile(Out_Path+'\sys.dasm');
              outStrList.Free;
              MainForm.MessagesListBox.Items.Add('Проект дизассемблированный целиком: '+Out_Path+'\sys.dasm');
    end;

  // доп информация по прошивке целиком по секциям
  if (not errFl) and GNUConfForm.DAsmSectionCheckBox.Checked then
    begin
      asExe:=GNUConfForm.ObjDumpFile.Text;
      outStrList:=TStringList.Create;
      DumpInfoFileS(asExe, Out_Path+'\sys.elf', outStrList);
      outStrList.SaveToFile(Out_Path+'\sys.sasm');
      outStrList.Free;
      MainForm.MessagesListBox.Items.Add('Проект дизассемблированный по секциям: '+Out_Path+'\sys.sasm');
    end;

  // доп информация по символам
  if (not errFl) and GNUConfForm.ProjectSymbolsCheckBox.Checked then
    begin
      asExe:=GNUConfForm.NmFile.Text;
      outStrList:=TStringList.Create;
      SymbolNamesFile(asExe, Out_Path+'\sys.elf', outStrList);
      outStrList.SaveToFile(Out_Path+'\symbols.lst');
      outStrList.Free;
      MainForm.MessagesListBox.Items.Add('Значения символов: '+Out_Path+'\symbols.lst');
    end;

  // bin прошивка
  if (not errFl) and GNUConfForm.ResBINCheckBox.Checked then
    begin
      asExe:=GNUConfForm.ObjCopyFile.Text;
      outStrList:=TStringList.Create;
      ElfToBinFile(asExe, Out_Path+'\sys.elf', Out_Path+'\sys.bin', outStrList);
      MainForm.MessagesListBox.Items.Add('BINARY файл проекта: '+Out_Path+'\sys.bin');
    end;

  // hex прошивка
  if (not errFl) and GNUConfForm.ResBINCheckBox.Checked then
    begin
      asExe:=GNUConfForm.ObjCopyFile.Text;
      outStrList:=TStringList.Create;
      ElfToHexFile(asExe, Out_Path+'\sys.elf', Out_Path+'\sys.hex', outStrList);
      MainForm.MessagesListBox.Items.add('Intel HEX файл проекта: '+Out_Path+'\sys.hex');
    end;

end;

// двойной клик на списке ошибок
procedure TProject.ErrMessNavigateDbClick(Sender: TObject);
var
  MessType:TMessType;
  str:string;
begin
   if MainForm.MessagesListBox.Count=0 then exit; // список пуст

   // сообщение об ошибке ?
   if MainForm.MessagesListBox.Items.Objects[MainForm.MessagesListBox.ItemIndex]=nil then exit;

   MessType:=TMessType(MainForm.MessagesListBox.Items.Objects[MainForm.MessagesListBox.ItemIndex]);
   str:=MainForm.MessagesListBox.Items.Strings[MainForm.MessagesListBox.ItemIndex];

   ErrMessGNUNavigate(MessType, str);
   Editor.Refresh;
end;


// очистка каталога компиляции
procedure TProject.GNU_Clear_Path;
begin
  DeleteDirectory(Out_Path, true); // удалим старые файлы

  EditorFiles.ClearOutCompileFiles;  // удалим файлы компилятора из списка открытых файлов

  ForceDirectory(Out_Path+'\internal'); // каталог внутреннего компилятора
  ForceDirectory(Out_Path+'\temp');     // каталог внешнего компилятора

  MainForm.MessagesListBox.Items.Clear;

end;

end.

