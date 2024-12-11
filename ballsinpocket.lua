local placeId = game.PlaceId -- Pobiera aktualne PlaceId gry
local TheGame = 123456789
local lobby = 18517861463  -- na odwrot te to jest game

if placeId == lobby then
    task.wait(5)
    local players = game:GetService("Players")
    local playerList = players:GetPlayers() -- Pobiera listę wszystkich graczy w grze

    if #playerList > 1 then
        game:GetService("ReplicatedStorage").Remotes.ReturnToLobby:FireServer()
        print("ulla")
    end

    
   local replicatedStorage = game:GetService("ReplicatedStorage")
local remotes = replicatedStorage:WaitForChild("Remotes")

-- Głosowanie na poziom trudności
remotes:WaitForChild("VoteDifficulty"):FireServer("BossRushOne")
task.wait(0.2)

-- Lista wież do postawienia
local towers = {
    {
        id = "960370fd-efe8-4a1a-9ec4-b2a7bee76214", -- Baller
        position = Vector3.new(-1387.231201171875, 3, 1233.673095703125),
        uniqueId = "{4cb2f537-f977-4ff9-9444-b8ee961f0008}",
        towerIndex = 1,
        towerUpgradeNr = {2, 3, 4, 5, 6, 7, 8, 9},  -- Numerki ulepszeń
        costs = {2400, 5000, 10000, 50000, 125000, 250000, 350000, 500000}, -- Koszty ulepszeń
        currentUpgrade = 1  -- Obecny poziom ulepszenia (zaczynamy od poziomu 1)
    },
    {
        id = "0194c0c8-4681-4ee7-95f9-b3adf4860934", -- GMK1
        position = Vector3.new(-1377.2821044921875, 3, 1224.64599609375),
        uniqueId = "{8b93d3ac-1dd7-42f7-b5de-492a92ec722d}",
        towerIndex = 2,
        towerUpgradeNr = {2, 3, 4, 5},  -- Numerki ulepszeń
        costs = {2000, 10000, 50000, 150000}, -- Koszty ulepszeń
        currentUpgrade = 1  -- Obecny poziom ulepszenia
    },
    {
        id = "9c8fede2-2f9d-4e64-a992-1d20d667f78a", -- GMK2
        position = Vector3.new(-1378.792236328125, 3, 1219.0018310546875),
        uniqueId = "{51542f60-adc8-445c-b7ef-b270c0485bc8}",
        towerIndex = 3,
        towerUpgradeNr = {2, 3, 4, 5},  -- Numerki ulepszeń
        costs = {2000, 10000, 50000, 150000}, -- Koszty ulepszeń
        currentUpgrade = 1  -- Obecny poziom ulepszenia
    },
    {
        id = "8faee502-87c8-48ba-a13d-12db02b1644f", -- Brain
        position = Vector3.new(-1393.274169921875, 3, 1218.615966796875),
        uniqueId = "{ffb86cae-24fa-4721-a13d-58c3c31b595f}",
        towerIndex = 4,
        towerUpgradeNr = {2, 3, 4, 5, 6, 7, 8},  -- Numerki ulepszeń
        costs = {5000, 10000, 20000, 50000, 100000, 250000, 400000}, -- Koszty ulepszeń
        currentUpgrade = 1  -- Obecny poziom ulepszenia
    },
    {
        id = "1213b910-a234-487e-ac0e-618a19df661e",
        position = Vector3.new(-1394.260009765625, 3, 1225.510498046875),
        towerIndex = 5,
        uniqueId = "{7e19ae61-e265-49af-a3af-7354d90b19da}",
        towerUpgradeNr = {2, 3, 4, 5, 6, 7, 8},  -- Numerki ulepszeń
        costs = {3000, 10000, 40000, 100000, 250000, 400000}, -- Koszty ulepszeń
        currentUpgrade = 1  -- Obecny poziom ulepszenia
    }
        
}

-- Funkcja parsowania tekstu pieniędzy
local function parseMoney(text)
    text = text:gsub("[%$,]", "") -- Usuń znaki "$" i ","
    local number = tonumber(text:match("[%d%.]+"))
    local multiplier = text:match("[KkMmBb]")
    if multiplier then
        if multiplier:lower() == "k" then
            return number * 1000
        elseif multiplier:lower() == "m" then
            return number * 1e6
        elseif multiplier:lower() == "b" then
            return number * 1e9
        end
    end
    return number
end

