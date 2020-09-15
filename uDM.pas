unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.FBDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, System.StrUtils,
  FireDAC.Comp.Client, FireDAC.Phys.IBBase, Vcl.ComCtrls, Vcl.Dialogs, Vcl.Forms;

type
  TDM = class(TDataModule)
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    fdConnection: TFDConnection;
    qQuery: TFDQuery;
    qPosts: TFDQuery;
    qPostsID: TIntegerField;
    qPostsUSER_ID: TIntegerField;
    qPostsTITLE: TStringField;
    qPostsBODY: TBlobField;
    procedure DataModuleCreate(Sender: TObject);
    procedure fdConnectionBeforeConnect(Sender: TObject);
  private
    function ExitePost(aId: Integer): Boolean;
    procedure SalvarDados(aId, aIdUsuario: integer; aTitle, aBody: string; var aErro: string);
  public
    procedure CarregarDados(aProgressBar: TProgressBar; var aFeedBacks: TStringList);
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses uDMRest;

{$R *.dfm}

procedure TDM.CarregarDados(aProgressBar: TProgressBar; var aFeedBacks: TStringList);
var
  aErro: string;
begin
  //branch
  dmRest.RESTRequest1.Execute;

  aProgressBar.Position := 0;
  aProgressBar.Max := dmRest.FDMemTable1.RecordCount;

  dmRest.FDMemTable1.First;
  while not dmRest.FDMemTable1.Eof do
  begin
    try
      if ExitePost(dmRest.FDMemTable1.FieldByName('ID').AsInteger) then
        aFeedBacks.Add('Post: ' + dmRest.FDMemTable1.FieldByName('ID').AsString + ' (Já existe na base de dados)')
      else
      begin
        DM.SalvarDados(dmRest.FDMemTable1.FieldByName('ID').AsInteger,
                       dmRest.FDMemTable1.FieldByName('USERID').AsInteger,
                       dmRest.FDMemTable1.FieldByName('TITLE').AsString,
                       dmRest.FDMemTable1.FieldByName('BODY').AsString, aErro);

        if aErro = EmptyStr then
          aFeedBacks.Add('Post: ' + dmRest.FDMemTable1.FieldByName('ID').AsString + ' (Importado com sucesso)')
        else
          aFeedBacks.Add('Erro ao importar post: ' + dmRest.FDMemTable1.FieldByName('ID').AsString + ' (' + aErro + ')');
      end;
    except
    end;
    aProgressBar.Position := aProgressBar.Position + 1;
    dmRest.FDMemTable1.Next;
  end;

  showmessage('Dados carregados!');
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  Application.CreateForm(TDMRest, DMRest);
  fdConnection.Connected := True;
  qPosts.Open;
end;

function TDM.ExitePost(aId: Integer): Boolean;
begin
  qQuery.Active := False;
  qQuery.SQL.Text := 'SELECT ID FROM POSTS WHERE ID = ' + IntToStr(aId);
  qQuery.Open();
  Result := not qQuery.IsEmpty;
end;

procedure TDM.fdConnectionBeforeConnect(Sender: TObject);
begin
  FDConnection.Params.Values['Database'] := ExtractFileDir(GetCurrentDir) + '\Dados\CM.fdb';
end;

procedure TDM.SalvarDados(aId, aIdUsuario: integer; aTitle, aBody: string; var aErro: string);
begin
  try
    qQuery.Close;
    qQuery.SQL.Text := 'INSERT INTO POSTS VALUES ( '+
                        IntToStr(aId)         + ', '+
                        IntToStr(aIdUsuario)  + ', '+
                        QuotedStr(aTitle)     + ', '+
                        QuotedStr(aBody)      +')';
    qQuery.ExecSQL;
  except on E: Exception do
    aErro := E.Message;
  end;
end;

end.
