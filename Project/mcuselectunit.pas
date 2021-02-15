unit MCUSelectUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, StdCtrls,
  IniFiles, LazUTF8;

type

  TMCU=class(TObject)
    fname:string;
    doc:string;
    syntax:string;
    cpu:string;
    thumb:string;
    fpu:string;
    openocd:string;
    deviceinfo:string;
    targetAdr:string;
  end;

  { TMCUSelectForm }

  TMCUSelectForm = class(TForm)
    ButtonOk: TButton;
    Button2: TButton;
    ImageList1: TImageList;
    TreeView1: TTreeView;
    procedure Button2Click(Sender: TObject);
    procedure ButtonOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure AddNewNode(iname: string; node: TTreeNode);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);

  private
    inif:TIniFile;
  public
    mcuname:string;
    mcufile:string;
    doc:string;
    syntax:string;
    cpu:string;
    thumb:string;
    fpu:string;
    openocd:string;
    deviceinfo:string;
    targetAdr:string;
  end;



implementation

uses MainUnit;

{$R *.lfm}

{ TMCUSelectForm }

procedure TMCUSelectForm.FormCreate(Sender: TObject);
var
  node: TTreeNode;
begin
  inif:=TIniFile.Create(app_path+'inf\mculist.ini');

  // построение дерева
  node:=TreeView1.Items.AddChildObject(nil, 'MCU', nil);
  node.ImageIndex:=0;
  node.SelectedIndex:=0;
  AddNewNode('root', node);
  node.Expand(false);
end;

procedure TMCUSelectForm.ButtonOkClick(Sender: TObject);
begin
  if mcuname<>'' then ModalResult:=mrOk;
end;

procedure TMCUSelectForm.Button2Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TMCUSelectForm.FormDestroy(Sender: TObject);
begin
  inif.Free;
end;

procedure TMCUSelectForm.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  if Node.Data<>nil then
    begin
       mcufile:=TMCU(Node.Data).fname;
       mcuname:=Node.Text;
       doc:=TMCU(Node.Data).doc;
       syntax:=TMCU(Node.Data).syntax;
       cpu:=TMCU(Node.Data).cpu;
       thumb:=TMCU(Node.Data).thumb;
       fpu:=TMCU(Node.Data).fpu;
       openocd:=TMCU(Node.Data).openocd;
       deviceinfo:=TMCU(Node.Data).deviceinfo;
       targetAdr:=TMCU(Node.Data).targetAdr;
    end
  else
  begin
    mcufile:='';
    mcuname:='';
    doc:='';
    syntax:='';
    cpu:='';
    thumb:='';
    fpu:='';
    openocd:='';
    deviceinfo:='';
    targetAdr:='';
  end
end;



procedure TMCUSelectForm.AddNewNode(iname: string; node: TTreeNode);
var
  k:integer;
  lst:TStringList;
  child: TTreeNode;
  mcu:TMCU;
begin
  if inif.ReadString(iname, 'type', '')='' then
    begin // список подкатегорий
       lst:=TStringList.Create;
       inif.ReadSectionRaw(iname, lst);
         for k:=0 to lst.Count-1 do
           begin
             child:=TreeView1.Items.AddChildObject(node, lst.Strings[k], nil);
             child.ImageIndex:=0;
             child.SelectedIndex:=0;
             AddNewNode(lst.Strings[k], child);
           end;
    end
  else
    begin // mcu
      mcu:=TMCU.Create;
      mcu.fname:=utf8LowerCase(inif.ReadString(iname, 'file', ''));
      mcu.doc:=inif.ReadString(iname, 'doc', '');
      mcu.syntax:=inif.ReadString(iname, 'syntax', '');
      mcu.cpu:=inif.ReadString(iname, 'cpu', '');
      mcu.thumb:=inif.ReadString(iname, 'thumb', '');
      mcu.fpu:=inif.ReadString(iname, 'fpu', '');
      mcu.openocd:=utf8LowerCase(inif.ReadString(iname, 'openocd', ''));
      mcu.deviceinfo:=utf8LowerCase(inif.ReadString(iname, 'deviceinfo', ''));
      mcu.targetAdr:=inif.ReadString(iname, 'targetadr', '');

      node.Data:=mcu;
      node.ImageIndex:=1;
      child.SelectedIndex:=1;
    end;
end;

end.

