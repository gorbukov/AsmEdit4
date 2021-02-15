unit FontImportConfigUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFontImportConfigForm }

  TFontImportConfigForm = class(TForm)
    Button1: TButton;
    WidthImp: TCheckBox;
    StrLineFormat: TCheckBox;
  private

  public

  end;

implementation

{$R *.lfm}

end.

