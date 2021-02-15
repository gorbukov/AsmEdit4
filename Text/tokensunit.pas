unit TokensUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8;

type
 // базовый тип токена при распознании строки

  TTokenType=(ttNone,   // первоначальное значение
              ttErr,    // ошибка распознания токена (нет второй кавычки)
              ttSpace,  // пробелы и табы
              ttDelim,  // разделитель            [ , = ; _ \ ` # № ? ]
              ttLabDelim, // разделитель меток    [ : ]
              ttRem,    // строчный комментарий   [ @ ]
              ttLogic,  // лог. и арифм. операции [ ! << >> | || & && - + ~ * / % ^ ]
              ttIf,     // операции сравнения     [ == != > < <> >= <=]
              ttGroup,  // токены группы          [ ( ) [ ] { } ]
              ttString, // строки заключенные в кавычки   [ '' "" ]
              ttChars,  // токен состоящий из букв и цифр
              ttOneChar, // токен состоящий из одного символа в одинарных кавычках
              ttEdDir); // директива редактора    [ @. ]

 // тип токена после синтаксического анализа текста

  TTokenStyle=( tsNone,     // токен не обработан
                tsErr,      // ошибка распознания
                tsParamErr, // в параметрах ошибка
                tsRem,      // примечание
                tsAsmDir,   // директива ассемблера
                tsEdDir,    // директива редактора
                tsParam,    // параметры директив редактора или ассемблера
                tsAsmCom,   // команда ассемблера
                tsDelim,    // разделитель
                tsLabSymb,  // символ\метка
                tsReg,      // регистр
                tsNum,      // число
                tsString);  // строка


  { TToken }

  TToken=class(TObject)
    private
      textToken:string;
      procedure setTokenText(AValue: string);

    public
      tokType:TTokenType;
      tokStyle:TTokenStyle;
      startPos:longint;
      tokLen:longint;

      property Text:string read textToken write setTokenText;

      Constructor Create(txt:string; pos:longint; typ:TTokenType);
      destructor  Free;

      function isNumber:boolean;
      function isHEX:boolean;
      function isSize:boolean;
      function isSymbol:boolean;
      function isRegister:boolean;
  end;

  { TTokenList }

  TTokenList=class(TObject)
    private
      List:TList;

      function  getCount: integer;

      function GetLineToken      (lineStr:string; lineLen:longint; var start:longint; var tokenType:TTokenType):string;
      function GetSpaceToken     (lineStr:string; lineLen:longint; var start:longint; var tokenType:TTokenType):string;
      function GetRemToken       (lineStr:string; lineLen:longint; var start:longint; var tokenType:TTokenType):string;
      function GetQuotedToken    (lineStr:string; lineLen:longint; var start:longint; var tokenType:TTokenType):string;
      function GetEqualsToken    (lineStr:string; lineLen:longint; var start:longint; var tokenType:TTokenType):string;
      function GetLeftArrowToken (lineStr:string; lineLen:longint; var start:longint; var tokenType:TTokenType):string;
      function GetRightArrowToken(lineStr:string; lineLen:longint; var start:longint; var tokenType:TTokenType):string;
      function GetOrToken        (lineStr:string; lineLen:longint; var start:longint; var tokenType:TTokenType):string;
      function GetAndToken       (lineStr:string; lineLen:longint; var start:longint; var tokenType:TTokenType):string;
      function GetNotToken       (lineStr:string; lineLen:longint; var start:longint; var tokenType:TTokenType):string;
      function GetOneCharToken   (lineStr:string;                  var start:longint; var tokenType:TTokenType):string;
      function GetSimpleToken    (lineStr:string; lineLen:longint; var start:longint; var tokenType:TTokenType):string;
    public
      property Count:integer read getCount;  // количество токенов в списке

      Constructor Create;
      destructor  Free;

      // процедуры работы со списком
      procedure Clear;
      procedure Add(Token:TToken);
      procedure Insert(pos:integer; Token:TToken);
      procedure Delete(pos:integer);

      function  GetToken(pos:integer):TToken;
      function  GetToken(var pos: integer; tokname: string): TToken;

      procedure SplitTokens(posStart, posEnd: integer);

      procedure ParseLineStr(text: string);  // разбор строки на токены

      // проверка есть ли токен в строке и его получение

  end;

