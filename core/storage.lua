local Storage = {}

function Storage.initialize()
    todolistDB = todolistDB or { items = {} }
    return todolistDB.items
end

function Storage.save(items)
    todolistDB.items = items
end

return Storage
