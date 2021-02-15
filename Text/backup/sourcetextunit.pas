unit SourceTextUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, UITypes, LazUTF8,
  TextParserUnit, SimpleTextParserUnit, AsmTextParserUnit, LDTextParserUnit,
  initextparserunit, dasmtextparserunit,
  CharsDecoderUnit,
  SourceLineUnit,
  TokensUnit,
  UndoRedoUnit;

type

  { TSourceText }

  TSourceText=class(TObject)
    private
      textfilename:string;
      FTextType:string;
      Lines:TList;
      Parser:TTextParser;

      procedure setFileName(AValue: string);
      procedure setUndoRedoRecCursorPos(URItem: TUndoRedoItem);
      procedure getUndoRedoRecCursorPos(URItem: TUndoRedoItem);
    public
      OpenInEditor:boolean; // файл открыт в проекте
      TextChange:boolean;   // флаг что текст был изменен и не сохранен
      FileNamed:boolean;    // флаг что текст имеет имя файла для сохранения
      CharSet:string;       // кодировка

      URList:TUndoRedoList;  // история изменений текста

      // переменные редактора текста
      FirstLineVisible:integer;  // первая видимая строка
      FirstCharVisible:integer;  // первый видимый символ
      FirstLineCopy:integer;     // копия первая видимая строка
      FirstCharCopy:integer;     // копия первый видимый символ
      CursorX, CursorY:integer;  // позиция курсора
      TextSelect:boolean;        // есть выделение текста
      TextSelectSX, TextSelectSY, TextSelectLX, TextSelectLY:integer; // выделение текста

      property    FileName:string  read textfilename write setFileName; // имя файла
      property    TextType:string  read FTextType;

      property    TextParser:TTextParser read Parser;

      constructor Create;
      destructor  Free;

      function    Count:integer;      // количество строк
      function    SelectionLength:integer;  // длина выделения в стандартных идиотских единицах
      function    SelStart:integer;         // позиция начала выделения в ст. идиот ед.

      procedure   Clear;              // очистка текста

      procedure   Add(str:string);              // добавить строку
      procedure   Ins(num:integer; str:string); // вставить строку
      procedure   Del(num:integer);             // удалить строку

      procedure   SetLineStr(num:integer; str:string);   // установить текст строки

      function    GetLine(num:integer):TSourceLine;

      function    GetLineStr(num:integer):string;          // получить текст строки
      function    GetLineTokens(num:integer):TTokenList;   // получить токены строки
      function    GetLineSymbols(num:integer):TStringList; // получить символы строки

      function    GetTokenInText(tokstr:string; out lineNum:integer):boolean; // поиск токена в тексте файла

      function    GetLineNum(SL:TSourceLine):integer;        // номер строки
      function    GetSymbolLineNum(symbname:string):integer; // номер строки объявления символа

      procedure   SetDebugStr(num:integer; debStr:string);   // установить сообщения отладки
      function    GetDebugStr(num:integer):string;           // прочитать сообщения отладки

      function    GetDebugAdrText(adrHex: string; navigate: boolean): string;     // прочитать строку по адресу
      function    GetAsmFromAdr(adrHex:string):string;   //получить текст asm по адресу
      function    GetAdrFromLine(line:integer):string;   // получить адрес из строки
      procedure   ClearBreakPointAdr(adr:string);        // удалить точку останова по адресу

      procedure   OpenFile(file_name:string); // открытие файла
      procedure   SaveFile;                   // сохранить файл
      procedure   CloseFile;                  // закрытие файла

      procedure   Undo;                       // отмена последнего изменения
      procedure   Redo;                       // возврат до последнего изменения
  end;

implementation

uses MainUnit, ConfigUnit;

{ TSourceText }

procedure TSourceText.setFileName(AValue: string);
var
  i:integer;
  chg:boolean;
begin
  chg:=textChange;

  textfilename:=UTF8LowerCase(AValue);
  if Assigned(Parser) then Parser.Free;

  // по расширению файла загрузим класс парсера текста
  FTextType:=UTF8UpperCase(ExtractFileExt(textfilename)); // получим расширение файла
  case FTextType of
    '.ASM', '.INC', '.-ASM': begin
                       Parser:=TAsmTextParser.Create(Lines);
                       TAsmTextParser(Parser).setFileName(textfilename);
                     end;
    '.DASM','.SASM': Parser:=TDAsmTextParser.Create(Lines);
    '.INI': Parser:=TIniTextParser.Create(Lines);
    '.LD' : Parser:=TLDTextParser.Create(Lines);
     else   Parser:=TSimpleTextParser.Create(Lines);
  end;

  CurrentParseFileName:=textfilename;  // задаем имя файла который сейчас парсим

  // пройдемся по всем строчкам текста
  Parser.ShortParse;

  for i:=0 to Lines.Count-1 do
    SetLineStr(i, GetLineStr(i)+' ');

  Parser.FullParse;

  textChange:=chg;
