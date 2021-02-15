unit MainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ExtCtrls, IniFiles,
  ComCtrls, LCLType, StdCtrls, Buttons, Grids, ShellApi, FileUtil, Clipbrd,
  AboutUnit,
  GetStrUnit, // модуль ввода строки у пользователя
  CheckLst, LazUTF8, LazFileUtils, SelectCharSetUnit,  // модуль перекодировки текстовых файлов
  ConfigUnit, UniqueInstance,
  ProjectUnit, {GNUConfUnit, }
  EditorFilesUnit,
  EditorUnit,
  SetCharSetUnit,
  SymbListunit,
  TokensUnit,
  SourceTextUnit, { SourceLineUnit, }
  TextParserUnit, AsmTextParserUnit, SymbolsUnit,
  ModuleAddUnit, AddScriptComUnit,
  STLinkUnit,     // форма настройки программатора
  OpenOCDConfigUnit, // настройка openOCD
  DebugUnit,      // форма отладки при помощи openODC
  FormValueInitUnit,  // модуль чтения значений элементов формы из ini файла
  HistoryFilesUnit,
  InfoUnit,
  CodeFormatConfigUnit;

type

  { TMainForm }

  TMainForm = class(TForm)
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    FindDialog1: TFindDialog;
    ImageList2: TImageList;
    Label11: TLabel;
    MenuItem10: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    Menu_Import_Bin: TMenuItem;
    Menu_Import_Font: TMenuItem;
    Menu_Config_InsFileName: TMenuItem;
    Menu_Close: TMenuItem;
    Menu_Edit_AutoFormat: TMenuItem;
    Menu_Edit_SelectAll: TMenuItem;
    Menu_Help_EdDirs: TMenuItem;
    MenuItem23: TMenuItem;
    Menu_Help_HotKeys: TMenuItem;
    Menu_Edit_DebugInfo_Disable: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    N5: TMenuItem;
    Menu_RUN_OpenODC_Write: TMenuItem;
    Menu_Edit_AddPointByte: TMenuItem;
    Menu_Edit_AddPointHword: TMenuItem;
    Menu_Edit_AddPointWord: TMenuItem;
    Menu_Edit_DebugInfo_Enable: TMenuItem;
    Menu_Edit_AddDebugBlock: TMenuItem;
    MenuItem20: TMenuItem;
    Menu_View_FxShow: TMenuItem;
    Menu_RUN_Debug: TMenuItem;
    Menu_Config_CreateIniModule: TMenuItem;
    Menu_Config_AddScriptCom: TMenuItem;
    Menu_Edit_CodeFormat_Config: TMenuItem;
    Menu_CodeFormat: TMenuItem;
    Menu_Edit_Find: TMenuItem;
    Menu_Edit_FindReplace: TMenuItem;
    Menu_RUN_MCUWrite: TMenuItem;
    MenuItem14: TMenuItem;
    Menu_Config_selmcu: TMenuItem;
    Menu_Config_mculist: TMenuItem;
    N4: TMenuItem;
    Menu_View_GNU: TMenuItem;
    MenuItem12: TMenuItem;
    Menu_RUN_Clear: TMenuItem;
    Menu_RUN_Conf: TMenuItem;
    Menu_RUN_ASLD: TMenuItem;
    MessagesListBox: TListBox;
    MenuItem11: TMenuItem;
    Menu_View_DecFont: TMenuItem;
    Menu_View_IncFont: TMenuItem;
    Menu_Modules_List: TMenuItem;
    Menu_Module_ADD: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem9: TMenuItem;
    Menu_Help_AsmParseDoc: TMenuItem;
    N2: TMenuItem;
    Menu_Help_About: TMenuItem;
    FilePopupMenu: TPopupMenu;
    ProTreePopupMenu: TPopupMenu;
    ReplaceDialog1: TReplaceDialog;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton_File_New: TSpeedButton;
    SymbolItemList: TListBox;
    SearchEditClearButton: TButton;
    SymbolNoFilesButton: TButton;
    SymbolAllFilesButton: TButton;
    Label10: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MenuItem5: TMenuItem;
    Menu_Edit_Redo: TMenuItem;
    MenuItem8: TMenuItem;
    Menu_Edit_Undo: TMenuItem;
    Menu_View_ProjectPanel: TMenuItem;
    Menu_View_SymbolsPanel: TMenuItem;
    F5Button: TSpeedButton;
    F6Button: TSpeedButton;
    F1Button: TSpeedButton;
    F2Button: TSpeedButton;
    F3Button: TSpeedButton;
    F4Button: TSpeedButton;
    EditorPopupMenu: TPopupMenu;
    SymbValueEdit: TEdit;
    GlobalToggleBox: TToggleBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LocToggleBox: TToggleBox;
    SymbDescMemo: TMemo;
    MenuItem4: TMenuItem;
    Menu_File_Insert_Option: TMenuItem;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    SymbFileBox: TCheckListBox;
    SymbolsStringGrid: TStringGrid;
    Menu_Config_HighLight: TMenuItem;
    Menu_File_ReOpen: TMenuItem;
    Menu_File_CharSetReopen: TMenuItem;
    Menu_File_Set_CharSet: TMenuItem;
    N3: TMenuItem;
    Panel3: TPanel;
    ProMode: TComboBox;
    ImageList1: TImageList;
    Label1: TLabel;
    ListBox1: TListBox;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    Menu_Edit_CopyToClipBoard: TMenuItem;
    Menu_Edit_CutToClipBoard: TMenuItem;
    Menu_Edit_PasteFromClipBoard: TMenuItem;
    Menu_Config_Editor: TMenuItem;
    Menu_File_SaveAll: TMenuItem;
    Menu_Project_Close: TMenuItem;
    Menu_Project_Config: TMenuItem;
    N1: TMenuItem;
    MenuItem7: TMenuItem;
    Menu_Project_New: TMenuItem;
    Menu_Project_Open: TMenuItem;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    SaveDialog1: TSaveDialog;
    SpeedButton1: TSpeedButton;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    SymbSearchEdit: TEdit;
    SymbToggleBox: TToggleBox;
    TextImage: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    Menu_File_New: TMenuItem;
    Menu_File_Open: TMenuItem;
    Menu_File_Save: TMenuItem;
    Menu_File_SaveAs: TMenuItem;
    Menu_File_Close: TMenuItem;
    LeftPanel: TPanel;
    CenterPanel: TPanel;
    CenterBottomPanel: TPanel;
    CenterTopPanel: TPanel;
    CenterWorkPanel: TPanel;
    RightPanel: TPanel;
    RightSplitter: TSplitter;
    LeftSplitter: TSplitter;
    BottomSplitter: TSplitter;
    TopSplitter: TSplitter;
    TopPanel: TPanel;
    ProTree: TTreeView;
    UniqueInstance1: TUniqueInstance;
    ValToggleBox: TToggleBox;

    procedure ApplicationActivate(Sender: TObject);
    procedure CenterPanelResize(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    // события передаваемые в редактор
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormUTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);

    procedure Menu_CloseClick(Sender: TObject);
    procedure Menu_CodeFormatClick(Sender: TObject);
    procedure Menu_Config_InsFileNameClick(Sender: TObject);
    procedure Menu_Import_BinClick(Sender: TObject);
    procedure Menu_Import_FontClick(Sender: TObject);
    procedure Menu_RUN_FlashWrite(Sender: TObject);


    // внешний вид
    procedure setVisualParams;

    // меню ФАЙЛ
    procedure Menu_File_NewClick(Sender: TObject);
    procedure Menu_File_OpenClick(Sender: TObject);
    procedure Menu_File_SaveClick(Sender: TObject);
    procedure Menu_File_SaveAsClick(Sender: TObject);
    procedure Menu_File_SaveAllClick(Sender: TObject);
    procedure Menu_File_CloseClick(Sender: TObject);
    procedure Menu_File_ReOpenClick(Sender: TObject);
    procedure Menu_File_CharSetReopenClick(Sender: TObject);
    procedure Menu_File_Set_CharSetClick(Sender: TObject);
    procedure Menu_File_Insert_OptionClick(Sender: TObject);

    // меню ПРАВКА
    procedure Menu_Edit_RedoClick(Sender: TObject);
    procedure Menu_Edit_UndoClick(Sender: TObject);
    procedure Menu_Edit_CopyToClipBoardClick(Sender: TObject);
    procedure Menu_Edit_CutToClipBoardClick(Sender: TObject);
    procedure Menu_Edit_PasteFromClipBoardClick(Sender: TObject);
    procedure Menu_Edit_FindClick(Sender: TObject);
    procedure Menu_Edit_FindReplaceClick(Sender: TObject);
    procedure Menu_Edit_CodeFormat_ConfigClick(Sender: TObject);
    procedure Menu_Edit_AddDebugBlockClick(Sender: TObject);
    procedure Menu_Edit_AddPointByteClick(Sender: TObject);
    procedure Menu_Edit_AddPointHwordClick(Sender: TObject);
    procedure Menu_Edit_AddPointWordClick(Sender: TObject);
    procedure Menu_Edit_DebugInfo_EnableClick(Sender: TObject);
    procedure Menu_Edit_AutoFormatClick(Sender: TObject);
    procedure Menu_Edit_DebugInfo_DisableClick(Sender: TObject);
    procedure Menu_Edit_SelectAllClick(Sender: TObject);

    // меню ВИД
    procedure Menu_View_DecFontClick(Sender: TObject);
    procedure Menu_View_IncFontClick(Sender: TObject);
    procedure Menu_View_GNUClick(Sender: TObject);
    procedure Menu_View_FxShowClick(Sender: TObject);

    // Меню ПРОЕКТ
    procedure Menu_Project_NewClick(Sender: TObject);
    procedure Menu_Project_OpenClick(Sender: TObject);
    procedure Menu_Project_CloseClick(Sender: TObject);
    procedure Menu_Project_ConfigClick(Sender: TObject);

    // меню ЗАПУСК
    procedure Menu_RUN_ASLDClick(Sender: TObject);
    procedure Menu_RUN_ConfASClick(Sender: TObject);
    procedure Menu_RUN_ClearClick(Sender: TObject);
    procedure Menu_RUN_STLinkWriteClick(Sender: TObject);
    procedure Menu_RUN_OpenODC_WriteClick(Sender: TObject);
    procedure Menu_RUN_STLinkConfClick(Sender: TObject);
    procedure Menu_RUN_OpenODC_ConfigClick(Sender: TObject);
    procedure Menu_RUN_DebugClick(Sender: TObject);

    // Меню МОДУЛИ
    procedure Menu_Module_ADDClick(Sender: TObject);
    procedure Menu_Modules_ListClick(Sender: TObject);

    // Меню НАСТРОЙКИ
    procedure Menu_Config_EditorClick(Sender: TObject);
    procedure Menu_Config_HighLightClick(Sender: TObject);
    procedure Menu_Config_AddScriptComClick(Sender: TObject);
    procedure Menu_Config_CreateIniModuleClick(Sender: TObject);
    procedure Menu_Config_mculistClick(Sender: TObject);
    procedure Menu_Config_selmcuClick(Sender: TObject);

    // Меню - СПРАВКА
    procedure Menu_Help_AboutClick(Sender: TObject);
    procedure Menu_Help_AsmParseDocClick(Sender: TObject);
    procedure Menu_Help_EdDirsClick(Sender: TObject);
    procedure Menu_Help_HotKeysClick(Sender: TObject);

    // Fx Buttons
    procedure F1ButtonClick(Sender: TObject);      // F1 - Описание символа
    procedure F2ButtonClick(Sender: TObject);      // F2 - Открыть файл
    procedure F3ButtonClick(Sender: TObject);
    procedure F4ButtonClick(Sender: TObject);
    procedure F5ButtonClick(Sender: TObject);
    procedure F6ButtonClick(Sender: TObject);

    // служебные процедуры
    procedure CenterWorkPanelResize(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Menu_View_ProjectPanelClick(Sender: TObject);
    procedure Menu_View_SymbolsPanelClick(Sender: TObject);
    procedure Panel5Resize(Sender: TObject);
    procedure ProModeClick(Sender: TObject);
    procedure ProTreeClick(Sender: TObject);
    procedure SymbFileBoxSelectionChange(Sender: TObject; {%H-}User: boolean);
    procedure SymbolAllFilesButtonClick(Sender: TObject);
    procedure SymbolNoFilesButtonClick(Sender: TObject);
    procedure SymbolsStringGridClick(Sender: TObject);
    procedure SymbolsStringGridDblClick(Sender: TObject);
    procedure SymbolsStringGridSelectCell(Sender: TObject; {%H-}aCol, aRow: Integer;
      var {%H-}CanSelect: Boolean);
    procedure SymbSearchEditChange(Sender: TObject);
    procedure SymbSearchEditClick(Sender: TObject);
    procedure SearchEditClearButtonClick(Sender: TObject);
    procedure SymbFileBoxClick(Sender: TObject);
    procedure SymbFileBoxDblClick(Sender: TObject);

    procedure CategorySymbolToggleBoxChange(Sender: TObject);
    procedure TextImageClick(Sender: TObject);
    procedure UniqueInstance1OtherInstance(Sender: TObject;
      ParamCount: Integer; const Parameters: array of String);

    // контекстное меню файла compile\sys.sasm
    procedure SetBreakPoint(Sender: TObject);        // точка останова
    procedure SetDebugAccess(Sender: TObject);       // точка доступа
    procedure SetDebugRun(Sender: TObject);          // режим RUN
    procedure SetDebugRunStep(Sender: TObject);      // режим RUN STEP
    procedure SetDebugStep(Sender: TObject);         // режим STEP
    procedure SetDebugClear(Sender: TObject);        // очистить

    // контекстное меню списка открытых в редакторе файлов
    procedure FilePopupMenuPopup(Sender: TObject);   // построитель меню
    procedure FileListCopyToBrd(Sender: TObject);    // скопировать имя файла в буфер обмена
    procedure FileListOpenInShell(Sender: TObject);  // открыть расположение файла в shell
    procedure FileListClose(Sender: TObject);        // закрыть

    // контекстное меню дерева файлов проекта
    procedure ProTreePopupMenuPopup(Sender: TObject); // построитель всплывающего меню дерева файлов проекта
        // операции с файлами
    procedure ProTreeNewFile(Sender: TObject);        // создать файл в директории
    procedure ProTreeCopyToProject(Sender: TObject);  // копировать файл в проект
    procedure ProTreeOpenFile(Sender: TObject);       // открыть файл в редакторе
    procedure ProTreeRenameFile(Sender: TObject);     // переименовать/переместить файл
    procedure ProTreeCopyFile(Sender: TObject);       // копировать файл
    procedure ProTreeDeleteFile(Sender: TObject);     // удалить файл
    procedure ProTreeExcludeFile(Sender: TObject);    // исключить из компиляции
    procedure ProTreeIncludeFile(Sender: TObject);    // включить в компиляцию
    procedure ProTreeViesDASMFile(Sender: TObject);   // просмотр результата компиляции
    procedure ProTreeOpenInShell(Sender: TObject);    // открыть расположение файла в shell
    procedure ProTreeWriteMCUFile(Sender: TObject);   // прошить файл в микроконтроллер
              // операции с папками
    procedure ProTreeNewDirectory(Sender: TObject);   // создать подпапку
    procedure ProTreeRenameDirectory(Sender: TObject); // переименовать папку
    procedure ProTreeDeleteDirectory(Sender: TObject); // удалить папку

    procedure GoToSASMLabel(Sender:TObject);     // открыть метку из текущего файла в sasm
  private
    startProc:boolean;
    oldMessPanelHigh:integer;  // прежняя высота панели  сообщений компиляции

    procedure ApplicationDeactivate(Sender: TObject);
    procedure HiddenPanels;

    procedure ClearPanels; // очистка информационных панелей

    procedure SetMenuToAsmMode;
    procedure SetMenuToTextMode;

    procedure OpenFileParams;  // открытие файлов из командной строки


  public

    procedure StatusEditor;   // показ статуса редактора, обновление списка меток

    procedure SetMenuMode(ST:TSourceText); // режим меню в зависимости от типа файла

    function  GetFileLabels(filename:string):TSymbolList; // получение списка меток файла
    function  GetFullFromOfsFilename(filename, currfile: string): string; // получение полного имени файла из относительного

    procedure ConstructEditorPopUpMenu;  // построитель всплывающего меню редактора

    procedure ProcessMess;
  end;

  const
    // информация о версии редактора
    versionStr='версия 0.9.1 (для тестов)';
    versionApp='02.02.2021';

  var
  MainForm: TMainForm;

  CodeFormatConfigForm:TCodeFormatConfigForm;

  Config:TConfig;          // конфигурация

  Project:TProject;        // проект

  STLink:TSTLink;          // интерфейс программатора

  OpenOCDConfigForm: TOpenOCDConfigForm; // настройки openODC
  DebugForm:TDebugForm;    // отладчик openODC

  EditorFiles:TEditorFiles; // список редактируемых и открытых файлов

  Editor:TEditor;          // редактор

  HistoryFiles:THistoryFiles;

  app_path:string;         // путь к приложению
  app_conf_name:string;    // имя файла конфигурации приложения
  versionInf:string;       // дата файлов конфигурации
  infDesc:TStringList;     // изменения файлов конфигурации

  InputEditor:boolean;     // фокус ввода, если true - ввод в редактор

  selectedSymbol:TSymbol;  // выбранный символ

  CurrentParseFileName:string;  // имя файла в настоящий момент обрабатываемого парсерами

  tmpGlInt:integer;
implementation

uses AsmFuncUnit;

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
var
  inif:TIniFile;
begin
  MainForm.Caption:='Assembler Editor Plus, '+versionStr;
  tmpGlInt:=0;
  startProc:=false;
  selectedSymbol:=nil;
  oldMessPanelHigh:=120;
  CenterBottomPanel.Height:=0;

  app_path:=ExtractFilePath(Application.ExeName);

  // определим дату библиотек
  infDesc:=TStringList.Create;
  inif:=TIniFile.Create(app_path+'inf/inf.ini');
  versionInf:=inif.ReadString('INF', 'data', 'Error');
  inif.ReadSectionRaw(versionInf, infDesc);
  inif.Free;

  app_conf_name:=app_path+'asmedit.ini';

  CodeFormatConfigForm:=TCodeFormatConfigForm.Create(MainForm);
  LoadFormValues(CodeFormatConfigForm, 'CodeFormatConfig', app_conf_name); // читаем настройки

  EditorFiles:=TEditorFiles.Create(ListBox1); // список открытых в редакторе файлов
  Editor:=TEditor.Create(TextImage);

  Config:=TConfig.Create;                     // настройки приложения

  Menu_View_ProjectPanel.Checked:=Config.ProjectPanelShow;
  RightPanel.Visible:=Config.SymbolPanelShow;
  Menu_View_SymbolsPanel.Checked:=Config.SymbolPanelShow;
  LeftPanel.Visible:=Config.ProjectPanelShow;

  STLink:=TSTLink.Create;   // инициализация модуля ST-Link
  OpenOCDConfigForm:=TOpenOCDConfigForm.Create(MainForm);
  LoadFormValues(OpenOCDConfigForm, 'OpenODCConfig', app_conf_name); // читаем настройки отладчика

  DebugForm:=TDebugForm.Create(MainForm);  // инициализация модуля отладки openODC
  LoadFormValues(DebugForm, 'OpenODC', app_conf_name); // читаем настройки отладчика

  Project:=TProject.Create(ProTree, ProMode); // проект
  Project.OpenOldProject;

  Config.OpenOldSessionFiles;                 // откроем файлы из предыдущей сессии

  OpenFileParams; // откроем файлы из командной строки

  Application.OnActivate:=@ApplicationActivate;
  Application.OnDeactivate:=@ApplicationDeactivate;

  EditorFiles.UpdateSTSymbolInfo;  // обновим информацию о метках

  HistoryFiles:=THistoryFiles.Create;

  InputEditor:=true;

  setVisualParams;

  StatusEditor;

  startProc:=true;
end;

procedure TMainForm.ApplicationActivate(Sender: TObject);
begin
  MainForm.SetFocus;
  if  startProc then Project.Update;
end;



procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FreeAndNil(HistoryFiles);

  SaveFormValues(CodeFormatConfigForm, 'CodeFormatConfig', app_conf_name); // сохраним настройки
  CodeFormatConfigForm.Free;

  Project.Free;

  STLink.Free;

  SaveFormValues(OpenOCDConfigForm, 'OpenODCConfig', app_conf_name);
  OpenOCDConfigForm.Free;

  if DebugForm.serverWorked then DebugForm.StopServerButton.Click;
  SaveFormValues(DebugForm, 'OpenODC', app_conf_name); // сохранить настройки отладчика
  DebugForm.Free;

  Config.SaveSessionFiles;  // сохраним открытые файлы текущей сессии
  Config.Free;

  Editor.Free;
  EditorFiles.free;

end;

// обработка нажатий кнопок
procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  MainForm.Caption:=inttostr(Key);

  case Key of
    112: F1Button.Click;
    113: F2Button.Click;
    114: F3Button.Click;
    115: F4Button.Click;
    116: F5Button.Click;
    117: F6Button.Click;
  end;

  if not InputEditor then exit;

  CenterWorkPanel.SetFocus;
  Editor.EditorKeyUp(Key, Shift);
  StatusEditor;
end;

procedure TMainForm.FormUTF8KeyPress(Sender: TObject; var UTF8Key: TUTF8Char);
begin
  if not InputEditor then exit;

  CenterWorkPanel.SetFocus;
  Editor.KeyPress(UTF8Key);

  StatusEditor;
  UTF8Key:='';
end;

procedure TMainForm.Menu_CloseClick(Sender: TObject);
begin
  Close;
end;


// меню: ФАЙЛ - Новый файл
procedure TMainForm.Menu_File_NewClick(Sender: TObject);
var
  ST:TSourceText;
begin
  ST:=EditorFiles.New;            // создадим файл
  EditorFiles.OpenInEditor(ST);   // откроем его в редакторе

  StatusEditor;
  Project.Update;
end;

// меню: ФАЙЛ - Открыть файл
procedure TMainForm.Menu_File_OpenClick(Sender: TObject);
var
  ST:TSourceText;

begin
  OpenDialog1.FilterIndex:=1;
  OpenDialog1.Title:='Открыть файл';
  OpenDialog1.FileName:='';
  if Project.Project_Opened then OpenDialog1.InitialDir:=Project.SourcePath+'\';
  if not OpenDialog1.Execute then exit;


  if UTF8Pos('.AEP', UTF8UpperCase(ExtractFileName(OpenDialog1.FileName)))>0 then // открытие проекта
    begin
       Project.Open(OpenDialog1.FileName);
    end
  else
    begin
      ST:=EditorFiles.Open(OpenDialog1.FileName); // откроем файл
      EditorFiles.OpenInEditor(ST);      // зададим его редактирование  в редакторе
    end;
  StatusEditor;
end;

// меню: ФАЙЛ - Сохранить файл
procedure TMainForm.Menu_File_SaveClick(Sender: TObject);
var
  ST:TSourceText;
begin
  ST:=TSourceText(Editor.Source);
  if ST=nil then exit;

  ST.SaveFile;

  StatusEditor;
  Project.Update;
end;

// меню: ФАЙЛ - Сохранить как
procedure TMainForm.Menu_File_SaveAsClick(Sender: TObject);
var
  ST:TSourceText;
begin
  ST:=TSourceText(Editor.Source);
  if ST=nil then exit;

  SaveDialog1.Title:='Сохранить файл как ..';
  SaveDialog1.FilterIndex:=1;
  OpenDialog1.FileName:=ST.FileName;
  OpenDialog1.InitialDir:=ExtractFilePath(ST.FileName);

  if SaveDialog1.Execute then
    begin
      ST.FileName:=SaveDialog1.FileName;
      ST.FileNamed:=true;
      ST.SaveFile;
    end;

  StatusEditor;
  Project.Update;
end;

// меню ФАЙЛ - Сохранить все
procedure TMainForm.Menu_File_SaveAllClick(Sender: TObject);
var
  i:integer;
  ST:TSourceText;
begin
  for i:=0 to ListBox1.Count-1 do
    begin
      ST:=TSourceText(Listbox1.Items.Objects[i]);
      ST.SaveFile;
    end;

  StatusEditor;
  Project.Update;
end;



// меню: ФАЙЛ - Закрыть файл
procedure TMainForm.Menu_File_CloseClick(Sender: TObject);
var
  ST:TSourceText;
begin
  ClearPanels;

  ST:=TSourceText(Editor.Source);

  if ST=nil then  exit;

  Editor.SetSourceText(EditorFiles.Close(ST, true));

  Editor.Refresh;
  StatusEditor;
end;

// Меню ФАЙЛ - Перечитать (повторное открытие файла)
procedure TMainForm.Menu_File_ReOpenClick(Sender: TObject);
var
  ST:TSourceText;
  str:string;
begin
   ST:=TSourceText(Editor.Source);

  if ST=nil then exit;
  ST.OpenFile(ST.FileName);

  // если файл это .ld то проверяем секции исходников
  str:=UTF8UpperCase(ST.FileName);
  if (UTF8Length(str)=UTF8Pos('.LD', str, 1)+2) then
      EditorFiles.ReloadLDFile;

  Editor.Refresh;
  StatusEditor;
end;

// меню ФАЙЛ - Перечитать с запросом кодировки
procedure TMainForm.Menu_File_CharSetReopenClick(Sender: TObject);
var
  SelectCharSetForm:TSelectCharSetForm;
begin
  SelectCharSetForm:=TSelectCharSetForm.Create(MainForm);
  SelectCharSetForm.SetFile(Editor.SourceText.FileName);
  if SelectCharSetForm.ShowModal=mrOk then
    begin
      Editor.SourceText.CharSet:=SelectCharSetForm.ComboBox1.Text;
      Editor.SourceText.OpenFile(Editor.SourceText.FileName);
      Editor.Refresh;
    end;

  StatusEditor;
end;

// меню ФАЙЛ - Задать кодировку асм файла
procedure TMainForm.Menu_File_Set_CharSetClick(Sender: TObject);
var
  SetCharSetForm:TSetCharSetForm;
begin
  if Editor.SourceText=nil then exit;

  SetCharSetForm:=TSetCharSetForm.Create(MainForm);
  if SetCharSetForm.ShowModal=mrOk then
    begin
       SetSTCharSet(Editor.SourceText, SetCharSetForm.ComboBox1.Text);
       Editor.Refresh;
       StatusEditor;
    end;
  SetCharSetForm.Free;
end;

// меню ФАЙЛ - вставить в файл опции компиляции
procedure TMainForm.Menu_File_Insert_OptionClick(Sender: TObject);
begin
   if (Editor.SourceText=nil) or (not Project.Project_Opened) then exit;
   SetGNUOptions(Editor.SourceText, Project);
   Editor.Refresh;
   StatusEditor;
end;


// меню: ПРАВКА - Отмена
procedure TMainForm.Menu_Edit_UndoClick(Sender: TObject);
begin
  if (Editor.SourceText=nil) then exit;
  Editor.SourceText.Undo;
  Editor.Refresh;
  StatusEditor;
end;

// меню: ПРАВКА - Возврат
procedure TMainForm.Menu_Edit_RedoClick(Sender: TObject);
begin
  if (Editor.SourceText=nil) then exit;
  Editor.SourceText.Redo;
  Editor.Refresh;
  StatusEditor;
end;

// меню: ПРАВКА - Копировать
procedure TMainForm.Menu_Edit_CopyToClipBoardClick(Sender: TObject);
begin
  Editor.CopyToClipBoard;
end;

// меню: ПРАВКА - Вырезать
procedure TMainForm.Menu_Edit_CutToClipBoardClick(Sender: TObject);
begin
  Editor.CutToClipBoard;
end;

// меню: ПРАВКА - Вставить
procedure TMainForm.Menu_Edit_PasteFromClipBoardClick(Sender: TObject);
begin
  Editor.PasteFromClipBoard;
end;

// меню ПРАВКА - Поиск
procedure TMainForm.Menu_Edit_FindClick(Sender: TObject);
begin
  Editor.FindText;
end;

// меню ПРАВКА - Замена
procedure TMainForm.Menu_Edit_FindReplaceClick(Sender: TObject);
begin
  Editor.ReplaceText;
end;

// меню ПРАВКА - Отладка
procedure TMainForm.Menu_RUN_DebugClick(Sender: TObject);
var
  PointsAdr:TList;
begin
  if FileExists(Project.Out_Path+'\sys.sasm') then
    begin
      DebugForm.ST:=EditorFiles.Open(Project.Out_Path+'\sys.sasm');
       PointsAdr:=TList.Create;
       GetPointsInfo(PointsAdr);
    end;

  DebugForm.StartForm(PointsAdr);
//  DebugForm.MCUConfIni.Text:=Project.Project_MCU_OpenOCD;
//  Panel3.Visible:=false;
//  DebugForm.Parent:=RightPanel;
//  DebugForm.BorderStyle:=bsNone;
  DebugForm.Show;
end;

// меню ПРАВКА - Добавить блок отладочной информации
procedure TMainForm.Menu_Edit_AddDebugBlockClick(Sender: TObject);
begin
   if (Editor.SourceText=nil) then exit;
   SetDebugBlock(Editor.SourceText);
   Editor.Refresh;
   StatusEditor;
end;

// меню ПРАВКА - Включить генерацию отладочной информации файла
procedure TMainForm.Menu_Edit_DebugInfo_EnableClick(Sender: TObject);
begin
   if (Editor.SourceText=nil) then exit;
   SetOnFileDebugBlock(Editor.SourceText);
   Editor.Refresh;
   StatusEditor;
end;

// меню ПРАВКА - Выключить генерацию отладочной информации файла
procedure TMainForm.Menu_Edit_DebugInfo_DisableClick(Sender: TObject);
begin
   if (Editor.SourceText=nil) then exit;
   SetOffFileDebugBlock(Editor.SourceText);
   Editor.Refresh;
   StatusEditor;
end;

// меню ПРАВКА - выделить все
procedure TMainForm.Menu_Edit_SelectAllClick(Sender: TObject);
var
  i:word;
begin
  i:=65;
  if (Editor.SourceText=nil) then exit;
  Editor.EditorKeyUp(i, [ssCtrl]);
end;


// меню ПРАВКА - Добавить указатель .word
procedure TMainForm.Menu_Edit_AddPointWordClick(Sender: TObject);
begin
   if (Editor.SourceText=nil) then exit;
      SetDebugPointWord(Editor.SourceText, 'word');
      Editor.Refresh;
      StatusEditor;
end;

// меню ПРАВКА - Добавить указатель .hword
procedure TMainForm.Menu_Edit_AddPointHwordClick(Sender: TObject);
begin
  if (Editor.SourceText=nil) then exit;
      SetDebugPointWord(Editor.SourceText, 'hword');
      Editor.Refresh;
      StatusEditor;
end;

// меню ПРАВКА - Добавить указатель .byte
procedure TMainForm.Menu_Edit_AddPointByteClick(Sender: TObject);
begin
  if (Editor.SourceText=nil) then exit;
      SetDebugPointWord(Editor.SourceText, 'byte');
      Editor.Refresh;
      StatusEditor;
end;

// меню ПРАВКА - Форматирование строки
procedure TMainForm.Menu_CodeFormatClick(Sender: TObject);
var
  ST:TSourceText;
  i:integer;
  cy:integer;
  posx, toknum:integer;
begin
   ST:=TSourceText(Editor.SourceText);
   if ST=nil then exit;

   if not (ST.TextParser is TAsmTextParser) then
     begin
       Editor.Refresh;
       exit;
     end;

   ST.URList.AddItem; // точка отмены изменений

   cy:=ST.CursorY;
   if ST.TextSelect then
     begin
       for i:=ST.TextSelectSY to ST.TextSelectLY do
         begin
           ST.CursorY:=i;
           LineFormat(posx, toknum);
           if ST.CursorY=cy then //если строка курсора - поставим его в нужное место
             begin
               if toknum=-1 then ST.CursorX:=posx
               else ST.CursorX:=TToken(TTokenList(ST.GetLineTokens(cy)).GetToken(toknum)).startPos+posx;
             end;
         end;
     end
   else
     begin
       LineFormat(posx, toknum);
       if toknum=-1 then ST.CursorX:=posx
       else ST.CursorX:=TToken(TTokenList(ST.GetLineTokens(cy)).GetToken(toknum)).startPos+posx;
     end;
   ST.CursorY:=cy;

  Editor.Refresh;
  StatusEditor;
end;

// меню ПРАВКА - Включение автоформатирования
procedure TMainForm.Menu_Edit_AutoFormatClick(Sender: TObject);
begin
  if Menu_Edit_AutoFormat.Checked then Menu_Edit_AutoFormat.Checked:=false
  else Menu_Edit_AutoFormat.Checked:=true;
end;

// меню ПРАВКА - Настройка форматирования кода
procedure TMainForm.Menu_Edit_CodeFormat_ConfigClick(Sender: TObject);
begin
  CodeFormatConfigForm.ShowModal;
end;

// меню: ВИД - показ/сокрытие панели проекта
procedure TMainForm.Menu_View_ProjectPanelClick(Sender: TObject);
begin
  if Config.ProjectPanelShow then Config.ProjectPanelShow:=false
                             else Config.ProjectPanelShow:=true;
  LeftPanel.Visible:=Config.ProjectPanelShow;
  Menu_View_ProjectPanel.Checked:=Config.ProjectPanelShow;
end;

// меню: ВИД - показ/сокрытие панели символов
procedure TMainForm.Menu_View_SymbolsPanelClick(Sender: TObject);
begin
  if Config.SymbolPanelShow then Config.SymbolPanelShow:=false
                             else Config.SymbolPanelShow:=true;
  RightPanel.Visible:=Config.SymbolPanelShow;
  Menu_View_SymbolsPanel.Checked:=Config.SymbolPanelShow;
end;

// меню: ВИД - показ/сокрытие панели компилятора
procedure TMainForm.Menu_View_GNUClick(Sender: TObject);
var
  t:integer;
begin
  t:=CenterBottomPanel.Height;
  CenterBottomPanel.Height:=oldMessPanelHigh;
  oldMessPanelHigh:=t;

  if not Menu_View_GNU.Checked then  Menu_View_GNU.Checked:=true
                               else  Menu_View_GNU.Checked:=false;
end;

// меню: ВИД - показ/сокрытие панели Fx кнопок
procedure TMainForm.Menu_View_FxShowClick(Sender: TObject);
begin
   if CenterTopPanel.Visible then CenterTopPanel.Visible:=false
                             else CenterTopPanel.Visible:=true;

   Menu_View_FxShow.Checked:=CenterTopPanel.Visible;
   CenterPanelResize(Sender);
end;

// меню: ВИД - Уменьшить шрифт
procedure TMainForm.Menu_View_DecFontClick(Sender: TObject);
var
  key:word;
begin
  key:=109;
  Editor.EditorKeyUp(key, [ssCtrl]);
  setVisualParams;
  Editor.Refresh;
end;

// меню: ВИД - Увеличить шрифт
procedure TMainForm.Menu_View_IncFontClick(Sender: TObject);
var
  key:word;
begin
  key:=107;
  Editor.EditorKeyUp(key, [ssCtrl]);
  setVisualParams;
  Editor.Refresh;
end;


// меню: ПРОЕКТ - Новый
procedure TMainForm.Menu_Project_NewClick(Sender: TObject);
begin
  ClearPanels;

  SaveDialog1.FilterIndex:=2;
  SaveDialog1.Title:='Новый проект';
  if SaveDialog1.Execute then
    begin
       HistoryFiles.Clear;
       Project.New(SaveDialog1.FileName);
    end;
  StatusEditor;
end;

// меню: ПРОЕКТ - открыть проект
procedure TMainForm.Menu_Project_OpenClick(Sender: TObject);
begin
  ClearPanels;

  OpenDialog1.FilterIndex:=2;
  OpenDialog1.Title:='Открыть проект';
  if OpenDialog1.Execute then
    begin
       HistoryFiles.Clear;
       Project.Open(OpenDialog1.FileName);
    end;
  StatusEditor;
end;

// меню ПРОЕКТ - Закрыть
procedure TMainForm.Menu_Project_CloseClick(Sender: TObject);
begin
  ClearPanels;
  HistoryFiles.Clear;
  Project.Close;
  Editor.Refresh;
  StatusEditor;
end;

// меню ПРОЕКТ - Параметры проекта
procedure TMainForm.Menu_Project_ConfigClick(Sender: TObject);
begin
  Project.Config;
end;


// меню ЗАПУСК - Полная компиляция проекта
procedure TMainForm.Menu_RUN_ASLDClick(Sender: TObject);
var
  t:integer;
begin
  if not Project.Project_Opened then exit;

  if DebugForm.Showing then
    begin
       MessageDlg('Внимание!', 'Компиляция при открытом окне отладчика не возможна',mtWarning, [mbOk], '');
       exit;
    end;

 if not Menu_View_GNU.Checked then
    begin
      t:=CenterBottomPanel.Height;
      CenterBottomPanel.Height:=oldMessPanelHigh;
      oldMessPanelHigh:=t;
      Menu_View_GNU.Checked:=true;
    end;

  Project.FullCompile;
  Project.Update;
  Editor.Refresh;
end;

// меню ЗАПУСК - Очистить выходной каталог
procedure TMainForm.Menu_RUN_ClearClick(Sender: TObject);
var
  t:integer;
begin
  if not Project.Project_Opened then exit;

  Project.GNU_Clear_Path;

  if Menu_View_GNU.Checked then
    begin
      t:=CenterBottomPanel.Height;
      CenterBottomPanel.Height:=oldMessPanelHigh;
      oldMessPanelHigh:=t;
      Menu_View_GNU.Checked:=false;
    end;

  Project.Update;
  Editor.Refresh;
end;

// меню ЗАПУСК -  Конфигурация компилятора
procedure TMainForm.Menu_RUN_ConfASClick(Sender: TObject);
begin
  if not Project.Project_Opened then exit;

  Project.GNUConfForm.ShowModal;
  Project.Update;
  Editor.Refresh;
end;

// меню ЗАПУСК - Запись в микроконтроллер при помощи ST-Link
procedure TMainForm.Menu_RUN_STLinkWriteClick(Sender: TObject);
var
  str,filename:string;
begin


    if DebugForm.telnetConnected then
    begin
       MessageDlg('Внимание!', 'При запушенном процессе отладки запись прошивки не возможна', mtWarning, [mbOk], '');
       exit;
    end;


  filename:='';
  OpenDialog1.Title:='Укажите файл Intel Hex (*.hex) для записи в микроконтроллер';
  OpenDialog1.FileName:='';
  OpenDialog1.FilterIndex:=6;
  OpenDialog1.InitialDir:=Project.Out_Path+'\';

  str:=Project.Out_Path+'\sys.hex';
  if FileExists(str) then filename:=str
    else if OpenDialog1.Execute then filename:=OpenDialog1.FileName;

  if filename='' then exit;
  STLink.MCUWrite(filename);
end;

// запись в устройство в зависимости от настроек openOCD
procedure TMainForm.Menu_RUN_FlashWrite(Sender: TObject);
begin
   if OpenOCDConfigForm.UseOCDtoFlashWrite.Checked then
     Menu_RUN_OpenODC_WriteClick(Sender) // openOCD
   else
     Menu_RUN_STLinkWriteClick(Sender);  // ST-Link
end;

// меню ЗАПУСК - Запись в микроконтроллер при помощи OpenOCD
procedure TMainForm.Menu_RUN_OpenODC_WriteClick(Sender: TObject);
var
  str,filename:string;
  t:integer;
begin
    if DebugForm.telnetConnected then
    begin
       MessageDlg('Внимание!', 'При запушенном процессе отладки запись прошивки не возможна', mtWarning, [mbOk], '');
       exit;
    end;

  // покажем панель сообщений
   if not Menu_View_GNU.Checked then
     begin
       Menu_View_GNU.Checked:=true;
       t:=CenterBottomPanel.Height;
       CenterBottomPanel.Height:=oldMessPanelHigh;
       oldMessPanelHigh:=t;
     end;

  filename:='';
  OpenDialog1.Title:='Укажите файл Bin (*.bin) для записи в микроконтроллер';
  OpenDialog1.FileName:='';
  OpenDialog1.FilterIndex:=9;
  OpenDialog1.InitialDir:=Project.Out_Path+'\';

  str:=Project.Out_Path+'\sys.bin';
  if FileExists(str) then filename:=str
    else if OpenDialog1.Execute then filename:=OpenDialog1.FileName;

  if filename='' then exit;
  DebugForm.MCUProgramming(filename);
end;

// меню ЗАПУСК - Настройка ST-Link
procedure TMainForm.Menu_RUN_STLinkConfClick(Sender: TObject);
begin
  STLink.Config;
end;

// меню ЗАПУСК - Настройка OpenOCD
procedure TMainForm.Menu_RUN_OpenODC_ConfigClick(Sender: TObject);
begin
  OpenOCDConfigForm.Show;
end;

// меню: МОДУЛИ - Добавить модуль
procedure TMainForm.Menu_Module_ADDClick(Sender: TObject);
var
  MF:TModuleAddForm;
begin
  if not Project.Project_Opened then exit;

  MF:=TModuleAddForm.Create(MainForm);

  // установим шрифт и цвет элементов формы
  MF.setColorFont(Editor.EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color,
                  ProTree.Font);

  MF.ShowModal;

  Project.Update;
  EditorFiles.Update;
  Editor.Refresh;

end;

// меню: МОДУЛИ - Список модулей
procedure TMainForm.Menu_Modules_ListClick(Sender: TObject);
begin
  if not Project.Project_Opened then exit;

  Project.ModulesForm.ShowModal;

  Project.Update;
  Editor.Refresh;

end;

// меню ИМПОРТ - Импорт bin файла
procedure TMainForm.Menu_Import_BinClick(Sender: TObject);
begin
  if Editor.SourceText=nil then exit;
  ImportBin;

  Editor.Refresh;

end;

// меню ИМПОРТ - Импорт шрифта из LCD Font Creater
procedure TMainForm.Menu_Import_FontClick(Sender: TObject);
var
  cx, cy:integer;
begin
  if Editor.SourceText=nil then exit;
  cx:=Editor.SourceText.CursorX;
  cy:=Editor.SourceText.CursorY;
  ImportFontData;
  Editor.SourceText.CursorX:=cx;
  Editor.SourceText.CursorY:=cy;

  Editor.Refresh;
end;




// меню: НАСТРОЙКИ -Настройки редактора
procedure TMainForm.Menu_Config_EditorClick(Sender: TObject);
begin
  Editor.EditorConfigForm.ShowModal;
  setVisualParams;
  Editor.Refresh;
end;

// меню: НАСТРОЙКИ - Настройки подсветки
procedure TMainForm.Menu_Config_HighLightClick(Sender: TObject);
begin
  Editor.EditorConfigHLForm.ShowModal;
  Editor.Refresh;
end;

// меню: НАСТРОЙКИ - Файл списка микроконтроллеров
procedure TMainForm.Menu_Config_mculistClick(Sender: TObject);
var
  ST:TSourceText;
begin
//  if (Project.Project_Opened) and
//    (MessageDlg('Открытый проект!',
//               'При редактировании проекта данный файл не может быть открыт. Закрыть проект и открыть файл?',
//               mtWarning, [mbYes,mbNo],'')<>mrYes) then exit;
//  Project.Close;
//  HistoryFiles.Clear;
//  Config.Default_CharSet:='UTF8';

  ST:=EditorFiles.Open(app_path+'inf\mculist.ini');
  EditorFiles.OpenInEditor(ST);

  StatusEditor;
  EditorFiles.Update;
end;

// меню: НАСТРОЙКИ - Файл настройки микроконтроллера
procedure TMainForm.Menu_Config_selmcuClick(Sender: TObject);
var
  str:string;
  ST:TSourceText;
begin
  ST:=TSourceText(Editor.SourceText);
  if (ST=nil) or (ExtractFileExt(ST.FileName)<>'.ini') then exit;

  str:=ST.GetLineStr(ST.CursorY);

  if UTF8Pos('=', str, 1)=0 then exit; // не найдена строка значения

  str:=app_path+UTF8Copy(str, UTF8Pos('=', str, 1)+1, UTF8Length(str)-UTF8Pos('=', str, 1));

  if not FileExists(str) then exit;

  ST:=EditorFiles.Open(str);
  EditorFiles.OpenInEditor(ST);

  StatusEditor;
  EditorFiles.Update;
end;

// меню: НАСТРОЙКИ - Создать файл настройки микроконтроллера
procedure TMainForm.Menu_Config_CreateIniModuleClick(Sender: TObject);
var
  ST:TSourceText;
begin
  SaveDialog1.Title:='Задать имя создаваемого файла настройки модуля';
  SaveDialog1.FileName:='new_module.ini';
  SaveDialog1.InitialDir:=app_path+'inf\';
  SaveDialog1.FilterIndex:=6;
  if SaveDialog1.Execute then
    begin
      ST:=EditorFiles.Open(SaveDialog1.FileName);
      ST.CharSet:='UTF8';
      ST.Clear;
      EditorFiles.OpenInEditor(ST);

      ST.Add('[MODULE]');
      ST.Add('caption=Имя модуля');
      ST.Add('group=MCU');
      ST.Add('');
      ST.Add('[DESC]');
      ST.Add('Описание модуля');
      ST.Add('');
      ST.Add('[ACTIONS]');
      ST.Add('act0=Установить');
      ST.Add('link0=ADD');
      ST.Add('');
      ST.Add('[ADD]');
      ST.Add('step0=имя секции команды для исполнения');

      Editor.Refresh;
      StatusEditor;
      EditorFiles.Update;
    end;
end;

// меню: НАСТРОЙКИ - Добавить команду скрипта
procedure TMainForm.Menu_Config_AddScriptComClick(Sender: TObject);
var
  AddScriptComForm: TAddScriptComForm;
  i:integer;
  ST:TSourceText;
begin
  AddScriptComForm:=TAddScriptComForm.Create(MainForm);
  if AddScriptComForm.ShowModal=mrOk then
    begin
      // сохраним имя секции в буфер обмена
      if AddScriptComForm.NameToClipBrdCheckBox.Checked then
        Clipboard.SetTextBuf(PChar(AddScriptComForm.ResultList.Strings[0]));
      // вставляем текст блока команды
      ST:=Editor.SourceText;
      for i:=1 to AddScriptComForm.ResultList.Count-1 do
        begin
          ST.Ins(ST.CursorY, AddScriptComForm.ResultList.Strings[i]);
          ST.CursorY:=ST.CursorY+1;
        end;

      Editor.Refresh;
      StatusEditor;
    end;
  AddScriptComForm.Free;
end;

// меню НАСТРОЙКА - Вставить путь и имя файла
procedure TMainForm.Menu_Config_InsFileNameClick(Sender: TObject);
var
  ST:TSourceText;
  str:string;
begin
  ST:=Editor.SourceText;
  if ST=nil then exit;
  OpenDialog1.FilterIndex:=1;
  OpenDialog1.InitialDir:=app_path;
  OpenDialog1.Title:='Файл для вставки';
  if OpenDialog1.Execute then
    begin
      str:=ST.GetLineStr(ST.CursorY);
      while UTF8Length(str)<ST.CursorX+1 do str:=str+' ';
      UTF8Insert(OpenDialog1.FileName, str, ST.CursorX+1);
      ST.SetLineStr(ST.CursorY, str);

      Editor.Refresh;
      StatusEditor;
    end;
end;

// меню: СПРАВКА - О программе
procedure TMainForm.Menu_Help_AboutClick(Sender: TObject);
var
  AboutForm: TAboutForm;
begin
  AboutForm:=TAboutForm.Create(MainForm);
  AboutForm.ShowModal;
  AboutForm.Free;
end;

// меню: СПРАВКА - Горячие клавиши
procedure TMainForm.Menu_Help_HotKeysClick(Sender: TObject);
var
  InfoForm: TInfoForm;
begin
  InfoForm:=TInfoForm.Create(MainForm);
  InfoForm.Memo1.Lines.LoadFromFile(app_path+'inf\hotkeys.txt');
  InfoForm.Caption:='Горячие клавиши';
  InfoForm.ShowModal;
  InfoForm.Free;
end;

// меню: СПРАВКА - Директивы редактора
procedure TMainForm.Menu_Help_EdDirsClick(Sender: TObject);
var
  InfoForm: TInfoForm;
begin
  InfoForm:=TInfoForm.Create(MainForm);
  InfoForm.Memo1.Lines.LoadFromFile(app_path+'inf\eddir.txt');
  InfoForm.Caption:='Директивы редактора';
  InfoForm.ShowModal;
  InfoForm.Free;
end;


// меню: СПРАВКА - Документация asm parse
procedure TMainForm.Menu_Help_AsmParseDocClick(Sender: TObject);
begin
  ShellExecute(0,nil, PChar('cmd'), PChar('/c start '+app_path+'inf\asmparse.pdf'), nil, 0);
end;


// F1 - Описание символа
procedure TMainForm.F1ButtonClick(Sender: TObject);
var
  TextParser:TTextParser;
begin
  TextParser:=TTextParser(Editor.SourceText.TextParser);
  if (Editor.SourceText=nil) or (not (TextParser is TAsmTextParser)) then exit;

  DescTokenInfo(Editor.SourceText);
  Editor.Refresh;
  StatusEditor;
end;

// F2 - Открыть файл
procedure TMainForm.F2ButtonClick(Sender: TObject);
var
  TextParser:TTextParser;
begin
  TextParser:=TTextParser(Editor.SourceText.TextParser);
  if (Editor.SourceText=nil) or (not (TextParser is TAsmTextParser)) then exit;

  TokenFileOpen(Editor.SourceText);
  Editor.Refresh;
  StatusEditor;
end;

// F3 - Определение
procedure TMainForm.F3ButtonClick(Sender: TObject);
var
  TextParser:TTextParser;
begin
  TextParser:=TTextParser(Editor.SourceText.TextParser);
  if (Editor.SourceText=nil) or (not (TextParser is TAsmTextParser)) then exit;

  TokenDef(Editor.SourceText);
  Editor.Refresh;
  StatusEditor;
end;

// F4 - Изменить
procedure TMainForm.F4ButtonClick(Sender: TObject);
var
  TextParser:TTextParser;
begin
  TextParser:=TTextParser(Editor.SourceText.TextParser);
  if (Editor.SourceText=nil) or (not (TextParser is TAsmTextParser)) then exit;

  TokenEdit(Editor.SourceText);
  Editor.Refresh;
  StatusEditor;
end;

// F5 - показ символов
procedure TMainForm.F5ButtonClick(Sender: TObject);
var
  TextParser:TTextParser;
  SymbListForm: TSymbListForm;
  str:string;
  tok:TToken;
  pos:integer;
begin
  TextParser:=TTextParser(Editor.SourceText.TextParser);
  if (Editor.SourceText=nil) or (not (TextParser is TAsmTextParser)) then exit;

  tok:=GetCursorToken(Editor.SourceText, pos);
  if pos=-1 then str:=''
            else str:=tok.Text;

  SymbListForm:= TSymbListForm.Create(MainForm);

  SymbListForm.SymbolListSetStart(str);
  SymbListForm.SymbolListGlobalSet(Project.GlobalSymbols); // глобальные символы
  SymbListForm.SymbolListLocalSet(TAsmTextParser(TextParser).FullSymbolList); // локальные символы
  SymbListForm.SymbFilterList;
  SymbListForm.setVisualParams(Editor.EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color, ProTree.Font);

  str:=Editor.SourceText.GetLineStr(Editor.SourceText.CursorY);
  // покажем окно выбора символа
  if SymbListForm.ShowModal=mrOk then
    begin
      if SymbListForm.symbolName<>'' then
        begin
          Editor.SourceText.URList.AddItem;

          if pos=-1 then // вставим символ в позицию курсора
            begin
              while UTF8Length(str)<Editor.SourceText.CursorX+1 do str:=str+' ';
            end
          else           // вставим символ вместо уже введенного префикса
            begin
              Editor.SourceText.CursorX:=tok.startPos-1;
              UTF8Delete(str, tok.startPos, tok.tokLen);
            end;
          UTF8Insert(SymbListForm.symbolName, str, Editor.SourceText.CursorX+1);
          Editor.SourceText.CursorX:=Editor.SourceText.CursorX+UTF8Length(SymbListForm.symbolName);
          Editor.SourceText.SetLineStr(Editor.SourceText.CursorY, str);
        end;
    end;
  Editor.Refresh;
  SymbListForm.Free;
end;

// F6 - Назад по истории открытия файлов
procedure TMainForm.F6ButtonClick(Sender: TObject);
begin
  HistoryFiles.GetLast;
end;


// получение списка символов файла по имени
function TMainForm.GetFileLabels(filename: string): TSymbolList;
var
  ST:TSourceText;
begin
  Result:=nil;

  // получим текст
  ST:=TSourceText(EditorFiles.Open(filename));
  if (ST.TextParser is TAsmTextParser) then
    begin
      TAsmTextParser(ST.TextParser).ParseFileSymbols;
      Result:=TSymbolList(TAsmTextParser(ST.TextParser).FileSymbolList);
    end;
end;

// преобразование относительно пути файла проекта в абсолютный
function TMainForm.GetFullFromOfsFilename(filename, currfile: string): string;
var
  str:string;
begin
  str:=StringReplace(filename, '/', '\', [rfReplaceAll]);
  if UTF8Copy(str, 1, 1)='\' then str:=UTF8Copy(str, 2, UTF8Length(str)-1);

  if (Project.Project_Opened) then
    begin
      if str<>ExtractFileName(str) then
        begin
          if UTF8Pos(UTF8LowerCase(Project.Project_Path), UTF8LowerCase(str),1)=1 then
            Result:=str
          else Result:=Project.Project_Path+str
        end
         else Result:=ExtractFilePath(currfile)+str;
    end
  else
    if Editor.SourceText<>nil then Result:=ExtractFilePath(currfile)+str
    else Result:=str;

  Result:=StringReplace(Result, '\\', '\', [rfReplaceAll]);
  Result:=UTF8UpperCase(Result);
end;

// точка останова
procedure TMainForm.SetBreakPoint(Sender: TObject);
var
  ST:TSourceText;
  adr:string;
  fl,fc, cy:integer;
begin
  ST:=Editor.SourceText;

  fl:=ST.FirstLineVisible;
  fc:=ST.FirstCharVisible;
  cy:=ST.CursorY;

  adr:=ST.GetAdrFromLine(ST.CursorY);
  if (adr<>'') and (DebugForm.telnetConnected) then DebugForm.setBreakPoint(adr);

  ST.SetDebugStr(ST.CursorY, 'BreakPnt');

  //  else ShowMessage('Отладочный сервер не подключен');

  ST.FirstLineVisible:=fl;
  ST.FirstCharVisible:=fc;
  ST.CursorY:=cy;

  Editor.Refresh;
end;


procedure TMainForm.SetDebugAccess(Sender: TObject);
var
  ST:TSourceText;
begin
  ST:=Editor.SourceText;
  ST.SetDebugStr(ST.CursorY, 'ACCESS');
  Editor.Refresh;
end;

procedure TMainForm.SetDebugRun(Sender: TObject);
var
  ST:TSourceText;
begin
  ST:=Editor.SourceText;
  ST.SetDebugStr(ST.CursorY, 'RUN');
  Editor.Refresh;
end;

procedure TMainForm.SetDebugRunStep(Sender: TObject);
var
  ST:TSourceText;
begin
  ST:=Editor.SourceText;
  ST.SetDebugStr(ST.CursorY, 'RUNSTEP');
  Editor.Refresh;
end;

procedure TMainForm.SetDebugStep(Sender: TObject);
var
  ST:TSourceText;
begin
  ST:=Editor.SourceText;
  ST.SetDebugStr(ST.CursorY, 'STEP');
  Editor.Refresh;
end;

// очистить точки останова
procedure TMainForm.SetDebugClear(Sender: TObject);
var
  ST:TSourceText;
  adr:string;
  fl,fc,cy:integer;
begin
  ST:=Editor.SourceText;

  fl:=ST.FirstLineVisible;
  fc:=ST.FirstCharVisible;
  cy:=ST.CursorY;

  adr:=ST.GetAdrFromLine(ST.CursorY);
  if (adr<>'') then DebugForm.clrBreakPoint(adr);

  ST.SetDebugStr(ST.CursorY, '');

  ST.FirstLineVisible:=fl;
  ST.FirstCharVisible:=fc;
  ST.CursorY:=cy;

  Editor.Refresh;
end;

// построитель всплывающего меню редактора
procedure TMainForm.ConstructEditorPopUpMenu;
var
  TextParser:TTextParser;

  mni:TMenuItem;

  desc:TStringList;
  str:string;
  i:integer;
  delim:boolean;
  Tokens:TTokenList;
begin
  EditorPopupMenu.Items.Clear;

// меню sys.sasm
  str:=Project.Out_Path+'\sys.sasm';
  str:=UTF8LowerCase(Editor.SourceText.FileName);
  if UTF8LowerCase(Editor.SourceText.FileName)=Project.Out_Path+'\sys.sasm' then
    begin
      Tokens:=TTokenList(Editor.SourceText.GetLineTokens(Editor.SourceText.CursorY));
      if (Tokens<>nil) and
         (Tokens.Count>1) and
         (TToken(Tokens.GetToken(1)).Text=':'){ and
         (DebugForm.Visible)} then
        begin
          mni:=TMenuItem.Create(EditorPopupMenu);
          mni.Caption:='Точка останова';
          mni.OnClick:=@SetBreakPoint;
          EditorPopupMenu.Items.Add(mni);

          mni:=TMenuItem.Create(EditorPopupMenu);
          mni.Caption:='-';
          EditorPopupMenu.Items.Add(mni);

          mni:=TMenuItem.Create(EditorPopupMenu);
          mni.Caption:='Удалить';
          mni.OnClick:=@SetDebugClear;
          EditorPopupMenu.Items.Add(mni);

          EditorPopupMenu.PopUp;
        end;
      exit;
    end;

  TextParser:=TTextParser(Editor.SourceText.TextParser);

  if Editor.SourceText=nil then exit;

  delim:=false;

  // переход назад по истории
  if HistoryFiles.Count>0 then
    begin
      mni:=TMenuItem.Create(EditorPopupMenu);
      mni.Caption:='Назад в  '+HistoryFiles.ViewLastFile;
      mni.OnClick:=@F6ButtonClick;
      EditorPopupMenu.Items.Add(mni);

      mni:=TMenuItem.Create(EditorPopupMenu);
      mni.Caption:='-';
      EditorPopupMenu.Items.Add(mni);
    end;

  // описание символа
  desc:=TStringList.Create;
  GetDescTokenInfo(Editor.SourceText, desc);
  if (Editor.SourceText<>nil) and (TextParser is TAsmTextParser) and (desc.Count>1) then
    begin
       mni:=TMenuItem.Create(EditorPopupMenu);
       mni.Caption:='Описание: '+desc.Strings[0];
       mni.OnClick:=@F1ButtonClick;
       EditorPopupMenu.Items.Add(mni);
       delim:=true;
    end;
  desc.Free;

  // открыть файл
  if (Editor.SourceText<>nil) and (TextParser is TAsmTextParser) then
    str:=GetTokenFile(Editor.SourceText) else str:='';
  if (str<>'') then
    begin
       mni:=TMenuItem.Create(EditorPopupMenu);
       mni.Caption:='Открыть файл: '+str;
       mni.OnClick:=@F2ButtonClick;
       EditorPopupMenu.Items.Add(mni);
       delim:=true;
    end;

   // определение символа
  if (Editor.SourceText<>nil) and (TextParser is TAsmTextParser) and
     (TSymbol(TokenDefInfo(Editor.SourceText))<>nil) then
    begin
       mni:=TMenuItem.Create(EditorPopupMenu);
       mni.Caption:='Определение: '+TSymbol(TokenDefInfo(Editor.SourceText)).Name;
       mni.OnClick:=@F3ButtonClick;
       EditorPopupMenu.Items.Add(mni);
       delim:=true;
    end;

  // изменить символ
 if (Editor.SourceText<>nil) and (TextParser is TAsmTextParser) then
    begin
      getTokenItem(Editor.SourceText, i, str);
      if str<>'' then
        begin
          mni:=TMenuItem.Create(EditorPopupMenu);
          mni.Caption:='Изменить значение: '+str;
          mni.OnClick:=@F4ButtonClick;
          EditorPopupMenu.Items.Add(mni);
          delim:=true;
       end;
    end;

  if delim then
    begin
      mni:=TMenuItem.Create(EditorPopupMenu);
      mni.Caption:='-';
      EditorPopupMenu.Items.Add(mni);
    end;

  delim:=false;
  // символ в прошивке
 if (Editor.SourceText<>nil) and (TextParser is TAsmTextParser) then
    begin
      i:=getSTinSASMLabelLine(Editor.SourceText, str);
      if i<>-1 then
        begin
          mni:=TMenuItem.Create(EditorPopupMenu);
          mni.Caption:='Открыть в .sasm: '+str;
          mni.OnClick:=@GoToSASMLabel;
          EditorPopupMenu.Items.Add(mni);
          delim:=true;
       end;
    end;

 if delim then
   begin
     mni:=TMenuItem.Create(EditorPopupMenu);
     mni.Caption:='-';
     EditorPopupMenu.Items.Add(mni);
   end;

  // работа с буфером обмена
  if  Editor.SourceText.TextSelect then
    begin
      mni:=TMenuItem.Create(EditorPopupMenu);
      mni.Caption:='Копировать';
      mni.OnClick:=@Menu_Edit_CopyToClipBoardClick;
      EditorPopupMenu.Items.Add(mni);

      mni:=TMenuItem.Create(EditorPopupMenu);
      mni.Caption:='Вырезать';
      mni.OnClick:=@Menu_Edit_CutToClipBoardClick;
      EditorPopupMenu.Items.Add(mni);
    end;

      mni:=TMenuItem.Create(EditorPopupMenu);
      mni.Caption:='Вставить';
      mni.OnClick:=@Menu_Edit_PasteFromClipBoardClick;
      EditorPopupMenu.Items.Add(mni);

{      mni:=TMenuItem.Create(EditorPopupMenu);
      mni.Caption:='-';
      EditorPopupMenu.Items.Add(mni);
}
  EditorPopupMenu.PopUp;
end;

// открыть метку из текущего файла в sasm
procedure TMainForm.GoToSASMLabel(Sender: TObject);
var
  i:integer;
  str:string;
  ST:TSourceText;
begin
  HistoryFiles.AddHist(Editor.SourceText);

  i:=getSTinSASMLabelLine(Editor.SourceText, str);
  ST:=EditorFiles.Open(Project.Out_Path+'\sys.sasm');
  EditorFiles.OpenInEditor(ST);
  ST.TextSelect:=true;
  ST.TextSelectLY:=i; ST.TextSelectSY:=i;
  ST.TextSelectSX:=TToken(TTokenList(ST.GetLineTokens(i)).GetToken(2)).startPos-1;
  ST.TextSelectLX:=ST.TextSelectSX+TToken(TTokenList(ST.GetLineTokens(i)).GetToken(2)).tokLen;
  ST.CursorX:=ST.TextSelectLX;
  ST.CursorY:=i;
  ST.FirstCharVisible:=1;
  ST.FirstLineVisible:=ST.CursorY-10;
  if ST.FirstLineVisible<0 then ST.FirstLineVisible:=0;

  Editor.Refresh;
  StatusEditor;
end;


// конекстное меню списка открытых файлов редактора
procedure TMainForm.FilePopupMenuPopup(Sender: TObject);
var
//  str:string;
  mni:TMenuItem;

begin
  FilePopupMenu.Items.Clear;
   if ListBox1.ItemIndex=-1 then exit;

   mni:=TMenuItem.Create(FilePopupMenu);
   mni.Caption:='Перечитать';
   mni.OnClick:=@Menu_File_ReOpenClick;
   FilePopupMenu.Items.Add(mni);

   mni:=TMenuItem.Create(FilePopupMenu);
   mni.Caption:='-';
   FilePopupMenu.Items.Add(mni);

   mni:=TMenuItem.Create(FilePopupMenu);
   mni.Caption:='Скопировать имя файла в буфер обмена';
   mni.OnClick:=@FileListCopyToBrd;
   FilePopupMenu.Items.Add(mni);

   mni:=TMenuItem.Create(FilePopupMenu);
   mni.Caption:='Открыть папку расположения файла в shell';
   mni.OnClick:=@FileListOpenInShell;
   FilePopupMenu.Items.Add(mni);

   mni:=TMenuItem.Create(FilePopupMenu);
   mni.Caption:='-';
   FilePopupMenu.Items.Add(mni);

   mni:=TMenuItem.Create(FilePopupMenu);
   mni.Caption:='Закрыть файл';
   mni.OnClick:=@FileListClose;
   FilePopupMenu.Items.Add(mni);

end;

// скопировать имя файла в буфер обмена
procedure TMainForm.FileListCopyToBrd(Sender: TObject);
var
  ST:TSourceText;
begin
  ST:=TSourceText(ListBox1.Items.Objects[ListBox1.ItemIndex]);
  Clipboard.SetTextBuf(PChar(ST.FileName));
end;

// открыть расположение файла в shell
procedure TMainForm.FileListOpenInShell(Sender: TObject);
var
  ST:TSourceText;
begin
  ST:=TSourceText(ListBox1.Items.Objects[ListBox1.ItemIndex]);
  ShellExecuteW(0, nil, 'explorer.exe', PWideChar(UTF8Decode('/select,'+ST.FileName)), nil, SW_SHOWNORMAL);
end;

// закрыть  файл
procedure TMainForm.FileListClose(Sender: TObject);
var
  ST:TSourceText;
begin
  ST:=TSourceText(ListBox1.Items.Objects[ListBox1.ItemIndex]);
  Editor.SetSourceText(EditorFiles.Close(ST, true));
end;

// контекстное меню дерева файлов проекта
procedure TMainForm.ProTreePopupMenuPopup(Sender: TObject);
var
  str, newname:string;
  mni:TMenuItem;
begin
  ProTreePopupMenu.Items.Clear;

  if ProTree.Selected=nil then str:=''  // нет выделенного узла
  else str:=Project.GetProTreePath(ProTree.Selected);  // получим объект на котором был клик

  // выделенный узел - директория
  if DirPathExists(str) then
    begin
      mni:=TMenuItem.Create(ProTreePopupMenu);
      mni.Caption:='Создать файл';
      mni.OnClick:=@ProTreeNewFile;
      ProTreePopupMenu.Items.Add(mni);

      mni:=TMenuItem.Create(ProTreePopupMenu);
      mni.Caption:='Скопировать в проект';
      mni.OnClick:=@ProTreeCopyToProject;
      ProTreePopupMenu.Items.Add(mni);

      mni:=TMenuItem.Create(ProTreePopupMenu);
      mni.Caption:='-';
      ProTreePopupMenu.Items.Add(mni);

      mni:=TMenuItem.Create(ProTreePopupMenu);
      mni.Caption:='Создать директорию';
      mni.OnClick:=@ProTreeNewDirectory;
      ProTreePopupMenu.Items.Add(mni);

      mni:=TMenuItem.Create(ProTreePopupMenu);
      mni.Caption:='Переименовать директорию';
      mni.OnClick:=@ProTreeRenameDirectory;
      ProTreePopupMenu.Items.Add(mni);

      mni:=TMenuItem.Create(ProTreePopupMenu);
      mni.Caption:='Удалить директорию';
      mni.OnClick:=@ProTreeDeleteDirectory;
      ProTreePopupMenu.Items.Add(mni);

    end
  else
    begin
        if ExtractFileExt(str)='.aep' then
          begin
            mni:=TMenuItem.Create(ProTreePopupMenu);
            mni.Caption:='Открыть окно настроек проекта';
            mni.OnClick:=@Menu_Project_ConfigClick;
            ProTreePopupMenu.Items.Add(mni);

            mni:=TMenuItem.Create(ProTreePopupMenu);
            mni.Caption:='Компиляция проекта';
            mni.OnClick:=@Menu_RUN_ASLDClick;
            ProTreePopupMenu.Items.Add(mni);

            mni:=TMenuItem.Create(ProTreePopupMenu);
            mni.Caption:='-';
            ProTreePopupMenu.Items.Add(mni);

            mni:=TMenuItem.Create(ProTreePopupMenu);
            mni.Caption:='Добавить модуль';
            mni.OnClick:=@Menu_Module_ADDClick ;
            ProTreePopupMenu.Items.Add(mni);

            mni:=TMenuItem.Create(ProTreePopupMenu);
            mni.Caption:='Список модулей проекта';
            mni.OnClick:=@Menu_Modules_ListClick;
            ProTreePopupMenu.Items.Add(mni);

            mni:=TMenuItem.Create(ProTreePopupMenu);
            mni.Caption:='-';
            ProTreePopupMenu.Items.Add(mni);

            mni:=TMenuItem.Create(ProTreePopupMenu);
            mni.Caption:='Открыть как текст';
            mni.OnClick:=@ProTreeOpenFile;
            ProTreePopupMenu.Items.Add(mni);

            exit;
          end;

        mni:=TMenuItem.Create(ProTreePopupMenu);
        mni.Caption:='Открыть '+ExtractFileName(str);
        mni.OnClick:=@ProTreeOpenFile;
        ProTreePopupMenu.Items.Add(mni);

        mni:=TMenuItem.Create(ProTreePopupMenu);
        mni.Caption:='-';
        ProTreePopupMenu.Items.Add(mni);

        mni:=TMenuItem.Create(ProTreePopupMenu);
        mni.Caption:='Переименовать/Переместить';
        mni.OnClick:=@ProTreeRenameFile;
        ProTreePopupMenu.Items.Add(mni);

        mni:=TMenuItem.Create(ProTreePopupMenu);
        mni.Caption:='Копировать';
        mni.OnClick:=@ProTreeCopyFile;
        ProTreePopupMenu.Items.Add(mni);

        mni:=TMenuItem.Create(ProTreePopupMenu);
        mni.Caption:='Удалить';
        mni.OnClick:=@ProTreeDeleteFile;
        ProTreePopupMenu.Items.Add(mni);

      if ExtractFileExt(str)='.asm' then
        begin
          mni:=TMenuItem.Create(ProTreePopupMenu);
          mni.Caption:='-';
          ProTreePopupMenu.Items.Add(mni);

          // проверим есть ли результат компиляции для файла
          newname:=Project.Out_Path+'\internal'+
              UTF8Copy(str, UTF8Length(Project.SourcePath)+1,
              UTF8Length(str)-UTF8Length(Project.SourcePath));
          newname:=ExtractFileDir(newname)+'\'+ExtractFileNameOnly(newname)+'.dasm';
          if FileExists(newname) then
            begin
              mni:=TMenuItem.Create(ProTreePopupMenu);
              mni.Caption:='Открыть результат компиляции';
              mni.OnClick:=@ProTreeViesDASMFile;
              ProTreePopupMenu.Items.Add(mni);
            end;

          mni:=TMenuItem.Create(ProTreePopupMenu);
          mni.Caption:='Исключить из компиляции';
          mni.OnClick:=@ProTreeExcludeFile;
          ProTreePopupMenu.Items.Add(mni);
        end;

      if ExtractFileExt(str)='.-asm' then
         begin
          mni:=TMenuItem.Create(ProTreePopupMenu);
          mni.Caption:='-';
          ProTreePopupMenu.Items.Add(mni);

           mni:=TMenuItem.Create(ProTreePopupMenu);
           mni.Caption:='Включить в компиляцию';
           mni.OnClick:=@ProTreeIncludeFile;
           ProTreePopupMenu.Items.Add(mni);
         end;

      if ExtractFileExt(str)='.hex' then
         begin
          mni:=TMenuItem.Create(ProTreePopupMenu);
          mni.Caption:='-';
          ProTreePopupMenu.Items.Add(mni);

           mni:=TMenuItem.Create(ProTreePopupMenu);
           mni.Caption:='Записать в микроконтроллер при помощи ST-Link';
           mni.OnClick:=@ProTreeWriteMCUFile;
           ProTreePopupMenu.Items.Add(mni);
         end;

      mni:=TMenuItem.Create(ProTreePopupMenu);
      mni.Caption:='-';
      ProTreePopupMenu.Items.Add(mni);

      mni:=TMenuItem.Create(ProTreePopupMenu);
      mni.Caption:='Открыть папку расположения файла в shell';
      mni.OnClick:=@ProTreeOpenInShell;
      ProTreePopupMenu.Items.Add(mni);
    end;
end;

// создать файл в директории
procedure TMainForm.ProTreeNewFile(Sender: TObject);
var
  str:string;
  ST:TSourceText;

begin
  str:=Project.GetProTreePath(ProTree.Selected);
  SaveDialog1.Title:='Задайте имя создаваемого файла';
  SaveDialog1.InitialDir:=str+'\';
  SaveDialog1.FileName:='';
  if SaveDialog1.Execute then
    begin
        ST:=EditorFiles.Open(SaveDialog1.FileName);            // создадим файл
        ST.FileName:=SaveDialog1.FileName;
        ST.FileNamed:=true;
        ST.SaveFile;

        EditorFiles.OpenInEditor(ST);   // откроем его в редакторе

        StatusEditor;
        Project.Update;
    end;
end;
// копировать файл в проект
procedure TMainForm.ProTreeCopyToProject(Sender: TObject);
var
  str:string;
  ST:TSourceText;
begin
  OpenDialog1.Title:='Задайте новое имя и/или расположение файла';
  OpenDialog1.InitialDir:=ExtractFileDir(app_path);
  OpenDialog1.FileName:='';
  OpenDialog1.FilterIndex:=1;
  if OpenDialog1.Execute then
    begin
       str:=Project.GetProTreePath(ProTree.Selected);
       ST:=EditorFiles.Open(OpenDialog1.FileName);
       EditorFiles.OpenInEditor(ST);

       ST.FileName:=str+'\'+ExtractFileName(OpenDialog1.FileName);
       ST.SaveFile;
    end;

  StatusEditor;
  EditorFiles.Update;
  Project.Update;
end;

// открыть файл в редакторе
procedure TMainForm.ProTreeOpenFile(Sender: TObject);
var
  str:string;
  ST:TSourceText;
begin
  str:=Project.GetProTreePath(ProTree.Selected);
  ST:=EditorFiles.Open(str);

  EditorFiles.OpenInEditor(ST);

  StatusEditor;
  Project.Update;
end;

// переименовать/переместить файл
procedure TMainForm.ProTreeRenameFile(Sender: TObject);
var
  oldname:string;
  ST:TSourceText;

begin
  oldname:=Project.GetProTreePath(ProTree.Selected);
  ST:=EditorFiles.Open(oldname);

  SaveDialog1.Title:='Задайте новое имя и/или расположение файла';
  SaveDialog1.InitialDir:=ExtractFileDir(oldname);
  SaveDialog1.FileName:=ExtractFileName(oldname);
  if SaveDialog1.Execute then
    begin
      ST.FileName:=SaveDialog1.FileName;
      ST.SaveFile;
      DeleteFile(oldname);

      StatusEditor;
      Project.Update;
    end;
end;

// копировать файл
procedure TMainForm.ProTreeCopyFile(Sender: TObject);
var
  oldname:string;

begin
  oldname:=Project.GetProTreePath(ProTree.Selected);

  SaveDialog1.Title:='Задайте новое имя и/или расположение файла';
  SaveDialog1.InitialDir:=ExtractFileDir(oldname);
  SaveDialog1.FileName:=ExtractFileName(oldname);
  if SaveDialog1.Execute then
    begin
      CopyFile(oldname, SaveDialog1.FileName);

      StatusEditor;
      Project.Update;
    end;
end;

// удалить файл
procedure TMainForm.ProTreeDeleteFile(Sender: TObject);
var
  filename:string;
  ST:TSourceText;
begin
  filename:=Project.GetProTreePath(ProTree.Selected);
  DeleteFile(filename);

  ST:=EditorFiles.Get(filename);
  if ST<>nil then  Editor.SetSourceText(EditorFiles.Close(ST, false));

  StatusEditor;
  Project.Update;
end;

// исключить из компиляции
procedure TMainForm.ProTreeExcludeFile(Sender: TObject);
var
  filename, newname:string;

  ST:TSourceText;
begin
  filename:=Project.GetProTreePath(ProTree.Selected);
  newname:=ExtractFileDir(filename)+'\'+ExtractFileNameOnly(filename)+'.-asm';

  RenameFileUTF8(filename, newname);

  ST:=EditorFiles.Get(filename);
  if ST<>nil then  ST.FileName:=newname;

  StatusEditor;
  EditorFiles.Update;
  Project.Update;
end;

// включить в компиляцию
procedure TMainForm.ProTreeIncludeFile(Sender: TObject);
var
  filename, newname:string;

  ST:TSourceText;
begin
  filename:=Project.GetProTreePath(ProTree.Selected);
  newname:=ExtractFileDir(filename)+'\'+ExtractFileNameOnly(filename)+'.asm';

  RenameFileUTF8(filename, newname);

  ST:=EditorFiles.Get(filename);
  if ST<>nil then  ST.FileName:=newname;

  StatusEditor;
  EditorFiles.Update;
  Project.Update;
end;

// просмотр результата компиляции
procedure TMainForm.ProTreeViesDASMFile(Sender: TObject);
var
  filename, newname:string;
  ST:TSourceText;
begin
  filename:=Project.GetProTreePath(ProTree.Selected);
  // сформируем имя файла-результата компиляции для проверки
  newname:=Project.Out_Path+'\internal'+
              UTF8Copy(filename, UTF8Length(Project.SourcePath)+1,
              UTF8Length(filename)-UTF8Length(Project.SourcePath));
  filename:=ExtractFileDir(newname)+'\'+ExtractFileNameOnly(newname)+'.dasm';

  ST:=EditorFiles.Open(filename);
  if ST<>nil then EditorFiles.OpenInEditor(ST);

  StatusEditor;
  Project.Update;
end;

// открыть расположение файла в shell
procedure TMainForm.ProTreeOpenInShell(Sender: TObject);
var
  filename:string;
begin
  filename:=Project.GetProTreePath(ProTree.Selected);
  ShellExecuteW(0, nil, 'explorer.exe', PWideChar(UTF8Decode('/select,'+filename)), nil, SW_SHOWNORMAL);
end;

// прошить файл в микроконтроллер
procedure TMainForm.ProTreeWriteMCUFile(Sender: TObject);
var
  filename:string;
begin
  filename:=Project.GetProTreePath(ProTree.Selected);
  STLink.MCUWrite(filename);
end;

// создать подпапку
procedure TMainForm.ProTreeNewDirectory(Sender: TObject);
var
  dirname:string;
  SF:TGetStrForm;
begin
  dirname:=Project.GetProTreePath(ProTree.Selected);
  SF:=TGetStrForm.Create(MainForm);
  SF.Caption:='Имя создаваемой папки';
  if SF.ShowModal=mrOk then ForceDirectory(dirname+'\'+SF.StrEdit.Text);
  SF.Free;

  StatusEditor;
  Project.Update;
end;

// переименовать папку
procedure TMainForm.ProTreeRenameDirectory(Sender: TObject);
var
  dirname, newname:string;
  dirFiles:TStringList;
  GetStrForm: TGetStrForm;
  i:integer;
  ST:TSourceText;
begin
  dirname:=Project.GetProTreePath(ProTree.Selected);
  dirFiles:=FindAllFiles(dirname, '*.*', true);
  GetStrForm:= TGetStrForm.Create(MainForm);
  GetStrForm.Caption:='Новое имя папки';
  GetStrForm.StrEdit.Text:=dirname;
  if GetStrForm.ShowModal=mrOk then
    begin
      RenameFile(dirname, GetStrForm.StrEdit.Text);

      // смена путей всех открытых файлов переименованной директории
      for i:=0 to dirFiles.Count-1 do
        begin
          ST:=EditorFiles.Get(dirFiles.Strings[i]);
          if ST<>nil then
            begin
              newname:=GetStrForm.StrEdit.Text+
                         UTF8Copy(ST.FileName,
                                  UTF8Length(dirname)+1,
                                  UTF8Length(ST.FileName)-UTF8Length(dirname));
              ST.FileName:=newname;
            end;
        end;

      StatusEditor;
      Project.Update;
    end;
  dirFiles.Free;
  GetStrForm.Free;
end;

// удалить папку
procedure TMainForm.ProTreeDeleteDirectory(Sender: TObject);
var
  dirname:string;
  dirFiles:TStringList;
  i:integer;
  ST:TSourceText;
begin
  dirname:=Project.GetProTreePath(ProTree.Selected);
  dirFiles:=FindAllFiles(dirname, '*.*', true);

  if (dirFiles.Count>0) and
        (MessageDlg('Удаление не пустой папки',
                   'Удаляемая папка содержит в себе файлы, которые тоже будут удалены. Удаляем?',
                      mtWarning,[mbYes, mbNo],'')<>mrYes) then
     begin
       dirFiles.Free;
       exit;
     end;

  DeleteDirectory(dirname, false); // удалим папку

  // закрытие открытых файлов удаляемой директории
  for i:=0 to dirFiles.Count-1 do
    begin
      ST:=EditorFiles.Get(dirFiles.Strings[i]);
      if ST<>nil then  Editor.SetSourceText(EditorFiles.Close(ST, false));
    end;

  dirFiles.Free;
  StatusEditor;
  Project.Update;
end;



// изменение размеров панели на которой стоит редактор
procedure TMainForm.CenterWorkPanelResize(Sender: TObject);
begin
  Editor.Refresh;
end;

procedure TMainForm.setVisualParams;
begin
  ProTree.Font:=Editor.EditorConfigForm.Editor_Text_Image.Canvas.Font;
  ProTree.Font.Size:=Editor.EditorConfigForm.Editor_Text_Image.Canvas.Font.Size-2;
  ListBox1.Font:=ProTree.Font;
  SymbolsStringGrid.Font:=ProTree.Font;
  SymbFileBox.Font:=ProTree.Font;
  SymbValueEdit.Font:=ProTree.Font;
  SymbDescMemo.Font:=ProTree.Font;
  SymbolItemList.Font:=ProTree.Font;

  ListBox1.Color:=Editor.EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color;
  ProTree.Color:=Editor.EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color;
  SymbolsStringGrid.Color:=Editor.EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color;
  SymbFileBox.Color:=Editor.EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color;
  SymbSearchEdit.Color:=Editor.EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color;
  SymbValueEdit.Color:=Editor.EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color;
  SymbDescMemo.Color:=Editor.EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color;
  SymbolItemList.Color:=Editor.EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color;

  MessagesListBox.Font:=ProTree.Font;
  MessagesListBox.Color:=Editor.EditorConfigForm.Editor_Text_Image.Canvas.Brush.Color;

  DebugForm.SetFormColor(MessagesListBox.Color);
end;

// отладочная настройка вида приложения
procedure TMainForm.HiddenPanels;
begin
   // скроем доп. панели
//  RightPanel.Width:=0;           // панель меток
//  RightSplitter.Enabled:=false;

//  CenterTopPanel.Height:=0;
//  TopSplitter.Enabled:=false;

  CenterBottomPanel.Height:=0;
//  BottomSplitter.Enabled:=false;
end;


// перевод меню в режим ASM файла
procedure TMainForm.SetMenuToAsmMode;
begin
   Menu_File_Set_CharSet.Enabled:=True;
   Menu_File_Insert_Option.Enabled:=true;
end;

// перевод меню в обычный режим
procedure TMainForm.SetMenuToTextMode;
begin
   Menu_File_Set_CharSet.Enabled:=false;
   Menu_File_Insert_Option.Enabled:=false;
end;

// открытие файлов из командной строки
procedure TMainForm.OpenFileParams;
var
  i, p, k:integer;
  str:string;
begin
  for i:=1 to ParamCount do
    begin
      str:=UTF8UpperCase(ParamStr(i));
      p:=UTF8Pos('.AEP', str, 1);
      k:=UTF8Length(str);
      if (p>0) and (k=p+3) then
         Project.Open(ParamStr(i))
      else EditorFiles.OpenInEditor(ParamStr(i)); // откроем файлы из командной строки
    end;
end;

procedure TMainForm.ProcessMess;
begin
  Application.ProcessMessages;
end;

procedure TMainForm.SetMenuMode(ST: TSourceText);
begin
  exit;
  //настройка меню в соответствии с типом открытого файла
  case ST.TextType of
    '.ASM', '.INC': SetMenuToAsmMode;
    else SetMenuToTextMode;
  end;
end;

// потеря фокуса
procedure TMainForm.ApplicationDeactivate(Sender: TObject);
begin
  Editor.Refresh;
end;

// показ статуса редактора
procedure TMainForm.StatusEditor;
var
  str:string;
  TextParser:TTextParser;

  // переменные блока меток и символов
  i, p, ppl:integer;
  symb:TSymbol;
  SymbList:TSymbolList;
  row:integer;
  symbfilelist:TStringList;
  str1:string;
  res:boolean;
begin
  if Editor.Source=nil then
    begin
        StatusBar1.Panels[0].Text:='';
        StatusBar1.Panels[1].Text:='';
        StatusBar1.Panels[2].Text:='';
        StatusBar1.Panels[3].Text:='';

        // скроем правую панель
        RightPanel.Visible:=false;
        Menu_View_SymbolsPanel.Checked:=false;
        Config.SymbolPanelShow:=false;

      exit;
    end;
  EditorFiles.Update;

  StatusBar1.Panels[0].Text:='X: '+inttostr(Editor.CursorPosX)+
                          ' : Y: '+inttostr(Editor.CursorPosY)+
                            ' ('+inttostr(TSourceText(Editor.Source).Count)+')';

  if not Editor.InsMode then str:='ЗАМ' else str:='ВСТ';
  MainForm.StatusBar1.Panels[1].text:=str;

  MainForm.StatusBar1.Panels[2].text:=TSourceText(Editor.Source).CharSet;
  MainForm.StatusBar1.Panels[3].text:=TSourceText(Editor.Source).FileName;

  if not Config.SymbolPanelShow then exit;

  // покажем символы если они есть
  TextParser:=TTextParser(Editor.SourceText.TextParser);

  // покажем панель если надо
  if (TextParser is TAsmTextParser) and (not RightPanel.Visible) then RightPanel.Visible:=true;
  // скроем панель если не надо
  if (not (TextParser is TAsmTextParser)) and (RightPanel.Visible) then RightPanel.Visible:=false;

  if (TextParser is TAsmTextParser) and (TAsmTextParser(TextParser).NewSymbolList=true) then
    begin

      TAsmTextParser(TextParser).NewSymbolList:=false;
      // получим символы
      SymbList:=TSymbolList(TAsmTextParser(TextParser).FullSymbolList);

      // настроим таблицу
      SymbolsStringGrid.ScrollBars:=ssNone;
      SymbolsStringGrid.ColWidths[0]:=SymbolsStringGrid.Width;

      // список файлов символов
      symbfilelist:=TStringList(TAsmTextParser(TextParser).IncludeFileList);
      // уравнивание списка файлов со списком фильтра
      // удалим те файлы из визуального списка которых уже нет
      ppl:=UTF8Length(Project.Project_Path);
      i:=0;
      while i<SymbFileBox.Count do
        begin
          res:=false;
          for p:=0 to symbfilelist.Count-1 do
            begin
              str1:=UTF8LowerCase(
                                   UTF8Copy(
                                             symbfilelist.Strings[p],
                                             ppl,
                                             UTF8Length(symbfilelist.Strings[p])-ppl+1
                                            )
                                 );
              if SymbFileBox.Items.Strings[i]=str1 then
                begin
                  res:=true;
                  break;
                end;
            end;
          if res then i:=i+1 else SymbFileBox.Items.Delete(i);
        end;
      // добавим те файлы которых не хватает
      for i:=0 to symbfilelist.Count-1 do
        begin
          res:=false;
          str1:=UTF8LowerCase(UTF8Copy(symbfilelist.Strings[i], ppl, UTF8Length(symbfilelist.Strings[i])-ppl+1));
          for p:=0 to SymbFileBox.Count-1 do
            if SymbFileBox.Items.Strings[p]=str1 then
              begin
                res:=true;
                break;
              end;
          if not res then SymbFileBox.Checked[SymbFileBox.Items.Add(str1)]:=true;
        end;

      SymbolsStringGrid.RowCount:=Project.GlobalSymbols.Count+SymbList.Count;
      row:=0;
      str:='';
      str1:=UTF8UpperCase(SymbSearchEdit.Text);
      // вывод глобальных символов
      if GlobalToggleBox.Checked then
        begin
          i:=0;
          while i<Project.GlobalSymbols.Count do
            begin
              symb:=TSymbol(Project.GlobalSymbols.GetSymb(i));
              str:=symb.FileName;
              if (str1='') or (UTF8Pos(str1, UTF8UpperCase(symb.Name))>0) then
                 begin
                   SymbolsStringGrid.Cells[0,row]:='G. '+symb.Name;
                   row:=row+1;
                 end;
              i:=i+1;
            end;
        end;
      // вывод остальных символов
      i:=0;
      while i<SymbList.Count do
      begin
        symb:=TSymbol(SymbList.GetSymb(i));
        str:=symb.FileName;
        for p:=0 to SymbFileBox.Count-1 do
          if ((SymbFileBox.Items.Strings[p]=UTF8LowerCase(UTF8Copy(symb.FileName, ppl, UTF8Length(symb.FileName)-ppl+1))) and
             (SymbFileBox.Checked[p])) then
            begin
              repeat // обработка символов файла попавшего в фильтр
                 // фильтр типа символа/метки/глобальной метки
                if ((symb.Typ=stLocalLabel) and (LocToggleBox.Checked)) or
                   ((symb.Typ=stSymbol) and (SymbToggleBox.Checked)) then
                     begin
                       // обработка текстового фильтра
                       if (str1='') or (UTF8Pos(str1, UTF8UpperCase(symb.Name))>0) then
                          begin
                            SymbolsStringGrid.Cells[0,row]:=symb.Name;
                            row:=row+1;
                          end;
                     end;
                 i:=i+1;
                 if i<SymbList.Count then symb:=TSymbol(SymbList.GetSymb(i));
              until (i=SymbList.Count) or (str<>symb.FileName);
              i:=i-1;
              break;
            end;
        i:=i+1;
      end;
      SymbolsStringGrid.RowCount:=row; // ограничим количество строк выведенными
      SymbolsStringGrid.ScrollBars:=ssAutoVertical;
    end;

end;

// смена выделения файла в списке
procedure TMainForm.SymbFileBoxSelectionChange(Sender: TObject; User: boolean);
var
  TextParser:TTextParser;
begin
  TextParser:=TTextParser(Editor.SourceText.TextParser);
  if not (TextParser is TAsmTextParser) then exit;

  TAsmTextParser(TextParser).NewSymbolList:=true;
  StatusEditor;
  MainForm.CenterWorkPanel.SetFocus;
end;

// выбор всех файлов символов
procedure TMainForm.SymbolAllFilesButtonClick(Sender: TObject);
var
  TextParser:TTextParser;
  i:integer;
begin
  TextParser:=TTextParser(Editor.SourceText.TextParser);
  if not (TextParser is TAsmTextParser) then exit;

  for i:=0 to SymbFileBox.Count-1 do SymbFileBox.Checked[i]:=true;

  TAsmTextParser(TextParser).NewSymbolList:=true;
  StatusEditor;
  MainForm.CenterWorkPanel.SetFocus;
end;

// выключение показа всех файлов
procedure TMainForm.SymbolNoFilesButtonClick(Sender: TObject);
var
  TextParser:TTextParser;
  i:integer;
begin
  TextParser:=TTextParser(Editor.SourceText.TextParser);
  if not (TextParser is TAsmTextParser) then exit;

  for i:=0 to SymbFileBox.Count-1 do SymbFileBox.Checked[i]:=false;

  TAsmTextParser(TextParser).NewSymbolList:=true;
  StatusEditor;
  MainForm.CenterWorkPanel.SetFocus;
end;

// клик по таблице символов
procedure TMainForm.SymbolsStringGridClick(Sender: TObject);
begin
  Editor.Refresh;
  InputEditor:=true;
end;

// открытие определения символа
procedure TMainForm.SymbolsStringGridDblClick(Sender: TObject);
var
  TextParser:TTextParser;
begin
   if selectedSymbol=nil then exit;

   TextParser:=TTextParser(Editor.SourceText.TextParser);
  if not (TextParser is TAsmTextParser) then exit;

  SymbolOpenDef(selectedSymbol, Editor.SourceText);
  Editor.Refresh;
  StatusEditor;
end;

// выбор символа для отображения
procedure TMainForm.SymbolsStringGridSelectCell(Sender: TObject; aCol,
  aRow: Integer; var CanSelect: Boolean);
var
  i:integer;
  TextParser:TTextParser;
  SymbList:TSymbolList;
  symb:TSymbol;
  str:string;
begin
  if not Config.SymbolPanelShow then exit;
  if (Editor.Source=nil) or (not startProc) or (SymbolsStringGrid.RowCount=0) or (aRow<0) then exit;

  TextParser:=TTextParser(Editor.SourceText.TextParser);
  if (TextParser is TAsmTextParser) then
    begin
      // получим символы
      SymbList:=TSymbolList(TAsmTextParser(TextParser).FullSymbolList);
      symb:=nil;
      str:=SymbolsStringGrid.Cells[0, aRow]; // текст символа
      if UTF8Pos('G. ', str, 1)=1 then // найдем глобальный символ
        begin
          str:=UTF8Copy(str, 4, UTF8Length(str)-3);
          for i:=0 to Project.GlobalSymbols.Count-1 do  // найдем  глобальный символ в списке
            if TSymbol(Project.GlobalSymbols.GetSymb(i)).Name=str then
              begin
                symb:=TSymbol(Project.GlobalSymbols.GetSymb(i));
                break;
              end;
        end
      else
      for i:=0 to SymbList.Count-1 do  // найдем не глобальный символ в списке
        if TSymbol(SymbList.GetSymb(i)).Name=str then
          begin
            symb:=TSymbol(SymbList.GetSymb(i));
            break;
          end;

      selectedSymbol:=symb;

      // получим токены определения
      if symb=nil then exit;
      SymbDescMemo.Text:=symb.ValueStr;
      Label8.Caption:=symb.TypeStr;

//      SymbolItemList.Clear;
      if symb.itemNames<>nil then SymbolItemList.Items.Assign(symb.itemNames);

      label10.Caption:=UTF8Copy(symb.FileName,
                                UTF8Length(Project.Project_Path)+1,
                                UTF8Length(symb.FileName)-UTF8Length(Project.Project_Path));
    end;
end;

// нажатие на кнопки типа символа в фильтре меток
procedure TMainForm.CategorySymbolToggleBoxChange(Sender: TObject);
var
  TextParser:TTextParser;
begin
  TextParser:=TTextParser(Editor.SourceText.TextParser);
  if not (TextParser is TAsmTextParser) then exit;

  TAsmTextParser(TextParser).NewSymbolList:=true;
  Editor.Refresh;
  StatusEditor;
end;

procedure TMainForm.TextImageClick(Sender: TObject);
begin

end;

// запуск второй копии приложения
procedure TMainForm.UniqueInstance1OtherInstance(Sender: TObject;
  ParamCount: Integer; const Parameters: array of String);
var
  i, p, k:integer;
  str:string;
begin
  WindowState:=wsNormal;
  BringToFront;

  for i:=0 to ParamCount-1 do
    begin
      str:=UTF8UpperCase(Parameters[i]);
      p:=UTF8Pos('.AEP', str, 1);
      k:=UTF8Length(str);
      if (p>0) and (k=p+3) then
         Project.Open(Parameters[i])
      else EditorFiles.OpenInEditor(Parameters[i]); // откроем файлы из командной строки
    end;
end;


// очистка текста фильтра символов
procedure TMainForm.SearchEditClearButtonClick(Sender: TObject);
begin
  SymbSearchEdit.Text:='';
  CategorySymbolToggleBoxChange(Sender);
end;

// ввод текста в поле фильтра поиска меток
procedure TMainForm.SymbSearchEditChange(Sender: TObject);
begin
  CategorySymbolToggleBoxChange(Sender);
end;

// клик на поле ввода текстового фильтра метки
procedure TMainForm.SymbSearchEditClick(Sender: TObject);
begin
  Editor.Refresh;
  InputEditor:=false;
end;

// клик на списке файлов символов инклудов
procedure TMainForm.SymbFileBoxClick(Sender: TObject);
begin
  Editor.Refresh;
  InputEditor:=true;
  MainForm.CenterWorkPanel.SetFocus;
end;

// двойной клик по файлу в окне включаемых файлов символов
procedure TMainForm.SymbFileBoxDblClick(Sender: TObject);
var
  str:string;
  i:integer;
  TextParser:TTextParser;
begin
  TextParser:=TTextParser(Editor.SourceText.TextParser);
  if not (TextParser is TAsmTextParser) then exit;

  i:=SymbFileBox.ItemIndex;
  str:=GetFullFromOfsFilename(SymbFileBox.Items.Strings[i], Editor.SourceText.FileName);

  HistoryFiles.AddHist(Editor.SourceText);

  EditorFiles.OpenInEditor(str);
  InputEditor:=true;
  MainForm.CenterWorkPanel.SetFocus;
end;

// клин на combobox выбора режима просмотра проекта
procedure TMainForm.ProModeClick(Sender: TObject);
begin
  InputEditor:=true;
end;

// клик по дереву проекта
procedure TMainForm.ProTreeClick(Sender: TObject);
begin
  InputEditor:=true;
end;

// клик на списке открытых файлов
procedure TMainForm.ListBox1Click(Sender: TObject);
begin
  InputEditor:=true;
end;


// настройка ширины нулевого столбца таблицы
procedure TMainForm.Panel5Resize(Sender: TObject);
var
  i:integer;
begin
  SymbolsStringGrid.ColWidths[0]:=SymbolsStringGrid.Width;

  i:=(Panel6.Width-5) div 4;
  GlobalToggleBox.Left:=5;   GlobalToggleBox.Width:=i-2;
  LocToggleBox.Left:=i+5;    LocToggleBox.Width:=i-2;
  SymbToggleBox.Left:=i*2+5; SymbToggleBox.Width:=i-2;
  ValToggleBox.Left:=i*3+5;  ValToggleBox.Width:=i-2;
end;

// изменение размера центральной панели
procedure TMainForm.CenterPanelResize(Sender: TObject);
var
  i:integer;
begin
  i:=(CenterTopPanel.Width-5) div 6;
  F1Button.Left:=5;      F1Button.Width:=i-2;
  F2Button.Left:=i+5;    F2Button.Width:=i-2;
  F3Button.Left:=i*2+5;  F3Button.Width:=i-2;
  F4Button.Left:=i*3+5;  F4Button.Width:=i-2;
  F5Button.Left:=i*4+5;  F5Button.Width:=i-2;
  F6Button.Left:=i*5+5;  F6Button.Width:=i-2;
end;

procedure TMainForm.ComboBox1Select(Sender: TObject);
begin
  if Editor.SourceText=nil then exit;

  Editor.InsertTextSelection(TComboBox(Sender).Text);

  Editor.Refresh;
  StatusEditor;
end;

// очистка информационных панелей
procedure TMainForm.ClearPanels;
begin
  SymbolsStringGrid.RowCount:=0;
  SymbFileBox.Clear;
  SymbSearchEdit.Text:='';
end;

end.

