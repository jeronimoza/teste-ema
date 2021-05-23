unit SWAPI.Forms.PlanetDetail;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, SWAPI.Forms.BaseDetail, System.Actions,
  FMX.ActnList, FMX.TabControl, FMX.Layouts,
  SWAPI.Models, FMX.ListBox, System.Generics.Collections,
  SWAPI.Services,
  SWAPI.Forms.BaseList, FMX.Objects;

type
  TfrmPlanetDetail = class(TfrmBaseDetail)
    iteFilms: TTabItem;
    iteResidents: TTabItem;
    Layout1: TLayout;
    Layout2: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FPeopleList: TObjectList<TPeople>;
    FFilmList: TObjectList<TFilm>;
    FfrmPeopleList: TfrmBaseList;
    FfrmFilmList: TfrmBaseList;
  public
    procedure DoFillControls(const APlanet: TPlanet);
  end;

implementation

uses
  SWAPI.Forms.PeopleList,
  SWAPI.Forms.FilmList;

{$R *.fmx}

{ TfrmPlanetDetail }

procedure TfrmPlanetDetail.DoFillControls(const APlanet: TPlanet);
begin
  lsbData.Items.AddPair('Nome', APlanet.name);
  lsbData.Items.AddPair('Período de rotação', APlanet.rotation_period);
  lsbData.Items.AddPair('Período de órbita', APlanet.orbital_period);
  lsbData.Items.AddPair('Diâmetro', APlanet.diameter);
  lsbData.Items.AddPair('Clima', APlanet.climate);
  lsbData.Items.AddPair('População', APlanet.population);

  DoInBackground(
    procedure()
    var
      LSWAPIRequest: ISWAPIRequest;
    begin
      LSWAPIRequest := TSWAPIPeopleRequest.Create();
      FdtmREST.Query<TPeople>(LSWAPIRequest, FPeopleList, APlanet.residents);
      TThread.Synchronize(nil,
        procedure()
        begin
          (FfrmPeopleList as TfrmPeopleList).DoFillListView(FPeopleList);
        end);

      LSWAPIRequest := TSWAPIFilmRequest.Create();
      FdtmREST.Query<TFilm>(LSWAPIRequest, FFilmList, APlanet.films);
      TThread.Synchronize(nil,
        procedure()
        begin
          (FfrmFilmList as TfrmFilmList).DoFillListView(FFilmList);
        end);
    end);
end;

procedure TfrmPlanetDetail.FormCreate(Sender: TObject);
begin
  inherited;
  tabDetail.ActiveTab := iteFilms;
  FPeopleList := TObjectList<TPeople>.Create();
  FFilmList := TObjectList<TFilm>.Create();
  FfrmFilmList := TfrmFilmList.InnerShow(Layout1);
  FfrmFilmList.ChangeToListMode();
  FfrmPeopleList := TfrmPeopleList.InnerShow(Layout2);
  FfrmPeopleList.ChangeToListMode();
end;

procedure TfrmPlanetDetail.FormDestroy(Sender: TObject);
begin
  inherited;
  FPeopleList.DisposeOf();
  FFilmList.DisposeOf();
end;

end.
