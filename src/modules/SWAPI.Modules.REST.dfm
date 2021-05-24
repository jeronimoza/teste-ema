object dtmREST: TdtmREST
  OldCreateOrder = False
  Height = 464
  Width = 631
  object RESTClient: TRESTClient
    BaseURL = 'https://swapi.dev/api/'
    Params = <>
    Left = 290
    Top = 160
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    SynchronizedEvents = False
    Left = 288
    Top = 216
  end
  object RESTResponse: TRESTResponse
    Left = 288
    Top = 268
  end
end
