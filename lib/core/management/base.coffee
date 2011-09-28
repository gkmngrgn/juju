juju = require '../../juju'

class exports.BaseCommand
    constructor: ->
        @help = ""

    get_version: ->
        version = juju.get_version()
        console.log version