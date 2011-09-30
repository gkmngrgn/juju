find_command = (command) ->
    try
        command_lib = require "./commands/#{ command }"
        command = new command_lib.Command
    catch error
        if error.name is 'Error'
            console.log """
                Unknown command: '#{ command }'
                Type 'juju help' for usage.
            """
        else
            console.log error

        process.exit()

    command


print_help = ->
    fs = require 'fs'
    file_list = fs.readdirSync("./commands")
    commands = ("  #{c.split('.')[0]}" for c in file_list)

    response =  """
        Usage: juju subcommand [args]
        Type 'juju help <subcommand>' for help on a specific subcommand.

        Available subcommands:

    """
    response += commands.join('\n')
    console.log response


print_help_command = (arg) ->
    command = find_command arg
    output = """
        Usage: juju #{ arg } #{ command.params }

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
    else if arg is '--version'
        juju = require '../../juju'
        console.log juju.get_version()
    else
        command = find_command arg
        command.run()