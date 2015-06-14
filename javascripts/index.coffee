Link = require('./scriptLink')
encodedImageLink = require('./encodedImageLink')
CssLink = require('./cssLink')
SimpleImageLink = require('./simpleImageLink')

LazyLoader = require('./lazyLoader')
AssetsLoader = require('./assetsLoader')

Renderer = require('./renderer')
$ = require('jquery')



$(->

    link = new Link('/test/test.js')
    b64imgLink = new encodedImageLink('/test/1.jpg')
    cssLink = new CssLink('/test/screen.css')
    #simpleImageLink = new SimpleImageLink('/test/1.jpg')

    urls = ['/test/test.js', '/test/1.jpg', '/test/screen.css', '/test/1.jpg']
########################################################## lazyloader tests
#
#    loader = new LazyLoader([link, b64imgLink, cssLink])
#    hub = loader.getHub()
#    hub.on('link:add', (link) -> console.log('add', link))
#    loader.addLink(new Base64ImageLink('/test/2.jpg'), 2)
#
#
#
#    hub.on('link:loadStart', (link) -> console.log('single link load start', link))
#    hub.on('link:loadEnd', (link) -> console.log('single link load end', link))
##    hub.on('progress', (progress) ->
##        console.log('total progress is', progress,'task progress is', loader.getProgress([0,1,2])))
#    hub.on('bunlde:loadStart', (ids) -> console.log('start loading for ids', ids))
#    hub.on('bundle:loadEnd', (ids) -> console.log('loading for ids complete', ids))
#    loader.loadBundle([0,1,2,3])


############################################################### link tests
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


######################################################### assetLoader tests

    al = new AssetsLoader(urls)
    ahub = al.getHub()
    ahub.on('link:loadStart', (link) -> console.log('single link load start', link))
    ahub.on('link:loadEnd', (link) -> console.log('single link load end', link))
    ahub.on('progress', (progress) ->
        console.log('total progress is', progress,'task progress is', al.getProgress([0,1,2])))
    ahub.on('bunlde:loadStart', (ids) -> console.log('start loading for ids', ids))
    ahub.on('bundle:loadEnd', (ids) -> console.log('loading for ids complete', ids))
    al.loadBundle([0,1,2])

)
