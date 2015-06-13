Hub = require('events').EventEmitter

class LazyLoader
    constructor: (links)->
        @hub = new Hub
        @links = links || []
        @state = {}

    addLink: (linkObj) ->
        @links.push(linkObj)

    load: ->
        for link in @links
            link.load()

