unit DebugMemUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  // описатель области памяти
  TMemArea=class(TObject)
    adrStart:string;
    size:string;
    mtype:integer;
  end;

implementation

end.

