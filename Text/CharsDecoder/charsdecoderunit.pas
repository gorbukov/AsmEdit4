unit CharsDecoderUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, LazUTF8, LConvEncoding, LazFileUtils;

const
  const_charSetList:array[0..21] of string=
  ('ISO8859-1',  'ISO8859-15',   'ISO8859-2',   'CP1250',    'CP1251',
   'CP1252',     'CP1253',       'CP1254',      'CP1255',    'CP1256',
   'CP1257',     'CP1258',       'CP437',       'CP850',     'CP852',
   'CP866',      'CP874',        'KOI8',        'MACINTOSH', 'UCS2L',
   'UCS2B',      'UTF8');

// открытие файла
// filename:string; имя файла
// defCharSet:string кодировка по умолчанию (если не будет обнаружена в файле)
// на выходе defCharSet содержит кодировку открытия или ERROR если пользователь
// отказался от открытия файла
function CDU_OpenFile(filename:string; var defCharSet:string):string;

// сохранение файла
procedure CDU_SaveFile(filename:string; var defCharSet:string; text:string);

// поиск на указание кодировки в тексте файла
function getTextCharSet(str: string): string;
// utf8 в выбранную кодировку
function UTF8ToCharSet(str:String; var charSet:string):String;
// из кодировки в utf8
function CharSetToUTF8(str:String; var charSet:string):String;

implementation

function UTF8ToCharSet(str:String; var charSet:string):String;
begin
   charSet:=UpperCase(charSet);
   case charSet of
   'ISO8859-1':  str:=UTF8ToISO_8859_1(str);
   'ISO8859-15': str:=UTF8ToISO_8859_15(str);
   'ISO8859-2':  str:=UTF8ToISO_8859_2(str);
   'CP1250':     str:=UTF8ToCP1250(str);
   'CP1251':     str:=UTF8ToCP1251(str);
   'CP1252':     str:=UTF8ToCP1252(str);
   'CP1253':     str:=UTF8ToCP1253(str);
   'CP1254':     str:=UTF8ToCP1254(str);
   'CP1255':     str:=UTF8ToCP1255(str);
   'CP1256':     str:=UTF8ToCP1256(str);
   'CP1257':     str:=UTF8ToCP1257(str);
   'CP1258':     str:=UTF8ToCP1258(str);
   'CP437':      str:=UTF8ToCP437(str);
   'CP850':      str:=UTF8ToCP850(str);
   'CP852':      str:=UTF8ToCP852(str);
   'CP866':      str:=UTF8ToCP866(str);
   'CP874':      str:=UTF8ToCP874(str);
   'KOI8':       str:=UTF8ToKOI8(str);
   'MACINTOSH':  str:=UTF8ToMacintosh(str);
   'UCS2L':      str:=UTF8ToUCS2LE(str);
   'UCS2B':      str:=UTF8ToUCS2BE(str);
        else     charSet:='UTF8';
   end;
   Result:=str;
end;

function CharSetToUTF8(str:String; var charSet:string):String;
begin
   charSet:=UpperCase(charSet);

   case charSet of
   'ISO8859-1':  str:=ISO_8859_1ToUTF8(str);
   'ISO8859-15': str:=ISO_8859_15ToUTF8(str);
   'ISO8859-2':  str:=ISO_8859_2ToUTF8(str);
   'CP1250':     str:=CP1250ToUTF8(str);
   'CP1251':     str:=CP1251ToUTF8(str);
   'CP1252':     str:=CP1252ToUTF8(str);
   'CP1253':     str:=CP1253ToUTF8(str);
   'CP1254':     str:=CP1254ToUTF8(str);
   'CP1255':     str:=CP1255ToUTF8(str);
   'CP1256':     str:=CP1256ToUTF8(str);
   'CP1257':     str:=CP1257ToUTF8(str);
   'CP1258':     str:=CP1258ToUTF8(str);
   'CP437':      str:=CP437ToUTF8(str);
   'CP850':      str:=CP850ToUTF8(str);
   'CP852':      str:=CP852ToUTF8(str);
   'CP866':      str:=CP866ToUTF8(str);
   'CP874':      str:=CP874ToUTF8(str);
   'KOI8':       str:=KOI8ToUTF8(str);
   'MACINTOSH':  str:=MacintoshToUTF8(str);
   'UCS2L':      str:=UCS2LEToUTF8(str);
   'UCS2B':      str:=UCS2BEToUTF8(str);
   else          charSet:='UTF8';
   end;
   Result:=str;
end;

// поиск на указание кодировки в тексте файла
function getTextCharSet(str: string): string;
var
  i:integer;
  s,t:String;
begin
   s:='';
   str:=UpperCase(str);
   // прочитаем название кодировки
   i:=UTF8Pos('@.CHARSET', str, 1);
   if i>0 then // если кодировка определена
      begin
         i:=i+9;
         while (UTF8Copy(str, i, 1)=' ') or (UTF8Copy(str, i, 1)=#09) do i:=i+1;
         if UTF8Copy(str, i, 1)='=' then i:=i+1;

         while (UTF8Length(str)>i) do
            begin
               t:=UTF8Copy(str, i, 1);
               if (t[1]=#$09) or (t[1]=#$0d) or (t[1]=#$0a) or (t[1]=' ') then break;

               s:=s+t;
               i:=i+1;
            end;
      end;
   Result:=s;
end;

// открытие файла
function CDU_OpenFile(filename: string; var defCharSet: string): string;
var
  txt:TStringList;
  chset:string;
begin
  if not FileExistsUTF8(filename) then
     begin
        defCharSet:='ERROR';
        exit;
     end;
  // загрузим файл
  txt:=TStringList.Create;
  txt.LoadFromFile(filename);
  // определим кодировку
  chset:=getTextCharSet(txt.Text);
  if chset<>'' then defCharSet:=chset; // если кодировку нашли сохраняем

  // перекодируем текст из кодировки в utf8
  txt.Text:=CharSetToUTF8(txt.Text, defCharSet);

  Result:=txt.Text;
  txt.Free;
end;

// сохранение файла
procedure CDU_SaveFile(filename: string; var defCharSet: string; text: string);
var
  txt:TStringList;
  chset:string;
begin
  chset:=getTextCharSet(text);
  if chset<>'' then defCharSet:=chset; // если кодировку нашли сохраняем

  // перекодируем в нужную кодировку из utf8
  text:=UTF8ToCharSet(text, defCharSet);

  txt:=TStringList.Create;
  txt.Text:=text;
  txt.SaveToFile(filename);
  txt.Free;
end;

end.
