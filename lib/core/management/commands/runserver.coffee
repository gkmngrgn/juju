command = require('juju').core.management.base
urls = require('juju').urls
connect = require 'connect'
path = require 'path'


class exports.Command extends command.BaseCommand
    constructor: ->
        @help = "Starts default Node HTTP Server."
        @params = '[portnumber]'
        @params_count = 1

    static: (req, res, next) ->
        options =
            root: global.STATIC_DIR
            path: req.url.replace '/static/', '/'
            getOnly: true

        req_path = path.normalize(path.join global.PROJECT_DIR, req.url)
        if req_path[..global.STATIC_DIR.length - 1] isnt global.STATIC_DIR
            options.root = ''

        connect.static.send req, res, next, options

    run: ->
        if not global.PROJECT_DIR
            console.log 'Create a project with `startproject` at first.'
            process.exit(1)

        params = @get_params()
        if params.length
            port = params[0]
        else
            port = 8000

        routes = connect(
            connect.router (app) ->
                for url in urls.get_urls()
                    app_name = url.name.split('.')[0]
                    view = new url.view(app_name)
                    app.get url.path, (req, res) ->
                        view.run req, res
        )
        try
            server = connect(connect.logger(), routes, @static)
            server.listen(port)
            console.log """
Server is running at http://127.0.0.1:#{ port }/
Quit the server with CONTROL-C.
            """
        catch error
            console.log error.message