end;

procedure TSourceText.setUndoRedoRecCursorPos(URItem:TUndoRedoItem);
begin
  if URItem=nil then exit;

  URItem.CursorY:=CursorY;
  URItem.CursorX:=CursorX;

  URItem.FirstLineVisible:=FirstLineVisible;  // первая видимая строка
  URItem.FirstCharVisible:=FirstCharVisible;  // первый видимый символ
  URItem.FirstLineCopy:=FirstLineCopy;        // копия первая видимая строка
  URItem.FirstCharCopy:=FirstCharCopy;        // копия первый видимый символ

  URItem.TextSelect:=TextSelect;              // есть выделение текста
  URItem.TextSelectSX:=TextSelectSX;
  URItem.TextSelectSY:=TextSelectSY;
  URItem.TextSelectLX:=TextSelectLX;
  URItem.TextSelectLY:=TextSelectLY;
end;

procedure TSourceText.getUndoRedoRecCursorPos(URItem: TUndoRedoItem);
begin
  CursorY:=URItem.CursorY;
  CursorX:=URItem.CursorX;

  FirstLineVisible:=URItem.FirstLineVisible;  // первая видимая строка
  FirstCharVisible:=URItem.FirstCharVisible;  // первый видимый символ
  FirstLineCopy:=URItem.FirstLineCopy;     // копия первая видимая строка
  FirstCharCopy:=URItem.FirstCharCopy;     // копия первый видимый символ

  TextSelect:=URItem.TextSelect;        // есть выделение текста
  TextSelectSX:=URItem.TextSelectSX;
  TextSelectSY:=URItem.TextSelectSY;
  TextSelectLX:=URItem.TextSelectLX;
  TextSelectLY:=URItem.TextSelectLY;
end;

constructor TSourceText.Create;
begin
  Lines:=TList.Create;
  URList:=TUndoRedoList.Create;
  Parser:=nil;

  OpenInEditor:=false;

  textChange:=false;
  FileName:='New';
  FileNamed:=false;
  CharSet:=Config.Default_CharSet;

  FirstLineVisible:=0;  // первая видимая строка
  FirstCharVisible:=1;  // первый видимый символ
  FirstLineCopy:=0;     // копия первая видимая строка
  FirstCharCopy:=1;     // копия первый видимый символ
  CursorX:=0;
  CursorY:=0;           // позиция курсора
  TextSelect:=false;    // есть выделение текста
end;

destructor TSourceText.Free;
var
  i:integer;
begin
  URList.Free;
  for i:=0  to Lines.Count-1 do TSourceLine(Lines.Items[i]).Free;
  Lines.free;
end;

// количество строк
function TSourceText.Count: integer;
begin
  Count:=Lines.Count;
end;

function TSourceText.SelectionLength: integer;
begin
  Result:=0;
  if not TextSelect then exit;

  Result:=TextSelectLX-TextSelectSX+1;
end;

function TSourceText.SelStart: integer;
var
  i, trg, charpos:integer;
begin
  if TextSelect then trg:=TextSelectSY
                 else trg:=CursorY;
  charpos:=0; i:=0;
  while (i<trg) do
     begin
       charpos:=charpos+UTF8Length(GetLineStr(i))+2;
       i:=i+1;
     end;
  if TextSelect then charPos:=charPos+TextSelectLX-1
                 else charPos:=charPos+CursorX;
  Result:=charpos;
end;

// очистить текст
procedure TSourceText.Clear;
var
  URItem:TUndoRedoItem;
  URRec:TUndoRedoRec;
  i:integer;
begin
  // сохраним текст в истории
  URItem:=URList.Current;           // берем текущий элемент истории
  if URItem<>nil then
    begin
      setUndoRedoRecCursorPos(URItem);  // сохраним позицию курсора
      // сохраним все строки
      for i:=0 to Lines.Count-1 do
      begin
        URRec:=TUndoRedoRec.Create(i, GetLineStr(i));
        URRec.action:=turClear;          // действие
        URItem.AddRec(URRec);
      end;
    end;

  if Assigned(Parser) then Parser.Clear;

  while Lines.Count>0 do
    begin
      TSourceLine(Lines.Items[0]).Free;
      Lines.Delete(0);
    end;
end;

// добавить строку
procedure TSourceText.Add(str: string);
var
  URItem:TUndoRedoItem;
  URRec:TUndoRedoRec;

  SL:TSourceLine;
  i:integer;
