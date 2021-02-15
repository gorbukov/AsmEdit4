unit EditorUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, LazUTF8,
  Clipbrd, StrUtils,
  FormValueInitUnit,
  EditorConfigUnit, EditorConfigHLUnit,
  SourceTextUnit, SourceLineUnit, UndoRedoUnit,
  TokensUnit,
  TextParserUnit, AsmTextParserUnit,
  AboutUnit;

type

  { TEditor }

  TEditor=class(TObject)
    private
      buttonPres:boolean;         // флаг нажатой кнопки мыши
      scrollInfoShowed:boolean;   // если истина - то было показано окно позиционирования
      TextImageMouseYPix:integer; // позиция указателя мыши в по вертикали

      TextImage:TImage;       // компонент для отрисовки
      ShadowBuff:TBitMap;     // буфер изображения поля редактора
      ShadowBuff2:TBitMap;    // второй буфер для отрисовки при показе позиционирования

      charPixStepX:integer;   // шаг символов редактора (BaseFont)
      charPixStepY:integer;

      num_width:integer;      // панель номеров строк: ширина панели в пикселах
      num_show_debug:boolean; // показывать отладочные строки в номерах строк

      Num_CharsCount:integer; // количество знаков в панели номеров строк
      scr_width:integer;      // панель скролинга: ширина панели в пикселах

      MouseInScroll:boolean;  // указатель мыши в области скролинга

      // процедуры отрисовки
      procedure GetMetrics;       // получение параметров редактора
      procedure PaintLineNum;     // отрисовка номеров строк
      procedure PaintText;        // отрисовка текста
      procedure PaintSelection;   // отрисовка выделения текста
      procedure PaintScrollPanel; // отрисовка панели скролинга
      procedure PaintScrollInfo;  // показ позиции скролинга
      procedure PaintCursor;      // отображение курсора

      // скрол редактора мышью
      procedure TextImageMouseWheelDown(Sender: TObject; {%H-}Shift: TShiftState;
        {%H-}MousePos: TPoint; var {%H-}Handled: Boolean);
      procedure TextImageMouseWheelUp(Sender: TObject; {%H-}Shift: TShiftState;
        {%H-}MousePos: TPoint; var {%H-}Handled: Boolean);
      // перемещение мыши в поле редактора
      procedure TextImageMouseMove(Sender: TObject; {%H-}Shift: TShiftState; X,
        Y: Integer);
      // клик в редакторе
      procedure TextImageClick(Sender: TObject);
      // старт выделения текста указателем мыши
      procedure TextImageMouseDown(Sender: TObject; {%H-}Button: TMouseButton;
        {%H-}Shift: TShiftState; X, Y: Integer);

      function  GetCursorPosX: integer;
      function  GetCursorPosY: integer;
      function  GetTextChanged: boolean;


    public
      // параметры показываемого окна редактора
      RowCount:integer;             // количество строк отображаемых в редакторе
      ColCount:integer;             // количество символов отображаемых в строке

      MouseCurX, MouseCurY:integer; // позиция курсора под указателем мыши
      InsMode:boolean;              // режим вставки
      MouseDownX, MouseDownY, MouseDownFL, MouseDownFC:integer;

      EditorConfigForm:TEditorConfigForm;     // настройки редактора
      EditorConfigHLForm:TEditorConfigHLForm; // настройки подсветки

      SourceText:TSourceText;              // редактируемый текст

      property CursorPosX:integer read GetCursorPosX;
      property CursorPosY:integer read GetCursorPosY;
      property Changed:boolean    read GetTextChanged;
      property Source:TSourceText read SourceText;

      procedure SelectionApply(MX, MY: integer); // обработка выделения

      constructor Create(Image:TImage);
      destructor  Free;

      procedure SetSourceText(ST:TSourceText); // установить исходный файл для редактирования
      procedure Refresh;       // перерисовать редактор

      // внешние события редактора
      procedure EditorKeyUp(var Key: Word; Shift: TShiftState);  // нажатие кнопок клавиатуры
      procedure KeyPress(Key: string);

      procedure CopyToClipBoard;     // копировать выделение в буфер обмена
      procedure CutToClipBoard;      // вырезать выделение в буфер обмена
      procedure PasteFromClipBoard;  // вставить текст из буфера обмена

      procedure TokenLeft;
      procedure TokenRight;
      procedure CursorToLeftToken;
      procedure CursorToRightToken;

      // вспомогательные процедуры
      procedure SelectionDel;                    // удаление выделенного текста
      function  GetTextSelection: TStringList;   // получить выделенный текст
      procedure InsertTextSelection(str:string); // вставить текст в позицию курсора

      procedure FindText; // диалог поиска
      procedure ReplaceText; // диалог замены
      procedure ReplaceDialogReplace(Sender: TObject); // процедура замены
      procedure FindDialogFind(Sender: TObject);  // процедура поиска диалога
      procedure DoFindText(ADialog: TFindDialog); // процедура поиска строки в тексте
  end;

implementation

uses MainUnit, EditorKeyUnit;
{ TEditor }

constructor TEditor.Create(Image: TImage);
begin
  // настройки редактора
  EditorConfigForm:=TEditorConfigForm.Create(MainForm);
  LoadFormValues(EditorConfigForm, 'EDITOR', app_conf_name);

  // настройки подсветки
  EditorConfigHLForm:=TEditorConfigHLForm.Create(MainForm);
  LoadFormValues(EditorConfigHLForm, 'HIGHLIGHT', app_conf_name);

  SourceText:=nil;

  TextImage:=TImage(Image);
  TextImage.OnMouseWheelDown:=@TextImageMouseWheelDown;
  TextImage.OnMouseWheelUp:=@TextImageMouseWheelUp;
  TextImage.OnMouseMove:=@TextImageMouseMove;
  TextImage.OnClick:=@TextImageClick;
  TextImage.OnMouseDown:=@TextImageMouseDown;

  ShadowBuff:=TBitMap.Create;
  ShadowBuff2:=TBitMap.Create;
  InsMode:=true;

  buttonPres:=false;

end;

destructor TEditor.Free;
begin
  SaveFormValues(EditorConfigHLForm, 'HIGHLIGHT', app_conf_name);

  SaveFormValues(EditorConfigForm,   'EDITOR',    app_conf_name);

  EditorConfigHLForm.Free;
  EditorConfigForm.Free;
  ShadowBuff.Free;
end;

// установить текст
procedure TEditor.SetSourceText(ST: TSourceText);
var
  TextParser:TTextParser;
begin
  SourceText:=ST;

  if SourceText=nil then
    begin
      TextImage.Canvas.Clear;
      exit;
    end;

  SourceText.OpenInEditor:=true;

  // перечитаем символы
  TextParser:=TTextParser(Editor.SourceText.TextParser);
  if (TextParser is TAsmTextParser) then TAsmTextParser(TextParser).ParseFileSymbols;

  Refresh;
end;

// флаг измененного текста (для вывода статуса)
function TEditor.GetTextChanged: boolean;
begin
  GetTextChanged:=SourceText.TextChange;
