unit GetStrUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TGetStrForm }

  TGetStrForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    StrEdit: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;


implementation

{$R *.lfm}

{ TGetStrForm }

procedure TGetStrForm.Button1Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TGetStrForm.Button2Click(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

end.

