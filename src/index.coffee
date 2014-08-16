# visitors  = require 'react-tools/vendor/fbtransform/visitors'
transform = require 'coffee-react-transform'
coffeescript = require 'coffee-script'

module.exports = class ReactCoffeeCompiler
  brunchPlugin: yes
  type: 'javascript'
  extension: 'cjsx'
  pattern: /\.cjsx/

  constructor: (@config) ->
    @includeHeader= @config?.plugins?.reactCoffee?.autoIncludeCommentBlock is yes
    # @harmony= @config?.plugins?.reactCoffee?.harmony is yes

  compile: (params, callback) ->
    source = if @includeHeader
        "/** @cjsx React.DOM */\n#{ params.data }"
      else
        params.data

    console.log 'aaa'

    # visitorList = if @harmony
        # visitors.getAllVisitors()
      # else
        # visitors.transformVisitors.react

    try
      console.log 'source:', source
      transformed = coffeescript.compile(transform(source))
      console.log 'transformed:', transformed
    catch err
      console.log "ERROR", err
      return callback err.toString()

     callback null, data: transformed
