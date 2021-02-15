unit AsmTextParserUnit;


// Класс рабора программы на ассемблера

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, TextParserUnit, IniFiles, LazUTF8,
  AsmTextRulesUnit,
  TokensUnit,
  SymbolsUnit,
  SourceLineUnit;

type

  { TRuleList }
  // список правил
  TRuleList = class(TObject)
  private
    RuleFile: string;  // имя списка правил (не имя файла !)

    List: TStringList; // список правил разбора

    function SearchRule(tokenStr: string; out Rule: TAsmTextRule): boolean; // поиск вхождения токена в имя правила

  public

    constructor Create;
    destructor Free;

    procedure Load(filename: string);

    procedure ProcessLine(SL: TSourceLine);   // обработка строки

  end;

  { TAsmTextParser }

  TAsmTextParser = class(TTextParser)
  private
    FFileName:string;

    FL_FullParse:boolean;

    RuleList: TRuleList;             // класс разбора текста

  public
    FileSymbolList: TSymbolList;         // символы файла

    FullSymbolList: TSymbolList;         // все символы файла с инклудами
    IncludeFileList:TStringList;         // все имена файлов включая self
    NewSymbolList:boolean;

    constructor Create(LN: TList); override;
    destructor Free; override;

    procedure SetFileName(filename:string);

    procedure Clear; override;
    procedure Parse(num: integer); override;
    procedure Del(num: integer); override;

    procedure ParseOff; override;
    procedure ParseOn; override;

    procedure ShortParse;         override;
    procedure FullParse;          override;

    procedure ParseFileSymbols;   // парсинг символов объявленных в файле
    procedure ParseFullSymbols(FullSymbols, incFileSymbols:TSymbolList; incFiles:TStringList);

    procedure SectionReload;      // повторная проверка .section
  end;

implementation

uses MainUnit, ConfigUnit, ProjectUnit;

{ TAsmTextParser }

// простое получение списка символов текущего файла и списка файлов включений
procedure TAsmTextParser.ParseFileSymbols;
var
  i, p, k:integer;
  SL:TSourceLine;
  symb:TSymbol;
  str:string;
  res:boolean;
  AddFileSymb:TSymbolList;
  tokens:TTokenList;
  itemList:TStringList;
begin
  FileSymbolList.Clear; // очистим список
  Project.ClearFileGlobalSymbols(FFileName); // очистим список глобальных символов
  FullSymbolList.Clear;  // выходной список  символов
  IncludeFileList.Clear;
  IncludeFileList.Add(FFileName); // имя текущего файла
  NewSymbolList:=true;

  itemList:=TStringList.Create;

  // перебираем все строки строки
  for i:=0 to Lines.Count-1 do
  begin
    SL:=TSourceLine(Lines.Items[i]); // берем строку текста

    if (SL.SymbolsName.Count=0) and (itemList.Count>0) then
      begin
         itemList:=TStringList.Create;
      end;
    tokens:=TTokenList(SL.Tokens);
    if (tokens<>nil) and (tokens.Count>0) and (UTF8UpperCase(TToken(tokens.GetToken(0)).Text)='@.ITEM') then
      begin  // item для символов
         for p:=1 to tokens.Count-1 do
           if tokens.GetToken(p).tokType<>ttRem then itemList.Add(TToken(tokens.GetToken(p)).Text)
           else break;
      end;

    for p:=0 to SL.SymbolsName.Count-1 do
      begin
        symb:=TSymbol(SL.SymbolsName.Objects[p]);
        if symb.Name<>'' then
        begin
          symb.FileName:=FFileName;
          symb.itemNames:=itemList;   // список item в которые входит символ
          if symb.Typ=stGlobalLabel then Project.GlobalSymbols.AddSymb(symb)
          else
            begin
              FileSymbolList.AddSymb(symb);
              FullSymbolList.AddSymb(symb);
            end
        end
        else  // включаемый файл
//        if symb.Name='' then
        begin
          FileSymbolList.AddSymb(symb);

          str:=MainForm.GetFullFromOfsFilename(symb.FileName, FFileName);

          res:=false;
          for k:=0 to IncludeFileList.Count-1 do
            if str=IncludeFileList.Strings[k] then
               begin
                 res:=true;
                 break;
               end;

          if not res then
            begin
              IncludeFileList.Add(str);  // добавим имя файла символы которого были обработаны

              // если файл еще не обрабатывался - то обработаем его
              AddFileSymb:=TSymbolList(MainForm.GetFileLabels(str));

              ParseFullSymbols(FullSymbolList, AddFileSymb, IncludeFileList);
            end;
        end
      end;
  end;
