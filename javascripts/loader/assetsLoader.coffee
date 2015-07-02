LazyLoader = require('./lazyLoader')
types = require('./../services/types')


#enchants lazyLoader with smart link generation
class AssetsLoader extends LazyLoader

    constructor: (urls, strategy) ->
        super(urls, strategy)
        @hub.on('command.loadBundle', @loadBundle.bind(@))

    addLink: (url, weight = 1) ->
        link = types.getLink(url)
        super(link, weight)


module.exports = AssetsLoader