begin
  // сохраним в истории
  URItem:=URList.Current;           // текущий элемент истории
  if URItem<>nil then
    begin
      setUndoRedoRecCursorPos(URItem);  // сохраним позицию курсора
      URRec:=TUndoRedoRec.Create(Lines.Count, '');
      URRec.action:=turAdd;          // действие
      URItem.AddRec(URRec);
    end;

  CurrentParseFileName:=textfilename;  // задаем имя файла который сейчас парсим

  SL:=TSourceLine.Create(str);
  i:=Lines.Add(SL);
  if Assigned(Parser) then Parser.Parse(i);
  TextChange:=true;
end;

// вставить строку
procedure TSourceText.Ins(num: integer; str: string);
var
  URItem:TUndoRedoItem;
  URRec:TUndoRedoRec;

  SL:TSourceLine;
begin
  // сохраним в истории
  URItem:=URList.Current;           // текущий элемент истории
  if URItem<>nil then
    begin
      setUndoRedoRecCursorPos(URItem);  // сохраним позицию курсора
      URRec:=TUndoRedoRec.Create(num, '');
      URRec.action:=turIns;            // действие
      URItem.AddRec(URRec);
    end;

  CurrentParseFileName:=textfilename;  // задаем имя файла который сейчас парсим

//  i:=Lines.Count;
  while Lines.Count-2<num do Add('');  // если строк нет выше, то добавим их

  SL:=TSourceLine.Create(str);
  Lines.Insert(num, SL);
  if Assigned(Parser) then Parser.Parse(num);
  TextChange:=true;
end;

// удалить строку
procedure TSourceText.Del(num: integer);
var
  URItem:TUndoRedoItem;
  URRec:TUndoRedoRec;
begin
  if num>=Count then exit;

  // сохраним в истории
  URItem:=URList.Current;           // текущий элемент истории
  if URItem<>nil then
    begin
      setUndoRedoRecCursorPos(URItem);  // сохраним позицию курсора
      URRec:=TUndoRedoRec.Create(num, GetLineStr(num));
      URRec.action:=turDel;          // действие
      URItem.AddRec(URRec);
    end;

  CurrentParseFileName:=textfilename;  // задаем имя файла который сейчас парсим

  if Assigned(Parser) then Parser.Del(num);
  TSourceLine(Lines.Items[num]).Free;
  Lines.Delete(num);
  TextChange:=true;
end;

// задать текст строки
procedure TSourceText.SetLineStr(num: integer; str: string);
var
  URItem:TUndoRedoItem;
  URRec:TUndoRedoRec;

begin
  if (num>=Lines.Count) then
    while Lines.Count+1<num do Add('');

  if str=TSourceLine(Lines.Items[num]).GetStr then exit;

  // сохраним в истории
  URItem:=URList.Current;           // текущий элемент истории
  if URItem<>nil then
    begin
      setUndoRedoRecCursorPos(URItem);  // сохраним позицию курсора
      URRec:=TUndoRedoRec.Create(num, GetLineStr(num));
      URRec.action:=turSet;          // действие
      URItem.AddRec(URRec);
    end;

  CurrentParseFileName:=textfilename;  // задаем имя файла который сейчас парсим

  TSourceLine(Lines.Items[num]).SetStr(str);
  if Assigned(Parser) then   Parser.Parse(num);

  TextChange:=true;
end;

function TSourceText.GetLine(num: integer): TSourceLine;
begin
  if (num>=0) and (num<Count) then Result:=TSourceLine(Lines.Items[num])
               else Result:=nil;
end;

// получить текст строки
function TSourceText.GetLineStr(num: integer): string;
begin
  if (num>=0) and (num<Count) then GetLineStr:=TSourceLine(Lines.Items[num]).GetStr
               else GetLineStr:='';
end;

// получить токены строки
function TSourceText.GetLineTokens(num: integer): TTokenList;
begin
   if (num>=0) and (num<Count) then GetLineTokens:=TSourceLine(Lines.Items[num]).GetTokens
                else GetLineTokens:=nil;
end;

// получить символы строки
function TSourceText.GetLineSymbols(num: integer): TStringList;
begin
  Result:=TSourceLine(Lines.Items[num]).SymbolsName;
end;

// поиск токена в тексте файла c возвратом номера строки
function TSourceText.GetTokenInText(tokstr: string; out lineNum: integer
  ): boolean;
var
  i, pos:integer;
  tokList:TTokenList;
  tok:TToken;
