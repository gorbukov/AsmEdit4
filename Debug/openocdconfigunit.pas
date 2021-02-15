unit OpenOCDConfigUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  FileUtil;

type

  { TOpenOCDConfigForm }

  TOpenOCDConfigForm = class(TForm)
    Button1: TButton;
    UseOCDtoFlashWrite: TCheckBox;
    ConnectStrText: TComboBox;
    Device_CRadio: TRadioButton;
    Device_FRadio: TRadioButton;
    GroupBox2: TGroupBox;
    ExternalOCDPathEdit: TEdit;
    InternalOpenODC: TComboBox;
    GroupBox1: TGroupBox;
    InternalODCSelect: TRadioButton;
    Label2: TLabel;
    RadioButton2: TRadioButton;
    TargetComboBox: TComboBox;
    TargetText: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InternalODCSelectClick(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
  private
    TargetFiles:TStringList;
  public
    function ServerExeFile:string;
    function TargetFile:string;
    function ConnectStr:string;
  end;


implementation

uses MainUnit;

{$R *.lfm}

{ TOpenOCDConfigForm }

procedure TOpenOCDConfigForm.InternalODCSelectClick(Sender: TObject);
begin
  InternalOpenODC.Enabled:=true;

  Button1.Enabled:=false;
  ExternalOCDPathEdit.Enabled:=false;

end;

procedure TOpenOCDConfigForm.FormCreate(Sender: TObject);
var
  i:integer;
begin
  TargetFiles:=FindAllFiles(app_path+'openocd\scripts\interface', '*.cfg', true);
  for i:=0 to TargetFiles.Count-1 do
    TargetComboBox.Items.Add(ExtractFileName(TargetFiles.Strings[i]));
end;

procedure TOpenOCDConfigForm.Button1Click(Sender: TObject);
begin
  MainForm.OpenDialog1.Title:='Файл openodc.exe';
  MainForm.OpenDialog1.FileName:='openodc.exe';
  MainForm.OpenDialog1.FilterIndex:=7;
  MainForm.OpenDialog1.InitialDir:=app_path;
  if MainForm.OpenDialog1.Execute then ExternalOCDPathEdit.Text:=MainForm.OpenDialog1.FileName;
end;

procedure TOpenOCDConfigForm.RadioButton2Click(Sender: TObject);
begin
  InternalOpenODC.Enabled:=false;

  Button1.Enabled:=true;
  ExternalOCDPathEdit.Enabled:=true;
end;

function TOpenOCDConfigForm.ServerExeFile: string;
begin
  Result:='';
  // внутренний сервер
  if InternalODCSelect.Checked then
    begin
       case InternalOpenODC.ItemIndex of
       0: Result:=app_path+'openocd\bin-x32\openocd.exe';
       1: Result:=app_path+'openocd\bin-x64\openocd.exe';
       end;
    end
  else // внешний сервер
    Result:=ExternalOCDPathEdit.Text;
end;

function TOpenOCDConfigForm.TargetFile: string;
begin
  Result:=TargetFiles.Strings[TargetComboBox.ItemIndex];
end;

function TOpenOCDConfigForm.ConnectStr: string;
begin
  Result:=ConnectStrText.Text;
end;

end.

