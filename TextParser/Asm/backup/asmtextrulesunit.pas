unit AsmTextRulesUnit;

//
// Базовый класс правил разбора  текста
//
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8,
  TokensUnit,
  SourceLineUnit,
  SymbolsUnit;
//  EditorFilesUnit, // все открытые файлы
//  ProjectUnit;     // открытый проект

type

  // базовый класс правил рабора текста
  { TAsmTextRule }

  TAsmTextRule=class(TObject)
     protected
       List:TList;

     public
         name:string;

         constructor Create(rule_name: string); virtual;
         destructor  Free;                      virtual;

         procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); virtual;

         function    Process(SL: TSourceLine; {Symbols: TSymbolList;}
      Tokens: TTokenList; var tokenPos: integer; var charPos: integer): boolean; virtual; abstract;
  end;

  { TAsmTextRuleItem }
  // одно подправило в правиле TRule
  TAsmTextRuleItem=class(TObject)
    public
      text:string;
      itemType:TTokenStyle;
      Rule:TAsmTextRule;

      constructor Create(txt: string; outType: TTokenStyle; AddRule: TAsmTextRule);
      destructor  Free;
  end;

  // правило для директивы .SECTION

   { TAsmTextRule_Section }

   TAsmTextRule_Section=class(TAsmTextRule)
    public
      constructor Create(rule_name: string); override;
      destructor  Free;                      override;

      procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

      function    Process({%H-}SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
            var tokenPos: integer; var {%H-}charPos: integer): boolean; override;
   end;

   { TAsmTextRule_TokenList }
   // правило из списка правил для наборов токенов
   TAsmTextRule_TokenList=class(TAsmTextRule)
    public
      constructor Create(rule_name: string); override;
      destructor  Free;                      override;

      procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

      function    Process(SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
            var tokenPos: integer; var charPos: integer): boolean; override;
   end;

   { TAsmTextRule_TokenMayBe }

   TAsmTextRule_TokenMayBe=class(TAsmTextRule)
    public
      constructor Create(rule_name: string); override;
      destructor  Free;                      override;

      procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

      function    Process(SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
            var tokenPos: integer; var charPos: integer): boolean; override;
   end;

   { TAsmTextRule_TokenOne }
   // правило из вариантов правил, возможен только один вариант
   TAsmTextRule_TokenOne=class(TAsmTextRule)
    public
      constructor Create(rule_name: string); override;
      destructor  Free;                      override;

      procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

      function    Process(SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
            var tokenPos: integer; var charPos: integer): boolean; override;
   end;

    { TAsmTextRule_TokenSplit }
    // правило объединения нескольких токенов в один с проверкой
   TAsmTextRule_TokenSplit=class(TAsmTextRule)
    public
      constructor Create(rule_name: string); override;
      destructor  Free;                      override;

      procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

      function    Process({%H-}SL: TSourceLine; {{%H-}Symbols: TSymbolList;} Tokens: TTokenList;
            var tokenPos: integer; var {%H-}charPos: integer): boolean; override;
   end;

   { TAsmTextRule_TokenParts }
   // проверка одного токена на вхождение подстрок
  TAsmTextRule_TokenParts=class(TAsmTextRule)
   public
     constructor Create(rule_name: string); override;
     destructor  Free;                      override;

     procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

     function    Process(SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
           var tokenPos: integer; var charPos: integer): boolean; override;
  end;

  // проверка на обязательное вхождение подстроки в токен

   { TAsmTextRule_PartsOne }

   TAsmTextRule_PartsOne=class(TAsmTextRule)
   public
     constructor Create(rule_name: string); override;
     destructor  Free;                      override;

     procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

     function    Process(SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
           var tokenPos: integer; var charPos: integer): boolean; override;
  end;

   { TAsmTextRule_TokenPartsMayBe }
   // проверка на возможное вхождение токена в строку
   TAsmTextRule_TokenPartsMayBe=class(TAsmTextRule)
   public
     constructor Create(rule_name: string); override;
     destructor  Free;                      override;

     procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

     function    Process(SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
           var tokenPos: integer; var charPos: integer): boolean; override;
  end;


   { TAsmTextRule_Expression }

   // значение

   TAsmTextRule_Expression=class(TAsmTextRule)
   public
     constructor Create(rule_name: string); override;
     destructor  Free;                      override;

     procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

     function    Process({%H-}SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
           var tokenPos: integer; var {%H-}charPos: integer): boolean; override;
  end;

      // выражение

      { TAsmTextRule_ExpressionList }

      TAsmTextRule_ExpressionList=class(TAsmTextRule)
      public
        constructor Create(rule_name: string); override;
        destructor  Free;                      override;

        procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

        function    Process(SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
              var tokenPos: integer; var charPos: integer): boolean; override;
     end;

      // одиночный регистр

      { TAsmTextRule_Register }

      TAsmTextRule_Register=class(TAsmTextRule)
      public
        constructor Create(rule_name: string); override;
        destructor  Free;                      override;

        procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

        function    Process({%H-}SL: TSourceLine; {{%H-}Symbols: TSymbolList;} Tokens: TTokenList;
              var tokenPos: integer; var {%H-}charPos: integer): boolean; override;
     end;

      // список регистров через запятую

      { TAsmTextRule_RegisterList }

      TAsmTextRule_RegisterList=class(TAsmTextRule)
            public
              constructor Create(rule_name: string); override;
              destructor  Free;                      override;

              procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

              function    Process(SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
                    var tokenPos: integer; var charPos: integer): boolean; override;
           end;


      { TAsmTextRule_DefineSymbol }

      TAsmTextRule_DefineSymbol=class(TAsmTextRule)
            public
              constructor Create(rule_name: string); override;
              destructor  Free;                      override;

              procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

              function    Process(SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
                    var tokenPos: integer; var {%H-}charPos: integer): boolean; override;
           end;

      { TAsmTextRule_String }

      TAsmTextRule_String=class(TAsmTextRule)
            public
              constructor Create(rule_name: string); override;
              destructor  Free;                      override;

              procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

              function    Process({%H-}SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
                    var tokenPos: integer; var {%H-}charPos: integer): boolean; override;
           end;

      { TAsmTextRule_StringList }

      TAsmTextRule_StringList=class(TAsmTextRule)
            public
              constructor Create(rule_name: string); override;
              destructor  Free;                      override;

              procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

              function    Process(SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
                    var tokenPos: integer; var charPos: integer): boolean; override;
           end;

      { TAsmTextRule_IncludeFile }

      TAsmTextRule_IncludeFile=class(TAsmTextRule)
            public
              constructor Create(rule_name: string); override;
              destructor  Free;                      override;

              procedure   AddItem(str:string; Rule:TAsmTextRule; outType:TTokenStyle); override;

              function    Process(SL: TSourceLine; {Symbols: TSymbolList;} Tokens: TTokenList;
                    var tokenPos: integer; var {%H-}charPos: integer): boolean; override;
           end;