begin
   for i:=0 to Lines.Count-1 do
     begin
       pos:=0;
       tokList:=GetLineTokens(i);
       tok:=tokList.GetToken(pos, tokstr);
       if tok<>nil then
         begin
           Result:=true;
           lineNum:=i;
           exit;
         end;
     end;
   Result:=false;
end;

function TSourceText.GetLineNum(SL: TSourceLine): integer;
begin
  Result:=Lines.IndexOf(SL);
end;

// номер строки объявления символа
function TSourceText.GetSymbolLineNum(symbname: string): integer;
var
  i:integer;
  SL:TSourceLine;
begin
  for i:=0 to Lines.Count-1 do
    begin
      SL:=TSourceLine(Lines.Items[i]);
      if SL.SymbolsName.IndexOf(symbname)<>-1 then
        begin
          Result:=i;
          exit;
        end;
    end;
end;

// установить сообщения отладки
procedure TSourceText.SetDebugStr(num: integer; debStr: string);
begin
  if (num>=0) and (num<Lines.Count) then
    TSourceLine(Lines.Items[num]).debugStr:=debStr;
end;

// прочитать сообщения отладки
function TSourceText.GetDebugStr(num: integer): string;
begin
  if (num>=0) and (num<Lines.Count) then
    Result:=TSourceLine(Lines.Items[num]).debugStr
  else Result:='';
end;

// прочитать строку по адресу
function TSourceText.GetDebugAdrText(adrHex: string; navigate:boolean): string;
var
  line:integer;
begin
  Result:='';
  if (not (TextParser is TDAsmTextParser)) then exit;

  Result:=TDAsmTextParser(TextParser).getAdrLine(adrHex, line);

  if navigate and (line<>-1) then
    begin
//      FirstLineVisible:=line-(Editor.RowCount div 2);  // выравнивание окна посередине

      // последовательное слежение
      if line<FirstLineVisible then FirstLineVisible:=line-5;
      if line>=FirstLineVisible+Editor.RowCount-5 then
        FirstLineVisible:=line-Editor.RowCount+6;

      if FirstLineVisible<0 then FirstLineVisible:=0;

      TextSelect:=true;
      TextSelectLX:=UTF8Length(Result);
      TextSelectSX:=0;
      TextSelectSY:=line;
      TextSelectLY:=line;

      Editor.Refresh;
    end;
end;

function TSourceText.GetAsmFromAdr(adrHex: string): string;
var
  i, line:integer;
  tokList:TTokenList;
begin
  Result:='';
  if (not (TextParser is TDAsmTextParser)) then exit;

  TDAsmTextParser(TextParser).getAdrLine(adrHex, line);
  if line=-1 then exit;

  i:=3;
  tokList:=TTokenList(GetLineTokens(line));
  while i<tokList.Count do
    begin
      Result:=Result+TToken(tokList.GetToken(i)).Text+' ';
      i:=i+1;
    end;

end;

function TSourceText.GetAdrFromLine(line: integer): string;
begin
  Result:='';
  if (not (TextParser is TDAsmTextParser)) then exit;

  Result:=TDAsmTextParser(TextParser).getLineAdr(line);
end;

// удалить точку останова по адресу
procedure TSourceText.ClearBreakPointAdr(adr: string);
var
  line:integer;

begin
  if (not (TextParser is TDAsmTextParser)) then exit;

  TDAsmTextParser(TextParser).getAdrLine(adr, line);
  if line=-1 then exit;
     SetDebugStr(line,'');
  Editor.Refresh;
end;



// открытие файла
procedure TSourceText.OpenFile(file_name: string);
var
  text:string;
  txt:TStringList;
  i:integer;
  charset_copy:string;
begin
  Clear;

  // откроем файл
  FileName:=file_name;
  FileNamed:=true;

  if CharSet='' then CharSet:=Config.Default_CharSet;

  if ExtractFileExt(file_name)='.ini' then CharSet:='UTF8';

  charset_copy:=CharSet;
  text:=CDU_OpenFile(file_name, CharSet);
  if CharSet='ERROR' then
    begin
      CharSet:=charset_copy; //Config.Default_CharSet;
      exit;
    end;

  txt:=TStringList.Create;
  txt.Text:=text;

  Lines.Capacity:=txt.Count;

  // добавим строки текста
  if Assigned(Parser) then   Parser.ShortParse; // режим ускоренного парсинга


  for i:=0 to txt.Count-1 do Add(txt.Strings[i]);

  if Assigned(Parser) then   Parser.FullParse;  // режим полного парсинга

  TextChange:=false;
end;

// сохранить файл
procedure TSourceText.SaveFile;
var
  txt:TStringList;
  i:integer;
