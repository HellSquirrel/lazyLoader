#simple storage that holds on in memory

Storage.nextId = 0;
class Storage
    constructor:(dataToStore) ->
        @data = dataToStore
        @id = Storage.nextId
        @stored = false
        Storage.nextId += 1

    dump: () ->
        localStorage.setItem('storedData' + @id, @data)
        @data = null
        @stored = true

    restore: () ->
        @data = localStorage.getItem('storedData' + @id)
        @stored = false

