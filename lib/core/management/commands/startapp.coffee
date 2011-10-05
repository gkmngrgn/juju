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
        params = @get_params()
        if not global.PROJECT_DIR
            console.log 'Create a project with `startproject` at first.'
        else if not params.length
            console.log 'Enter at least one application name.'
        else
            fs = require 'fs'
            path = require 'path'

            try
                tmp_path = "#{ __dirname }/../../../conf/app_template"
                app_name = path.join 'apps', params[0]

                fs.mkdirSync app_name, 0755
                fs.mkdirSync path.join(app_name, 'templates'), 0755
                files = fs.readdirSync tmp_path
                for file in files
                    data = fs.readFileSync "#{ tmp_path }/#{ file }"
                    fs.writeFile "#{ app_name }/#{ file }", data, (err) ->
                        throw err if err

            catch error
                console.log error.message