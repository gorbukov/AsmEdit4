unit SymbUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, LazUTF8,
  SymbolsUnit;

type

  { TSymbForm }

  TSymbForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    ImageList1: TImageList;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ListBox1: TListBox;
    PageControl2: TPageControl;
    SymbEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    PageControl1: TPageControl;
    Panel2: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TreeView1: TTreeView;
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListBox1SelectionChange(Sender: TObject; {%H-}User: boolean);
    procedure SymbEditChange(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
  private
     function GetNodeFromName(nm:string):TTreeNode; // поиск узла по имени

     procedure ConstructSymbInfo; //построение кода
  public
     start:boolean;
     Symbols:TSymbolList;

     newSymbol:boolean;
     SymbolName:string;
  end;

var
  SymbForm: TSymbForm;

implementation

{$R *.lfm}

{ TSymbForm }

procedure TSymbForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
   if Key=27 then ModalResult:=mrCancel;
   if Key=13 then ModalResult:=mrOk;

   if Shift=[ssCtrl] then
     begin
        if Key=78 then
          begin
             PageControl1.ActivePageIndex:=0;
             SymbEdit.SetFocus;
          end;
        if Key=80 then PageControl1.ActivePageIndex:=1;
     end;
end;

procedure TSymbForm.ListBox1SelectionChange(Sender: TObject; User: boolean);
begin
   Edit2.Text:='';
   Edit3.Text:='';
   Edit4.Text:='';
   if ListBox1.Items.Objects[ListBox1.ItemIndex]=nil then exit;
   Edit4.Text:=TSymbol(ListBox1.Items.Objects[ListBox1.ItemIndex]).descr;
   Edit2.Text:=TSymbol(ListBox1.Items.Objects[ListBox1.ItemIndex]).valueStr;
   Edit3.Text:=TSymbol(ListBox1.Items.Objects[ListBox1.ItemIndex]).file_name;

   newSymbol:=false;
   SymbolName:=ListBox1.Items[ListBox1.ItemIndex];
end;

// ввод имени нового символа
procedure TSymbForm.SymbEditChange(Sender: TObject);
var
  i:integer;
  res:boolean;
begin
   if SymbEdit.Text='' then
     begin
       Label2.Caption:='Имя не задано';
       Label2.Font.Color:=clRed;
       Memo2.Lines.Clear;
       exit;
     end;

   res:=true;
   for i:=0 to Symbols.Count-1 do
     begin
       if TSymbol(Symbols.getSymbol(i)).name=SymbEdit.Text then
         begin
           res:=false;
           break;
         end;
     end;
   if res then
     begin
       Label2.Caption:='Имя свободно';
       Label2.Font.Color:=clGreen;
       ConstructSymbInfo;
       newSymbol:=true;
       SymbolName:=SymbEdit.Text;
     end
   else
     begin
        Label2.Caption:='Имя занято';
        Label2.Font.Color:=clRed;
        Memo2.Lines.Clear;
     end;
end;

procedure TSymbForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
   Edit2.Text:='';
   Edit3.Text:='';
   Edit4.Text:='';
   if Node.Data=nil then exit;
   Edit4.Text:=TSymbol(Node.Data).descr;
   Edit2.Text:=TSymbol(Node.Data).valueStr;
   Edit3.Text:=TSymbol(Node.Data).file_name;

   newSymbol:=false;
   SymbolName:=TSymbol(Node.Data).name;
end;

// поиск узла по имени
function TSymbForm.GetNodeFromName(nm: string): TTreeNode;
var
  i, c:integer;
begin
   GetNodeFromName:=nil;
   c:=TreeView1.Items.Count-1;
  for i:=0 to c do
    if (TTreeNode(TreeView1.Items[i]).Text=nm) then
      begin
        GetNodeFromName:=TTreeNode(TreeView1.Items[i]);
        break;
      end;
end;



//построение кода
procedure TSymbForm.ConstructSymbInfo;
var
  str:string;
begin
  Memo2.Lines.Clear;
   case ComboBox1.ItemIndex of
    0: begin
         Memo2.Lines.Add('@.Area=Desc');
         str:='.equ '+SymbEdit.Text+' , '+Memo1.Text;
         if Edit5.Text<>'' then str:=str+' @ '+Edit5.Text;
         Memo2.Lines.Add(str);
         newSymbol:=true;
         SymbolName:=SymbEdit.Text;
         exit;
       end;
    1: Memo2.Lines.Add('@.Area=Const');
    2: Memo2.Lines.Add('@.Area=Var');
   end;

   case ComboBox2.ItemIndex of
    0: str:='.byte';
    1: str:='.hword';
    2: str:='.word';
    3: str:='.space';
    4: str:='.ascii';
    5: str:='.asciz';
   end;

   str:=SymbEdit.Text+': '+str+' '+Memo1.Text;
   if Edit5.Text<>'' then str:=str+' @ '+Edit5.Text;
   Memo2.Lines.Add(str);
end;

procedure TSymbForm.FormActivate(Sender: TObject);
var
  i, k, u:integer;
  TN:TTreeNode;
  res:boolean;
  istop:boolean;
begin
   PageControl1.ActivePageIndex:=0;

   TN:=TreeView1.Items.Add(nil, '.GLOBAL / MODULE');
   TN.Data:=nil;
   TN.ImageIndex:=0;

   if start then // если это первая активация формы - установим фокус
     begin
        SymbEdit.SetFocus;
        start:=false;

        for i:=0 to Symbols.Count-1 do
          begin
             istop:=false;
             // проверим топовость символа

             // у символа нет UpItem
             if TStringList(TSymbol(Symbols.getSymbol(i)).item).Count=0 then
                begin // это символ верхнего уровня
                  TN:=TreeView1.Items.AddChild(GetNodeFromName('.GLOBAL / MODULE'), TSymbol(Symbols.getSymbol(i)).name);
                  TN.Data:=TSymbol(Symbols.getSymbol(i));
                  TN.ImageIndex:=0;
                  istop:=true;
                end
             else     // проверим наличие символа с именем .item если символа нет, то топовым
                begin // является символ с именем .item
                  res:=true;
                  for k:=0 to Symbols.Count-1 do
                    for u:=0 to TStringList(TSymbol(Symbols.getSymbol(i)).item).Count-1 do
                      if TStringList(TSymbol(Symbols.getSymbol(i)).item).Strings[u]=TSymbol(Symbols.getSymbol(k)).name then
                        begin
                          res:=false;
                          break;
                        end;

                  if res then // символ .item тоже является топовым
                    begin
                      istop:=false;
                      TN:=GetNodeFromName(TStringList(TSymbol(Symbols.getSymbol(i)).item).strings[0]);
                      if TN=nil then
                        begin
                          TN:=TreeView1.Items.Add(nil, TStringList(TSymbol(Symbols.getSymbol(i)).item).strings[0]);
                          TN.Data:=nil;
                          TN.ImageIndex:=1;
                          istop:=true;
                        end;
                    end;
                end;

              // если символ не топовый то добавим его к уже существующему узлу
            if not istop then
              for k:=0 to TreeView1.Items.Count-1 do
                if TSymbol(Symbols.getSymbol(i)).symbInGroup(TTreeNode(TreeView1.Items[k]).Text) then
                  begin
                    TN:=TreeView1.Items.AddChild(TreeView1.Items[k],  TSymbol(Symbols.getSymbol(i)).name);
                    TN.Data:=TSymbol(Symbols.getSymbol(i));
                  end;

            // добавим символ в линейный список
            ListBox1.Items.AddObject(TSymbol(Symbols.getSymbol(i)).name, Symbols.getSymbol(i));
          end;
     end;
   Label13.Caption:=inttostr(ListBox1.Items.Count);

   SymbEditChange(Sender);
end;

procedure TSymbForm.Button5Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

// изменение фильтра отбора
procedure TSymbForm.Edit1Change(Sender: TObject);
var
  i:integer;
begin
   ListBox1.Clear;
   for i:=0 to Symbols.Count-1 do
     begin
        if (
             (Edit1.Text<>'')
             and (UTF8Pos(Edit1.Text, TSymbol(Symbols.getSymbol(i)).name,1)>0)
           ) or (Edit1.Text='') then
           ListBox1.Items.AddObject(TSymbol(Symbols.getSymbol(i)).name, Symbols.getSymbol(i));
     end;
end;

procedure TSymbForm.Button4Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

// очистим редактор значений
procedure TSymbForm.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TSymbForm.FormCreate(Sender: TObject);
begin
  start:=true;
end;

end.

