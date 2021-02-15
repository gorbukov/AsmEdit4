unit SymbListunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, Grids, LazUTF8,
  SymbolsUnit,
  ProjectUnit;

type

  { TSymbListForm }

  TSymbListForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    ComboBox1: TComboBox;
    Edit6: TEdit;
    Label14: TLabel;
    Label15: TLabel;
    Memo1: TMemo;
    SectionComboBox: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    SymbolGrid: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    SymbTree: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure Button1KeyUp(Sender: TObject; var {%H-}Key: Word; {%H-}Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit5Change(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; {%H-}Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure SymbolGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SymbolGridSelectCell(Sender: TObject; {%H-}aCol, aRow: Integer;
      var {%H-}CanSelect: Boolean);
    procedure SymbTreeChange(Sender: TObject; Node: TTreeNode);
    procedure SymbTreeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );

  private
    start:boolean;

    fullSymbList:TSymbolList;

     function GetNodeFromName(nm: string; var st: integer): TTreeNode; // поиск узла по имени
     procedure SymbolListSet(topitem: string; Symbols: TSymbolList);    // построение списков
  public
     selectedSymbol:TSymbol;  // результат работы
     symbolName:string;
     procedure SymbolListSetStart(symbStr: string);
     procedure SymbolListGlobalSet(Symbols:TSymbolList);    // построение списков глобальных символов
     procedure SymbolListLocalSet(Symbols:TSymbolList);     // построение списков локальных символов
     procedure SymbFilterList;  // построение списка по фильтру
     procedure setVisualParams(bkgColor:TColor; fnt:TFont); // задание цветов
  end;

implementation

{$R *.lfm}

{ TSymbListForm }
uses MainUnit, AsmFuncUnit;


// выбор символа в дереве
procedure TSymbListForm.SymbTreeChange(Sender: TObject; Node: TTreeNode);
var
   i:integer;
   str:string;
begin
  if not start then exit;

  Edit1.Text:='';
  Edit2.Text:='';
  Edit3.Text:='';
  label2.Caption:='';
  label4.Caption:='';

  if Node.Data=nil then exit;

  selectedSymbol:=TSymbol(Node.Data);
  symbolName:=selectedSymbol.Name;

  str:='';
  for i:=0 to selectedSymbol.itemNames.Count-1 do
    str:=str+TStringList(selectedSymbol.itemNames).Strings[i]+' ';
  Edit1.Text:=str;

  Edit2.Text:=selectedSymbol.ValueStr;

  Edit3.Text:='';   // рассчитанное значение

  label2.Caption:=selectedSymbol.TypeStr;
  label4.Caption:=selectedSymbol.FileName;
end;

// выбор символа по Enter
procedure TSymbListForm.SymbTreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=13 then // Enter
         begin
             Key:=0;
            Button1.Click;
         end;
end;

// выбор символа из списка
procedure TSymbListForm.SymbolGridSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
var
   TN:TTreeNode;
   i, n:integer;
begin
  if not start then exit;
  n:=0;
  TN:=TTreeNode(GetNodeFromName(SymbolGrid.Cells[2, aRow], n));
  if (TN=nil) or (TN.Data=nil) then exit;

  selectedSymbol:=TSymbol(TN.Data);
  symbolName:=selectedSymbol.Name;

  // свернем все узлы
  for i:=0 to SymbTree.Items.Count-1 do
    TTreeNode(SymbTree.Items[i]).Expanded:=false;

  TN.ExpandParents;
  TN.Selected:=true; // выберем узел
end;

procedure TSymbListForm.Button3Click(Sender: TObject);
begin
  Edit4.Text:='';
  SymbFilterList;
end;

procedure TSymbListForm.ComboBox1Change(Sender: TObject);
begin
  if ComboBox1.ItemIndex>0 then CheckBox1.Checked:=false else CheckBox1.Checked:=true;
  if ComboBox1.ItemIndex=1 then SectionComboBox.Enabled:=false else SectionComboBox.Enabled:=true;
end;

procedure TSymbListForm.Button2Click(Sender: TObject);
begin
  fullSymbList.free;
  ModalResult:=mrCancel;
end;

procedure TSymbListForm.Button1Click(Sender: TObject);
var
   line, last:integer;
begin
  // новый символ
  if (PageControl1.ActivePageIndex=0) then
    begin
      if (ComboBox1.ItemIndex<>0) then
        begin
         if ComboBox1.ItemIndex=1 then  // тип символа .equ
           begin
             if not SearchUpSection(line) then line:=line-1;
             InsertTextLine(line+1, '.equ  '+Edit5.Text+' , '+Memo1.Text+' @ '+Edit6.Text);
             if not CheckBox1.Checked then symbolName:='';
           end
         else
           begin
             if SearchSection(SectionComboBox.Text, line, last) then // ищем начало секции
               begin

               end
             else    // секция не найдена, добавляем в конец текста
               begin
                 line:=addSection(SectionComboBox.Text)+1;
               end;
               InsertTextLine(line+1, Edit5.Text+':  '+ComboBox1.text+'  '+Memo1.Text+' @ '+Edit6.Text);
               if not CheckBox1.Checked then symbolName:='';
           end;
        end;
    end;
  fullSymbList.free;
  ModalResult:=mrOk
end;

procedure TSymbListForm.Button1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

// изменение фильтра
procedure TSymbListForm.Edit4Change(Sender: TObject);
begin
  SymbFilterList;
end;

procedure TSymbListForm.Edit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   y:longint;
   gr:TGridRect;
begin
  case Key of
      38: // курсор вверх
      begin
          Key:=0;
         y:=SymbolGrid.Selection.Top;
         if y=1 then exit;
         SymbolGrid.Row:=y-1;
      end;
      40: // курсор вниз
      begin
          Key:=0;
         y:=SymbolGrid.Selection.Top;
         if y=SymbolGrid.RowCount then exit;
         SymbolGrid.Row:=y+1;
      end;
      13: // Enter
      begin
         Key:=0;
         Button1.Click;
      end;
    end;
end;

procedure TSymbListForm.Edit5Change(Sender: TObject);
begin
  symbolName:=Edit5.Text;
end;

procedure TSymbListForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=27 then ModalResult:=mrCancel;
  if (ssCtrl in Shift) then
  case Key of
    49: begin
          PageControl1.ActivePageIndex:=0;
          Edit5.SetFocus;
    end;
    50: begin
          PageControl1.ActivePageIndex:=1;
          Edit4.SetFocus;
    end;
    51: begin
          PageControl1.ActivePageIndex:=2;
          SymbTree.SetFocus;
    end;

  end;

end;

procedure TSymbListForm.FormShow(Sender: TObject);
begin
  Edit4.SetFocus;
end;

procedure TSymbListForm.SymbolGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  end;

function TSymbListForm.GetNodeFromName(nm: string; var st: integer): TTreeNode;
var
  i, c:integer;
begin
   GetNodeFromName:=nil;
  c:=SymbTree.Items.Count-1;
  for i:=st to c do
    if (TTreeNode(SymbTree.Items[i]).Text=nm) then
      begin
        st:=i;
        GetNodeFromName:=TTreeNode(SymbTree.Items[i]);
        exit;
      end;
  st:=SymbTree.Items.Count;
end;

// построение списка по фильтру
procedure TSymbListForm.SymbFilterList;
var
  i, y:integer;
  str:string;
begin
  if not start then exit;
  str:=UTF8UpperCase(Edit4.Text);
  SymbolGrid.RowCount:=fullSymbList.Count+1;
  y:=1;
  for i:=0 to fullSymbList.Count-1 do
    // если фильтр пустой
    if (str='') or (UTF8Pos(str, UTF8UpperCase(TSymbol(fullSymbList.GetSymb(i)).Name), 1)>0) then
      begin
        SymbolGrid.Cells[0,y]:=inttostr(y);
        SymbolGrid.Cells[1,y]:=TSymbol(fullSymbList.GetSymb(i)).TypeStr;
        SymbolGrid.Cells[2,y]:=TSymbol(fullSymbList.GetSymb(i)).Name;
        y:=y+1;
      end;
  SymbolGrid.RowCount:=y;
end;

// построение списков
procedure TSymbListForm.SymbolListSet(topitem: string; Symbols: TSymbolList);
var
  TN:TTreeNode;
  i, p, n:integer;
  isTop:boolean;
begin
  for i:=0 to Symbols.Count-1 do
    begin
      fullSymbList.AddSymb(TSymbol(Symbols.GetSymb(i))); // общий список символов

       if TStringList(TSymbol(Symbols.GetSymb(i)).itemNames).Count=0 then
         begin // это символ верхнего уровня
           n:=0;
           TN:=SymbTree.Items.AddChild(GetNodeFromName(topitem, n), TSymbol(Symbols.GetSymb(i)).name);
           TN.Data:=TSymbol(Symbols.getSymb(i));
           TN.ImageIndex:=1;
           TN.SelectedIndex:=2;
         end
       else

         begin // проверка категории на топовость
           isTop:=true;
           for p:=0 to TStringList(TSymbol(Symbols.GetSymb(i)).itemNames).Count-1 do
             if TStringList(TSymbol(Symbols.GetSymb(i)).itemNames).Strings[p]=TSymbol(Symbols.GetSymb(p)).Name then
               begin
                 isTop:=false;
                 break;
               end;

           if isTop then       // добавим отдельную категорию как топовую
             begin
               n:=0;
               TN:=GetNodeFromName(TStringList(TSymbol(Symbols.GetSymb(i)).itemNames).Strings[0], n);
               if TN=nil then
                 begin
                   TN:=SymbTree.Items.Add(nil, TStringList(TSymbol(Symbols.GetSymb(i)).itemNames).Strings[0]);
                   TN.ImageIndex:=0;
                   TN.Data:=nil;
                   TN.SelectedIndex:=0;
                 end;
               isTop:=false;
             end;

           if not isTop then    // вложенный символ
             begin
               for p:=0 to TStringList(TSymbol(Symbols.GetSymb(i)).itemNames).Count-1 do
                 begin
                   n:=0;
                   TN:=GetNodeFromName(TStringList(TSymbol(Symbols.GetSymb(i)).itemNames).Strings[p], n);
//                   if n>SymbTree.Items.Count then
//                     begin
//                       TN:=SymbTree.Items.AddChild(TN, TSymbol(Symbols.GetSymb(i)).Name);
//                       TN.Data:=TSymbol(Symbols.getSymb(i));
//                       TN.ImageIndex:=1;
//                       TN.SelectedIndex:=2;
//                     end
//                   else
                   while n<SymbTree.Items.Count do
                     begin
                       n:=n+1;
                       // символ к которому добавляем вложенный
                       TN:=SymbTree.Items.AddChild(TN, TSymbol(Symbols.GetSymb(i)).Name);
                       TN.Data:=TSymbol(Symbols.getSymb(i));
                       TN.ImageIndex:=1;
                       TN.SelectedIndex:=2;
                       TN:=GetNodeFromName(TStringList(TSymbol(Symbols.GetSymb(i)).itemNames).Strings[p], n);
                     end;
                 end;
             end;
         end;
    end;
  start:=true;
end;

procedure TSymbListForm.SymbolListSetStart(symbStr:string);
begin
  fullSymbList:=TSymbolList.Create;

  symbolName:='';

  start:=false;
  SymbTree.Items.Clear;
//  if symbstr<>'' then
    PageControl1.ActivePage:=TabSheet2;
  Edit4.Text:=symbStr; // фильтр

  Edit1.Text:='';
  Edit2.Text:='';
  Edit3.Text:='';
  label2.Caption:='';
  label4.Caption:='';

  SymbolGrid.ColWidths[0]:=50;
  SymbolGrid.ColWidths[1]:=120;
  SymbolGrid.ColWidths[2]:=TabSheet2.Width-190;
  SymbolGrid.Cells[0,0]:='№';
  SymbolGrid.Cells[1,0]:='Тип';
  SymbolGrid.Cells[2,0]:='Имя';
  SymbolGrid.RowCount:=1;

  Edit5.Text:='';
  Label11.Caption:='';
  // секции
  SectionComboBox.Items.Assign(Project.GetCodeSectionsList);
  if SectionComboBox.Items.Count>0 then SectionComboBox.ItemIndex:=0;
  Memo1.Clear;
  Edit6.Text:='';
  CheckBox1.Checked:=true;
end;

// построение списка локальных символов
procedure TSymbListForm.SymbolListGlobalSet(Symbols: TSymbolList);
var
   TN:TTreeNode;
begin
  TN:=SymbTree.Items.Add(nil, '.GLOBAL');
  TN.Data:=nil;
  TN.ImageIndex:=0;
  TN.SelectedIndex:=0;
  SymbolListSet('.GLOBAL', Symbols);
end;

// построение списков локальных символов
procedure TSymbListForm.SymbolListLocalSet(Symbols: TSymbolList);
var
   TN:TTreeNode;
begin
  TN:=SymbTree.Items.Add(nil, 'MODULE');
  TN.Data:=nil;
  TN.ImageIndex:=0;
  TN.SelectedIndex:=0;
  SymbolListSet('MODULE', Symbols);
end;



// задание цветов
procedure TSymbListForm.setVisualParams(bkgColor: TColor; fnt: TFont);
begin
  SymbTree.Color:=bkgColor;
  SymbTree.Font:=fnt;
  Panel2.Color:=clBtnFace;
  Panel3.Color:=clBtnFace;
  Edit1.Color:=bkgColor;
  Edit1.Font:=fnt;
  Edit2.Color:=bkgColor;
  Edit2.Font:=fnt;
  Edit3.Color:=bkgColor;
  Edit3.Font:=fnt;
  Label2.Font:=fnt;
  Label4.Font:=fnt;
  SymbolGrid.Color:=bkgColor;
  SymbolGrid.Font:=fnt;

  Edit5.Color:=bkgColor;
  Edit5.Font:=fnt;
  Edit6.Color:=bkgColor;
  Edit6.Font:=fnt;
  ComboBox1.Color:=bkgColor;
  ComboBox1.Font:=fnt;
  SectionComboBox.Color:=bkgColor;
  SectionComboBox.Font:=fnt;
  Memo1.Color:=bkgColor;
  Memo1.Font:=fnt;
end;

end.

