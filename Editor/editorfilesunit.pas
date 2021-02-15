unit EditorFilesUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StdCtrls, LazUTF8,
  SourceTextUnit,
  EditorUnit,
  TextParserUnit, AsmTextParserUnit;

type

  { TEditorFiles }

  TEditorFiles=class(TObject)
    private
       LB:TListBox;
       List:TList;

       procedure LBClick(Sender: TObject);

    public
      constructor Create(ListBox:TListBox);
      destructor  Free;

      function  Count:integer;
      function  GetNameSelected:string;               // имя выбранного файла
      function  Get(num:integer):TSourceText;         // получить по номеру
      function  Get(filename:string):TSourceText;     // получить по имени файла

      function  New:TSourceText;                      // добавить новый файл
      function  Open(filename:string):TSourceText;    // открыть файл
      function  Close(ST: TSourceText; closeFlag:boolean): TSourceText;  // закрыть

      procedure OpenInEditor(num:integer);            // открыть файл в редакторе
      procedure OpenInEditor(filename:string);
      procedure OpenInEditor(ST: TSourceText);

      procedure UpdateSTSymbolInfo;
      procedure ReloadLDFile;          // повторное чтение асм файлов после изменения ld файла
      procedure ClearOutCompileFiles;  // убрать из списка открытых файлов файлы результата компиляции
      procedure Update;                               // обновить состояние списка
  end;

implementation

uses MainUnit;
{ TEditorFiles }

// смена элемента в списке
procedure TEditorFiles.LBClick(Sender: TObject);
var
  str:string;
  ST:TSourceText;
begin
  if LB.ItemIndex=-1 then exit;

  ST:=Editor.SourceText;
  if ST<>nil then
    begin
      str:=UTF8UpperCase(ST.FileName);
      if (ST.TextChange) and
        (UTF8Length(str)=UTF8Pos('.LD', str, 1)+2) then
          ReloadLDFile;
    end;
  ST:=TSourceText(LB.Items.Objects[LB.ItemIndex]);

  OpenInEditor(ST);
  MainForm.StatusEditor;
end;

constructor TEditorFiles.Create(ListBox: TListBox);
begin
   List:=TList.Create;

   LB:=ListBox;
   LB.OnClick:=@LBClick;
end;

destructor TEditorFiles.Free;
begin
  List.Free;
end;

// количество элементов в списке
function TEditorFiles.Count: integer;
begin
  Count:=List.Count;
end;

// имя выбранного элемента
function TEditorFiles.GetNameSelected: string;
begin
  GetNameSelected:='-';
  if LB.ItemIndex=-1 then exit;

  GetNameSelected:=TSourceText(LB.Items.Objects[LB.ItemIndex]).FileName;
end;

// добавить текст
function TEditorFiles.New: TSourceText;
var
  ST:TSourceText;
begin
  ST:=TSourceText.Create;
  List.Add(ST); // добавим файл в общий список
  New:=ST;
end;

// открыть файл
function TEditorFiles.Open(filename: string): TSourceText;
var
  i:integer;
  ST:TSourceText;
begin

  for i:=0 to List.Count-1 do
   if UTF8UpperCase(TSourceText(List.Items[i]).FileName)=UTF8UpperCase(filename) then
      begin
        Result:=TSourceText(List.Items[i]);
        exit;
      end;

  ST:=TSourceText.Create;
  ST.OpenFile(filename);
  List.Add(ST);
  Result:=ST;
end;

// получить объект по номеру
function TEditorFiles.Get(num: integer): TSourceText;
begin
  Get:=TSourceText(List.Items[num]);
end;

// получить по имени файла
function TEditorFiles.Get(filename: string): TSourceText;
var
  i:integer;

begin
  for i:=0 to List.Count-1 do
  begin
   if UTF8UpperCase(TSourceText(List.Items[i]).FileName)=UTF8UpperCase(filename) then
      begin
        Get:=TSourceText(List.Items[i]);
        exit;
      end;
  end;
  Get:=nil;
end;

// закрытие файла
function TEditorFiles.Close(ST: TSourceText; closeFlag: boolean): TSourceText;
var
  i:integer;
