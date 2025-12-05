local Input = {}

function Input.create(parent, onSubmit)
    -- Background
    local editBoxBackground = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    editBoxBackground:SetSize(210, 25)
    editBoxBackground:SetPoint("BOTTOMLEFT", 10, 10)
    editBoxBackground:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 16,
        insets = { left = 5, right = 5, top = 5, bottom = 5 }
    })
    editBoxBackground:SetBackdropColor(0, 0, 0, 0.5)

    -- Edit box
    local editBox = CreateFrame("EditBox", nil, editBoxBackground)
    editBox:SetSize(200, 20)
    editBox:SetPoint("CENTER")
    editBox:SetFontObject("GameFontNormal")
    editBox:SetAutoFocus(false)
    editBox:SetTextInsets(5, 5, 0, 0)

    editBox:SetScript("OnEnterPressed", function(self)
        local text = self:GetText()
        if text ~= "" then
            onSubmit(text)
            self:SetText("")
        end
    end)

    return editBox
end

return Input
