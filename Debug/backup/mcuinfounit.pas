unit MCUInfoUnit;

//
// модуль описания конфигурации микроконтроллера для чтения xml (svd) файла
//

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, laz2_DOM, laz2_XMLRead, LazUTF8;

type

   TCPU=class(TObject)
     name:string;
     revision:string;
     endian:string;
     mpuPresent:boolean;
     fpuPresent:boolean;
     nvicPriobits:integer;
     vendorSystickConfig:boolean;
   end;

   TInterrupt=class(TObject)
     name:string;
     desc:string;
     value:integer;
   end;

   TField=class(TObject)
     name:string;
     desc:string;
     bitOffset:integer;
     bitWidth:integer;
     access:string;

     vmode:integer;
   end;

   { TRegister }

   TRegister=class(TObject)
     name:string;
     dispName:string;
     desc:string;
     adrOffset:string;
     size:string;
     access:string;
     resetValue:string;

     Fields:TList;

     constructor Create;
   end;

   { TPeripheral }

   TPeripheral=class(TObject)
      name:string;
      desc:string;
      groupName:string;
      baseAddress:string;

      offset:string;
      size:string;
      usage:string;

      Interrupts:TList;

      Registers:TList;

      constructor Create;
   end;

   { TMCUInfo }

   TMCUInfo=class(TObject)
   private
     // служебные переменные
     currPeripheral:TPeripheral; // заполняемый описатель периферии
     currInterrupt:TInterrupt;   // заполняемый описатель прерывания
     currRegister:TRegister;     // заполняемый регистр настройки
     currField:TField;           // заполняемое поле настройки

     oldCategory:string;

     function StrToBool(value:string):boolean;

     procedure Add(key, value, cat:string);  // добавить значение
     procedure NewCat(cat, copyFrom: string);          // добавить категорию

     procedure SetBaseValue(key, value:string);
     procedure SetCPUValue (key, value:string);
     procedure SetPeripheralValue(key, value:string);
     procedure SetInterruptValue(key, value:string);
     procedure SetRegisterValue(key, value:string);
     procedure SetFieldValue(key, value:string);

     procedure XML2Tree(XMLDoc: TXMLDocument);
   public
     name:string;
     version:string;
     desc:string;

     CPU:TCPU;

     addressUnitBits:integer;
     width:integer;
     size:string;
     resetValue:string;
     resetMask:string;

     Peripherals:TList;

     constructor Create;
     destructor  Free;

     procedure LoadFromFile(filename:string);
   end;

  TTreeNodeInfo=class(TObject)
     Periph:TPeripheral;
     Reg:TRegister;
   end;

implementation

{ TRegister }

constructor TRegister.Create;
begin
  Fields:=TList.Create;
end;

{ TPeripheral }

constructor TPeripheral.Create;
begin
  Interrupts:=TList.Create;

   Registers:=TList.Create;
end;

{ TMCUInfo }

constructor TMCUInfo.Create;
begin
  Peripherals:=TList.Create;
  CPU:=TCPU.Create;
end;

destructor TMCUInfo.Free;
begin
  CPU.Free;
  Peripherals.Free;
end;

function TMCUInfo.StrToBool(value: string): boolean;
begin
  if lowerCase(value)='true' then Result:=true
                             else Result:=false;
end;

// добавить значение
procedure TMCUInfo.Add(key, value, cat: string);
var
  categ:string;
begin
  categ:=UpperCase(cat);
  if (categ<>'') and (categ<>'CPU') and (categ<>'PERIPHERAL') and
     (categ<>'INTERRUPT') and (categ<>'REGISTER') and (categ<>'FIELD') then
     categ:=oldCategory;

  case UpperCase(categ) of
    ''          : SetBaseValue(key, value);
    'CPU'       : SetCPUValue(key, value);
    'PERIPHERAL': SetPeripheralValue(key, value);
    'INTERRUPT' : SetInterruptValue(key, value);
    'REGISTER'  : SetRegisterValue(key, value);
    'FIELD'     : SetFieldValue(key, value);
  end;
  oldCategory:=categ;
end;

// добавить категорию
procedure TMCUInfo.NewCat(cat, copyFrom: string);
var
  i:integer;
begin
  case UpperCase(cat) of
    'CPU': CPU:=TCPU.Create;

    'PERIPHERAL': // создадим описатель периферии и добавим его в список
      begin
        currPeripheral:=TPeripheral.create;
        Peripherals.Add(currPeripheral);
        // поиск источника копирования
        if copyFrom<>'' then
           for i:=0 to Peripherals.Count-1 do
             if TPeripheral(Peripherals.Items[i]).name=copyFrom then
               begin
                 currPeripheral.Registers:=TPeripheral(Peripherals.Items[i]).Registers;
                 currPeripheral.Interrupts:=TPeripheral(Peripherals.Items[i]).Interrupts;
                 currPeripheral.desc:=TPeripheral(Peripherals.Items[i]).desc;
                 currPeripheral.groupName:=TPeripheral(Peripherals.Items[i]).groupName;
                 currPeripheral.size:=TPeripheral(Peripherals.Items[i]).size;
               end;
      end;

    'INTERRUPT': // создадим описатель прерывания в периферии
      begin
        currInterrupt:=TInterrupt.Create;
        currPeripheral.Interrupts.Add(currInterrupt);
      end;

    'REGISTER':  // описатель регистра настройки
      begin
        currRegister:=TRegister.Create;
        currPeripheral.Registers.Add(currRegister);
      end;

    'FIELD':     // описатель одного поля регистра
      begin
         currField:=TField.Create;
         currField.vmode:=0;
         currRegister.Fields.Add(currField);
      end;
  end;
