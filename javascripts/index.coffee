Link = require('./scriptLink')
Base64ImageLink = require('./base64ImageLink')
CssLink = require('./cssLink')
LazyLoader = require('./lazyLoader')

Renderer = require('./renderer')
$ = require('jquery')

$(->
    link = new Link('/test/test.js')
    b64imgLink = new Base64ImageLink('/test/1.jpg')
    cssLink = new CssLink('/test/screen.css')

    loader = new LazyLoader([link, b64imgLink, cssLink])
    hub = loader.getHub()
    hub.on('link:add', (link) -> console.log('add', link))
    loader.addLink(new Base64ImageLink('/test/2.jpg'), 2)
    hub.on('link:loadStart', (link) -> console.log('single link load start', link))
    hub.on('link:loadEnd', (link) -> console.log('single link load end', link))
    hub.on('progress', (progress) ->
        console.log('total progress is', progress,'task progress is', loader.getProgress([0,1,2])))
    hub.on('bundle:loadStart', (ids) -> console.log('start loading for ids', ids))
    hub.on('bundle:loadEnd', (ids) -> console.log('loading for ids complete', ids))

    loader.loadBundle([0,1,2])

#    link.load().then(
#        (response) ->
#            Renderer.renderScript response
#    )
#    .fail( (err) ->
#        console.error err
#    )
#
#    b64imgLink.load().then((response) -> Renderer.renderImage response)
#    cssLink.load().then((response) -> Renderer.renderStyle response)
)


