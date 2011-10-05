{spawn, exec} = require("child_process")

bold  = "\033[0;1m"
red   = "\033[0;31m"
green = "\033[0;32m"
reset = "\033[0m"

log = (message, color, explanation) ->
    console.log color + message + reset + ' ' + (explanation or '')

onerror = (err)->
    if err
        process.stdout.write "#{ red }#{ err.stack }#{ reset }\n"
        process.exit -1

build = (callback) ->
    log "Compiling CoffeeScript to JavaScript ...", green
    exec "rm -rf lib.o && coffee -c -l -b -o lib.o lib", callback

task "build", "Compile CoffeeScript to JavaScript", -> build onerror