end;

// сбор символов в FullSymbols из incFileSymbols
procedure TAsmTextParser.ParseFullSymbols(FullSymbols, incFileSymbols: TSymbolList;
   incFiles: TStringList);
var
  i, p:integer;
  symb:TSymbol;
  str:string;
  res:boolean;
  AddFileSymb:TSymbolList;
begin
  // перебираем символы включаемого файла
  for i:=0 to incFileSymbols.Count-1 do
    begin
      symb:=TSymbol(incFileSymbols.GetSymb(i));
      if symb.Name='' then // включаемый файл
        begin
          str:=MainForm.GetFullFromOfsFilename(symb.FileName, FFileName);

          res:=false;
          for p:=0 to incFiles.Count-1 do
            if str=incFiles.Strings[p] then
               begin
                 res:=true;
                 break;
               end;
          if not res then
            begin
              incFiles.Add(str);  // добавим имя файла символы которого были обработаны

              // если файл еще не обрабатывался - то обработаем его
              AddFileSymb:=TSymbolList(MainForm.GetFileLabels(str));

              ParseFullSymbols(FullSymbols, AddFileSymb, incFiles);
            end;
        end
      else                 // символ
        begin
          FullSymbols.AddSymb(symb);
        end;
    end;
end;



// конструктор
constructor TAsmTextParser.Create(LN: TList);
var
  stmcore:string;
begin
  inherited Create(LN);

  FileSymbolList := TSymbolList.Create;
  FullSymbolList:=TSymbolList.Create;
  IncludeFileList:=TStringList.Create;

  FL_FullParse:=false;

  // обработчик правил ассемблера
  RuleList := TRuleList.Create;
  if Project.Project_Opened then stmcore:=Project.Project_Cpu
                            else stmcore:=Config.Default_AsmDecode;
  RuleList.Load(stmcore);
end;

// деструктор
destructor TAsmTextParser.Free;
begin
  inherited Free;

  RuleList.Free;
  FileSymbolList.Free;
  FullSymbolList.Free;
  IncludeFileList.Free;
end;

procedure TAsmTextParser.SetFileName(filename: string);
begin
  FFileName:=filename;
end;

// очистка состояния
procedure TAsmTextParser.Clear;
var
  num: integer;
begin
  FileSymbolList.Clear; // очистим список символов текста

  for num := 0 to Lines.Count - 1 do
    TTokenList(TSourceLine(Lines.Items[num]).GetTokens).Clear;

end;

// разбор строки
procedure TAsmTextParser.Parse(num: integer);
var
  Tokens: TTokenList;
  SL: TSourceLine;
begin
  SL := TSourceLine(Lines.Items[num]);  // строка

  SL.SymbolsName.Clear;  // очистим список символов

  Tokens := TTokenList(SL.GetTokens);   // токены
  Tokens.Clear;                         // очистим список токенов
  Tokens.ParseLineStr(SL.GetStr);

  // проведем парсинг символов строки
  RuleList.ProcessLine(SL{, SymbolList});

  if FL_FullParse then ParseFileSymbols;
end;

procedure TAsmTextParser.Del(num: integer);
var
  SL: TSourceLine;
begin
  SL := TSourceLine(Lines.Items[num]);

  SL.SymbolsName.Clear;

  // очистим токены в строке
  TTokenList(SL.GetTokens).Clear;

  if FL_FullParse then ParseFileSymbols;
end;

procedure TAsmTextParser.ParseOff;
begin
  inherited ParseOff;
end;

procedure TAsmTextParser.ParseOn;
begin
  inherited ParseOn;
end;

procedure TAsmTextParser.ShortParse;
begin
  FL_FullParse:=false;
end;

procedure TAsmTextParser.FullParse;
begin
  FL_FullParse:=true;
  ParseFileSymbols;
end;

// повторная проверка .section
procedure TAsmTextParser.SectionReload;
var
  i:integer;
  SL:TSourceLine;
  tokList:TTokenList;
