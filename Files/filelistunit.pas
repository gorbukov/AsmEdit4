unit FileListUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  SourceTextUnit;

type

  { TFileList }

  TFileList=class(TObject)
    private
      List:TList;

    public
      constructor Create;
      destructor  Free;

  end;

implementation

{ TFileList }

constructor TFileList.Create;
begin
  List:=TList.Create;
end;

destructor TFileList.Free;
begin
  List.Free;
end;

end.

