unit uConexaoSingleton;

interface

uses System.SysUtils, Vcl.Forms, uDM;

type
  TConecaoSingleton = Class
  private
    procedure Conectar;
  public
    class function Execute: TConecaoSingleton;
  end;

var
  conexaoSingleton: TConecaoSingleton;

implementation

{ TConecaoSingleton }

procedure TConecaoSingleton.Conectar;
begin
  Application.CreateForm(TDM, DM);
end;

class function TConecaoSingleton.Execute: TConecaoSingleton;
begin
  if not Assigned(conexaoSingleton) then
  begin
    conexaoSingleton := TConecaoSingleton.Create;
    conexaoSingleton.Conectar;
  end;
  Result := conexaoSingleton;
end;

end.
