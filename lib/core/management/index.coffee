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


print_help_command = (arg) ->
    command = find_command arg
    output = """
        Usage: juju-admin #{ arg } #{ command.params }

        #{ command.help }
    """
    console.log output


exports.execute = ->
    arg = process.argv[2]
    if not arg
        print_help()
    else if arg is 'help'
        sub_command = process.argv[3]
        if sub_command
            print_help_command sub_command
        else
            print_help()
    else
        command = find_command arg
        if command.check_params()
            command.run()
        else
            command.get_error_message()
            print_help_command arg