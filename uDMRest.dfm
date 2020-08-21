object DMRest: TDMRest
  OldCreateOrder = False
  Height = 278
  Width = 269
  object RESTClient1: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://jsonplaceholder.typicode.com/posts'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 112
    Top = 16
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    SynchronizedEvents = False
    Left = 112
    Top = 64
  end
  object RESTResponse1: TRESTResponse
    ContentType = 'application/json'
    Left = 112
    Top = 112
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Active = True
    Dataset = FDMemTable1
    FieldDefs = <>
    Response = RESTResponse1
    NestedElements = True
    Left = 112
    Top = 160
  end
  object FDMemTable1: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'userId'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'title'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'body'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 112
    Top = 208
    object FDMemTable1userId: TWideStringField
      FieldName = 'userId'
      Size = 255
    end
    object FDMemTable1id: TWideStringField
      FieldName = 'id'
      Size = 255
    end
    object FDMemTable1title: TWideStringField
      FieldName = 'title'
      Size = 255
    end
    object FDMemTable1body: TWideStringField
      FieldName = 'body'
      Size = 255
    end
  end
end
