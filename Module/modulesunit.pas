unit ModulesUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, ExtCtrls,
  StdCtrls, IniFiles, LazUTF8, LazFileUtils;

type
  // класс описания узла дерева модулей
  TModItem=class(TObject)
    txt:string;
    script:string;
  end;

  { TModulesForm }

  TModulesForm = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    ImageList1: TImageList;
    Label1: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    TreeView1: TTreeView;

    procedure FormCreate(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);

  private
     TN:TTreeNode; // корневой уровень дерева

     function splitString(str:string; num:integer; delim:string):string; // получение части суб строки (для getFullFileName)
     procedure GetScriptInfo(Node: TTreeNode);
     function SubNodeFromName(nodename: string): TTreeNode; // поиск подузла по имени

  public
     procedure AddModuleFile(nm:string); // добавление файла модуля в дерево
  end;


implementation

uses MainUnit, ProjectUnit;
{$R *.lfm}

{ TModulesForm }

procedure TModulesForm.FormCreate(Sender: TObject);
begin
  TN:=TreeView1.Items.Add(nil, Project.Project_MCU);
  TN.Data:=nil;
  TN.ImageIndex:=0;
end;

procedure TModulesForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  ComboBox1.Items.Clear;
  Memo1.Lines.Clear;
  Edit1.Text:='';
  if Node.Data<>nil then GetScriptInfo(Node);

end;

// получение части суб строки (для getFullFileName)
function TModulesForm.splitString(str: string; num: integer; delim: string
  ): string;
var
  st, p:integer;
begin
   p:=1;
   while (num>0) do
      begin
        st:=p;
        while (p<=UTF8Length(str)) and (UTF8Copy(str, p, 1)<>delim) do p:=p+1;
        num:=num-1;
        p:=p+1;
      end;
   splitString:=UTF8Copy(str, st, p-1-st);
end;


// получить информацию из файла скрипта
procedure TModulesForm.GetScriptInfo(Node: TTreeNode);
var
   inis:TIniFile;
   strl:TStringList;
   i:integer;
   scr_file:string;
   str:string;
begin
   Edit1.Text:=Node.Text;

   scr_file:=TModItem(Node.Data).script;

   if not FileExistsUTF8(scr_file) then exit;

   inis:=TIniFile.Create(scr_file);

   // прочитаем описание модуля
   strl:=TStringList.Create;
   inis.ReadSectionRaw('DESC', strl);
   Memo1.Text:=strl.Text;
   strl.Free;

   // прочитаем список действий
   i:=0;
   while inis.ReadString('ACTIONS', 'act'+inttostr(i),'')<>'' do
     begin
       str:=inis.ReadString('ACTIONS', 'link'+inttostr(i),'');
       if str<>'ADD' then ComboBox1.Items.Add(inis.ReadString('ACTIONS', 'act'+inttostr(i),''));
       i:=i+1;
     end;
   if ComboBox1.Items.Count>0 then ComboBox1.ItemIndex:=0;

   inis.Free;
end;

// поиск подузла по имени
function TModulesForm.SubNodeFromName(nodename: string): TTreeNode;
var
  i:integer;
begin
  SubNodeFromName:=nil;

  for i:=0 to TreeView1.Items.Count-1 do
    if TTreeNode(TreeView1.Items[i]).Text=nodename then
      begin
         SubNodeFromName:=TTreeNode(TreeView1.Items[i]);
         exit;
      end;
end;

// добавление файла модуля в дерево
procedure TModulesForm.AddModuleFile(nm: string);
var
  inif:TIniFile;
  str, str1:string;
  P:integer;
  TN1, TN2:TTreeNode;
  ni:TModItem;
begin
  inif:=TIniFile.Create(nm);

  str:=inif.ReadString('MODULE', 'group', '');

  p:=1;
  TN1:=TN;
  while splitString(str, p, '/')<>'' do
    begin
      str1:=splitString(str, p, '/');
      if str1<>'MCU' then
        begin
          TN2:=SubNodeFromName(str1);
          if TN2=nil then TN2:=TreeView1.Items.AddChild(TN1, str1);
          TN2.Data:=nil;
          TN2.ImageIndex:=0;
          TN1:=TN2;
        end;
      p:=p+1;
    end;
  str:=inif.ReadString('MODULE', 'caption', '');
  TN2:=TreeView1.Items.AddChild(TN1, str);
  ni:=TModItem.Create;
  ni.txt:=str;
  ni.script:=nm;
  TN2.Data:=ni;
  TN2.ImageIndex:=1;
  inif.free;

  TN.Expand(false);
end;

end.

