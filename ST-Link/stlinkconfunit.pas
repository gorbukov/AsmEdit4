unit STLinkConfUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TSTLinkConfForm }

  TSTLinkConfForm = class(TForm)
    Bevel1: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ConnectTypeCheckBox: TCheckBox;
    SWDRadioButton: TRadioButton;
    JTAGRadioButton: TRadioButton;
    RadioGroup1: TRadioGroup;
    STLinkEdit: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

    procedure SpeedConnect(Sender: TObject);
  private

  public

  end;


implementation

uses MainUnit;

{$R *.lfm}

{ TSTLinkConfForm }

procedure TSTLinkConfForm.Button1Click(Sender: TObject);
begin
 MainForm.OpenDialog1.Title:='Укажите файл ST-Link_CLI.exe';
 MainForm.OpenDialog1.InitialDir:=ExtractFilePath(STLinkEdit.text);
 MainForm.OpenDialog1.FileName:='ST-Link_CLI.exe';

 if MainForm.OpenDialog1.Execute then STLinkEdit.text:=MainForm.OpenDialog1.FileName;
end;

procedure TSTLinkConfForm.Button2Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TSTLinkConfForm.Button3Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TSTLinkConfForm.SpeedConnect(Sender: TObject);
begin

end;

end.

