unit SymbolsUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8,
  TokensUnit, SourceLineUnit;

type

  TSymbolType=(stNone,
               stLocalLabel,
               stGlobalLabel,
               stSymbol,
               stInc);          // вложенный файл
  { TSymbol }

  TSymbol = class(TObject)
    private
      FSymbolName: string;        // имя символа
      FSymbolType:TSymbolType;    // тип символа
      FSL:TSourceLine;            // указатель на строку
      FTokenNum:integer;          // номер токена символа
      FFileName:string;           // имя файла

      procedure setFileName(AValue: string);

    public
      itemNames:TStringList;      //имена категорий item символа (внешнезаполняемое)

      property Name      :string      read FSymbolName;
      property Typ       :TSymbolType read FSymbolType;
      property SourceLine:TSourceLine read FSL;
      property TokenNum  :integer     read FTokenNum;
      property FileName  :string      read FFileName write setFileName;

      constructor Create(symbname: string; tokNum: integer; SourceL: TSourceLine);
      constructor Create(file_name:string; SourceL: TSourceLine);

      destructor Free;

      function TypeStr:string;  // тип символа в виде строки
      function ValueStr:string; // получить строковое значение символа
  end;

  { TSymbolList }

  TSymbolList = class(TObject)
  private
    List: TList;

    function getListCount: integer;

  public
    property Count: integer read getListCount;

    constructor Create;
    destructor  Free;

    procedure Clear;

    procedure AddSymb(symb:TSymbol);
    function  GetSymb(num:integer):TSymbol;
    procedure DelSymb(num:integer);
  end;

implementation

{ TSymbol }

procedure TSymbol.setFileName(AValue: string);
begin
  if FFileName=AValue then Exit;
  FFileName:=UTF8LowerCase(AValue);
end;

// создание символа
constructor TSymbol.Create(symbname: string; tokNum: integer;
  SourceL: TSourceLine);

begin
  FSymbolName:=symbname;
  FSL:=SourceL;
  FtokenNum:=tokNum;
  FileName:='';
//  itemNames:=nil;

  // установим тип символа
  if (FtokenNum>0) then
     case UTF8UpperCase(TToken(TTokenList(FSL.GetTokens).GetToken(FtokenNum-1)).Text) of
       '.EQU'   : FSymbolType:=stSymbol;
       '.GLOBAL': FSymbolType:=stGlobalLabel;
     end
  else
  if (FtokenNum+1<TTokenList(FSL.GetTokens).Count) and
         (UTF8UpperCase(TToken(TTokenList(FSL.GetTokens).GetToken(FtokenNum+1)).Text)=':') then
     FSymbolType:=stLocalLabel
  else FSymbolType:=stNone;
end;

constructor TSymbol.Create(file_name: string; SourceL: TSourceLine);
begin
  FileName:=file_name;
  FSL:=SourceL;
  FSymbolType:=stInc;
  itemNames:=nil;
end;

destructor TSymbol.Free;
begin
//  if itemNames<>nil then itemNames.Free;
//  FreeAndNil(itemNames);
end;

// тип символа в виде строки
function TSymbol.TypeStr: string;
begin
  case Typ of
     stNone:       Result:='None';
     stLocalLabel: Result:='Local';
     stGlobalLabel:Result:='Global';
     stSymbol:     Result:='Symbol';
     stInc:        Result:='Include';
     else Result:='Unknown';
  end;
end;

// получить строковое значение символа
function TSymbol.ValueStr: string;
var
  i:integer;
begin
  Result:='';

  if (Typ=stLocalLabel) or (Typ=stGlobalLabel) then exit;

  for i:=TokenNum to FSL.GetTokens.Count-1 do
    if TToken(FSL.GetTokens.GetToken(i)).tokType<>ttRem then
       begin
         Result:=Result+' '+TToken(FSL.GetTokens.GetToken(i)).Text;
       end
    else exit;
end;


{ TSymbolList }

function TSymbolList.getListCount: integer;
begin
  Result := List.Count;
end;


constructor TSymbolList.Create;
begin
  List := TList.Create;
end;

destructor TSymbolList.Free;
begin
  Clear;
  List.Free;
end;


// очистка списков
procedure TSymbolList.Clear;
//var
//  i:integer;
//  symb:TSymbol;
begin
//  for i:=0 to List.Count-1 do
//    begin
//      symb:=TSymbol(List.Items[i]);
//      FreeAndNil(symb);
//      if symb<>nil then symb.Free;
//    end;
  List.Clear;
end;

procedure TSymbolList.AddSymb(symb: TSymbol);
begin
  List.Add(symb);
end;

function TSymbolList.GetSymb(num: integer): TSymbol;
begin
  if num>=List.Count then Result:=nil
                     else Result:=TSymbol(List.Items[num]);
end;

procedure TSymbolList.DelSymb(num: integer);
begin
  if num>=List.Count then exit;

//  TSymbol(List.Items[num]).Free;
  List.Delete(num);
end;



end.
