unit SourceLineUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8,
  TokensUnit;

type

  { TSourceLine }

  TSourceLine=class(TObject)
    private
      lineStr:string;           // текст строки
      FdebugStr:string;         // сообщение отладчика
      FLineErr:boolean;         // признак что парсинг строки выдал ошибку
      FLineErrStr:string;       // текст ошибки парсинга
      FTokenErrNum:integer;     // номер ошибочного токена

    public
      Tokens:TTokenList;        // токены строки
      SymbolsName:TStringList;  // имена объявленных символов

      property    debugStr:string     read FdebugStr    write FdebugStr;
      property    LineErr:boolean     read FLineErr     write FLineErr;
      property    LineErrStr:string   read FLineErrStr  write FLineErrStr;
      property    TokenErrNum:integer read FTokenErrNum write TokenErrNum;

      constructor Create(str:string);
      destructor  Free;

      procedure SetStr(str:string);
      function  GetStr:string;


      function  GetTokens:TTokenList;

  end;

implementation

{ TSourceLine }

constructor TSourceLine.Create(str: string);
begin
  Tokens:=TTokenList.Create;
  SymbolsName:=TStringList.Create;

  SetStr(str);
end;

destructor TSourceLine.Free;
begin
  SymbolsName.Free;
  Tokens.Free;
end;

procedure TSourceLine.SetStr(str: string);
var
  i:integer;
begin
  lineStr:=UTF8StringReplace(str, #09, '     ', [rfReplaceAll]);
  i:=UTF8Length(linestr);
  while (i>0) and ( (UTF8Copy(linestr, i, 1)=' ') or (UTF8Copy(linestr, i, 1)=#09) ) do i:=i-1;

  linestr:=UTF8Copy(linestr, 1, i);
end;

function TSourceLine.GetStr: string;
begin
  GetStr:=lineStr;
end;

function TSourceLine.GetTokens: TTokenList;
begin
  GetTokens:=Tokens;
end;

end.

