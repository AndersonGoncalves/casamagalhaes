unit uLog;

interface

uses
  System.Classes, System.SysUtils;

type
  TLog = class
  public
    class procedure Execute(aMsg: string);
  end;

implementation

{ TLog }

class procedure TLog.Execute(aMsg: string);
var
  Arquivo: TextFile;
  nomeArquivo: string;
begin
  nomeArquivo := 'Log.txt';
  AssignFile(Arquivo, nomeArquivo);
  try
    if (fileexists(nomeArquivo)) then
      Append(Arquivo)
    else
      Rewrite(Arquivo);
    Writeln(Arquivo, aMsg);
  finally
    Closefile(Arquivo);
  end;
end;

end.
