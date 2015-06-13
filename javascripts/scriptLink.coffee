q = require('q')
BaseLink = require('./baseLink');

class ScriptLink extends BaseLink
    constructor: (url) ->
        super(url, 'text/javascript');

    load: ->
        return super().then( (xhr)->
            return xhr.responseText)


module.exports = ScriptLink
