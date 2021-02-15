unit LDTextParserUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8,
  TextParserUnit,
  TokensUnit,
  SourceLineUnit;

type
     { TSimpleTextParser }

     { TLDTextParser }

     TLDTextParser=class(TTextParser)
     private
        FfullParse:boolean;

        MemoryMode:integer;  // шаг парсинга Memory
        SectionMode:integer; // шаг парсинга Section

        procedure LDFileParse;      // парсинг файла

        function GetNext(var line, pos: integer): TToken;   // переход к следующему токену
        function ViewNext(var line, pos: integer): TToken;  // просмотр следующего токена без перехода

        procedure ParseRemark(var line, pos:integer);      // парсинг комментария

        procedure MemoryParse(var line, pos:integer);      // парсинг области memory
        procedure SubMemoryParse(var line, pos:integer);   // парсинг одного блока memory

        procedure SectionsParse(var line, pos:integer);    // парсинг блока Sections
        procedure SubSectionsParse(var line, pos:integer); // парсинг одного блока Sections
        procedure CodeSectionsParse(var line, pos: integer); // парсинг описания секции кода
        procedure GetCodeSection(var line, pos: integer);  // парсинг чтения имени секции кода

     public
       MemoryList:TStringList;      // список memory областей
       SectionList:TStringList;     // список sections областей
       CodeSectionList:TStringList; // список секций кода

       constructor Create(LN:TList);   override;
       destructor  Free;               override;

       procedure   Clear;              override;
       procedure   Parse(num:integer); override;
       procedure   Del(num:integer);   override;

      procedure   ParseOff;            override;
      procedure   ParseOn;             override;
      procedure   ShortParse;          override;
      procedure   FullParse;           override;
   end;

implementation

{ TLDTextParser }


constructor TLDTextParser.Create(LN: TList);
begin
  inherited Create(LN);

  FfullParse:=false;

  MemoryList:=TStringList.Create;
  SectionList:=TStringList.Create;
  CodeSectionList:=TStringList.Create;
end;

destructor TLDTextParser.Free;
begin
  inherited Free;

  MemoryList.Free;
  SectionList.Free;
  CodeSectionList.Free;
end;

procedure TLDTextParser.Clear;
var
  num:integer;
begin
  for num:=0 to Lines.Count-1 do
    TTokenList(TSourceLine(Lines.Items[num]).GetTokens).Clear;
end;

procedure TLDTextParser.Parse(num: integer);
var
  Tokens:TTokenList;
  SL:TSourceLine;
begin
  SL:=TSourceLine(Lines.Items[num]);  // строка
  Tokens:=TTokenList(SL.GetTokens);   // токены
  Tokens.Clear;                       // очистим список токенов
  Tokens.ParseLineStr(SL.GetStr);     // проведем парсинг строки

{  if FfullParse then } LDFileParse;      // парсинг строк файла
end;

procedure TLDTextParser.Del(num: integer);
begin
  TTokenList(TSourceLine(Lines.Items[num]).GetTokens).Clear;
end;

procedure TLDTextParser.ParseOff;
begin
  inherited ParseOff;
  FfullParse:=false;
end;

procedure TLDTextParser.ParseOn;
begin
  inherited ParseOn;
  FfullParse:=true;
end;

procedure TLDTextParser.ShortParse;
begin
  inherited ShortParse;
  FfullParse:=false;
end;

procedure TLDTextParser.FullParse;
begin
  inherited FullParse;
  FfullParse:=true;
  LDFileParse;
end;

// парсинг строк файла
procedure TLDTextParser.LDFileParse;
var
  line, pos:integer;
  tok:TToken;
  str:string;

