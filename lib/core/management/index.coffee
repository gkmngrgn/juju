exports.execute_from_command_line = ->
    command_lib = require "./commands/#{process.argv[2]}"
    command = new command_lib.Command
    command.get_version()