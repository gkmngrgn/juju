class TemplateView
    constructor: ->
        @template_name = ''

    get_template_name: ->
        @template_name = 'default' if not @template_name

        "#{ __dirname }/#{ @template_name }.html"

    run: (req, res) ->
        fs = require 'fs'
        template = fs.readFileSync(@get_template_name())