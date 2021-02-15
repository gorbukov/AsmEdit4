unit AsmFuncUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls,
  ComCtrls, LCLType, StdCtrls, LazUTF8, FileUtil,
  TokensUnit,
  SourceTextUnit, SourceLineUnit,
  TextParserUnit, AsmTextParserUnit, dasmtextparserunit, SymbolsUnit,
  ProjectUnit,
  EditorFilesUnit,
  DescUnit, EditValueUnit,
  DebugStructUnit,
  ImportConfigUnit,
  CodeFormatConfigUnit, FontImportConfigUnit;

// служебные
function GetEdDirValue(paramName:string; tokens:TTokenList; casesens:boolean=true; start:integer=1):string; // получить параметр директивы

function SearchEdDirInList(FullText:TList; dirStr:string; var start:integer):TTokenList; // поиск директивы в списке строк

procedure ImportFontData; // вставка шрифта
procedure ImportBin;  // вставка bin файла

procedure LineFormat(out xpos, toknum:integer); // форматирование строки

// вызываемые
procedure SetSTCharSet(ST:TSourceText; charSet:string);  // установка кодировки файла

procedure SetGNUOptions(ST:TSourceText; Project:TProject); // установка опций компиляции


// точки отслеживания в редакторе
procedure SetDebugBlock(ST:TSourceText); // установка блока отладочной информации

procedure SetDebugPointWord(ST:TSourceText; typstr:string); // установка отладочного адреса .word

procedure ToggleFileDebugBlock(ST:TSourceText); // переключить блоки отладочной информации
procedure SetOffFileDebugBlock(ST: TSourceText); // выключить блок отладочной информации
procedure SetOnFileDebugBlock(ST: TSourceText);  // включить блок отладочной информации


// точки отслеживания в редакторе
procedure GetPointsInfo(pointAdr:TList);  // получение информации о всех точках для чтения в отладчике


procedure GetDescTokenInfo(ST:TSourceText; desc:TStringList); // получение информации о токене

procedure DescTokenInfo(ST:TSourceText); // F1 показ описания символа

function  GetTokenFile(ST:TSourceText):string;  // поиск имени файла для токена

procedure TokenFileOpen(ST:TSourceText); // F2 открыть файл токена

function  TokenDefInfo(ST:TSourceText):TSymbol; // получение  информации о символе

procedure TokenDef(ST:TSourceText);      // F3 открыть определение

procedure SymbolOpenDef(symb:TSymbol; ST: TSourceText); //открытие файла по символу

function  getTokenItem(ST: TSourceText; out tokPos:integer; out symbEdit:string):TSymbolList;

procedure TokenEdit(ST:TSourceText);      // F4 Изменить

function  GetCursorToken(ST:TSourceText; out tokNum:integer):TToken; // получить токен на котором стоит курсор

function SearchSection(secName:string; out line, next:integer): boolean; // поиск секции по имени в указанном направлении

function SearchUpSection(out line:integer): boolean;  // поиск секции выше курсора

function addSection(secName:string):integer; // добавить секцию

procedure InsertTextLine(line:integer; str:string);  //добавить строку в текст

// получить номер строки в sasm файле соответсвующий метке под курсором
function getSTinSASMLabelLine(ST:TSourceText; out symbname:string):integer;
implementation

uses MainUnit;


// получить номер строки в sasm файле соответсвующий метке под курсором
function getSTinSASMLabelLine(ST: TSourceText; out symbname: string): integer;
var
  symb:TSymbol;
  SASM:TSourceText;
  SASMParser:TDAsmTextParser;
begin
  Result:=-1;
  symb:=TokenDefInfo(ST);  // получим имя метки/символа
  if symb=nil then exit;
  // файл дизассемблера прошивки
  SASM:=TSourceText(EditorFiles.Open(Project.Out_Path+'\sys.sasm'));
  SASMParser:=TDAsmTextParser(SASM.TextParser);
  symbname:=symb.Name;
  Result:=SASMParser.getLabelLine(symb.Name);  // номер строки с меткой
end;

// вставка шрифта
procedure ImportFontData;
var
  fontText:TStringList;
  fntName:string;
  str:string;
  i, pos, cy, charNamePos, chy:integer;
  syln, vpos:integer;
  charName:string;
  symbData:string;
  FontImportConfigForm: TFontImportConfigForm;
