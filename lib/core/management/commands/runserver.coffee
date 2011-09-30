management = require '../base'


class exports.Command extends management.BaseCommand
    constructor: ->
        @help = "Starts default Node HTTP Server."
        @params = '[portnumber]'
        @params_count = 1

    run: ->
        params = this.get_params()
        if params.length
            port = params[0]
        else
            port = '8000'

        http = require 'http'
        fs = require 'fs'
        path = "#{ __dirname }/../../../conf/default_templates/default.html"
        html = fs.readFileSync(path)
        server = http.createServer (req, res) ->
            res.writeHead 200, { 'Content-Type': 'text/html' }
            res.end html

        try
            server.listen port, '127.0.0.1'
            console.log """
Server is running at http://127.0.0.1:#{ port }/
Quit the server with CONTROL-C.
            """
        catch error
            console.log error.message