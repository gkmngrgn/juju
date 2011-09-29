management = require '../base'


class exports.Command extends management.BaseCommand
    constructor: ->
        @help = "Starts default Node HTTP Server."
        @error_message = "Ports is not available."
        @params = '[portnumber]'
        @params_count = 1

    run: ->
        params = this.get_params()
        http = require 'http'
        fs = require 'fs'
        html = "#{ __dirname }/../../../conf/default_templates/default.html"
        html = fs.readFileSync(html)
        server = http.createServer (req, res) ->
            res.writeHead 200, { 'Content-Type': 'text/html' }
            res.end html
        server.listen params[0], '127.0.0.1'
        output = """
Server is running at http://127.0.0.1:#{ params[0] }/
Quit the server with CONTROL-C.
        """

        console.log output