implementation

uses MainUnit;



{ TAsmTextRuleItem }

constructor TAsmTextRuleItem.Create(txt:string; outType:TTokenStyle; AddRule:TAsmTextRule);
begin
  text:=txt;
  itemType:=outType;
  Rule:=AddRule;
end;

destructor TAsmTextRuleItem.Free;
begin
//  Rule.Free;
end;

{ TAsmTextRule }

constructor TAsmTextRule.Create(rule_name: string);
begin
  List:=TList.Create;
  name:=rule_name;
end;

destructor TAsmTextRule.Free;
var
  i:integer;
begin
  for i:=0 to List.Count-1 do TAsmTextRuleItem(List.Items[i]).Free;
  List.Free;
end;

// добавить элемент разбора
procedure TAsmTextRule.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
var
  ATRI:TAsmTextRuleItem;
begin
  ATRI:=TAsmTextRuleItem.Create(str, outType, Rule);
  List.Add(ATRI);
end;

{ TAsmTextRule_TokenList }
// набор списка правил
constructor TAsmTextRule_TokenList.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_TokenList.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_TokenList.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_TokenList.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
var
  i:integer;
  tok:TToken;
  RI:TAsmTextRuleItem;
//  start:integer;
begin
  Result:=false;

  // перебираем все части правила
  i:=0;
  while (i<List.Count) {and (tokenPos<Tokens.Count)} do
    begin
      RI:=TAsmTextRuleItem(List.Items[i]);
      tok:=tokens.GetToken(tokenPos);

      // сравниваем токен на строковое значение правила
      if RI.text<>'' then
        begin
          if (tok<>nil) and (RI.text=UTF8UpperCase(tok.Text)) then
            begin  // если совпали то правим стиль токена
              tok.tokStyle:=RI.itemType;
              i:=i+1;
              tokenPos:=tokenPos+1;
            end
          else exit // если токены не совпали выходим с ошибкой стравнения
        end
      else
      // проверяем токен по другому правилу
        begin
           charPos:=1;
          // start:=tokenPos;
           if TAsmTextRule(RI.Rule).Process(SL, {Symbols,} tokens, tokenPos {start}, charPos) then
             begin // проверка прошла успешно
               if (tok<>nil) and (RI.itemType<>tsNone) then tok.tokStyle:=RI.itemType;
               i:=i+1;          // переходим к следующему пункту правил
          //     tokenPos:=start;
             end
           else exit; // проверка не прошла
        end;
    end;
  // правило полностью обработано
  if (i=List.Count) then Result:=true;
