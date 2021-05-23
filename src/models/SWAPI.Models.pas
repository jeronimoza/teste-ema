unit SWAPI.Models;

interface

type
  TPeople = class
  private
    Fname: string;
    Fgender: string;
    Ffilms: TArray<string>;
    Fbirth_year: string;
  protected
    Fvehicles: TArray<string>;
    Fstarships: TArray<string>;
    Fspecies: TArray<string>;
  public
    property name: string read Fname write Fname;
    property birth_year: string read Fbirth_year write Fbirth_year;
    property gender: string read Fgender write Fgender;
    property films: TArray<string> read Ffilms write Ffilms;
  end;

  TPlanet = class
  private
    Fname: string;
    Frotation_period: string;
    Fresidents: TArray<string>;
    Ffilms: TArray<string>;
    Fpopulation: string;
    Fclimate: string;
    Forbital_period: string;
    Fdiameter: string;
  public
    property name: string read Fname write Fname;
    property rotation_period: string read Frotation_period write Frotation_period;
    property orbital_period: string read Forbital_period write Forbital_period;
    property diameter: string read Fdiameter write Fdiameter;
    property climate: string read Fclimate write Fclimate;
    property population: string read Fpopulation write Fpopulation;
    property residents: TArray<string> read Fresidents write Fresidents;
    property films: TArray<string> read Ffilms write Ffilms;
  end;

  TFilm = class
  private
    Fstarships: TArray<string>;
    Fepisode_id: Integer;
    Fplanets: TArray<string>;
    Fspecies: TArray<string>;
    Ftitle: string;
    Fcharacters: TArray<string>;
    Fopening_crawl: string;
    Frelease_date: string;
    Fvehicles: TArray<string>;
  public
    property title: string read Ftitle write Ftitle;
    property episode_id: Integer read Fepisode_id write Fepisode_id;
    property opening_crawl: string read Fopening_crawl write Fopening_crawl;
    property release_date: string read Frelease_date write Frelease_date;
    property characters: TArray<string> read Fcharacters write Fcharacters;
    property planets: TArray<string> read Fplanets write Fplanets;
    property starships: TArray<string> read Fstarships write Fstarships;
    property vehicles: TArray<string> read Fvehicles write Fvehicles;
    property species: TArray<string> read Fspecies write Fspecies;
  end;

implementation

end.
