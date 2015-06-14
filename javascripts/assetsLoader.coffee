LazyLoader = require('./lazyLoader')
types = require('./types')


#enchants lazyLoader with smart link generation
class AssetsLoader extends LazyLoader

    addLink: (url, weight = 1) ->
        link = types.getLink(url)
        super(link, weight)

module.exports = AssetsLoader