end;

// позиция X курсора
function TEditor.GetCursorPosX: integer;
begin
  if SourceText<>nil then
    GetCursorPosX:=SourceText.CursorX+1
    else GetCursorPosX:=0;
end;

// позиция Y курсора
function TEditor.GetCursorPosY: integer;
begin
  if SourceText<>nil then
    GetCursorPosY:=SourceText.CursorY+1
    else GetCursorPosY:=0;
end;

// нажатие кнопок клавиатуры
procedure TEditor.EditorKeyUp(var Key: Word; Shift: TShiftState);
begin
  if SourceText=nil then exit;

  case Key of
    08: Editor_Cursor_BkSp (Key, Shift); // BackSpace     (            )
    09: Editor_Tab         (Key, Shift); // Tab           (            )
    13: Editor_Cursor_Enter(Key, Shift); // Enter         (            )
    33: Editor_Cursor_PgUp (Key, Shift); // PgUp          (+Ctrl +Shift)
    34: Editor_Cursor_PgDn (Key, Shift); // PgDn          (+Ctrl +Shift)
    35: Editor_Cursor_End  (Key, Shift); // End           (+Ctrl +Shift)
    36: Editor_Cursor_Home (Key, Shift); // Home          (+Ctrl +Shift)
    37: Editor_Cursor_Left (Key, Shift); // курсор влево  (+Ctrl +Shift +Alt)
    38: Editor_Cursor_Up   (Key, Shift); // курсор вверх  (+Ctrl +Shift)
    39: Editor_Cursor_Right(Key, Shift); // курсор вправо (+Ctrl +Shift +Alt)
    40: Editor_Cursor_Down (Key, Shift); // курсор вниз   (+Ctrl +Shift)
    45: Editor_Cursor_Ins  (Key, Shift); // Ins           (            )
    46: Editor_Cursor_Del  (Key, Shift); // Del           (            )

    65: Editor_Key_A       (Key, Shift); // A             +Ctrl
//    67: Editor_ClipB_Copy  (Key, Shift); // C              +Ctrl
//    86: Editor_ClipB_Paste (Key, Shift); // V              +Ctrl
//    88: Editor_ClipB_Cut   (Key, Shift); // X              +Ctrl
    89: Editor_Key_Y       (Key, Shift); // Y             +Ctrl
   107: Editor_Crey_Plus   (Key, Shift); // Серый плюс    +Ctrl
   109: Editor_Crey_Minus  (Key, Shift); // Серый минус   +Ctrl
  end;

  // любую необработанную комбинацию с Ctrl или Alt, обнуляем
//  if (Key<>0) and ((ssAlt in Shift) or  (ssCtrl in Shift)) then Key:=0
//  else
  Refresh;

end;

//нажатие кнопки символа
procedure TEditor.KeyPress(Key: string);
var
  str:string;
  tmp:word;

begin
  if SourceText=nil then exit;

  SourceText.URList.AddItem;

  if SourceText.TextSelect then SelectionDel;

  while SourceText.CursorY>=SourceText.Count do SourceText.Add('');

  str:=SourceText.GetLineStr(SourceText.CursorY);
  while SourceText.CursorX>UTF8Length(str) do str:=str+' ';

  if not InsMode then UTF8Delete(str, SourceText.CursorX+1, 1);
  UTF8Insert(Key, str, SourceText.CursorX+1);

  SourceText.SetLineStr(SourceText.CursorY, str);
  Editor_Cursor_Right(tmp{%H-}, []);

  // автоформат
  if MainForm.Menu_Edit_AutoFormat.Checked then MainForm.Menu_CodeFormatClick(nil)
  else
  Refresh;
end;

// копировать выделение в буфер обмена
procedure TEditor.CopyToClipBoard;
begin
   Clipboard.SetTextBuf(PChar(TStringList(Editor.GetTextSelection).Text));
   Refresh;
end;

// вырезать выделение в буфер обмена
procedure TEditor.CutToClipBoard;
begin
  SourceText.URList.AddItem;

  CopyToClipBoard;
  SelectionDel;

  Refresh;
end;

// вставить текст из буфера обмена
procedure TEditor.PasteFromClipBoard;
begin
  SourceText.URList.AddItem;

  InsertTextSelection(Clipboard.AsText);

  Refresh;
end;

procedure TEditor.TokenLeft;
var
  i, t:integer;
  str:string;
  key:word;
  tokens:TTokenList;
begin
  Key:=0;
  str:=SourceText.GetLineStr(SourceText.CursorY);

  t:=0;
  // найдем начало токена
  tokens:=SourceText.GetLineTokens(SourceText.CursorY);
  for i:=0 to tokens.Count-1 do
    if (TToken(tokens.GetToken(i)).startPos<=SourceText.CursorX+1) and
      (TToken(tokens.GetToken(i)).startPos+TToken(tokens.GetToken(i)).tokLen>=SourceText.CursorX+1)
      then
        begin
          t:=TToken(tokens.GetToken(i)).startPos;
          break;
        end;

  while t>=0 do
    if UTF8Copy(str, t, 1)=' ' then
      begin
        UTF8Delete(str, t, 1);
        SourceText.SetLineStr(SourceText.CursorY, str);
        Editor_Cursor_Left(Key, []);
        exit;
      end
    else t:=t-1;
end;

procedure TEditor.TokenRight;
var
  i, t:integer;
  str:string;
  key:word;
  tokens:TTokenList;
begin
  Key:=0;
  str:=SourceText.GetLineStr(SourceText.CursorY);

   t:=0;
  // найдем начало токена
  tokens:=SourceText.GetLineTokens(SourceText.CursorY);
  for i:=0 to tokens.Count-1 do
    if (TToken(tokens.GetToken(i)).startPos<=SourceText.CursorX+1) and
      (TToken(tokens.GetToken(i)).startPos+TToken(tokens.GetToken(i)).tokLen>=SourceText.CursorX+1)
      then
        begin
          t:=TToken(tokens.GetToken(i)).startPos;
          break;
        end;

  UTF8Insert(' ', str, t);
  SourceText.SetLineStr(SourceText.CursorY, str);
  Editor_Cursor_Right(Key, []);
  exit;
end;

procedure TEditor.CursorToLeftToken;
var
  i, t:integer;
  key:word;
  tokens:TTokenList;
begin
  Key:=0;

   t:=0;
  // найдем начало токена
  tokens:=SourceText.GetLineTokens(SourceText.CursorY);
  for i:=0 to tokens.Count-1 do
    if (TToken(tokens.GetToken(i)).startPos<=SourceText.CursorX+1) and
      (TToken(tokens.GetToken(i)).startPos+TToken(tokens.GetToken(i)).tokLen-1>=SourceText.CursorX+1)
      then
        begin
          t:=i;
          break;
        end else t:=i+1;

  t:=t-1;
  if t<0 then t:=0;
  while SourceText.CursorX+1>TToken(tokens.GetToken(t)).startPos do Editor_Cursor_Left(Key, []);
end;

