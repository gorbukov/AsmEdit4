unit ScriptExecUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, LazUTF8, FileUtil, LazFileUtils, IniFiles, ShellApi,
  SourceTextUnit,
  ProjectUnit,
  EditorFilesUnit;


// исполнение скрипта из файла
function ScriptExecute(script_file:string; script_name:string; messShow:boolean):boolean;

implementation

uses MainUnit;

// проверка наличия файла
function Oper_File_Present(ainis: TIniFile; astep: String; {%H-}messShow: boolean):boolean;
var
  fname:string;
  acc:boolean;
  warn:string;
begin
  Oper_File_Present:=false;

  fname:=ainis.ReadString(astep, 'file', '');
  if fname='' then exit; // если файл не задан выходим из скрипта

  acc:=ainis.ReadBool(astep, 'accept', false);
  fname:=Project.SourcePath +'\'+ fname;
  if acc<>FileExistsUTF8(fname) then
     begin // ожидаемый результат не совпал
       warn:=ainis.ReadString(astep, 'warning', '');
       if warn='' then exit;
       if MessageDlg('Внимание!',
                     warn+' Перезаписать?',
                       mtWarning, [mbCancel, mbOk],
                     '')=mrOk then
                        Oper_File_Present:=true;
     end
  else
  Oper_File_Present:=true;
end;

// копирование файла
function Oper_File_Copy(ainis: TIniFile; astep: String; {%H-}messShow: boolean): boolean;
var
  f1name:string;
  f2name:string;
  ST:TSourceText;
begin
  Oper_File_Copy:=true;

  f1name:=ainis.ReadString(astep, 'file1', '');
  f2name:=Project.SourcePath+'\'+ainis.ReadString(astep, 'file2', '');

  if FileExistsUTF8(app_path+f1name) then
     begin
       CopyFile(app_path+f1name, f2name);
       ST:=TSourceText(EditorFiles.Get(f2name));
       if ST<>nil then EditorFiles.Close(ST, false);
       EditorFiles.OpenInEditor(f2name);
     end
  else
    begin
      Oper_File_Copy:=false;
      showmessage('Ошибка ! Файл не найден: '+app_path+' '+f1name);
    end;
end;

// копирование файла c запросом у пользователя имени сохраняемого файла
function Oper_File_CopyAs(ainis: TIniFile; astep: String; {%H-}messShow: boolean): boolean;
var
  f1name:string;
  f2name:string;
  ST:TSourceText;
begin
  Result:=false;

  f1name:=app_path+ainis.ReadString(astep, 'file1', '');

  MainForm.SaveDialog1.FileName:=ExtractFileName(f1name);
  MainForm.SaveDialog1.InitialDir:=Project.SourcePath+'\';
  MainForm.SaveDialog1.Title:='Укажите расположение и имя нового файла настроек';
  if not MainForm.SaveDialog1.Execute then exit;

  f2name:=MainForm.SaveDialog1.FileName; //Project.SourcePath+'\'+ainis.ReadString(astep, 'file2', '');

  if FileExistsUTF8(f1name) then
     begin
       CopyFile(f1name, f2name);
       ST:=TSourceText(EditorFiles.Get(f2name));
       if ST<>nil then EditorFiles.Close(ST, false);
       EditorFiles.OpenInEditor(f2name);
       Result:=true;
     end
end;

// копирование файла
function Oper_Dir_Copy(ainis: TIniFile; astep: String): boolean;
var
  f1name:string;
  f2name:string;
  fos: TSHFileOpStruct;
begin
  Result:=true;

  f1name:=app_path+ainis.ReadString(astep, 'file1', '');
  f2name:=Project.SourcePath+'\'+ainis.ReadString(astep, 'file2', '');

   with fos do begin
     wFunc := FO_COPY;
     fFlags := FOF_ALLOWUNDO;
     pFrom := PChar(f1name + #0);
     pTo := PChar(f2name)
   end;
   Result := (0 = ShFileOperation(fos));

end;

// регистрация модуля в проекте
function Oper_Mod_Write(ainis: TIniFile): boolean;
begin
  Project.AddModule(ainis.FileName);

  Oper_Mod_Write:=true;
end;

// инсталляция модуля
function Oper_Mod_Install(ainis: TIniFile; astep: String; {%H-}messShow: boolean): boolean;
var
  f1name:string;
  script:string;
  mess:boolean;
begin
  Oper_Mod_Install:=false;

  f1name:=app_path+ainis.ReadString(astep, 'file', '');
  script:=ainis.ReadString(astep, 'script', '');
  if ainis.ReadString(astep, 'mess', 'Y')<>'true' then mess:=false else mess:=true;

  if FileExistsUTF8(f1name) then
     Oper_Mod_Install:=ScriptExecute(f1name, script, mess);
end;

// создание директории
function Oper_Dir_Make(ainis: TIniFile; astep: String; {%H-}messShow: boolean): boolean;
var
  f1name:string;
begin
  f1name:=Project.SourcePath+'\'+ainis.ReadString(astep, 'file', '');
  Oper_Dir_Make:=ForceDirectoriesUTF8(f1name);
end;

function ScriptExecute(script_file: string; script_name: string;
  messShow: boolean): boolean;
var
  inis:TIniFile;
  i:integer;
  step, oper:string;
  res:boolean;
begin
  inis:=TIniFile.Create(script_file);
  res:=true;
  // перебор комманд скрипта
  i:=0;
  step:=inis.ReadString(script_name, 'step'+inttostr(i), ''); // отладка
  while inis.ReadString(script_name, 'step'+inttostr(i), '')<>'' do
    begin
      step:=inis.ReadString(script_name, 'step'+inttostr(i), ''); // шаг скрипта

      oper:=UTF8UpperCase(inis.ReadString(step, 'oper', '')); // команда
      case oper of
        'DIR_MAKE'    :  res:=Oper_Dir_Make(inis, step, messShow);    // создание директории
        'FILE_PRESENT':  if messShow then res:=Oper_File_Present(inis, step, messShow) // проверка наличия файла
                           else res:=true;
        'FILE_COPY':     res:=Oper_File_Copy(inis, step, messShow);    // копирование файла
        'FILE_COPY_ASK': res:=Oper_File_CopyAs(inis, step, messShow);  // копирование файла c запросом имени и пути
        'DIR_COPY'     : res:=Oper_Dir_Copy(inis, step);               // копирование директории
        'MOD_WRITE':     res:=Oper_Mod_Write(inis);                    // регистрация модуля в проекте
        'MOD_INSTALL':   res:=Oper_Mod_Install(inis, step, messShow);  // установка другого модуля
        else res:=false;
      end;

      if not res then
         begin
           i:=99999; // останавливаем исполнение скрипта
           showmessage('Ошибка ! шаг: '+step+' операция: '+oper);
         end;
      i:=i+1;
    end;

  ScriptExecute:=res;

  inis.Free;
end;

end.