begin
  for i:=0 to Lines.Count-1 do
    begin
      SL:=TSourceLine(Lines.Items[i]);
      if SL.Tokens.Count>0 then
        begin
          tokList:=TTokenList(SL.Tokens);
          if UTF8UpperCase(TToken(tokList.GetToken(0)).Text)='.SECTION' then
             Parse(i);
        end;
    end;
end;

// -----------------------------------------------------

//  Классы для разбора текста как исходник ассемблера

// -----------------------------------------------------

// создание списка правил
constructor TRuleList.Create;
begin
  List := TStringList.Create;
end;

//  загрузка списка правил
procedure TRuleList.Load(filename: string);
var
  inif: TIniFile;
  rlist: TStringList;
  i, r, t: integer;
  Rule: TAsmTextRule;
  ruleType, str: string;
  itemType:TTokenStyle;
  tmpList:TList;
begin
  RuleFile:=filename;

  inif := TIniFile.Create(app_path + 'inf\' + filename + '.ini');

  rlist := TStringList.Create;

  tmpList:=TList.Create; // временный список объектов

  inif.ReadSections(rlist); // загружаем список секций
  // перебираем список секций
  for i := 0 to rlist.Count - 1 do
  begin
    // имя правила в rlist.strings[i]
    ruleType := inif.ReadString(rlist.strings[i], 'type', '');
    if ruleType <> '' then
    begin
      case UTF8UpperCase(ruleType) of
        'TOKENLIST':  Rule:=TAsmTextRule_TokenList.Create(rlist.strings[i]);
        'TOKENMAYBE': Rule:=TAsmTextRule_TokenMayBe.Create(rlist.strings[i]);
         'TOKENONE':  Rule:=TAsmTextRule_TokenOne.Create(rlist.strings[i]);
       'TOKENSPLIT':  Rule:=TAsmTextRule_TokenSplit.Create(rlist.strings[i]);
       'TOKENPARTS':  Rule:=TAsmTextRule_TokenParts.Create(rlist.strings[i]);
       'PARTSONE':    Rule:=TAsmTextRule_PartsOne.Create(rlist.strings[i]);
       'PARTSMAYBE':  Rule:=TAsmTextRule_TokenPartsMayBe.Create(rlist.strings[i]);
       'EXPRESSION':  Rule:=TAsmTextRule_Expression.Create(rlist.strings[i]);
       'EXPRESSIONLIST': Rule:=TAsmTextRule_ExpressionList.Create(rlist.strings[i]);
       'REGISTER'  :  Rule:=TAsmTextRule_Register.Create(rlist.strings[i]);
       'REGISTERLIST'  : Rule:=TAsmTextRule_RegisterList.Create(rlist.strings[i]);
       'DEFINESYMBOL'  : Rule:=TAsmTextRule_DefineSymbol.Create(rlist.strings[i]);
       'STRING'    :  Rule:=TAsmTextRule_String.Create(rlist.strings[i]);
       'STRINGLIST':  Rule:=TAsmTextRule_StringList.Create(rlist.strings[i]);
       'INCLUDEFILE': Rule:=TAsmTextRule_IncludeFile.Create(rlist.strings[i]);
       'SECTION':     Rule:=TAsmTextRule_Section.Create(rlist.strings[i]);
      end;

      if UTF8Copy(rlist.strings[i], 1, 1)='$' then tmpList.Add(Rule)
        else List.AddObject(rlist.strings[i], Rule);

      // загрузка частей правила
      r := 0;
      while inif.ReadString(rlist.strings[i], 'item' + IntToStr(r), '') <> '' do
        begin
          str:= inif.ReadString(rlist.strings[i], 'item' + IntToStr(r), '');

          case UTF8UpperCase(inif.ReadString(rlist.strings[i], 'item' + IntToStr(r)+'type', '')) of
            'REM'    : itemType:=tsRem;      // примечание
            'ASMDIR' : itemType:=tsAsmDir;   // директива ассемблера
            'EDDIR'  : itemType:=tsEdDir;    // директива редактора
            'PARAM'  : itemType:=tsParam;    // параметры директив редактора или ассемблера
            'ASMCOM' : itemType:=tsAsmCom;   // команда ассемблера
            'DELIM'  : itemType:=tsDelim;    // разделитель
            'LABSYMB': itemType:=tsLabSymb;  // символ\метка
            'REG'    : itemType:=tsReg;      // регистр
            'NUM'    : itemType:=tsNum;      // число
            'STRING' : itemType:=tsString;   // строка
            else       itemType:=tsNone;
          end;
        if UTF8Pos('$', str, 1)=1 then
          begin
            for t:=0 to tmpList.Count-1 do
              if TAsmTextRule(tmpList.Items[t]).name=str then
              Rule.AddItem('', TAsmTextRule(tmpList.Items[t]), itemType);
          end else Rule.AddItem(str, nil, itemType);
        r := r + 1;
      end;
    end;
  end;
  while tmpList.Count>0 do tmpList.Delete(0); tmpList.Free;
  rlist.Free;
  inif.Free;
end;

// поиск вхождения токена в имя правила
function TRuleList.SearchRule(tokenStr: string; out Rule: TAsmTextRule): boolean;
var
  i: integer;
begin
  Result:=false;

  for i :=0 to List.Count - 1 do
      if (UTF8Pos(TAsmTextRule(List.Objects[i]).Name, tokenStr) = 1) then
      begin
        Result:=true;
        Rule:=TAsmTextRule(List.Objects[i]);
        exit;
      end;
end;

// обработка строки
procedure TRuleList.ProcessLine(SL: TSourceLine); //; Symbols: TSymbolList);
var
  TokenList: TTokenList;
  i, posx: integer;
  tokStr: string;
  StartRule:TAsmTextRule;
  processed:boolean;
  asmcompres:boolean;
  symb:TSymbol;
begin
  TokenList := TTokenList(SL.GetTokens);
  SL.LineErr:=false;
  SL.LineErrStr:='';

  i := 0;
  asmcompres:=false; // команда ассемблера еще не обрабатывалась
  while i < TokenList.Count do
    begin
      processed:=false;
      tokStr := UTF8UpperCase(TToken(TokenList.GetToken(i)).Text);
      // объявление метки
      if (i + 1 < TokenList.Count) and
         TToken(TokenList.GetToken(i)).isSymbol and
            (TToken(TokenList.GetToken(i+1)).Text = ':') then
        begin
          // добавим символ
          symb:=TSymbol.Create(TToken(TokenList.GetToken(i)).Text, i, SL);
          SL.SymbolsName.AddObject(TToken(TokenList.GetToken(i)).Text, symb);

          TToken(TokenList.GetToken(i)).tokStyle:=tsLabSymb;

          i:=i+2;
          processed:=true;
        end
      else // строчный комментарий
      if TToken(TokenList.GetToken(i)).tokType=ttRem then
        begin
          TToken(TokenList.GetToken(i)).tokStyle:=tsRem;
          i:=i+1;
          processed:=true;
        end
      else // директива редактора
      if TToken(TokenList.GetToken(i)).tokType=ttEdDir then
        begin
          TToken(TokenList.GetToken(i)).tokStyle:=tsEdDir;
          i:=i+1;
          processed:=true;
          while i<TokenList.Count do
            begin
              TToken(TokenList.GetToken(i)).tokStyle:=tsRem;
              i:=i+1;
            end;
        end
      else // ищем правило обработки для токена
          if SearchRule(tokStr, StartRule) and (not asmcompres) then
            begin

              processed:=StartRule.Process(SL, {Symbols,} TokenList, i, posx{%H-});
              if processed then asmcompres:=true
              else
                begin
                  SL.LineErr:=true;
                  SL.LineErrStr:='Строка не распознана';
                end;
            end;

      if not processed then // если есть что то не обработанное - то это уже ошибка
        begin
          // сохраним позицию ошибки в строке
          SL.LineErr:=true;
          SL.LineErrStr:='Строка не распознана';
          if i<TokenList.Count then SL.TokenErrNum:=i else SL.TokenErrNum:=-1;

          while i<TokenList.Count do
            begin
              TToken(TokenList.GetToken(i)).tokStyle:=tsErr;
              i:=i+1;
            end;
        end;
  end;

end;

destructor TRuleList.Free;
begin
  while List.Count > 0 do
  begin
    TAsmTextRule(List.Objects[0]).Free;
    List.Delete(0);
  end;
  List.Free;
end;

end.
