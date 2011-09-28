management = require '../base'

class exports.Command extends management.BaseCommand
    constructor: ->
        @help = """
Creates a JuJu project directory structure for the given project name in the
current directory.
        """