procedure TEditor.CursorToRightToken;
var
  i, t:integer;
  key:word;
  tokens:TTokenList;
begin
  Key:=0;

  t:=-1;
  // найдем начало токена
  tokens:=SourceText.GetLineTokens(SourceText.CursorY);
  for i:=0 to tokens.Count-1 do
    if (TToken(tokens.GetToken(i)).startPos<=SourceText.CursorX+1) and
      (TToken(tokens.GetToken(i)).startPos+TToken(tokens.GetToken(i)).tokLen-1>=SourceText.CursorX+1)
      then
        begin
          t:=i;
          break;
        end;
  t:=t+1;
  if t+1>=tokens.Count then t:=tokens.Count-1;

  while SourceText.CursorX+1<TToken(tokens.GetToken(t)).startPos do Editor_Cursor_Right(Key, []);
end;

// скрол текста колесом мыши вверх
procedure TEditor.TextImageMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  if SourceText=nil then exit;

  if SourceText.FirstLineVisible>5 then SourceText.FirstLineVisible:=SourceText.FirstLineVisible-5
                        else SourceText.FirstLineVisible:=0;
  Refresh;
end;

// скрол текста колесом мыши вниз
procedure TEditor.TextImageMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
 if SourceText=nil then exit;

 SourceText.FirstLineVisible:=SourceText.FirstLineVisible+5;
 Refresh;
end;

// движение указателя мыши
procedure TEditor.TextImageMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  oldMouseCurX, oldMouseCurY:integer;
begin
  if SourceText=nil then exit;

  // навели указатель на панель позиционирования (скролл)

  if (x>TextImage.Width-scr_width) and (x<TextImage.Width-5) then
    begin
      MouseInScroll:=true;
      TextImageMouseYPix:=y;
      if scrollInfoShowed then PaintScrollInfo; // покажем окно позиционирования
      buttonPres:=false;
      exit;
    end else MouseInScroll:=false;

  // если был показ области позиционирования - восстановим вид редактора
  if scrollInfoShowed then
    begin
      //Refresh;
      TextImage.Picture.Bitmap.Assign(ShadowBuff);
      scrollInfoShowed:=false;
    end;

  if x-num_width<0 then x:=num_width;

  oldMouseCurX:=MouseCurX;
  oldMouseCurY:=MouseCurY;

  MouseCurX:=SourceText.FirstCharVisible-1+((x-num_width) div charPixStepX);
  MouseCurY:=SourceText.FirstLineVisible+(y div charPixStepY);

  if (oldMouseCurX=MouseCurX) and (oldMouseCurY=MouseCurY) then exit;

  if not buttonPres then exit;

  SelectionApply(MouseCurX, MouseCurY);

  if not SourceText.TextSelect then exit;

  PaintText;
  PaintScrollPanel;

  TextImage.Picture.Bitmap.Assign(ShadowBuff);

end;

// позиционирование курсора по клику мышки
procedure TEditor.TextImageClick(Sender: TObject);
begin
  InputEditor:=true; // перенаправление ввода для MainForm
  MainForm.CenterWorkPanel.SetFocus;

  if SourceText=nil then exit;

   buttonPres:=false;

   SourceText.CursorX:=MouseCurX;
   SourceText.CursorY:=MouseCurY;

   if MouseInScroll and (not scrollInfoShowed) then
     begin
//      TextImageMouseYPix:=y;
      PaintScrollInfo; // покажем окно позиционирования
      buttonPres:=false;
      exit;
     end
   else
   // показано окно позиционирования, выполним переход к строке
   if scrollInfoShowed then
     begin
       SourceText.CursorY:=(TextImageMouseYPix*SourceText.Count) div TextImage.Height;
       SourceText.CursorX:=0;

       MouseDownX:=0;
       MouseDownY:=SourceText.CursorY;

       SourceText.FirstLineVisible:=SourceText.CursorY;
       SourceText.FirstCharVisible:=1;
     end;

   SourceText.FirstLineCopy:=SourceText.FirstLineVisible;
   SourceText.FirstCharCopy:=SourceText.FirstCharVisible;

   SelectionApply(SourceText.CursorX, SourceText.CursorY);

   MainForm.StatusEditor;  // вывод статуса редактора

   Refresh;
end;

// выделение текста мышью
procedure TEditor.TextImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if SourceText=nil then exit;

  if x-num_width<0 then x:=num_width;

  if (Button=mbLeft) then
    begin
      MouseDownX:=SourceText.FirstCharVisible-1+((x-num_width) div charPixStepX);
      MouseDownY:=SourceText.FirstLineVisible+(y div charPixStepY);

      MouseDownFC:=SourceText.FirstCharVisible;
      MouseDownFL:=SourceText.FirstLineVisible;

      buttonPres:=true;
    end
  else
    if (Button=mbRight) then
    begin
      SourceText.CursorX:=SourceText.FirstCharVisible-1+((x-num_width) div charPixStepX);
      SourceText.CursorY:=SourceText.FirstLineVisible+(y div charPixStepY);
      Refresh;
      MainForm.ConstructEditorPopUpMenu;
    end;
end;

// обработка выделения текста
procedure TEditor.SelectionApply(MX, MY:integer);
begin
   if (MX=MouseDownX) and (MY=MouseDownY) then SourceText.TextSelect:=false
     else
     begin
       SourceText.TextSelect:=true;
       if MY<MouseDownY then // прямое
         begin
           SourceText.TextSelectSX:=MX; SourceText.TextSelectSY:=MY;
           SourceText.TextSelectLX:=MouseDownX; SourceText.TextSelectLY:=MouseDownY;
         end;
       if MY>MouseDownY then // обратное
         begin
           SourceText.TextSelectLX:=MX; SourceText.TextSelectLY:=MY;
           SourceText.TextSelectSX:=MouseDownX; SourceText.TextSelectSY:=MouseDownY;
         end;
       if MY=MouseDownY then // прямое
         if MX>MouseDownX then
            begin
              SourceText.TextSelectLX:=MX; SourceText.TextSelectLY:=MY;
              SourceText.TextSelectSX:=MouseDownX; SourceText.TextSelectSY:=MouseDownY;
            end
          else                     // обратное
            begin
              SourceText.TextSelectSX:=MX; SourceText.TextSelectSY:=MY;
              SourceText.TextSelectLX:=MouseDownX; SourceText.TextSelectLY:=MouseDownY;
            end;
     end;
end;

// удаление выделенного текста
procedure TEditor.SelectionDel;
var
  i:integer;
  str, str2:string;
