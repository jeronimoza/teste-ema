unit SWAPI.Forms.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, SWAPI.Forms.Base, FMX.TabControl,
  System.Actions, FMX.ActnList, FMX.Layouts, FMX.Controls.Presentation, FMX.Objects;

type
  TfrmMain = class(TfrmBase)
    tabData: TTabControl;
    itePlanets: TTabItem;
    itePeople: TTabItem;
    iteFilms: TTabItem;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    procedure FormShow(Sender: TObject);
  private
  public
  end;

var
  frmMain: TfrmMain;

implementation

uses
  SWAPI.Forms.PlanetList,
  SWAPI.Forms.PeopleList,
  SWAPI.Forms.FilmList;

{$R *.fmx}

procedure TfrmMain.FormShow(Sender: TObject);
begin
  inherited;
  tabData.ActiveTab := itePlanets;
  TfrmPlanetList.InnerShow(Layout1);
  TfrmPeopleList.InnerShow(Layout2);
  TfrmFilmList.InnerShow(Layout3);
end;

end.
