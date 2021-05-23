program SWAPI;

uses
  System.StartUpCopy,
  FMX.Forms,
  SWAPI.Forms.Base in 'forms\SWAPI.Forms.Base.pas' {frmBase},
  SWAPI.Forms.Main in 'forms\SWAPI.Forms.Main.pas' {frmMain},
  SWAPI.Forms.BaseList in 'forms\SWAPI.Forms.BaseList.pas' {frmBaseList},
  SWAPI.Forms.PlanetList in 'forms\SWAPI.Forms.PlanetList.pas' {frmPlanetList},
  SWAPI.Modules.REST in 'modules\SWAPI.Modules.REST.pas' {dtmREST: TDataModule},
  SWAPI.Models in 'models\SWAPI.Models.pas',
  SWAPI.Classes.Attributes in 'classes\SWAPI.Classes.Attributes.pas',
  SWAPI.Services in 'services\SWAPI.Services.pas',
  SWAPI.Forms.BaseDetail in 'forms\SWAPI.Forms.BaseDetail.pas' {frmBaseDetail},
  SWAPI.Forms.PlanetDetail in 'forms\SWAPI.Forms.PlanetDetail.pas' {frmPlanetDetail},
  SWAPI.Forms.PeopleList in 'forms\SWAPI.Forms.PeopleList.pas' {frmPeopleList},
  SWAPI.Forms.PeopleDetail in 'forms\SWAPI.Forms.PeopleDetail.pas' {frmPeopleDetail},
  SWAPI.Forms.FilmList in 'forms\SWAPI.Forms.FilmList.pas' {frmFilmList},
  SWAPI.Forms.FilmDetail in 'forms\SWAPI.Forms.FilmDetail.pas' {frmFilmDetail};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Title := 'The Star Wars API';
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
