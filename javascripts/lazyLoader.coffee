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
        }

        @links.push(linkObj)
        @hub.emit('link:add', linkObj)

    removeLink: (id) ->
        link = @links.splice(id, 1)
        @hub.emit('link:remove', link)

    load: (id) ->

        link = @links[id]
        link.link.load().then((result) =>
            link.state = LOAD_END
            @hub.emit('link:loadEnd', link)
            @hub.emit('progress', @getProgress())
        ).done()
        link.state = LOAD_START
        @hub.emit('link:loadStart', link)


    loadBundle: (ids) ->

        promises = @links[id].link.promise for id in ids
        q.all(promises).then(() =>
            @hub.emit('bundle:loadEnd', ids)
        )
        @load(id) for id in ids
        @hub.emit('bunlde:loadStart', ids)


    totalWeight: (ids) ->
        return ids.reduce((result, id)=>
            return result + @links[id].weight)

    getProgress: (ids) ->

        if ids
            loaded = ids.reduce((result, id) =>
                link = @links[id]
                if(link.state == LOAD_END)
                    return result + link.weight
                return result
            , 0)

            return loaded/@totalWeight(ids)

        all = [0..@links.length - 1]
        @getProgress(all)

    getHub: -> @hub

module.exports = LazyLoader

