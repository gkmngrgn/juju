views = require('juju').views


class WelcomeIndexView extends views.TemplateView
    constructor: ->
        @template_name = 'index'