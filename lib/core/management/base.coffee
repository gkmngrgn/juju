juju = require '../../juju'


class exports.BaseCommand
    constructor: ->
        @help = ''
        @error_message = ''
        @params = ''
        @params_count = 0

    check_params: ->
        params = this.get_params()
        params.length is @params_count

    get_error_message: ->
        console.log "Error: #{ @error_message }"

    get_params: ->
        process.argv[3..]

    get_version: ->
        version = juju.get_version()
        console.log version