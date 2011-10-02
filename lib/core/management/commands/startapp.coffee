command = require('juju').core.management.base


class exports.Command extends command.BaseCommand
    constructor: ->
        @help = """
Creates a Django app directory structure for the given app name in this
project's directory.
        """
        @params = '[appname]'
        @params_count = 1


    run: ->
        fs = require 'fs'
        params = @get_params()

        if not params.length
            console.log 'Enter at least one application name.'
        else
            try
                path = "#{ __dirname }/../../../conf/app_template"
                app_name = params[0]

                fs.mkdirSync app_name, 0755
                files = fs.readdirSync path
                for file in files
                    data = fs.readFileSync "#{ path }/#{ file }"
                    fs.writeFile "#{ app_name }/#{ file }", data, (err) ->
                        throw err if err

            catch error
                console.log error.message