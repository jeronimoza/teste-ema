unit SWAPI.Forms.PeopleList;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  SWAPI.Models,
  SWAPI.Services,
  SWAPI.Classes.Attributes, SWAPI.Forms.BaseList, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, System.Actions, FMX.ActnList, FMX.ListView, FMX.Edit, FMX.Controls.Presentation,
  FMX.Layouts, System.Generics.Collections,
  SWAPI.Forms.PeopleDetail, FMX.Objects;

type
  TfrmPeopleList = class(TfrmBaseList)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actNextPageExecute(Sender: TObject);
    procedure actSearchExecute(Sender: TObject);
    procedure lsvDataItemClick(const Sender: TObject; const AItem: TListViewItem);
  private
  private
    FPeopleList: TObjectList<TPeople>;
  public
    procedure DoFillListView(const AList: TObjectList<TPeople>);
  end;

implementation

{$R *.fmx}

procedure TfrmPeopleList.actNextPageExecute(Sender: TObject);
begin
  inherited;
  DoInBackground(
    procedure()
    begin
      FdtmREST.Query<TPeople>(FSWAPIRequest, FPeopleList, EmptyStr);
      TThread.Synchronize(nil,
        procedure()
        begin
          DoFillListView(FPeopleList);
        end);
    end);
end;

procedure TfrmPeopleList.actSearchExecute(Sender: TObject);
begin
  inherited;
  FPeopleList.Clear();
  DoInBackground(
    procedure()
    begin
      FdtmREST.Query<TPeople>(FSWAPIRequest, FPeopleList, edtSearch.Text);
      TThread.Synchronize(nil,
        procedure()
        begin
          DoFillListView(FPeopleList);
        end);
    end);
end;

procedure TfrmPeopleList.DoFillListView(const AList: TObjectList<TPeople>);
var
  LItem: TListViewItem;
  LPeople: TPeople;
begin
  for LPeople in AList do
  begin
    LItem := lsvData.Items.Add();
    LItem.Text := LPeople.name;
    LItem.TagObject := LPeople;
  end;
end;

procedure TfrmPeopleList.FormCreate(Sender: TObject);
begin
  inherited;
  FSWAPIRequest := TSWAPIPeopleRequest.Create();
  FPeopleList := TObjectList<TPeople>.Create();
end;

procedure TfrmPeopleList.FormDestroy(Sender: TObject);
begin
  inherited;
  FPeopleList.DisposeOf();
end;

procedure TfrmPeopleList.lsvDataItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  LfrmPeopleDetail: TfrmPeopleDetail;
begin
  inherited;
  LfrmPeopleDetail := TfrmPeopleDetail.Create(Self);
  try
    LfrmPeopleDetail.DoFillControls(AItem.TagObject as TPeople);
    LfrmPeopleDetail.ShowModal();
  finally
    LfrmPeopleDetail.DisposeOf();
  end;
end;

end.
