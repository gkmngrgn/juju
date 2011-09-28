management_base = require '../base'

class exports.Command extends management_base.BaseCommand
    get_version: ->
        super '1.1.2'