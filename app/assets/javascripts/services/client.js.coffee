app.factory 'Client', ['BaseModel', (BaseModel) ->
  self = BaseModel.new("client", "/clients", ["id"])
  self.index = []
  self.init = (clients)->
    self.index = clients

  return self
]
