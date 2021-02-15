unit AddScriptComUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TAddScriptComForm }

  TAddScriptComForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    NameToClipBrdCheckBox: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
  private

  public
     ResultList:TStringList;
  end;



implementation

{$R *.lfm}

{ TAddScriptComForm }

procedure TAddScriptComForm.Button1Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TAddScriptComForm.Button2Click(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TAddScriptComForm.Edit1Change(Sender: TObject);
begin
  ListBox1SelectionChange(Sender, true);
end;

procedure TAddScriptComForm.FormCreate(Sender: TObject);
begin
   ResultList:=TStringList.Create;
   Memo1.Lines.Clear;
end;

procedure TAddScriptComForm.FormDestroy(Sender: TObject);
begin
   ResultList.Free;
end;

procedure TAddScriptComForm.ListBox1SelectionChange(Sender: TObject;
  User: boolean);
begin
  Memo1.Lines.Clear;
  if ListBox1.ItemIndex=-1 then exit;

  case ListBox1.Items.Strings[ListBox1.ItemIndex] of

    'DIR_MAKE'      : begin
      Memo1.Lines.Add('Создание директории в папке исходников (src) проекта');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('Параметры:');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('file    - Относительный путь создаваемого каталога (от /src проекта)');
      ResultList.Clear;
      ResultList.Add(Edit1.Text);
      ResultList.Add('['+Edit1.Text+']');
      ResultList.Add('oper=DIR_MAKE');
      ResultList.Add('file=относительный путь к создаваемой папке от /src');
    end;

    'FILE_PRESENT'  : begin
      Memo1.Lines.Add('Проверка наличия файла в проекте');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('Параметры:');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('file    - [Строка] Относительный путь к файлу (от /src проекта)');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('accept  - [ 1, 0 ]   Ожидаемый результат: 1 - файл существует, 0 - файл не найден');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('warning - [Строка] Выдача предупреждения при получении результата равного ожидаемому');
      ResultList.Clear;
      ResultList.Add(Edit1.Text);
      ResultList.Add('['+Edit1.Text+']');
      ResultList.Add('oper=FILE_PRESENT');
      ResultList.Add('file=относительный путь к проверяемому файлу');
      ResultList.Add('accept=1');
      ResultList.Add('warning=Текст выдаваемого предупреждения при успехе проверки');
    end;

    'FILE_COPY'     : begin
      Memo1.Lines.Add('Копирование файла в проект с заранее заданным положением');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('Параметры:');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('file1    - [Строка] Относительный путь и имя исходного файла (от папки приложения, как правило начиная с папки /inf) который будет скопирован');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('file2    - [Строка] Относительный путь и имя конечного файла (от папки/src проекта)');
      ResultList.Clear;
      ResultList.Add(Edit1.Text);
      ResultList.Add('['+Edit1.Text+']');
      ResultList.Add('oper=FILE_COPY');
      ResultList.Add('file1=относительный путь к файлу источнику');
      ResultList.Add('file2=относительный путь к файлу получателю');
    end;

    'FILE_COPY_ASK' : begin
      Memo1.Lines.Add('Копирование файла в проект с запросом положения и имени у пользователя');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('Параметры:');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('file1    - [Строка] Относительный путь и имя исходного файла (от папки приложения, как правило начиная с папки /inf) который будет скопирован');
      ResultList.Clear;
      ResultList.Add(Edit1.Text);
      ResultList.Add('['+Edit1.Text+']');
      ResultList.Add('oper=FILE_COPY_ASK');
      ResultList.Add('file1=относительный путь к файлу источнику');
    end;

    'MOD_WRITE'     : begin
      Memo1.Lines.Add('Регистрация модуля в проекте');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('Параметров нет');
      ResultList.Clear;
      ResultList.Add(Edit1.Text);
      ResultList.Add('['+Edit1.Text+']');
      ResultList.Add('oper=MOD_WRITE');
    end;

    'MOD_INSTALL'   : begin
      Memo1.Lines.Add('Установка другого модуля');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('Параметры:');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('file    - [Строка] Относительный путь и имя файла скрипта модуля (от папки приложения, начиная с папки /inf)');
      Memo1.Lines.Add('');
      Memo1.Lines.Add('script  - [Строка] Имя Actions для исполнения');
      ResultList.Clear;
      ResultList.Add(Edit1.Text);
      ResultList.Add('['+Edit1.Text+']');
      ResultList.Add('oper=MOD_INSTALL');
      ResultList.Add('file=относительный путь к файлу скрипта');
      ResultList.Add('script=ADD');
    end;

  end;
end;

end.

