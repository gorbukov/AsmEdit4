unit EditValueUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids, LazUTF8,
  SymbolsUnit, TokensUnit, SourceLineUnit;

type

  { TEditValueForm }

  TEditValueForm = class(TForm)
    CancelButton: TButton;
    ApplyButton: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    StringGrid1: TStringGrid;
    procedure CancelButtonClick(Sender: TObject);
    procedure ApplyButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; {%H-}Shift: TShiftState);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; {%H-}aCol, aRow: Integer;
      var {%H-}CanSelect: Boolean);
  private
     run:boolean;
  public
     SymbName:string;
     Symbols: TSymbolList;
     procedure SetData(SymbolList:TSymbolList);
  end;

var
  EditValueForm: TEditValueForm;

implementation

{$R *.lfm}

{ TEditValueForm }

procedure TEditValueForm.FormCreate(Sender: TObject);
begin
  run:=false;
  StringGrid1.RowCount:=2;
  StringGrid1.ColWidths[0]:=220;
  StringGrid1.ColWidths[1]:=442;
  StringGrid1.Cells[0,0]:='Символ';
  StringGrid1.Cells[1,0]:='Описание';
end;

procedure TEditValueForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
  13:ModalResult:=mrOk;
  27:ModalResult:=mrCancel;
  end;
end;

procedure TEditValueForm.StringGrid1DblClick(Sender: TObject);
begin
   ModalResult:=1;
end;

procedure TEditValueForm.StringGrid1SelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
var
  i, p:integer;
  str:string;
  TL:TTokenList;
begin
  if not run then exit;

  i:=aRow-1;
  if (i<0) then exit;

  SymbName:=StringGrid1.Cells[0, aRow];

  TL:=TTokenList(TSymbol(Symbols.GetSymb(i)).SourceLine.GetTokens);
  str:='';

  for p:=TSymbol(Symbols.GetSymb(i)).TokenNum+2 to TL.Count-1 do
    if TToken(TL.GetToken(p)).tokType=ttRem then break
      else str:=str+TToken(TL.GetToken(p)).Text+' ';

  Memo1.Text:=str; //UTF8Copy(ValList.Strings[i], p, e-p);

end;


procedure TEditValueForm.CancelButtonClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TEditValueForm.ApplyButtonClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TEditValueForm.FormActivate(Sender: TObject);
begin
end;

procedure TEditValueForm.SetData(SymbolList: TSymbolList);
var
  i, t:integer;
  SL:TSourceLine;
  TL:TTokenList;
begin
  if (SymbolList=nil) or (SymbolList.Count=0) then exit;
  Symbols:=SymbolList;
  StringGrid1.RowCount:=SymbolList.Count+1;
  for i:=0 to SymbolList.Count-1 do
    begin
       SL:=TSourceLine(SymbolList.GetSymb(i).SourceLine);
       TL:=TTokenList(SL.GetTokens);
       StringGrid1.Cells[0,i+1]:=TSymbol(SymbolList.GetSymb(i)).Name;
       for t:=0 to TL.Count-1 do
         if TToken(TL.GetToken(t)).tokType=ttRem then
           StringGrid1.Cells[1,i+1]:=UTF8Copy(TToken(TL.GetToken(t)).Text, 2, UTF8Length(TToken(TL.GetToken(t)).Text)-1);
    end;
   SymbName:=StringGrid1.Cells[0, 1];
   run:=true;
end;

end.

