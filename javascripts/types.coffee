LazyLoader = require('./lazyLoader')
ScriptLink = require('./scriptLink')
CssLink = require('./cssLink')
LazyLoader = require('./lazyLoader')
SimpleImageLink = require('./simpleImageLink')

BaseLink = require('./baseLink');
EncodedImageLink = require('./encodedImageLink')


isScript = (url) ->
    return (/\.js$/).test(url)

isPic = (url) ->
    re = /\.((?:(?:jp)|(?:pn)|(?:sv))g)(?:\?\w+)?$/;
    re.test(url)

isCss = (url) ->
    return (/\.css/).test(url)

getLink = (url) =>
    type = switch
        when isScript(url) then new ScriptLink(url)
        when isPic(url) then new EncodedImageLink(url)
        when isCss(url) then new CssLink(url)
        else throw "cant define link type!"
    type

module.exports = {
    isScript: isScript,
    isPic: isPic,
    isCss: isCss,
    getLink: getLink
}