begin

  // удалим файл из общего списка файлов
  for i:=0 to List.Count-1 do
    if TSourceText(List.Items[i])=ST then
      begin
        List.Delete(i);
        break;
      end;

    // удалим файл из списка открытых
  for i:=0 to LB.Count-1 do
    if TSourceText(LB.Items.Objects[i])=ST then
        begin
          LB.Items.Delete(i);
          break;
        end;

  if closeFlag then ST.CloseFile; // закроем файл
  ST.Free;

  Close:=nil;

  if LB.Count>0 then
    begin
      LB.ItemIndex:=0;
      Close:=TSourceText(LB.items.Objects[0]);
    end
end;

// открыть файл в редакторе по номеру в списке
procedure TEditorFiles.OpenInEditor(num: integer);
var
  ST:TSourceText;
begin
  ST:=TSourceText(List.Items[num]);
  OpenInEditor(ST);
end;

// открыть файл в редакторе
procedure TEditorFiles.OpenInEditor(filename:string);
begin
  OpenInEditor(Open(filename));
end;

// открыть файл в редакторе
procedure TEditorFiles.OpenInEditor(ST: TSourceText);
var
  i:integer;
begin
  Editor.SetSourceText(ST); // откроем файл в редакторе

  MainForm.SetMenuMode(ST); // режим меню для файла
  MainForm.StatusEditor;    // статус редактора

  // найдем файл в списке открытых
  for i:=0 to LB.Count-1 do
    if TSourceText(LB.Items.Objects[i])=ST then
      begin
        LB.ItemIndex:=i;
        exit;
      end;

  // если среди открытых нет - то добавим его
  LB.AddItem(UTF8LowerCase(ExtractFileName(ST.FileName)), ST);

  LB.ItemIndex:=LB.Count-1;
end;

procedure TEditorFiles.UpdateSTSymbolInfo;
var
  i:integer;
  ST:TSourceText;
  TextParser:TTextParser;
begin
  for i:=0 to List.Count-1 do
    begin
      ST:=TSourceText(List.Items[i]);
      TextParser:=TTextParser(ST.TextParser);
      if (TextParser is TAsmTextParser) then TAsmTextParser(TextParser).ParseFileSymbols;
    end;
end;

// повторное чтение асм файлов после изменения ld файла
procedure TEditorFiles.ReloadLDFile;
var
  i:integer;
  ST:TSourceText;
begin
  for i:=0 to List.Count-1 do
    begin
      ST:=TSourceText(List.Items[i]);
      if (ST.TextParser is TAsmTextParser) then
        TAsmTextParser(ST.TextParser).SectionReload;
    end;
end;

// убрать из списка открытых файлов файлы результата компиляции
procedure TEditorFiles.ClearOutCompileFiles;
var
  i:integer;
  ST:TSourceText;
begin
  // просмотрим список загруженных файлов и закроем файлы из выходного каталога
  i:=0;
  while i<List.Count do
    begin
      ST:=TSourceText(List.Items[i]);
      if UTF8Pos(Project.Out_Path, ST.FileName,1)=1 then Close(ST, false)
                                                    else i:=i+1;
    end;
  // откроем файл из списка открытых в редакторе, а если такого нет - то скроем редактирование
  if LB.Count>0 then
    begin
      LB.ItemIndex:=0;
      ST:=TSourceText(LB.Items.Objects[0])
    end else ST:=nil;
  Editor.SetSourceText(ST);
end;

// обновить список открытых файлов
procedure TEditorFiles.Update;
var
  i, k:integer;
  str:string;
  ST:TSourceText;
begin
  for k:=0 to List.Count-1 do
    if TSourceText(List.Items[k]).OpenInEditor then
      for i:=0 to LB.Count-1 do
        if TSourceText(List.Items[k])=TSourceText(LB.Items.Objects[i]) then
          begin
            ST:=TSourceText(LB.Items.Objects[i]);
            str:=UTF8LowerCase(ExtractFileName(ST.FileName));
            // проверка на изменение имени файла
            if (UTF8Pos(str, LB.Items.Strings[i], 1)=0) then LB.Items.Strings[i]:=str;
            // отображение наличия несохраненных изменений
            if (ST.TextChange=true) and
                 (UTF8Pos(' [*]', LB.Items.Strings[i], 1)=0) then LB.Items.Strings[i]:=str+' [*]'
            else
            // отображение отсутствия несохраненных изменений
            if (ST.TextChange=false) and
                 (UTF8Pos(' [*]', LB.Items.Strings[i], 1)>0) then LB.Items.Strings[i]:=str;
            break;
          end;
end;

end.

