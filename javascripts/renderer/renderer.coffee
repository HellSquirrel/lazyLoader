module.exports = {

    renderScript: (script) ->
        s = document.createElement('script')
        s.innerHTML = script
        document.head.appendChild(s)

    renderImage: (src) ->
        img = document.createElement('img')
        img.src = src
        document.body.appendChild(img)

    renderStyle: (css) ->
        style = document.createElement('style')
        style.innerHTML = css
        document.head.appendChild(style)
}