-- Funkcja sprawdzająca dostępne pieniądze
local function getAvailableMoney()
    local player = game:GetService("Players").LocalPlayer
    local moneyLabel = player.PlayerGui:WaitForChild("MainGui")
                           :WaitForChild("LoadoutTop")
                           :WaitForChild("MoneyLabel")
    return parseMoney(moneyLabel.Text)
end

-- Funkcja do stawiania wież
local function spawnTowers()
    for _, tower in ipairs(towers) do
        local args = {
            [1] = tower.id,
            [2] = tower.position,
            [3] = 0,
            [4] = tower.uniqueId
        }
        remotes:WaitForChild("SpawnTowerServer"):FireServer(unpack(args))
        task.wait(0.1)
    end
end

-- Funkcja do ulepszania wież
local function upgradeTowers()
    while true do
        local availableMoney = getAvailableMoney()
        print("Dostępne pieniądze: " .. availableMoney)

        local upgradesMade = false -- Flaga sprawdzająca, czy dokonano ulepszeń

        -- Iteracja po wieżach
        for _, tower in ipairs(towers) do
            local upgradeNrs = tower.towerUpgradeNr
            local costs = tower.costs
            local currentUpgrade = tower.currentUpgrade

            -- Sprawdzenie, czy wieża ma kolejne ulepszenie
            if currentUpgrade <= #upgradeNrs then
                local nextUpgrade = upgradeNrs[currentUpgrade]
                local cost = costs[currentUpgrade]

                -- Sprawdzenie, czy ulepszenie jest dostępne
                if cost and availableMoney >= cost then
                    print(string.format("Ulepszanie wieży %d na poziom %d za %d", tower.towerIndex, nextUpgrade, cost))

                    -- Wywołanie remota do ulepszenia wieży
                    local args = {
                        [1] = tower.towerIndex,
                        [2] = nextUpgrade
                    }
                    remotes:WaitForChild("UpgradeTowerServer"):FireServer(unpack(args))

                    -- Zaktualizowanie dostępnych pieniędzy po ulepszeniu
                    availableMoney = availableMoney - cost
                    print("Pozostałe pieniądze: " .. availableMoney)

                    -- Zaktualizowanie obecnego poziomu ulepszenia
                    tower.currentUpgrade = tower.currentUpgrade + 1

                    upgradesMade = true
                    task.wait(0.5) -- Czekaj przed kolejnym ulepszeniem
                    break -- Ulepsz tylko raz dla każdej wieży
                end
            end
        end

        if not upgradesMade then
            print("Brak wystarczających pieniędzy na dalsze ulepszenia.")
        end
        
        task.wait(1) -- Sprawdzaj dostępne pieniądze co 1 sekundę
    end
end

-- Uruchomienie funkcji
spawnTowers()  -- Stawianie wież
task.wait(2)
task.spawn(upgradeTowers)  -- Ulepszanie wież
local args = {
    [1] = 3
}

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SetSpeedUp"):FireServer(unpack(args))


local plr = game.Players.LocalPlayer
print("asda")
local function teleportPlayerTo(player, targetPart)
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = player.Character.HumanoidRootPart
        humanoidRootPart.CFrame = targetPart.CFrame
    end
end

workspace.ChildAdded:Connect(function(child)
    if child.Name == "T0" and child:FindFirstChild("Root") then
        print("T0 znaleziony, przetwarzanie...")
        -- teleportPlayerTo(plr, child:FindFirstChild("Root"))

        for i, v in pairs(child:FindFirstChild("Root"):GetChildren()) do
            if v:IsA("ProximityPrompt") then
                v.HoldDuration = 0.001
                v.MaxActivationDistance = 100
                teleportPlayerTo(plr, v.Parent)
                fireproximityprompt(v)
            end
        end
    else
        print("Dodano nowy obiekt, ale nie jest to T0.")
    end
end)

local function autoskip()
    while true do
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SkipVote"):FireServer()
    task.wait(15)
    end
end
task.spawn(autoskip)
local player = game:GetService("Players").LocalPlayer
local gui = player:WaitForChild("PlayerGui"):WaitForChild("MainGui")

