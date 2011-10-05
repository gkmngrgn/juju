exports.get_urls = ->
    urlpatterns = require("#{ global.PROJECT_DIR }/urls").urlpatterns
    if not urlpatterns.length
        views = require('juju').welcome.views
        [{ path: '/', view: views.WelcomeIndexView, name: 'welcome.Index' }]
    else
        patterns = []
        for pattern in urlpatterns
            [app, view] = pattern.view.split '.'
            views = require "#{ app }/views"
            patterns.push { path: '/', view: views[view], name: pattern.view }
        patterns