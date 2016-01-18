program Counter;

uses
  Forms, Windows,
  UMain in 'UMain.pas' {MainFrm},
  UTray in 'UTray.pas' {TryFrm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Benbac Internet Counter';
  Application.CreateForm(TTryFrm, TryFrm);
  Application.Run;
end.
