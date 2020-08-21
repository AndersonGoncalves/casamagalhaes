unit ufrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, uDao;

type
  TOperacao = (tpNone, tpExibir, tpAlterar);

  TfrmPrincipal = class(TForm)
    btnCarregaDados: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ProgressBar1: TProgressBar;
    mmLog: TMemo;
    btnExibir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    lblLogImportacao: TLabel;
    pcPost: TPageControl;
    tbsGrid: TTabSheet;
    tbsDados: TTabSheet;
    lblId: TLabel;
    edtID: TEdit;
    edtUserId: TEdit;
    lblUserId: TLabel;
    edtTitle: TEdit;
    lblTitle: TLabel;
    lblBody: TLabel;
    mmBody: TMemo;
    btnOk: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCarregaDadosClick(Sender: TObject);
    procedure btnExibirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    Operacao: TOperacao;
    procedure Reopen;
    procedure HabilitarControles(aHabilitar: Boolean);
    procedure AtivarBotoes(aExibindo: Boolean);
    procedure CarregarControles(aDao: TPostDao);
    procedure Exibir;
    procedure Alterar;
    procedure Salvar;
    procedure Excluir;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses uConexaoSingleton, uDM, uLog;

procedure TfrmPrincipal.Alterar;
var
  dao: TPostDao;
begin
  dao := TPostDao.Create;
  try
    Operacao := tpAlterar;
    dao.Exibir(DM.qPosts.FieldByName('ID').AsInteger);
    CarregarControles(dao);
    HabilitarControles(True);
    AtivarBotoes(True);
    edtTitle.SetFocus;
  finally
    if Assigned(dao) then
      FreeAndNil(dao);
  end;
end;

procedure TfrmPrincipal.btnAlterarClick(Sender: TObject);
begin
  Alterar;
end;

procedure TfrmPrincipal.btnCarregaDadosClick(Sender: TObject);
var
  aErros: TStringList;
begin
  try
    mmLog.Lines.Clear;
    aErros := TStringList.Create;
    DM.CarregarDados(ProgressBar1, aErros);
    mmLog.Lines.Text := aErros.Text;
    Reopen;
  finally
    if Assigned(aErros) then
      FreeAndNil(aErros);
  end;
end;

procedure TfrmPrincipal.btnExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TfrmPrincipal.btnExibirClick(Sender: TObject);
begin
  Exibir;
end;

procedure TfrmPrincipal.btnOkClick(Sender: TObject);
begin
  Salvar;
end;

procedure TfrmPrincipal.CarregarControles(aDao: TPostDao);
begin
  edtID.Text     := aDao.Post.ID.ToString();
  edtUserId.Text := aDao.Post.UserID.ToString();
  edtTitle.Text  := aDao.Post.Title;
  mmBody.Text    := aDao.Post.Body;
end;

procedure TfrmPrincipal.Excluir;
var
  dao: TPostDao;
begin
  dao := TPostDao.Create;
  try
    if Application.MessageBox('Deseja excluir o registro?', 'Atenção', MB_YESNO) = IDYES then
    begin
      dao.Excluir(DM.qPosts.FieldByName('ID').AsInteger);
      Reopen;
    end;
  finally
    if Assigned(dao) then
      FreeAndNil(dao);
  end;
end;

procedure TfrmPrincipal.Exibir;
var
  dao: TPostDao;
begin
  dao := TPostDao.Create;
  try
    Operacao := tpExibir;
    dao.Exibir(DM.qPosts.FieldByName('ID').AsInteger);
    CarregarControles(dao);
    HabilitarControles(False);
    AtivarBotoes(True);
  finally
    if Assigned(dao) then
      FreeAndNil(dao);
  end;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Operacao := tpNone;
  AtivarBotoes(False);
  TConecaoSingleton.Execute;
end;

procedure TfrmPrincipal.AtivarBotoes(aExibindo: Boolean);
begin
  if Operacao = tpAlterar then
    btnOk.Caption := 'Salvar'
  else
    btnOk.Caption := 'OK';

  tbsGrid.TabVisible      := not aExibindo;
  tbsDados.TabVisible     := aExibindo;
  btnOk.Visible           := aExibindo;
  btnExibir.Visible       := not aExibindo;
  btnAlterar.Visible      := not aExibindo;
  btnExcluir.Visible      := not aExibindo;
  btnCarregaDados.Enabled := not aExibindo;
end;

procedure TfrmPrincipal.HabilitarControles(aHabilitar: Boolean);
begin
  for var I: integer := 0 to tbsDados.ControlCount - 1 do
  begin
    if tbsDados.Controls[I] is TControl then
      (tbsDados.Controls[I] as TControl).Enabled := aHabilitar;
  end;
  edtID.Enabled := False;
  edtUserId.Enabled := False;
end;

procedure TfrmPrincipal.Reopen;
begin
  DM.qPosts.Close;
  DM.qPosts.Open;
end;

procedure TfrmPrincipal.Salvar;
var
  dao: TPostDao;
begin
  dao := TPostDao.Create;
  try
    if Operacao = tpAlterar then
    begin
      dao.Alterar(StrToInt(edtID.Text), edtTitle.Text, mmBody.Text);
      Sleep(100);//Para evitar concorrência com a TThread
      Reopen;
    end;
    Operacao := tpNone;
    AtivarBotoes(False);
  finally
    if Assigned(dao) then
      FreeAndNil(dao);
  end;
end;

end.
