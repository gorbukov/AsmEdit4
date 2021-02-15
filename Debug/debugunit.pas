unit DebugUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Grids, lNetComponents, Process, lNet, LazUTF8, StrUtils,
  SourceTextUnit, dasmtextparserunit,
  OpenOCDConfigUnit,
  ProjectUnit,
  DebugStructUnit,
  MCUInfoUnit,
  DebugMemUnit,
  TokensUnit;

type

  { TDebugForm }

  TDebugForm = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    MCU_RunStepButton: TButton;
    MemAreaAddButton: TButton;
    MemAreaDelButton: TButton;
    MemAreaChangeButton: TButton;
    MemAreaRefreshButton: TButton;
    CheckBox1: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    MemTableWidth: TComboBox;
    MemAreaTypeBox: TComboBox;
    CoreRegGrid: TStringGrid;
    DebugMess: TEdit;
    MemAreaBox: TListBox;
    MemAreaAdr: TEdit;
    MemAreaSize: TEdit;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Panel8: TPanel;
    MemAreaGrid: TStringGrid;
    TabSheet8: TTabSheet;
    WatchAdr: TEdit;
    WatchMin: TEdit;
    WatchValue: TEdit;
    WatchMax: TEdit;
    WatchDesc: TEdit;
    WatchMessMin: TEdit;
    WatchMessValue: TEdit;
    WatchMessMax: TEdit;
    Label2: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label8: TLabel;
    Panel5: TPanel;
    Panel7: TPanel;
    RegOfs: TEdit;
    RegFullAdr: TEdit;
    RegAcc: TEdit;
    RegValue: TEdit;
    RegRes: TEdit;
    PeriphName: TEdit;
    PeriphDesc: TEdit;
    PeriphBaseAdr: TEdit;
    PeriphSize: TEdit;
    RegName: TEdit;
    RegDesc: TEdit;
    PerTreeImage: TImageList;
    Label1: TLabel;
    Label13: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    PageControl2: TPageControl;
    Panel2: TPanel;
    Panel4: TPanel;
    PointAdrGrid: TStringGrid;
    Splitter2: TSplitter;
    RFGrid: TStringGrid;
    BreakGrid: TStringGrid;
    WatchGrid: TStringGrid;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TelnetServer: TEdit;
    TelnetPort: TEdit;
    Label11: TLabel;
    Label9: TLabel;
    TelnetMessShow: TCheckBox;
    RunStepPauseComboBox: TComboBox;
    FlagBasePri: TLabel;
    FlagnPriv: TLabel;
    FlagSPSEL: TLabel;
    FlagGE: TLabel;
    FlagIT: TLabel;
    FlagIPSR_Num: TLabel;
    FlagICI: TLabel;
    FlagPrimask: TLabel;
    FlagFaultMask: TLabel;
    FlagFPCA: TLabel;
    FlagT: TLabel;
    FlagZ: TLabel;
    FlagC: TLabel;
    FlagV: TLabel;
    FlagQ: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    MCU_StatusButton: TButton;
    HideServerConsoleCheckBox: TCheckBox;
    MCU_ResumeButton: TButton;
    MCU_RunButton: TButton;
    MCU_ResetHalt: TButton;
    MCU_HaltButton: TButton;
    MCU_StepButton: TButton;
    MCU_AutoStepButton: TButton;
    MCU_StopButton: TButton;
    Label10: TLabel;
    MCUMode: TLabel;
    MCUState: TLabel;
    Label12: TLabel;
    CodeText: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    FlagN: TLabel;
    Memo1ClearButton: TButton;
    Memo2ClearButton: TButton;
    ComboBox1: TComboBox;
    Label6: TLabel;
    Panel3: TPanel;
    Panel6: TPanel;
    StartServerButton: TButton;
    StopServerButton: TButton;
    TelnetConnectButton: TButton;
    SendMessButton: TButton;
    Edit1: TEdit;
    LTelnetClientComponent1: TLTelnetClientComponent;
    Memo2: TMemo;
    Memo1: TMemo;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Timer1: TTimer;
    RunStepTimer: TTimer;
    StatusTimer: TTimer;
    PageControl1: TPageControl;
    Panel1: TPanel;
    TabSheet1: TTabSheet;
    PerTree: TTreeView;
    procedure Bevel4ChangeBounds(Sender: TObject);
    procedure BreakGridDblClick(Sender: TObject);
    procedure BreakGridSelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure MCU_RunStepButtonClick(Sender: TObject);
    procedure MemAreaRefreshButtonClick(Sender: TObject);
    procedure MemAreaChangeButtonClick(Sender: TObject);
    procedure MemAreaDelButtonClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure MCU_DEL_BreakPointClick(Sender: TObject);
    procedure MCU_HaltButtonClick(Sender: TObject);
    procedure MCU_ResetHaltClick(Sender: TObject);
    procedure MCU_ResumeButtonClick(Sender: TObject);
    procedure MCU_RunButtonClick(Sender: TObject);
    procedure MCU_AutoStepButtonClick(Sender: TObject);
    procedure MCU_StatusButtonClick(Sender: TObject);
    procedure MCU_StepButtonClick(Sender: TObject);
    procedure MCU_StopButtonClick(Sender: TObject);
    procedure MemAreaAddButtonClick(Sender: TObject);
    procedure MemAreaBoxSelectionChange(Sender: TObject; User: boolean);
    procedure Memo1ClearButtonClick(Sender: TObject);
    procedure Memo2ClearButtonClick(Sender: TObject);
    procedure PerTreeChange(Sender: TObject; Node: TTreeNode);
    procedure RFGridDblClick(Sender: TObject);
    procedure RFGridSelectCell(Sender: TObject; {%H-}aCol, aRow: Integer;
      var {%H-}CanSelect: Boolean);
    procedure RunStepTimerTimer(Sender: TObject);
    procedure StatusTimerTimer(Sender: TObject);
    procedure TelnetConnectButtonClick(Sender: TObject);
    procedure SendMessButtonClick(Sender: TObject);
    procedure LTelnetClientComponent1Receive({%H-}aSocket: TLSocket);
    procedure StartServerButtonClick(Sender: TObject);
    procedure StopServerButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
//    procedure Timer2Timer(Sender: TObject);
  private
    function BinStrToHex(binstr: string): string;
    procedure LTelnetProgrammingReceive({%H-}aSocket: TLSocket);
    procedure MCUProgrammingProcess;
    procedure ParseMemoryRead;
    procedure ParseRegValue;
    procedure SetRegisterFieldGrid;
    procedure setRunFL(AValue: boolean);
  private


    telnetFirstConnect:boolean;
    runstep:boolean;         // признак работы режима RunStep

    commSendName:string;     // команда отправленная на сервер
    receiveData:TStringList;
    wait_answer:boolean;  // признак ожидания ответа от команды

    StatusEvent:boolean;  // событие временного интервала
    MemoryReadSuccess:boolean;

    OpenODCProcess:TProcess;
    BreakPoint_Addres:string;
    run_fl:boolean;

    programming_fl:boolean;  // запуск сервера в режиме программирования
    prog_file:string;

    RegFieldList:TList;  // список полей редактора
    SelectedRegisterNode:TTreeNode;
    FieldRowSelect: Integer;  // выделенное поле редактора

    MCU_PC_Adr:string;  // адрес PC
    RunStepBreakAdr:string;  // адрес останова при Run Step

    property running:boolean read run_fl write setRunFL;      // признак исполнения без отладки



    function HexToBinStr(tstr:string):string;  // перевод строки hex в строку bin
    function HexToDecStr(tstr:string):string;  // перевод строки hex в строку dec

    function HexToDW(hexStr:string):DWord;     // перевод из hex в DWord

    procedure sendMess(str:string);
    procedure parse_Answer;
    procedure ParseMemoryArea;    // парсинг чтения области памяти

    procedure ShowMCUStatus;      // показ состояния mcu

    function getMCURegValue(rgname:string):string; // получение значения регистра
  public
    serverWorked:boolean;    // признак работы openODC сервера
    MCUInfo:TMCUInfo;
    telnetConnected:boolean; // признак работы telnet
    ST:TSourceText;
    WatchPoints:TList;       // список точек наблюдения

    procedure SetFormColor(bkg:TColor);
    procedure StartForm(PointsAdr:TList);

    procedure GetBreakPointFromSysSasm;  // чтение точек останова из sys.asm

    procedure GetMCUDevice;              // чтение информации о периферии mcu

    function setBreakPoint(adr: string; getStatus:boolean=true): boolean; // установить точку останова
    function clrBreakPoint(adr:string; getStatus:boolean=true): boolean;  // очистить точку останова

    procedure MCUProgramming(filename:string);     // прошивка устройства
  end;


implementation

uses MainUnit;
{$R *.lfm}

{ TDebugForm }

