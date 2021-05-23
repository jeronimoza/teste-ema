unit SWAPI.Forms.PeopleDetail;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, SWAPI.Forms.BaseDetail, System.Actions,
  FMX.ActnList, FMX.TabControl, FMX.Layouts,
  SWAPI.Models, FMX.ListBox, System.Generics.Collections,
  SWAPI.Services,
  SWAPI.Forms.BaseList, FMX.Objects;

type
  TfrmPeopleDetail = class(TfrmBaseDetail)
    iteFilms: TTabItem;
    Layout1: TLayout;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FFilmList: TObjectList<TFilm>;
    FfrmFilmList: TfrmBaseList;
  public
    procedure DoFillControls(const APeople: TPeople);
  end;

implementation

uses
  SWAPI.Forms.FilmList;

{$R *.fmx}

{ TfrmPeopleDetail }

procedure TfrmPeopleDetail.DoFillControls(const APeople: TPeople);
begin
  lsbData.Items.AddPair('Nome', APeople.name);
  lsbData.Items.AddPair('Ano de aniversário', APeople.birth_year);
  lsbData.Items.AddPair('Gênero', APeople.gender);

  DoInBackground(
    procedure()
    var
      LSWAPIRequest: ISWAPIRequest;
    begin
      LSWAPIRequest := TSWAPIFilmRequest.Create();
      FdtmREST.Query<TFilm>(LSWAPIRequest, FFilmList, APeople.films);
      TThread.Synchronize(nil,
        procedure()
        begin
          (FfrmFilmList as TfrmFilmList).DoFillListView(FFilmList);
        end);
    end);
end;

procedure TfrmPeopleDetail.FormCreate(Sender: TObject);
begin
  inherited;
  tabDetail.ActiveTab := iteFilms;
  FFilmList := TObjectList<TFilm>.Create();
  FfrmFilmList := TfrmFilmList.InnerShow(Layout1);
  FfrmFilmList.ChangeToListMode();
end;

procedure TfrmPeopleDetail.FormDestroy(Sender: TObject);
begin
  inherited;
  FFilmList.DisposeOf();
end;

end.
