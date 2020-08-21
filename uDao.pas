unit uDao;

interface

uses
  System.SysUtils, System.Classes;

type
  TPost = class
  private
    FID     : Integer;
    FUserID : Integer;
    FTitle  : String;
    FBody   : String;
    procedure SetBody(const Value: String);
    procedure SetID(const Value: Integer);
    procedure SetTitle(const Value: String);
    procedure SetUserID(const Value: Integer);
  public
    property ID     : Integer read FID     write SetID;
    property UserID : Integer read FUserID write SetUserID;
    property Title  : String  read FTitle  write SetTitle;
    property Body   : String  read FBody   write SetBody;
  end;

  TPostDao = class
  private
    FPost: TPost;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Exibir(aId: integer);
    procedure Alterar(aId: integer; aTitulo, aBody: string);
    procedure Excluir(AId: integer);
    property Post: TPost read FPost write FPost;
  end;

implementation

{ TPost }

uses uDM, uLog;

procedure TPost.SetBody(const Value: String);
begin
  FBody := Value;
end;

procedure TPost.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TPost.SetTitle(const Value: String);
begin
  FTitle := Value;
end;

procedure TPost.SetUserID(const Value: Integer);
begin
  FUserID := Value;
end;

{ TPostDao }

constructor TPostDao.Create;
begin
  FPost := TPost.Create;
end;

destructor TPostDao.Destroy;
begin
  if Assigned(FPost) then
    FreeAndNil(FPost);

  inherited;
end;

procedure TPostDao.Alterar(aId: integer; aTitulo, aBody: string);
begin
  try
    TThread.CreateAnonymousThread(procedure
    begin
      DM.qQuery.Close;
      DM.qQuery.SQL.Text := 'UPDATE POSTS SET TITLE = ' +QuotedStr(aTitulo)+ ', BODY = ' + QuotedStr(aBody) + ' WHERE ID = ' + IntToStr(aId);
      DM.qQuery.ExecSQL;

      Sleep(100);
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLog.Execute('Registro: ' + aId.ToString() + ' Alterado.');
      end);
    end).Start;
  except on E:Exception do
    raise Exception.Create('Falha ao alterar registro');
  end;
end;

procedure TPostDao.Excluir(AId: integer);
begin
  try
    TThread.CreateAnonymousThread(procedure
    begin
      DM.qQuery.Close;
      DM.qQuery.SQL.Text := 'DELETE FROM POSTS WHERE ID = ' + IntToStr(aId);
      DM.qQuery.ExecSQL;

      Sleep(500);
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        TLog.Execute('Registro: ' + aId.ToString() + ' Excluído.');
      end);
    end).Start;
  except on E:Exception do
    raise Exception.Create('Falha ao excluir registro');
  end;
end;

procedure TPostDao.Exibir(aId: integer);
begin
  try
    DM.qQuery.Close;
    DM.qQuery.SQL.Text := 'SELECT * FROM POSTS WHERE ID = ' + IntToStr(aId);
    DM.qQuery.Open;

    FPost.FID     := DM.qQuery.FieldByName('ID').AsInteger;
    FPost.FUserID := DM.qQuery.FieldByName('USER_ID').AsInteger;
    FPost.FTitle  := DM.qQuery.FieldByName('TITLE').AsString;
    FPost.FBody   := DM.qQuery.FieldByName('BODY').AsString;
  except on E:Exception do
    raise Exception.Create('Falha ao carregar dados');
  end;
end;

end.
