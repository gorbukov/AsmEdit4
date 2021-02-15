unit SelectCharSetUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ConfigUnit;

type

  { TSelectCharSetForm }

  TSelectCharSetForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SetFile(filename:string);
  private
     fl_name:string;
     strl:TStringList;
  public
     res:TStringList;
  end;

implementation

uses CharsDecoderUnit, MainUnit;

{$R *.lfm}

{ TSelectCharSetForm }

procedure TSelectCharSetForm.FormCreate(Sender: TObject);
var
  i:integer;
begin
   res:=TStringList.Create;
  Memo1.Lines.Clear;
  ComboBox1.Items.Clear;
  for i:=0 to Length(const_charSetList)-1 do  ComboBox1.Items.Add(const_charSetList[i]);
end;

procedure TSelectCharSetForm.FormDestroy(Sender: TObject);
begin
  strl.Free;
  res.Free;
end;

procedure TSelectCharSetForm.ComboBox1Change(Sender: TObject);
var
  str:string;
begin
  str:=ComboBox1.Text;
   memo1.Text:=CharSetToUTF8(strl.Text, str);
   res.Text:=Memo1.Text;
end;

procedure TSelectCharSetForm.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TSelectCharSetForm.Button2Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TSelectCharSetForm.FormActivate(Sender: TObject);
begin
   ComboBox1Change(nil);
end;

procedure TSelectCharSetForm.SetFile(filename: string);
var
  cs:string;
  i:integer;
begin
    fl_name:=filename;
   strl:=TStringList.Create;
   strl.LoadFromFile(filename);
   cs:=getTextCharSet(strl.Text);
   if cs='' then cs:=Config.Editor_DefaultCharSet;
   ComboBox1.ItemIndex:=0;
   for i:=0 to ComboBox1.Items.Count-1 do
     if cs=ComboBox1.Items[i] then
       begin
         ComboBox1.ItemIndex:=i;
         exit;
       end;
end;

end.

