q = require('q')
BaseLink = require('./baseLink')

class CssLink extends BaseLink
    constructor: (url) ->
        super(url, 'text/css')

    load: ->
        return super().then( (xhr) ->
            return xhr.responseText)


module.exports = CssLink