// создание формы
procedure TDebugForm.FormCreate(Sender: TObject);
begin
  receiveData:=TStringList.Create;
  programming_fl:=false;  // запуск сервера в обычном режиме

  BreakGrid.ColCount:=2;
  BreakGrid.RowCount:=1;
  BreakGrid.FixedRows:=1;
  BreakGrid.FixedCols:=0;
  BreakGrid.Cells[0,0]:='Адрес';
  BreakGrid.Cells[1,0]:='Инструкция';

  PointAdrGrid.ColCount:=4;
  PointAdrGrid.RowCount:=1;
  PointAdrGrid.FixedRows:=1;
  PointAdrGrid.FixedCols:=0;
  PointAdrGrid.Cells[0,0]:='Имя';
  PointAdrGrid.Cells[1,0]:='Адрес';
  PointAdrGrid.Cells[0,0]:='Тип';
  PointAdrGrid.Cells[0,0]:='Значение';

  PointAdrGrid.ColWidths[1]:=128;
  PointAdrGrid.ColWidths[2]:=64;
  PointAdrGrid.ColWidths[3]:=256;

  RunStepBreakAdr:='';

  WatchPoints:=TList.Create;       // список точек наблюдения
end;

procedure TDebugForm.StartForm(PointsAdr: TList);
var
  i:integer;
  str:string;
begin
  running:=false;
  programming_fl:=false; // режим программирования
  serverWorked:=false;
  telnetConnected:=false;

  // выключим кнопки
  MCU_RunButton.Enabled:=false;
  MCU_HaltButton.Enabled:=false;
  MCU_ResetHalt.Enabled:=false;
  MCU_StepButton.Enabled:=false;
  MCU_ResumeButton.Enabled:=false;
  MCU_AutoStepButton.Enabled:=false;
  MCU_StopButton.Enabled:=false;
  MCU_StatusButton.Enabled:=False;
  MCU_RunStepButton.Enabled:=false;

  TelnetConnectButton.Enabled:=false;
  SendMessButton.Enabled:=false;
  PageControl1.ActivePageIndex:=0;

  PageControl2.ActivePageIndex:=0;  // покажем регистры

  CoreRegGrid.RowCount:=1;
  BreakGrid.RowCount:=1;
  if PointsAdr=nil then exit;

  PointAdrGrid.RowCount:=PointsAdr.Count+1;
  for i:=0 to PointsAdr.Count-1 do
    begin

      PointAdrGrid.Cells[0, i+1]:=TPointInfo(PointsAdr.Items[i]).name;
      PointAdrGrid.Cells[1, i+1]:=TPointInfo(PointsAdr.Items[i]).adr;
      case TPointInfo(PointsAdr.Items[i]).ptype of
        tptWord:  str:='word';
        tptHWord: str:='hword';
        tptByte:  str:='byte';
      end;
      PointAdrGrid.Cells[2, i+1]:=str;
    end;

  WatchPoints.Clear;
end;

procedure TDebugForm.GetBreakPointFromSysSasm;
var
  i:integer;
  adr:string;
begin
  if ST=nil then exit;

  // получаем информацию о устройствах микроконтроллера
  GetMCUDevice;

  // получение точек останова
  for i:=0 to ST.Count-1 do
    if ST.GetDebugStr(i)='BreakPnt' then
      begin
        adr:=ST.GetAdrFromLine(i);
        setBreakPoint(adr);
      end;


end;

// чтение информации о периферии mcu
procedure TDebugForm.GetMCUDevice;
var
  p,r:integer;
  PR:TPeripheral;
  RG:TRegister;
  TreeNodeInfo:TTreeNodeInfo;
  ParentNode, TmpNode, CatNode, StartNode:TTreeNode;
begin
  if MCUInfo<>nil then MCUInfo.Free;

  MCUInfo:=TMCUInfo.Create;
  if Project.Project_Opened then
    MCUInfo.LoadFromFile(Project.Project_MCU_DeviceInfo);

  StartNode:=nil;
  // заполнение дерева устройств
  PerTree.Items.Clear;
  PerTree.BeginUpdate;
  for p:=0 to MCUInfo.Peripherals.Count-1 do
    begin
      // выводим устройство в дерево
      PR:=TPeripheral(MCUInfo.Peripherals.Items[p]);

      // проверим нужно ли поместить устройство в категорию
      CatNode:=nil;
      if PR.groupName<>PR.name then
        begin
          CatNode:=nil;
          r:=0;
          while r<PerTree.Items.Count do
            if TTreeNode(PerTree.Items.Item[r]).Text=PR.groupName then
              begin
                CatNode:=TTreeNode(PerTree.Items.Item[r]);
                break;
              end
            else r:=r+1;

          if CatNode=nil then
            begin
             CatNode:=PerTree.Items.Add(nil, PR.groupName);
             CatNode.SelectedIndex:=2;
             CatNode.ImageIndex:=2;
             TreeNodeInfo:=TTreeNodeInfo.Create;
             TreeNodeInfo.Periph:=nil;
             TreeNodeInfo.Reg:=nil;
             CatNode.Data:=TreeNodeInfo;
            end;
        end;

      TreeNodeInfo:=TTreeNodeInfo.Create;
      TreeNodeInfo.Periph:=PR;
      TreeNodeInfo.Reg:=nil;
      ParentNode:=PerTree.Items.AddChild(CatNode, PR.name);
      ParentNode.ImageIndex:=0;
      ParentNode.SelectedIndex:=0;
      ParentNode.Data:=TreeNodeInfo;

      if StartNode=nil then StartNode:=ParentNode;

      // выводим регистры настройки
      for r:=0 to PR.Registers.Count-1 do
        begin
          RG:=TRegister(PR.Registers.Items[r]);
          TreeNodeInfo:=TTreeNodeInfo.Create;
          TreeNodeInfo.Periph:=PR;
          TreeNodeInfo.Reg:=RG;
          TmpNode:=PerTree.Items.AddChild(ParentNode, RG.name);
          TmpNode.Data:=TreeNodeInfo;
          TmpNode.ImageIndex:=1;
          TmpNode.SelectedIndex:=1;
        end;
    end;
  PerTree.EndUpdate;
  PerTree.Selected:=StartNode;
end;

procedure TDebugForm.PerTreeChange(Sender: TObject; Node: TTreeNode);
var
  f:integer;
  PR:TPeripheral;
  RG:TRegister;
  FR:TField;
  TreeNodeInfo:TTreeNodeInfo;
begin
  SelectedRegisterNode:=Node;
  if Node=nil then exit;

  TreeNodeInfo:=TTreeNodeInfo(Node.Data);
  PR:=TPeripheral(TreeNodeInfo.Periph);

  if PR=nil then
    begin
     PeriphName.Text:='';
     PeriphDesc.Text:='';

     PeriphBaseAdr.Text:='';
     PeriphSize.Text:='';
    end
  else
    begin
      PeriphName.Text:=PR.name;
      PeriphDesc.Text:=PR.desc;
      PeriphBaseAdr.Text:=PR.baseAddress;
      PeriphSize.Text:=PR.size;
    end;

  RG:=TRegister(TreeNodeInfo.Reg);
  if RG=nil then
    begin
      RegName.Text:='';
      RegDesc.Text:='';
      RegOfs.Text:='';
      RegAcc.Text:='';
      RegRes.Text:='';
      RegFullAdr.Text:='';
      RegValue.Text:='';
      RFGrid.RowCount:=1;
      exit;
    end;

  RegName.Text:=RG.name;
  RegDesc.Text:=RG.desc;
  RegOfs.Text:=RG.adrOffset;
  RegAcc.Text:=RG.access;
  RegRes.Text:=RG.resetValue;

  RegFullAdr.Text:='0x'+IntToHex(HexToDW(PeriphBaseAdr.text)+HexToDW(RegOfs.Text), 8);

  RFGrid.RowCount:=RG.Fields.Count+1;

  RegFieldList:=TList(RG.Fields);

  for f:=0 to RG.Fields.Count-1 do
    begin
      FR:=TField(RG.Fields.Items[f]);
      RFGrid.Cells[0, f+1]:=FR.name;
      RFGrid.Cells[1, f+1]:=inttostr(FR.bitOffset)+' : '+inttostr(FR.bitWidth);
      RFGrid.Cells[3, f+1]:=FR.desc;
    end;

  commSendName:='REGMDW';
  sendMess('mdw '+RegFullAdr.Text+' 1');
end;

procedure TDebugForm.RFGridDblClick(Sender: TObject);
begin
  if (FieldRowSelect<0) or (FieldRowSelect>=RFGrid.RowCount) then exit;

  TField(RegFieldList.Items[FieldRowSelect]).vmode:=TField(RegFieldList.Items[FieldRowSelect]).vmode+1;
  if TField(RegFieldList.Items[FieldRowSelect]).vmode=3 then
    TField(RegFieldList.Items[FieldRowSelect]).vmode:=0;

  PerTreeChange(Sender, SelectedRegisterNode);
end;

procedure TDebugForm.RFGridSelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
  FieldRowSelect:=aRow-1;
end;


function TDebugForm.setBreakPoint(adr: string; getStatus: boolean=true): boolean;
begin
  Result:=false;
  if not telnetConnected then exit;

  sendMess('bp '+adr+' 2 hw');

  if getStatus then MCU_StatusButton.Click;
  Result:=true;
