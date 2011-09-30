management = require '../base'

class exports.Command extends management.BaseCommand
    constructor: ->
        @help = """
Creates a JuJu project directory structure for the given project name in the
current directory.
        """
        @params = '[projectname]'
        @params_count = 1

    run: ->
        fs = require 'fs'
        params = this.get_params()

        if not params.length
            console.log 'Please define a project name.'
        else
            try
                fs.mkdirSync params[0], 0755
            catch error
                console.log error