begin
  FontImportConfigForm:=TFontImportConfigForm.Create(MainForm);
  if FontImportConfigForm.ShowModal<>mrOk then
  begin
    FontImportConfigForm.Free;
    exit;
  end;
  MainForm.OpenDialog1.InitialDir:=Project.SourcePath+'\';
  MainForm.OpenDialog1.FilterIndex:=1;
  MainForm.OpenDialog1.FileName:='';
  if not MainForm.OpenDialog1.Execute then exit;

  fontText:=TStringList.Create;
  fontText.LoadFromFile(MainForm.OpenDialog1.FileName);

  // найдем имя шрифта
  fntName:='';
  for i:=0 to fontText.Count-1 do
    begin
      str:=fontText.Strings[i];
      pos:=utf8pos(':', str, 1);
      if ((utf8pos(';', str, 1)>pos) or (utf8pos(';', str, 1)=0)) and (pos>0) then
        begin
          fntName:=utf8copy(str, 1, pos-1);
          cy:=i;
          break;
        end;
    end;

  if fntName='' then
    begin
      showmessage('Указатель на шрифт не найден');
      exit;
    end;

  // перебор текста
  for i:=cy to fontText.Count-1 do
    begin
      str:=fontText.Strings[i];
      pos:=utf8pos('.dw', str, 1);
      charNamePos:=utf8pos(fntName, str, pos);
      // найдем указатель на символ
      if (pos>0) and (charNamePos>pos) then
        begin
          charName:=utf8copy(str, charNamePos, utf8pos('*', str, charNamePos)-charNamePos);
          // поиск символа с именем charName

          for chy:=i to fontText.Count-1 do
            if utf8pos(charName+':', fontText.Strings[chy], 1)>0 then
              begin // нашли символ
                syln:=chy;
                symbData:='';
                str:='';
                while (syln<fontText.Count) and (utf8pos(':',str,1)=0) do
                  begin
                    str:=fontText.Strings[syln];

                    // если нужно читать ширину символа то читаем после .db
                    if FontImportConfigForm.WidthImp.Checked then
                      vpos:=utf8pos('.db', utf8lowercase(str), 1)+3
                    else // если ширина не нужна - читаем начиная с двоичных значений
                      vpos:=utf8pos('0b', utf8lowercase(str), 1);

                    if symbdata<>'' then symbData:=symbData+', ';
                    symbData:=symbData+utf8copy(str, vpos, utf8length(str));

                    syln:=syln+1;
                    if syln<fontText.Count then str:=fontText.Strings[syln];
                  end;

                symbData:=StringReplace(symbData, #09, ' ', [rfReplaceAll]);
                symbData:=StringReplace(symbData, ',0', ', 0', [rfReplaceAll]);
                Editor.SourceText.Ins(Editor.SourceText.CursorY, '.byte '+symbData);
                // если нужно форматируем вывод
                if FontImportConfigForm.StrLineFormat.Checked then LineFormat(syln, vpos);

                Editor.SourceText.CursorY:=Editor.SourceText.CursorY+1;
                break;
              end;

        end;
    end;
  FontImportConfigForm.Free;
end;

// вставка bin файла
procedure ImportBin;
var
//  fname:integer;
  fs:TFileStream;
  ofs, i:cardinal;
  p:integer;
  str:string;
  py:integer;
  sz:integer; // размер для вывода
  ImportConfigForm: TImportConfigForm;
  posx, toknum:integer;
begin
  ImportConfigForm:= TImportConfigForm.Create(MainForm);
  if ImportConfigForm.ShowModal<>mrOk then
    begin
      ImportConfigForm.Free;
      exit;
    end;

  MainForm.OpenDialog1.InitialDir:=Project.SourcePath+'\';
  MainForm.OpenDialog1.FilterIndex:=1;
  MainForm.OpenDialog1.FileName:='';
  if not MainForm.OpenDialog1.Execute then exit;

  fs:=TFileStream.Create(MainForm.OpenDialog1.FileName,fmOpenRead);

  if ImportConfigForm.ByteSize.Checked then sz:=1
  else
  if ImportConfigForm.HWordSize.Checked then sz:=2
  else sz:=4;

  Editor.SourceText.URList.AddItem;
  try
    p:=0;
    case sz of
      1 : str:='.byte ';
      2 : str:='.hword ';
      4 : str:='.word ';
    end;

    py:=Editor.SourceText.CursorY;
    i:=0;
    ofs:=i;
    while i<(fs.Size div sz) do
      begin
        if p<>0 then str:=str+', ';
        case sz of
          1 : str:=str+'0x'+IntToHex(fs.ReadByte,2);
          2 : str:=str+'0x'+IntToHex(fs.ReadWord,4);
          4 : str:=str+'0x'+IntToHex(fs.ReadWord+fs.ReadWord*65536,8);
        end;

        p:=p+1;
        if p=strtoint(ImportConfigForm.ValuesCount.Text) then
          begin
            // вывод адреса строки
            if ImportConfigForm.OfsToRem.Checked then
              begin
                str:=str+'  @  0x'+IntToHex(ofs*sz,8);
                ofs:=i+1;
              end;
            Editor.SourceText.Ins(Editor.SourceText.CursorY, str);
            // форматирование строки
            if ImportConfigForm.LineFormat.Checked then LineFormat(posx, toknum);
            p:=0;
            case sz of
              1 : str:='.byte ';
              2 : str:='.hword ';
              4 : str:='.word ';
            end;
            Editor.SourceText.CursorY:=Editor.SourceText.CursorY+1;
          end;
        i:=i+1;
      end;
    if p<>0 then Editor.SourceText.Ins(Editor.SourceText.CursorY, str);
    // форматирование строки
    if ImportConfigForm.LineFormat.Checked then LineFormat(posx, toknum);
    Editor.SourceText.CursorY:=py;
  finally
    fs.free;
  end;
  ImportConfigForm.Free;
end;

// форматирование строки
procedure LineFormat(out xpos, toknum:integer);
var
  ST:TSourceText;
  Tokens:TTokenList;
  str:string;
  i:integer;
  labPresent:boolean;
  p21, p30, p50:integer;

//  xpos, toknum:integer; // позиция курсора в строке
begin
  ST:=TSourceText(Editor.SourceText);
  if ST=nil then exit;


  p21:=CodeFormatConfigForm.AsmComPos.Position; // позиция команды
  p30:=CodeFormatConfigForm.AsmParamPos; // позиция параметров
  p50:=CodeFormatConfigForm.RemPos.Position; // позиция комментариев

  // получим токены строки
  Tokens:=TTokenList(ST.GetLineTokens(ST.CursorY));
  toknum:=-1;
  xpos:=ST.CursorX;
  if (Tokens=nil) or (Tokens.Count<1) then exit;

  // определим позицию курсора в строке

  for i:=0 to Tokens.Count-1 do
    begin
      if TToken(Tokens.GetToken(i)).startPos<ST.CursorX+1 then toknum:=i;
    end;
  // в toknum -1 если курсор левее токена, или номер токена после которого стоит курсор
  if toknum=-1 then xpos:=ST.CursorX
  else xpos:=ST.CursorX-TToken(Tokens.GetToken(toknum)).startPos;
  // в xpos - смещение курсора относительно токена или начала строки

  str:='';

  // метки с начала строки через пробел
  i:=0; labPresent:=false;
  while (Tokens.Count>i+1) and (TToken(Tokens.GetToken(i)).tokStyle=tsLabSymb) and
            (TToken(Tokens.GetToken(i+1)).Text=':') do
      begin
        str:=str+TToken(Tokens.GetToken(i)).Text+': ';
        i:=i+2;
        labPresent:=true;
      end;

  // директива .equ
  if (i+1<Tokens.Count) and (utf8UpperCase(TToken(Tokens.GetToken(i)).Text)='.EQU') then
    begin
      if CodeFormatConfigForm.DirNamesUpperCase.Checked then str:=utf8UpperCase(TToken(Tokens.GetToken(i)).Text)
        else str:=TToken(Tokens.GetToken(i)).Text;

      str:=str+'  '+TToken(Tokens.GetToken(i+1)).Text;
      i:=i+2;
      // добьем пробелами до p30 символов
      while (UTF8Length(str)<p21) do str:=str+' ';

      // через пробел все остальное
      while i<Tokens.Count do
        begin
          if TToken(Tokens.GetToken(i)).tokStyle=tsRem then
            begin
              str:=str+'   ';
              while (UTF8Length(str)<p50) do str:=str+' '; // добьем пробелами до 50 символов
            end;

          if TToken(Tokens.GetToken(i)).Text<>',' then str:=str+' ';
          str:=str+TToken(Tokens.GetToken(i)).Text;
          i:=i+1;
        end;
       ST.SetLineStr(ST.CursorY, str);
       exit;
    end;

  // директива компилятора
  if (i<Tokens.Count) and (not labPresent) and
     (
       (utf8UpperCase(TToken(Tokens.GetToken(i)).Text)='.SYNTAX') OR
       (utf8UpperCase(TToken(Tokens.GetToken(i)).Text)='.THUMB') OR
       (utf8UpperCase(TToken(Tokens.GetToken(i)).Text)='.CPU') OR
       (utf8UpperCase(TToken(Tokens.GetToken(i)).Text)='.FPU') or
       (utf8UpperCase(TToken(Tokens.GetToken(i)).Text)='.SECTION') or
       (utf8UpperCase(TToken(Tokens.GetToken(i)).Text)='.ALIGN') or
       (utf8UpperCase(TToken(Tokens.GetToken(i)).Text)='.GLOBAL')
     ) then
      begin
        if CodeFormatConfigForm.DirNamesUpperCase.Checked then str:=utf8UpperCase(TToken(Tokens.GetToken(i)).Text)
              else str:=TToken(Tokens.GetToken(i)).Text;

        str:=str+' ';
        while (UTF8Length(str)<CodeFormatConfigForm.AsmOfsPos.Position) do str:=str+' ';
        i:=i+1;
        // через пробел все остальное
        while i<Tokens.Count do
          begin
            if TToken(Tokens.GetToken(i)).tokStyle=tsRem then
              begin
                str:=str+'  ';
                while (UTF8Length(str)<p30) do str:=str+' '; // добьем пробелами до 50 символов
              end;
            str:=str+TToken(Tokens.GetToken(i)).Text+' ';
            i:=i+1;
          end;
         ST.SetLineStr(ST.CursorY, str);
         exit;
      end;

  // директива компилятора
  if (i<Tokens.Count) and (not labPresent) and
       (utf8UpperCase(TToken(Tokens.GetToken(i)).Text)='.INCLUDE') then
      begin
        if CodeFormatConfigForm.DirNamesUpperCase.Checked then str:=utf8UpperCase(TToken(Tokens.GetToken(i)).Text)
              else str:=TToken(Tokens.GetToken(i)).Text;

        str:=str+'   ';
        while (UTF8Length(str)<CodeFormatConfigForm.AsmOfsPos.Position) do str:=str+' ';
        i:=i+1;
        // через пробел все остальное
        while i<Tokens.Count do
          begin
            if TToken(Tokens.GetToken(i)).tokStyle=tsRem then
              begin
                str:=str+'   ';
                while (UTF8Length(str)<p50+1) do str:=str+' '; // добьем пробелами до 50 символов
              end;
            str:=str+TToken(Tokens.GetToken(i)).Text+' ';
            i:=i+1;
          end;
         ST.SetLineStr(ST.CursorY, str);
         exit;
      end;

  // директива редактора
  if (i<Tokens.Count) and (not labPresent) and
       (TToken(Tokens.GetToken(i)).tokStyle=tsEdDir) then
      begin
        if CodeFormatConfigForm.DirNamesUpperCase.Checked then str:=utf8UpperCase(TToken(Tokens.GetToken(i)).Text)
              else str:=TToken(Tokens.GetToken(i)).Text;

        str:=str+' ';

        while (UTF8Length(str)<10) do str:=str+' ';
        i:=i+1;
        // через пробел все остальное
        while i<Tokens.Count do
          begin
            if (TToken(Tokens.GetToken(i)).Text<>'=') and
               ((i-1>=0) and (TToken(Tokens.GetToken(i-1)).Text<>'=')) then str:=str+' ';
            str:=str+TToken(Tokens.GetToken(i)).Text;
            i:=i+1;
          end;
         ST.SetLineStr(ST.CursorY, str);
         exit;
      end;

  // комментарии с начала строки не трогаем
  if (i<Tokens.Count) and (not labPresent) and
       (TToken(Tokens.GetToken(i)).tokStyle=tsRem) then exit;

  // добьем пробелами до 20 символов
  while (UTF8Length(str)<p21) do str:=str+' ';

  // директива или команда начиная с 21 символа
  if (Tokens.Count<=i) then exit;

  if (CodeFormatConfigForm.DirNamesUpperCase.Checked) and
       (TToken(Tokens.GetToken(i)).tokStyle=tsAsmDir)
     then str:=str+utf8UpperCase(TToken(Tokens.GetToken(i)).Text)+' '
  else
  if (CodeFormatConfigForm.AsmComUpperCase.Checked) and
               (TToken(Tokens.GetToken(i)).tokStyle=tsAsmCom)
             then str:=str+utf8UpperCase(TToken(Tokens.GetToken(i)).Text)+' '
  else str:=str+TToken(Tokens.GetToken(i)).Text+' ';

  i:=i+1;
  // добьем пробелами до 30 символов
  while (UTF8Length(str)<p30) do str:=str+' ';

  // через пробел все остальное
  while i<Tokens.Count do
    begin
      if TToken(Tokens.GetToken(i)).Text<>',' then str:=str+' ';

      if TToken(Tokens.GetToken(i)).tokStyle=tsRem then
        begin
          str:=str+'   ';
          while (UTF8Length(str)<p50) do str:=str+' '; // добьем пробелами до 50 символов
        end;

      if CodeFormatConfigForm.DirNamesUpperCase.Checked and
           (TToken(Tokens.GetToken(i)).tokStyle=tsAsmDir)
         then str:=str+utf8UpperCase(TToken(Tokens.GetToken(i)).Text)
      else
      if (CodeFormatConfigForm.AsmComUpperCase.Checked) and
         (TToken(Tokens.GetToken(i)).tokStyle=tsAsmCom)
         then str:=str+utf8UpperCase(TToken(Tokens.GetToken(i)).Text)
      else
      if (CodeFormatConfigForm.RegUpperCase.Checked) and
         (TToken(Tokens.GetToken(i)).tokStyle=tsReg)
         then str:=str+utf8UpperCase(TToken(Tokens.GetToken(i)).Text)
      else
      str:=str+TToken(Tokens.GetToken(i)).Text;

      i:=i+1;
    end;

  ST.SetLineStr(ST.CursorY, str);
end;

// установка кодировки файла
procedure SetSTCharSet(ST: TSourceText; charSet: string);
var
  i, ln:integer;
  tokens:TTokenList;
begin
  // ищем строку с указанием на кодировку
  ln:=-1;
  for i:=0 to ST.Count-1 do
     begin
       tokens:=TTokenList(ST.GetLineTokens(i));
       if (tokens.Count>0) and (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)='@.CHARSET') then
         begin
           ln:=i;
           break;
         end;
     end;

  if ln=-1 then ST.Ins(0, '@.CHARSET '+charSet)
  else  ST.SetLineStr(ln, '@.CHARSET '+charSet);
