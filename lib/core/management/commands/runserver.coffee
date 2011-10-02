command = require('juju').core.management.base
urls = require('juju').urls
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
            port = 8000

        routes = connect(
            connect.router (app) ->
                for url in urls.get_urls()
                    view = new url.view()
                    app.get url.path, (req, res) ->
                        view.run req, res
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