local Data = {}

function Data.addItem(items, text)
    table.insert(items, {text = text, checked = false})
end

function Data.removeItem(items, index)
    if index >= 1 and index <= #items then
        table.remove(items, index)
    end
end

function Data.setChecked(items, index, checked)
    if items[index] then
        items[index].checked = checked
    end
end

return Data