end;

// установка опций компиляции
procedure SetGNUOptions(ST: TSourceText; Project: TProject);
var
  posy:integer;
begin

  ST.URList.AddItem; // точка отмены изменений

   posy:=ST.CursorY;
   ST.Ins(posy, '@ GNU AS');

   posy:=posy+1;
   if Project.Project_Syntax<>'' then
     begin
       ST.Ins(posy, '.syntax '+Project.Project_Syntax);
       posy:=posy+1;
     end;
   if Project.Project_Cpu<>'' then
     begin
       ST.Ins(posy, '.cpu '+Project.Project_Cpu);
       posy:=posy+1;
     end;
   if Project.Project_Thumb<>'' then
     begin
       ST.Ins(posy, Project.Project_Thumb);
       posy:=posy+1;
     end;
   if Project.Project_Fpu<>'' then
     begin
       ST.Ins(posy, '.fpu '+Project.Project_Fpu);
       posy:=posy+1;
     end;

   ST.CursorY:=posy;
end;

// установка блока отладочной информации
procedure SetDebugBlock(ST: TSourceText);
begin
  ST.URList.AddItem; // точка отмены изменений

  ST.Ins(ST.CursorY, '@.DEBUG type=DEBUGINFO  label=debug  path=ROOT');
  ST.CursorY:=ST.CursorY+1;

  ST.Ins(ST.CursorY, '.align 4');
  ST.CursorY:=ST.CursorY+1;

  ST.Ins(ST.CursorY, 'debug:');
  ST.CursorY:=ST.CursorY+1;

  ST.Ins(ST.CursorY, '@.ENDDEBUG');
  ST.CursorY:=ST.CursorY+1;

