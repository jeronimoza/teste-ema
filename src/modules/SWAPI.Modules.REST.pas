unit SWAPI.Modules.REST;

interface

uses
  System.SysUtils,
  System.Classes,
  REST.Types,
  REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  System.Generics.Collections,
  System.JSON,
  REST.Json,
  System.Rtti,
  SWAPI.Classes.Attributes,
  SWAPI.Services;

type
  TdtmREST = class(TDataModule)
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
  strict private
    const BASE_URL = 'https://swapi.dev/api/';
      procedure Query<T: constructor, class>(const ARequest: ISWAPIRequest; const AList: TObjectList<T>); overload;
  public
    procedure Query<T: constructor, class>(const ARequest: ISWAPIRequest; const AList: TObjectList<T>;
      const AQuery: string); overload;
    procedure Query<T: constructor, class>(const ARequest: ISWAPIRequest; const AList: TObjectList<T>;
      const ARequestList: TArray<string>); overload;
  end;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TdtmREST }

procedure TdtmREST.Query<T>(const ARequest: ISWAPIRequest; const AList: TObjectList<T>;
  const AQuery: string);
begin
  RESTClient.ResetToDefaults();
  RESTRequest.ResetToDefaults();
  RESTResponse.ResetToDefaults();
  if ARequest.NextPage.IsEmpty() then
  begin
    RESTClient.BaseURL := BASE_URL;
    RESTRequest.Resource := ARequest.Resouce;
    if (not AQuery.IsEmpty()) then
      RESTRequest.Resource := RESTRequest.Resource + Format(ARequest.Query, [AQuery]);
  end
  else
  begin
    RESTClient.BaseURL := ARequest.NextPage;
  end;
  Query<T>(ARequest, AList);
end;

procedure TdtmREST.Query<T>(const ARequest: ISWAPIRequest; const AList: TObjectList<T>;
  const ARequestList: TArray<string>);
var
  LRequest: string;
begin
  RESTClient.ResetToDefaults();
  RESTRequest.ResetToDefaults();
  RESTResponse.ResetToDefaults();
  for LRequest in ARequestList do
  begin
    RESTClient.BaseURL := LRequest;
    Query<T>(ARequest, AList);
  end;
end;

procedure TdtmREST.Query<T>(const ARequest: ISWAPIRequest; const AList: TObjectList<T>);
var
  LJSONObject: TJSONObject;
  LJSONValue: TJSONValue;
begin
  RESTRequest.Execute();
  if (not RESTRequest.Response.Status.Success()) then
    raise Exception.Create(RESTResponse.Content);

  LJSONObject := (TJSONObject.ParseJSONValue(RESTResponse.Content) as TJSONObject);
  try
    if Assigned(LJSONObject.GetValue('next')) then
      ARequest.NextPage := LJSONObject.GetValue('next').AsType<string>;

    if Assigned(LJSONObject.GetValue('results')) then
    begin
      for LJSONValue in (LJSONObject.GetValue('results').AsType<TJSONArray>) do
        AList.Add(TJson.JsonToObject<T>(LJSONValue.ToString()));
    end
    else
    begin
       AList.Add(TJson.JsonToObject<T>(LJSONObject.ToString()));
    end;
  finally
    LJSONObject.DisposeOf();
  end;
end;

end.
