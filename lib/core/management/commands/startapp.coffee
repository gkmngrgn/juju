command = require('juju').core.management.base
path = require 'path'

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
            try
                src = "#{ __dirname }/../../../conf/app_template"
                dst = path.join 'apps', params[0]
                command.copy_files src, dst

            catch error
                console.log error.message