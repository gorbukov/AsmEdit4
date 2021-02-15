unit FontImportConfigUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFontImportConfigForm }

  TFontImportConfigForm = class(TForm)
    Button1: TButton;
    WidthImp: TCheckBox;
    StrLineFormat: TCheckBox;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

implementation

{$R *.lfm}

{ TFontImportConfigForm }

procedure TFontImportConfigForm.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

end.

