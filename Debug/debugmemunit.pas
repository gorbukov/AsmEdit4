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

  TModeControlVal=(tcNone, tcHalt, tcProcess);

  TWatchPoint=class(TObject)
    adr:string;   // адрес
    size:integer; // размер
    access:integer; // режим доступа

    controlFlag:boolean;
    controlMode:TModeControlVal;

    contMinFlag:boolean;
    ValueMin:string;
    messMinFlag:boolean;
    messMin:string;
    minHaltFlag:boolean;

    contValFlag:boolean;
    ValueVal:string;
    messValFlag:boolean;
    messVal:string;
    ValHaltFlag:boolean;

    contMaxFlag:boolean;
    ValueMax:string;
    messMaxFlag:boolean;
    messMax:string;
    maxHaltFlag:boolean;

  end;

implementation

end.