begin
  if not FileNamed then        // нужно задать имя файла
    begin
      MainForm.SaveDialog1.FilterIndex:=3;
      MainForm.SaveDialog1.Title:='Сохранить как..';
      MainForm.SaveDialog1.InitialDir:=Project.SourcePath+'\';
      if MainForm.SaveDialog1.Execute then filename:=MainForm.SaveDialog1.FileName
                                      else exit;
    end;

  txt:=TStringList.Create;
  for i:=0 to Lines.Count-1 do txt.Add(TSourceLine(Lines.Items[i]).GetStr);

//  charSet:='CP1251';
  CDU_SaveFile(filename, CharSet, txt.text);
  TextChange:=false;
  FileNamed:=true;
end;

// закрытие файла
procedure TSourceText.CloseFile;
begin
  if not TextChange then exit; // не сохраненных изменений нет

  if MessageDlg('Внимание !', 'Файл '+filename+
                ' содержит не сохраненные изменения, сохранить их перед закрытием?',
                mtWarning, [mbYes, mbNo], '')=mrNo then exit;

  if not FileNamed then        // нужно задать имя файла
    begin
      MainForm.SaveDialog1.FilterIndex:=3;
      MainForm.SaveDialog1.Title:='Сохранить как..';
      if MainForm.SaveDialog1.Execute then filename:=MainForm.SaveDialog1.FileName
                                      else exit;
    end;
  SaveFile;
  TextChange:=false;
  FileNamed:=true;
end;

// отмена последнего изменения
procedure TSourceText.Undo;
var
  URItem:TUndoRedoItem;
  URRec:TUndoRedoRec;
  i, p:integer;
begin
  if not URList.undo_oper then
    begin
      p:=URList.itemNum;
        URItem:=URList.AddItem;

        if URItem=nil then exit;

        setUndoRedoRecCursorPos(URItem);  // сохраним позицию курсора
        // сохраним все строки
        for i:=0 to Lines.Count-1 do
          begin
            URRec:=TUndoRedoRec.Create(i, GetLineStr(i));
            URRec.action:=turSet;          // действие
            URItem.AddRec(URRec);
          end;
        URList.itemNum:=p;
      end;

  URList.fl_write_change:=false; // выключим режим запоминания изменений

  URItem:=URList.GetLast;
  if URItem=nil then exit;

  if URItem.Count>0 then
    begin
      for i:=URItem.Count-1 downto 0 do
        begin
          URRec:=TUndoRedoRec(URItem.GetRec(i));
          case URRec.action of
            turAdd:  // было добавление строк - значит удалим их
               begin
                Del(URRec.lineNum);
               end;

            turIns:  // была вставка строки - значит удалим ее
               begin
                Del(URRec.lineNum);
               end;

            turDel: // было удаление строки - значит создадим ее
               begin
                Ins(URRec.lineNum, URRec.lineStr);
               end;

            turSet: // было изменение текста строки - значит изменим ее
               begin
                while Lines.Count<=URRec.lineNum do Add('');
                SetLineStr(URRec.lineNum, URRec.lineStr);
               end;
            turClear: // была очистка текста - значит восстановим все
              begin
               Add(URRec.lineStr);
              end;
          end; // case
        end; // for i
     getUndoRedoRecCursorPos(URItem);  // восстановим позицию курсора
   end;

  URList.fl_write_change:=true;     // включим режим запоминания изменений
end;

// возврат до последнего изменения
procedure TSourceText.Redo;
var
  URItem:TUndoRedoItem;
  URRec:TUndoRedoRec;
  i:integer;
begin
  URItem:=URList.GetPrev;
  if URItem=nil then exit;

  URList.fl_write_change:=false; // выключим режим запоминания изменений

  if URItem.Count>0 then
    begin
      for i:=0 to URItem.Count-1 do
        begin
          URRec:=TUndoRedoRec(URItem.GetRec(i));
          case URRec.action of
            turAdd:  // было добавление строк
               begin
                Add(URRec.lineStr);
               end;

            turIns:  // была вставка строки
               begin
                Ins(URRec.lineNum, URRec.lineStr);
               end;

            turDel: // было удаление строки - значит создадим ее
               begin
                Del(URRec.lineNum);
               end;

            turSet: // было изменение текста строки - значит изменим ее
               begin
                SetLineStr(URRec.lineNum, URRec.lineStr);
               end;

            turClear: // была очистка текста - значит восстановим все
              begin
               Clear;
              end;
          end; // case
        end; // for i
     getUndoRedoRecCursorPos(URItem);  // восстановим позицию курсора
   end;

  URList.fl_write_change:=true;     // включим режим запоминания изменений
end;

end.

