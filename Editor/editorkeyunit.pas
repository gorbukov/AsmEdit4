unit EditorKeyUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8,
  EditorUnit,
  SourceTextUnit;

// клавиши управления курсором
// одиночное нажатие - движение курсора
// +Shift - выделение текста
// +Ctrl  - управление окном просмотра без движения курсора
procedure Editor_Cursor_Left (var Key: Word; Shift: TShiftState);
procedure Editor_Cursor_Up   (var Key: Word; Shift: TShiftState);
procedure Editor_Cursor_Right(var Key: Word; Shift: TShiftState);
procedure Editor_Cursor_Down (var Key: Word; Shift: TShiftState);

procedure Editor_Cursor_Home (var Key: Word; Shift: TShiftState);
procedure Editor_Cursor_End  (var Key: Word; Shift: TShiftState);

procedure Editor_Cursor_PgUp (var Key: Word; Shift: TShiftState);
procedure Editor_Cursor_PgDn (var Key: Word; Shift: TShiftState);

procedure Editor_Cursor_Del (var Key: Word; Shift: TShiftState);
procedure Editor_Cursor_BkSp(var Key: Word; Shift: TShiftState);

procedure Editor_Cursor_Ins (var Key: Word; Shift: TShiftState);

procedure Editor_Cursor_Enter(var Key: Word; Shift: TShiftState);

procedure Editor_ClipB_Copy  (var Key: Word; Shift: TShiftState);
procedure Editor_ClipB_Paste (var Key: Word; Shift: TShiftState);
procedure Editor_ClipB_Cut   (var Key: Word; Shift: TShiftState);

procedure Editor_Key_A       (var Key: Word; Shift: TShiftState);
procedure Editor_Key_Y       (var Key: Word; Shift: TShiftState);

procedure Editor_Crey_Plus   (var Key: Word; Shift: TShiftState);
procedure Editor_Crey_Minus  (var Key: Word; Shift: TShiftState);

procedure Editor_Tab         (var {%H-}Key: Word; {%H-}Shift: TShiftState);

implementation

uses MainUnit, EditorConfigUnit;

// курсор влево
procedure Editor_Cursor_Left(var Key: Word; Shift: TShiftState);
var
  Shft: TShiftState;
