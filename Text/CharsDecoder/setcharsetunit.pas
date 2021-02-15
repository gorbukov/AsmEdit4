unit SetCharSetUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  CharsDecoderUnit;

type

  { TSetCharSetForm }

  TSetCharSetForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

implementation

{$R *.lfm}

{ TSetCharSetForm }

procedure TSetCharSetForm.Button1Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TSetCharSetForm.Button2Click(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

procedure TSetCharSetForm.FormCreate(Sender: TObject);
var
  i:integer;
begin
  ComboBox1.Items.Clear;
  for i:=0 to Length(const_charSetList)-1 do  ComboBox1.Items.Add(const_charSetList[i]);
end;

end.

