find_command = (command) ->
    try
        command_lib = require "#{ __dirname }/commands/#{ command }"
        command = new command_lib.Command
    catch error
        if error.name is 'Error'
            console.log """
                Unknown command: '#{ command }'
                Type 'juju-admin help' for usage.
            """
        else
            console.log error

        process.exit()

    command


print_help = ->
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


print_help_command = (command) ->
    command = find_command command
    console.log command.help


exports.execute = ->
    command = process.argv[2]
    if not command
        print_help()
    else if command is 'help'
        sub_command = process.argv[3]
        if sub_command
            print_help_command sub_command
        else
            print_help()
    else
        command = find_command command
        command.get_version()