end;

// очистить точку останова
function TDebugForm.clrBreakPoint(adr: string; getStatus: boolean=true): boolean;
begin
  Result:=false;
   if not telnetConnected then exit;

  sendMess('rbp '+adr);

  if getStatus then MCU_StatusButton.Click;
  Result:=true;
end;

// запись прошивки в устройство
procedure TDebugForm.MCUProgramming(filename: string);
begin
  programming_fl:=true;  // запуск сервера в режиме программирования
  prog_file:=StringReplace(filename, '\', '/', [rfReplaceAll]);

  MainForm.MessagesListBox.Items.Clear;

  MainForm.MessagesListBox.Items.add('Запуск openOCD-сервера');
  MainForm.ProcessMess;
  StartServerButton.Click;
end;

procedure TDebugForm.MCUProgrammingProcess;
begin
  LTelnetClientComponent1.OnReceive:=@LTelnetProgrammingReceive;

  sendMess('load_image '+prog_file+' '+Project.Project_MCU_TargetAdr+' bin 0');

end;

// получение сообщений от хоста
procedure TDebugForm.LTelnetProgrammingReceive(aSocket: TLSocket);
var
  BytesRead    : longint;
  Buffer       : array[1..1000000] of byte;
  str:string;
  i:integer;
begin
  LTelnetClientComponent1.Output.Position:=0;
  BytesRead:=LTelnetClientComponent1.Output.Read(Buffer{%H-}, 1000000);

  receiveData.Clear;
  str:='';
  i:=1;
  while i<BytesRead do
    begin
      if Buffer[i]<32 then
         begin
           if (str<>'') then  receiveData.Add(str);
           str:='';
         end
       else  str:=str+char(Buffer[i]);
       i:=i+1;
    end;
  if (str<>'') then  receiveData.Add(str);

  // если ответ получен полностью - парсим полученное
  if (utf8Pos('>', receiveData.Text, 1)>0) and wait_answer and LTelnetClientComponent1.Connected then
     begin
       for i:=0 to receiveData.Count-1 do
         MainForm.MessagesListBox.Items.add(receiveData.Strings[i]);
       receiveData.Clear;
       LTelnetClientComponent1.OnReceive:=@LTelnetClientComponent1Receive;
       programming_fl:=false;
       StopServerButtonClick(nil);
     end;
end;

// установить цвет формы
procedure TDebugForm.SetFormColor(bkg: TColor);
begin
  // вкладка openODC server
  Memo1.Color:=bkg;

  Edit1.Color:=bkg;
  Memo2.Color:=bkg;

  BreakGrid.Color:=bkg;
  WatchGrid.Color:=bkg;
  PointAdrGrid.Color:=bkg;
  CoreRegGrid.Color:=bkg;

  PerTree.Color:=bkg;
  PeriphName.Color:=bkg;
  PeriphDesc.Color:=bkg;
  PeriphBaseAdr.Color:=bkg;
  PeriphSize.Color:=bkg;

  RegName.Color:=bkg;
  RegDesc.Color:=bkg;
  RegOfs.Color:=bkg;
  RegAcc.Color:=bkg;
  RegRes.Color:=bkg;
  RFGrid.Color:=bkg;
  RegFullAdr.Color:=bkg;
  RegValue.Color:=bkg;

  // Память микроконтроллера
  MemAreaBox.Color:=bkg;
  MemAreaAdr.Color:=bkg;
  MemAreaSize.Color:=bkg;
  MemAreaGrid.Color:=bkg;
end;

// уничтожение формы
procedure TDebugForm.FormDestroy(Sender: TObject);
begin
  receiveData.Free;
end;

procedure TDebugForm.FormResize(Sender: TObject);
var
  i, t:integer;
begin
  if not DebugForm.Visible then exit;

  BreakGrid.ColWidths[0]:=140;
  BreakGrid.ColWidths[1]:= DebugForm.Width-165;

  PointAdrGrid.ColWidths[0]:=DebugForm.Width-PointAdrGrid.ColWidths[1]-
                             PointAdrGrid.ColWidths[2]-PointAdrGrid.ColWidths[3]-20;

  RFGrid.ColWidths[3]:=RFGrid.Width-RFGrid.ColWidths[0]-RFGrid.ColWidths[1]-RFGrid.ColWidths[2];

  // расчет ширины ячеек таблицы
  if (MemAreaGrid.RowCount>0) and (MemAreaGrid.ColCount>1) then
    begin
      MemAreaGrid.ColWidths[0]:=90;
      i:=(MemAreaGrid.Width-90-16) div (MemAreaGrid.ColCount-1);
      if (MemAreaTypeBox.ItemIndex=0) and (i<32) then i:=32;
      if (MemAreaTypeBox.ItemIndex=1) and (i<42) then i:=42;
      if (MemAreaTypeBox.ItemIndex=2) and (i<70) then i:=70;
      for t:=1 to MemAreaGrid.ColCount-1 do MemAreaGrid.ColWidths[t]:=i;
    end;
end;


// показ точки останова в коде
procedure TDebugForm.BreakGridDblClick(Sender: TObject);
begin
  ST.GetDebugAdrText(BreakPoint_Addres, true);
end;

procedure TDebugForm.Bevel4ChangeBounds(Sender: TObject);
begin

end;

procedure TDebugForm.BreakGridSelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
   BreakPoint_Addres:='';

  if (aRow<0) or (aRow>=BreakGrid.RowCount) then exit;
  BreakPoint_Addres:=BreakGrid.Cells[0, aRow];
end;

// получение значения регистра
function TDebugForm.getMCURegValue(rgname: string): string;
var
  i:integer;
begin
  Result:='';
  for i:=0 to CoreRegGrid.RowCount-1 do
    if CoreRegGrid.Cells[0, i]=rgname then
      begin
        Result:=CoreRegGrid.Cells[4, i];
        exit;
      end;
end;

// RUN с остановом в следующей команде
procedure TDebugForm.MCU_RunStepButtonClick(Sender: TObject);
var
  str:string;
  line:integer;
  i:integer;
  Tokens:TTokenList;
  tok:TToken;
  val:DWord;
begin
  if ST=nil then exit;

  Memo2.Lines.Add('Команда: Run Step');

  RunStepBreakAdr:='';
  str:=TDAsmTextParser(ST.TextParser).getAdrLine(MCU_PC_Adr, line); // текущая строка

   // анализ текущей команды
   Tokens:=TTokenList(ST.GetLineTokens(line));
   i:=0;
   while i<Tokens.Count do
     begin
       tok:=TToken(Tokens.GetToken(i));
       if utf8pos('b.', tok.Text, 1)=1 then
         begin
           RunStepBreakAdr:='0x'+TToken(Tokens.GetToken(i+1)).Text;
           break;
         end;
       if (tok.Text='bx') then
         begin
           RunStepBreakAdr:=getMCURegValue(TToken(Tokens.GetToken(i+1)).Text);
           val:=strtoint(RunStepBreakAdr)-1;
           RunStepBreakAdr:='0x'+IntToHex(val, 8);
           break;
         end;
       if utf8pos('bl', tok.Text, 1)=1 then
         begin
          while (ST.Count>line) and (RunStepBreakAdr='') do
            begin
              line:=line+1;
              RunStepBreakAdr:=TDAsmTextParser(ST.TextParser).getLineAdr(line);
            end;
           break;
         end;
       i:=i+1;
     end;
   // если спец команда не распознана то не ставим точку останова и выполняем просто step
   if RunStepBreakAdr='' then
     begin
       MCU_StepButtonClick(sender);
       exit;
     end;
   // адрес следующей команды
   Memo2.Lines.Add('Установка точки останова после команды: '+RunStepBreakAdr);
   setBreakPoint(RunStepBreakAdr, false);
   MCU_ResumeButtonClick(sender); // запустим исполнение
end;


// закрытие формы
procedure TDebugForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  StopServerButtonClick(Sender);
  CloseAction:=caHide;
end;


// очистить окно сообщений cli
procedure TDebugForm.Memo1ClearButtonClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;


// Command Line Interface ------------------------------------------------------

// запуск сервера отладки
procedure TDebugForm.StartServerButtonClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Timer1.Enabled:=false;

  if not FileExists(OpenOCDConfigForm.ServerExeFile) then
    begin
      ShowMessage('Файл запуска openOCD.exe не найден');
      exit;
    end;
  Memo1.Lines.add('Параметры запуска OpenOCD:');
  Memo1.Lines.add('Сервер: '+OpenOCDConfigForm.ServerExeFile);

  if (OpenOCDConfigForm.Device_FRadio.Checked) and (not FileExists(OpenOCDConfigForm.TargetFile)) then
    begin
      ShowMessage('Файл конфигурации программатора не найден');
      exit;
    end;
  if (OpenOCDConfigForm.Device_FRadio.Checked) then Memo1.Lines.add('Программатор: '+OpenOCDConfigForm.TargetFile)
                                       else Memo1.Lines.add('Программатор: "'+OpenOCDConfigForm.TargetText.Text+'"');

  if not FileExists(Project.Project_MCU_OpenOCD) then
    begin
      ShowMessage('Файл конфигурации отлаживаемого MCU не найден [ '+Project.Project_MCU_OpenOCD+' ]');
      exit;
    end;
  Memo1.Lines.add('MCU: '+Project.Project_MCU_OpenOCD);
  Memo1.Lines.add('Transport: '+OpenOCDConfigForm.ConnectStr);
  Memo1.Lines.add('');

  if Assigned(OpenODCProcess) then
    begin
      OpenODCProcess.Terminate(3);
      OpenODCProcess.Free;
      serverWorked:=false;
    end;

  OpenODCProcess:=TProcess.Create(MainForm);
  OpenODCProcess.Executable:=OpenOCDConfigForm.ServerExeFile;
  // программатор
  if (OpenOCDConfigForm.Device_FRadio.Checked) then
    begin
       OpenODCProcess.Parameters.Add('-f');
       OpenODCProcess.Parameters.Add(OpenOCDConfigForm.TargetFile);
    end
  else
    begin
      OpenODCProcess.Parameters.Add('-c');
      OpenODCProcess.Parameters.Add('"'+OpenOCDConfigForm.TargetText.Text+'"');
    end;

  // способ подключения
  OpenODCProcess.Parameters.Add('-c');
  OpenODCProcess.Parameters.Add('"transport select '+OpenOCDConfigForm.ConnectStr+'"');

  // устройство к которому подключаемся
  OpenODCProcess.Parameters.Add('-f');
  OpenODCProcess.Parameters.Add(Project.Project_MCU_OpenOCD);

  OpenODCProcess.Options :=[poUsePipes, poStdErrToOutput];
  if HideServerConsoleCheckBox.Checked then OpenODCProcess.ShowWindow:=swoHide
                                       else OpenODCProcess.ShowWindow:=swoMinimize;
  OpenODCProcess.Execute;

  StartServerButton.Enabled:=false;
  telnetFirstConnect:=true;
  telnetConnected:=false;

  Timer1.Enabled:=true;

end;

// остановить сервер openODC
procedure TDebugForm.StopServerButtonClick(Sender: TObject);
begin
 wait_answer:=false;

 Timer1.Enabled:=false;
 serverWorked:=false;
 telnetConnected:=false;

   // выключим кнопки
  MCU_RunButton.Enabled:=false;
  MCU_HaltButton.Enabled:=false;
  MCU_ResetHalt.Enabled:=false;
  MCU_StepButton.Enabled:=false;
  MCU_ResumeButton.Enabled:=false;
  MCU_AutoStepButton.Enabled:=false;
  MCU_StopButton.Enabled:=false;
  MCU_StatusButton.Enabled:=False;
  MCU_RunStepButton.Enabled:=false;

  StartServerButton.Enabled:=true;
  TelnetConnectButton.Enabled:=true;
  SendMessButton.Enabled:=false;

 if not Assigned(OpenODCProcess) then exit;

 LTelnetClientComponent1.Disconnect(true);

 OpenODCProcess.Terminate(3);
 FreeAndNil(OpenODCProcess);
end;

// показ сообщений от сервера openODC
procedure TDebugForm.Timer1Timer(Sender: TObject);
var
  OutputStream : TStream;
  BytesRead    : longint;
  Buffer       : array[1..2048] of byte;
  outResultList: TStringList;
  p1:integer;
begin
    // получаем результат работы сервера в потоке
   while OpenODCProcess.Output.NumBytesAvailable>0 do
      begin
        BytesRead := OpenODCProcess.Output.Read(Buffer{%H-}, 2048);
        OutputStream := TMemoryStream.Create;
        OutputStream.Write(Buffer, BytesRead);

        OutputStream.Position := 0;
        outResultList:=TStringList.Create;
        outResultList.LoadFromStream(OutputStream);
        Memo1.Lines.AddStrings(outResultList, false);

        OutputStream.Free;
        outResultList.Free;
      end;

   p1:=UTF8Pos('Listening on port 3333 for gdb connections', Memo1.Text, 1);

   if (p1>0) and (telnetFirstConnect) then
      begin
        telnetFirstConnect:=false;
        serverWorked:=true;
        PageControl1.ActivePageIndex:=1;
        TelnetConnectButtonClick(Sender);
      end;

   if UTF8Pos('Error:', Memo1.Text, 1)>0 then // ошибка при подключении
     begin
       if programming_fl then
            begin
               MainForm.MessagesListBox.Items.add('Ошибка !');
               for p1:=0 to Memo1.Lines.Count-1 do
                 MainForm.MessagesListBox.Items.add(Memo1.Lines.Strings[p1]);
               programming_fl:=false;
               StopServerButtonClick(nil);
               exit;
            end;
     end;

   p1:=UTF8Pos('connection on tcp/4444', Memo1.Text, 1);

   if (p1>0) and (not telnetConnected) { and (not telnetFirstConnect) } then
      begin
         Memo2.Lines.Clear;
         Memo2.Lines.Add('Подключено к localhost : 4444');
         telnetConnected:=true;

         if programming_fl then
            begin
              MCUProgrammingProcess;
              exit;
            end;

         // включим кнопки
         MCU_RunButton.Enabled:=true;
         MCU_HaltButton.Enabled:=true;
         MCU_ResetHalt.Enabled:=true;
         MCU_StepButton.Enabled:=true;
         MCU_ResumeButton.Enabled:=true;
         MCU_AutoStepButton.Enabled:=true;
         TelnetConnectButton.Enabled:=false;
         SendMessButton.Enabled:=true;
         MCU_StatusButton.Enabled:=true;
         MCU_RunStepButton.Enabled:=true;
         // выключим кнопки
         MCU_StopButton.Enabled:=false;
         PageControl1.ActivePageIndex:=2;

         GetBreakPointFromSysSasm;
         MCU_StatusButtonClick(Sender); // статус
      end;
end;

procedure TDebugForm.setRunFL(AValue: boolean);
begin
  if run_fl=AValue then Exit;
  run_fl:=AValue;
end;



// --- Telnet Dialog -----------------------------------------------------------

// подключиться к хосту
procedure TDebugForm.TelnetConnectButtonClick(Sender: TObject);
begin
  if not serverWorked then exit;

  telnetConnected:=false;
  LTelnetClientComponent1.Disconnect(true);

  if TelnetServer.Text='' then TelnetServer.Text:='localhost';
  if TelnetPort.Text='' then TelnetPort.Text:='4444';

  LTelnetClientComponent1.Connect(TelnetServer.Text, strtoint(TelnetPort.Text));
end;

// отправка сообщения
procedure TDebugForm.SendMessButtonClick(Sender: TObject);
begin
  commSendName:='';
  sendMess(Edit1.Text);
end;

// удаление точки останова
procedure TDebugForm.MCU_DEL_BreakPointClick(Sender: TObject);
var
  adr:string;
begin
  if BreakGrid.RowCount<2 then exit;

  if BreakPoint_Addres='' then BreakPoint_Addres:=BreakGrid.Cells[0,1];

  adr:=BreakPoint_Addres;
  Memo2.Lines.Add('Команда: REMOVE BP: Удаление точки останова по адресу: '+BreakPoint_Addres);

  clrBreakPoint(adr);
  ST.ClearBreakPointAdr(adr);
end;

// halt
procedure TDebugForm.MCU_HaltButtonClick(Sender: TObject);
begin
  commSendName:='HALT';
  Memo2.Lines.Add('Команда: HALT: Принудительный останов');
  sendMess('halt');

  MCU_StatusButtonClick(Sender);

  MCU_ResetHalt.Enabled:=true;
  MCU_StepButton.Enabled:=true;
  MCU_ResumeButton.Enabled:=true;
  MCU_AutoStepButton.Enabled:=true;
  MCU_StopButton.Enabled:=true;
  MCU_RunStepButton.Enabled:=true
end;

// reset halt
procedure TDebugForm.MCU_ResetHaltClick(Sender: TObject);
begin
  commSendName:='RESET HALT';
  Memo2.Lines.Add('Команда: RESET HALT: Сброс микроконтроллера и останов');
  sendMess('reset halt');

  MCU_StatusButtonClick(Sender);

  MCU_ResetHalt.Enabled:=true;
  MCU_StepButton.Enabled:=true;
  MCU_ResumeButton.Enabled:=true;
  MCU_AutoStepButton.Enabled:=true;
  MCU_StopButton.Enabled:=true;
end;

procedure TDebugForm.MCU_ResumeButtonClick(Sender: TObject);
begin
  Memo2.Lines.Add('Команда: RESUME: Продолжение исполнения программы');
  CoreRegGrid.RowCount:=1;
  commSendName:='RESUME';

  MCUState.Caption:='Running';
  MCUState.Font.Color:=clBlue;
  CodeText.Caption:='Нет';

  MCU_ResetHalt.Enabled:=false;
  MCU_StepButton.Enabled:=false;
  MCU_ResumeButton.Enabled:=false;
  MCU_AutoStepButton.Enabled:=false;
  MCU_StopButton.Enabled:=false;

  running:=true;

  sendMess('resume');

  MCU_StatusButton.Click;
end;

procedure TDebugForm.MCU_RunButtonClick(Sender: TObject);
begin
  Memo2.Lines.Add('Команда: RUN: Сброс и запуск MCU');
  CoreRegGrid.RowCount:=1;
  commSendName:='RESET RUN';

  MCUState.Caption:='Running';
  MCUState.Font.Color:=clBlue;
  CodeText.Caption:='Нет';

  MCU_ResetHalt.Enabled:=false;
  MCU_StepButton.Enabled:=false;
  MCU_ResumeButton.Enabled:=false;
  MCU_AutoStepButton.Enabled:=false;
  MCU_StopButton.Enabled:=false;
  MCU_RunStepButton.Enabled:=false;
  running:=true;

  sendMess('reset run');

  MCU_StatusButton.Click;

end;

// включение режима Run Step
procedure TDebugForm.MCU_AutoStepButtonClick(Sender: TObject);
begin
  case RunStepPauseComboBox.ItemIndex of
    0: RunStepTimer.Interval:=1;
    else RunStepTimer.Interval:=RunStepPauseComboBox.ItemIndex*100;
  end;
  runstep:=true;

  // выключим кнопки
  MCU_RunButton.Enabled:=false;
  MCU_HaltButton.Enabled:=false;
  MCU_ResetHalt.Enabled:=false;
  MCU_StepButton.Enabled:=false;
  MCU_ResumeButton.Enabled:=false;
  MCU_AutoStepButton.Enabled:=false;
  MCU_StatusButton.Enabled:=False;

  // включим кнопки
  MCU_StopButton.Enabled:=true;

  RunStepTimer.Enabled:=true;
end;

// получим  статус микроконтроллера
procedure TDebugForm.MCU_StatusButtonClick(Sender: TObject);
var
  i:integer;
begin
  MCU_ResetHalt.Enabled:=true;
  MCU_StepButton.Enabled:=true;
  MCU_ResumeButton.Enabled:=true;
  MCU_AutoStepButton.Enabled:=true;
  MCU_StopButton.Enabled:=true;
  MCU_RunStepButton.Enabled:=true;

  if RunStepBreakAdr<>'' then
    begin
      memo2.Lines.Add('Удаление  точки останова после RUN STEP: '+RunStepBreakAdr);
      commSendName:='RBP';
      clrBreakPoint(RunStepBreakAdr, false);
    end;

  Memo2.Lines.Add('Команда: STATUS: Получим статус микроконтроллера:');
  Memo2.Lines.Add('');

  commSendName:='REG';
  Memo2.Lines.Add('- Запрос данных регистров mcu');
  sendMess('reg');

  BreakGrid.RowCount:=1;
  commSendName:='BP';
  Memo2.Lines.Add('- Запрос данных точек останова');
  sendMess('bp');

  // отслеживание изменений открытого узла
  Memo2.Lines.Add('- Запрос данных периферии');
  PerTreeChange(sender, SelectedRegisterNode);

  for i:=1 to PointAdrGrid.RowCount-1 do
    begin
      Memo2.Lines.Add('- Запрос значений переменных');
      PointAdrGrid.cells[3, i]:='';
      case UTF8UpperCase(PointAdrGrid.cells[2, i]) of
        'WORD':  begin
                   commSendName:='ONEMDW';
                   sendMess('mdw '+PointAdrGrid.cells[1, i]+' 1');
          end;
        'HWORD': begin
                   commSendName:='ONEMDH';
                   sendMess('mdh '+PointAdrGrid.cells[1, i]+' 1');
          end;
        'BYTE':  begin
                   commSendName:='ONEMDB';
                   sendMess('mdb '+PointAdrGrid.cells[1, i]+' 1');
          end;
      end;
    end;
end;

// step
procedure TDebugForm.MCU_StepButtonClick(Sender: TObject);
begin
  commSendName:='STEP';
  Memo2.Lines.Add('Команда: STEP: Один шаг исполнения');
  sendMess('step');

  MCU_StatusButtonClick(Sender);

end;

// stop (остановка режима AutoStep)
procedure TDebugForm.MCU_StopButtonClick(Sender: TObject);
begin
  RunStepTimer.Enabled:=false;

  runstep:=false;

  MCU_StatusButtonClick(Sender);

  // включим кнопки
  MCU_RunButton.Enabled:=true;
  MCU_HaltButton.Enabled:=true;
  MCU_ResetHalt.Enabled:=true;
  MCU_StepButton.Enabled:=true;
  MCU_ResumeButton.Enabled:=true;
  MCU_AutoStepButton.Enabled:=true;
  MCU_StatusButton.Enabled:=true;

  // выключим кнопки
  MCU_StopButton.Enabled:=False;
end;

// добавить область памяти
procedure TDebugForm.MemAreaAddButtonClick(Sender: TObject);
var
  MemArea:TMemArea;
begin
  if MemAreaTypeBox.ItemIndex<0 then exit;

  // заполним описатель области
  MemArea:=TMemArea.Create;
  MemArea.adrStart:=MemAreaAdr.Text;
  MemArea.size:=MemAreaSize.Text;
  MemArea.mtype:=MemAreaTypeBox.ItemIndex;
  // добавим в список
  MemAreaBox.AddItem(MemArea.adrStart+' - '+ MemArea.size+' - '+MemAreaTypeBox.Text, MemArea);
end;

// удалить область памяти
procedure TDebugForm.MemAreaDelButtonClick(Sender: TObject);
begin
  if MemAreaBox.ItemIndex<0 then exit;

  // удалить область памяти
  MemAreaBox.Items.Delete(MemAreaBox.ItemIndex);
end;

// изменить область памяти
procedure TDebugForm.MemAreaChangeButtonClick(Sender: TObject);
var
  MemArea:TMemArea;
begin
  if MemAreaBox.ItemIndex<0 then exit;

  MemArea:=TMemArea(MemAreaBox.Items.Objects[MemAreaBox.ItemIndex]);
  MemAreaBox.Items.Strings[MemAreaBox.ItemIndex]:=MemArea.adrStart+
                            ' - '+ MemArea.size+' - '+MemAreaTypeBox.Text;

  MemArea.adrStart:=MemAreaAdr.Text;
  MemArea.size:=MemAreaSize.Text;
  MemArea.mtype:=MemAreaTypeBox.ItemIndex;
end;

// выбрать область памяти
procedure TDebugForm.MemAreaBoxSelectionChange(Sender: TObject; User: boolean);
var
  MemArea:TMemArea;
begin
  if MemAreaBox.ItemIndex<0 then
    begin
     MemAreaAdr.Text:='';
     MemAreaSize.Text:='';
     MemAreaTypeBox.ItemIndex:=-1;
     exit;
    end;

  MemArea:=TMemArea(MemAreaBox.Items.Objects[MemAreaBox.ItemIndex]);
  MemAreaAdr.Text:=MemArea.adrStart;
  MemAreaSize.Text:=MemArea.size;
  MemAreaTypeBox.ItemIndex:=MemArea.mtype;

  MemAreaRefreshButton.Click;
end;

// получение информации об области памяти
procedure TDebugForm.MemAreaRefreshButtonClick(Sender: TObject);
var
  comm:string;
begin
  // тип команды-получения данных
  case MemAreaTypeBox.ItemIndex of
    0: comm:='mdb ';
    1: comm:='mdh ';
    2: comm:='mdw ';
  end;

  commSendName:='MEMARR';
  comm:=comm+MemAreaAdr.Text+' '+MemAreaSize.Text;
  Memo2.Lines.Add('Запрос массива памяти');

  sendMess(comm);
end;



// получение сообщений от хоста
procedure TDebugForm.LTelnetClientComponent1Receive(aSocket: TLSocket);
var
  BytesRead    : longint;
  Buffer       : array[1..1000000] of byte;
  str:string;
  i:integer;
begin
  LTelnetClientComponent1.Output.Position:=0;
  BytesRead:=LTelnetClientComponent1.Output.Read(Buffer{%H-}, 1000000);

  receiveData.Clear;
  str:='';
  i:=1;
  while i<BytesRead do
    begin
      if Buffer[i]<32 then
         begin
           if (str<>'') then  receiveData.Add(str);
           str:='';
         end
       else  str:=str+char(Buffer[i]);
       i:=i+1;
    end;
  if (str<>'') then  receiveData.Add(str);

  // если ответ получен полностью - парсим полученное
  if utf8Pos('>', receiveData.Text, 1)>0 then
     begin
       if not TelnetMessShow.Checked then Memo2.Lines.AddStrings(receiveData);
       parse_Answer;
     end;
end;

// отправка строки на хост
procedure TDebugForm.sendMess(str: string);
begin
  receiveData.Clear;
  wait_answer:=true;
  LTelnetClientComponent1.Output.Clear;
  LTelnetClientComponent1.SendMessage(str+#$0d +#$0a);

  Memo2.Lines.Add('Ожидание ответа');
  while wait_answer and LTelnetClientComponent1.Connected do
    begin
      MainForm.ProcessMess;
    end;

end;

// очистить окно Telnet обмена
procedure TDebugForm.Memo2ClearButtonClick(Sender: TObject);
begin
  Memo2.Lines.Clear;
end;

// таймер RunStep
procedure TDebugForm.RunStepTimerTimer(Sender: TObject);
begin
  if not runstep then exit;

  RunStepTimer.Enabled:=false;

  MCU_StepButtonClick(Sender);

  MainForm.ProcessMess;

  RunStepTimer.Enabled:=true;
end;

procedure TDebugForm.StatusTimerTimer(Sender: TObject);
begin
  StatusTimer.Enabled:=false;;
  StatusEvent:=true;
end;

// выбор команды для отправки
procedure TDebugForm.ComboBox1Change(Sender: TObject);
begin
  Edit1.Text:=ComboBox1.Text;
end;



// --------------- разбор получаемых с telnet данных ---------------------------

// перевод строки hex в строку bin
function TDebugForm.HexToBinStr(tstr: string): string;
var
  i:integer;
begin
  if tstr='' then
    begin
      Result:='';
      exit;
    end;

  Result:='0b ';
  for i:=3 to UTF8Length(tstr) do
    case UTF8UpperCase(utf8Copy(tstr, i, 1)) of
      '0': Result:=Result+'0000 ';
      '1': Result:=Result+'0001 ';
      '2': Result:=Result+'0010 ';
      '3': Result:=Result+'0011 ';
      '4': Result:=Result+'0100 ';
      '5': Result:=Result+'0101 ';
      '6': Result:=Result+'0110 ';
      '7': Result:=Result+'0111 ';
      '8': Result:=Result+'1000 ';
      '9': Result:=Result+'1001 ';
      'A': Result:=Result+'1010 ';
      'B': Result:=Result+'1011 ';
      'C': Result:=Result+'1100 ';
      'D': Result:=Result+'1101 ';
      'E': Result:=Result+'1110 ';
      'F': Result:=Result+'1111 ';
    end;

  Result:=UTF8Copy(Result, 1, UTF8Length(Result)-1);
end;

// перевод строки hex в строку dec
function TDebugForm.HexToDecStr(tstr: string): string;
begin
  if tstr='' then Result:=''
             else Result:=inttostr(HexToDW(tstr));
end;

// перевод из hex в DWord
function TDebugForm.HexToDW(hexStr: string): DWord;
var
  i:integer;
  w:DWord;
begin
  if hexStr='' then
    begin
      Result:=0;
      exit;
    end;

  w:=0;
  for i:=3 to UTF8Length(hexStr) do
    case UTF8UpperCase(utf8Copy(hexStr, i, 1)) of
      '0': w:=w*16+0;
      '1': w:=w*16+1;
      '2': w:=w*16+2;
      '3': w:=w*16+3;
      '4': w:=w*16+4;
      '5': w:=w*16+5;
      '6': w:=w*16+6;
      '7': w:=w*16+7;
      '8': w:=w*16+8;
      '9': w:=w*16+9;
      'A': w:=w*16+10;
      'B': w:=w*16+11;
      'C': w:=w*16+12;
      'D': w:=w*16+13;
      'E': w:=w*16+14;
      'F': w:=w*16+15;
    end;
  Result:=w;
end;

function TDebugForm.BinStrToHex(binstr:string):string;
var
  i:integer;
  b:DWord;
begin
  Result:='';
  if binstr='' then exit;
  b:=0;
  i:=1;;
  while i<=UTF8Length(binstr) do
    begin
      b:=b*2;
      if utf8copy(binstr, i, 1)='1' then b:=b+1;
      i:=i+1;
    end;
  i:=(UTF8Length(binstr) div 4);
  if (UTF8Length(binstr) mod 4)>0 then i:=i+1;

  Result:=IntToHex(b, i);
end;

procedure TDebugForm.ParseRegValue;
var
  pos, i:integer;
  str, val:string;
begin
  i:=1;
  while i<receiveData.Count do
    begin
      str:=UTF8LowerCase(receiveData.Strings[i]);
      pos:=UTF8Pos(':', str, 1);
      if pos>0 then
        begin
          MemoryReadSuccess:=true;
          // прочитаем значение
          pos:=pos+1;
          while UTF8Copy(str, pos, 1)=' ' do pos:=pos+1;
          val:=UTF8Copy(str, pos, UTF8Length(str)-pos);

          RegValue.Text:='0x'+val;
          SetRegisterFieldGrid;
          exit;
        end;
      i:=i+1;
    end;
  Memo2.Lines.Add('');
end;

//  установка полей регистра
procedure TDebugForm.SetRegisterFieldGrid;
var
  binStr:string;
  bins:string;
  f:integer;
  RF:TField;
begin
  if RegFieldList=nil then exit;

  binstr:=intToBin(HexToDW(RegValue.Text), 32);
  for f:=0 to RegFieldList.Count-1 do
    begin
      RF:=TField(RegFieldList.Items[f]);
      bins:=utf8Copy(binstr, 33-RF.bitOffset-RF.bitWidth, RF.bitWidth);
      case RF.vmode of
        0: RFGrid.Cells[2, f+1]:='0b '+bins;
        1: RFGrid.Cells[2, f+1]:='0x '+BinStrToHex(bins);
        2: RFGrid.Cells[2, f+1]:='   '+HexToDecStr('0x'+BinStrToHex(bins));
      end;
    end;
end;


procedure TDebugForm.ParseMemoryRead;
var
  pos, i:integer;
  str, adr, val:string;
begin
  i:=1;

  while i<receiveData.Count do
    begin
      str:=UTF8LowerCase(receiveData.Strings[i]);
      pos:=UTF8Pos(':', str, 1);
      if pos>0 then
        begin
          MemoryReadSuccess:=true;
          // прочитаем значение
          adr:=UTF8Copy(str, 1, pos-1);
          pos:=pos+1;
          while UTF8Copy(str, pos, 1)=' ' do pos:=pos+1;
          val:=UTF8Copy(str, pos, UTF8Length(str)-pos);

          //  запишем в таблицу
          for pos:=1 to PointAdrGrid.RowCount-1 do
            begin
              if UTF8UpperCase(PointAdrGrid.Cells[1, pos])=UTF8UpperCase(adr) then
                begin
                  Memo2.Lines.Add('  Переменная: '+PointAdrGrid.Cells[0, pos]+
                                  ' Адрес: '+PointAdrGrid.Cells[1, pos]+
                                  ' Значение: '+val);
                 PointAdrGrid.Cells[3, pos]:=val;
                 exit;
                end;
            end;

        end;
      i:=i+1;
    end;
  Memo2.Lines.Add('');
end;

// парсинг чтения области памяти
procedure TDebugForm.ParseMemoryArea;
var
  i, t, x,y:integer;
  TL:TTokenList;
  Res:TStringList;
  adr:DWord;
begin
  i:=1;
  Res:=TStringList.Create;
  while i<receiveData.Count do
    begin
      TL:=TTokenList.Create;
      TL.ParseLineStr(receiveData.Strings[i]);
      if (TL.Count>2) and (TToken(TL.GetToken(1)).Text=':') then
        for t:=2 to TL.Count-1 do
          begin
             Res.Add(TToken(TL.GetToken(t)).Text);
          end;
      TL.Free;
      i:=i+1;
    end;

  // разметка таблицы
  MemAreaGrid.RowCount:=2;
  MemAreaGrid.ColCount:=strtoint(MemTableWidth.Text)+1;
  MemAreaGrid.FixedCols:=1;
  MemAreaGrid.FixedRows:=1;
  // оистим таблицу
  for t:=0 to strtoint(MemTableWidth.Text)-1 do MemAreaGrid.Cells[t,1]:='';

  // расчет ширины ячеек таблицы
  MemAreaGrid.ColWidths[0]:=90;
  i:=(MemAreaGrid.Width-90-16) div (MemAreaGrid.ColCount-1);
  if (MemAreaTypeBox.ItemIndex=0) and (i<32) then i:=32;
  if (MemAreaTypeBox.ItemIndex=1) and (i<42) then i:=42;
  if (MemAreaTypeBox.ItemIndex=2) and (i<70) then i:=70;
  for t:=1 to MemAreaGrid.ColCount-1 do MemAreaGrid.ColWidths[t]:=i;

  // заполнение заголовка
  for i:=0 to strtoint(MemTableWidth.Text)-1 do
    MemAreaGrid.Cells[i+1,0]:=inttostr(i);

  // заполнение адреса
  adr:=HexToDW(MemAreaAdr.Text);
  MemAreaGrid.Cells[0, 1]:='0x'+IntToHex(adr, 8);

  // заполнение таблицы
  x:=1; y:=1;
  for t:=0 to Res.Count-1 do
    begin
      MemAreaGrid.Cells[x,y]:=Res.Strings[t];
      x:=x+1;

      // увеличим адрес
      case MemAreaTypeBox.ItemIndex of
        0: adr:=adr+1;
        1: adr:=adr+2;
        2: adr:=adr+4;
      end;

      if x>strtoint(MemTableWidth.Text) then
        begin
          x:=1;
          y:=y+1;
          MemAreaGrid.RowCount:=y+1;
          MemAreaGrid.Cells[0, y]:='0x'+IntToHex(adr, 8);
        end;

    end;
  if MemAreaGrid.Cells[1, y]='' then MemAreaGrid.RowCount:=y;
end;


procedure TDebugForm.parse_Answer;
var
  i, p, x, line:integer;
  str, regstr, tstr, sz:string;
begin
  if commSendName='MEMARR' then
    begin
      ParseMemoryArea;
      wait_answer:=false;
      exit;
    end;

  // приоритетное чтение переменных - всегда должно быть раньше MDx обработок
  if (commSendName='ONEMDB') or (commSendName='ONEMDH') or (commSendName='ONEMDW') then
    begin
      ParseMemoryRead;
      wait_answer:=false;
      exit;
    end;

  if (commSendName='REGMDW') then
    begin
      ParseRegValue;
      wait_answer:=false;
      exit;
    end;

  // обработка команды BP - показ точек останова
  str:=utf8lowercase(receiveData.Strings[0]);
  if (commSendName='BP') or (utf8pos('bp',str,1)=1) then
    begin
       Memo2.lines.Add('Результат: Получены данные точек останова');
       i:=0;
       line:=1;
       BreakGrid.RowCount:=1;
       while i<receiveData.Count do
         begin
           str:=UTF8LowerCase(receiveData.Strings[i]);
           p:=UTF8Pos(': ', str, 1);
           if p<>0 then
             begin
               p:=p+2;
               x:=UTF8Pos(',', str, p);
               tstr:=UTF8Copy(str, p, x-p);

               BreakGrid.RowCount:=line+1;
               BreakGrid.Cells[0, line]:=tstr;
               BreakGrid.Cells[1, line]:=ST.GetAsmFromAdr(tstr);
               Memo2.Lines.Add('Адрес: '+tstr);
               line:=line+1;
             end;
           i:=i+1;
         end;
       Memo2.Lines.Add('');
       commSendName:='';
       wait_answer:=false;
       exit;
    end;

  // обработка команды REG - показ значений регистров
  if (commSendName='REG') or (utf8pos('reg',str,1)=1) then
    begin
      Memo2.lines.Add('Результат: Получены данные регистров');
      Memo2.lines.Add('');
      i:=0;
      line:=1;
      CoreRegGrid.RowCount:=1;
      while (i<receiveData.Count) do
        begin
          if (utf8Pos('(', receiveData.Strings[i], 1)=1) then
            begin
              if CoreRegGrid.RowCount<=line then CoreRegGrid.RowCount:=line+1;

              str:=UTF8LowerCase(receiveData.Strings[i]);
              // прочитаем  имя регистра
              x:=utf8Pos(' ', str, 2)+1;
              p:=utf8Pos(' ', str, x);
              regstr:=utf8copy(str, x, p-x);
              CoreRegGrid.Cells[0, line]:=regstr;

              // прочитаем размерность
              x:=utf8Pos('(', str, p)+2;
              p:=utf8Pos(')', str, x);
              sz:=utf8copy(str, x, p-x);
              CoreRegGrid.Cells[1, line]:=sz;

              // прочитаем значение
              x:=utf8Pos(' ', str, p)+1;
              p:=utf8Pos(' ', str, x+1);
              if p=0 then p:=UTF8Length(str);
              tstr:=utf8copy(str, x, p-x+1);
              if utf8copy(tstr, 1,1)='(' then tstr:='';
              if sz<>'64' then
                begin
                  CoreRegGrid.Cells[2, line]:=tstr;
                  CoreRegGrid.Cells[3, line]:=HexToBinStr(tstr);
                  CoreRegGrid.Cells[4, line]:=HexToDecStr(tstr);
                end
              else
                begin
                  CoreRegGrid.Cells[2, line]:='-->';
                  CoreRegGrid.Cells[3, line]:=tstr;
                  CoreRegGrid.Cells[4, line]:='';
                end;
              // покажем команду по адресу
              if (regstr='pc') then
                if (ST<>nil) then
                  begin
                    CodeText.Caption:=ST.GetDebugAdrText(tstr, true);
                    MCU_PC_Adr:=tstr;
                  end
                else CodeText.Caption:=tstr;

              line:=line+1;
            end;
           i:=i+1;
          end;
          ShowMCUStatus;
          commSendName:='';
          wait_answer:=false;
          exit;
       end;


  if (commSendName='RESET HALT') or
     (
        (utf8pos('reset',str,1)>0) and
        (utf8pos('halt',str,1)>0)  and
        (
          utf8pos('reset',str,1)<utf8pos('halt',str,1)
        )
     ) then
    begin
      Memo2.lines.Add('Результат: MCU остановлен');
      Memo2.lines.Add('');
      commSendName:='';
      wait_answer:=false;
      exit;
    end;

  if (commSendName='RESET RUN') or
     (
        (utf8pos('reset',str,1)>0) and
        (utf8pos('run',str,1)>0)  and
        (
          utf8pos('reset',str,1)<utf8pos('run',str,1)
        )
     ) then
    begin
      i:=0; x:=0;
      while i<receiveData.Count do
        begin
          str:=lowercase(receiveData.Strings[i]);
          if utf8pos('xpsr:', str, 1)>0 then x:=1;
          i:=i+1;
        end;
      receiveData.Clear;
      if x=0 then exit;

      Memo2.lines.Add('Результат: MCU перезапущен');
      Memo2.lines.Add('');
      commSendName:='';
      wait_answer:=false;
      running:=false;

      exit;
    end;

  // обработка команды HALT - останов
  if (commSendName='HALT') or (utf8pos('halt', str, 1)=1) then
    begin
      Memo2.lines.Add('Результат: MCU остановлен');
      Memo2.lines.Add('');
      commSendName:='';
      wait_answer:=false;
      exit;
    end;

  // обработка команды STEP - шаг исполнения
  if (commSendName='STEP') or (utf8pos('step', str, 1)=1) then
    begin
      Memo2.lines.Add('Результат: Выполнен Один шаг программы');
      Memo2.lines.Add('');
      commSendName:='';
      wait_answer:=false;
      exit;
    end;

  // обработка команды RESUME - возобновление исполнения
  if (commSendName='RESUME') or (utf8pos('resume', str, 1)=1) then
    begin
      i:=0; x:=0;
      while i<receiveData.Count do
        begin
          str:=lowercase(receiveData.Strings[i]);
          if utf8pos('xpsr:', str, 1)>0 then x:=1;
          i:=i+1;
        end;
      receiveData.Clear;
      if x=0 then exit;

      Memo2.lines.Add('Результат: Возобновление исполнения программы');
      Memo2.lines.Add('');
      commSendName:='';
      wait_answer:=false;
      running:=false;
      exit;
    end;

  wait_answer:=false;
  receiveData.Clear;
  if running then running:=false;
end;



// показ состояния mcu
procedure TDebugForm.ShowMCUStatus;
var
  i:integer;
  xpsr:boolean;
  primask:boolean;
  faultmask:boolean;
  basepri:boolean;
  _control:boolean;
begin
  i:=0;
  xpsr:=false;
  primask:=false;
  faultmask:=false;
  basepri:=false;
  _control:=false;


  while i<CoreRegGrid.RowCount-1 do
    begin
      // регистр xpsr 0b 0000 0000 0000 0000 0000 0000 0000 0000
      if (CoreRegGrid.Cells[0,i]='xpsr') and (CoreRegGrid.Cells[3,i]<>'') then
        begin
         xpsr:=true;
         // флаг N
          if utf8copy(CoreRegGrid.Cells[3,i], 4, 1)='1' then
            begin
             FlagN.Font.Color:=clRed;
             FlagN.Hint:='Флаг установлен';
            end
          else
            begin
             FlagN.Font.Color:=clBlue;
             FlagN.Hint:='Флаг сброшен';
            end;

         // флаг Z
          if utf8copy(CoreRegGrid.Cells[3,i], 5, 1)='1' then
            begin
             FlagZ.Font.Color:=clRed;
             FlagZ.Hint:='Флаг установлен';
            end
          else
            begin
             FlagZ.Font.Color:=clBlue;
             FlagZ.Hint:='Флаг сброшен';
            end;

          // флаг C
           if utf8copy(CoreRegGrid.Cells[3,i], 6, 1)='1' then
             begin
              FlagC.Font.Color:=clRed;
              FlagC.Hint:='Флаг установлен';
             end
           else
             begin
              FlagC.Font.Color:=clBlue;
              FlagC.Hint:='Флаг сброшен';
             end;

          // флаг V
           if utf8copy(CoreRegGrid.Cells[3,i], 7, 1)='1' then
             begin
               FlagV.Font.Color:=clRed;
               FlagV.Hint:='Флаг установлен';
             end
           else
             begin
               FlagV.Font.Color:=clBlue;
               FlagV.Hint:='Флаг сброшен';
             end;

          // флаг Q
           if utf8copy(CoreRegGrid.Cells[3,i], 9, 1)='1' then
             begin
               FlagQ.Font.Color:=clRed;
               FlagQ.Hint:='Флаг установлен';
             end
           else
             begin
               FlagQ.Font.Color:=clBlue;
               FlagQ.Hint:='Флаг сброшен';
             end;

          // флаг ICI
          FlagICI.Caption:='ICI: '+utf8copy(CoreRegGrid.Cells[3,i], 10, 2);
          if utf8copy(CoreRegGrid.Cells[3,i], 10, 2)<>'00' then
            begin
               FlagICI.Font.Color:=clRed;
               FlagICI.Hint:='Флаг установлен';
             end
           else
             begin
               FlagICI.Font.Color:=clBlue;
               FlagICI.Hint:='Флаг сброшен';
             end;

          // флаг T
           if utf8copy(CoreRegGrid.Cells[3,i], 12, 1)='1' then
             begin
               FlagT.Font.Color:=clRed;
               FlagT.Hint:='Флаг установлен';
             end
           else
             begin
               FlagT.Font.Color:=clBlue;
               FlagT.Hint:='Флаг сброшен';
             end;

          // флаг GE
           FlagGE.Caption:='GE: '+utf8copy(CoreRegGrid.Cells[3,i], 19, 4);
           if utf8copy(CoreRegGrid.Cells[3,i], 19, 4)<>'0000' then
             begin
               FlagGE.Font.Color:=clRed;
               FlagGE.Hint:='Флаг установлен';
             end
           else
             begin
               FlagGE.Font.Color:=clBlue;
               FlagGE.Hint:='Флаг сброшен';
             end;

         // флаг IT
          FlagIT.Caption:='IT: '+utf8copy(CoreRegGrid.Cells[3,i], 24, 4)+
                                  utf8copy(CoreRegGrid.Cells[3,i], 29, 1);
          if FlagIT.Caption<>'IT: 00000' then
            begin
              FlagIT.Font.Color:=clRed;
              FlagIT.Hint:='Флаг установлен';
            end
          else
            begin
              FlagIT.Font.Color:=clBlue;
              FlagIT.Hint:='Флаг сброшен';
            end;

         // флаг IPSR
          FlagIPSR_Num.Caption:=utf8copy(CoreRegGrid.Cells[3,i], 32, 1)+
                                utf8copy(CoreRegGrid.Cells[3,i], 34, 4)+
                                utf8copy(CoreRegGrid.Cells[3,i], 39, 4);
          if FlagIPSR_Num.Caption<>'000000000' then
            begin
              FlagIPSR_Num.Font.Color:=clRed;
              FlagIPSR_Num.Hint:='Флаг установлен';
            end
          else
            begin
              FlagIPSR_Num.Font.Color:=clBlue;
              FlagIPSR_Num.Hint:='Флаг сброшен';
            end;
        end;

     // регистр primask 0b 0000 0000
     if (CoreRegGrid.Cells[0,i]='primask') and (CoreRegGrid.Cells[3,i]<>'') then
        begin
         primask:=true;
         // флаг PRIMASK
          if utf8copy(CoreRegGrid.Cells[3,i], 12, 1)='1' then
            begin
             FlagPrimask.Font.Color:=clRed;
             FlagPrimask.Hint:='Флаг установлен';
            end
          else
            begin
             FlagPrimask.Font.Color:=clBlue;
             FlagPrimask.Hint:='Флаг сброшен';
            end;
         end;

     // регистр faultmask 0b 0000 0000
     if (CoreRegGrid.Cells[0,i]='faultmask') and (CoreRegGrid.Cells[3,i]<>'') then
        begin
         faultmask:=true;
         // флаг FaultMask
          if utf8copy(CoreRegGrid.Cells[3,i], 12, 1)='1' then
            begin
             FlagFaultMask.Font.Color:=clRed;
             FlagFaultMask.Hint:='Флаг установлен';
            end
          else
            begin
             FlagFaultMask.Font.Color:=clBlue;
             FlagFaultMask.Hint:='Флаг сброшен';
            end;
         end;

     // регистр basepri 0b 0000 0000
     if (CoreRegGrid.Cells[0,i]='basepri') and (CoreRegGrid.Cells[3,i]<>'') then
        begin
         basepri:=true;
         // флаг basepri
          FlagBasePri.Caption:=utf8copy(CoreRegGrid.Cells[3,i], 4, 4);
          if FlagBasePri.Caption<>'0000' then
            begin
             FlagBasePri.Font.Color:=clRed;
             FlagBasePri.Hint:='Флаг установлен';
            end
          else
            begin
             FlagBasePri.Font.Color:=clBlue;
             FlagBasePri.Hint:='Флаг сброшен';
            end;
         end;

     // регистр control 0b 0000 0000
     if (CoreRegGrid.Cells[0,i]='control') and (CoreRegGrid.Cells[3,i]<>'') then
        begin
         _control:=true;
         // флаг FPCA
         if utf8copy(CoreRegGrid.Cells[3,i], 10, 1)='1' then
            begin
             FlagFPCA.Font.Color:=clRed;
             FlagFPCA.Hint:='Флаг установлен';
            end
          else
            begin
             FlagFPCA.Font.Color:=clBlue;
             FlagFPCA.Hint:='Флаг сброшен';
            end;

         // флаг SPSEL
         if utf8copy(CoreRegGrid.Cells[3,i], 11, 1)='1' then
            begin
             FlagSPSEL.Font.Color:=clRed;
             FlagSPSEL.Hint:='Флаг установлен';
            end
          else
            begin
             FlagSPSEL.Font.Color:=clBlue;
             FlagSPSEL.Hint:='Флаг сброшен';
            end;

         // флаг nPRIV
         if utf8copy(CoreRegGrid.Cells[3,i], 12, 1)='1' then
            begin
              FlagnPriv.Font.Color:=clRed;
              FlagnPriv.Hint:='Флаг установлен';
              MCUMode.Caption:='Unprivileged';
              MCUMode.Font.Color:=clRed;
            end
         else
            begin
              FlagnPriv.Font.Color:=clBlue;
              FlagnPriv.Hint:='Флаг сброшен';
              MCUMode.Caption:='Privileged';
              MCUMode.Font.Color:=clBlue;
            end;
         end;
       i:=i+1;
    end;

  // если xpsr небыло - сбросим его флаги в неизвестное состояние
  if not xpsr then
    begin
      FlagN.Font.Color:=clBlack;
      FlagN.Hint:='Состояние неизвестно';
      FlagZ.Font.Color:=clBlack;
      FlagZ.Hint:='Состояние неизвестно';
      FlagC.Font.Color:=clBlack;
      FlagC.Hint:='Состояние неизвестно';
      FlagV.Font.Color:=clBlack;
      FlagV.Hint:='Состояние неизвестно';
      FlagQ.Font.Color:=clBlack;
      FlagQ.Hint:='Состояние неизвестно';
      FlagICI.Caption:='ICI:';
      FlagICI.Font.Color:=clBlack;
      FlagICI.Hint:='Состояние неизвестно';
      FlagT.Font.Color:=clBlack;
      FlagT.Hint:='Состояние неизвестно';
      FlagGE.Caption:='GE:';
      FlagGE.Font.Color:=clBlack;
      FlagGE.Hint:='Состояние неизвестно';
      FlagIT.Caption:='GE:';
      FlagIT.Font.Color:=clBlack;
      FlagIT.Hint:='Состояние неизвестно';
      FlagIPSR_Num.Caption:='#';
      FlagIPSR_Num.Font.Color:=clBlack;
      FlagIPSR_Num.Hint:='Состояние неизвестно';
    end;

  if not primask then
    begin
      FlagPrimask.Font.Color:=clBlack;
      FlagPrimask.Hint:='Состояние неизвестно';
    end;

  if not faultmask then
    begin
      FlagFaultMask.Font.Color:=clBlack;
      FlagFaultMask.Hint:='Состояние неизвестно';
    end;

  if not basepri then
    begin
      FlagBasePri.Font.Color:=clBlack;
      FlagBasePri.Hint:='Состояние неизвестно';
    end;

  if not _control then
    begin
      FlagFPCA.Font.Color:=clBlack;
      FlagFPCA.Hint:='Состояние неизвестно';
      FlagSPSEL.Font.Color:=clBlack;
      FlagSPSEL.Hint:='Состояние неизвестно';
      FlagnPriv.Font.Color:=clBlack;
      FlagnPriv.Hint:='Состояние неизвестно';
      MCUMode.Caption:=' --- ';
      MCUMode.Font.Color:=clBlack;
    end;

  if (CoreRegGrid.RowCount>1)then
    if (CoreRegGrid.Cells[2,1]='') then
      begin
        MCUState.Caption:='Running';
        MCUState.Font.Color:=clBlue;
      end
    else
      begin
        if runstep then
          begin
            MCUState.Caption:='Run Step Mode';
            MCUState.Font.Color:=clRed;
          end
        else
          begin
            MCUState.Caption:='Halted';
           MCUState.Font.Color:=clGreen;
          end;
      end;

end;


end.

