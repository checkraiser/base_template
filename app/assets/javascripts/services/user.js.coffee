app.factory 'User', ['BaseModel', (BaseModel) ->
  self = BaseModel.new("user", "/users", ["id"])
  self.index = []
  self.init = (users)->
    self.index = users

  return self
]
