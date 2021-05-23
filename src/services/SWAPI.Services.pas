unit SWAPI.Services;

interface

uses
  System.Rtti,
  SWAPI.Classes.Attributes,
  System.Generics.Collections;

type
  ISWAPIRequest = interface
    ['{DEB01A85-92B1-4856-BFD8-757BECE19275}']
    function GetNextPage(): string;
    procedure SetNextPage(const AValue: string);
    function GetResource(): string;
    function GetQuery(): string;
    property NextPage: string read GetNextPage write SetNextPage;
    property Resouce: string read GetResource;
    property Query: string read GetQuery;
  end;

  TSWAPIRequest = class(TInterfacedObject)
  strict private
    FNextPage: string;
    FContext: TRttiContext;
  strict protected
    function GetNextPage(): string;
    procedure SetNextPage(const AValue: string);
    function GetResource(): string;
    function GetQuery(): string;
  public
    constructor Create();
    destructor Destroy(); override;
  end;

  [SWAPIResource('planets/')]
  [SWAPIQuery('?search=%s&search_fields=name&search_fields=population&search_fields=climate')]
  TSWAPIPlanetRequest = class(TSWAPIRequest, ISWAPIRequest)
  end;

  [SWAPIResource('people/')]
  [SWAPIQuery('?search=%s&search_fields=gender&search_fields=name')]
  TSWAPIPeopleRequest = class(TSWAPIRequest, ISWAPIRequest)
  end;

  [SWAPIResource('films/')]
  [SWAPIQuery('?search=%s&search_fields=title&search_fields=release_date')]
  TSWAPIFilmRequest = class(TSWAPIRequest, ISWAPIRequest)
  end;

implementation

{ TSWAPIRequest }

constructor TSWAPIRequest.Create();
begin
  inherited Create();
  FContext := TRttiContext.Create();
end;

destructor TSWAPIRequest.Destroy();
begin
  FContext.Free();
  inherited Destroy();
end;

function TSWAPIRequest.GetNextPage(): string;
begin
  Result := FNextPage;
end;

function TSWAPIRequest.GetQuery(): string;
var
  LRttiType: TRttiType;
  LAttribute: TCustomAttribute;
begin
  LRttiType := FContext.GetType(Self.ClassType);
  try
    for LAttribute in LRttiType.GetAttributes() do
    begin
      if (LAttribute is SWAPIQueryAttribute) then
      begin
        Result := SWAPIQueryAttribute(LAttribute).Query;
        Break;
      end;
    end;
  finally
    LRttiType.Free();
  end;
end;

function TSWAPIRequest.GetResource(): string;
var
  LRttiType: TRttiType;
  LAttribute: TCustomAttribute;
begin
  LRttiType := FContext.GetType(Self.ClassType);
  try
    for LAttribute in LRttiType.GetAttributes() do
    begin
      if (LAttribute is SWAPIResourceAttribute) then
      begin
        Result := SWAPIResourceAttribute(LAttribute).Resource;
        Break;
      end;
    end;
  finally
    LRttiType.Free();
  end;
end;

procedure TSWAPIRequest.SetNextPage(const AValue: string);
begin
  FNextPage := AValue;
end;

end.
