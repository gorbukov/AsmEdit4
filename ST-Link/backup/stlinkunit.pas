unit STLinkUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8, LazFileUtils, FileUtil, Process, Forms,
  Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  FormValueInitUnit,
  ProjectUnit,
  STLinkConfUnit;

type

  { TSTLink }

  TSTLink=class(TObject)
    private
       STLinkConfForm: TSTLinkConfForm;
    public
       constructor Create;
       destructor  Free;

       procedure   Config;

       procedure   MCUWrite(filename:string);  // прошивка микроконтроллера
  end;

implementation

uses MainUnit;

{ TSTLink }

constructor TSTLink.Create;
begin
  STLinkConfForm:= TSTLinkConfForm.Create(MainForm);
  LoadFormValues(STLinkConfForm, 'ST-LINK', app_conf_name);
  if STLinkConfForm.STLinkEdit.Text='' then
    STLinkConfForm.STLinkEdit.Text:='C:\Program Files (x86)\STMicroelectronics\STM32 ST-LINK Utility\ST-LINK Utility\ST-LINK_CLI.exe';
end;

destructor TSTLink.Free;
begin
  SaveFormValues(STLinkConfForm, 'ST-LINK', app_conf_name);
  STLinkConfForm.Free;
end;

procedure TSTLink.Config;
begin
   if STLinkConfForm.ShowModal<>mrOk then
     LoadFormValues(STLinkConfForm, 'ST-LINK', app_conf_name);
end;

// прошивка микроконтроллера
procedure TSTLink.MCUWrite(filename: string);
var
  Proc:TProcess;
  OutputStream : TStream;
  BytesRead    : longint;
  Buffer       : array[1..2048] of byte;
  str:string;
begin
  if not MainForm.Menu_View_GNU.Checked then MainForm.Menu_View_GNUClick(nil);

  MainForm.MessagesListBox.Items.Clear;
  MainForm.MessagesListBox.Items.Add('Запуск ST-Link');
  str:=STLinkConfForm.STLinkEdit.Text+' -c ';

  // способ подключения
  if STLinkConfForm.ConnectTypeCheckBox.Checked then
    begin
      if STLinkConfForm.SWDRadioButton.Checked then str:=str+'SWD '
        else str:=str+'JTAG '
    end;
  str:=str+'-p '+filename+' '+Project.Project_MCU_TargetAdr+' -Q';

  MainForm.ProcessMess;

  Proc:=TProcess.Create(MainForm);
  Proc.Executable:=STLinkConfForm.STLinkEdit.Text;
  Proc.Parameters.Add('-c');

  // способ подключения
  if STLinkConfForm.ConnectTypeCheckBox.Checked then
    begin
      if STLinkConfForm.SWDRadioButton.Checked then Proc.Parameters.Add('SWD')
        else Proc.Parameters.Add('JTAG')
    end;

  Proc.Parameters.Add('-p');
  Proc.Parameters.Add(filename);
  Proc.Parameters.Add(Project.Project_MCU_TargetAdr);
  Proc.Parameters.Add('-Q');

  Proc.Options :=[poUsePipes, poStdErrToOutput];
  proc.ShowWindow:=swoHide;
  Proc.Execute;

  // получаем результат работы компилятора в поток
  OutputStream := TMemoryStream.Create;
  repeat
    BytesRead := Proc.Output.Read(Buffer{%H-}, 2048);
    OutputStream.Write(Buffer, BytesRead);
  until BytesRead = 0;

  Proc.Free;

  // читаем сообщения компилятора
  OutputStream.Position := 0;
  MainForm.MessagesListBox.Items.loadFromStream(OutputStream);
  MainForm.MessagesListBox.Items.Insert(0,'Строка запуска:');
  MainForm.MessagesListBox.Items.Insert(1,str);
  MainForm.MessagesListBox.Items.Insert(2,'');
end;

end.

