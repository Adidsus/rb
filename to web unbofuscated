local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local PlaceIdLobby = 17017769292
local Web = "" --Server Ip its empty because of safety reasons
local player = Players.LocalPlayer
-- _G.UserID = "Your User ID here"
local userId = _G.UserID

local function getCurrency()
    local data = game:GetService('ReplicatedStorage').Remotes.GetInventory:InvokeServer()
    local currencies = {}
    local Level = 0

    if type(data) == "table" then
        if data.Currencies then
            for key, value in pairs(data.Currencies) do
                if key == "Gems" or key == "Gold" then
                    currencies[key] = value
                end
            end
        end
        Level = data.Level or 0
    end
    return currencies, Level
end

local function getInventoryItems()
    local data = game:GetService('ReplicatedStorage').Remotes.GetInventory:InvokeServer()
    local items = {}
    if type(data) == "table" and data.Items then
        for key, value in pairs(data.Items) do
            table.insert(items, {name = key, count = value})
        end
    end
    return items
end

local function sendData(player, status, gems, gold, itemsInfo, userId, level)
    local msg = {
        userId = userId,
        playerName = player.Name,
        gems = gems,
        gold = gold,
        level = level,
        content = status,
        items = itemsInfo,
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    local http_request = syn.request or request or HttpPost
    local response = http_request({
        Url = Web,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = HttpService:JSONEncode(msg)
    })

    print("Datas sending status", response.StatusCode)
    print("Server Response", response.Body)

    if response.StatusCode ~= 200 then
        print("Error while sending data.")
    end
end

wait(1)

if player and game.PlaceId == PlaceIdLobby then
    print(player.Name .. " is in lobby")

    local currencyData, level = getCurrency()
    local gems = currencyData.Gems or "0"
    local gold = currencyData.Gold or "0"

    local itemsInfo = getInventoryItems()

    sendData(player, "Lobby", gems, gold, itemsInfo, userId, level)
elseif game.PlaceId ~= PlaceIdLobby then
    print(player.Name .. " is in game")
    
    local currencyData, level = getCurrency()
    local gems = currencyData.Gems or "0"
    local gold = currencyData.Gold or "0"

    local itemsInfo = getInventoryItems()

    sendData(player, "Game", gems, gold, itemsInfo, userId, level)
else
    print(player.Name .. " unknown state.")
end