begin
  if SourceText=nil then exit;

  SourceText.URList.AddItem;

  if not SourceText.TextSelect then exit;

  if SourceText.TextSelectSY=SourceText.TextSelectLY then
    begin // удаление в одной строке
      str:=SourceText.GetLineStr(SourceText.TextSelectSY);
      UTF8Delete(str, SourceText.TextSelectSX+1, SourceText.TextSelectLX-SourceText.TextSelectSX+1);
      SourceText.SetLineStr(SourceText.TextSelectSY, str);
    end
  else
  begin
    // первая строка
    str:=SourceText.GetLineStr(SourceText.TextSelectSY);
    UTF8Delete(str, SourceText.TextSelectSX+1, UTF8Length(str)-SourceText.TextSelectSX+1);

    // промежуточные строки
    for i:=SourceText.TextSelectSY+1 to SourceText.TextSelectLY-1 do SourceText.Del(SourceText.TextSelectSY+1);

    // последняя строка
    str2:=SourceText.GetLineStr(SourceText.TextSelectSY+1);
    str:=str+UTF8Copy(str2, SourceText.TextSelectLX+2,
                              UTF8Length(str2)-SourceText.TextSelectLX);
    SourceText.SetLineStr(SourceText.TextSelectSY, str);
    SourceText.Del(SourceText.TextSelectSY+1);
  end;

  // позиционирование курсора и области просмотра
   SourceText.CursorX:=SourceText.TextSelectSX;
   SourceText.CursorY:=SourceText.TextSelectSY;
   if SourceText.FirstCharVisible>SourceText.TextSelectSX+1 then SourceText.FirstCharVisible:=SourceText.TextSelectSX+1;
   if SourceText.FirstLineVisible+1>SourceText.Count then SourceText.FirstLineVisible:=SourceText.Count-1;
   SourceText.TextSelect:=false;
end;

// получить выделенный текст
function TEditor.GetTextSelection: TStringList;
var
  res:TStringList;
  i:integer;
  str:string;
begin

  res:=TStringList.Create;
  GetTextSelection:=res;

  if SourceText=nil then exit;

  if not SourceText.TextSelect then exit;

  // первая строка
  str:=SourceText.GetLineStr(SourceText.TextSelectSY);

  // если строка единственная
  if SourceText.TextSelectSY=SourceText.TextSelectLY then
    begin
      str:=UTF8Copy(str, SourceText.TextSelectSX+1, SourceText.TextSelectLX-SourceText.TextSelectSX);
      res.Add(str);
      exit;
    end;

  str:=UTF8Copy(str, SourceText.TextSelectSX+1, UTF8Length(str)-SourceText.TextSelectSX+1);
  res.Add(str);
  // промежуточные строки
  for i:=SourceText.TextSelectSY+1 to SourceText.TextSelectLY-1 do
    res.Add(SourceText.GetLineStr(i));

  // последняя строка
  str:=SourceText.GetLineStr(SourceText.TextSelectLY);
  str:=UTF8Copy(str, 1, SourceText.TextSelectLX);
  res.Add(str);
end;

// вставить текст в позицию курсора
procedure TEditor.InsertTextSelection(str: string);
var
  res:TStringList;
  i, pos:integer;
  str0:string;
  ostr:string;
  estr:string;
  tmp:word;
begin
  if SourceText=nil then exit;

  SourceText.URList.AddItem;

  res:=TStringList.Create;
  res.Text:=str;
  if res.Count=0 then exit;

  SelectionDel;

  while SourceText.Count<=SourceText.CursorY do SourceText.Add('');
  str0:=SourceText.GetLineStr(SourceText.CursorY);

  while UTF8Length(str0)<SourceText.CursorX+1 do str0:=str0+' ';
  // символы до места вставки
  ostr:=UTF8Copy(str0, 1, SourceText.CursorX);
  ostr:=ostr+res.Strings[0];
  // символы после места вставки
  estr:=UTF8Copy(str0, SourceText.CursorX+1, UTF8Length(str0)-SourceText.CursorX+1);

  if res.Count=1 then // вставка из одной строки
    begin
      pos:=UTF8Length(ostr); // позиция курсора после вставки
      ostr:=ostr+estr;
      SourceText.SetLineStr(SourceText.CursorY, ostr);
      // сдвинем курсор
      while SourceText.CursorX<pos do Editor_Cursor_Right(tmp{%H-}, []);
    end
  else                // вставка нескольких строк
    begin
      SourceText.SetLineStr(SourceText.CursorY, ostr);

      // вставка промежуточных строк
      for i:=1 to res.Count-2 do
        begin
          SourceText.Ins(SourceText.CursorY+1, res.Strings[i]);
          Editor_Cursor_Down(tmp, []);
        end;

      // вставка последней строки
      str0:=res.Strings[res.Count-1];
      pos:=UTF8Length(str0); // позиция курсора после вставки
      ostr:=str0+estr;
      SourceText.Ins(SourceText.CursorY+1, ostr);
      Editor_Cursor_Down(tmp, []);
      // сдвинем курсор в ту сторону которую нужно
      while SourceText.CursorX<pos do Editor_Cursor_Right(tmp, []);
      while SourceText.CursorX>pos do Editor_Cursor_Left(tmp, []);
    end;

end;

// диалог поиска
procedure TEditor.FindText;
begin
  if SourceText=nil then exit;

   MainForm.FindDialog1.OnFind:=@FindDialogFind;
   MainForm.FindDialog1.Execute;
end;

// диалог замены
procedure TEditor.ReplaceText;
begin
 if SourceText=nil then exit;

  MainForm.ReplaceDialog1.OnFind:=@FindDialogFind;
  MainForm.ReplaceDialog1.OnReplace:=@ReplaceDialogReplace;

  MainForm.ReplaceDialog1.Execute;
end;

// процедура замены
procedure TEditor.ReplaceDialogReplace(Sender: TObject);
var
  sx, sy, ly:integer;
begin
  if frReplaceAll in TReplaceDialog(Sender).Options then // заменить все вхождения ReplaceDialog1
    begin
      DoFindText(Sender as TFindDialog);
      while SourceText.TextSelect do
         begin
           sx:=SourceText.TextSelectSX;
           sy:=SourceText.TextSelectSY;
           ly:=SourceText.TextSelectLY;
           InsertTextSelection(TReplaceDialog(Sender).ReplaceText);
           SourceText.TextSelectSX:=sx;
           SourceText.TextSelectLX:=sx+UTF8Length(TReplaceDialog(Sender).ReplaceText);
           SourceText.TextSelectSY:=sy;
           SourceText.TextSelectLY:=ly;
           SourceText.TextSelect:=true;
           DoFindText(Sender as TFindDialog);
         end;
    end
  else
    begin // заменять по одному
      DoFindText(Sender as TFindDialog);
      // и если что-то было найдено (длина выделенного текста больше 0) - то
      // заменяем выделенный текст на содержимое второго поля.
      sx:=SourceText.TextSelectSX;
      sy:=SourceText.TextSelectSY;
      ly:=SourceText.TextSelectLY;

      if SourceText.TextSelect then
        begin
          InsertTextSelection(TReplaceDialog(Sender).ReplaceText);
          SourceText.TextSelectSX:=sx;
          SourceText.TextSelectLX:=sx+UTF8Length(TReplaceDialog(Sender).ReplaceText);
          SourceText.TextSelectSY:=sy;
          SourceText.TextSelectLY:=ly;
          SourceText.TextSelect:=true;
        end;
    end;
  Refresh;
end;