end;

procedure TMCUInfo.SetBaseValue(key, value: string);
begin
  case LowerCase(key) of
     'name'           : name:=value;
     'version'        : version:=value;
     'description'    : desc:=value;

     'addressunitbits': addressUnitBits:=strtoint(value);
     'width'          : width:=strtoint(value);
     'size'           : size:=value;
     'resetvalue'     : resetValue:=value;
     'resetmask'      : resetMask:=value;

//     Peripherals:TList;
  end;
end;

procedure TMCUInfo.SetCPUValue(key, value: string);
begin
  case LowerCase(key) of
    'name'             : CPU.name:=value;
    'revision'         : CPU.revision:=value;
    'endian'           : CPU.endian:=value;
    'mpupresent'       : CPU.mpuPresent:=StrToBool(value);
    'fpupresent'       : CPU.fpuPresent:=StrToBool(value);
    'nvicpriobits'     : CPU.nvicPriobits:=strtoint(value);
    'vendorsystickconfig': CPU.vendorSystickConfig:=StrToBool(value);
  end;
end;

procedure TMCUInfo.SetPeripheralValue(key, value: string);
begin
   case LowerCase(key) of
      'name'           : currPeripheral.name:=value;
      'description'    : currPeripheral.desc:=value;
      'groupname'      : currPeripheral.groupName:=value;
      'baseaddress'    : currPeripheral.baseAddress:=value;
// <addressBlock>
      'offset'         : currPeripheral.offset:=value;
      'size'           : currPeripheral.size:=value;
      'usage'          : currPeripheral.usage:=value;

//      Interrupts:TList;

//      Registers:TList;
   end;
end;

procedure TMCUInfo.SetInterruptValue(key, value: string);
begin
  case LowerCase(key) of
     'name'             : currInterrupt.name:=value;
     'description'      : currInterrupt.desc:=value;
     'value'            : currInterrupt.value:=strtoint(value);
  end;
end;

procedure TMCUInfo.SetRegisterValue(key, value: string);
var
  i:integer;
  str, tmp:string;
begin
  case LowerCase(key) of
     'name'             : currRegister.name:=value;
     'dispname'         : currRegister.dispName:=value;
     'description'      :  begin
         tmp:='';
         currRegister.desc:='';
         for i:=1 to UTF8Length(value) do
           begin
             str:=utf8Copy(value, i, 1);
             if (str<>' ') or
                ( (str=' ') and (str<>tmp) ) then
                  currRegister.desc:=currRegister.desc+str;
             {if str=' ' then} tmp:=str;
           end;
     end;
     'addressoffset'     : currRegister.adrOffset:=value;
     'size'             : currRegister.size:=value;
     'access'           : currRegister.access:=value;
     'resetvalue'       : currRegister.resetValue:=value;

//     Fields:TList;
   end;
end;

procedure TMCUInfo.SetFieldValue(key, value: string);
var
  i:integer;
  str, tmp:string;
begin
  case LowerCase(key) of
     'name'             : currField.name:=value;
     'description'      : begin
         tmp:='';
         currField.desc:='';
         for i:=1 to UTF8Length(value) do
           begin
             str:=utf8Copy(value, i, 1);
             if (str<>' ') or
                ( (str=' ') and (str<>tmp) ) then currField.desc:=currField.desc+str;
             {if str=' ' then} tmp:=str;
           end;
     end;
     'bitoffset'        : currField.bitOffset:=strtoint(value);
     'bitwidth'         : currField.bitWidth:=strtoint(value);
     'access'           : currField.access:=value;
  end;

end;

// загрузка данных о периферии из файла
procedure TMCUInfo.LoadFromFile(filename: string);
var
  Doc : TXMLDocument;
begin
  try
    ReadXMLFile(Doc, filename);
    XML2Tree(Doc);
  finally
    Doc.Free;
  end;
end;

procedure TMCUInfo.XML2Tree(XMLDoc: TXMLDocument);
var
  iNode: TDOMNode;
  cat:string;

  procedure ProcessNode(Node: TDOMNode; key, categ:string);
  var
    cNode: TDOMNode;
    s: string;
    copyName:string;
  begin
    if Node = nil then Exit;


    // Adds a node to the tree
    s := node.NodeValue;
    if s = '' then
      begin
        // добавить категорию
        key := Node.NodeName;

        cNode:=Node.FirstChild; // смотрим вложенный и если у него нет значения
        if cNode.NodeValue='' then
          begin                     // то это категория
            categ:=key;
            copyName:='';
            if (node.Attributes.Length>0) and
               (lowercase(node.Attributes.item[0].NodeName)='derivedfrom') then
              copyName:=node.Attributes.item[0].NodeValue;
            NewCat(key, copyName);
          end;
      end
    else
       // добавить значение
       Add(key, s, categ);


    // Goes to the child node
    cNode := Node.FirstChild;

    // Processes all child nodes
    while cNode <> nil do
    begin
      ProcessNode(cNode, key, categ);
      cNode := cNode.NextSibling;
    end;
  end;

begin
  cat:='';
  iNode := XMLDoc.DocumentElement.FirstChild;
  while iNode <> nil do
  begin
    ProcessNode(iNode, '', cat);
    iNode := iNode.NextSibling;
  end;
end;

end.

