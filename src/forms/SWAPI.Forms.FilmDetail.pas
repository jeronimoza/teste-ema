unit SWAPI.Forms.FilmDetail;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, SWAPI.Forms.BaseDetail, System.Actions,
  FMX.ActnList, FMX.TabControl, FMX.Layouts,
  SWAPI.Models, FMX.ListBox, System.Generics.Collections,
  SWAPI.Services,
  SWAPI.Forms.BaseList, FMX.Objects, FMX.Controls.Presentation;

type
  TfrmFilmDetail = class(TfrmBaseDetail)
    iteCharacters: TTabItem;
    itePlanets: TTabItem;
    Layout1: TLayout;
    Layout2: TLayout;
    labOpeningCrawl: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FPeopleList: TObjectList<TPeople>;
    FPlanetList: TObjectList<TPlanet>;
    FfrmPeopleList: TfrmBaseList;
    FfrmPlanetList: TfrmBaseList;
  public
    procedure DoFillControls(const AFilm: TFilm);
  end;

implementation

uses
  SWAPI.Forms.PeopleList,
  SWAPI.Forms.PlanetList;

{$R *.fmx}

procedure TfrmFilmDetail.DoFillControls(const AFilm: TFilm);
//var
  //LItem: TListBoxItem;
  //LLabel: TLabel;
begin
  lsbData.Items.AddPair('Título', AFilm.title);
  lsbData.Items.AddPair('Episódio', AFilm.episode_id.ToString());
  //lsbData.Items.AddPair('Texto de abertura', AFilm.opening_crawl);

  {LItem := TListBoxItem.Create(lsbData);
  LItem.Parent := lsbData;
  LLabel := TLabel.Create(LItem);
  LLabel.Parent := LItem;
  LLabel.Align := TAlignLayout.Client;
  LLabel.Text := AFilm.opening_crawl;
  LLabel.WordWrap := True;
  LLabel.AutoSize := True;
  LItem.AddObject(LLabel);
  LItem.Height := LLabel.Height;}

  {LLabel := TLabel.Create(lsbData);
  LLabel.Parent := lsbData;
  LLabel.Align := TAlignLayout.Top;
  LLabel.Text := AFilm.opening_crawl;
  LLabel.WordWrap := True;
  LLabel.AutoSize := True;}

  labOpeningCrawl.Text := AFilm.opening_crawl;

  lsbData.Items.AddPair('Ano de lançamento', AFilm.release_date);

  DoInBackground(
    procedure()
    var
      LSWAPIRequest: ISWAPIRequest;
    begin
      LSWAPIRequest := TSWAPIPeopleRequest.Create();
      FdtmREST.Query<TPeople>(LSWAPIRequest, FPeopleList, AFilm.characters);
      TThread.Synchronize(nil,
        procedure()
        begin
          (FfrmPeopleList as TfrmPeopleList).DoFillListView(FPeopleList);
        end);

      LSWAPIRequest := TSWAPIPlanetRequest.Create();
      FdtmREST.Query<TPlanet>(LSWAPIRequest, FPlanetList, AFilm.planets);
      TThread.Synchronize(nil,
        procedure()
        begin
          (FfrmPlanetList as TfrmPlanetList).DoFillListView(FPlanetList);
        end);
    end);
end;

procedure TfrmFilmDetail.FormCreate(Sender: TObject);
begin
  inherited;
  tabDetail.ActiveTab := iteCharacters;
  FPeopleList := TObjectList<TPeople>.Create();
  FPlanetList := TObjectList<TPlanet>.Create();
  FfrmPeopleList := TfrmPeopleList.InnerShow(Layout1);
  FfrmPeopleList.ChangeToListMode();
  FfrmPlanetList := TfrmPlanetList.InnerShow(Layout2);
  FfrmPlanetList.ChangeToListMode();
end;

procedure TfrmFilmDetail.FormDestroy(Sender: TObject);
begin
  inherited;
  FPeopleList.DisposeOf();
  FPlanetList.DisposeOf();
end;

end.