// событие поиска поиска
procedure TEditor.FindDialogFind(Sender: TObject);
begin
  DoFindText(Sender as TFindDialog);
  Refresh;
end;

// процедура поиска строки в тексте
procedure TEditor.DoFindText(ADialog: TFindDialog);
var
 Found, StartPos: Integer;
 ToFind, Where : string;
 isReverse : Boolean;
 txt:TStringList;
 i, charpos:integer;

begin
  // текст в редакторе
  txt:=TStringList.Create;
  for i:=0 to SourceText.Count-1 do txt.Add(SourceText.GetLineStr(i));

// стандартный обработчик поиска
  ToFind := ADialog.FindText;
  Where := txt.Text;
  if not (frMatchCase in ADialog.Options) then
     begin
        ToFind := UTF8UpperCase(ToFind);
        Where := UTF8UpperCase(Where);
     end;

  isReverse := not (frDown in ADialog.Options);

  if SourceText.SelectionLength <> 0 then
     begin
        StartPos := SourceText.SelStart;
        if not isReverse then StartPos := StartPos + SourceText.SelectionLength;
     end
  else
     begin
        if isReverse then StartPos := UTF8Length(Where)
        else StartPos := 0;
     end;

  if isReverse then
     Found := UTF8Length(PChar(Where), RPos(ToFind, UTF8Copy(Where, 1, StartPos)))
  else
     Found := UTF8Pos(ToFind, Where, StartPos + 1);

  if Found <> 0 then
  begin
    // фрагмент текста найден
    // AControl.HideSelection := False;
    // AControl.SelStart := Found - 1;
    // AControl.SelLength := UTF8Length(ADialog.FindText);
    charpos:=0; i:=0;
    while charpos+UTF8Length(txt.Strings[i])<Found do
      begin
        charpos:=charpos+UTF8Length(txt.Strings[i])+2;
        i:=i+1;
      end;
    SourceText.TextSelect:=true;
    SourceText.TextSelectSY:=i;
    SourceText.TextSelectLY:=i;
    SourceText.TextSelectSX:=Found-charpos-1;
    SourceText.TextSelectLX:=SourceText.TextSelectSX+UTF8Length(ADialog.FindText)-1;
    SourceText.CursorX:=SourceText.TextSelectLX;
    SourceText.CursorY:=SourceText.TextSelectLY;
    // позиционирование окна просмотра
    if SourceText.TextSelectLX<ColCount then SourceText.FirstCharVisible:=1
                else SourceText.FirstCharVisible:=ColCount-SourceText.TextSelectLX+1;
    if SourceText.TextSelectSY<RowCount then SourceText.FirstLineVisible:=0
                else SourceText.FirstLineVisible:=SourceText.TextSelectSY+5-RowCount;
    if SourceText.FirstLineVisible<0 then SourceText.FirstLineVisible:=0;
  end
  else
    begin
       SourceText.TextSelect:=false;
       MessageDlg ('Строка ' + ADialog.FindText + ' не найдена!', mtConfirmation, [mbYes], 0);
    end;


  txt.free;
end;


// перерисовка редактора
procedure TEditor.Refresh;
var
 i, wx, wy:integer;
 str:string;
begin
  if SourceText=nil then
    begin // отрисовка при отсутствии текста
        // отрисуем фон панели номеров строк
      ShadowBuff.SetSize(TextImage.Width, TextImage.Height);

      ShadowBuff.Canvas.Brush.Color:=EditorConfigForm.Editor_Num_Image.Canvas.Brush.Color;
      ShadowBuff.Canvas.FillRect(0, 0, TextImage.Width, TextImage.Height);

      ShadowBuff.Canvas.Font:=EditorConfigForm.Editor_Text_Image.Canvas.Font;

      ShadowBuff.Canvas.Brush.Color:=EditorConfigForm.Editor_Num_Image.Canvas.Brush.Color;
      ShadowBuff.Canvas.Font.Color:=EditorConfigForm.Editor_Num_Image.Canvas.Font.Color;

      str:='Assembler Editor Plus, '+versionStr;
      wx:= ShadowBuff.Canvas.GetTextWidth(str);
      wy:= ShadowBuff.Canvas.GetTextHeight(str);
      ShadowBuff.Canvas.TextOut((TextImage.Width div 2) - (wx div 2),
                                (TextImage.Height div 2) - wy *4, str);

      str:='дата компиляции: '+versionApp;
      wx:= ShadowBuff.Canvas.GetTextWidth(str);
      wy:= ShadowBuff.Canvas.GetTextHeight(str);
      ShadowBuff.Canvas.TextOut((TextImage.Width div 2) - (wx div 2),
                                (TextImage.Height div 2) - wy*3, str);

      str:='дата конфигурации: '+versionInf;
      wx:= ShadowBuff.Canvas.GetTextWidth(str);
      wy:= ShadowBuff.Canvas.GetTextHeight(str);
      ShadowBuff.Canvas.TextOut((TextImage.Width div 2) - (wx div 2),
                                (TextImage.Height div 2) -wy*2, str);

      // вывод изменений версии конфигурации
      for i:=0 to infDesc.Count-1 do
        begin
          str:=infDesc.Strings[i];
          wx:= ShadowBuff.Canvas.GetTextWidth(str);
          wy:= ShadowBuff.Canvas.GetTextHeight(str);
          ShadowBuff.Canvas.TextOut((TextImage.Width div 2) - (wx div 2),
                                    (TextImage.Height div 2)+ wy * i, str);

        end;
    end
  else
    begin
      GetMetrics;       // получим параметры

      PaintLineNum;     // нумерация строк
      PaintText;        // текст редактора
      PaintCursor;      // курсор
      PaintScrollPanel; // панель скролинга
    end;

  TextImage.Picture.Bitmap.Assign(ShadowBuff);
  TextImage.Repaint;
end;



// получение параметров вывода
procedure TEditor.GetMetrics;
var
  tm:TLCLTextMetric;

begin
  // определим размер буфера
  ShadowBuff.SetSize(TextImage.Width, TextImage.Height);

  ShadowBuff.Canvas.Font:=EditorConfigForm.Editor_Text_Image.Canvas.Font;
  ShadowBuff.Canvas.GetTextMetrics(tm);  // получим параметры шрифта
  charPixStepX:= ShadowBuff.Canvas.GetTextWidth('Щ'); //+1; // tm.Ascender;
  charPixStepY:=tm.Height+3;
  RowCount:=ShadowBuff.Height div charPixStepY;
  ColCount:=(ShadowBuff.Width-scr_width-num_width-3)  div charPixStepX;

  if UTF8LowerCase(Editor.SourceText.FileName)=Project.Out_Path+'\sys.sasm' then
    begin
      Num_CharsCount:=UTF8Length(inttostr(SourceText.Count))+8;
      num_show_debug:=true;
    end
  else
    begin
      if UTF8Length(inttostr(SourceText.Count))+1>EditorConfigForm.Editor_Num_Chars.Position then
         Num_CharsCount:=UTF8Length(inttostr(SourceText.Count))+1
      else Num_CharsCount:=EditorConfigForm.Editor_Num_Chars.Position;
      num_show_debug:=false;
    end;

  num_width:=3+ Num_CharsCount * charPixStepX;

  scr_width:=3+ (UTF8Length(inttostr(SourceText.Count))+1) * charPixStepX;
