unit SWAPI.Forms.BaseDetail;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, SWAPI.Forms.Base, FMX.Layouts,
  System.Actions, FMX.ActnList, FMX.TabControl, FMX.ListBox, FMX.Objects;

type
  TfrmBaseDetail = class(TfrmBase)
    lytLeft: TLayout;
    lytClient: TLayout;
    tabDetail: TTabControl;
    lsbData: TListBox;
  private
  public
  end;

implementation

{$R *.fmx}

end.
