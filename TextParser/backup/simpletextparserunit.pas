unit SimpleTextParserUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, TextParserUnit,
  TokensUnit,
  SourceLineUnit;

type

     { TSimpleTextParser }

     TSimpleTextParser=class(TTextParser)
     private

     public
       constructor Create(LN:TList);   override;
       destructor  Free;               override;

       procedure   Clear;              override;
       procedure   Parse(num:integer); override;
       procedure   Del(num:integer);   override;
   end;
implementation

{ TSimpleTextParser }

constructor TSimpleTextParser.Create(LN: TList);
begin
  inherited Create(LN);
end;

destructor TSimpleTextParser.Free;
begin
  inherited Free;
end;

procedure TSimpleTextParser.Clear;
var
  num:integer;
begin
  for num:=0 to Lines.Count-1 do
    TTokenList(TSourceLine(Lines.Items[num]).GetTokens).Clear;
end;

procedure TSimpleTextParser.Parse(num: integer);
var
  Tokens:TTokenList;
  SL:TSourceLine;
  Token:TToken;
begin
  SL:=TSourceLine(Lines.Items[num]);  // строка
  Tokens:=TTokenList(SL.GetTokens);   // токены
  Tokens.Clear;                       // очистим список токенов
  Token:=TToken.Create(SL.GetStr, 1, ttNone);  // создадим токен - вся строка
  Tokens.Add(Token);                  // добавим токен в строку
end;

procedure TSimpleTextParser.Del(num: integer);
begin
   TTokenList(TSourceLine(Lines.Items[num]).GetTokens).Clear;
end;

end.

