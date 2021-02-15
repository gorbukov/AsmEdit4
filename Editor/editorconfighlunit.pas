unit EditorConfigHLUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ColorBox;

type

  { TEditorConfigHLForm }

  TEditorConfigHLForm = class(TForm)
    Button1: TButton;
    RemBkgColorCheck: TCheckBox;
    RegBkgColorCheck: TCheckBox;
    NumBkgColorCheck: TCheckBox;
    AsmcomBkgColorCheck: TCheckBox;
    AsmdirBkgColorCheck: TCheckBox;
    ParamBkgColorCheck: TCheckBox;
    StringBkgColorCheck: TCheckBox;
    DelimBkgColorCheck: TCheckBox;
    ErrBkgColorCheck: TCheckBox;
    SymbBkgColorCheck: TCheckBox;
    EddirBkgColorCheck: TCheckBox;
    RemFontColorBox: TColorBox;
    StringBkgColorBox: TColorBox;
    DelimFontColorBox: TColorBox;
    DelimBkgColorBox: TColorBox;
    ErrFontColorBox: TColorBox;
    ErrBkgColorBox: TColorBox;
    SymbFontColorBox: TColorBox;
    SymbBkgColorBox: TColorBox;
    EddirFontColorBox: TColorBox;
    EddirBkgColorBox: TColorBox;
    RegFontColorBox: TColorBox;
    RemBkgColorBox: TColorBox;
    RegBkgColorBox: TColorBox;
    NumFontColorBox: TColorBox;
    NumBkgColorBox: TColorBox;
    AsmcomFontColorBox: TColorBox;
    AsmcomBkgColorBox: TColorBox;
    AsmdirFontColorBox: TColorBox;
    AsmdirBkgColorBox: TColorBox;
    ParamFontColorBox: TColorBox;
    ParamBkgColorBox: TColorBox;
    StringFontColorBox: TColorBox;
    RemFontStyleBox: TComboBox;
    RegFontStyleBox: TComboBox;
    NumFontStyleBox: TComboBox;
    AsmcomFontStyleBox: TComboBox;
    AsmdirFontStyleBox: TComboBox;
    ParamFontStyleBox: TComboBox;
    StringFontStyleBox: TComboBox;
    DelimFontStyleBox: TComboBox;
    ErrFontStyleBox: TComboBox;
    SymbFontStyleBox: TComboBox;
    EddirFontStyleBox: TComboBox;
    GroupBox1: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    GroupBox9: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    function getNumBkgColorBox: TColor;
    function getNumBkgColorCheck: boolean;
    function getNumFontColor: TColor;
    function getNumFontStyles: TFontStyles;

    function getRemBkgColorBox: TColor;
    function getRemBkgColorCheck: boolean;
    function getRemFontColor: TColor;
    function getRemFontStyles: TFontStyles;

    function getEddirBkgColorBox: TColor;
    function getEddirBkgColorCheck: boolean;
    function getEddirFontColor: TColor;
    function getEddirFontStyles: TFontStyles;

    function getAsmdirBkgColorBox: TColor;
    function getAsmdirBkgColorCheck: boolean;
    function getAsmdirFontColor: TColor;
    function getAsmdirFontStyles: TFontStyles;

    function getParamBkgColorBox: TColor;
    function getParamBkgColorCheck: boolean;
    function getParamFontColor: TColor;
    function getParamFontStyles: TFontStyles;

    function getStringBkgColorBox: TColor;
    function getStringBkgColorCheck: boolean;
    function getStringFontColor: TColor;
    function getStringFontStyles: TFontStyles;

    function getDelimBkgColorBox: TColor;
    function getDelimBkgColorCheck: boolean;
    function getDelimFontColor: TColor;
    function getDelimFontStyles: TFontStyles;

    function getErrBkgColorCheck: boolean;
    function getErrFontColor: TColor;
    function getErrFontStyles: TFontStyles;
    function getErrkgColorBox: TColor;

    function getSymbBkgColorBox: TColor;
    function getSymbBkgColorCheck: boolean;
    function getSymbFontColor: TColor;
    function getSymbFontStyles: TFontStyles;

    function getAsmcomBkgColorCheck: boolean;
    function getAsmcomFontColor: TColor;
    function getAsmcomFontStyles: TFontStyles;
    function getAsmcomBkgColorBox: TColor;

    function getRegBkgColorBox: TColor;
    function getRegBkgColorCheck: boolean;
    function getRegFontColor: TColor;
    function getRegFontStyles: TFontStyles;
  public
    // свойства шрифта для REM - комментариев
    property REM_FONT_COLOR:TColor         read  getRemFontColor;
    property REM_FONT_STYLE:TFontStyles    read  getRemFontStyles;
    property REM_BKGCOL_CHECK:boolean      read  getRemBkgColorCheck;
    property REM_BKG_COLOR:TColor          read  getRemBkgColorBox;

    property EDDIR_FONT_COLOR:TColor      read  getEddirFontColor;
    property EDDIR_FONT_STYLE:TFontStyles read  getEddirFontStyles;
    property EDDIR_BKGCOL_CHECK:boolean   read  getEddirBkgColorCheck;
    property EDDIR_BKG_COLOR:TColor       read  getEddirBkgColorBox;

    property ASMDIR_FONT_COLOR:TColor      read  getAsmdirFontColor;
    property ASMDIR_FONT_STYLE:TFontStyles read  getAsmdirFontStyles;
    property ASMDIR_BKGCOL_CHECK:boolean   read  getAsmdirBkgColorCheck;
    property ASMDIR_BKG_COLOR:TColor       read  getAsmdirBkgColorBox;

    property PARAM_FONT_COLOR:TColor      read  getParamFontColor;
    property PARAM_FONT_STYLE:TFontStyles read  getParamFontStyles;
    property PARAM_BKGCOL_CHECK:boolean   read  getParamBkgColorCheck;
    property PARAM_BKG_COLOR:TColor       read  getParamBkgColorBox;

    property STRING_FONT_COLOR:TColor      read  getStringFontColor;
    property STRING_FONT_STYLE:TFontStyles read  getStringFontStyles;
    property STRING_BKGCOL_CHECK:boolean   read  getStringBkgColorCheck;
    property STRING_BKG_COLOR:TColor       read  getStringBkgColorBox;

    property DELIM_FONT_COLOR:TColor      read  getDelimFontColor;
    property DELIM_FONT_STYLE:TFontStyles read  getDelimFontStyles;
    property DELIM_BKGCOL_CHECK:boolean   read  getDelimBkgColorCheck;
    property DELIM_BKG_COLOR:TColor       read  getDelimBkgColorBox;

    property ERR_FONT_COLOR:TColor      read  getErrFontColor;
    property ERR_FONT_STYLE:TFontStyles read  getErrFontStyles;
    property ERR_BKGCOL_CHECK:boolean   read  getErrBkgColorCheck;
    property ERR_BKG_COLOR:TColor       read  getErrkgColorBox;

    property SYMB_FONT_COLOR:TColor      read  getSymbFontColor;
    property SYMB_FONT_STYLE:TFontStyles read  getSymbFontStyles;
    property SYMB_BKGCOL_CHECK:boolean   read  getSymbBkgColorCheck;
    property SYMB_BKG_COLOR:TColor       read  getSymbBkgColorBox;

    property ASMCOM_FONT_COLOR:TColor      read  getAsmcomFontColor;
    property ASMCOM_FONT_STYLE:TFontStyles read  getAsmcomFontStyles;
    property ASMCOM_BKGCOL_CHECK:boolean   read  getAsmcomBkgColorCheck;
    property ASMCOM_BKG_COLOR:TColor       read  getAsmcomBkgColorBox;

    property REG_FONT_COLOR:TColor      read  getRegFontColor;
    property REG_FONT_STYLE:TFontStyles read  getRegFontStyles;
    property REG_BKGCOL_CHECK:boolean   read  getRegBkgColorCheck;
    property REG_BKG_COLOR:TColor       read  getRegBkgColorBox;

    property NUM_FONT_COLOR:TColor      read  getNumFontColor;
    property NUM_FONT_STYLE:TFontStyles read  getNumFontStyles;
    property NUM_BKGCOL_CHECK:boolean   read  getNumBkgColorCheck;
    property NUM_BKG_COLOR:TColor       read  getNumBkgColorBox;
  end;

