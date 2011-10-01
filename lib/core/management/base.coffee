juju = require 'juju'


class exports.BaseCommand
    constructor: ->
        @help = ''
        @params = ''
        @params_count = 0

    check_params: ->
        params = this.get_params()
        params.length is @params_count

    get_params: ->
        process.argv[3..]

    get_version: ->
        version = juju.get_version()
        console.log version