end;

{ TAsmTextRule_Section }
// правило для директивы .SECTION
constructor TAsmTextRule_Section.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_Section.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_Section.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_Section.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
var
  tok:TToken;
//  start:integer;
begin
  Result:=false;

  // перебираем все части правила
//  i:=0;
  if tokenPos>=Tokens.Count then exit;

  tok:=tokens.GetToken(tokenPos);

  if Project.CodeSectionPresent(tok.Text) then
     begin  // если совпали то переходим к следующему токену
       tokenPos:=tokenPos+1;
       Result:=true;
     end;
end;

{ TAsmTextRule_TokenMayBe }
// токен который может отсутствовать
constructor TAsmTextRule_TokenMayBe.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_TokenMayBe.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_TokenMayBe.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_TokenMayBe.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
var
  RI:TAsmTextRuleItem;
  start:integer;
  str:string;
begin
  Result:=true;

  RI:=TAsmTextRuleItem(List.Items[0]);
  if RI.text<>'' then
     begin
       if tokenPos<Tokens.Count then str:=TToken(Tokens.GetToken(tokenPos)).Text
                                else str:='';
       if RI.text=UTF8UpperCase(str) then
          begin
            if RI.itemType<>tsNone then TToken(Tokens.GetToken(tokenPos)).tokStyle:=RI.itemType;
            tokenPos:=tokenPos+1;
          end;
     end
  else
     begin
       start:=tokenPos;
       if RI.Rule.Process(SL, {Symbols,} tokens, start, charPos) then tokenPos:=start;
     end;
end;


{ TAsmTextRule_TokenOne }
// выбор одного варианта из нескольких
constructor TAsmTextRule_TokenOne.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_TokenOne.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_TokenOne.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_TokenOne.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
var
  i:integer;
  tok:TToken;
  RI:TAsmTextRuleItem;
  pos:integer;
  start:integer;
//  ruleNum:integer; // номер правила более подходящего
begin
  Result:=true;
  start:=tokenPos;
  // перебираем все части правила
  i:=0;
  while (i<List.Count) and (tokenPos<Tokens.Count) do
    begin
      RI:=TAsmTextRuleItem(List.Items[i]);
      tok:=tokens.GetToken(tokenPos);

      // сравниваем токен на строковое значение правила
      if RI.text<>'' then
         begin
           if RI.text=UTF8UpperCase(tok.Text) then
              begin  // если совпали то правим стиль токена
                tok.tokStyle:=RI.itemType;
                tokenPos:=tokenPos+1; // перейдем к следующему токену
                exit;
              end
           else i:=i+1;  // если токены не совпали, смотрим следующие варианты
         end
      else
         // проверяем токен по другому правилу
         begin
           charPos:=1;
           pos:=tokenPos;
           if TAsmTextRule(RI.Rule).Process(SL, {Symbols,} tokens, pos, charPos) then
              begin // проверка прошла успешно
                if RI.itemType<>tsNone then tok.tokStyle:=RI.itemType;
                tokenPos:=pos;
                exit;
              end
           else
             begin
               if pos>start then start:=pos;
               i:=i+1; // проверка не прошла, переходим к следующему пункту правил
             end;
         end;
    end;

  tokenPos:=start;
  Result:=false;
