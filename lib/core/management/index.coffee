help = ->
    fs = require 'fs'
    file_list = fs.readdirSync("#{ __dirname }/commands")
    commands = ("  #{c.split('.')[0]}" for c in file_list)

    response =  """
        Usage: juju-admin subcommand [args]
        Type 'juju-admin help <subcommand>' for help on a specific subcommand.

        Available subcommands:

    """
    response += commands.join('\n')
    console.log response


exports.execute = ->
    arg = process.argv[2]
    if not arg
        help()
    else
        try
            command_lib = require "./commands/#{arg}"
            command = new command_lib.Command
            command.get_version()
        catch error
            if error.name is 'Error'
                console.log """
                    Unknown command: '#{ arg }'
                    Type 'juju-admin help' for usage.
                """
            else
                console.log error