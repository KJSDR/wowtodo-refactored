local Storage = require("core.storage")
local Data = require("core.data")
local Frame = require("ui.frame")
local List = require("ui.list")
local Input = require("ui.input")

local todoItems = {}
local frame = nil
local contentFrame = nil

local function saveItems()
    Storage.save(todoItems)
end

local function updateList()
    List.update(contentFrame, todoItems, onToggle, onRemove)
end

function onToggle(index, checked)
    Data.setChecked(todoItems, index, checked)
    saveItems()
end

function onRemove(index)
    Data.removeItem(todoItems, index)
    saveItems()
    updateList()
end

local function onAdd(text)
    Data.addItem(todoItems, text)
    saveItems()
    updateList()
end

local function initialize()
    todoItems = Storage.initialize()
    
    print("Loaded todoItems:")
    for i, item in ipairs(todoItems) do
        print(i, item.text, item.checked)
    end

    frame = Frame.create()
    local scrollFrame
    scrollFrame, contentFrame = List.createScrollFrame(frame)
    Input.create(frame, onAdd)

    updateList()

    SLASH_TODOLIST1 = "/todolist"
    SlashCmdList["TODOLIST"] = function()
        Frame.toggle(frame)
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
    initialize()
end)
