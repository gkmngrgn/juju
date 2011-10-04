class exports.TemplateView
    constructor: (@app_name) ->
        @app_prefix = null

    get_template_name: ->
        @template_name = "default" if not @template_name
        if @app_prefix
            "#{ @app_prefix }/templates/#{ @template_name }.html"
        else
            "#{ global.PROJECT_DIR }/apps/#{ @app_name }/templates/#{ @template_name }.html"

    run: (req, res) ->
        fs = require 'fs'
        context = fs.readFileSync(@get_template_name())

        res.end context
