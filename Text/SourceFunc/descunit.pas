unit DescUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  LazUTF8;

type

  { TDescForm }

  TDescForm = class(TForm)
    Memo1: TMemo;
    procedure FormKeyUp(Sender: TObject; var Key: Word; {%H-}Shift: TShiftState);
  private

  public
    procedure AutoWidth;
  end;


implementation

{$R *.lfm}

{ TDescForm }

procedure TDescForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key=27 then ModalResult:=mrOk;
end;

procedure TDescForm.AutoWidth;
var
  i, wc:integer;
begin
  wc:=0;
  for i:=0 to Memo1.Lines.Count-1 do
   if wc<UTF8Length(Memo1.Lines.Strings[i]) then wc:=UTF8Length(Memo1.Lines.Strings[i]);
  if wc>100 then wc:=100;
  Width:=(wc+3)*Canvas.GetTextWidth('Щ');

  if Memo1.Lines.Count>40 then i:=40 else i:=Memo1.Lines.Count;
  Height:=(i+2)*Canvas.GetTextHeight('Щ');
end;

end.