implementation

{ TTokenList }

// количество токенов в списке
function TTokenList.getCount: integer;
begin
  Result:=List.Count;
end;

// парсинг строки символов на токены
procedure TTokenList.ParseLineStr(text: string);
var
   tokStr:string;
   start, pos:longint;
   len:longint;
   tokenType:TTokenType;
   Token:TToken;
begin
   Clear; // очистим список
   start:=1;
   len:=UTF8Length(text);
   while start<=len do
      begin
         pos:=start; tokenType:=ttNone;
         tokStr:=GetLineToken (text, len, start, tokenType);
         if (tokenType<>ttNone) and (tokenType<>ttSpace) then
            begin
               // задание стилей токенов
               Token:=TToken.Create(tokStr, pos, tokenType);
               List.Add(Token);
            end;
      end;
end;

// проверка есть ли токен в строке и получение его номера
function TTokenList.GetToken(var pos:integer; tokname: string): TToken;
var
   i:integer;
//   str:string;
begin
   for i:=pos to List.Count-1 do
     begin
//       str:=TToken(List.Items[i]).Text;
     if tokname=TToken(List.Items[i]).Text then
        begin
           pos:=i+1;
           GetToken:=TToken(List.Items[i]);
           exit;
        end;

     end;
   pos:=-1;
   GetToken:=nil;
end;

// получить токен из позиции в строке
function TTokenList.GetLineToken(lineStr: string; lineLen: longint;
  var start: longint; var tokenType: TTokenType): string;
begin
  GetLineToken:='';
  tokenType:=ttNone;

  case UTF8Copy(lineStr, start, 1) of
 ' ', #09: GetLineToken:=GetSpaceToken     (lineStr, lineLen, start, tokenType);  // токен "Пробел"
      '@': GetLineToken:=GetRemToken       (lineStr, lineLen, start, tokenType);  // токен "Комментарий", включая токен директивы компилятора
'"', '''': GetLineToken:=GetQuotedToken    (lineStr, lineLen, start, tokenType);  // распознание строк
      '=': GetLineToken:=GetEqualsToken    (lineStr, lineLen, start, tokenType);  // распознание знака '=' либо '=='
      '<': GetLineToken:=GetLeftArrowToken (lineStr, lineLen, start, tokenType);  // '<', '<<', '<=', '<>'
      '>': GetLineToken:=GetRightArrowToken(lineStr, lineLen, start, tokenType);  // '>', '>>', '>='
      '|': GetLineToken:=GetOrToken        (lineStr, lineLen, start, tokenType);  // '|', '||'
      '&': GetLineToken:=GetAndToken       (lineStr, lineLen, start, tokenType);  // '&', '&&'
      '!': GetLineToken:=GetNotToken       (lineStr, lineLen, start, tokenType);  // '!', '!='
'-', '+', '~', '*', '/', '\', '%', '^', ':', ';',
',', '[', ']', '{', '}', '(', ')': GetLineToken:=GetOneCharToken(lineStr, start, tokenType);
          else GetLineToken:=GetSimpleToken(lineStr, lineLen, start, tokenType);
   end;
end;

// получить токен "Пробел"
function TTokenList.GetSpaceToken(lineStr: string; lineLen: longint;
  var start: longint; var tokenType: TTokenType): string;
var
   ch:string;
begin
   tokenType:=ttSpace;
   ch:=' ';
   GetSpaceToken:='';
   // собираем все пробелы
   repeat
      GetSpaceToken:=GetSpaceToken+ch;
      start:=start+1;
      ch:=UTF8Copy(lineStr, start, 1);
   until (start>lineLen) or ((ch<>' ') and (ch<>#09));
end;

// получить токен "Комментарий"
function TTokenList.GetRemToken(lineStr: string; lineLen: longint;
  var start: longint; var tokenType: TTokenType): string;
const
   breakChar=#09+' ~`!@#№$;%^:&?*()-+\/|"''<>,=';
var
   ch:string;
begin
   tokenType:=ttRem;
   GetRemToken:='@';
   start:=start+1;

   if (start>lineLen) then exit; // символ комментария был в конце строки

   if UTF8Copy(lineStr, start, 1)='.' then // директива компилятора
      begin
         tokenType:=ttEdDir;
         GetRemToken:='@.';
         start:=start+1;
         ch:=UTF8Copy(lineStr, start, 1);
         while (start<=lineLen) and (UTF8Pos(ch, breakChar, 1)=0) do
            begin
               GetRemToken:=GetRemToken+ch;
               start:=start+1;
               ch:=UTF8Copy(lineStr, start, 1);
            end;
      end
   else  // комментарий
      begin
         GetRemToken:='@'+UTF8Copy(lineStr, start, lineLen-start+1);
         start:=lineLen+1;
      end;
end;

// токен строка заключенная в кавычки
function TTokenList.GetQuotedToken(lineStr: string; lineLen: longint;
  var start: longint; var tokenType: TTokenType): string;
var
   ch:string;
   i:longint;
begin
   ch:=UTF8Copy(lineStr, start, 1);
   GetQuotedToken:=ch;
   i:=0;
   if start<lineLen then i:=UTF8Pos(ch, lineStr, start+1);
   if i=0 then
      begin
         GetQuotedToken:=UTF8Copy(lineStr, start, lineLen-start+1);
         start:=lineLen+1;
         tokenType:=ttErr;
      end
   else
      begin
         GetQuotedToken:=UTF8Copy(lineStr, start, i-start+1);
         if (ch='''') then
            begin
              if (start+2=i) then tokenType:=ttOneChar
                             else tokenType:=ttErr;
            end
         else tokenType:=ttString;
         start:=i+1;
      end;
