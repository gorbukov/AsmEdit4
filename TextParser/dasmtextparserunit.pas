unit dasmtextparserunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, TextParserUnit, LazUTF8,
  TokensUnit,
  SourceLineUnit;

type
     { TDAsmTextParser }

     TDAsmTextParser=class(TTextParser)
     private
       procedure OpenBrack(Tokens: TTokenList; var pos: integer);

     public
       constructor Create(LN:TList);   override;
       destructor  Free;               override;

       procedure   Clear;              override;
       procedure   Parse(num:integer); override;
       procedure   Del(num:integer);   override;

       function getAdrLine(adrHex: string; out line: integer): string; // текст и номер строки по hex адресу
       function getLineAdr(line:integer):string;   // получить адрес из строки
       function getLabelLine(name:string):integer; // получить номер строки метки в тексте
   end;
implementation

{ TDAsmTextParser }

constructor TDAsmTextParser.Create(LN: TList);
begin
  inherited Create(LN);
end;

destructor TDAsmTextParser.Free;
begin
  inherited Free;
end;

procedure TDAsmTextParser.Clear;
var
  num:integer;
begin
  for num:=0 to Lines.Count-1 do
    TTokenList(TSourceLine(Lines.Items[num]).GetTokens).Clear;
end;

procedure TDAsmTextParser.OpenBrack(Tokens:TTokenList; var pos:integer);
var
  tok:TToken;
begin
   TToken(Tokens.GetToken(pos)).tokStyle:=tsDelim;
   pos:=pos+1;
   while (pos<Tokens.Count) do
     begin
       tok:=TToken(Tokens.GetToken(pos));
       if tok.Text='>' then
          begin
            tok.tokStyle:=tsDelim;
            pos:=pos+1;
            exit;
          end;
       if (tok.tokType=ttLogic) then tok.tokStyle:=tsDelim;
       if tok.isHEX or tok.isNumber then begin end;
       if tok.tokType=ttChars then tok.tokStyle:=tsLabSymb;
       pos:=pos+1;
     end;
end;

procedure TDAsmTextParser.Parse(num: integer);
var
  Tokens:TTokenList;
  SL:TSourceLine;
  Token:TToken;
  i:integer;