var
  EditorConfigHLForm: TEditorConfigHLForm;

implementation

{$R *.lfm}

{ TEditorConfigHLForm }

procedure TEditorConfigHLForm.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;


// rem
function TEditorConfigHLForm.getRemBkgColorBox: TColor;
begin
  Result:=RemBkgColorBox.Selected;
end;

function TEditorConfigHLForm.getRemBkgColorCheck: boolean;
begin
  Result:=RemBkgColorCheck.Checked;
end;

function TEditorConfigHLForm.getRemFontColor: TColor;
begin
  Result:=RemFontColorBox.Selected;
end;

function TEditorConfigHLForm.getRemFontStyles: TFontStyles;
begin
  case RemFontStyleBox.ItemIndex of
    0: Result:=TFontStyles([]);
    1: Result:=[fsBold];
    2: Result:=[fsItalic];
    3: Result:=[fsBold,fsItalic];
  end;
end;

//eddir
function TEditorConfigHLForm.getEddirBkgColorBox: TColor;
begin
  Result:=EddirBkgColorBox.Selected;
end;

function TEditorConfigHLForm.getEddirBkgColorCheck: boolean;
begin
  Result:=EddirBkgColorCheck.Checked;
end;

function TEditorConfigHLForm.getEddirFontColor: TColor;
begin
  Result:=EddirFontColorBox.Selected;
