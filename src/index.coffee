transform    = require 'coffee-react-transform'
coffeescript = require 'coffee-script'

module.exports = class ReactCoffeeCompiler
  brunchPlugin: yes
  type: 'javascript'
  extension: 'cjsx'
  pattern: /\.cjsx/

  constructor: (@config) ->
    @includeHeader= @config?.plugins?.reactCoffee?.autoIncludeCommentBlock is yes

  compile: (params, callback) ->
    source = if @includeHeader
        "/** @cjsx React.DOM */\n#{ params.data }"
      else
        params.data

    try
      transformed = coffeescript.compile transform(source), bare: true
    catch err
      console.log "ERROR: ", err
      return callback err.toString()

    callback null, data: transformed