end;



{ TAsmTextRule_TokenSplit }
// правило объединения нескольких токенов в один с проверкой
constructor TAsmTextRule_TokenSplit.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_TokenSplit.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_TokenSplit.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_TokenSplit.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
var
  i:integer;
  tok:TToken;
  RI:TAsmTextRuleItem;
  str:string;
  tsc, st:integer;
begin
  Result:=false;
  str:='';
  st:=0;  // стартовый номер первого символа первого токена
  tsc:=tokenPos;  // номер первого анализируемого токена
  // перебираем все части правила
  i:=0;
  while (i<List.Count) and (tokenPos<tokens.Count) do
    begin
      tok:=tokens.GetToken(tokenPos); // сравниваемый токен

      RI:=TAsmTextRuleItem(List.Items[i]);
      if (UTF8UpperCase(tok.Text)=RI.text) then
        begin
          str:=str+tok.Text; // собираем текст токена (для последующих проверок)
          if i=0 then st:=tok.startPos; // стартовая позиция первого токена

          i:=i+1;
          tokenPos:=tokenPos+1;
        end
      else  exit;
    end;

  // токен правильный
  if (Tokens.Count>0) and
     (UTF8Length(str)=(Tokens.GetToken(tokenPos-1).startPos+Tokens.GetToken(tokenPos-1).tokLen-st)) and
     (i=List.Count) then
    begin
      tokens.SplitTokens(tsc, tokenPos-1);
      tokenPos:=tsc+1;
      Result:=true;
    end
  else tokenPos:=tsc;
end;

{ TAsmTextRule_TokenParts }
// проверка одного токена на вхождение подстрок
constructor TAsmTextRule_TokenParts.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_TokenParts.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_TokenParts.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_TokenParts.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
var
  i:integer;
  tok:TToken;
  RI:TAsmTextRuleItem;
  start:integer;
  tokStr:string;
  poss:integer;
begin
  Result:=false;

  tok:=tokens.GetToken(TokenPos); // проверяемый токен

  tokStr:=UTF8UpperCase(tok.Text);
    // перебираем все части правила
    i:=0;
    while (i<List.Count) and (charPos<=UTF8Length(tokStr)) do
      begin
         RI:=TAsmTextRuleItem(List.Items[i]);
         if RI.text<>'' then
           begin
             if UTF8Pos(RI.text, tokStr, charPos)=charPos then
               begin
                 i:=i+1;
                 charPos:=charPos+UTF8Length(RI.text);
               end
             else  exit;
           end
         else
           begin // обрабатываем другое правило
             start:=charPos;
             poss:=tokenPos;
             if TAsmTextRule(RI.Rule).Process(SL, {Symbols,} tokens, poss, start) then
               begin
                 charPos:=start;
                 i:=i+1;
               end
             else exit;
           end;
      end;

  if (charPos>UTF8Length(tokStr)) then
     while (i<List.Count) and
        (TAsmTextRuleItem(List.Items[i]).Rule is TAsmTextRule_TokenPartsMayBe) do i:=i+1;

  // если обработали все правила и токен как раз тоже кончился - то токен верен
  if (i=List.Count) and (charPos>UTF8Length(tokStr)) then
    begin
      tokenPos:=tokenPos+1;
      Result:=true;
    end;
end;

{ TAsmTextRule_PartsOne }
// проверка на обязательное вхождение подстроки в токен из нескольких вариантов
constructor TAsmTextRule_PartsOne.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_PartsOne.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_PartsOne.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_PartsOne.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
var
  i:integer;
  tok:TToken;
  RI:TAsmTextRuleItem;
  start:integer;
  tokstr:string;
  poss:integer;
