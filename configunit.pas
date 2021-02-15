unit ConfigUnit;

//
// Класс инициализации приложения
//

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IniFiles,
  FormValueInitUnit;

type

  { TConfig }

  TConfig=class(TObject)
    private

    public
      Default_CharSet:string;   // кодировка по умолчанию
      Default_AsmDecode:string; // декодирование инструкций по умолчанию

      ProjectPanelShow:boolean;
      SymbolPanelShow:boolean;

      constructor Create;
      destructor  Free;

      procedure  OpenOldSessionFiles; // открытие файлов прошлой сессии
      procedure  SaveSessionFiles;    // сохранение открытых файлов сессии
  end;

implementation

uses MainUnit, SourceTextUnit, EditorFilesUnit;
{ TConfig }

constructor TConfig.Create;
var
  inif:TIniFile;
begin
   inif:=TIniFile.Create(app_conf_name);

   Default_CharSet:=inif.ReadString ('APPLICATION', 'Default_CharSet',    'CP1251');
   Default_AsmDecode:=inif.ReadString('APPLICATION', 'Default_AsmDecode',  'cortex-m4');
   ProjectPanelShow:=inif.ReadBool   ('APPLICATION', 'ProjectPanelShow',   false);
   SymbolPanelShow:=inif.ReadBool    ('APPLICATION', 'SymbolPanelShow',    false);

   MainForm.CenterTopPanel.Visible:=inif.ReadBool('APPLICATION', 'FxPanelShow',    false);
   MainForm.Menu_View_FxShow.Checked:=MainForm.CenterTopPanel.Visible;

   MainForm.Menu_Edit_AutoFormat.Checked:=inif.ReadBool    ('APPLICATION', 'Autoformat',    false);
   inif.Free;

end;

destructor TConfig.Free;
var
  inif:TIniFile;
begin
   inif:=TIniFile.Create(app_conf_name);

   inif.WriteString('APPLICATION',   'Default_CharSet',    Default_CharSet);
   inif.WriteString('APPLICATION',   'Default_AsmDecode',  Default_AsmDecode);
   inif.WriteBool  ('APPLICATION',   'ProjectPanelShow',   ProjectPanelShow);
   inif.WriteBool  ('APPLICATION',   'SymbolPanelShow',    SymbolPanelShow);
   inif.WriteBool  ('APPLICATION',   'FxPanelShow',        MainForm.CenterTopPanel.Visible);
   inif.WriteBool  ('APPLICATION',   'Autoformat',         MainForm.Menu_Edit_AutoFormat.Checked);
   inif.UpdateFile;
   inif.Free;
end;

// открытие файлов прошлой сессии
procedure TConfig.OpenOldSessionFiles;
var
  i:integer;
  cnt:integer;
  inif:TIniFile;

  ST:TSourceText;
  text_ch:boolean; // флаг изменения файла
  text_nm:string;  // имя файла
  text_chs:string;
  tmp:string;
begin
   inif:=TIniFile.Create(app_conf_name);

   cnt:=inif.ReadInteger('OLDSESSIONFILES', 'Count', 0);

   if cnt=0 then exit;

   for i:=0 to cnt-1 do
     begin

       text_nm:=   inif.ReadString('OLDSESSIONFILES', 'file_'+inttostr(i)+'_nm',  '');
       text_ch:=     inif.ReadBool('OLDSESSIONFILES', 'file_'+inttostr(i)+'_ch',  false);
       text_chs:=inif.ReadString('OLDSESSIONFILES', 'file_'+inttostr(i)+'_chs', Default_CharSet);
       tmp:=Default_CharSet;
       Default_CharSet:=text_chs;

       ST:=EditorFiles.Open(text_nm); // откроем файл (это обязательно даже при чтении из кеша!!)
       if text_ch then // файл содержал несохраненные изменения, читаем из кеша
         begin
           ST.OpenFile(app_path+'tmp\'+inttostr(i)); // откроем из кеша
           ST.FileName:=text_nm;                     // реальное имя файла
           ST.TextChange:=text_ch;                   // восстановим флаг изменений
           ST.FileNamed:=inif.ReadBool('OLDSESSIONFILES', 'file_'+inttostr(i)+'_nd',  false);
         end;
       Default_CharSet:=tmp;
       EditorFiles.OpenInEditor(ST);
     end;

   EditorFiles.Update;

   text_nm:=inif.ReadString('OLDSESSIONFILES', 'OpenInEditor', '-');
   if EditorFiles.get(text_nm)<>nil then EditorFiles.OpenInEditor(text_nm);

   inif.Free;
end;

// сохранение открытых файлов сессии
procedure TConfig.SaveSessionFiles;
var
  cnt, i:integer;
  inif:TIniFile;
  ST:TSourceText;
begin
  inif:=TIniFile.Create(app_conf_name);

  inif.EraseSection('OLDSESSIONFILES');

  i:=0;
  for cnt:=0 to EditorFiles.Count-1 do
    begin

      ST:=EditorFiles.Get(cnt);
      if (ST.OpenInEditor) and
                ((ST.TextChange and (not ST.FileNamed)) or ST.FileNamed) then
        begin
          inif.WriteString('OLDSESSIONFILES', 'file_'+inttostr(i)+'_nm',  ST.FileName);  // имя файла
          inif.WriteString('OLDSESSIONFILES', 'file_'+inttostr(i)+'_chs', ST.CharSet);   // кодировка
          inif.WriteBool  ('OLDSESSIONFILES', 'file_'+inttostr(i)+'_ch',  ST.TextChange);// флаг изменений
          inif.WriteBool  ('OLDSESSIONFILES', 'file_'+inttostr(i)+'_nd',  ST.FileNamed); // флаг новизны

          if ST.TextChange then
            begin
              ST.FileName:=app_path+'tmp\'+inttostr(i);
              ST.FileNamed:=true;
              ST.SaveFile;
            end;
          i:=i+1;
        end;
    end;
  inif.WriteInteger('OLDSESSIONFILES', 'Count',    i);
  inif.WriteString('OLDSESSIONFILES', 'OpenInEditor', EditorFiles.GetNameSelected);

  inif.UpdateFile;
  inif.Free;
end;

end.

