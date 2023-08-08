-- Variable to track auto-run state
local isAutoRunning = false

-- Function to handle player chat
local function onChatted(message)
    local prefixAuto = ".earape true"
    local prefixStop = ".earape false"

    if message:sub(1, #prefixAuto) == prefixAuto then
        -- Start auto-run
        if not isAutoRunning then
            isAutoRunning = true
            while isAutoRunning do
                -- Infinite loop to keep sending votes with the desired parameters
                local targetName = message:sub(#prefixAuto + 1):lower() -- Convert to lowercase for case-insensitive comparison

                local function convertDisplayNameToUsername(displayName)
                    for _, player in ipairs(game.Players:GetPlayers()) do
                        if player.DisplayName:lower():find(displayName, 1, true) then
                            return player.Name
                        end
                    end
                    return nil
                end

                local targetUsername = convertDisplayNameToUsername(targetName)

                if targetUsername then
                    local args = {
                        [1] = game.Players:FindFirstChild(targetUsername).Character
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Kill"):FireServer(unpack(args))
                else
                    print(" ")
                end
                wait(0.5) -- Wait 1 second before sending the next vote
            end
        end
    elseif message:sub(1, #prefixStop) == prefixStop then
        -- Stop auto-run
        isAutoRunning = false
    end
end

game:GetService("Players").LocalPlayer.Chatted:Connect(onChatted)