end;


// установка отладочного адреса по типу
procedure SetDebugPointWord(ST: TSourceText; typstr: string);
begin
   ST.URList.AddItem; // точка отмены изменений

  ST.Ins(ST.CursorY, '      .word 0x20000000  @.DEBUG name="RAM START" type='+typstr);
  ST.CursorX:=13;

end;

// переключить блоки отладочной информации
procedure ToggleFileDebugBlock(ST: TSourceText);
var
  line:integer;
  tokens:TTokenList;
begin
  line:=0;
  while line<ST.Count do
    begin
       // ищем директиву @.DEBUG
       tokens:=TTokenList(ST.GetLineTokens(line));
       if (tokens.Count>0) and (TToken(tokens.GetToken(0)).tokType=ttEdDir) and
          (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)='@.DEBUG') then
          begin
            line:=line+1;
            // внутри директивы все комментим/декомментим пока не встретим @.ENDDEBUG
            while line<ST.Count do
              begin
                if (TTokenList(ST.GetLineTokens(line)).Count>0) then
                  begin
                    if (UTF8UpperCase(TToken(TTokenList(ST.GetLineTokens(line)).GetToken(0)).Text)='@.ENDDEBUG') then break;

                    if utf8Pos('@ ', ST.GetLineStr(line), 1)=1 then
                       ST.SetLineStr(line, UTF8Copy(ST.GetLineStr(line), 3, UTF8Length(ST.GetLineStr(line))-2))
                    else ST.SetLineStr(line, '@ '+ST.GetLineStr(line));
                  end;
                  line:=line+1;
              end;
          end;
       line:=line+1;
    end;
end;

// включить блоки отладочной информации
procedure SetOnFileDebugBlock(ST: TSourceText);
var
  line:integer;
  tokens:TTokenList;
begin
  line:=0;
  while line<ST.Count do
    begin
       // ищем директиву @.DEBUG
       tokens:=TTokenList(ST.GetLineTokens(line));
       if (tokens.Count>0) and (TToken(tokens.GetToken(0)).tokType=ttEdDir) and
          (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)='@.DEBUG') then
          begin
            line:=line+1;
            // внутри директивы все комментим/декомментим пока не встретим @.ENDDEBUG
            while line<ST.Count do
              begin
                if (TTokenList(ST.GetLineTokens(line)).Count>0) then
                  begin
                    if (UTF8UpperCase(TToken(TTokenList(ST.GetLineTokens(line)).GetToken(0)).Text)='@.ENDDEBUG') then break;

                    if utf8Pos('@ ', ST.GetLineStr(line), 1)=1 then
                       ST.SetLineStr(line, UTF8Copy(ST.GetLineStr(line), 3, UTF8Length(ST.GetLineStr(line))-2))
                  end;
                  line:=line+1;
              end;
          end;
       line:=line+1;
    end;
end;

// выключить блоки отладочной информации
procedure SetOffFileDebugBlock(ST: TSourceText);
var
  line:integer;
  tokens:TTokenList;
begin
  line:=0;
  while line<ST.Count do
    begin
       // ищем директиву @.DEBUG
       tokens:=TTokenList(ST.GetLineTokens(line));
       if (tokens.Count>0) and (TToken(tokens.GetToken(0)).tokType=ttEdDir) and
          (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)='@.DEBUG') then
          begin
            line:=line+1;
            // внутри директивы все комментим/декомментим пока не встретим @.ENDDEBUG
            while line<ST.Count do
              begin
                if (TTokenList(ST.GetLineTokens(line)).Count>0) then
                  begin
                    if (UTF8UpperCase(TToken(TTokenList(ST.GetLineTokens(line)).GetToken(0)).Text)='@.ENDDEBUG') then break;

                    if utf8Pos('@ ', ST.GetLineStr(line), 1)=0 then ST.SetLineStr(line, '@ '+ST.GetLineStr(line));
                  end;
                  line:=line+1;
              end;
          end;
       line:=line+1;
    end;
end;

function getSASMLabelLine(SASMST:TSourceText; labelName:string):integer;
var
  line:integer;
  tokens:TTokenList;
begin
   for line:=0 to SASMST.Count-1 do
     begin
       tokens:=TTokenList(SASMST.GetLineTokens(line));
       if (tokens<>nil) and
          (tokens.Count>3) and
          (TToken(tokens.GetToken(1)).Text='<') and
          (TToken(tokens.GetToken(2)).Text=labelName) and
          (TToken(tokens.GetToken(3)).Text='>') then
          begin
            Result:=line+1;
            exit;
          end;
     end;
   Result:=-1;
end;


// получаем адреса точек исходного файла
procedure GetFilePointsAdr(ST:TSourceText; pointAdr: TList);
var
  line:integer;
  labelName:string;
  str:string;
  SASMST:TSourceText;
  tokens:TTokenList;
  lineSASM:integer;
  PointInfo:TPointInfo;
begin
  SASMST:=EditorFiles.Open(Project.Out_Path+'\sys.sasm');
  if SASMST.Count=0 then exit; // файл дизассемблера прошивки отсутствует или пуст

  // начнем просматривать файл  в поиске директив отладчика
  line:=0;
  while line<ST.Count do
    begin
      // ищем директиву @.DEBUG
      tokens:=TTokenList(ST.GetLineTokens(line));
      if (tokens<>nil) and (tokens.Count>0) and (TToken(tokens.GetToken(0)).tokType=ttEdDir) and
         (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)='@.DEBUG') then
         begin
           labelName:=GetEdDirValue('LABEL', tokens, false); // получим имя метки для поиска
           lineSASM:=getSASMLabelLine(SASMST, labelName);
           if lineSASM<>-1 then
             repeat

             // чтение точки наблюдения
             if (tokens<>nil) and (tokens.Count>0)
                and (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)='.WORD') then
                   begin
                     PointInfo:=TPointInfo.Create;
                     //адрес в sys.sasm
                     PointInfo.adr:='0x'+TToken(TTokenList(SASMST.GetLineTokens(lineSASM)).GetToken(2)).Text;
                     lineSASM:=lineSASM+1;
                     PointInfo.name:=GetEdDirValue('NAME', tokens, false, 3);

                     str:=GetEdDirValue('TYPE', tokens, false,  3);
                     case UTF8UpperCase(str) of
                       'WORD':   PointInfo.ptype:=tptWord;
                       'HWORD':  PointInfo.ptype:=tptHWord;
                       'BYTE':   PointInfo.ptype:=tptByte;
                     end;

                     pointAdr.Add(PointInfo);
                   end;

             line:=line+1;
             if line=ST.Count then break;

             tokens:=TTokenList(ST.GetLineTokens(line));

           until ((tokens<>nil) and (tokens.Count>0) and (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)='@.ENDDEBUG'));
         end;
      line:=line+1;
    end;
