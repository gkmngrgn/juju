juju = require 'juju'
fs = require 'fs'
path = require 'path'


exports.copy_files = (src, dst) ->
    items = fs.readdirSync src
    fs.mkdirSync dst, 0755

    for item in items
        try
            data = fs.readFileSync "#{ src }/#{ item }"
            fs.writeFile "#{ dst }/#{ item }", data, (err) ->
                throw err if err
        catch error
            if error.code is 'EISDIR'
               @copy_files path.join(src, item), path.join(dst, item)


class exports.BaseCommand
    constructor: ->
        @help = ''
        @params = ''
        @params_count = 0

    check_params: ->
        params = @get_params()
        params.length is @params_count

    get_params: ->
        process.argv[3..]

    get_version: ->
        version = juju.get_version()
        console.log version