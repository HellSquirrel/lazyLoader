LazyLoader = require('./lazyLoader')
types = require('./../services/types')


#enchants lazyLoader with smart link generation
class AssetsLoader extends LazyLoader

    constructor: (urls) ->
        super(urls)
        @hub.on('command.loadBundle', @loadBundle.bind(@))
        @startCatchingAjax()

    addLink: (url, weight = 1) ->
        link = types.getLink(url)
        super(link, weight)

    startCatchingAjax: () ->
        open = XMLHttpRequest.prototype.open;
        send = XMLHttpRequest.prototype.send;

        XMLHttpRequest.prototype.open = (method = '',url = '') ->
            if not @urlIsComplete(url)
                open.apply(@, arguments)

        XMLHttpRequest.prototype.send = (method = '',url = '') ->
            if not @urlIsComplete(url)
                send.apply(@, arguments)

    #todo: add advanced check
    urlIsComplete: (url) ->

        for(i = 0; i< @links.length; i++)
            link = @links[i]
            if (link.url == url && @link.state == 2)
                return link.result
            null


module.exports = AssetsLoader
