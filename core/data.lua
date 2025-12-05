-- core/data.lua
-- Data operations for todo items

local Data = {}

function Data.addItem(items, text)
    table.insert(items, {text = text, checked = false})
end

function Data.removeItem(items, index)
    table.remove(items, index)
end

function Data.setChecked(items, index, checked)
    if items[index] then
        items[index].checked = checked
    end
end

return Data
