unit DebugStructUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  TPointType=(tptWord, tptHWord, tptByte);

  TPointInfo=class(TObject)
    name:string;
    ptype:TPointType;
    adr:string;
    val:string;
  end;

implementation

end.

