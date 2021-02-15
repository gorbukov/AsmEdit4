unit AboutUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ShellApi,
  Clipbrd;

type

  { TAboutForm }

  TAboutForm = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label11Click(Sender: TObject);
    procedure Label12Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
  private

  public

  end;

implementation

uses MainUnit;
{$R *.lfm}

{ TAboutForm }

procedure TAboutForm.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
   label2.Caption:=versionStr;
   label6.Caption:=versionApp;
   label13.Caption:=versionInf;
end;

procedure TAboutForm.Label11Click(Sender: TObject);
begin
   ShellExecute(0,nil, PChar('cmd'),PChar('/c start https://vk.com/club200545792'),nil,0);
end;

procedure TAboutForm.Label12Click(Sender: TObject);
begin
   ShellExecute(0,nil, PChar('cmd'),PChar('/c start https://www.youtube.com/playlist?list=PLdA4KC1wucOwotDhISMkVorbjdHzG2mUM'),nil,0);
end;

procedure TAboutForm.Label7Click(Sender: TObject);
begin
   Clipboard.SetTextBuf(PChar('gorbukov@yandex.ru'));
   ShowMessage('Адрес электронной почты скопирован в буфер обмена');
end;

end.

