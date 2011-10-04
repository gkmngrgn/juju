views = require('juju').views


class exports.WelcomeIndexView extends views.TemplateView
    constructor: ->
        @app_prefix = __dirname
        @template_name = 'index'
