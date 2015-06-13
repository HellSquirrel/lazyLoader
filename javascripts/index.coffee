Link = require('./scriptLink')
Base64ImageLink = require('./base64ImageLink')
CssLink = require('./cssLink')

Renderer = require('./renderer')
$ = require('jquery')

$(->
    link = new Link('/test/test.js')
    b64imgLink = new Base64ImageLink('/test/1.jpg')
    cssLink = new CssLink('/test/screen.css')
    link.load().then(
        (response) ->
            Renderer.renderScript response
    )
    .fail( (err) ->
        console.error err
    )

    b64imgLink.load().then((response) -> Renderer.renderImage response)
    cssLink.load().then((response) -> Renderer.renderStyle response)
)
