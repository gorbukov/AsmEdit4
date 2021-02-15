unit HistoryFilesUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  EditorFilesUnit,
  SourceTextUnit;

type

  TFilePos=class(TObject)
    filename:string;

    FirstLineVisible:integer;  // первая видимая строка
    FirstCharVisible:integer;  // первый видимый символ
    CursorX, CursorY:integer;  // позиция курсора
  end;

  { THistoryFiles }

  THistoryFiles=class(TObject)
    private
       List:TList;
    public
      constructor Create;
      destructor  Free;

      function   Count:integer;

      procedure  Clear;
      procedure  AddHist(ST:TSourceText);
      procedure  GetLast;
      function   ViewLastFile:string;
  end;

implementation

uses MainUnit;

{ THistoryFiles }

constructor THistoryFiles.Create;
begin
  List:=TList.Create;
end;

destructor THistoryFiles.Free;
begin
  List.Free;
end;

function THistoryFiles.Count: integer;
begin
   Result:=List.Count;
end;

procedure THistoryFiles.Clear;
begin
  List.Clear;
end;

procedure THistoryFiles.AddHist(ST: TSourceText);
var
  fp:TFilePos;
begin
  fp:=TFilePos.Create;
  fp.filename:=ST.FileName;
  fp.CursorY:=ST.CursorY;
  fp.CursorX:=ST.CursorX;
  fp.FirstCharVisible:=ST.FirstCharVisible;
  fp.FirstLineVisible:=ST.FirstLineVisible;
  List.Add(fp);
end;

procedure THistoryFiles.GetLast;
var
  fp:TFilePos;
  ST:TSourceText;
begin
  if List.Count=0 then
    begin
      exit;
    end;

  fp:=TFilePos(List.Items[List.Count-1]);
  ST:=EditorFiles.Open(fp.filename);
  ST.CursorX:=fp.CursorX;
  ST.CursorY:=fp.CursorY;
  ST.FirstCharVisible:=fp.FirstCharVisible;
  ST.FirstLineVisible:=fp.FirstLineVisible;
  EditorFiles.OpenInEditor(ST);
  List.Delete(List.Count-1);
end;

function THistoryFiles.ViewLastFile: string;
begin
  Result:=TFilePos(List.Items[List.Count-1]).filename;
end;

end.

