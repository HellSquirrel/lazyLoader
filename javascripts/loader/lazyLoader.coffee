Hub = require('events').EventEmitter
q = require('q')
W8 = 0
LOAD_START = 1
LOAD_END = 2

class LazyLoader
    constructor: (links)->
        @hub = new Hub
        @links = []
        if(links)
            @addLink(link) for link in links

    addLink: (link , weight = 1) ->

        linkObj = {
            link: link
            result: false
            state: W8
            weight: weight
            progress: 0
        }

        @links.push(linkObj)
        @hub.emit('link:add', linkObj)

    removeLink: (id) ->
        link = @links.splice(id, 1)
        @hub.emit('link:remove', link)

    load: (id) ->

        link = @links[id]

        #already loaded
        if(link.state = LOAD_END)
            @hub.emit('link:loadEnd', link)
            @hub.emit('progress', @getProgress())

        link.state = LOAD_START
        @hub.emit('link:loadStart', link)

        link.link.load().then(
            (result) =>
                link.state = LOAD_END
                link.result = result
                link.progress = 1
                @hub.emit('link:loadEnd', link)
                @hub.emit('progress', @getProgress())

            (fail) => console.warn(fail)
            (progress) =>
                @hub.emit('link:progress', link)
                @hub.emit('progress', @getProgress())
                link.progress = progress

        ).done()


    loadBundle: (ids) ->

        promises = ids.map((id) => @links[id].link.defer)
        q.all(promises).then(() =>
            console.debug('bundle load complete!')
            @hub.emit('bundle:loadEnd', ids)
        ).catch((err) -> console.error(err))
        @load(id) for id in ids
        @hub.emit('bunlde:loadStart', ids)


    totalWeight: (ids) ->
        result = 0
        (result += @links[id].weight) for id in ids
        result

    getProgress: (ids) ->

        if ids
            loaded = ids.reduce((result, id) =>
                link = @links[id]
                return result + link.progress * link.weight
            , 0)

            return loaded/@totalWeight(ids)

        all = [0..@links.length - 1]
        @getProgress(all)

    getHub: -> @hub

module.exports = LazyLoader