begin
  Result:=false;

  tok:=tokens.GetToken(TokenPos); // проверяемый токен

  tokstr:=UTF8UpperCase(tok.Text);
    // перебираем все части правила
   i:=0;
   while (i<List.Count) and (tokenPos<=tok.tokLen) do
      begin
         RI:=TAsmTextRuleItem(List.Items[i]);
         if RI.text<>'' then
           begin
             if UTF8Pos(RI.text, tokstr, charPos)=charPos then
               begin
                 charPos:=charPos+UTF8Length(RI.text);
                 Result:=true;
                 exit;
               end
             else i:=i+1;
           end
         else
           begin // обрабатываем другое правило
             start:=charPos;
             poss:=tokenPos;
             if TAsmTextRule(RI.Rule).Process(SL, {Symbols,} tokens, poss, start) then
               begin
                 charPos:=start;
                 Result:=true;
                 exit;
               end
             else i:=i+1;
           end;
      end;
end;


{ TAsmTextRule_TokenPartsMayBe }
// проверка на возможное вхождение токена в строку
constructor TAsmTextRule_TokenPartsMayBe.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_TokenPartsMayBe.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_TokenPartsMayBe.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_TokenPartsMayBe.Process(SL: TSourceLine;
  Tokens: TTokenList; var tokenPos: integer; var charPos: integer): boolean;
var
  i:integer;
  tok:TToken;
  RI:TAsmTextRuleItem;
  start:integer;
  tokstr:string;
  poss:integer;
begin
  Result:=true;

  tok:=tokens.GetToken(TokenPos); // проверяемый токен

  if tok=nil then exit;

  tokstr:=UTF8UpperCase(tok.Text);
    // перебираем все части правила
    i:=0;
    while (i<List.Count) and (tokenPos<=tok.tokLen) do
      begin
         RI:=TAsmTextRuleItem(List.Items[i]);
         if RI.text<>'' then
           begin
             if UTF8Pos(RI.text, tokstr, charPos)=charPos then
               begin
                 charPos:=charPos+UTF8Length(RI.text);
                 exit;
               end
             else i:=i+1;
           end
         else
           begin // обрабатываем другое правило
             start:=charPos;
             poss:=tokenPos;
             if TAsmTextRule(RI.Rule).Process(SL, {Symbols,} tokens, poss, start) then
               begin
                 charPos:=start;
                 exit;
               end
             else i:=i+1;
           end;
      end;
end;

{ TAsmTextRule_Expression }

// проверка на выражение
constructor TAsmTextRule_Expression.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_Expression.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_Expression.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_Expression.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
type
  TInputType=(itPref, itVal, itOper);
var
  tok:TToken;
  mode, oldmode:TInputType;
  i, op_b, cl_b:integer;
  str:string;
begin
  if tokenPos=Tokens.Count then
    begin
       Result:=false;
       exit;
    end;

  Result:=true;

  // проверка скобок группировки вычислений
  op_b:=0; cl_b:=0;
  for i:=tokenPos to Tokens.Count-1 do
    begin
       str:=TToken(tokens.GetToken(i)).Text;
       if str='(' then op_b:=op_b+1
       else
       if str=')' then cl_b:=cl_b+1
       else
       if UTF8Pos('@', str, 1)=1 then break;
    end;
  if op_b<>cl_b then
    begin // количество скобок разное
      while tokenPos<Tokens.Count do
        begin
          TToken(tokens.GetToken(tokenPos)).tokStyle:=tsErr;
          tokenPos:=tokenPos+1;
        end;
      Result:=false;
      exit;
    end;

  mode:=itPref; // ожидаем префикс

  while (tokenPos<Tokens.Count) do
    begin
       tok:=tokens.GetToken(tokenPos); // проверяемый токен
       if (tok.Text='(') or (tok.Text=')') then
          begin
            tok.tokStyle:=tsDelim;
            tokenPos:=tokenPos+1
          end
       else
       case mode of
         itPref: // префиксный оператор
                 if (tok.Text='-') or (tok.Text='~') then
                    begin
                      oldmode:=itPref;
                      mode:=itVal;
                      tok.tokStyle:=tsDelim;
                      tokenPos:=tokenPos+1;
                    end
                 else mode:=itVal;

         itVal:  // число или символ
                 if (tok.tokType=ttChars) or (tok.tokType=ttOneChar) then
                   begin
                      if (tok.isNumber) then tokenPos:=tokenPos+1 // токен число
                      else
                      if (tok.tokType=ttOneChar) then
                        begin
                           tok.tokStyle:=tsString;
                           tokenPos:=tokenPos+1
                        end
                      else
                      if tok.isSymbol and (not tok.isRegister) then // токен метка
                        begin
                          //Symbols.UseSymbol(tok.Text, SL);
                          //SL.SymbolsName.Add(tok.Text);
                          tok.tokStyle:=tsLabSymb;
                          tokenPos:=tokenPos+1;
                        end
                      else   // ошибка ! ожидали значение, а тут что то другое
                        begin
                          Result:=false;
                          exit;
                        end;
                      oldmode:=itVal;
                      mode:=itOper;
                   end
                 else   // ошибка ! ожидали значение, а тут что то другое
                    begin
                      Result:=false;
                      exit;
                    end;

         itOper: // операция
                 if ((tok.tokType=ttLogic) and (tok.Text<>'~')) or (tok.tokType=ttIf) then
                   begin
                      tok.tokStyle:=tsDelim;
                      oldmode:=itOper;
                      mode:=itPref;
                      tokenPos:=tokenPos+1;
                   end
                 else
                   begin // конец выражения
                     Result:=true;
                     exit;
                   end;
       end; // case
    end; // while

  if (tokenPos=Tokens.Count) and (oldmode=itOper) then
    begin
       tokenPos:=tokenPos-1;
       exit;
    end;
  if (mode=itPref) or (mode=itOper) then Result:=true else Result:=false;