-- Funkcja monitorująca dodanie nowego "Main"
local function monitorEndGame()
    gui.ChildAdded:Connect(function(child)
        if child:IsA("Frame") and child.Name == "Main" then
            print("Pojawił się nowy Frame o nazwie 'Main'")
            -- Sprawdź, czy ten Frame zawiera element wskazujący na koniec gry
            if child:FindFirstChild("EndScreenStats") then
                print("Znaleziono EndScreenStats. Restartowanie gry...")
                -- restartGame() -- Funkcja restartująca grę
                game:GetService("ReplicatedStorage").Remotes.ReturnToLobby:FireServer()
            end
        end
    end)
end
monitorEndGame()
--elseif placeId == lobby then
else  
task.wait(2)
print("DoingMapStuff")

local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}
local player = game.Players.LocalPlayer
local lobbyList = player.PlayerGui.MainGui.LobbyListFrame.Content.LobbyList
local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}
local player = game.Players.LocalPlayer
local mainGui = player.PlayerGui.MainGui
local function FireSignal(button)
    for _, Signal in pairs(Signals) do
        firesignal(button[Signal])
    end
end

local function findAndClickLeaveButton()
    for _, frame in pairs(lobbyList:GetChildren()) do
        -- Sprawdzamy, czy to Frame i czy ma nazwę "Lobby"
        if frame:IsA("Frame") and frame.Name == "Lobby" then
            -- print("Znaleziono Frame Lobby:", frame.Name)
            
            -- Szukamy LeaveButton w tym Frame
            local leaveButton = frame:FindFirstChild("LeaveButton")
            
            if leaveButton and leaveButton:IsA("TextButton") then
                -- print("Znaleziono LeaveButton z tekstem:", leaveButton.Text)
                if leaveButton.Text == "Create Party" then
                    print("Klikam LeaveButton z tekstem 'Create Party'")
                    FireSignal(leaveButton)
                    return true -- Kończymy, gdy znajdziemy odpowiedni przycisk
                end
            else
                print("Nie znaleziono LeaveButton w tym Lobby")
            end
        end
    end
    print("Nie znaleziono żadnego odpowiedniego Lobby z LeaveButton")
    return false
end

findAndClickLeaveButton()



-- local buttonsFrame = mainGui.CurrentLobby.Lobby.Buttons
local Signals = {"Activated", "MouseButton1Down", "MouseButton2Down", "MouseButton1Click", "MouseButton2Click"}

local function FireSignal(button)
    for i,Signal in pairs(Signals) do
        firesignal(button[Signal])
    end
end
task.wait(0.8)
local function ChangeMap()
    local player = game.Players.LocalPlayer
    local mainGui = player.PlayerGui.MainGui
    local scrollingFrame = mainGui.MapSelector.Content.ScrollingFrame

    for _, frame in pairs(scrollingFrame:GetChildren()) do
        if frame:IsA("Frame") then
            local mapImageButton = frame:FindFirstChild("MapImage")
            if mapImageButton and mapImageButton:IsA("TextButton") then
                -- Szukamy Frame w MapImage, który zawiera TextLabel
                local innerFrame = mapImageButton:FindFirstChild("Frame")
                if innerFrame then
                    local textLabel = innerFrame:FindFirstChild("TextLabel")
                    if textLabel and textLabel.Text == "Tundra" then
                        print("changing Map")
                        FireSignal(mapImageButton)
               
                    end
                end
            end
        end
    end
end

task.wait(0.2)

ChangeMap()
print("Map changed")

local buttonsFrame = mainGui.CurrentLobby.Lobby.Buttons

local function clickStartButton()
    print("Startfunc")
    local buttonsFrame = mainGui.CurrentLobby.Lobby.Buttons

    for _, frame in pairs(buttonsFrame:GetChildren()) do
        print(frame)
        if frame:IsA("Frame") and frame.Name == "Frame" then
            -- Sprawdzamy wszystkie dzieci w Frame, aby znaleźć TextButton
            for _, child in pairs(frame:GetChildren()) do
                if child:IsA("TextButton") then  -- Szukamy obiektów typu TextButton
                    print("Znaleziono przycisk:", child.Name)  -- Sprawdzamy, który przycisk został znaleziony
                    print(child.Text)
                    if  child.Text == "Start" then
                        FireSignal(child)
                    --     print("Znaleziono Public, aktywowanie...")
                        -- child.MouseButton1Click:Fire()
                    --     return true  -- Zwracamy true, gdy przycisk Public zostanie kliknięty
                    end
                end
            end
        end
    end
    return false  -- Jeśli nie znaleziono Public
end
-- task.wait(0.1)
task.wait(0.1)
   print("Starting")
clickStartButton()
end