end;

// получение информации о всех точках для чтения в отладчике
procedure GetPointsInfo(pointAdr: TList);
var
  ProjectFiles:TStringList;

  ST:TSourceText;
  filecounter:integer;
begin
  // найдем список файлов
  ProjectFiles:=FindAllFiles(Project.SourcePath, '*.asm;*.ASM; *.inc; *.INC', true);

  // перебираем все файлы для поиска маркеров точек наблюдения
  for filecounter:=0 to ProjectFiles.Count-1 do
    begin
      ST:=TSourceText(EditorFiles.Open(ProjectFiles.Strings[filecounter]));
      if ST.Count>0 then GetFilePointsAdr(ST, pointAdr);
    end;
end;



// поиск директивы по имени
function GetEditorDirective(name:string; var start:integer; ST:TSourceText):TTokenList;
var
  tokens:TTokenList;
begin
  while start<ST.Count do
    begin
      tokens:=TTokenList(ST.GetLineTokens(start));
      if (tokens.Count>0) and (TToken(tokens.GetToken(0)).tokType=ttEdDir) and
           (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)=name) then
        begin
          Result:=tokens;
          exit;
        end
      else start:=start+1;
    end;
  Result:=nil;
end;

// получить параметр директивы
function GetEdDirParam(paramName:string; tokens:TTokenList):string;
var
  i:integer;
begin
  i:=1;
  while i<tokens.Count-2 do
    if (UTF8UpperCase(TToken(tokens.GetToken(i)).Text)=paramName) and
       (TToken(tokens.GetToken(i+1)).Text='=') then
         begin
           Result:=TToken(tokens.GetToken(i+2)).Text;
           exit;
         end
    else i:=i+1;
  Result:='';
end;

// поиск директивы с заданым именем
function GetLineEdDirNamed(edDirname, nameEdDir:string; ST:TSourceText):integer;
var
  line:integer;
  tokens:TTokenList;
begin
  Result:=-1;
  line:=0;
  tokens:=TTokenList(GetEditorDirective(edDirname, line, ST));
  repeat
    if tokens=nil then exit; // директива edDirname не найдена
    if GetEdDirParam('NAME', tokens)=nameEdDir then Result:=line
    else line:=line+1;
    tokens:=TTokenList(GetEditorDirective(edDirname, line, ST));
  until (line>=ST.Count) or (Result>-1);
end;

// поиск директивы с заданым типом
function GetLineEdDirType(edDirname, typeEdDir:string; ST:TSourceText):integer;
var
  line:integer;
  tokens:TTokenList;
begin
  Result:=-1;
  line:=0;
  tokens:=TTokenList(GetEditorDirective(edDirname, line, ST));
  repeat
    if tokens=nil then exit; // директива edDirname не найдена
    if UTF8UpperCase(GetEdDirParam('TYPE', tokens))=typeEdDir then Result:=line
    else line:=line+1;
    tokens:=TTokenList(GetEditorDirective(edDirname, line, ST));
  until (line>=ST.Count) or (Result>-1);
end;


// поиск описания символа в файле
procedure GetSymbolDescFromFile(symbName:string; filename:string; desc:TStringList);
var
  ST:TSourceText;
  start:integer;
  tokens:TTokenList;
begin
  ST:=TSourceText(EditorFiles.Open(filename));
  // теперь найдем директиву @.desc
  start:=GetLineEdDirNamed('@.DESC', symbName, ST)+1;
  if start>0 then
  while (start<ST.Count) do
    begin
      tokens:=TTokenList(ST.GetLineTokens(start));
      if (tokens.Count>0) and
         (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)='@.ENDDESC') then exit;
      desc.Add(ST.GetLineStr(start));
      start:=start+1;
    end;
end;

// поиск описания в файле
procedure GetModuleDescFromFile(filename:string; desc:TStringList);
var
  ST:TSourceText;
  start:integer;
  tokens:TTokenList;
  str:string;
begin
  str:=MainForm.GetFullFromOfsFilename(filename, CurrentParseFileName); // получим полное имя включаемого файла

  ST:=TSourceText(EditorFiles.Get(str));
  // теперь найдем директиву @.desc
  start:=GetLineEdDirType('@.DESC', 'MODULE', ST)+1;
  if start>0 then
    begin
      desc.Add('Имя файла: '+str);
      while (start<ST.Count) do
        begin
          tokens:=TTokenList(ST.GetLineTokens(start));
            if (tokens.Count>0) and
               (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)='@.ENDDESC') then exit;
            desc.Add(ST.GetLineStr(start));
            start:=start+1;
        end;
    end;
end;

function GetSymbFileName(symbName:string; ST:TSourceText):TSymbol;
var
  i:integer;
  TextParser:TTextParser;
  SymbList:TSymbolList;
  symb:TSymbol;
begin
  symb:=nil;
  TextParser:=TTextParser(ST.TextParser);
  if (TextParser is TAsmTextParser) then
    begin
      // получим символы
      SymbList:=TSymbolList(TAsmTextParser(TextParser).FullSymbolList);
      for i:=0 to Project.GlobalSymbols.Count-1 do  // найдем глобальный символ в списке
        if TSymbol(Project.GlobalSymbols.GetSymb(i)).Name=symbName then
          begin
            symb:=TSymbol(Project.GlobalSymbols.GetSymb(i));
            Result:=symb;
            break;
          end;
      if symb=nil then // среди глобальных не нашли, ищем среди локальных
        for i:=0 to SymbList.Count-1 do  // найдем не глобальный символ в списке
          if TSymbol(SymbList.GetSymb(i)).Name=symbName  then
            begin
              symb:=TSymbol(SymbList.GetSymb(i));
               Result:=symb;
              break;
            end;
    end;

  Result:=symb;
end;

// получение информации о токене
procedure GetDescTokenInfo(ST:TSourceText; desc:TStringList);
var
  i, res:integer;
  tokens:TTokenList;
  tok:TToken;
  symb:TSymbol;
  str:string;
