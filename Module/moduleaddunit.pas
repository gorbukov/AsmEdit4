unit ModuleAddUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, IniFiles, LazFileUtils,
  ProjectUnit,
  ScriptExecUnit; // модуль исполнения скриптов

type

  // класс описания узла дерева модулей
  TModItem=class(TObject)
    txt:string;
    link:string;
    script:string;
  end;

  { TModuleAddForm }

  TModuleAddForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    ImageList1: TImageList;
    Label1: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure AddNewNode(iname: string; node: TTreeNode);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);

    procedure GetScriptInfo(Node:TTreeNode); // получить информацию из файла скрипта
  private
     inif:TIniFile;
     scr_file:string;
  public
     procedure setColorFont(bkgColor:TColor; fnt:TFont);
  end;

var
  ModuleAddForm: TModuleAddForm;

implementation

uses MainUnit;

{$R *.lfm}

{ TModuleAddForm }

procedure TModuleAddForm.FormCreate(Sender: TObject);
var
  node: TTreeNode;
begin
  inif:=TIniFile.Create(app_path+Project.Project_MCU_FILE);

  // построение дерева
  node:=TreeView1.Items.AddChildObject(nil, Project.Project_MCU, nil);
  node.ImageIndex:=0;
  AddNewNode(Project.Project_MCU, node);
  node.Expand(false);
  inif.Free;
end;

procedure TModuleAddForm.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

// исполнение скрипта
procedure TModuleAddForm.Button2Click(Sender: TObject);
var
   inis:TIniFile;
   script:string;
begin
  if scr_file='' then exit;

   inis:=TIniFile.Create(scr_file);

   script:='ADD'; //inis.ReadString('ACTIONS', 'link'+inttostr(ComboBox1.ItemIndex), '');
   inis.Free;

   if ScriptExecute(scr_file, script, true) then
       MessageDlg('Добавление модуля',
                  'Модуль успешно добавлен в проект. Редактирование настроек возможно в добавленных файлах и/или через меню: "МОДУЛИ" - "Управление модулями"',
                  mtConfirmation, [mbOk], 0);

end;

// построение дерева модулей
procedure TModuleAddForm.AddNewNode(iname: string; node: TTreeNode);
var
   num:integer;
   MI:TModItem;
   child:TTreeNode;
begin
   num:=0;
   while inif.ReadString(iname, 'text'+inttostr(num), '')<>'' do
     begin
        MI:=TModItem.Create;
        MI.txt:=inif.ReadString(iname, 'text'+inttostr(num), '');
        MI.link:=inif.ReadString(iname, 'link'+inttostr(num), '');
        MI.script:=inif.ReadString(iname, 'script'+inttostr(num), '');

        child:=TreeView1.Items.AddChildObject(node, MI.txt, MI);
        child.ImageIndex:=1;
        if MI.link<>'' then
          begin
            child.ImageIndex:=0;
            AddNewNode(MI.link, child);
          end;

        num:=num+1;
     end;
end;

procedure TModuleAddForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  Edit1.Text:='';
//  ComboBox1.Items.Clear;
  Memo1.Lines.Clear;
  scr_file:='';
  if Node.Data=nil then exit;
  if TModItem(Node.Data).script='' then exit;

  Edit1.Text:=TModItem(Node.Data).txt;
  GetScriptInfo(Node);
//  Label4.Caption:='Скрипт: '+scr_file;
end;

// получить информацию из файла скрипта
procedure TModuleAddForm.GetScriptInfo(Node: TTreeNode);
var
   inis:TIniFile;
   strl:TStringList;
begin

   if not FileExistsUTF8(app_path+TModItem(Node.Data).script) then exit;
   scr_file:=app_path+TModItem(Node.Data).script;

   inis:=TIniFile.Create(scr_file);

   // прочитаем описание модуля
   strl:=TStringList.Create;
   inis.ReadSectionRaw('DESC', strl);
   Memo1.Text:=strl.Text;
   strl.Free;

   // прочитаем список действий
{   i:=0;
   while inis.ReadString('ACTIONS', 'act'+inttostr(i),'')<>'' do
     begin
        ComboBox1.Items.Add(inis.ReadString('ACTIONS', 'act'+inttostr(i),''));
        i:=i+1;
     end;
   if ComboBox1.Items.Count>0 then ComboBox1.ItemIndex:=0;
}
   inis.Free;
end;

procedure TModuleAddForm.setColorFont(bkgColor: TColor; fnt: TFont);
begin
   TreeView1.Color:=bkgColor;
   TreeView1.Font:=fnt;

   Edit1.Color:=bkgColor;
   Edit1.Font:=fnt;

   Memo1.Color:=bkgColor;
   Memo1.Font:=fnt;

end;

end.

