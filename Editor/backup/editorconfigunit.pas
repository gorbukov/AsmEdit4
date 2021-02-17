unit EditorConfigUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls;

type

  { TEditorConfigForm }

  TEditorConfigForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button_SetNumColor: TButton;
    Button_SetNumFont: TButton;
    ColorDialog1: TColorDialog;
    Editor_Num_Step: TTrackBar;
    FontDialog1: TFontDialog;
    GroupBox1: TGroupBox;
    Editor_Num_Image: TImage;
    GroupBox2: TGroupBox;
    Editor_Text_Image: TImage;
    GroupBox3: TGroupBox;
    Editor_Scr_Image: TImage;
    Editor_Cursor_Image: TImage;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Editor_Num_Chars: TTrackBar;
    TabSheet2: TTabSheet;
    CursorHorView: TTrackBar;
    CursorVertView: TTrackBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button_SetNumColorClick(Sender: TObject);
    procedure Button_SetNumFontClick(Sender: TObject);
    procedure CursorHorViewChange(Sender: TObject);
    procedure CursorVertViewChange(Sender: TObject);
    procedure Editor_Num_CharsChange(Sender: TObject);
    procedure Editor_Num_StepChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);


    procedure PaintNumImage;
  private

  public

  end;

var
  EditorConfigForm: TEditorConfigForm;

implementation

{$R *.lfm}

{ TEditorConfigForm }

// смена ширины панели номеров строк
procedure TEditorConfigForm.Editor_Num_CharsChange(Sender: TObject);
begin
  Label2.Caption:=inttostr(Editor_Num_Chars.Position);
end;

procedure TEditorConfigForm.Editor_Num_StepChange(Sender: TObject);
begin
  Label6.Caption:=inttostr(Editor_Num_Step.Position);
end;

procedure TEditorConfigForm.FormActivate(Sender: TObject);
begin
  PaintNumImage;
end;

// отрисовка демо панели цвета фона и символов панели
procedure TEditorConfigForm.PaintNumImage;
begin
  Editor_Num_Image.Canvas.FillRect(0, 0, Editor_Num_Image.Width, Editor_Num_Image.Height);
  Editor_Num_Image.Canvas.TextOut(20, 15, '12345');

  Editor_Text_Image.Canvas.FillRect(0, 0, Editor_Text_Image.Width, Editor_Text_Image.Height);
  Editor_Text_Image.Canvas.TextOut(20, 20, '12345');

  Editor_Cursor_Image.Canvas.FillRect(0, 0, Editor_Cursor_Image.Width, Editor_Cursor_Image.Height);

  Editor_Scr_Image.Canvas.FillRect(0, 0, Editor_Scr_Image.Width, Editor_Scr_Image.Height);
  Editor_Scr_Image.Canvas.TextOut(20, 20, '12345');


end;

// задать цвет фона области нумерации строк
procedure TEditorConfigForm.Button_SetNumColorClick(Sender: TObject);
begin
  ColorDialog1.Color:=Editor_Num_Image.Canvas.Brush.Color;
  if ColorDialog1.Execute then
    begin
      Editor_Num_Image.Canvas.Brush.Color:=ColorDialog1.Color;
      PaintNumImage;
    end;
end;

// цвет фона текста в редакторе
procedure TEditorConfigForm.Button1Click(Sender: TObject);
begin
  ColorDialog1.Color:=Editor_Text_Image.Canvas.Brush.Color;
  if ColorDialog1.Execute then
    begin
      Editor_Text_Image.Canvas.Brush.Color:=ColorDialog1.Color;

      PaintNumImage;
    end;
end;

// шрифт текста в редакторе
procedure TEditorConfigForm.Button2Click(Sender: TObject);
begin
   FontDialog1.Font:=Editor_Text_Image.Canvas.Font;
   if FontDialog1.Execute then
     begin
       Editor_Text_Image.Canvas.Font:=FontDialog1.Font;
       Editor_Text_Image.Canvas.Font.Name:='Courier New';
       PaintNumImage;
     end;
end;

// цвет фона панели скролинга
procedure TEditorConfigForm.Button3Click(Sender: TObject);
begin
  ColorDialog1.Color:=Editor_Scr_Image.Canvas.Brush.Color;
    if ColorDialog1.Execute then
      begin
        Editor_Scr_Image.Canvas.Brush.Color:=ColorDialog1.Color;
        PaintNumImage;
      end;
end;

// цвет символов панели скролинга
procedure TEditorConfigForm.Button4Click(Sender: TObject);
begin
  ColorDialog1.Color:=Editor_Scr_Image.Canvas.Font.Color;
    if ColorDialog1.Execute then
      begin
        Editor_Scr_Image.Canvas.Font.Color:=ColorDialog1.Color;
        PaintNumImage;
      end;
end;

// цвет курсора
procedure TEditorConfigForm.Button5Click(Sender: TObject);
begin
  ColorDialog1.Color:=Editor_Cursor_Image.Canvas.Brush.Color;
      if ColorDialog1.Execute then
        begin
          Editor_Cursor_Image.Canvas.Brush.Color:=ColorDialog1.Color;
          PaintNumImage;
        end;
end;

procedure TEditorConfigForm.Button6Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

// задать цвет символов области нумерации строк
procedure TEditorConfigForm.Button_SetNumFontClick(Sender: TObject);
begin
  ColorDialog1.Color:=Editor_Num_Image.Canvas.Font.Color;
  if ColorDialog1.Execute then
    begin
      Editor_Num_Image.Canvas.Font.Color:=ColorDialog1.Color;
      PaintNumImage;
    end;
end;

// обзор вокруг курсора по горизонтали
procedure TEditorConfigForm.CursorHorViewChange(Sender: TObject);
begin
  Label14.Caption:=inttostr(CursorHorView.Position);
end;

// обзор вокруг курсора по вертикали
procedure TEditorConfigForm.CursorVertViewChange(Sender: TObject);
begin
  Label15.Caption:=inttostr(CursorVertView.Position);
end;

end.

