command = require('juju').core.management.base
connect = require 'connect'


class exports.Command extends command.BaseCommand
    constructor: ->
        @help = "Starts default Node HTTP Server."
        @params = '[portnumber]'
        @params_count = 1

    run: ->
        params = @get_params()
        if params.length
            port = params[0]
        else
            port = '8000'

        routes = connect(connect.router (app) ->
            app.get '/', (req, res) ->
                res.end 'hello world'

            app.get '/hello', (req, res) ->
                res.end 'world!'
        )

        try
            server = connect(connect.logger(), routes)
            server.listen(port)
            console.log """
Server is running at http://127.0.0.1:#{ port }/
Quit the server with CONTROL-C.
            """
        catch error
            console.log error.message