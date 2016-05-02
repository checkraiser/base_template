# This class stores instructions till the instructions are ready to be processed
# The typical use case is for AngularJS directives
#
# 1. Problem:
# The controller needs to call a function of an AngularJS directive
# AngularJS currently does not provide a way to do this
#
# 2. Solution:
# a. Declare an instance of this InstructionPipe class in the controller
# b. Pass the instance to the directive
# c. In the directive, do :
#   $scope.set_processing_function (function_name, parameters)->
#     if function_name = ... do something
#
# This ensures that instructions are processed by the directive
# once the directive is initialized and ready to process instructions
class window.InstructionPipe
  constructor: ()->
    @instructions = []
    @processing_function = null

  # store the instruction and parameters
  send: (function_name, parameters = {})->
    @instructions.push({function_name: function_name, parameters: parameters})
    @process()

  # process instructions if the processing_function has been defined
  process: ()->
    return if @processing_function == null
    while @instructions.length > 0
      instruction = @instructions.pop()
      @processing_function(instruction.function_name, instruction.parameters)

  # define the processing_function and process any instructions
  set_processing_function: (processing_function)->
    @processing_function = processing_function
    @process()