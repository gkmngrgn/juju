views = require('juju').views


class exports.WelcomeIndexView extends views.TemplateView
    constructor: ->
        @template_name = 'index'
