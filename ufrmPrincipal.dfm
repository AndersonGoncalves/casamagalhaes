object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Avalia'#231#227'o T'#233'cnica'
  ClientHeight = 463
  ClientWidth = 692
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    692
    463)
  PixelsPerInch = 96
  TextHeight = 13
  object lblLogImportacao: TLabel
    Left = 8
    Top = 334
    Width = 90
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Log de Importa'#231#227'o'
  end
  object btnCarregaDados: TButton
    Left = 8
    Top = 16
    Width = 129
    Height = 25
    Caption = 'Carregar Dados'
    TabOrder = 0
    OnClick = btnCarregaDadosClick
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 446
    Width = 692
    Height = 17
    Align = alBottom
    TabOrder = 1
  end
  object mmLog: TMemo
    Left = 8
    Top = 353
    Width = 529
    Height = 87
    Anchors = [akLeft, akRight, akBottom]
    ReadOnly = True
    TabOrder = 2
  end
  object btnExibir: TButton
    Left = 555
    Top = 47
    Width = 129
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Exibir'
    TabOrder = 3
    OnClick = btnExibirClick
  end
  object btnAlterar: TButton
    Left = 555
    Top = 78
    Width = 129
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Alterar'
    TabOrder = 4
    OnClick = btnAlterarClick
  end
  object btnExcluir: TButton
    Left = 555
    Top = 109
    Width = 129
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Excluir'
    TabOrder = 5
    OnClick = btnExcluirClick
  end
  object pcPost: TPageControl
    Left = 8
    Top = 47
    Width = 529
    Height = 281
    ActivePage = tbsGrid
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 6
    object tbsGrid: TTabSheet
      Caption = 'Listagem'
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 521
        Height = 253
        Align = alClient
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'ID'
            Width = 42
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'USER_ID'
            Width = 59
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TITLE'
            Width = 383
            Visible = True
          end>
      end
    end
    object tbsDados: TTabSheet
      Caption = 'Dados'
      ImageIndex = 1
      DesignSize = (
        521
        253)
      object lblId: TLabel
        Left = 9
        Top = 7
        Width = 11
        Height = 13
        Caption = 'ID'
      end
      object lblUserId: TLabel
        Left = 9
        Top = 53
        Width = 36
        Height = 13
        Caption = 'User ID'
      end
      object lblTitle: TLabel
        Left = 9
        Top = 101
        Width = 20
        Height = 13
        Caption = 'Title'
      end
      object lblBody: TLabel
        Left = 9
        Top = 149
        Width = 24
        Height = 13
        Caption = 'Body'
      end
      object edtID: TEdit
        Left = 9
        Top = 26
        Width = 50
        Height = 21
        TabOrder = 0
      end
      object edtUserId: TEdit
        Left = 9
        Top = 72
        Width = 50
        Height = 21
        TabOrder = 1
      end
      object edtTitle: TEdit
        Left = 9
        Top = 120
        Width = 499
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
      end
      object mmBody: TMemo
        Left = 9
        Top = 168
        Width = 499
        Height = 73
        Anchors = [akLeft, akTop, akRight, akBottom]
        TabOrder = 3
      end
    end
  end
  object btnOk: TButton
    Left = 555
    Top = 16
    Width = 129
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Ok'
    TabOrder = 7
    OnClick = btnOkClick
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = DM.qPosts
    Left = 624
    Top = 336
  end
end