end;

function TEditorConfigHLForm.getEddirFontStyles: TFontStyles;
begin
  case EddirFontStyleBox.ItemIndex of
    0: Result:=TFontStyles([]);
    1: Result:=[fsBold];
    2: Result:=[fsItalic];
    3: Result:=[fsBold,fsItalic];
  end;
end;

//asmdir
function TEditorConfigHLForm.getAsmdirBkgColorBox: TColor;
begin
  Result:=AsmdirBkgColorBox.Selected;
end;

function TEditorConfigHLForm.getAsmdirBkgColorCheck: boolean;
begin
  Result:=AsmdirBkgColorCheck.Checked;
end;

function TEditorConfigHLForm.getAsmdirFontColor: TColor;
begin
  Result:=AsmdirFontColorBox.Selected;
end;

function TEditorConfigHLForm.getAsmdirFontStyles: TFontStyles;
begin
  case AsmdirFontStyleBox.ItemIndex of
    0: Result:=TFontStyles([]);
    1: Result:=[fsBold];
    2: Result:=[fsItalic];
    3: Result:=[fsBold,fsItalic];
  end;
end;

// param
function TEditorConfigHLForm.getParamBkgColorBox: TColor;
begin
  Result:=ParamBkgColorBox.Selected;
end;

function TEditorConfigHLForm.getParamBkgColorCheck: boolean;
begin
  Result:=ParamBkgColorCheck.Checked;
end;

function TEditorConfigHLForm.getParamFontColor: TColor;
begin
  Result:=ParamFontColorBox.Selected;
end;

function TEditorConfigHLForm.getParamFontStyles: TFontStyles;
begin
  case ParamFontStyleBox.ItemIndex of
    0: Result:=TFontStyles([]);
    1: Result:=[fsBold];
    2: Result:=[fsItalic];
    3: Result:=[fsBold,fsItalic];
  end;
end;

// string
function TEditorConfigHLForm.getStringBkgColorBox: TColor;
begin
  Result:=StringBkgColorBox.Selected;
end;

function TEditorConfigHLForm.getStringBkgColorCheck: boolean;
begin
  Result:=StringBkgColorCheck.Checked;
end;

function TEditorConfigHLForm.getStringFontColor: TColor;
begin
  Result:=StringFontColorBox.Selected;
end;

function TEditorConfigHLForm.getStringFontStyles: TFontStyles;
begin
  case StringFontStyleBox.ItemIndex of
    0: Result:=TFontStyles([]);
    1: Result:=[fsBold];
    2: Result:=[fsItalic];
    3: Result:=[fsBold,fsItalic];
  end;
end;

// delim
function TEditorConfigHLForm.getDelimBkgColorBox: TColor;
begin
  Result:=DelimBkgColorBox.Selected;
end;

function TEditorConfigHLForm.getDelimBkgColorCheck: boolean;
begin
  Result:=DelimBkgColorCheck.Checked;
end;

