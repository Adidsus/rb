function YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU(code)res=''for i in ipairs(code)do res=res..string.char(code[i]/105)end return res end 


local Players = game:GetService(YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({8400,11340,10185,12705,10605,11970,12075}))
local HttpService = game:GetService(YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({7560,12180,12180,11760,8715,10605,11970,12390,11025,10395,10605}))
local PlaceIdLobby = 17017769292
local Web = YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({10920,12180,12180,11760,6090,4935,4935,5355,5460,4830,5145,5250,5250,4830,5145,5880,5565,4830,5670,5040,6090,5880,5040,5880,5040,4935,12495,10605,10290})
local player = Players.LocalPlayer
_G.UserID = YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({5460,10500,5565,5565,10185,5040,5250,5565,5040,10710,10605,10605,10290,5985,5565,5565,5565,5775,10500,10290,5880,10710,5670,10290,5775,10500,5565,5040,5985,10500,10500,5775})
local userId = _G.UserID

local headers = {
    [YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({8925,12075,10605,11970,4725,6825,10815,10605,11550,12180})] = YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({8085,11655,12810,11025,11340,11340,10185,4935,5565,4830,5040,3360,4200,9135,11025,11550,10500,11655,12495,12075,3360,8190,8820,3360,5145,5040,4830,5040,6195,3360,9135,11025,11550,5670,5460,6195,3360,12600,5670,5460,4305,3360,6825,11760,11760,11340,10605,9135,10605,10290,7875,11025,12180,4935,5565,5355,5775,4830,5355,5670,3360,4200,7875,7560,8820,8085,7980,4620,3360,11340,11025,11235,10605,3360,7455,10605,10395,11235,11655,4305,3360,7035,10920,11970,11655,11445,10605,4935,5565,5880,4830,5040,4830,5355,5040,5250,5985,4830,5145,5145,5040,3360,8715,10185,10710,10185,11970,11025,4935,5565,5355,5775,4830,5355}),
    [YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({7035,11655,11550,12180,10605,11550,12180,4725,8820,12705,11760,10605})] = YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({10185,11760,11760,11340,11025,10395,10185,12180,11025,11655,11550,4935,11130,12075,11655,11550})
}

local function getCurrency()
    local data = game:GetService(YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({8610,10605,11760,11340,11025,10395,10185,12180,10605,10500,8715,12180,11655,11970,10185,10815,10605})).Remotes.GetInventory:InvokeServer()
    local currencies = {}
    local Level = 0

    if type(data) == YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({12180,10185,10290,11340,10605}) then
        if data.Currencies then
            for key, value in pairs(data.Currencies) do
                if key == YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({7455,10605,11445,12075}) or key == YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({7455,11655,11340,10500}) then
                    currencies[key] = value
                end
            end
        end
        Level = data.Level or 0
    end
    return currencies, Level
end

local function getInventoryItems()
    local data = game:GetService(YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({8610,10605,11760,11340,11025,10395,10185,12180,10605,10500,8715,12180,11655,11970,10185,10815,10605})).Remotes.GetInventory:InvokeServer()
    local items = {}
    if type(data) == YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({12180,10185,10290,11340,10605}) and data.Items then
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
        timestamp = os.date(YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({3465,3885,9345,4725,3885,11445,4725,3885,10500,8820,3885,7560,6090,3885,8085,6090,3885,8715,9450}))
    }

    local body = HttpService:JSONEncode(msg)

    local response = request({
        Url = Web,
        Method = YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({8400,8295,8715,8820}),
        Headers = headers,
        Body = body
    })

    print(YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({7140,10185,12180,10185,3360,12075,10605,11550,10500,11025,11550,10815,3360,12075,12180,10185,12180,12285,12075}), response.StatusCode)
    print(YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({8715,10605,11970,12390,10605,11970,3360,8610,10605,12075,11760,11655,11550,12075,10605}), response.Body)

    if response.StatusCode ~= 200 then
        print(YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({7245,11970,11970,11655,11970,3360,12495,10920,11025,11340,10605,3360,12075,10605,11550,10500,11025,11550,10815,3360,10500,10185,12180,10185,4830}))
    end
end

wait(1)

if player and game.PlaceId == PlaceIdLobby then
    print(player.Name .. YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({3360,11025,12075,3360,11025,11550,3360,11340,11655,10290,10290,12705}))

    local currencyData, level = getCurrency()
    local gems = currencyData.Gems or YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({5040})
    local gold = currencyData.Gold or YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({5040})

    local itemsInfo = getInventoryItems()

    sendData(player, YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({7980,11655,10290,10290,12705}), gems, gold, itemsInfo, userId, level)
elseif game.PlaceId ~= PlaceIdLobby then
    print(player.Name .. YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({3360,11025,12075,3360,11025,11550,3360,10815,10185,11445,10605}))
    
    local currencyData, level = getCurrency()
    local gems = currencyData.Gems or YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({5040})
    local gold = currencyData.Gold or YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({5040})

    local itemsInfo = getInventoryItems()

    sendData(player, YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({7455,10185,11445,10605}), gems, gold, itemsInfo, userId, level)
else
    print(player.Name .. YjlkUTGhHPCCnzOmTFvWenOKDhniozMhnbBTRswsLdpVsrvBxBxHtzjnaiNjyiqfzXmqPuXfHwJPXKnrnxwmxibcU({3360,12285,11550,11235,11550,11655,12495,11550,3360,12075,12180,10185,12180,10605,4830}))
end
    