begin
  res:=-1;

  tokens:=ST.GetLineTokens(ST.CursorY); // получили токены строки
  if tokens=nil then exit;

  for i:=0 to tokens.Count-1 do
     begin
       tok:=TToken(tokens.GetToken(i));
       if (tok.startPos<=ST.CursorX) and (tok.startPos+tok.tokLen>=ST.CursorX) then
         begin
           res:=i;
           break;
         end;
     end;
  if res=-1 then exit; // токен не найден

  case tok.tokStyle of
    tsLabSymb: // символ, надо найти его описание
               begin
                 symb:=TSymbol(GetSymbFileName(tok.Text, ST));
                 if symb=nil then exit; // символ не найден
                 desc.Add(tok.Text);
                 GetSymbolDescFromFile(tok.Text, symb.filename, desc);
               end;
    tsParam:  // параметр директивы
               begin
                 // параметр .include ? (имя включаемого файла)
                 if (res>0) and (UTF8UpperCase(TToken(tokens.GetToken(i-1)).Text)='.INCLUDE') then
                   begin
                     str:=UTF8Copy(tok.Text, 2, UTF8Length(tok.Text)-2);
                     GetModuleDescFromFile(str, desc);
                   end;
               end;
  end;
end;

// показ описания токена
procedure DescTokenInfo(ST: TSourceText);
var
  desc:TStringList;
  DescForm:TDescForm;

begin
  desc:=TStringList.Create;

  GetDescTokenInfo(ST, desc);

  if desc.Count>1 then
    begin
      DescForm:=TDescForm.Create(MainForm);
      DescForm.Font:=MainForm.SymbolsStringGrid.Font;
      DescForm.Caption:=desc.Strings[0];
      desc.Delete(0);
      DescForm.Memo1.Text:=desc.Text;
      DescForm.AutoWidth;
      DescForm.ShowModal;
    end;
  desc.Free;
end;


// поиск имени файла для токена
function GetTokenFile(ST:TSourceText):string;
var
  i, res:integer;
  tokens:TTokenList;
  tok:TToken;
  symb:TSymbol;
  str:string;
begin
  res:=-1;
  Result:='';

  tokens:=ST.GetLineTokens(ST.CursorY); // получили токены строки
  if tokens=nil then exit;

  for i:=0 to tokens.Count-1 do
     begin
       tok:=TToken(tokens.GetToken(i));
       if (tok.startPos<=ST.CursorX) and (tok.startPos+tok.tokLen>=ST.CursorX) then
         begin
           res:=i;
           break;
         end;
     end;
  if res=-1 then exit; // токен не найден
  Result:='';
  case tok.tokStyle of
    tsLabSymb: // символ, надо найти его описание
               begin
                 symb:=TSymbol(GetSymbFileName(tok.Text, ST));
                 if symb=nil then exit; // символ не найден
                 Result:=symb.FileName;
               end;
    tsParam:  // параметр
               begin
                  if (res>0) and (UTF8UpperCase(TToken(tokens.GetToken(res-1)).Text)='.INCLUDE') then
                    begin // возможно это файл для .include
                      str:=UTF8Copy(tok.text, 2, UTF8Length(tok.text)-2);
                      Result:=MainForm.GetFullFromOfsFilename(str, ST.FileName);
                    end;
               end;
    tsAsmDir:  // директива
               begin
                  if (res+1<tokens.Count) and (UTF8UpperCase(TToken(tokens.GetToken(res)).Text)='.INCLUDE') and
                  (TToken(tokens.GetToken(res+1)).tokStyle=tsParam)
                    then
                      begin // возможно это файл для .include
                        tok:=TToken(tokens.GetToken(res+1));
                        str:=UTF8Copy(tok.text, 2, UTF8Length(tok.text)-2);
                        Result:=MainForm.GetFullFromOfsFilename(str, ST.FileName);
                      end;
               end;
  end;

end;

// открыть файл токена
procedure TokenFileOpen(ST: TSourceText);
var
  filename:string;
begin
  filename:=GetTokenFile(ST);
  if (filename='') or (not FileExists(filename)) then exit;

  HistoryFiles.AddHist(ST);
  EditorFiles.OpenInEditor(filename);
end;

// получение  информации о символе
function TokenDefInfo(ST:TSourceText):TSymbol;
var
  i, res:integer;
  tokens:TTokenList;
  tok:TToken;
  symb:TSymbol;

begin
  symb:=nil;
  Result:=symb;
  res:=-1;

  tokens:=ST.GetLineTokens(ST.CursorY); // получили токены строки
  if tokens=nil then exit;

  for i:=0 to tokens.Count-1 do
     begin
       tok:=TToken(tokens.GetToken(i));
       if (tok.startPos<=ST.CursorX) and (tok.startPos+tok.tokLen>=ST.CursorX) then
         begin
           res:=i;
           break;
         end;
     end;
  if res=-1 then exit; // токен не найден


  case tok.tokStyle of
    tsLabSymb: symb:=TSymbol(GetSymbFileName(tok.Text, ST));// символ, надо найти его описание
  end;
  Result:=symb;
end;

//открытие файла по символу
procedure SymbolOpenDef(symb:TSymbol; ST: TSourceText);
var
  STn:TSourceText;
  str:string;
begin
  HistoryFiles.AddHist(ST);

  str:=symb.FileName;

  STn:=TSourceText(EditorFiles.Open(str));
  STn.CursorY:=STn.GetSymbolLineNum(symb.Name);   // получим номер строки в тексте

  STn.FirstLineVisible:=STn.CursorY-5;
  if STn.FirstLineVisible<0 then STn.FirstLineVisible:=0;
  STn.CursorX:=TToken(TTokenList(STn.GetLineTokens(STn.CursorY)).GetToken(symb.TokenNum)).startPos-1;
  STn.TextSelect:=true;
  STn.TextSelectSY:=STn.CursorY; STn.TextSelectLY:=STn.CursorY;
  STn.TextSelectSX:=STn.CursorX; STn.TextSelectLX:=STn.CursorX+
  TToken(TTokenList(STn.GetLineTokens(STn.CursorY)).GetToken(symb.TokenNum)).tokLen;

  EditorFiles.OpenInEditor(STn);
end;


// F3 открыть определение
procedure TokenDef(ST: TSourceText);
var
  symb:TSymbol;
begin
  symb:=TokenDefInfo(ST);

  if symb=nil then exit;
  SymbolOpenDef(symb, ST);
end;


// получение полного текста файла с текстом инклудов
procedure GetFullFileText(FullText:TList);
var
   TextParser:TTextParser;
   i, l:integer;
   STIn:TSourceText;
