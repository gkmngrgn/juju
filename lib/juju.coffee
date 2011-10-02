VERSION = [0, 0, 1, 'alpha', 0]


exports.get_version = ->
    version = "#{ VERSION[0] }.#{ VERSION[1] }"
    if VERSION[2]
        version = "#{ version }.#{ VERSION[2] }"
        if VERSION[3] is 'alpha' and VERSION[4] is 0
            version = "#{ version } pre-alpha"
        else if VERSION[3] != 'final'
            version = "#{ version } #{ VERSION[3] } #{ VERSION[4] }"

    version


exports.core = require './core'
exports.urls = require './urls'
exports.views = require './views'
exports.welcome = require './welcome'