q = require('q');

class BaseLink
    constructor: (@url, type) ->
        @defer = q.defer()
        @curent = 0
        @mime = type
        @loadStart = false
        @loadEnd = false


    load:  ->

        @loadStart = true
        xhr = new XMLHttpRequest()
        xhr.overrideMimeType(@mime)

        xhr.onprogress = (event) =>
            if(event.lengthComputable)
                @current = event.loaded
                @defer.notify(event.loaded/event.total)

        xhr.onreadystatechange = (state) =>
            switch xhr.readyState
                when 2
                    length = xhr.getResponseHeader("Content-length")
                    @total = length

                when 3
                    length = xhr.getResponseHeader("Content-length");
                    @current = xhr.response.length;

                    if(@current)
                        @defer.notify(@current/@total);

                when 4
                    if (xhr.status == 200)
                        @current = @total
                        @defer.notify(state)
                        @content = xhr
                        @defer.resolve @content
                        @loadEnd = true
                        @response = @content
                        @success = true

                    else
                        @defer.reject xhr.status
                        @loadEnd = true
                        @response = xhr.status
                        @success = false

        xhr.open('GET', @url)
        xhr.send()

        return @defer.promise

module.exports = BaseLink
