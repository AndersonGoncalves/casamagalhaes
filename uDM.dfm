object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 152
  Width = 272
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    VendorLib = 
      'D:\Projetos\Avalia'#231#227'o T'#233'cnica Casa Magalh'#227'es\Win32\Dados\fbclien' +
      't.dll'
    Left = 179
    Top = 15
  end
  object fdConnection: TFDConnection
    Params.Strings = (
      
        'Database=D:\Projetos\Avalia'#231#227'o T'#233'cnica Casa Magalh'#227'es\Win32\Dado' +
        's\CM.FDB'
      'Server=localhost'
      'User_Name=sysdba'
      'Password=masterkey'
      'Port=3050'
      'CharacterSet=ISO8859_2'
      'DriverID=FB')
    LoginPrompt = False
    BeforeConnect = fdConnectionBeforeConnect
    Left = 30
    Top = 20
  end
  object qQuery: TFDQuery
    Connection = fdConnection
    Left = 95
    Top = 88
  end
  object qPosts: TFDQuery
    Connection = fdConnection
    SQL.Strings = (
      'SELECT * FROM POSTS')
    Left = 31
    Top = 80
    object qPostsID: TIntegerField
      FieldName = 'ID'
      Origin = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object qPostsUSER_ID: TIntegerField
      FieldName = 'USER_ID'
      Origin = 'USER_ID'
      Required = True
    end
    object qPostsTITLE: TStringField
      FieldName = 'TITLE'
      Origin = 'TITLE'
      Size = 255
    end
    object qPostsBODY: TBlobField
      FieldName = 'BODY'
      Origin = 'BODY'
    end
  end
end
