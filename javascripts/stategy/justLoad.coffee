#do nothing
#if you load a picture then remove it from loader
#but results are chashed

save = (link) ->
    link.link.defer = null
    link.link.xhr = null
    link.inStorage = true
    link.state = 'saved'


module.exports.save = save
