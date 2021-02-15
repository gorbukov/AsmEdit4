unit CodeFormatConfigUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, LazUTF8,
  ComCtrls, Buttons, MaskEdit,
  SourceTextUnit,
  TokensUnit;

type

  { TCodeFormatConfigForm }

  TCodeFormatConfigForm = class(TForm)
    AsmOfsPos: TTrackBar;
    RemPos: TTrackBar;
    Button1: TButton;
    AsmComUpperCase: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    RegUpperCase: TCheckBox;
    DirNamesUpperCase: TCheckBox;
    AsmComPos: TTrackBar;
    procedure AsmComPosChange(Sender: TObject);
    procedure AsmOfsPosChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RemPosChange(Sender: TObject);
  private
    function getAsmParamPos: integer;
  public
    property AsmParamPos:integer read getAsmParamPos;
  end;

implementation


{$R *.lfm}

{ TCodeFormatConfigForm }


procedure TCodeFormatConfigForm.FormCreate(Sender: TObject);
begin
  Edit3.Text:=inttostr(RemPos.Position);
  Edit1.Text:=inttostr(AsmComPos.Position);
  Edit2.Text:=inttostr(AsmOfsPos.Position);
end;

procedure TCodeFormatConfigForm.RemPosChange(Sender: TObject);
begin
   Edit3.Text:=inttostr(RemPos.Position);
end;

function TCodeFormatConfigForm.getAsmParamPos: integer;
begin
  Result:=AsmComPos.Position+AsmOfsPos.Position;
end;



procedure TCodeFormatConfigForm.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TCodeFormatConfigForm.AsmComPosChange(Sender: TObject);
begin
  Edit1.Text:=inttostr(AsmComPos.Position);
end;

procedure TCodeFormatConfigForm.AsmOfsPosChange(Sender: TObject);
begin
  Edit2.Text:=inttostr(AsmOfsPos.Position);
end;

end.

