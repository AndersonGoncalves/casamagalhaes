program AvaliacaoTecnica;

uses
  Vcl.Forms,
  ufrmPrincipal in 'ufrmPrincipal.pas' {frmPrincipal},
  uConexaoSingleton in 'uConexaoSingleton.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  uDMRest in 'uDMRest.pas' {DMRest: TDataModule},
  uDao in 'uDao.pas',
  uLog in 'uLog.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
