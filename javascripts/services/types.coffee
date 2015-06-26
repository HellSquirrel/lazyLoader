LazyLoader = require('./../loader/lazyLoader')
ScriptLink = require('./../links/scriptLink')
CssLink = require('./../links/cssLink')
LazyLoader = require('./../loader/lazyLoader')
SimpleImageLink = require('./../links/simpleImageLink')

BaseLink = require('./../links/baseLink');
EncodedImageLink = require('./../links/encodedImageLink')


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
