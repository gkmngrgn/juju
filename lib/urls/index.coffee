exports.get_urls = ->
    urls = require "#{ process.cwd() }/urls"
    if not urls.urlpatterns.length
        views = require('juju').welcome.views
        [{ path: '/', view: views.WelcomeIndexView, name: 'welcome-index' }]
    else
        urls.urlpatterns