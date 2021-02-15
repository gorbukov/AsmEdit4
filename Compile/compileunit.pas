unit CompileUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazUTF8, LazFileUtils, FileUtil, Process;

//компиляция файла
// asExe:string;      файл компилятора для запуска
// sourceFile:string; исходный файл
// outFile:string;    результирующий файл
// incPath:string;    путь для include
// outResultList:TStringList; результат
procedure CompileAsmFile(asExe:string;
                         sourceFile:string; outFile:string; incPath:string;
                         outResultList:TStringList);

procedure DumpInfoFileD(objdumpExe: string; objFile: string; outResultList: TStringList);
procedure DumpInfoFileS(objdumpExe: string; objFile: string; outResultList: TStringList);

procedure LinkFiles(ldExe: string; ldFile: string; elfFile:string; objFiles:TStringList;
  outResultList: TStringList);

procedure SymbolNamesFile(nmExe: string; elfFile: string; outResultList: TStringList);

procedure ElfToBinFile(nmExe: string; elfFile: string; binFile: string;
  outResultList: TStringList);
procedure ElfToHexFile(nmExe: string; elfFile: string; hexFile: string;
  outResultList: TStringList);

implementation

uses MainUnit;

procedure CompileAsmFile(asExe: string; sourceFile: string; outFile: string;
  incPath: string; outResultList: TStringList);
var
  Proc:TProcess;
  OutputStream : TStream;
  BytesRead    : longint;
  Buffer       : array[1..2048] of byte;

begin
  Proc:=TProcess.Create(MainForm);
  Proc.Executable:=asExe;
  Proc.Parameters.Add('-o');
  Proc.Parameters.Add(outFile);
  Proc.Parameters.Add('-I');
  Proc.Parameters.Add(incPath);
  Proc.Parameters.Add(sourceFile);
  Proc.CurrentDirectory:=incPath;
  Proc.Options :=[poUsePipes, poStdErrToOutput];
  proc.ShowWindow:=swoHide;
  Proc.Execute;

  // получаем результат работы компилятора в поток
  OutputStream := TMemoryStream.Create;
  repeat
    BytesRead := Proc.Output.Read(Buffer{%H-}, 2048);
    OutputStream.Write(Buffer, BytesRead)
  until BytesRead = 0;

  Proc.Free;

  // читаем сообщения компилятора
  OutputStream.Position := 0;
  outResultList.LoadFromStream(OutputStream);
end;

procedure DumpInfoFileD(objdumpExe: string; objFile: string;
  outResultList: TStringList);
var
  Proc:TProcess;
  OutputStream : TStream;
  BytesRead    : longint;
  Buffer       : array[1..2048] of byte;

begin
  Proc:=TProcess.Create(MainForm);
  Proc.Executable:=objdumpExe;
  Proc.Parameters.Add('-D');
  Proc.Parameters.Add(objFile);
  Proc.Options :=[poUsePipes, poStdErrToOutput];
  proc.ShowWindow:=swoHide;
  Proc.Execute;

  // получаем результат работы компилятора в поток
  OutputStream := TMemoryStream.Create;
  repeat
    BytesRead := Proc.Output.Read(Buffer{%H-}, 2048);
    OutputStream.Write(Buffer, BytesRead)
  until BytesRead = 0;

  Proc.Free;

  // читаем сообщения компилятора
  OutputStream.Position := 0;
  outResultList.LoadFromStream(OutputStream);
end;

procedure DumpInfoFileS(objdumpExe: string; objFile: string;
  outResultList: TStringList);
var
  Proc:TProcess;
  OutputStream : TStream;
  BytesRead    : longint;
  Buffer       : array[1..2048] of byte;

begin
  Proc:=TProcess.Create(MainForm);
  Proc.Executable:=objdumpExe;
  Proc.Parameters.Add('-S');
  Proc.Parameters.Add(objFile);
  Proc.Options :=[poUsePipes, poStdErrToOutput];
  proc.ShowWindow:=swoHide;
  Proc.Execute;

  // получаем результат работы компилятора в поток
  OutputStream := TMemoryStream.Create;
  repeat
    BytesRead := Proc.Output.Read(Buffer{%H-}, 2048);
    OutputStream.Write(Buffer, BytesRead)
  until BytesRead = 0;

  Proc.Free;

  // читаем сообщения компилятора
  OutputStream.Position := 0;
  outResultList.LoadFromStream(OutputStream);
end;

