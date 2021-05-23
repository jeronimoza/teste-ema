unit SWAPI.Forms.Base;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions, FMX.ActnList,
  SWAPI.Modules.REST, SWAPI.Services, FMX.StdCtrls, FMX.Objects, FMX.DialogService, FMX.Layouts;

type
  TfrmBase = class(TForm)
    aclBase: TActionList;
    recLoading: TRectangle;
    AniIndicator: TAniIndicator;
    lytContents: TLayout;
    procedure FormCreate(Sender: TObject);
  private
  strict protected
    FdtmREST: TdtmREST;
    FSWAPIRequest: ISWAPIRequest;
    procedure DoShowProcessing();
    procedure DoHideProcessing();
    procedure DoInBackground(const AProc: TProc);
  public
  end;

implementation

{$R *.fmx}

procedure TfrmBase.DoHideProcessing();
begin
  TThread.Synchronize(nil,
    procedure()
    begin
      recLoading.SendToBack();
      recLoading.Visible := False;
      AniIndicator.Enabled := False;
    end);
end;

procedure TfrmBase.DoInBackground(const AProc: TProc);
begin
  DoShowProcessing();
  TThread.CreateAnonymousThread(
    procedure()
    begin
      try
        try
          AProc();
        except
          on LException: Exception do
          begin
            TDialogService.ShowMessage(LException.Message);
          end;
        end;
      finally
        DoHideProcessing();
      end;
    end).Start();
end;

procedure TfrmBase.DoShowProcessing();
begin
  recLoading.BringToFront();
  recLoading.Visible := True;
  AniIndicator.Enabled := True;
end;

procedure TfrmBase.FormCreate(Sender: TObject);
begin
  FdtmREST := TdtmREST.Create(Self);
end;

end.
