views = require('juju').views


class exports.WelcomeIndexView extends views.TemplateView
    constructor: ->
        super

        @app_prefix = __dirname
        @template_name = 'index'

    get_context_data: ->
        context_data = super
        context_data['project_name'] = 'Juju'

        context_data
