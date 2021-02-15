unit FormValueInitUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Buttons, StdCtrls, ComCtrls, ExtCtrls,
  Graphics, IniFiles, ColorBox, Menus;

procedure SaveFormValues(FRM:TForm; section:string; filename:string);
procedure LoadFormValues(FRM:TForm; section:string; filename:string);

implementation

// TComboBox
procedure ComboBoxSave(CP:TComboBox; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: fl.WriteInteger(section, CP.Name, CP.ItemIndex);
    2: fl.WriteString (section, CP.Name, CP.text);
  end;
end;

procedure ComboBoxLoad(CP:TComboBox; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: CP.ItemIndex:=fl.ReadInteger(section, CP.Name, -1);
    2: CP.text     :=fl.ReadString (section, CP.Name, '');
  end;
end;

// TEdit
procedure EditSave(CP:TEdit; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: exit;
    2: fl.WriteString (section, CP.Name, CP.text);
  end;
end;

procedure EditLoad(CP:TEdit; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: exit;
    2: CP.text:=fl.ReadString (section, CP.Name, '');
  end;
end;

// TLabeledEdit
procedure LabeledEditSave(CP:TLabeledEdit; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: exit;
    2: fl.WriteString (section, CP.Name, CP.text);
  end;
end;

procedure LabeledEditLoad(CP:TLabeledEdit; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: exit;
    2: CP.text:=fl.ReadString (section, CP.Name, '');
  end;
end;

// TTrackBar
procedure TrackBarSave(CP:TTrackBar; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: fl.WriteInteger(section, CP.Name, CP.Position);
  end;
end;

procedure TrackBarLoad(CP:TTrackBar; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: CP.Position:=fl.ReadInteger(section, CP.Name, 0);
  end;
end;

// TShape
procedure ShapeSave(CP:TShape; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: fl.WriteInt64(section, CP.Name, CP.Brush.Color);
  end;
end;

procedure ShapeLoad(CP:TShape; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: CP.Brush.Color:=fl.ReadInteger(section, CP.Name, clBtnFace);
  end;
end;

// TImage
procedure ImageSave(CP:TImage; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    10: begin
         fl.WriteInt64  (section,  CP.Name+'_BrushColor', CP.Canvas.Brush.Color);
         fl.WriteInt64  (section,  CP.Name+'_FontColor',  CP.Canvas.Font.Color);
         fl.WriteString (section,  CP.Name+'_FontName',   CP.Canvas.Font.Name);
         fl.WriteInteger(section,  CP.Name+'_FontSize',   CP.Canvas.Font.Size);
         fl.WriteInteger(section,  CP.Name+'_FontStyle',  Integer(CP.Canvas.Font.Style));
        end;
  end;
end;

procedure ImageLoad(CP:TImage; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    10: begin
             CP.Canvas.Brush.Color:=fl.ReadInteger(section,  CP.Name+'_BrushColor', clBtnFace);
             CP.Canvas.Font.Color:= fl.ReadInteger(section,  CP.Name+'_FontColor',  clBlack);
             CP.Canvas.Font.Name:=  fl.ReadString (section,  CP.Name+'_FontName',   'Courier New');
             CP.Canvas.Font.Size:=  fl.ReadInteger(section,  CP.Name+'_FontSize',   11);
             CP.Canvas.Font.Style:= TFontStyles (fl.ReadInteger(section,  CP.Name+'_FontStyle',  0));
            end;
  end;
end;

// TColorBox
procedure ColorBoxSave(CP:TColorBox; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: fl.WriteInt64(section, CP.Name, CP.Selected);
  end;
end;

procedure ColorBoxLoad(CP:TColorBox; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: CP.Selected:=fl.ReadInteger(section, CP.Name, clBtnFace);
  end;
end;

// TCheckBox
procedure CheckBoxSave(CP:TCheckBox; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: fl.WriteBool(section, CP.Name, CP.Checked);
  end;
end;

procedure CheckBoxLoad(CP:TCheckBox; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: CP.Checked:=fl.ReadBool(section, CP.Name, false);
  end;
end;

// TRadioButton
procedure RadioButtonSave(CP:TRadioButton; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: fl.WriteBool(section, CP.Name, CP.Checked);
  end;
end;

procedure RadioButtonLoad(CP:TRadioButton; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: CP.Checked:=fl.ReadBool(section, CP.Name, false);
  end;
end;

// TMenuItem
procedure MenuItemSave(CP:TMenuItem; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: fl.WriteBool(section, CP.Name, CP.Checked);
  end;
end;

procedure MenuItemLoad(CP:TMenuItem; section:string; fl:TIniFile);
begin
  case CP.Tag of
    0: exit;
    1: CP.Checked:=fl.ReadBool(section, CP.Name, false);
  end;
end;

// TListBox
procedure ListBoxSave(CP:TListBox; section:string; fl:TIniFile);
var
  i:integer;
begin
  if CP.Tag<>3 then exit;

  fl.WriteInteger (section, CP.Name+'_COUNT', CP.Items.Count);
  for i:=0 to CP.Items.Count-1 do
    begin
      fl.WriteString (section, CP.Name+'_'+inttostr(i), CP.Items.Strings[i]);
    end;
end;

procedure ListBoxLoad(CP:TListBox; section:string; fl:TIniFile);
var
  i:integer;
begin
  if CP.Tag<>3 then exit;

  CP.Items.Clear;
  for i:=0 to fl.ReadInteger (section, CP.Name+'_COUNT', 0)-1 do
    begin
      CP.Items.Add(fl.ReadString (section, CP.Name+'_'+inttostr(i), ''));
    end;
end;

// запись состояния элементов формы
procedure SaveFormValues(FRM: TForm; section:string; filename: string);
var
  i:integer;
  inif:TIniFile;
begin
  inif:=TIniFile.Create(filename);

  for i:=0 to FRM.ComponentCount-1 do
    case FRM.Components[i].ClassName of
      'TComboBox': ComboBoxSave(FRM.Components[i] as TComboBox, section, inif);
      'TEdit'       : EditSave    (FRM.Components[i] as TEdit,     section, inif);
      'TLabeledEdit': LabeledEditSave(FRM.Components[i] as TLabeledEdit, section, inif);
      'TTrackBar': TrackBarSave(FRM.Components[i] as TTrackBar, section, inif);
      'TShape'   : ShapeSave   (FRM.Components[i] as TShape,    section, inif);
      'TImage'   : ImageSave   (FRM.Components[i] as TImage,    section, inif);
      'TColorBox': ColorBoxSave(FRM.Components[i] as TColorBox, section, inif);
      'TCheckBox': CheckBoxSave(FRM.Components[i] as TCheckBox, section, inif);
      'TRadioButton': RadioButtonSave(FRM.Components[i] as TRadioButton, section, inif);
      'TMenuItem'   : MenuItemSave(FRM.Components[i] as TMenuItem, section, inif);
      'TListBox'    : ListBoxSave(FRM.Components[i] as TListBox, section, inif);
    end;

  inif.UpdateFile;
  inif.Free;
end;

// чтения состояния элементов формы
procedure LoadFormValues(FRM: TForm; section: string; filename: string);
var
  i:integer;
  inif:TIniFile;
begin
  inif:=TIniFile.Create(filename);

  for i:=0 to FRM.ComponentCount-1 do
    case FRM.Components[i].ClassName of
      'TComboBox': ComboBoxLoad(FRM.Components[i] as TComboBox, section, inif);
      'TEdit'       : EditLoad    (FRM.Components[i] as TEdit,     section, inif);
      'TLabeledEdit': LabeledEditLoad(FRM.Components[i] as TLabeledEdit, section, inif);
      'TTrackBar': TrackBarLoad(FRM.Components[i] as TTrackBar, section, inif);
      'TShape'   : ShapeLoad   (FRM.Components[i] as TShape,    section, inif);
      'TImage'   : ImageLoad   (FRM.Components[i] as TImage,    section, inif);
      'TColorBox': ColorBoxLoad(FRM.Components[i] as TColorBox, section, inif);
      'TCheckBox': CheckBoxLoad(FRM.Components[i] as TCheckBox, section, inif);
      'TRadioButton': RadioButtonLoad(FRM.Components[i] as TRadioButton, section, inif);
      'TMenuItem'   : MenuItemLoad(FRM.Components[i] as TMenuItem, section, inif);
      'TListBox'    : ListBoxLoad(FRM.Components[i] as TListBox, section, inif);
    end;

  inif.UpdateFile;
  inif.Free;
end;

end.

