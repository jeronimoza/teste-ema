unit SWAPI.Forms.BaseList;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, SWAPI.Forms.Base, FMX.Edit,
  System.Actions, FMX.ActnList, FMX.Controls.Presentation, FMX.Layouts, System.Generics.Collections, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  SWAPI.Modules.REST,
  SWAPI.Services, FMX.Objects;

type
  TfrmBaseList = class(TfrmBase)
    lytBottom: TLayout;
    Button1: TButton;
    actNextPage: TAction;
    lytTop: TLayout;
    edtSearch: TEdit;
    SearchEditButton1: TSearchEditButton;
    lytClient: TLayout;
    lsvData: TListView;
    actSearch: TAction;
    procedure aclBaseUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actNextPageExecute(Sender: TObject);
    procedure actSearchExecute(Sender: TObject);
  private
  strict protected
    procedure DoClearDataListView();
  public
    //procedure DoFillDataListView<T: constructor, class>(const AList: TObjectList<T>); virtual; abstract;
    class function InnerShow(const AOwner: TLayout): TfrmBaseList;
    procedure ChangeToListMode();
  end;

var
  frmBaseList: TfrmBaseList;

implementation

{$R *.fmx}

procedure TfrmBaseList.aclBaseUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  inherited;
  actNextPage.Enabled := Assigned(FSWAPIRequest) and (not FSWAPIRequest.NextPage.IsEmpty());
end;

procedure TfrmBaseList.actNextPageExecute(Sender: TObject);
begin
  inherited;
  DoClearDataListView();
end;

procedure TfrmBaseList.actSearchExecute(Sender: TObject);
begin
  inherited;
  FSWAPIRequest.NextPage := EmptyStr;
  DoClearDataListView();
end;

procedure TfrmBaseList.ChangeToListMode();
begin
  lytTop.Visible := False;
  lytBottom.Visible := False;
end;

procedure TfrmBaseList.DoClearDataListView();
begin
  lsvData.Items.Clear();
end;

class function TfrmBaseList.InnerShow(const AOwner: TLayout): TfrmBaseList;
var
  LfrmBaseList: TfrmBaseList;
begin
  LfrmBaseList := Self.Create(AOwner);
  LfrmBaseList.lytContents.Parent := AOwner;
  AOwner.AddObject(LfrmBaseList.lytContents);
  Result := LfrmBaseList;
  //TControl(AOwner.Children.Items[AOwner.Children.IndexOf(LfrmBaseList.lytContents)]).Visible := True;
end;

end.
