unit UndoRedoUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  TURAction=(turAdd, turIns, turDel, turSet, turClear); // тип действия

  //одно действие

  { TUndoRedoRec }

  TUndoRedoRec=class(TObject)
    action:TURAction;

    lineNum:integer;
    lineStr:string;
    constructor Create(num:integer; str:string);
  end;

  // одно изменение

  { TUndoRedoItem }

  TUndoRedoItem=class(TObject)
  private
    List:TList;
    function GetListCount: integer;

  public
    FirstLineVisible:integer;  // первая видимая строка
    FirstCharVisible:integer;  // первый видимый символ
    FirstLineCopy:integer;     // копия первая видимая строка
    FirstCharCopy:integer;     // копия первый видимый символ
    CursorX, CursorY:integer;  // позиция курсора
    TextSelect:boolean;        // есть выделение текста
    TextSelectSX, TextSelectSY, TextSelectLX, TextSelectLY:integer; // выделение текста

    property     Count:integer read GetListCount;

    constructor  Create;
    destructor   Free;


    procedure AddRec(URRec:TUndoRedoRec);
    function  GetRec(num: integer): TUndoRedoRec;
  end;

  { TUndoRedoList }
  // список изменений
  TUndoRedoList=class(TObject)
    private
       List:TList;

       write_change:boolean;

       procedure setWrite_change(AValue: boolean);

    public
      Current:TUndoRedoItem;   // текущее изменение

      undo_oper:boolean;    // флаг предыдущей undo операции
      redo_oper:boolean;    // флаг предыдущей redo операции
      itemNum:integer;

      property fl_write_change:boolean read write_change write setWrite_change; // признак запоминания изменений

      constructor  Create;
      destructor   Free;

      function Count:integer;

      function AddItem:TUndoRedoItem;  // добавить новое изменение

      function GetLast:TUndoRedoItem;  // последнее изменение
      function GetPrev:TUndoRedoItem;  // возврат перед последним изменением
  end;

implementation

{ TUndoRedoRec }

constructor TUndoRedoRec.Create(num: integer; str: string);
begin
  lineNum:=num;
  lineStr:=str;
end;

{ TUndoRedoItem }

function TUndoRedoItem.GetListCount: integer;
begin
  Result:=List.Count;
end;

constructor TUndoRedoItem.Create;
begin
  List:=TList.Create;

end;

destructor TUndoRedoItem.Free;
begin
  List.Free;
end;

procedure TUndoRedoItem.AddRec(URRec: TUndoRedoRec);
begin
   List.Add(URRec);
end;

function TUndoRedoItem.GetRec(num: integer): TUndoRedoRec;
begin
  Result:=TUndoRedoRec(List.Items[num]);
end;

{ TUndoRedoList }

procedure TUndoRedoList.setWrite_change(AValue: boolean);
begin
  if write_change=AValue then Exit;
  write_change:=AValue;
  if not write_change then Current:=nil;
end;

constructor TUndoRedoList.Create;
begin
  List:=TList.Create;
  Current:=nil;
  itemNum:=-1;

  undo_oper:=false;
  redo_oper:=false;

  fl_write_change:=true;
end;

destructor TUndoRedoList.Free;
begin
  List.Free;
end;

function TUndoRedoList.Count: integer;
begin
  Result:=List.Count;
end;

function TUndoRedoList.AddItem: TUndoRedoItem;
var
  uri:TUndoRedoItem;
begin
  uri:=nil;
  Current:=uri;
  if fl_write_change then
    begin
      undo_oper:=false;
      redo_oper:=false;

      uri:=TUndoRedoItem.Create;
      Current:=uri;
      itemNum:=List.Add(uri);
    end;
  Result:=uri;
end;

//последнее изменение
function TUndoRedoList.GetLast: TUndoRedoItem;
begin
  Result:=nil;
  if itemNum<0 then exit;

  if undo_oper then itemNum:=itemNum-1;   // если предыдущая операция была отмена,
                        // то сдвигаемся к началу списка изменений
  Result:=TUndoRedoItem(List.Items[itemNum]);

  undo_oper:=true;
  redo_oper:=false;
end;

// возврат отмены
function TUndoRedoList.GetPrev: TUndoRedoItem;
begin
  Result:=nil;
  if itemNum=-1 then exit;

  if itemNum+1<List.Count then itemNum:=itemNum+1;

  Result:=TUndoRedoItem(List.Items[itemNum]);

  undo_oper:=false;
  redo_oper:=true;
end;

end.

