unit ProjectConfigUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  LazFileUtils, FileUtil, ExtCtrls,
  MCUSelectUnit;

type

  { TProjectConfigForm }

  TProjectConfigForm = class(TForm)
    ButtonCreatePath: TButton;
    Button3: TButton;
    CancelButton: TButton;
    CloseButton: TButton;
    MCU_DEVICEINFO: TEdit;
    Label15: TLabel;
    MCU_TARGET_ADR: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    MCUSelect: TButton;
    Label12: TLabel;
    MCU_DOC_PATH: TEdit;
    Label11: TLabel;
    MCU_CONF_FILE: TEdit;
    Label10: TLabel;
    MCU_OPENOCD: TEdit;
    SRC_PATH: TEdit;
    GNU_PATH: TEdit;
    MOD_PATH: TEdit;
    OUT_PATH: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MCU_SYNTAX: TEdit;
    MCU_CPU: TEdit;
    MCU_THUMB: TEdit;
    MCU_FPU: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MCU_NAME: TEdit;
    Label1: TLabel;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    EDIT_PATH: TEdit;
    procedure Button3Click(Sender: TObject);
    procedure ButtonCreatePathClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure CloseButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MCUSelectClick(Sender: TObject);

    procedure NewPro;
  private

  public

  end;

implementation

uses MainUnit;
{$R *.lfm}

{ TProjectConfigForm }

procedure TProjectConfigForm.CloseButtonClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TProjectConfigForm.FormCreate(Sender: TObject);
begin
  PageControl1.PageIndex:=0;
  PageControl2.PageIndex:=0;
end;

procedure TProjectConfigForm.MCUSelectClick(Sender: TObject);
var
  MCUSelectForm: TMCUSelectForm;
begin
  MCUSelectForm:=TMCUSelectForm.Create(MainForm);
  if MCUSelectForm.ShowModal=mrOk then
  begin
    MCU_NAME.Text:=MCUSelectForm.mcuname;
    MCU_SYNTAX.Text:=MCUSelectForm.syntax;
    MCU_CPU.Text:=MCUSelectForm.cpu;
    MCU_THUMB.Text:=MCUSelectForm.thumb;
    MCU_FPU.Text:=MCUSelectForm.fpu;
    MCU_CONF_FILE.Text:=MCUSelectForm.mcufile;
    MCU_DOC_PATH.Text:=MCUSelectForm.doc;
    MCU_OPENOCD.Text:=MCUSelectForm.openocd;
    MCU_DEVICEINFO.Text:=MCUSelectForm.deviceinfo;
    MCU_TARGET_ADR.Text:=MCUSelectForm.targetAdr;
  end;
end;

procedure TProjectConfigForm.CancelButtonClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

// создание каталогов проекта
procedure TProjectConfigForm.ButtonCreatePathClick(Sender: TObject);
begin
  ForceDirectory(Project.Project_Path+SRC_PATH.Text); // исходники
  ForceDirectory(Project.Project_Path+MOD_PATH.Text); // модули
  ForceDirectory(Project.Project_Path+EDIT_PATH.Text);// временные файлы
  ForceDirectory(Project.Project_Path+OUT_PATH.Text+'\internal'); // каталог внутреннего компилятора
end;

// компилятор проекта
procedure TProjectConfigForm.Button3Click(Sender: TObject);
begin
  ForceDirectory(Project.Project_Path+GNU_PATH.Text); // компилятор
  CopyFile(app_path+'bin\make_project.bat', Project.Project_Path+'make_project.bat');
  CopyFile(app_path+'bin\arm-none-eabi-as.exe', Project.Project_Path+GNU_PATH.Text+'\arm-none-eabi-as.exe');
  CopyFile(app_path+'bin\arm-none-eabi-ld.exe', Project.Project_Path+GNU_PATH.Text+'\arm-none-eabi-ld.exe');
  CopyFile(app_path+'bin\arm-none-eabi-nm.exe', Project.Project_Path+GNU_PATH.Text+'\arm-none-eabi-nm.exe');
  CopyFile(app_path+'bin\arm-none-eabi-objcopy.exe', Project.Project_Path+GNU_PATH.Text+'\arm-none-eabi-objcopy.exe');
  CopyFile(app_path+'bin\arm-none-eabi-objdump.exe', Project.Project_Path+GNU_PATH.Text+'\arm-none-eabi-objdump.exe');
  ForceDirectory(Project.Project_Path+OUT_PATH.Text+'\temp'); //
end;

//новый проект
procedure TProjectConfigForm.NewPro;
begin
  MCU_NAME.Text:='';
  MCU_SYNTAX.Text:='';
  MCU_CPU.Text:='';
  MCU_THUMB.Text:='';
  MCU_FPU.Text:='';
  MCU_CONF_FILE.Text:='';
  MCU_DOC_PATH.Text:='';
  MCU_OPENOCD.Text:='';
  MCU_DEVICEINFO.Text:='';
  MCU_TARGET_ADR.Text:='';

  SRC_PATH.Text:='src';
  GNU_PATH.Text:='bin';
  MOD_PATH.Text:='modules';
  OUT_PATH.Text:='compile';
  EDIT_PATH.text:='tmp';
end;

end.