function TEditorConfigHLForm.getDelimFontColor: TColor;
begin
  Result:=DelimFontColorBox.Selected;
end;

function TEditorConfigHLForm.getDelimFontStyles: TFontStyles;
begin
  case DelimFontStyleBox.ItemIndex of
    0: Result:=TFontStyles([]);
    1: Result:=[fsBold];
    2: Result:=[fsItalic];
    3: Result:=[fsBold,fsItalic];
  end;
end;

// err
function TEditorConfigHLForm.getErrkgColorBox: TColor;
begin
  Result:=ErrBkgColorBox.Selected;
end;

function TEditorConfigHLForm.getErrBkgColorCheck: boolean;
begin
  Result:=ErrBkgColorCheck.Checked;
end;

function TEditorConfigHLForm.getErrFontColor: TColor;
begin
  Result:=ErrFontColorBox.Selected;
end;

function TEditorConfigHLForm.getErrFontStyles: TFontStyles;
begin
  case ErrFontStyleBox.ItemIndex of
    0: Result:=TFontStyles([]);
    1: Result:=[fsBold];
    2: Result:=[fsItalic];
    3: Result:=[fsBold,fsItalic];
  end;
end;

// symb
function TEditorConfigHLForm.getSymbBkgColorBox: TColor;
begin
  Result:=SymbBkgColorBox.Selected;
end;

function TEditorConfigHLForm.getSymbBkgColorCheck: boolean;
begin
  Result:=SymbBkgColorCheck.Checked;
end;

function TEditorConfigHLForm.getSymbFontColor: TColor;
begin
  Result:=SymbFontColorBox.Selected;
end;

function TEditorConfigHLForm.getSymbFontStyles: TFontStyles;
begin
  case SymbFontStyleBox.ItemIndex of
    0: Result:=TFontStyles([]);
    1: Result:=[fsBold];
    2: Result:=[fsItalic];
    3: Result:=[fsBold,fsItalic];
  end;
end;

// asmcom
function TEditorConfigHLForm.getAsmcomFontColor: TColor;
begin
  Result:=AsmcomFontColorBox.Selected;
end;

function TEditorConfigHLForm.getAsmcomFontStyles: TFontStyles;
begin
  case AsmcomFontStyleBox.ItemIndex of
    0: Result:=TFontStyles([]);
    1: Result:=[fsBold];
    2: Result:=[fsItalic];
    3: Result:=[fsBold,fsItalic];
  end;
end;

function TEditorConfigHLForm.getAsmcomBkgColorCheck: boolean;
begin
  Result:=AsmcomBkgColorCheck.Checked;
end;

function TEditorConfigHLForm.getAsmcomBkgColorBox: TColor;
begin
  Result:=AsmcomBkgColorBox.Selected;
end;

// reg
function TEditorConfigHLForm.getRegBkgColorBox: TColor;
begin
  Result:=RegBkgColorBox.Selected;
end;

function TEditorConfigHLForm.getRegBkgColorCheck: boolean;
begin
  Result:=RegBkgColorCheck.Checked;
end;

function TEditorConfigHLForm.getRegFontColor: TColor;
begin
  Result:=RegFontColorBox.Selected;
end;

function TEditorConfigHLForm.getRegFontStyles: TFontStyles;
begin
  case RegFontStyleBox.ItemIndex of
    0: Result:=TFontStyles([]);
    1: Result:=[fsBold];
    2: Result:=[fsItalic];
    3: Result:=[fsBold,fsItalic];
  end;
end;

// num
function TEditorConfigHLForm.getNumBkgColorBox: TColor;
begin
  Result:=NumBkgColorBox.Selected;
end;

function TEditorConfigHLForm.getNumBkgColorCheck: boolean;
begin
  Result:=NumBkgColorCheck.Checked;
end;

function TEditorConfigHLForm.getNumFontColor: TColor;
begin
  Result:=NumFontColorBox.Selected;
end;

function TEditorConfigHLForm.getNumFontStyles: TFontStyles;
begin
  case NumFontStyleBox.ItemIndex of
    0: Result:=TFontStyles([]);
    1: Result:=[fsBold];
    2: Result:=[fsItalic];
    3: Result:=[fsBold,fsItalic];
  end;
end;

end.

