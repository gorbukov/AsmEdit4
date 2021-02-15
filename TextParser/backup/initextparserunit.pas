unit initextparserunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, TextParserUnit,
  TokensUnit,
  SourceLineUnit;

type
     { TIniTextParser }

     TIniTextParser=class(TTextParser)
     private

     public
       constructor Create(LN:TList);   override;
       destructor  Free;               override;

       procedure   Clear;              override;
       procedure   Parse(num:integer); override;
       procedure   Del(num:integer);   override;
   end;
implementation

{ TIniTextParser }

constructor TIniTextParser.Create(LN: TList);
begin
  inherited Create(LN);
end;

destructor TIniTextParser.Free;
begin
  inherited Free;
end;

procedure TIniTextParser.Clear;
var
  num:integer;
begin
  for num:=0 to Lines.Count-1 do
    TTokenList(TSourceLine(Lines.Items[num]).GetTokens).Clear;
end;

procedure TIniTextParser.Parse(num: integer);
var
  Tokens:TTokenList;
  SL:TSourceLine;
  Token:TToken;
  i:integer;
  openbrk:boolean;
  keyid:boolean;
begin
  SL:=TSourceLine(Lines.Items[num]);  // строка
  Tokens:=TTokenList(SL.GetTokens);   // токены
  Tokens.Clear;                       // очистим список токенов

  Tokens.ParseLineStr(SL.GetStr);
  i:=0;
  openbrk:=false;
  keyid:=false;
  while i<Tokens.Count do
    begin
      Token:=Tokens.GetToken(i);
      if Token.Text=';' then
          while i<Tokens.Count do
            begin
              Token.tokStyle:=tsRem;
              i:=i+1;
            end
      else
      if Token.Text='[' then
        begin
          Token.tokStyle:=tsDelim;
          openbrk:=true;
        end
      else
      if Token.Text=']' then
        begin
          Token.tokStyle:=tsDelim;
          openbrk:=false;
        end
      else
      if Token.Text='=' then
        begin
          Token.tokStyle:=tsDelim;
          keyid:=true;
        end
      else
        if openbrk then // внутри квадратных скобок имя секции
          begin
            Token.tokStyle:=tsAsmDir;
          end
      else
        if not keyid then
          begin
            Token.tokStyle:=tsParam;
          end
      else
         begin
            Token.tokStyle:=tsLabSymb;
         end;

      i:=i+1;
    end;
end;

procedure TIniTextParser.Del(num: integer);
begin
   TTokenList(TSourceLine(Lines.Items[num]).GetTokens).Clear;
end;

end.