begin
  TextParser:=TTextParser(Editor.SourceText.TextParser);
  if (Editor.SourceText=nil) or (not (TextParser is TAsmTextParser)) then exit;

  // перебираем все файлы для создания списка файлов для обработки
  for i:=0 to TAsmTextParser(TextParser).IncludeFileList.Count-1 do
    begin
      // получим файл
      STIn:=TSourceText(EditorFiles.Open(TAsmTextParser(TextParser).IncludeFileList.Strings[i]));
      for l:=0 to STIn.Count-1 do FullText.Add(STIn.GetLine(l));
    end;
end;


// поиск директивы в списке строк
function  SearchEdDirInList(FullText:TList; dirStr:string; var start:integer):TTokenList;
var
   tokens:TTokenList;
begin
  while start<FullText.Count do
    begin
      tokens:=TTokenList(TSourceLine(FullText.Items[start]).Tokens);
      if (tokens.Count>0) and (TToken(tokens.GetToken(0)).tokType=ttEdDir) and
           (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)=dirStr) then
        begin
          Result:=tokens;
          exit;
        end
      else start:=start+1;
    end;
  Result:=nil;
end;

function GetItemSymbols(confitem:string; FullText:TList):TSymbolList;
var
   i, t, k, y:integer;
   symblist:TSymbolList;
   SL:TSourceLine;
   tokens:TTokenList;
begin
  symblist:=TSymbolList.Create;
  Result:=symblist;

  for i:=0 to FullText.Count-1 do
    begin
       SL:=TSourceLine(FullText.Items[i]);
       tokens:=TTokenList(SL.Tokens);
       if (tokens.Count>0) and (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)='@.ITEM') then
         begin
           for t:=1 to tokens.Count-1 do
             if TToken(tokens.GetToken(t)).Text=confitem then
               begin // список найден
                 k:=i+1;
                 if k<FullText.Count then
                   repeat // копируем все последующие символы
                     SL:=TSourceLine(FullText.Items[k]);
                     for y:=0 to SL.SymbolsName.Count-1 do symblist.AddSymb(TSymbol(SL.SymbolsName.Objects[y]));
                     k:=k+1;
                   until (k>=FullText.Count) or (SL.SymbolsName.Count=0);

                 exit;
               end;
         end;
    end;
end;

// получить параметр директивы
function GetEdDirValue(paramName: string; tokens: TTokenList;
  casesens: boolean=true; start: integer=1): string;
var
  i:integer;

begin
  i:=start;

  while i<tokens.Count-2 do
    if ( casesens and
         (TToken(tokens.GetToken(i)).Text=paramName) and
           (TToken(tokens.GetToken(i+1)).Text='=')
       ) or
       ( (not casesens) and
         (UTF8UpperCase(TToken(tokens.GetToken(i)).Text)=paramName) and
         (TToken(tokens.GetToken(i+1)).Text='=')
       ) then
         begin
           Result:=TToken(tokens.GetToken(i+2)).Text;
           exit;
         end
    else i:=i+1;
  Result:='';
end;

function getTokenItem(ST: TSourceText; out tokPos:integer; out symbEdit:string):TSymbolList;
var
  FullText:TList;
  i, res, line:integer;
  tokens:TTokenList;
  tok:TToken;
  symbname, confitem:string;
  TextParser:TAsmTextParser;
  SymbList:TSymbolList;
begin
  Result:=nil;
  symbEdit:='';
  res:=-1;

  tokens:=ST.GetLineTokens(ST.CursorY); // получили токены строки

  if tokens=nil then exit;

  for i:=0 to tokens.Count-1 do
     begin
       tok:=TToken(tokens.GetToken(i));
       if (tok.startPos<=ST.CursorX) and (tok.startPos+tok.tokLen>=ST.CursorX) then
         begin
           res:=i;
           break;
         end;
     end;
  tokPos:=res;
  if res=-1 then exit; // токен не найден

  FullText:=TList.Create;
  GetFullFileText(FullText); // получим полный текст файла с инклудами



  if (res-3>=0) and (UTF8UpperCase(TToken(tokens.GetToken(res-3)).Text)='.EQU') and
                (TToken(tokens.GetToken(res-1)).Text=',') then
    begin // объявление .equ - ищем настройку для объявляемого символа в @.config
      symbname:=TToken(tokens.GetToken(res-2)).Text;  // имя символа для изменения
      line:=0;
      repeat
        tokens:=TTokenList(SearchEdDirInList(FullText, '@.CONFIG', line));
        if tokens=nil then confitem:=''
                       else confitem:=GetEdDirValue(symbname, tokens);
        if confitem<>'' then
          begin
            Result:=TSymbolList(GetItemSymbols(confitem, FullText));
            symbEdit:=symbname;
            FullText.Free;
            exit;
          end else line:=line+1;
      until (line>=FullText.Count);
//      symbEdit:='';
    end
  else
  if (res-1>=0) and (UTF8UpperCase(TToken(tokens.GetToken(res-1)).Text)='.INCLUDE') then
    begin // .include - нужно задать имя файла
      symbname:=TToken(tokens.GetToken(res)).Text;  // имя символа для изменения
      tokPos:=res-1;
      symbEdit:=symbname;
      Result:=nil;
    end
  else
  if (UTF8UpperCase(TToken(tokens.GetToken(res)).Text)='.INCLUDE') then
    begin // .include - нужно задать имя файла
      tokPos:=res; // + 1;
      if tokens.Count>res+1 then symbname:=TToken(tokens.GetToken(res+1)).Text  // имя символа для изменения
                                 else symbname:='Указать файл';
      symbEdit:=symbname;
      Result:=nil;
    end
  else
    begin  // просто имя символа - ищем его группу
      TextParser:=TAsmTextParser(ST.TextParser);
      symbname:=TToken(tokens.GetToken(res)).Text;  // имя символа для изменения
      // получим символы
      SymbList:=TSymbolList(TAsmTextParser(TextParser).FullSymbolList);
      for i:=0 to SymbList.Count-1 do
        if (TSymbol(SymbList.GetSymb(i)).Name=symbname) and
           (TSymbol(SymbList.GetSymb(i)).itemNames.Count>0) then
          begin
            confitem:=TSymbol(SymbList.GetSymb(i)).itemNames.Strings[0];
            symbEdit:=symbname;
            Result:=TSymbolList(GetItemSymbols(confitem, FullText));
            FullText.Free;
            exit;
          end;
    end;

  FullText.Free;
end;

// F4 Изменить
procedure TokenEdit(ST: TSourceText);
var
  res, b, e:integer;
  symbolItems:TSymbolList;
  EditValueForm:TEditValueForm;
  str, str1:string;
