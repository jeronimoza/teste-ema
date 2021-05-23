unit SWAPI.Forms.PlanetList;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, SWAPI.Forms.BaseList, System.Actions,
  FMX.ActnList, FMX.Edit, FMX.Controls.Presentation, FMX.Layouts, System.Generics.Collections, SWAPI.Modules.REST,
  System.JSON, REST.Json, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  SWAPI.Models,
  SWAPI.Services,
  SWAPI.Classes.Attributes,
  SWAPI.Forms.PlanetDetail, FMX.Objects;

type
  TfrmPlanetList = class(TfrmBaseList)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actNextPageExecute(Sender: TObject);
    procedure actSearchExecute(Sender: TObject);
    procedure lsvDataItemClick(const Sender: TObject; const AItem: TListViewItem);
  private
    FPlanetList: TObjectList<TPlanet>;
  public
    procedure DoFillListView(const AList: TObjectList<TPlanet>);
    //procedure DoFillDataListView<TPlanet>(const AList: TObjectList<TPlanet>); virtual; abstract;
  end;

implementation

{$R *.fmx}

procedure TfrmPlanetList.actNextPageExecute(Sender: TObject);
begin
  inherited;
  DoInBackground(
    procedure()
    begin
      FdtmREST.Query<TPlanet>(FSWAPIRequest, FPlanetList, EmptyStr);
      TThread.Synchronize(nil,
        procedure()
        begin
          DoFillListView(FPlanetList);
        end);
    end);
end;

procedure TfrmPlanetList.actSearchExecute(Sender: TObject);
begin
  inherited;
  FPlanetList.Clear();
  DoInBackground(
    procedure()
    begin
      FdtmREST.Query<TPlanet>(FSWAPIRequest, FPlanetList, edtSearch.Text);
      TThread.Synchronize(nil,
        procedure()
        begin
          DoFillListView(FPlanetList);
        end);
    end);
end;

procedure TfrmPlanetList.DoFillListView(const AList: TObjectList<TPlanet>);
var
  LItem: TListViewItem;
  LPlanet: TPlanet;
begin
  for LPlanet in AList do
  begin
    LItem := lsvData.Items.Add();
    LItem.Text := LPlanet.name;
    LItem.TagObject := LPlanet;
  end;
end;

procedure TfrmPlanetList.FormCreate(Sender: TObject);
begin
  inherited;
  FSWAPIRequest := TSWAPIPlanetRequest.Create();
  FPlanetList := TObjectList<TPlanet>.Create();
end;

procedure TfrmPlanetList.FormDestroy(Sender: TObject);
begin
  inherited;
  FPlanetList.DisposeOf();
end;

procedure TfrmPlanetList.lsvDataItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  LfrmPlanetDetail: TfrmPlanetDetail;
begin
  inherited;
  LfrmPlanetDetail := TfrmPlanetDetail.Create(Self);
  try
    LfrmPlanetDetail.DoFillControls(AItem.TagObject as TPlanet);
    LfrmPlanetDetail.ShowModal();
  finally
    LfrmPlanetDetail.DisposeOf();
  end;
end;

end.