end;


// отрисовка номеров строк
procedure TEditor.PaintLineNum;
var
  i:integer;
  str:string;
begin
  // отрисуем фон панели номеров строк
  ShadowBuff.Canvas.Brush.Color:=EditorConfigForm.Editor_Num_Image.Canvas.Brush.Color;
  ShadowBuff.Canvas.FillRect(0, 0, num_width, TextImage.Height);

  ShadowBuff.Canvas.Pen.Color:=clBlack;
  ShadowBuff.Canvas.Line(num_width, 0, num_width, TextImage.Height);

  for i:=0 to RowCount-1 do
    begin
      if (0=((SourceText.FirstLineVisible+i+1) mod EditorConfigForm.Editor_Num_Step.Position))
        or (i=0)
          or (i=RowCount-1)
            or (SourceText.CursorY=SourceText.FirstLineVisible+i) then
        str:=IntToStr(SourceText.FirstLineVisible+i+1) else str:='.';

      if (SourceText.CursorY=SourceText.FirstLineVisible+i) then
        begin
          ShadowBuff.Canvas.Brush.Color:=EditorConfigForm.Editor_Cursor_Image.Canvas.Brush.Color;;
          ShadowBuff.Canvas.Font.Color:=EditorConfigForm.Editor_Num_Image.Canvas.Brush.color;
        end
      else
        begin
          ShadowBuff.Canvas.Brush.Color:=EditorConfigForm.Editor_Num_Image.Canvas.Brush.Color;
          ShadowBuff.Canvas.Font.Color:=EditorConfigForm.Editor_Num_Image.Canvas.Font.Color;
        end;

      // подсветим номер строки с ошибкой
      if (SourceText.FirstLineVisible+i<SourceText.Count) and
            TSourceLine(SourceText.GetLine(SourceText.FirstLineVisible+i)).LineErr then
        ShadowBuff.Canvas.Brush.Color:=EditorConfigHLForm.ERR_BKG_COLOR;

      if num_show_debug then
        begin
          ShadowBuff.Canvas.TextOut(2, charPixStepY*i, SourceText.GetDebugStr(SourceText.FirstLineVisible+i));
          ShadowBuff.Canvas.TextOut(2+8*charPixStepX, charPixStepY*i, format('%'+inttostr(Num_CharsCount-8)+'s', [str]));
        end
      else
      ShadowBuff.Canvas.TextOut(2, charPixStepY*i, format('%'+inttostr(Num_CharsCount)+'s', [str]));

    end;
end;

// отрисовка текста
procedure TEditor.PaintText;
var
  line:integer;       // номер строки для вывода
  posy, posx:integer; // позиция вывода токена
  tokpos:integer;     // номер токена для вывода
  str:string;
  Tokens:TTokenList;
  Token:TToken;

  tx, tl:integer;