end;

// токен  '='
function TTokenList.GetEqualsToken(lineStr: string; lineLen: longint;
  var start: longint; var tokenType: TTokenType): string;
var
   ch:string;
begin
   tokenType:=ttDelim;
   GetEqualsToken:='=';

   start:=start+1;
   if start>lineLen then exit;

   ch:=UTF8Copy(lineStr, start, 1);
   if ch='=' then
      begin
         GetEqualsToken:='==';
         start:=start+1;
         tokenType:=ttIf;
      end;
end;

// '<' или '<<' или '<=' или '<>'
function TTokenList.GetLeftArrowToken(lineStr: string; lineLen: longint;
  var start: longint; var tokenType: TTokenType): string;
var
   ch:string;
begin
   tokenType:=ttIf;
   GetLeftArrowToken:='<';

   start:=start+1;
   if start>lineLen then exit;

   ch:=UTF8Copy(lineStr, start, 1);
   case ch of
     '<': begin GetLeftArrowToken:='<<'; start:=start+1; tokenType:=ttLogic; end;
     '=': begin GetLeftArrowToken:='<='; start:=start+1; tokenType:=ttIf; end;
     '>': begin GetLeftArrowToken:='<>'; start:=start+1; tokenType:=ttIf; end;
   end;
end;

// '>' или '>>' или '>='
function TTokenList.GetRightArrowToken(lineStr: string; lineLen: longint;
  var start: longint; var tokenType: TTokenType): string;
var
   ch:string;
begin
   tokenType:=ttIf;
   GetRightArrowToken:='>';

   if start>lineLen then exit;
   start:=start+1;

   ch:=UTF8Copy(lineStr, start, 1);
   case ch of
     '>': begin GetRightArrowToken:='>>'; start:=start+1; tokenType:=ttLogic; end;
     '=': begin GetRightArrowToken:='>='; start:=start+1; tokenType:=ttIf; end;
   end;
end;

// '|' или '||'
function TTokenList.GetOrToken(lineStr: string; lineLen: longint;
  var start: longint; var tokenType: TTokenType): string;
begin
   tokenType:=ttLogic;
   GetOrToken:='|';

   if start>lineLen then exit;
   start:=start+1;

   if UTF8Copy(lineStr, start, 1)='|' then
      begin
         GetOrToken:='||';
         start:=start+1;
      end;
