unit TextParserUnit;

//
// Базовый класс для классов разбора текстов
//
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SourceLineUnit;

type

  { TTextParser }

  TTextParser=class(TObject)
    protected
       Lines:TList;

    public
      constructor Create(LN:TList); virtual;
      destructor  Free;   virtual;

      procedure   Clear; virtual; abstract;
      procedure   Parse(num:integer); virtual; abstract;
      procedure   Del(num:integer);   virtual; abstract;

      procedure   ParseOff;           virtual;
      procedure   ParseOn;            virtual;
      procedure   ShortParse;         virtual;
      procedure   FullParse;          virtual;
  end;

implementation

{ TTextParser }

// конструктор
constructor TTextParser.Create(LN: TList);
begin
  Lines:=LN;
end;

// деструктор
destructor TTextParser.Free;
begin

end;

// блокировка работы парсера
procedure TTextParser.ParseOff;
begin

end;

// включение работы парсера
procedure TTextParser.ParseOn;
begin

end;

// быстрый парсинг
procedure TTextParser.ShortParse;
begin

end;

// полный парсинг
procedure TTextParser.FullParse;
begin

end;

end.