begin
  // отрисуем фон текста
  ShadowBuff.Canvas.Brush.Color:=EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color; // text_bkg_color;
  ShadowBuff.Canvas.FillRect(num_width+1, 0, TextImage.Width-scr_width, TextImage.Height);


  ShadowBuff.Canvas.Font:=EditorConfigForm.Editor_Text_Image.Canvas.Font;
  posy:=0;
  for line:=SourceText.FirstLineVisible to SourceText.FirstLineVisible+RowCount-1 do
    begin
      if line>=SourceText.Count then break;

      str:=SourceText.GetLineStr(line);
      Tokens:=TTokenList(SourceText.GetLineTokens(line)); // токены строки

      // вывод токенов строки
      for tokpos:=0 to Tokens.Count-1 do
        begin
          Token:=TToken(Tokens.GetToken(tokpos));

          if ( (Token.startPos>=SourceText.FirstCharVisible) and (Token.startPos<=SourceText.FirstCharVisible+ColCount) ) or
             ( (Token.startPos<=SourceText.FirstCharVisible) and (Token.startPos+Token.tokLen>=SourceText.FirstCharVisible) ) then
             begin // токен подлежит печати

               // расчет позиции вывода токена по горизонтали
               if Token.startPos>=SourceText.FirstCharVisible then posx:=Token.startPos-SourceText.FirstCharVisible
                                                   else posx:=0;

               // конечный символ токена для вывода
               if (Token.startPos>=SourceText.FirstCharVisible) then
                  begin
                    tx:=1;
                    if posx+Token.tokLen<ColCount then tl:=Token.tokLen
                      else tl:=ColCount-posx+1;
                  end
               else
                  begin //(Token.startPos < FirstCharVisible)
                     tx:=SourceText.FirstCharVisible-Token.startPos+1;
                     if Token.tokLen-tx>=ColCount then tl:=ColCount
                     else tl:=Token.tokLen-tx+1;
                  end;

               str:=UTF8Copy(Token.Text, tx, tl); // копируем текст для вывода

               // выбор атрибутов токенов
               ShadowBuff.Canvas.Font:=EditorConfigForm.Editor_Text_Image.Canvas.Font;
               ShadowBuff.Canvas.Brush.Color:=EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color; //text_bkg_color;
               case Token.tokStyle of
                 tsRem:   begin
                             ShadowBuff.Canvas.Font.Color:=EditorConfigHLForm.REM_FONT_COLOR;
                             ShadowBuff.Canvas.Font.Style:=EditorConfigHLForm.REM_FONT_STYLE;
                             if EditorConfigHLForm.REM_BKGCOL_CHECK then
                               ShadowBuff.Canvas.Brush.Color:=EditorConfigHLForm.REM_BKG_COLOR;
                          end;
                 tsEdDir:  begin
                             ShadowBuff.Canvas.Font.Color:=EditorConfigHLForm.EDDIR_FONT_COLOR;
                             ShadowBuff.Canvas.Font.Style:=EditorConfigHLForm.EDDIR_FONT_STYLE;
                             if EditorConfigHLForm.EDDIR_BKGCOL_CHECK then
                               ShadowBuff.Canvas.Brush.Color:=EditorConfigHLForm.EDDIR_BKG_COLOR;
                           end;
                 tsAsmDir: begin
                             ShadowBuff.Canvas.Font.Color:=EditorConfigHLForm.ASMDIR_FONT_COLOR;
                             ShadowBuff.Canvas.Font.Style:=EditorConfigHLForm.ASMDIR_FONT_STYLE;
                             if EditorConfigHLForm.ASMDIR_BKGCOL_CHECK then
                               ShadowBuff.Canvas.Brush.Color:=EditorConfigHLForm.ASMDIR_BKG_COLOR;
                           end;
                 tsParam:  begin
                             ShadowBuff.Canvas.Font.Color:=EditorConfigHLForm.PARAM_FONT_COLOR;
                             ShadowBuff.Canvas.Font.Style:=EditorConfigHLForm.PARAM_FONT_STYLE;
                             if EditorConfigHLForm.PARAM_BKGCOL_CHECK then
                               ShadowBuff.Canvas.Brush.Color:=EditorConfigHLForm.PARAM_BKG_COLOR;
                           end;
                 tsString: begin
                             ShadowBuff.Canvas.Font.Color:=EditorConfigHLForm.STRING_FONT_COLOR;
                             ShadowBuff.Canvas.Font.Style:=EditorConfigHLForm.STRING_FONT_STYLE;
                             if EditorConfigHLForm.STRING_BKGCOL_CHECK then
                               ShadowBuff.Canvas.Brush.Color:=EditorConfigHLForm.STRING_BKG_COLOR;
                           end;
                 tsDelim:  begin
                             ShadowBuff.Canvas.Font.Color:=EditorConfigHLForm.DELIM_FONT_COLOR;
                             ShadowBuff.Canvas.Font.Style:=EditorConfigHLForm.DELIM_FONT_STYLE;
                             if EditorConfigHLForm.DELIM_BKGCOL_CHECK then
                               ShadowBuff.Canvas.Brush.Color:=EditorConfigHLForm.DELIM_BKG_COLOR;
                           end;
                 tsErr:    begin
                             ShadowBuff.Canvas.Font.Color:=EditorConfigHLForm.ERR_FONT_COLOR;
                             ShadowBuff.Canvas.Font.Style:=EditorConfigHLForm.ERR_FONT_STYLE;
                             if EditorConfigHLForm.ERR_BKGCOL_CHECK then
                               ShadowBuff.Canvas.Brush.Color:=EditorConfigHLForm.ERR_BKG_COLOR;
                           end;
                 tsLabSymb: begin
                              ShadowBuff.Canvas.Font.Color:=EditorConfigHLForm.SYMB_FONT_COLOR;
                             ShadowBuff.Canvas.Font.Style:=EditorConfigHLForm.SYMB_FONT_STYLE;
                             if EditorConfigHLForm.SYMB_BKGCOL_CHECK then
                               ShadowBuff.Canvas.Brush.Color:=EditorConfigHLForm.SYMB_BKG_COLOR;
                            end;
                 tsAsmCom:  begin
                              ShadowBuff.Canvas.Font.Color:=EditorConfigHLForm.ASMCOM_FONT_COLOR;
                              ShadowBuff.Canvas.Font.Style:=EditorConfigHLForm.ASMCOM_FONT_STYLE;
                              if EditorConfigHLForm.ASMCOM_BKGCOL_CHECK then
                                ShadowBuff.Canvas.Brush.Color:=EditorConfigHLForm.ASMCOM_BKG_COLOR;
                            end;
                 tsReg:     begin
                             ShadowBuff.Canvas.Font.Color:=EditorConfigHLForm.REG_FONT_COLOR;
                             ShadowBuff.Canvas.Font.Style:=EditorConfigHLForm.REG_FONT_STYLE;
                             if EditorConfigHLForm.REG_BKGCOL_CHECK then
                               ShadowBuff.Canvas.Brush.Color:=EditorConfigHLForm.REG_BKG_COLOR;
                            end;
                 tsNum:     begin
                              ShadowBuff.Canvas.Font.Color:=EditorConfigHLForm.NUM_FONT_COLOR;
                             ShadowBuff.Canvas.Font.Style:=EditorConfigHLForm.NUM_FONT_STYLE;
                             if EditorConfigHLForm.NUM_BKGCOL_CHECK then
                               ShadowBuff.Canvas.Brush.Color:=EditorConfigHLForm.NUM_BKG_COLOR;
                            end;
               end;
               posx:=num_width+3+(posx)*charPixStepX; // расчет координат для вывода

               ShadowBuff.Canvas.TextOut(posx, posy, str);
               // подсветим ошибку
               if TSourceLine(SourceText.GetLine(line)).LineErr then
                 begin
                   ShadowBuff.Canvas.Pen.Color:=EditorConfigHLForm.ERR_BKG_COLOR;
                   ShadowBuff.Canvas.Pen.Style:=psSolid;
                   if (TSourceLine(SourceText.GetLine(line)).TokenErrNum=-1) and (tokpos=Tokens.Count-1) then
                       ShadowBuff.Canvas.Line(posx+charPixStepX*(tl+1) , posy+charPixStepY-2, posx+charPixStepX*(tl+5), posy+charPixStepY-2);

                 end;
             end;
        end;
      posy:=posy+charPixStepY;
    end;
  if SourceText.TextSelect then PaintSelection;
end;

procedure TEditor.PaintSelection;
var
  line:integer;       // номер строки для вывода
  posy, posx:integer; // позиция вывода токена
  str:string;

  ts, te, tl:integer;
begin
  // фон выделенного текста
  ShadowBuff.Canvas.Brush.Color:=clYellow;
  ShadowBuff.Canvas.Font:=EditorConfigForm.Editor_Text_Image.Canvas.Font;
  ShadowBuff.Canvas.Font.Color:=clBlack;
  ShadowBuff.Canvas.Font.Style:=[fsItalic];

  posy:=0;
  for line:=SourceText.FirstLineVisible to SourceText.FirstLineVisible+RowCount-1 do
    begin
      if line>=SourceText.Count then break;

      if (SourceText.TextSelectSY<=line) and (line<=SourceText.TextSelectLY) then
        begin
          str:=SourceText.GetLineStr(line);

          // начало выделения в строке
          if (SourceText.TextSelectSY=line) then
            begin
              ts:=SourceText.TextSelectSX+1;
              te:=ColCount+SourceText.FirstCharVisible;
            end;
          // полностью выделенная строка
          if (SourceText.TextSelectSY<line) and (SourceText.TextSelectLY>line) then
            begin
              ts:=1;
              te:=ColCount+SourceText.FirstCharVisible;
            end;
          // конец выделения в строке
          if (SourceText.TextSelectLY=line) and (SourceText.TextSelectSY<>line)then
            begin
              ts:=1;
              if SourceText.TextSelectLX+1<ColCount+SourceText.FirstCharVisible then
                te:=SourceText.TextSelectLX+1 else te:=ColCount+SourceText.FirstCharVisible;
            end;
          //  выделение в одной строке
          if (SourceText.TextSelectLY=line) and (SourceText.TextSelectSY=line)then
            begin
              ts:=SourceText.TextSelectSX+1;
              if SourceText.TextSelectLX+1<ColCount+SourceText.FirstCharVisible then
                te:=SourceText.TextSelectLX+1 else te:=ColCount+SourceText.FirstCharVisible;
            end;

          while UTF8Length(str)<te do str:=str+' ';

          if ts<SourceText.FirstCharVisible then ts:=SourceText.FirstCharVisible;

          if te-ts>ColCount then tl:=ColCount else tl:=te-ts;

          if te>SourceText.FirstCharVisible then
            begin
              str:=UTF8Copy(str, ts, tl);
              posx:=num_width+3+(ts-SourceText.FirstCharVisible)*charPixStepX; // расчет координат для вывода

              ShadowBuff.Canvas.TextOut(posx, posy, str);
            end;
        end;
      posy:=posy+charPixStepY;
    end;
