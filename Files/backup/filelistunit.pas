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

      function  FileAdd:integer;           // новый файл


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

// добавить новый файл
function TFileList.FileAdd: integer;
var
  ST:TSourceText;
begin
  ST:=TSourceText.Create;

  FileAdd:=List.Add(ST);
end;

end.

