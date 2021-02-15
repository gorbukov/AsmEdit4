unit ImportConfigUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TImportConfigForm }

  TImportConfigForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    LineFormat: TCheckBox;
    ValuesCount: TComboBox;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    ByteSize: TRadioButton;
    HWordSize: TRadioButton;
    WordSize: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

implementation

{$R *.lfm}

{ TImportConfigForm }

procedure TImportConfigForm.Button2Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TImportConfigForm.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

end.