end;

// '&' или '&&'
function TTokenList.GetAndToken(lineStr: string; lineLen: longint;
  var start: longint; var tokenType: TTokenType): string;
begin
  tokenType:=ttLogic;
  GetAndToken:='&';

  if start>lineLen then exit;
  start:=start+1;

  if UTF8Copy(lineStr, start, 1)='&' then
     begin
        GetAndToken:='&&';
        start:=start+1;
     end
  else
  if UTF8Copy(lineStr, start, 1)='=' then
     begin
        GetAndToken:='&=';
        start:=start+1;
     end
end;

// '!' или '!='
function TTokenList.GetNotToken(lineStr: string; lineLen: longint;
  var start: longint; var tokenType: TTokenType): string;
begin
  tokenType:=ttLogic;
  GetNotToken:='!';

  start:=start+1;
  if start>=lineLen then exit;

  if UTF8Copy(lineStr, start, 1)='=' then
     begin
        GetNotToken:='!=';
        start:=start+1;
        tokenType:=ttIf;
     end;
end;

// токен из одного символа
function TTokenList.GetOneCharToken(lineStr: string; var start: longint;
  var tokenType: TTokenType): string;
begin
  GetOneCharToken:=UTF8Copy(lineStr, start, 1);

  case GetOneCharToken of
    '-', '+', '~', '*', '/', '%', '^':  tokenType:=ttLogic;
                                  ':':  tokenType:=ttLabDelim;
         '[', ']', '{', '}', '(', ')':  tokenType:=ttGroup;
    else tokenType:=ttDelim;
  end;
  start:=start+1;

  if (
       (GetOneCharToken='*') or
       (GetOneCharToken='-') or
          (GetOneCharToken='+')
     ) and
       (start<UTF8Length(linestr)) and
                (UTF8Copy(lineStr, start, 1)='=') then
     begin
       GetOneCharToken:=GetOneCharToken+'=';
       start:=start+1;
     end

end;

// токен из букв и цифр
function TTokenList.GetSimpleToken(lineStr: string; lineLen: longint;
  var start: longint; var tokenType: TTokenType): string;
const
   // внимание !! [ . _ $ ] - входят в список букв и цифр и не являются разделителями
   breakChar=#09+' ~`!@#№;%^:&?*()[]{}-+\/|"''<>,='; // список разделителей
var
   ch:string;
begin
   GetSimpleToken:='';

   repeat
      ch:=UTF8Copy(lineStr, start, 1);
      GetSimpleToken:=GetSimpleToken+ch;
      start:=start+1;
   until (start>lineLen) or (UTF8Pos(UTF8Copy(lineStr, start, 1), breakChar, 1)>0);

   tokenType:=ttChars;
end;

// конструктор
constructor TTokenList.Create;
begin
   List:=TList.Create;
end;

// деструктор
destructor TTokenList.Free;
begin
   List.Free;
end;

// очистка списка
procedure TTokenList.Clear;
begin
   while List.Count>0 do
      begin
         // TToken(List.Items[0]).Free;   // почему не работает не понимаю !!!!
         Delete(0);
      end;
end;

// добавить токен
procedure TTokenList.Add(Token: TToken);
begin
  List.Add(Token);
end;

// вставить токен в список
procedure TTokenList.Insert(pos: integer; Token: TToken);
begin
  List.Insert(pos, Token);
end;

// удалить токен
procedure TTokenList.Delete(pos: integer);
begin
  TToken(List.Items[pos]).Free;
  List.Delete(pos);
end;

// получить токен из списка
function TTokenList.GetToken(pos: integer): TToken;
begin
  if pos<Count then Result:=TToken(List.Items[pos])
               else Result:=nil;
end;

// объединение нескольких токенов в один
procedure TTokenList.SplitTokens(posStart, posEnd: integer);
var
   str:string;
   i:integer;