begin
  SL:=TSourceLine(Lines.Items[num]);  // строка
  Tokens:=TTokenList(SL.GetTokens);   // токены
  Tokens.Clear;                       // очистим список токенов

  Tokens.ParseLineStr(SL.GetStr);
  i:=0;
  while i<Tokens.Count do
    begin
      Token:=Tokens.GetToken(i);
      if Token.isHEX then // обрабатываемая строка начинается с числа
        begin
          i:=i+1;
          // после числа идет открывающий знак
          if (TToken(Tokens.GetToken(i)).Text='<') then  OpenBrack(Tokens, i)
          else
          // потом двоеточие
           if (TToken(Tokens.GetToken(i)).Text=':') then
            begin
              if (i+1<Tokens.Count) and (TToken(Tokens.GetToken(i+1)).Text='\') then
                begin
                  i:=0;
                  while i<Tokens.Count do
                     begin
                       TToken(Tokens.GetToken(i)).tokStyle:=tsRem;
                       i:=i+1;
                     end;
                  exit;
                end;
              TToken(Tokens.GetToken(i)).tokStyle:=tsDelim;
              i:=i+1;
              if not TToken(Tokens.GetToken(i)).isHEX then
                begin
                  while i<Tokens.Count do
                     begin
                       TToken(Tokens.GetToken(i)).tokStyle:=tsRem;
                       i:=i+1;
                     end;
                  exit
                end;
              while TToken(Tokens.GetToken(i)).isHEX do i:=i+1;
              if TToken(Tokens.GetToken(i)).tokType=ttChars then
                begin
                  TToken(Tokens.GetToken(i)).tokStyle:=tsAsmCom;
                  i:=i+1;
                end;
              // дальше раскрашиваем по типу распознанного токена
              while i<Tokens.Count do
                begin
                   Token:=Tokens.GetToken(i);
                   if (Token.isNumber) or (Token.isHEX) then begin i:=i+1; end
                   else
                   if (TToken(Tokens.GetToken(i)).Text='<') then OpenBrack(Tokens, i)
                   else
                   if (Token.Text=',') or (Token.Text='[') or (Token.Text=']')
                     or (Token.Text='(') or (Token.Text=')') or (Token.Text='{')
                     or (Token.Text='}') or (Token.Text='-') or (Token.Text=':')
                     or (Token.Text='!') or (Token.Text='^') then
                      begin
                        TToken(Tokens.GetToken(i)).tokStyle:=tsDelim;
                        i:=i+1;
                      end
                   else
                   if UTF8Copy(Token.Text,1,1)='#' then
                     begin
                       Token.tokStyle:=tsNum;
                       i:=i+1;
//                       if i=Tokens.Count then exit;
//                       TToken(Tokens.GetToken(i)).tokStyle:=tsNum;
//                       i:=i+1;
                     end
                   else
                   if (Token.Text=';')  then
                      while i<Tokens.Count do
                        begin
                         TToken(Tokens.GetToken(i)).tokStyle:=tsRem;
                         i:=i+1;
                        end
                   else
                   if Token.tokType=ttChars then
                      begin
                        TToken(Tokens.GetToken(i)).tokStyle:=tsAsmCom;
                        i:=i+1;
                      end
                   else
                   begin
                        TToken(Tokens.GetToken(i)).tokStyle:=tsErr;
                        i:=i+1;
                      end
                end;
            end
        end
      else
      while i<Tokens.Count do // иначе это комментарий
        begin
          Token:=Tokens.GetToken(i);
          Token.tokStyle:=tsRem;
          i:=i+1;
        end;
      i:=i+1;
    end;
end;

procedure TDAsmTextParser.Del(num: integer);
begin
   TTokenList(TSourceLine(Lines.Items[num]).GetTokens).Clear;
end;

// получить строку по адресу
function TDAsmTextParser.getAdrLine(adrHex: string; out line:integer): string;
var
  adr:string;
  i:integer;
  SL:TSourceLine;
  Tokens:TTokenList;
begin
  Result:='';
  line:=-1;
  if utf8pos('0x0', adrHex,1)=1 then adr:=utf8copy(adrHex,4, UTF8Length(adrHex)-3)
                                else adr:=utf8copy(adrHex,3, UTF8Length(adrHex)-2);
  for i:=0 to Lines.Count-1 do
    begin
      SL:=TSourceLine(Lines.Items[i]);  // строка
      Tokens:=TTokenList(SL.GetTokens);   // токены
      if (Tokens.Count>0) and
         (utf8uppercase(TToken(Tokens.GetToken(0)).Text)=utf8uppercase(adr)) then
         begin
           Result:=SL.GetStr;
           line:=i;
           exit;
         end;
    end;
end;

// получить адрес из строки
function TDAsmTextParser.getLineAdr(line: integer): string;
var
  SL:TSourceLine;
  Tokens:TTokenList;
begin
  Result:='';
  if (line<0) or (line>=Lines.Count) then exit;

  SL:=TSourceLine(Lines.Items[line]);  // строка
  Tokens:=TTokenList(SL.GetTokens);   // токены

  if (Tokens=nil) or (Tokens.Count<2) then exit;
  if TToken(Tokens.GetToken(1)).Text<>':' then exit;

  Result:=TToken(Tokens.GetToken(0)).Text;
  if UTF8Length(Result)<8 then Result:='0'+Result;
  Result:='0x'+Result;

end;

// получить номер строки метки в тексте
function TDAsmTextParser.getLabelLine(name: string): integer;
var
  SL:TSourceLine;
  Tokens:TTokenList;
  i:integer;
begin
  Result:=-1;

  for i:=0 to Lines.Count-1 do
    begin
      SL:=TSourceLine(Lines.Items[i]);  // строка
      Tokens:=TTokenList(SL.GetTokens);   // токены
      if (Tokens.Count>4) and
         (TToken(Tokens.GetToken(1)).Text='<') and
         (TToken(Tokens.GetToken(2)).Text=name) and
         (TToken(Tokens.GetToken(3)).Text='>') then
         begin
            Result:=i;
            exit;
         end;
    end;
end;

end.