begin
  if Shift=[] then         // единоличное нажатие
    begin
      Editor.SourceText.TextSelect:=false;
      Editor.SourceText.FirstLineVisible:=Editor.SourceText.FirstLineCopy;
      Editor.SourceText.FirstCharVisible:=Editor.SourceText.FirstCharCopy;

      if Editor.SourceText.CursorX>Editor.SourceText.FirstCharVisible+
                                   Editor.EditorConfigForm.CursorHorView.Position-1 then
         Editor.SourceText.CursorX:=Editor.SourceText.CursorX-1
      else
        begin
          if Editor.SourceText.FirstCharVisible>1 then Editor.SourceText.FirstCharVisible:=Editor.SourceText.FirstCharVisible-1;
          if Editor.SourceText.CursorX>0 then Editor.SourceText.CursorX:=Editor.SourceText.CursorX-1;
        end;
      Editor.SourceText.FirstLineCopy:=Editor.SourceText.FirstLineVisible;
      Editor.SourceText.FirstCharCopy:=Editor.SourceText.FirstCharVisible;
    end
  else
  if ssAlt in Shift then // нажатие с Alt
    begin
       Editor.TokenLeft;
    end
  else
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin
       Editor.CursorToLeftToken;
      //if Editor.SourceText.FirstCharVisible>1 then Editor.SourceText.FirstCharVisible:=Editor.SourceText.FirstCharVisible-1;
    end
  else
  if ssShift in Shift then // нажатие с Shift
    begin
      Shft:=[];
      if Editor.SourceText.TextSelect then
        begin // существующее выделение
          Editor_Cursor_Left(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end
      else
        begin // новое выделение
          Editor.MouseDownX:=Editor.SourceText.CursorX+1;
          Editor.MouseDownY:=Editor.SourceText.CursorY;
          Editor_Cursor_Left(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end;
    end;

  Key:=0;
end;

// курсор вверх
procedure Editor_Cursor_Up(var Key: Word; Shift: TShiftState);
var
  Shft: TShiftState;
begin
  if Shift=[] then         // единоличное нажатие
    begin
      Editor.SourceText.TextSelect:=false;

      Editor.SourceText.FirstLineVisible:=Editor.SourceText.FirstLineCopy;
      Editor.SourceText.FirstCharVisible:=Editor.SourceText.FirstCharCopy;

      if Editor.SourceText.CursorY>Editor.SourceText.FirstLineVisible+Editor.EditorConfigForm.CursorVertView.Position then Editor.SourceText.CursorY:=Editor.SourceText.CursorY-1
      else
        begin
          if Editor.SourceText.FirstLineVisible>0 then Editor.SourceText.FirstLineVisible:=Editor.SourceText.FirstLineVisible-1;
          if Editor.SourceText.CursorY>0 then Editor.SourceText.CursorY:=Editor.SourceText.CursorY-1;
      end;

      Editor.SourceText.FirstLineCopy:=Editor.SourceText.FirstLineVisible;
      Editor.SourceText.FirstCharCopy:=Editor.SourceText.FirstCharVisible;
    end
  else
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin
      if Editor.SourceText.FirstLineVisible>0 then Editor.SourceText.FirstLineVisible:=Editor.SourceText.FirstLineVisible-1;
    end
  else
  if ssShift in Shift then // нажатие с Shift
    begin
      Shft:=[];
      if Editor.SourceText.TextSelect then
        begin // существующее выделение
          Editor_Cursor_Up(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end
      else
        begin // новое выделение
          Editor.MouseDownX:=Editor.SourceText.CursorX+1;
          Editor.MouseDownY:=Editor.SourceText.CursorY;
          Editor_Cursor_Up(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end;
    end;

  Key:=0;
end;

// курсор вправо
procedure Editor_Cursor_Right(var Key: Word; Shift: TShiftState);
var
  Shft: TShiftState;
begin
  if Shift=[] then         // единоличное нажатие
    begin
      Editor.SourceText.TextSelect:=false;

      Editor.SourceText.FirstLineVisible:=Editor.SourceText.FirstLineCopy;
      Editor.SourceText.FirstCharVisible:=Editor.SourceText.FirstCharCopy;

      Editor.SourceText.CursorX:=Editor.SourceText.CursorX+1;
      if Editor.SourceText.CursorX>Editor.SourceText.FirstCharVisible+
                                   Editor.ColCount-2-
                                   Editor.EditorConfigForm.CursorHorView.Position then
         Editor.SourceText.FirstCharVisible:=Editor.SourceText.FirstCharVisible+1;

      Editor.SourceText.FirstLineCopy:=Editor.SourceText.FirstLineVisible;
      Editor.SourceText.FirstCharCopy:=Editor.SourceText.FirstCharVisible;
    end
  else
  if ssAlt in Shift then // нажатие с Alt
    begin
       Editor.TokenRight;
    end
  else
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin
       Editor.CursorToRightToken;
     // Editor.SourceText.FirstCharVisible:=Editor.SourceText.FirstCharVisible+1;
    end
  else
  if ssShift in Shift then // нажатие с Shift
    begin
      Shft:=[];
      if Editor.SourceText.TextSelect then
        begin // существующее выделение
          Editor_Cursor_Right(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end
      else
        begin // новое выделение
          Editor.MouseDownX:=Editor.SourceText.CursorX;
          Editor.MouseDownY:=Editor.SourceText.CursorY;
          Editor_Cursor_Right(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end;
    end;

  Key:=0;
end;

// курсор вниз
procedure Editor_Cursor_Down(var Key: Word; Shift: TShiftState);
var
  Shft: TShiftState;
begin
  if Shift=[] then         // единоличное нажатие
    begin
      Editor.SourceText.TextSelect:=false;

      Editor.SourceText.FirstLineVisible:=Editor.SourceText.FirstLineCopy;
      Editor.SourceText.FirstCharVisible:=Editor.SourceText.FirstCharCopy;

      Editor.SourceText.CursorY:=Editor.SourceText.CursorY+1;
      if Editor.SourceText.CursorY>Editor.SourceText.FirstLineVisible+
                                   Editor.RowCount-
                                   Editor.EditorConfigForm.CursorVertView.Position-1 then
        Editor.SourceText.FirstLineVisible:=Editor.SourceText.FirstLineVisible+1;

      Editor.SourceText.FirstLineCopy:=Editor.SourceText.FirstLineVisible;
      Editor.SourceText.FirstCharCopy:=Editor.SourceText.FirstCharVisible;
    end
  else
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin
      Editor.SourceText.FirstLineVisible:=Editor.SourceText.FirstLineVisible+1;
    end
  else
  if ssShift in Shift then // нажатие с Shift
    begin
      Shft:=[];
      if Editor.SourceText.TextSelect then
        begin // существующее выделение
          Editor_Cursor_Down(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end
      else
        begin // новое выделение
          Editor.MouseDownX:=Editor.SourceText.CursorX;
          Editor.MouseDownY:=Editor.SourceText.CursorY;
          Editor_Cursor_Down(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end;
    end;

  Key:=0;
end;

// Home
procedure Editor_Cursor_Home(var Key: Word; Shift: TShiftState);
var
  Shft: TShiftState;
  str:string;
begin
  if Shift=[] then         // единоличное нажатие
    begin
      if Editor.SourceText.CursorY<Editor.SourceText.Count then
        str:=Editor.SourceText.GetLineStr(Editor.SourceText.CursorY)
      else str:='';

      if Editor.SourceText.CursorX=0 then
        While (UTF8Length(str)>Editor.SourceText.CursorX) and (UTF8Length(str)<>0) and
               (UTF8Copy(str, Editor.SourceText.CursorX+1, 1)=' ') do Editor_Cursor_Right(Key, [])
      else
         begin
           Editor.SourceText.CursorX:=0;
           Editor.SourceText.FirstCharVisible:=1;
         end;

      Editor.SourceText.FirstCharCopy:=Editor.SourceText.FirstCharVisible;
    end
  else
  if ssShift in Shift then // нажатие с Shift
    begin
      Shft:=Shift - [ssShift];
      if Editor.SourceText.TextSelect then
        begin // существующее выделение
          Editor_Cursor_Home(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end
      else
        begin // новое выделение
          Editor.MouseDownX:=Editor.SourceText.CursorX+1;
          Editor.MouseDownY:=Editor.SourceText.CursorY;
          Editor_Cursor_Home(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end;
    end
  else
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin
      Editor.SourceText.TextSelect:=false;
      Editor.SourceText.CursorY:=0;
      Editor.SourceText.CursorX:=0;
      Editor.SourceText.FirstCharVisible:=1;
      Editor.SourceText.FirstLineVisible:=0;
      Editor.SourceText.FirstLineCopy:=Editor.SourceText.FirstLineVisible;
      Editor.SourceText.FirstCharCopy:=Editor.SourceText.FirstCharVisible;
    end;

  Key:=0;
end;

// End
procedure Editor_Cursor_End(var Key: Word; Shift: TShiftState);
var
  Shft: TShiftState;
  str:string;
begin
  if Shift=[] then         // единоличное нажатие
    begin
      if Editor.SourceText.CursorY<Editor.SourceText.Count then
         str:=Editor.SourceText.GetLineStr(Editor.SourceText.CursorY)
      else str:='';
      if (UTF8Length(str)<>0) then
        begin
          While (UTF8Length(str)<Editor.SourceText.CursorX+1) do Editor_Cursor_Left(Key{%H-}, []);
          While (UTF8Length(str)>Editor.SourceText.CursorX) do Editor_Cursor_Right(Key, []);
        end
      else
        begin
          Editor.SourceText.CursorX:=0;
          Editor.SourceText.FirstCharVisible:=1;
        end;
    end
  else
  if ssShift in Shift then // нажатие с Shift
    begin
      Shft:=Shift - [ssShift];
      if Editor.SourceText.TextSelect then
        begin // существующее выделение
          Editor_Cursor_End(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end
      else
        begin // новое выделение
          Editor.MouseDownX:=Editor.SourceText.CursorX;
          Editor.MouseDownY:=Editor.SourceText.CursorY;
          Editor_Cursor_End(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end;
    end
  else
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin
      Editor.SourceText.TextSelect:=false;
      Editor.SourceText.CursorY:=Editor.SourceText.Count-1;
      Editor.SourceText.CursorX:=0;
      Editor.SourceText.FirstCharVisible:=1;
      Editor.SourceText.FirstLineVisible:=Editor.SourceText.CursorY-Editor.RowCount + Editor.EditorConfigForm.CursorVertView.Position;
      Editor.SourceText.FirstLineCopy:=Editor.SourceText.FirstLineVisible;
      Editor.SourceText.FirstCharCopy:=Editor.SourceText.FirstCharVisible;
    end;

  Key:=0;
end;

procedure Editor_Cursor_PgUp(var Key: Word; Shift: TShiftState);
var
  Shft: TShiftState;
begin
  if Shift=[] then         // единоличное нажатие
    begin
      if Editor.SourceText.FirstLineVisible>Editor.RowCount-1 then
          begin
            Editor.SourceText.TextSelect:=false;
            Editor.SourceText.CursorY:=Editor.SourceText.CursorY-Editor.RowCount;
            Editor.SourceText.FirstLineVisible:=Editor.SourceText.FirstLineVisible-Editor.RowCount;
            Editor.SourceText.FirstLineCopy:=Editor.SourceText.FirstLineVisible;
            Editor.SourceText.FirstCharCopy:=Editor.SourceText.FirstCharVisible;
          end
        else
          begin
            Editor.SourceText.TextSelect:=false;
            Editor.SourceText.CursorY:=0;
            Editor.SourceText.FirstLineVisible:=0;
            Editor.SourceText.FirstLineCopy:=Editor.SourceText.FirstLineVisible;
            Editor.SourceText.FirstCharCopy:=Editor.SourceText.FirstCharVisible;
          end;
    end
  else
  if ssShift in Shift then // нажатие с Shift
    begin
      Shft:=Shift - [ssShift];
      if Editor.SourceText.TextSelect then
        begin // существующее выделение
          Editor_Cursor_PgUp(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end
      else
        begin // новое выделение
          Editor.MouseDownX:=Editor.SourceText.CursorX+1;
          Editor.MouseDownY:=Editor.SourceText.CursorY;
          Editor_Cursor_PgUp(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end;
    end
  else
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin
      if Editor.SourceText.FirstLineVisible>0 then
        Editor.SourceText.FirstLineVisible:=Editor.SourceText.FirstLineVisible-Editor.RowCount;
      if Editor.SourceText.FirstLineVisible<0 then Editor.SourceText.FirstLineVisible:=0;
    end;

  Key:=0;
end;

procedure Editor_Cursor_PgDn(var Key: Word; Shift: TShiftState);
var
  Shft: TShiftState;
begin
  if Shift=[] then         // единоличное нажатие
    begin
      Editor.SourceText.TextSelect:=false;
      Editor.SourceText.CursorY:=Editor.SourceText.CursorY+Editor.RowCount;
      Editor.SourceText.FirstLineVisible:=Editor.SourceText.FirstLineVisible+Editor.RowCount;
      Editor.SourceText.FirstLineCopy:=Editor.SourceText.FirstLineVisible;
      Editor.SourceText.FirstCharCopy:=Editor.SourceText.FirstCharVisible;
    end
  else
  if ssShift in Shift then // нажатие с Shift
    begin
      Shft:=Shift - [ssShift];
      if Editor.SourceText.TextSelect then
        begin // существующее выделение
          Editor_Cursor_PgDn(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end
      else
        begin // новое выделение
          Editor.MouseDownX:=Editor.SourceText.CursorX+1;
          Editor.MouseDownY:=Editor.SourceText.CursorY;
          Editor_Cursor_PgDn(Key, Shft);
          Editor.SourceText.TextSelect:=true;
          Editor.SelectionApply(Editor.SourceText.CursorX, Editor.SourceText.CursorY);
        end;
    end
  else
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin
      Editor.SourceText.FirstLineVisible:=Editor.SourceText.FirstLineVisible+Editor.RowCount;
    end;

  Key:=0;
end;

procedure Editor_Cursor_Del(var Key: Word; Shift: TShiftState);
var
  str, str1:string;
  i:integer;
begin
  if Shift=[] then         // единоличное нажатие
    begin
       Editor.SourceText.URList.AddItem;

      if Editor.SourceText.TextSelect then
        begin
          Editor.SelectionDel;
          Key:=0;
          exit;
        end;

      if Editor.SourceText.CursorY>=Editor.SourceText.Count then exit;

      str:=Editor.SourceText.GetLineStr(Editor.SourceText.CursorY);

      if Editor.SourceText.CursorX<UTF8Length(str) then UTF8Delete(str, Editor.SourceText.CursorX+1, 1)
      else
        begin
          while UTF8Length(str)<Editor.SourceText.CursorX do str:=str+' ';

          if Editor.SourceText.CursorY+1<Editor.SourceText.Count then
            begin
              str1:=Editor.SourceText.GetLineStr(Editor.SourceText.CursorY+1);
              i:=1; while (UTF8Copy(str1, i, 1)=' ') or (UTF8Copy(str1, i, 1)=#09) do i:=i+1;
              str:=str+ UTF8Copy(str1, i, UTF8Length(str1)-i+1);
              Editor.SourceText.Del(Editor.SourceText.CursorY+1);
            end;
        end;
      Editor.SourceText.SetLineStr(Editor.SourceText.CursorY, str);
      if MainForm.Menu_Edit_AutoFormat.Checked then MainForm.Menu_CodeFormatClick(nil);
    end
  else
  if ssShift in Shift then // нажатие с Shift
    begin

    end
  else
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin

    end;

  Key:=0;
end;

procedure Editor_Cursor_BkSp(var Key: Word; Shift: TShiftState);
var
  str, str1:string;

begin
  if Shift=[] then         // единоличное нажатие
    begin
      Editor.SourceText.URList.AddItem;

      if Editor.SourceText.TextSelect then Editor.SelectionDel;

      if (Editor.SourceText.CursorY>=Editor.SourceText.Count) then exit;

      if (Editor.SourceText.CursorX=0) and (Editor.SourceText.CursorY>0)then
        begin
          str:=Editor.SourceText.GetLineStr(Editor.SourceText.CursorY);
          str1:=Editor.SourceText.GetLineStr(Editor.SourceText.CursorY-1);
          str:=str1+str;
          Editor.SourceText.SetLineStr(Editor.SourceText.CursorY-1, str);
          Editor.SourceText.Del(Editor.SourceText.CursorY);
          Editor_Cursor_Up(Key{%H-}, []); //CursorUp;
          while Editor.SourceText.CursorX<UTF8Length(str1) do Editor_Cursor_Right(Key, []);
        end
      else
        begin
          str:=Editor.SourceText.GetLineStr(Editor.SourceText.CursorY);
          if Editor.SourceText.CursorX<=UTF8Length(str) then UTF8Delete(str, Editor.SourceText.CursorX, 1);

          Editor.SourceText.SetLineStr(Editor.SourceText.CursorY, str);
          Editor_Cursor_Left(Key, []); //CursorLeft;
        end;
    end
  else
  if ssShift in Shift then // нажатие с Shift
    begin

    end
  else
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin

    end;

  if MainForm.Menu_Edit_AutoFormat.Checked then MainForm.Menu_CodeFormatClick(nil);
  Key:=0;
end;

// Ins
procedure Editor_Cursor_Ins(var Key: Word; Shift: TShiftState);
begin
  if Shift=[] then         // единоличное нажатие
    begin
      Editor.InsMode:=not Editor.InsMode; // смена режима ввода
    end
  else
  if ssShift in Shift then // нажатие с Shift
    begin
      Editor.PasteFromClipBoard;          // вставить из буф обмена
    end
  else
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin
      Editor.CopyToClipBoard;             // копировать в буф обмена
    end;

  Key:=0;
end;

// Enter
procedure Editor_Cursor_Enter(var Key: Word; Shift: TShiftState);
var
  //Shft: TShiftState;
  str, str1:string;
begin
  if Shift=[] then         // единоличное нажатие
    begin
      Editor.SourceText.URList.AddItem;
      if Editor.SourceText.TextSelect then Editor.SelectionDel;

      if Editor.SourceText=nil then exit;

      if (Editor.SourceText.CursorY>=Editor.SourceText.Count) then exit;

      str:=Editor.SourceText.GetLineStr(Editor.SourceText.CursorY);
      if UTF8Length(str)>Editor.SourceText.CursorX+1 then
        begin
          str1:=UTF8Copy(str, Editor.SourceText.CursorX+1, UTF8Length(str)-Editor.SourceText.CursorX);
          Editor.SourceText.SetLineStr(Editor.SourceText.CursorY, UTF8Copy(str, 1, Editor.SourceText.CursorX));
        end else str1:='';
      Editor.SourceText.Ins(Editor.SourceText.CursorY+1, str1);
      Editor_Cursor_Down(Key{%H-}, []);
      Editor_Cursor_Home(Key{%H-}, []);
    end
  else
  if ssShift in Shift then // нажатие с Shift
    begin

    end
  else
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin

    end;

  Key:=0;
end;

procedure Editor_ClipB_Copy(var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin
      Editor.CopyToClipBoard;             // копировать в буф обмена
      Key:=0;
    end;
end;

procedure Editor_ClipB_Paste(var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then  // нажатие с Ctrl
    begin
      Editor.PasteFromClipBoard;          // вставить из буф обмена
      Key:=0;
    end;
end;

procedure Editor_ClipB_Cut(var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then  // нажатие с Ctrl
      begin
        Editor.CutToClipBoard;            // вырезать в буфер обмена
        Key:=0;
      end;
end;

// выделить весь текст
procedure Editor_Key_A(var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then  // нажатие с Ctrl
      begin
        Editor.SourceText.TextSelect:=true;

        Editor.SourceText.TextSelectSX:=0;
        Editor.SourceText.TextSelectSY:=0;

        Editor.SourceText.TextSelectLX:=0;
        Editor.SourceText.TextSelectLY:=Editor.SourceText.Count;

        Key:=0;
      end;
end;

// удалить текущую строку
procedure Editor_Key_Y(var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then  // нажатие с Ctrl
      begin
        Editor.SourceText.URList.AddItem;
        Editor.SourceText.Del(Editor.SourceText.CursorY);
        Key:=0;
      end;
end;

// Увеличить размер шрифта
procedure Editor_Crey_Plus(var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then  // нажатие с Ctrl
      begin
        Editor.EditorConfigForm.Editor_Text_Image.Canvas.Font.Size:=Editor.EditorConfigForm.Editor_Text_Image.Canvas.Font.Size+1;
        MainForm.setVisualParams;
        Key:=0;
      end;
end;

// Уменьшить размер шрифта
procedure Editor_Crey_Minus(var Key: Word; Shift: TShiftState);
begin
  if ssCtrl in Shift then  // нажатие с Ctrl
      begin
        if Editor.EditorConfigForm.Editor_Text_Image.Canvas.Font.Size>8 then
          Editor.EditorConfigForm.Editor_Text_Image.Canvas.Font.Size:=Editor.EditorConfigForm.Editor_Text_Image.Canvas.Font.Size-1;
        MainForm.setVisualParams;
        Key:=0;
      end;
end;

// tab
procedure Editor_Tab(var Key: Word; Shift: TShiftState);
var
  i:integer;
begin
  Editor.SourceText.URList.AddItem;
  i:=5- ((Editor.SourceText.CursorX) mod 5);
  if i=0 then i:=5;
  while i>0 do
    begin
      Editor.KeyPress(' ');
      i:=i-1;
    end;
  Key:=0;
end;

end.

