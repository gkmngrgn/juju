command = require('juju').core.management.base


class exports.Command extends command.BaseCommand
    constructor: ->
        @help = """
Creates a JuJu project directory structure for the given project name in the
current directory.
        """
        @params = '[projectname]'
        @params_count = 1

    run: ->
        fs = require 'fs'
        path = require 'path'
        params = @get_params()

        if not params.length
            console.log 'Please define a project name.'
        else
            try
                tmp_path = "#{ __dirname }/../../../conf/project_template"
                project_path = params[0]

                fs.mkdirSync params[0], 0755
                for dir in ['apps', 'logs', 'pids', 'static']
                    fs.mkdirSync path.join(project_path, dir), 0755

                files = fs.readdirSync tmp_path
                for file in files
                    data = fs.readFileSync "#{ tmp_path }/#{ file }"
                    fs.writeFile "#{ project_path }/#{ file }", data, (err) ->
                        throw err if err

            catch error
                console.log error.message