unit GNUConfUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls;

type

  { TGNUConfForm }

  TGNUConfForm = class(TForm)
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    SaveBeforeCompile: TCheckBox;
    OpenDialog1: TOpenDialog;
    ResBINCheckBox: TCheckBox;
    ResHEXCheckBox: TCheckBox;
    FileSectionInfoCheckBox: TCheckBox;
    ProjectSymbolsCheckBox: TCheckBox;
    ProjectDAsmCheckBox: TCheckBox;
    DAsmSectionCheckBox: TCheckBox;
    LdFile: TLabeledEdit;
    Button1: TButton;
    AsFile: TLabeledEdit;
    ObjDumpFile: TLabeledEdit;
    NmFile: TLabeledEdit;
    ObjCopyFile: TLabeledEdit;
    PageControl1: TPageControl;
    Panel1: TPanel;
    TabSheet1: TTabSheet;
    TabSheet3: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private

  public
    procedure  DefaultValues;
  end;


implementation

uses MainUnit;

{$R *.lfm}

{ TGNUConfForm }

procedure TGNUConfForm.Button7Click(Sender: TObject);
begin
  DefaultValues;
end;

procedure TGNUConfForm.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TGNUConfForm.Button2Click(Sender: TObject);
begin
  OpenDialog1.Title:='Программа as.exe';
  if OpenDialog1.Execute then asFile.Text:=OpenDialog1.FileName;
end;

procedure TGNUConfForm.Button3Click(Sender: TObject);
begin
  OpenDialog1.Title:='Программа ld.exe';
  if OpenDialog1.Execute then LdFile.Text:=OpenDialog1.FileName;
end;

procedure TGNUConfForm.Button4Click(Sender: TObject);
begin
  OpenDialog1.Title:='Программа nm.exe';
  if OpenDialog1.Execute then NmFile.Text:=OpenDialog1.FileName;
end;

procedure TGNUConfForm.Button5Click(Sender: TObject);
begin
  OpenDialog1.Title:='Программа objdump.exe';
  if OpenDialog1.Execute then ObjDumpFile.Text:=OpenDialog1.FileName;
end;

procedure TGNUConfForm.Button6Click(Sender: TObject);
begin
  OpenDialog1.Title:='Программа objcopy.exe';
  if OpenDialog1.Execute then ObjCopyFile.Text:=OpenDialog1.FileName;
end;

procedure TGNUConfForm.DefaultValues;
begin

  FileSectionInfoCheckBox.Checked:=true;
  ProjectSymbolsCheckBox.Checked:=true;
  ProjectDAsmCheckBox.Checked:=true;
  DAsmSectionCheckBox.Checked:=true;
  ResBINCheckBox.Checked:=true;
  ResHEXCheckBox.Checked:=true;;


  LdFile.Text:=app_path+'bin\arm-none-eabi-ld.exe';
  AsFile.Text:=app_path+'bin\arm-none-eabi-as.exe';
  ObjDumpFile.Text:=app_path+'bin\arm-none-eabi-objdump.exe';
  NmFile.Text:=app_path+'bin\arm-none-eabi-nm.exe';
  ObjCopyFile.Text:=app_path+'bin\arm-none-eabi-objcopy.exe';
end;

end.

