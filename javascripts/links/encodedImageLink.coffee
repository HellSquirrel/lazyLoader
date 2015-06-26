BaseLink = require('./baseLink');


getPictureType = (url) ->
    return url.slice(-3);

base64Encode =  (str) ->
    CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    out = ""
    i = 0
    len = str.length
    while (i < len)
        c1 = str.charCodeAt(i++) & 0xff
        if (i == len)
            out += CHARS.charAt(c1 >> 2)
            out += CHARS.charAt((c1 & 0x3) << 4)
            out += "=="
            break

        c2 = str.charCodeAt(i++)
        if (i == len)
            out += CHARS.charAt(c1 >> 2)
            out += CHARS.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4))
            out += CHARS.charAt((c2 & 0xF) << 2)
            out += "="
            break

        c3 = str.charCodeAt(i++)
        out += CHARS.charAt(c1 >> 2)
        out += CHARS.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4))
        out += CHARS.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6))
        out += CHARS.charAt(c3 & 0x3F)

    return out



class EncodedImageLink extends BaseLink

    constructor: (url) ->
        super(url, 'text/plain; charset=x-user-defined')
        @picType = getPictureType(url)

    load: ->
        return super().then((xhr) =>

            data = xhr.responseText;

            encoded = base64Encode(data)
            src = "data:image/#{@picType};base64," + encoded
            return src
        )

module.exports = EncodedImageLink
