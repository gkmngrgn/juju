class exports.TemplateView
    get_template_name: ->
        @template_name = "default" if not @template_name
        "./templates/#{ @template_name }.html"

    run: (req, res) ->
        fs = require 'fs'
        context = fs.readFileSync(@get_template_name())

        res.end context