end;

// панель скролинга
procedure TEditor.PaintScrollPanel;
var
  i, line, oline, posy, posx:integer;
begin
  // отрисуем фон панели скролинга
  ShadowBuff.Canvas.Brush.Color:=EditorConfigForm.Editor_Scr_Image.Canvas.Brush.Color;
  ShadowBuff.Canvas.FillRect(TextImage.Width-scr_width, 0, TextImage.Width, TextImage.Height);
  ShadowBuff.Canvas.Pen.Color:=clBlack;
  ShadowBuff.Canvas.Line(TextImage.Width-scr_width, 0, TextImage.Width-scr_width, TextImage.Height);

  if SourceText.Count<RowCount*2 then exit;

  posy:=(charPixStepY div 2);
  posx:=TextImage.Width-scr_width+2;

  ShadowBuff.Canvas.Font.Style:=[];

  oline:=-1;
  if RowCount=0 then exit;

  for i:=0 to RowCount do
    begin
      line:=(i*SourceText.Count) div RowCount;

      if ( (SourceText.FirstLineVisible<=line) and (SourceText.FirstLineVisible+RowCount>=line) ) or
         ( (SourceText.FirstLineVisible>oline) and (SourceText.FirstLineVisible+RowCount<line) )
        then
        begin
          ShadowBuff.Canvas.Brush.Color:=EditorConfigForm.Editor_Cursor_Image.Canvas.Brush.Color;
          ShadowBuff.Canvas.Font.Color:=EditorConfigForm.Editor_Scr_Image.Canvas.Brush.color;
        end
      else
        begin
          ShadowBuff.Canvas.Brush.Color:=EditorConfigForm.Editor_Scr_Image.Canvas.Brush.Color;
          ShadowBuff.Canvas.Font.Color:=EditorConfigForm.Editor_Scr_Image.Canvas.Font.Color;
         end;

      if i<>0 then
        begin
          if num_show_debug then
            ShadowBuff.Canvas.TextOut(posx, charPixStepY*i-posy, format('%'+inttostr(Num_CharsCount-8)+'s', [inttostr(line)]))
          else
            ShadowBuff.Canvas.TextOut(posx, charPixStepY*i-posy, format('%'+inttostr(Num_CharsCount)+'s', [inttostr(line)]));
        end;

      oline:=line;
    end;
end;

// окно позиционирования
procedure TEditor.PaintScrollInfo;
var

  tm:TLCLTextMetric;
  i, line,posx, posy:integer;
  charXStep, charYStep:integer;
  colc:integer;
  linestart, rows:integer;
  src, dst:TRect;
begin
  if SourceText.Count<RowCount*2 then exit;

  if not scrollInfoShowed then ShadowBuff2.Assign(ShadowBuff);

  // параметры шрифта для вывода
  ShadowBuff2.Canvas.Font:=EditorConfigForm.Editor_Text_Image.Canvas.Font;
  ShadowBuff2.Canvas.Font.Size:=EditorConfigForm.Editor_Text_Image.Canvas.Font.Size-2;

  // получим параметры шрифта
  ShadowBuff2.Canvas.GetTextMetrics(tm);
  charXStep:= ShadowBuff2.Canvas.GetTextWidth('Щ');
  charYStep:=ShadowBuff2.Canvas.GetTextHeight('Щ');

  line:=(TextImageMouseYPix*SourceText.Count) div TextImage.Height;

  if RowCount>40 then rows:=40 else rows:=RowCount;

  posy:=((TextImage.Height-charYStep*rows) * ((TextImageMouseYPix * 100) div TextImage.Height)) div  100;

  colc:=ColCount;
  if colc>60 then colc:=60;

  posx:=TextImage.Width - scr_width - charXStep*colc-5;

  src:=Trect.Create(posx-1, 0, ShadowBuff.Width, ShadowBuff.height);
  dst:=Trect.Create(posx-1, 0, ShadowBuff.Width, ShadowBuff.height);
  ShadowBuff2.Canvas.CopyRect(src, ShadowBuff.Canvas, dst);

  // поле позиционирование с рамкой
  ShadowBuff2.Canvas.Brush.Color:=EditorConfigForm.Editor_Scr_Image.Canvas.Brush.Color;
  ShadowBuff2.Canvas.FillRect(posx, posy-1, posx+colc*charXStep+2, posy+charYStep*rows+1);
  ShadowBuff2.Canvas.Pen.Color:=clBlack;
  ShadowBuff2.Canvas.Rectangle(posx, posy-1, posx+colc*charXStep+2, posy+charYStep*rows+1);

  linestart:=line+1;
  for i:=0 to rows-1 do
    begin
      if line<SourceText.Count then
         ShadowBuff2.Canvas.TextOut(posx+5, posy+charYStep*i, UTF8Copy(SourceText.GetLineStr(line), 1, colc-1))
         else break;
      line:=line+1;
    end;

  // метка строки под указателем мыши
  ShadowBuff2.Canvas.Font:=EditorConfigForm.Editor_Text_Image.Canvas.Font;
  ShadowBuff2.Canvas.Font.Color:=clWhite;
  ShadowBuff2.Canvas.Font.Style:=[fsBold];
  ShadowBuff2.Canvas.Brush.Color:=clRed;

  ShadowBuff2.Canvas.TextOut(TextImage.Width-scr_width+2-Num_CharsCount*charXStep,
                                TextImageMouseYPix-(charYStep div 2),
                                 format('%'+inttostr(Num_CharsCount)+'s', [inttostr(linestart)]));

  TextImage.Canvas.CopyRect(src, ShadowBuff2.Canvas, dst);
  scrollInfoShowed:=true;
end;


// отображение курсора
procedure TEditor.PaintCursor;
var
  posy, posx:integer; // позиция вывода токена
  str, curText:string;
begin
  // проверим видимость курсора
  if (SourceText.CursorX+1<SourceText.FirstCharVisible) or (SourceText.CursorY>SourceText.FirstLineVisible+RowCount) then exit;
  // определим символ в позиции курсора
  curText:=' ';
  if SourceText.Cursory<SourceText.Count then
    begin
      str:=SourceText.GetLineStr(SourceText.CursorY);
      if SourceText.CursorX+1<=UTF8Length(str) then curText:=UTF8Copy(str, SourceText.CursorX+1, 1);
    end;
  // графические координаты
  posy:=(SourceText.Cursory-SourceText.FirstLineVisible)*charPixStepY;
  posx:=num_width+3+charPixStepX*(SourceText.CursorX-SourceText.FirstCharVisible+1);

  // отрисовка
  ShadowBuff.Canvas.Brush.Color:=EditorConfigForm.Editor_Cursor_Image.Canvas.Brush.Color;
  ShadowBuff.Canvas.Font.Color:=EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color;
  if SourceText.TextSelect then ShadowBuff.Canvas.Brush.Color:=clRed;
  ShadowBuff.Canvas.TextOut(posx, posy, curText);
end;

end.

