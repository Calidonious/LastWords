-- Initialize the addon
local LastWordsFrame = CreateFrame("Frame")
local lastWords = "We go again!"  -- Default message; the user can change this

-- Function to check player health
local function CheckHealth()
    local healthPercent = (UnitHealth("player") / UnitHealthMax("player")) * 100
    if healthPercent <= 1 then
        -- Send the custom message to chat
        SendChatMessage(lastWords, "SAY")
        LastWordsFrame:SetScript("OnUpdate", nil)  -- Stop checking after message is sent
    end
end

-- Slash command to set the last words
SLASH_LASTWORDS1 = "/lastwords"
SlashCmdList["LASTWORDS"] = function(msg)
    if msg and msg ~= "" then
        lastWords = msg
        print("LastWords message set to: " .. msg)
    else
        print("Please enter a message for your LastWords.")
    end
end

-- Event to start checking health
LastWordsFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
LastWordsFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_DISABLED" then
        -- Start checking health when combat begins
        self:SetScript("OnUpdate", CheckHealth)
    end
end)