end;

{ TAsmTextRule_ExpressionList }

constructor TAsmTextRule_ExpressionList.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_ExpressionList.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_ExpressionList.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_ExpressionList.Process(SL: TSourceLine;
  Tokens: TTokenList; var tokenPos: integer; var charPos: integer): boolean;
var
  ExpR:TAsmTextRule_Expression;
//  first:boolean;
begin
  ExpR:=TAsmTextRule_Expression.Create('test');
  Result:=true;
//  first:=false;

  repeat
     Result:=(ExpR.Process(SL, {Symbols,} Tokens, tokenPos, charPos));

     if Result and (tokenPos<Tokens.Count) and
     (Tokens.GetToken(tokenPos).Text=',') then
       begin
          TToken(Tokens.GetToken(tokenPos)).tokStyle:=tsDelim;
          tokenPos:=tokenPos+1;
       end else break;
  until not Result;

  ExpR.Free;
end;

{ TAsmTextRule_Register }

constructor TAsmTextRule_Register.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_Register.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_Register.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_Register.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
const
  regNames=' R0 R1 R2 R3 R4 R5 R6 R7 R8 R9 R10 R11 R12 R13 R14 R15 LR SP PC ';
var
  str:string;
  i:integer;
begin
  Result:=false;

  if tokenPos>=Tokens.Count then exit;

  str:=UTF8UpperCase(TToken(Tokens.GetToken(tokenPos)).Text);

  if (UTF8Pos(str, regNames,1)=0) or (UTF8Length(str)=1) then exit;

  for i:=0 to List.Count-1 do
    if str=TAsmTextRuleItem(List.Items[i]).text then exit;

  TToken(Tokens.GetToken(tokenPos)).tokStyle:=tsReg;
  tokenPos:=tokenPos+1;
  Result:=true;
end;

{ TAsmTextRule_RegisterList }

constructor TAsmTextRule_RegisterList.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_RegisterList.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_RegisterList.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_RegisterList.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
var
  ExpR:TAsmTextRule_Register;
  i:integer;
