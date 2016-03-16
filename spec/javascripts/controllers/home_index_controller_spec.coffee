describe "home_index_controller", ->
  scope        = null
  ctrl         = null
  gon.message = "Hello World 2"
  setupController =()->
    inject(($rootScope, $controller)->
      scope       = $rootScope.$new()
      ctrl        = $controller('home_index_controller',
                                $scope: scope)
    )

  beforeEach(module("app"))
  beforeEach(setupController())

  it "Render Hello World 2", ->
    expect(scope.message).toBe('Hello World 2')