local List = {}

function List.createScrollFrame(parent)
    local scrollFrame = CreateFrame("ScrollFrame", nil, parent, "UIPanelScrollFrameTemplate")
    scrollFrame:SetSize(280, 300)
    scrollFrame:SetPoint("TOP", 0, -40)

    local contentFrame = CreateFrame("Frame", nil, scrollFrame)
    contentFrame:SetSize(280, 300)
    scrollFrame:SetScrollChild(contentFrame)

    return scrollFrame, contentFrame
end

function List.update(contentFrame, items, onToggle, onRemove)
    -- Hide existing children
    for i, child in ipairs({contentFrame:GetChildren()}) do
        child:Hide()
    end

    local itemHeight = 20
    local spacing = 5
    local totalHeight = 0

    for i, item in ipairs(items) do
        -- Checkbox
        local checkbox = CreateFrame("CheckButton", nil, contentFrame, "ChatConfigCheckButtonTemplate")
        checkbox:SetPoint("TOPLEFT", 10, -totalHeight - spacing)
        checkbox.text = checkbox:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        checkbox.text:SetPoint("LEFT", checkbox, "RIGHT", 5)
        checkbox.text:SetText(item.text)
        checkbox:SetChecked(item.checked)

        checkbox:SetScript("OnClick", function(self)
            onToggle(i, self:GetChecked())
        end)

        -- Remove button
        local removeButton = CreateFrame("Button", nil, contentFrame, "UIPanelButtonTemplate")
        removeButton:SetSize(25, 20)
        removeButton:SetText("-")
        removeButton:SetPoint("LEFT", checkbox.text, "RIGHT", 5, 0)
        removeButton:SetFrameLevel(checkbox:GetFrameLevel() + 1)

        removeButton:SetScript("OnClick", function()
            onRemove(i)
        end)

        totalHeight = totalHeight + itemHeight + spacing
    end

    contentFrame:SetHeight(math.max(totalHeight, 300))
end

return List