procedure LinkFiles(ldExe: string; ldFile: string; elfFile:string; objFiles:TStringList;
  outResultList: TStringList);
var
  Proc:TProcess;
  OutputStream : TStream;
  BytesRead    : longint;
  Buffer       : array[1..2048] of byte;
  i:integer;
begin
  Proc:=TProcess.Create(MainForm);
  Proc.Executable:=ldExe;
  Proc.Parameters.Add('-T');
  Proc.Parameters.Add(ldFile);
  Proc.Parameters.Add('-o');
  Proc.Parameters.Add(elfFile);

  for i:=0 to objFiles.Count-1 do  // добавим список файлов
    Proc.Parameters.Add(objFiles.Strings[i]);

  Proc.Options :=[poUsePipes, poStdErrToOutput];
  proc.ShowWindow:=swoHide;
  Proc.Execute;

  // получаем результат работы компилятора в поток
  OutputStream := TMemoryStream.Create;
  repeat
    BytesRead := Proc.Output.Read(Buffer{%H-}, 2048);
    OutputStream.Write(Buffer, BytesRead)
  until BytesRead = 0;

  Proc.Free;

  // читаем сообщения компилятора
  OutputStream.Position := 0;
  outResultList.LoadFromStream(OutputStream);
end;

procedure SymbolNamesFile(nmExe: string; elfFile: string;
  outResultList: TStringList);
var
  Proc:TProcess;
  OutputStream : TStream;
  BytesRead    : longint;
  Buffer       : array[1..2048] of byte;

begin
  Proc:=TProcess.Create(MainForm);
  Proc.Executable:=nmExe;
  Proc.Parameters.Add('-A');
  Proc.Parameters.Add('-p');
  Proc.Parameters.Add(elfFile);
  Proc.Options :=[poUsePipes, poStdErrToOutput];
  proc.ShowWindow:=swoHide;
  Proc.Execute;

  // получаем результат работы компилятора в поток
  OutputStream := TMemoryStream.Create;
  repeat
    BytesRead := Proc.Output.Read(Buffer{%H-}, 2048);
    OutputStream.Write(Buffer, BytesRead)
  until BytesRead = 0;

  Proc.Free;

  // читаем сообщения компилятора
  OutputStream.Position := 0;
  outResultList.LoadFromStream(OutputStream);
end;

procedure ElfToBinFile(nmExe: string; elfFile: string; binFile: string;
  outResultList: TStringList);
var
  Proc:TProcess;
  OutputStream : TStream;
  BytesRead    : longint;
  Buffer       : array[1..2048] of byte;

begin
  Proc:=TProcess.Create(MainForm);
  Proc.Executable:=nmExe;
  Proc.Parameters.Add('-O');
  Proc.Parameters.Add('binary');
  Proc.Parameters.Add(elfFile);
  Proc.Parameters.Add(binFile);
  Proc.Options :=[poUsePipes, poStdErrToOutput];
  proc.ShowWindow:=swoHide;
  Proc.Execute;

  // получаем результат работы компилятора в поток
  OutputStream := TMemoryStream.Create;
  repeat
    BytesRead := Proc.Output.Read(Buffer{%H-}, 2048);
    OutputStream.Write(Buffer, BytesRead)
  until BytesRead = 0;

  Proc.Free;

  // читаем сообщения компилятора
  OutputStream.Position := 0;
  outResultList.LoadFromStream(OutputStream);
end;

procedure ElfToHexFile(nmExe: string; elfFile: string; hexFile: string;
  outResultList: TStringList);
var
  Proc:TProcess;
  OutputStream : TStream;
  BytesRead    : longint;
  Buffer       : array[1..2048] of byte;

begin
  Proc:=TProcess.Create(MainForm);
  Proc.Executable:=nmExe;
  Proc.Parameters.Add('-O');
  Proc.Parameters.Add('ihex');
  Proc.Parameters.Add(elfFile);
  Proc.Parameters.Add(hexFile);
  Proc.Options :=[poUsePipes, poStdErrToOutput];
  proc.ShowWindow:=swoHide;
  Proc.Execute;

  // получаем результат работы компилятора в поток
  OutputStream := TMemoryStream.Create;
  repeat
    BytesRead := Proc.Output.Read(Buffer{%H-}, 2048);
    OutputStream.Write(Buffer, BytesRead)
  until BytesRead = 0;

  Proc.Free;

  // читаем сообщения компилятора
  OutputStream.Position := 0;
  outResultList.LoadFromStream(OutputStream);
end;
end.

