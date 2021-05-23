unit SWAPI.Classes.Attributes;

interface

type
  SWAPIResourceAttribute = class(TCustomAttribute)
  strict private
    FResource: string;
    function GetResource(): string;
  public
    constructor Create(const AResource: string);
    property Resource: string read GetResource;
  end;

  SWAPIQueryAttribute = class(TCustomAttribute)
  private private
    FQuery: string;
    function GetQuery(): string;
  public
    constructor Create(const AQuery: string);
    property Query: string read GetQuery;
  end;

implementation

{ SWAPIResourceAttribute }

constructor SWAPIResourceAttribute.Create(const AResource: string);
begin
  inherited Create();
  FResource := AResource;
end;

function SWAPIResourceAttribute.GetResource(): string;
begin
  Result := FResource;
end;

{ SWAPIQueryAttribute }

constructor SWAPIQueryAttribute.Create(const AQuery: string);
begin
  inherited Create();
  FQuery := AQuery;
end;

function SWAPIQueryAttribute.GetQuery: string;
begin
  Result := FQuery;
end;

end.
