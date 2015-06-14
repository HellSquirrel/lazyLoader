Base64ImageLink = require('./encodedImageLink')
BaseLink = require('./baseLink')

class SimpleImageLink extends BaseLink
    load: () ->
        @loadStart = true
        img = new Image();
        img.src = @url
        img.addEventListener('load', (event) =>
            @defer.resolve(@)
            @loadEnd = true
            @current = 1
            @total = 1
        )
        img.addEventListener('error', (event) => @defer.reject(event))

        @defer.promise


module.exports = SimpleImageLink