begin
  str:='';
  // определим строку нового объединенного токена
   for i:=posStart to posEnd do str:=str+TToken(List.Items[i]).Text;

   // запомним строку
   TToken(List.Items[posStart]).Text:=str;

   // удалим токены которые вошли в объединение
   for i:=posStart+1 to posEnd do Delete(posStart+1);
end;

{ TToken }

procedure TToken.setTokenText(AValue: string);
begin
  if textToken=AValue then Exit;
  textToken:=AValue;
  tokLen:=UTF8Length(textToken);
end;

constructor TToken.Create(txt: string; pos: longint; typ: TTokenType);
begin
  Text:=txt;
  tokType:=typ;
  startPos:=pos;
  tokStyle:=tsNone;
end;

destructor TToken.Free;
begin

end;

function TToken.isNumber: boolean;
const
   binDigits='01';
   octDigits='01234567';
   decDigits='0123456789';
   hexDigits='0123456789ABCDEF';
var
   str:string;
   i, k:integer;
begin
  Result:=false;

  str:=UTF8UpperCase(Text);
  k:=UTF8Pos('.', str);
  if k>0 then
    begin // возможно действительное число - ВАЖНО - процедура скорее всего работает не верно !!
       exit;
    end
  else
  if UTF8Pos('0B', str)=1 then
    begin // бинарное число
      if UTF8Length(str)=2 then exit;
      for i:=3 to UTF8Length(str) do
        if UTF8Pos(UTF8Copy(str, i, 1), binDigits)=0 then exit;
    end
  else
  if UTF8Pos('0X', str)=1 then
    begin // шестнадцатиричное число
      if UTF8Length(str)=2 then exit;
      for i:=3 to UTF8Length(str) do
        if UTF8Pos(UTF8Copy(str, i, 1), hexDigits)=0 then exit;
    end
  else
  if UTF8Pos('0', str)=1 then
    begin // восьмиричное число
      for i:=1 to UTF8Length(str) do
        if UTF8Pos(UTF8Copy(str, i, 1), octDigits)=0 then exit;
    end
  else
    // десятичное число
    for i:=1 to UTF8Length(str) do
      if UTF8Pos(UTF8Copy(str, i, 1), decDigits)=0 then exit;

  tokStyle:=tsNum;
  Result:=true;
end;

function TToken.isHEX: boolean;
const
   hexDigits='0123456789ABCDEF';
var
   str:string;
   i:integer;
begin
  Result:=false;

  str:=UTF8UpperCase(Text);
  for i:=1 to UTF8Length(str) do
    if UTF8Pos(UTF8Copy(str, i, 1), hexDigits)=0 then exit;

  tokStyle:=tsNum;
  Result:=true;
end;

function TToken.isSize: boolean;
const
   decDigits='0123456789';

var
   str:string;
   i:integer;
begin
  Result:=false;

  str:=UTF8UpperCase(Text);
  // десятичное число
  for i:=1 to UTF8Length(str) do
    if (UTF8Pos(UTF8Copy(str, i, 1), decDigits)>0) or
         (
           (i=UTF8Length(str)) and
           (
             (UTF8Copy(str, i, 1)='K') or
             (UTF8Copy(str, i, 1)='M')
           )
         ) then Result:=true
           else
            begin
              Result:=false;
              exit;
            end;
  tokStyle:=tsNum;
end;

function TToken.isSymbol: boolean;
const
   Digits='0123456789';
begin
  case UTF8UpperCase(textToken) of
    'ASR', 'LSL', 'LSR', 'ROR', 'RRX': Result:=false;
    else
      if (UTF8Pos(UTF8Copy(textToken, 1, 1), digits, 1)<>0) then Result:=false
        else
         begin
           Result:=true;
           tokStyle:=tsLabSymb;
         end;
  end;
end;

function TToken.isRegister: boolean;
const
  regNames=' R0 R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11 R12 R13 R14 R15 LR SP PC ';
var
  str:string;
//  i:integer;
begin
  Result:=false;

  str:=UTF8UpperCase(Text);

  if (UTF8Pos(str, regNames,1)=0) or (UTF8Length(str)=1) then exit;

  Result:=true;
end;

end.