begin
  MemoryMode:=0;
  SectionMode:=0;

  // перебор всех строк
  line:=0;
  pos:=0;
  tok:=TToken(GetNext(line, pos));
  while tok<>nil do
    begin
      tok.tokStyle:=tsNone;
      str:=UTF8UpperCase(tok.Text);
      case str of
        'MEMORY': // переключение на обработку memory
                  begin
                    if (MemoryMode=0) then
                      begin
                        tok.tokStyle:=tsAsmDir;
                        MemoryParse(line, pos);
                      end
                    else
                      tok.tokStyle:=tsErr;
                  end;

      'SECTIONS': // переключение на обработку sections
                  begin
                    if SectionMode=0 then
                      begin
                        tok.tokStyle:=tsAsmDir;
                        SectionsParse(line, pos);
                      end
                    else
                      tok.tokStyle:=tsErr;
                  end;

           else   // ошибочные символы
                  begin
                    tok.tokStyle:=tsErr;
                  end;
           end;
      tok:=TToken(GetNext(line, pos));
    end;
end;

// переход к следующему токену
function TLDTextParser.GetNext(var line, pos: integer):TToken;
var
  Tokens:TTokenList;

begin
  Result:=nil;

  if Lines.Count=0 then exit;

  if line>=Lines.Count then exit;
  Tokens:=TTokenList(TSourceLine(Lines.Items[line]).GetTokens);

  while (pos>=Tokens.Count) or
        (TTokenList(TSourceLine(Lines.Items[line]).GetTokens).Count=0) do
    begin
      pos:=0;
      line:=line+1;
      if line=Lines.Count then exit;
      Tokens:=TTokenList(TSourceLine(Lines.Items[line]).GetTokens);
    end;

  if (pos+1<Tokens.Count) and  // обработка комментариев
       (TToken(Tokens.GetToken(pos)).Text='/') and
         (TToken(Tokens.GetToken(pos+1)).Text='*') then
     begin
       TToken(Tokens.GetToken(pos)).tokStyle:=tsRem;
       TToken(Tokens.GetToken(pos+1)).tokStyle:=tsRem;
       pos:=pos+2;
       ParseRemark(line, pos);
       Result:=GetNext(line, pos);
     end
  else
   begin // возврат следующего токена
     Result:=TToken(Tokens.GetToken(pos));
     pos:=pos+1;
   end;
end;

// просмотр следующего токена без перехода
function TLDTextParser.ViewNext(var line, pos: integer): TToken;
var
  line1, pos1:integer;
begin
  line1:=line;
  pos1:=pos;
  Result:=GetNext(line1, pos1);
end;

// парсинг комментария
procedure TLDTextParser.ParseRemark(var line, pos: integer);
var
  Tokens:TTokenList;

begin
  Tokens:=TTokenList(TSourceLine(Lines.Items[line]).GetTokens);

  // перебираем до конца комментария
  repeat
    // проверимся на конец строки и конец текста
    if pos>=Tokens.Count then
      begin
        pos:=0;
        line:=line+1;
        if line=Lines.Count then exit;
        Tokens:=TTokenList(TSourceLine(Lines.Items[line]).GetTokens);
      end;

    // если токены в строке есть - то продолжим обработку
    if (TTokenList(TSourceLine(Lines.Items[line]).GetTokens).Count>0) then
      begin
        // это еще комментарий
        TToken(Tokens.GetToken(pos)).tokStyle:=tsRem;

        // проверяем конец комментария
        if (pos+1<Tokens.Count) and
            (TToken(Tokens.GetToken(pos)).Text='*') and
             (TToken(Tokens.GetToken(pos+1)).Text='/') then
          begin
            TToken(Tokens.GetToken(pos+1)).tokStyle:=tsRem;
            pos:=pos+2;
            exit;
          end;

        // смотрим следующий токен
        pos:=pos+1;
      end;
  until  line=Lines.Count;
end;

// парсинг области memory
procedure TLDTextParser.MemoryParse(var line, pos: integer);
var
  tok:TToken;
  res:boolean;
  i:integer;
  str:string;