//  str:string;
begin
  ExpR:=TAsmTextRule_Register.Create('test');
  for i:=0 to List.Count-1 do
    ExpR.List.Add(TAsmTextRuleItem(List.Items[i]));

  Result:=true;

  repeat
    Result:=(ExpR.Process(SL, {Symbols,} Tokens, tokenPos, charPos));

    if Result and (tokenPos<Tokens.Count) and (Tokens.GetToken(tokenPos).Text=',') then
       begin
         TToken(Tokens.GetToken(tokenPos)).tokStyle:=tsDelim;
         tokenPos:=tokenPos+1;
       end
    else
    if Result and (tokenPos<Tokens.Count) and (Tokens.GetToken(tokenPos).Text='-') then
       begin
         TToken(Tokens.GetToken(tokenPos)).tokStyle:=tsDelim;
         tokenPos:=tokenPos+1;
       end
    else
       break;
{
    if Result and (tokenPos<Tokens.Count) then
      begin
         if (Tokens.GetToken(tokenPos).Text=',') then
            begin
              TToken(Tokens.GetToken(tokenPos)).tokStyle:=tsDelim;
              tokenPos:=tokenPos+1;
            end
         else
         if (Tokens.GetToken(tokenPos).Text='-') then
            begin
              TToken(Tokens.GetToken(tokenPos)).tokStyle:=tsDelim;
              tokenPos:=tokenPos+1;
            end
         else break;
       end;
}
    until not Result;

    ExpR.List.Clear;

    ExpR.Free;
end;

{ TAsmTextRule_DefineSymbol }

constructor TAsmTextRule_DefineSymbol.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_DefineSymbol.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_DefineSymbol.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_DefineSymbol.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
var
  token:TToken;
  symb:TSymbol;
begin
  Result:=false;

  token:=TToken(Tokens.GetToken(tokenPos));
  if token=nil then exit;

  if not token.isSymbol then exit;

  symb:=TSymbol.Create(token.text, tokenPos, SL);
  SL.SymbolsName.AddObject(token.text, symb);

  token.tokStyle:=tsLabSymb;

  tokenPos:=tokenPos+1;
  Result:=true;
end;

{ TAsmTextRule_String }

constructor TAsmTextRule_String.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_String.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_String.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_String.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
begin
  if TToken(Tokens.GetToken(tokenPos)).tokType=ttString then
     begin
       TToken(Tokens.GetToken(tokenPos)).tokStyle:=tsString;
       tokenPos:=tokenPos+1;
       Result:=true;
     end
  else Result:=false;
end;

{ TAsmTextRule_StringList }

constructor TAsmTextRule_StringList.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_StringList.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_StringList.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_StringList.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
var
  strRule:TAsmTextRule_String;
begin
  strRule:=TAsmTextRule_String.Create('test');

   Result:=true;

  repeat
    Result:=(strRule.Process(SL, {Symbols,} Tokens, tokenPos, charPos));

    if Result and (tokenPos<Tokens.Count) and (Tokens.GetToken(tokenPos).Text=',') then
       begin
         TToken(Tokens.GetToken(tokenPos)).tokStyle:=tsDelim;
         tokenPos:=tokenPos+1;
       end else break;
    until not Result;

  strRule.Free;
end;

{ TAsmTextRule_IncludeFile }
// вставка символов файла
constructor TAsmTextRule_IncludeFile.Create(rule_name: string);
begin
  inherited Create(rule_name);
end;

destructor TAsmTextRule_IncludeFile.Free;
begin
  inherited Free;
end;

procedure TAsmTextRule_IncludeFile.AddItem(str: string; Rule: TAsmTextRule;
  outType: TTokenStyle);
begin
  inherited AddItem(str, Rule, outType);
end;

function TAsmTextRule_IncludeFile.Process(SL: TSourceLine; Tokens: TTokenList;
  var tokenPos: integer; var charPos: integer): boolean;
var
  str:string;
  symb:TSymbol;
begin
   result:=false;

   if (Tokens.GetToken(tokenPos)<>nil) and (TToken(Tokens.GetToken(tokenPos)).tokType=ttString) then
      begin
        str:=UTF8Copy(
                        TToken(Tokens.GetToken(tokenPos)).text, 2,
                        UTF8Length(TToken(Tokens.GetToken(tokenPos)).text)-2);

        str:=MainForm.GetFullFromOfsFilename(str, CurrentParseFileName); // определяем файл
        if FileExists(str) then
           begin
             symb:=TSymbol.Create(str, SL);
             SL.SymbolsName.AddObject('', symb);

             TToken(Tokens.GetToken(tokenPos)).tokStyle:=tsParam;
             tokenPos:=tokenPos+1;
             Result:=true;
           end
        else
        begin
          TToken(Tokens.GetToken(tokenPos)).tokStyle:=tsErr;
          tokenPos:=tokenPos+1;
          Result:=true;
        end

      end;
end;

end.

