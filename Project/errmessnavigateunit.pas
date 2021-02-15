unit ErrMessNavigateUnit;

// модуль обработки ошибок компиляции или сборки из окна сообщений
//

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8,
  AsmTextParserUnit;

type
  // тип сообщения
  TMtype=(mtGNU_As, mtGNU_ld);

  // сообщение

  { TMessType }

  TMessType=class(TObject)
    MType:TMtype;
    filename:string;
    constructor Create(mt:TMType; fn:string);
  end;

// разбор ошибок и навигация по файлам
procedure ErrMessGNUNavigate(mt:TMessType; mess:string);

implementation

uses MainUnit, ProjectUnit, EditorFilesUnit, SourceTextUnit;

procedure selectLine(ST:TSourceText; line:integer);
begin
  EditorFiles.OpenInEditor(ST);

  // установим курсор
  ST.CursorX:=0; ST.CursorY:=line;
  ST.FirstCharVisible:=1;
  ST.FirstLineVisible:=line-5;
  if ST.FirstLineVisible<0 then ST.FirstLineVisible:=0;

  // выделим строку
  ST.TextSelect:=true;
  ST.TextSelectSY:=line; ST.TextSelectLY:=line;
  ST.TextSelectSX:=0;    ST.TextSelectLX:=UTF8Length(ST.GetLineStr(line));

end;

// ошибка компилятора
procedure ErrMessGNUAsNavigate(mess: string);
var
  fname:string;
  line:integer;
  strpos, strpos2:integer;
  ST:TSourceText;
begin
  strpos:=UTF8Pos(':', mess, 3);

  if UTF8Copy(mess, 1, 1)='.' then
    begin
      // инклудный файл
      fname:=StringReplace(Project.Project_Path+UTF8Copy(mess, 3, strpos-3),
                           '/', '\', [rfReplaceAll]);
      fname:=StringReplace(fname,
                           '\\', '\', [rfReplaceAll]);
    end
  else fname:=UTF8Copy(mess, 1, strpos-1);
  fname:=UTF8LowerCase(fname);

  // найдем номер строки
  strpos2:=UTF8Pos(':', mess, strpos+1);
  line:=strtoint(UTF8Copy(mess, strpos+1, strpos2-strpos-1))-1;

  // откроем файл в котором находится ошибочный текст
  ST:=EditorFiles.Open(fname);

  selectLine(ST, line);  // выделим строку с ошибкой

end;

// ошибка сборщика
procedure ErrMessGNULdNavigate(mess: string);
var
  fname, tokstr:string;
  pos, i, line:integer;
  ST:TSourceText;
  TextParser:TAsmTextParser;
  symbfilelist:TStringList;
begin
   pos:=UTF8Pos('.o:', mess, 1);  // ищем где начинается расширение
   fname:=UTF8Copy(mess, 1, pos-1)+'.asm'; // имя файла при обработке которого возникла ошибка
   fname:=Project.SourcePath+UTF8Copy(fname, UTF8Length(Project.Out_Path+'\internal\'), UTF8Length(fname)-UTF8Length(Project.Out_Path+'\internal\')+1);

   // ищем имя символа
   i:=UTF8Pos('undefined reference to', mess, pos);
   if i=0 then exit;

   tokstr:=UTF8Copy(mess,
                    i+UTF8Length('undefined reference to')+2,
                    UTF8Length(mess)-(i+UTF8Length('undefined reference to')+2)); // искомый токен

   // файл в котором нашли ошибку
   ST:=EditorFiles.Open(fname);
   // получим список файлов с инклудами
   TextParser:=TAsmTextParser(ST.TextParser);
   symbfilelist:=TStringList(TextParser.IncludeFileList);
   i:=symbfilelist.Count;

   // ищем токен во всех файлах
   for i:=0 to symbfilelist.Count-1 do
     begin
       // откроем файл (в том числе инклудный)
       ST:=EditorFiles.Open(symbfilelist.Strings[i]);
       pos:=ST.Count;
       if ST.GetTokenInText(tokstr, line) then
         begin
           selectLine(ST, line);
           exit;
         end;
     end;


end;

// разбор ошибок и навигация по файлам
procedure ErrMessGNUNavigate(mt: TMessType; mess: string);
begin
   // отображение выбранной ошибки
   case mt.MType of
     mtGNU_As: ErrMessGNUAsNavigate(mess);
     mtGNU_ld: ErrMessGNULdNavigate(mess);
   end;
end;

{ TMessType }

constructor TMessType.Create(mt: TMType; fn: string);
begin
  Mtype:=mt;
  filename:=fn;
end;

end.

