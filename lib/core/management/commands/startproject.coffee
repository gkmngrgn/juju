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
        params = @get_params()

        if not params.length
            console.log 'Please define a project name.'
            process.exit(1)

        fs = require 'fs'
        path = require 'path'

        try
            src = "#{ __dirname }/../../../conf/project_template"
            dst = params[0]

            command.copy_files src, dst
            for dir in ['apps', 'logs', 'pids', 'static']
                fs.mkdirSync path.join(dst, dir), 0755

        catch error
            console.log error.message