begin
  MemoryList.Clear;
  repeat
    case MemoryMode of
      0: // поиск открывающей скобки
         begin
           tok:=TToken(GetNext(line, pos));
           if (tok<>nil) and (tok.Text='{') then
             begin
               tok.tokStyle:=tsDelim;
               MemoryMode:=1;
             end
           else
             if (tok<>nil) then tok.tokStyle:=tsErr else exit;
         end;

      1: // поиск суб секций
         begin
           tok:=TToken(GetNext(line, pos));
           if (tok<>nil) and (tok.Text='}') then  // если закрывающая скобка
             begin
               tok.tokStyle:=tsDelim;
               MemoryMode:=2;
             end
           else                  // то наверное субсекция
           if (tok<>nil) and (tok.tokType=ttChars) then
             begin // имя области
               // проверим что область не объявлена ранее
               res:=true;
               str:=UTF8UpperCase(tok.Text);
               for i:=0 to MemoryList.Count-1 do
                 if MemoryList.Strings[i]=str then res:=false;

               if not res then
                 begin
                   tok.tokStyle:=tsErr;
                 end
               else
                 begin
                   MemoryList.Add(str);   // добавим область памяти

                   tok.tokStyle:=tsAsmCom;
                   SubMemoryParse(line, pos); //tok.tokStyle:=tsNone;
                 end;
             end
           else
             begin
               if (tok<>nil) then tok.tokStyle:=tsErr;
               exit;
             end;
         end;
    end;
  until MemoryMode=2;
end;


// парсинг одного блока memory
procedure TLDTextParser.SubMemoryParse(var line, pos: integer);
var
  tok:TToken;
begin
  // открывающая скобка типа области
  tok:=TToken(GetNext(line, pos));
  if tok.text='(' then
    begin
      tok.tokStyle:=tsDelim;

      //тип области
      tok:=TToken(GetNext(line, pos));
      if tok.tokType=ttChars then
        begin
          tok.tokStyle:=tsParam;
        end;

      // закрывающая скобка типа области
      tok:=TToken(GetNext(line, pos));
      if tok.text=')' then
        begin
          tok.tokStyle:=tsDelim;
        end
      else
        begin
          tok.tokStyle:=tsErr;
          exit;
        end;
      tok:=TToken(GetNext(line, pos)); // читаем следующий токен
    end;

  // двоеточие
  if tok.text=':' then
    begin
      tok.tokStyle:=tsDelim;
    end
  else
    begin
      tok.tokStyle:=tsErr;
      exit;
    end;

  //тип области
  tok:=TToken(GetNext(line, pos));
  if (UTF8UpperCase(tok.text)='ORIGIN') or (UTF8UpperCase(tok.text)='ORG') or
       (UTF8UpperCase(tok.text)='O') then
    begin
      tok.tokStyle:=tsAsmDir;
    end
  else
    begin
      tok.tokStyle:=tsErr;
      exit;
    end;

  // равно
  tok:=TToken(GetNext(line, pos));
  if tok.text='=' then
    begin
      tok.tokStyle:=tsDelim;
    end
  else
    begin
      tok.tokStyle:=tsErr;
      exit;
    end;

  //стартовый адрес области
  tok:=TToken(GetNext(line, pos));
  if tok.isNumber then
    begin
     // стиль выставляет процедура isNumber
    end
  else
    begin
      tok.tokStyle:=tsErr;
      exit;
    end;

  // запятая
  tok:=TToken(GetNext(line, pos));
  if tok.text=',' then
    begin
      tok.tokStyle:=tsDelim;
    end
  else
    begin
      tok.tokStyle:=tsErr;
      exit;
    end;

  //длина области
    tok:=TToken(GetNext(line, pos));
    if (UTF8UpperCase(tok.text)='LENGTH') or (UTF8UpperCase(tok.text)='LEN') or
         (UTF8UpperCase(tok.text)='L') then
      begin
        tok.tokStyle:=tsAsmDir;
      end
    else
      begin
        tok.tokStyle:=tsErr;
        exit;
      end;

  // равно
  tok:=TToken(GetNext(line, pos));
  if tok.text='=' then
    begin
      tok.tokStyle:=tsDelim;
    end
  else
    begin
      tok.tokStyle:=tsErr;
      exit;
    end;

  // значение длины области
  tok:=TToken(GetNext(line, pos));
  if tok.isSize then
    begin
      // стиль выставляет процедура isNumber
    end
  else
    begin
      tok.tokStyle:=tsErr;
      exit;
    end;
