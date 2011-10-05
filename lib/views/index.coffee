class exports.TemplateView
    constructor: (@app_name) ->
        @app_prefix = null
        @context_data =
            juju_appname: @app_name
            juju_viewname: @constructor.name

    get_context_data: ->
        @context_data

    get_template_name: ->
        if not @template_name
            @template_name = @constructor.name.toLowerCase()

        if @app_prefix
            "#{ @app_prefix }/templates/#{ @template_name }.jade"
        else
            "#{ global.PROJECT_DIR }/apps/#{ @app_name }/templates/#{ @template_name }.jade"

    run: (req, res) ->
        jade = require 'jade'
        context_data = @get_context_data()
        template = require('fs').readFileSync @get_template_name(), 'utf8'
        context = jade.compile template

        res.end context context_data