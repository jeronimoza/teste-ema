unit SWAPI.Forms.FilmList;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, SWAPI.Forms.BaseList, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, System.Actions, FMX.ActnList, FMX.ListView, FMX.Edit,
  FMX.Controls.Presentation, FMX.Layouts,
  SWAPI.Models,
  SWAPI.Services,
  SWAPI.Classes.Attributes,
  SWAPI.Forms.FilmDetail,
  System.Generics.Collections, FMX.Objects;

type
  TfrmFilmList = class(TfrmBaseList)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actNextPageExecute(Sender: TObject);
    procedure actSearchExecute(Sender: TObject);
    procedure lsvDataItemClick(const Sender: TObject; const AItem: TListViewItem);
  private
    FFilmList: TObjectList<TFilm>;
  public
    procedure DoFillListView(const AList: TObjectList<TFilm>);
  end;

implementation

{$R *.fmx}

procedure TfrmFilmList.actNextPageExecute(Sender: TObject);
begin
  inherited;
  DoInBackground(
    procedure()
    begin
      FdtmREST.Query<TFilm>(FSWAPIRequest, FFilmList, EmptyStr);
      TThread.Synchronize(nil,
        procedure()
        begin
          DoFillListView(FFilmList);
        end);
    end);
end;

procedure TfrmFilmList.actSearchExecute(Sender: TObject);
begin
  inherited;
  FFilmList.Clear();
  DoInBackground(
    procedure()
    begin
      FdtmREST.Query<TFilm>(FSWAPIRequest, FFilmList, edtSearch.Text);
      TThread.Synchronize(nil,
        procedure()
        begin
          DoFillListView(FFilmList)
        end);
    end);
end;

procedure TfrmFilmList.DoFillListView(const AList: TObjectList<TFilm>);
var
  LItem: TListViewItem;
  LFilm: TFilm;
begin
  for LFilm in AList do
  begin
    LItem := lsvData.Items.Add();
    LItem.Text := LFilm.title;
    LItem.TagObject := LFilm;
  end;
end;

procedure TfrmFilmList.FormCreate(Sender: TObject);
begin
  inherited;
  FSWAPIRequest := TSWAPIFilmRequest.Create();
  FFilmList := TObjectList<TFilm>.Create();
end;

procedure TfrmFilmList.FormDestroy(Sender: TObject);
begin
  inherited;
  FFilmList.DisposeOf();
end;

procedure TfrmFilmList.lsvDataItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  LfrmFilmDetail: TfrmFilmDetail;
begin
  inherited;
  LfrmFilmDetail := TfrmFilmDetail.Create(Self);
  try
    LfrmFilmDetail.DoFillControls(AItem.TagObject as TFilm);
    LfrmFilmDetail.ShowModal();
  finally
    LfrmFilmDetail.DisposeOf();
  end;
end;

end.