end;


// парсинг блока Sections
procedure TLDTextParser.SectionsParse(var line, pos: integer);
var
  tok:TToken;
  i:integer;
  str:string;
  res:boolean;
begin
  SectionList.Clear;
  CodeSectionList.Clear;

  repeat
    case SectionMode of
      0: // поиск открывающей скобки
         begin
           tok:=TToken(GetNext(line, pos));
           if (tok<>nil) and (tok.Text='{') then
             begin
               tok.tokStyle:=tsDelim;
               SectionMode:=1;
             end
           else if (tok<>nil) then tok.tokStyle:=tsErr else exit;
         end;

      1: // поиск суб секций
         begin
           tok:=TToken(ViewNext(line, pos));
           if (tok=nil) or (tok.Text='}') then
             begin
               SectionMode:=3;
               if (tok<>nil) then
                 begin
                   tok:=TToken(GetNext(line, pos)); // читаем следующий токен
                   tok.tokStyle:=tsDelim;
                 end;
             end
           else
             begin
               // сначала идет имя субсекции
               // проверим что область не объявлена ранее
               tok:=TToken(GetNext(line, pos)); // читаем следующий токен
               res:=true;
               str:=UTF8UpperCase(tok.Text);
               for i:=0 to SectionList.Count-1 do
                 if SectionList.Strings[i]=str then res:=false;

               if not res then tok.tokStyle:=tsErr
               else
                 begin
                   SectionList.Add(str);   // добавим область памяти
                   tok.tokStyle:=tsAsmCom;
                   SubSectionsParse(line, pos);
                   SectionMode:=2;
                 end;
             end;
         end;
      2: // указатель размещения секции в memory
         begin
           tok:=TToken(GetNext(line, pos)); // читаем следующий токен
           if (tok<>nil) and (tok.Text='>') then  // указатель на memory
             begin
               //tok:=TToken(GetNext(line, pos)); // читаем следующий токен
               tok.tokStyle:=tsDelim;

               tok:=TToken(GetNext(line, pos)); // читаем следующий токен
               res:=false;
               str:=UTF8UpperCase(tok.Text);
               for i:=0 to MemoryList.Count-1 do
                 if MemoryList.Strings[i]=str then res:=true;
               if res then tok.tokStyle:=tsAsmCom
                      else tok.tokStyle:=tsErr;
               SectionMode:=1;
             end
           else SectionMode:=3;
         end;
    end;
  until SectionMode=3;
end;

// парсинг одного блока Sections
procedure TLDTextParser.SubSectionsParse(var line, pos: integer);
var
  tok:TToken;
begin
  tok:=TToken(GetNext(line, pos)); // читаем следующий токен

  // может идти адрес размещения секции
  if tok.isNumber then
    begin
      tok.tokStyle:=tsNum;
      tok:=TToken(GetNext(line, pos)); // читаем следующий токен
    end;

  // двоеточие
  if tok.text=':' then
    begin
      tok.tokStyle:=tsDelim;
    end
  else    //
    begin
      tok.tokStyle:=tsErr;
      exit;
    end;

  tok:=TToken(GetNext(line, pos)); // читаем следующий токен
  // открывающая скобка
  if tok.text='{' then
    begin
      tok.tokStyle:=tsDelim;
    end
  else    //
    begin
      tok.tokStyle:=tsErr;
      exit;
    end;

  // перебираем включаемые секции кода
  tok:=ViewNext(line, pos);
  while (tok<>nil) and (tok.Text<>'}') do
    begin
      CodeSectionsParse(line, pos);
      tok:=ViewNext(line, pos);
    end;

  // закрывающая секцию скобка
  tok:=TToken(GetNext(line, pos));
  if (tok<>nil) and (tok.Text='}') then
    begin
      tok.tokStyle:=tsDelim;
    end;