begin
  symbolItems:=getTokenItem(ST, res, str);

  if str='' then exit;

  if symbolItems=nil then
    begin // редактирование имени файла
      MainForm.OpenDialog1.InitialDir:=ExtractFilePath(Project.SourcePath+'\');
      MainForm.OpenDialog1.FilterIndex:=4;
      if MainForm.OpenDialog1.Execute then
        begin
//          strt1:=UTF8LowerCase(MainForm.OpenDialog1.FileName);
//          strt2:=Project.Project_Path;
          e:=UTF8Pos(Project.Project_Path, UTF8LowerCase(MainForm.OpenDialog1.FileName), 1);
          if UTF8Pos(Project.Project_Path, UTF8LowerCase(MainForm.OpenDialog1.FileName), 1)=1 then
            begin
              str1:='"'+UTF8Copy(MainForm.OpenDialog1.FileName,
                   UTF8Length(Project.Project_Path),
                   UTF8Length(MainForm.OpenDialog1.FileName)-UTF8Length(Project.Project_Path)+1)+'"';
              str1:=StringReplace(str1, '\', '/', [rfReplaceAll]);

              str:=ST.GetLineStr(ST.CursorY);
              if TTokenList(ST.GetLineTokens(ST.CursorY)).Count>res+1 then
                 begin;
                   b:=TToken(ST.GetLineTokens(ST.CursorY).GetToken(res+1)).startPos;
                   e:=TToken(ST.GetLineTokens(ST.CursorY).GetToken(res+1)).tokLen;
                 end
              else
              begin;
                b:=TToken(ST.GetLineTokens(ST.CursorY).GetToken(res)).startPos+8;
                e:=0;
                str1:='  '+str1;
              end;

              if e>0 then UTF8Delete(str, b, e);
              UTF8Insert(str1, str, b);
              ST.URList.AddItem;
              ST.SetLineStr(ST.CursorY, str);
              // выделим изменения
              if e=0 then b:=b+2;
              ST.TextSelect:=true;
              ST.TextSelectSX:=b-1;
              ST.TextSelectLX:=b+TToken(ST.GetLineTokens(ST.CursorY).GetToken(res+1)).tokLen-1;
              ST.TextSelectSY:=ST.CursorY;
              ST.TextSelectLY:=ST.CursorY;
            end;
        end;
    end
  else
    begin
      if (symbolItems=nil) or (symbolItems.Count=0) then exit; // если варианты не найдены просто выходим

      // запустим форму выбора значения
      EditValueForm:=TEditValueForm.Create(MainForm);
      EditValueForm.SetData(symbolItems);
      EditValueForm.StringGrid1.Color:=MainForm.SymbolsStringGrid.Color;
      EditValueForm.StringGrid1.Font:=MainForm.SymbolsStringGrid.Font;
      EditValueForm.Memo1.Color:=EditValueForm.StringGrid1.Color;
      EditValueForm.Memo1.Font:=EditValueForm.StringGrid1.Font;
      if EditValueForm.ShowModal=mrOk then
        begin
          str:=ST.GetLineStr(ST.CursorY);
          b:=TToken(ST.GetLineTokens(ST.CursorY).GetToken(res)).startPos;
          e:=TToken(ST.GetLineTokens(ST.CursorY).GetToken(res)).tokLen;
          UTF8Delete(str, b, e);
          UTF8Insert(EditValueForm.SymbName, str, TToken(ST.GetLineTokens(ST.CursorY).GetToken(res)).startPos);
          ST.URList.AddItem;
          ST.SetLineStr(ST.CursorY, str);
          // выделим изменения
          ST.TextSelect:=true;
          ST.TextSelectSX:=b-1;
          ST.TextSelectLX:=b+TToken(ST.GetLineTokens(ST.CursorY).GetToken(res)).tokLen-1;
          ST.TextSelectSY:=ST.CursorY;
          ST.TextSelectLY:=ST.CursorY;
        end;
    end;
end;

// получить токен на котором стоит курсор
function GetCursorToken(ST: TSourceText; out tokNum: integer): TToken;
var
  i:integer;
  tokens:TTokenList;
  tok:TToken;
  str:string;
  posx:integer;
begin
  Result:=nil;

  posx:=ST.CursorX;
  str:=ST.GetLineStr(ST.CursorY)+' ';
  if (posx+1<=UTF8Length(str)) and  // строка длинее позиции курсора
      (UTF8Copy(str, posx+1, 1)=' ') and// в позиции курсора стоит пробел
        (UTF8Copy(str, posx, 1)<>' ')
         then posx:=posx-1; // двинем курсор левее

  tokNum:=-1;
  tokens:=ST.GetLineTokens(ST.CursorY); // получили токены строки
  if tokens=nil then exit;

  for i:=0 to tokens.Count-1 do
       begin
         tok:=TToken(tokens.GetToken(i));
         if (tok.tokType=ttChars) and (tok.startPos<=posx+1) and (tok.startPos+tok.tokLen-1>=posx+1) then
           begin
             tokNum:=i;
             break;
           end;
       end;

  if tokNum=-1 then Result:=nil
               else Result:=TToken(tokens.GetToken(tokNum));
end;

// поиск секции по имени в указанном направлении
// если direct = true - то поиск с конца
function SearchSection(secName: string; out line, next:integer): boolean;
var
  ST:TSourceText;
  i:integer;
  tokens:TTokenList;
begin
  Result:=false;

  ST:=TSourceText(Editor.SourceText);

  i:=0;
  line:=-1;
  next:=-1;

  // поиск секции
  while (i<ST.Count) do
    begin
      tokens:=TTokenList(ST.GetLineTokens(i));
      if (tokens.Count>1) and
         (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)='.SECTION') then
         begin
           if (UTF8UpperCase(TToken(tokens.GetToken(1)).text)=UTF8UpperCase(secName)) then
             begin
               Result:=true;
               line:=i;
             end
           else
             if line<>-1 then
               begin
                 next:=i;
                 exit;
               end;
         end;
      i:=i+1;
    end;
end;

// поиск секции выше курсора
function SearchUpSection(out line:integer): boolean;
var
  ST:TSourceText;
  i:integer;
  tokens:TTokenList;
begin
  Result:=false;

  ST:=TSourceText(Editor.SourceText);

  i:=ST.CursorY;
  line:=i;

  // поиск секции
  while (i>=0) do
    begin
      tokens:=TTokenList(ST.GetLineTokens(i));
      if (tokens.Count>1) and
         (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)='.SECTION') then
         begin
           Result:=true;
           line:=i;
           exit;
         end;
      i:=i-1;
    end;
end;

// добавить секцию
function addSection(secName: string): integer;
var
  ST:TSourceText;
begin
   ST:=TSourceText(Editor.SourceText);
   ST.URList.AddItem;
   ST.Add('.section '+secName);
   Result:=ST.Count-1;
end;

//добавить строку в текст
procedure InsertTextLine(line: integer; str: string);
var
  ST:TSourceText;
begin
   ST:=TSourceText(Editor.SourceText);
   ST.URList.AddItem;
   if ST.Count>line then ST.Ins(line, str) else ST.Add(str);
   if line<ST.CursorY then ST.CursorY:=ST.CursorY+1;
end;

end.

