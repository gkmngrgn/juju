juju = require '../../juju'

class exports.BaseCommand
    constructor: ->
        hello = "hello world."

    get_version: ->
        version = juju.get_version()
        console.log version