end;

// парсинг описания секции кода
procedure TLDTextParser.CodeSectionsParse(var line, pos: integer);
var
  tok:TToken;
begin
  tok:=TToken(GetNext(line, pos));
  if (tok.Text='*') then   // любой входящий файл
    begin
      tok.tokStyle:=tsParam;
      GetCodeSection(line, pos);
    end
  else
  // текущий адрес
  if tok.Text='.' then
    begin
      tok.tokStyle:=tsParam;

      tok:=TToken(GetNext(line, pos));
      if (tok.Text='=') or
           (tok.Text='&=') or
             (tok.Text='-=') or
               (tok.Text='+=') or
                 (tok.Text='*=') then   // любой входящий файл
        begin
          tok.tokStyle:=tsDelim;
          tok:=TToken(GetNext(line, pos));
          if tok=nil then exit;

          case UTF8UpperCase(tok.Text) of
            'ALIGN':
                     begin
                       tok.tokStyle:=tsParam;

                       tok:=TToken(GetNext(line, pos));
                       if tok=nil then exit;
                       if tok.Text='(' then
                         tok.tokStyle:=tsDelim
                       else tok.tokStyle:=tsErr;

                       tok:=TToken(GetNext(line, pos));
                       if tok=nil then exit;
                       if tok.isNumber then
                         tok.tokStyle:=tsNum
                       else tok.tokStyle:=tsErr;

                       tok:=TToken(GetNext(line, pos));
                       if tok=nil then exit;
                       if tok.Text=')' then
                         tok.tokStyle:=tsDelim
                       else tok.tokStyle:=tsErr;

                       tok:=TToken(GetNext(line, pos));
                       if tok=nil then exit;
                       if tok.Text=';' then
                         tok.tokStyle:=tsDelim
                       else tok.tokStyle:=tsErr;
                     end;
          end;
        end
      else tok.tokStyle:=tsErr;

    end
  else
  if (tok.isSymbol) then
    begin
      // имя файла
      if UTF8Pos('.O', UTF8UpperCase(tok.Text),1)+1=UTF8Length(tok.Text) then
        begin
          tok.tokStyle:=tsParam;
          GetCodeSection(line, pos);
        end
    end
  else tok.tokStyle:=tsErr;

end;

// парсинг чтения имени секции кода
procedure TLDTextParser.GetCodeSection(var line, pos: integer);
var
  tok:TToken;
  i:integer;
  res:boolean;
  str:string;
begin
  // проверим есть ли вставка имен секций в скобках
  tok:=TToken(ViewNext(line, pos));
  if (tok<>nil) and  (tok.Text='(') then
    begin
      tok:=TToken(GetNext(line, pos));
      tok.tokStyle:=tsDelim;

      // перебираем включаемые секции кода
      tok:=ViewNext(line, pos);
      while (tok<>nil) and (tok.Text<>')') do
        begin
          tok:=TToken(GetNext(line, pos));
          tok.tokStyle:=tsParam;
          // проверим наличие секции в списке
          res:=false;
          for i:=0 to CodeSectionList.Count-1 do
            if CodeSectionList.Strings[i]=tok.Text then res:=true;
          // добавим секцию если ее нет в списке
          if not res then
            CodeSectionList.Add(tok.Text);

          tok:=ViewNext(line, pos);
        end;
      if (tok.Text=')') then
        begin
          tok:=TToken(GetNext(line, pos));
          tok.tokStyle:=tsDelim;

          tok:=TToken(GetNext(line, pos));
          if (tok<>nil) and (tok.Text=';') then tok.tokStyle:=tsDelim
          else
            if (tok<>nil) then tok.tokStyle:=tsErr else exit;
        end
    end;
end;

end.

