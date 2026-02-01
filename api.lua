--[[
    aaa3HUB Key System API v2

    Proste API do weryfikacji kluczy z StatusCodes.
    Bez wbudowanego UI - developer buduje wlasne.

    Uzycie:
    local api = loadstring(game:HttpGet("https://api.aaa3.dev/loaderv2"))()
    api.script_id = "your_project_id"

    local result = api.check_key("XXXX-XXXX-XXXX-XXXX")
    if result.status == api.StatusCodes.KEY_VALID then
        print("OK!")
    end
]]

local api = {}

-- ============================================
-- STATUS CODES
-- ============================================
api.StatusCodes = {
    KEY_VALID = "KEY_VALID",
    KEY_EXPIRED = "KEY_EXPIRED",
    KEY_BANNED = "KEY_BANNED",
    KEY_HWID_LOCKED = "KEY_HWID_LOCKED",
    KEY_INCORRECT = "KEY_INCORRECT",
    KEY_INVALID = "KEY_INVALID",
    SCRIPT_ID_INCORRECT = "SCRIPT_ID_INCORRECT",
    SCRIPT_ID_INVALID = "SCRIPT_ID_INVALID",
    INVALID_EXECUTOR = "INVALID_EXECUTOR",
    SECURITY_ERROR = "SECURITY_ERROR",
    TIME_ERROR = "TIME_ERROR",
    UNKNOWN_ERROR = "UNKNOWN_ERROR",
    PROJECT_NOT_FOUND = "PROJECT_NOT_FOUND",
    CONNECTION_ERROR = "CONNECTION_ERROR",
}

api.StatusMessages = {
    KEY_VALID = "The provided key is valid.",
    KEY_EXPIRED = "The provided key has expired.",
    KEY_BANNED = "The provided key has been banned.",
    KEY_HWID_LOCKED = "The provided key is locked to a different HWID.",
    KEY_INCORRECT = "The provided key is incorrect.",
    KEY_INVALID = "The provided key is invalid.",
    SCRIPT_ID_INCORRECT = "The provided script ID is incorrect.",
    SCRIPT_ID_INVALID = "The provided script ID is invalid.",
    INVALID_EXECUTOR = "The executor you are using is not supported.",
    SECURITY_ERROR = "A security error has occurred.",
    TIME_ERROR = "There is a time synchronization error between the client and server.",
    UNKNOWN_ERROR = "An unknown error has occurred.",
    PROJECT_NOT_FOUND = "The project was not found.",
    CONNECTION_ERROR = "Failed to connect to the server.",
}

-- ============================================
-- KONFIGURACJA
-- ============================================
api.script_id = ""
api._api_url = "https://api.aaa3.dev/api/roblox/key-system/"
api._key_page_url = "https://ads.aaa3.dev"
api._cached_hwid = nil

-- ============================================
-- SERWISY
-- ============================================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")

-- ============================================
-- FUNKCJE POMOCNICZE
-- ============================================

function api.get_hwid()
    if api._cached_hwid then
        return api._cached_hwid
    end

    local hwid = ""

    pcall(function()
        hwid = RbxAnalyticsService:GetClientId()
    end)

    if hwid == "" then
        pcall(function()
            local player = Players.LocalPlayer
            hwid = tostring(player.UserId) .. "_" .. tostring(game.PlaceId)
        end)
    end

    local hash = 0
    for i = 1, #hwid do
        hash = (hash * 31 + string.byte(hwid, i)) % 0xFFFFFFFF
    end

    api._cached_hwid = string.format("%08X", hash)
    print(api._cached_hwid)
    return api._cached_hwid
end

local function httpRequest(url)
    -- Synapse/Sirius
    if syn and syn.request then
        local ok, response = pcall(syn.request, { Url = url, Method = "GET" })
        if ok and response then
            local ok2, data = pcall(HttpService.JSONDecode, HttpService, response.Body)
            if ok2 then return data end
        end
    end

    -- Inne executory
    if request then
        local ok, response = pcall(request, { Url = url, Method = "GET" })
        if ok and response then
            local ok2, data = pcall(HttpService.JSONDecode, HttpService, response.Body)
            if ok2 then return data end
        end
    end

    if http_request then
        local ok, response = pcall(http_request, { Url = url, Method = "GET" })
        if ok and response then
            local ok2, data = pcall(HttpService.JSONDecode, HttpService, response.Body)
            if ok2 then return data end
        end
    end

    -- Fallback
    local ok, response = pcall(HttpService.GetAsync, HttpService, url)
    if ok then
        local ok2, data = pcall(HttpService.JSONDecode, HttpService, response)
        if ok2 then return data end
    end

    return nil
end

-- ============================================
-- API PUBLICZNE
-- ============================================

--[[
    Weryfikuje klucz.

    @param key string - Klucz do weryfikacji
    @return table - { status: string, message: string, success: boolean, data?: table }
]]
function api.check_key(key)
    if not api.script_id or api.script_id == "" then
        return {
            status = api.StatusCodes.SCRIPT_ID_INVALID,
            message = api.StatusMessages.SCRIPT_ID_INVALID,
            success = false
        }
    end

    if not key or key == "" then
        return {
            status = api.StatusCodes.KEY_INVALID,
            message = api.StatusMessages.KEY_INVALID,
            success = false
        }
    end

    local hwid = api.get_hwid()
    print("apihwid", hwid)

    local url = string.format(
        "%sverify?key=%s&hwid=%s&for=%s",
        api._api_url,
        key,
        hwid,
        api.script_id
    )

    local response = httpRequest(url)

    if not response then
        return {
            status = api.StatusCodes.CONNECTION_ERROR,
            message = api.StatusMessages.CONNECTION_ERROR,
            success = false
        }
    end

    if response.valid then
        return {
            status = api.StatusCodes.KEY_VALID,
            message = api.StatusMessages.KEY_VALID,
            success = true,
            data = {
                hwid = response.hwid,
                project_id = response.project_id,
                project_name = response.project_name,
                time_left_seconds = response.time_left_seconds,
                expires = response.expires,
            }
        }
    end

    -- Mapuj bledy na StatusCodes
    local error_msg = response.error or ""

    if error_msg:find("Project not found") then
        return {
            status = api.StatusCodes.PROJECT_NOT_FOUND,
            message = api.StatusMessages.PROJECT_NOT_FOUND,
            success = false
        }
    elseif error_msg:find("Invalid key") or error_msg:find("Key not found") then
        return {
            status = api.StatusCodes.KEY_INCORRECT,
            message = api.StatusMessages.KEY_INCORRECT,
            success = false
        }
    elseif error_msg:find("expired") then
        return {
            status = api.StatusCodes.KEY_EXPIRED,
            message = api.StatusMessages.KEY_EXPIRED,
            success = false
        }
    elseif error_msg:find("HWID") then
        return {
            status = api.StatusCodes.KEY_HWID_LOCKED,
            message = api.StatusMessages.KEY_HWID_LOCKED,
            success = false,
            data = {
                hwid_reset_available = response.hwid_reset_available
            }
        }
    elseif error_msg:find("banned") then
        return {
            status = api.StatusCodes.KEY_BANNED,
            message = api.StatusMessages.KEY_BANNED,
            success = false
        }
    else
        return {
            status = api.StatusCodes.UNKNOWN_ERROR,
            message = error_msg ~= "" and error_msg or api.StatusMessages.UNKNOWN_ERROR,
            success = false
        }
    end
end

--[[
    Sprawdza status klucza (bez przypisywania HWID).
]]
function api.get_key_status(key)
    if not api.script_id or api.script_id == "" then
        return {
            status = api.StatusCodes.SCRIPT_ID_INVALID,
            message = api.StatusMessages.SCRIPT_ID_INVALID,
            success = false
        }
    end

    if not key or key == "" then
        return {
            status = api.StatusCodes.KEY_INVALID,
            message = api.StatusMessages.KEY_INVALID,
            success = false
        }
    end

    local url = string.format(
        "%sstatus?key=%s&for=%s",
        api._api_url,
        key,
        api.script_id
    )

    local response = httpRequest(url)

    if not response then
        return {
            status = api.StatusCodes.CONNECTION_ERROR,
            message = api.StatusMessages.CONNECTION_ERROR,
            success = false
        }
    end

    if not response.exists then
        return {
            status = api.StatusCodes.KEY_INCORRECT,
            message = api.StatusMessages.KEY_INCORRECT,
            success = false
        }
    end

    if response.is_expired then
        return {
            status = api.StatusCodes.KEY_EXPIRED,
            message = api.StatusMessages.KEY_EXPIRED,
            success = false,
            data = response
        }
    end

    return {
        status = api.StatusCodes.KEY_VALID,
        message = api.StatusMessages.KEY_VALID,
        success = true,
        data = {
            exists = response.exists,
            is_used = response.is_used,
            is_expired = response.is_expired,
            hwid = response.hwid,
            time_left_seconds = response.time_left_seconds,
            created = response.created,
            last_used = response.last_used,
        }
    }
end

--[[
    Pobiera informacje o projekcie.
]]
function api.get_project_info()
    if not api.script_id or api.script_id == "" then
        return {
            status = api.StatusCodes.SCRIPT_ID_INVALID,
            message = api.StatusMessages.SCRIPT_ID_INVALID,
            success = false
        }
    end

    local url = string.format(
        "%sproject-info?for=%s",
        api._api_url,
        api.script_id
    )

    local response = httpRequest(url)

    if not response then
        return {
            status = api.StatusCodes.CONNECTION_ERROR,
            message = api.StatusMessages.CONNECTION_ERROR,
            success = false
        }
    end

    if not response.found then
        return {
            status = api.StatusCodes.PROJECT_NOT_FOUND,
            message = api.StatusMessages.PROJECT_NOT_FOUND,
            success = false
        }
    end

    return {
        status = api.StatusCodes.KEY_VALID,
        message = "Project found.",
        success = true,
        data = {
            name = response.name,
            public_id = response.public_id,
            allow_hwid_reset = response.allow_hwid_reset,
            hwid_cooldown_days = response.hwid_cooldown_days,
        }
    }
end

--[[
    Resetuje HWID dla klucza.
]]
function api.reset_hwid(key)
    if not api.script_id or api.script_id == "" then
        return {
            status = api.StatusCodes.SCRIPT_ID_INVALID,
            message = api.StatusMessages.SCRIPT_ID_INVALID,
            success = false
        }
    end

    local new_hwid = api.get_hwid()

    local url = string.format(
        "%sreset-hwid?key=%s&new_hwid=%s&for=%s",
        api._api_url,
        key,
        new_hwid,
        api.script_id
    )

    local response = httpRequest(url)

    if not response then
        return {
            status = api.StatusCodes.CONNECTION_ERROR,
            message = api.StatusMessages.CONNECTION_ERROR,
            success = false
        }
    end

    if response.success then
        return {
            status = api.StatusCodes.KEY_VALID,
            message = "HWID reset successful.",
            success = true,
            data = { hwid = response.hwid }
        }
    end

    local error_msg = response.error or ""

    if error_msg:find("cooldown") then
        return {
            status = api.StatusCodes.TIME_ERROR,
            message = "HWID reset on cooldown.",
            success = false,
            data = { cooldown_remaining_seconds = response.cooldown_remaining_seconds }
        }
    elseif error_msg:find("not allowed") then
        return {
            status = api.StatusCodes.SECURITY_ERROR,
            message = "HWID reset not allowed for this project.",
            success = false
        }
    else
        return {
            status = api.StatusCodes.UNKNOWN_ERROR,
            message = error_msg ~= "" and error_msg or api.StatusMessages.UNKNOWN_ERROR,
            success = false
        }
    end
end

-- ============================================
-- FUNKCJE POMOCNICZE
-- ============================================

function api.get_key_page_url()
    return string.format(
        "%s/?for=%s&hwid=%s",
        api._key_page_url,
        api.script_id,
        api.get_hwid()
    )
end

function api.copy_key_url()
    local url = api.get_key_page_url()
    pcall(function()
        setclipboard(url)
    end)
    return url
end

-- ============================================
-- ZAPIS/ODCZYT KLUCZA
-- ============================================

function api.save_key(key)
    pcall(function()
        if not isfolder("aaa3hub") then
            makefolder("aaa3hub")
        end
        writefile("aaa3hub/" .. api.script_id .. ".key", key)
    end)
end

function api.load_saved_key()
    local saved_key = nil
    pcall(function()
        if isfolder and isfolder("aaa3hub") then
            if isfile and isfile("aaa3hub/" .. api.script_id .. ".key") then
                saved_key = readfile("aaa3hub/" .. api.script_id .. ".key")
            end
        end
    end)
    return saved_key
end

function api.clear_saved_key()
    pcall(function()
        if isfile and isfile("aaa3hub/" .. api.script_id .. ".key") then
            delfile("aaa3hub/" .. api.script_id .. ".key")
        end
    end)
end

function api.check_key_and_save(key, auto_save)
    if auto_save == nil then auto_save = true end
    local result = api.check_key(key)
    if result.success and auto_save then
        api.save_key(key)
    end
    return result
end

function api.check_saved_key()
    local saved_key = api.load_saved_key()

    if not saved_key or saved_key == "" then
        return {
            has_valid_key = false,
            status = api.StatusCodes.KEY_INVALID,
            message = "No saved key found."
        }
    end

    local result = api.check_key(saved_key)

    return {
        has_valid_key = result.success,
        key = saved_key,
        status = result.status,
        message = result.message,
        data = result.data
    }
end

-- ============================================
-- INICJALIZACJA
-- ============================================

if getgenv and getgenv().PROJECT_ID then
    api.script_id = getgenv().PROJECT_ID
end

if getgenv and getgenv().SCRIPT_ID then
    api.script_id = getgenv().SCRIPT_ID
end
if getgenv and getgenv().DefaultGui then
    api.LoadGUI = getgenv().DefaultGui
end
if getgenv and getgenv().getHWID then
    api.hwid = getgenv().getHWID
    print(api.hwid)
end

return api

--[[
    PRZYKLADY UZYCIA:

    local api = loadstring(game:HttpGet("https://api.aaa3.dev/loaderv2"))()
    api.script_id = "my_project_123"

    -- Weryfikacja klucza
    local result = api.check_key("XXXX-XXXX-XXXX-XXXX")

    if result.status == api.StatusCodes.KEY_VALID then
        print("Klucz poprawny!")
        print("Pozostalo:", result.data.time_left_seconds, "s")
        -- uruchom skrypt

    elseif result.status == api.StatusCodes.KEY_EXPIRED then
        print("Klucz wygasl!")

    elseif result.status == api.StatusCodes.KEY_HWID_LOCKED then
        print("Klucz przypisany do innego HWID!")

    elseif result.status == api.StatusCodes.KEY_INCORRECT then
        print("Nieprawidlowy klucz!")

    elseif result.status == api.StatusCodes.PROJECT_NOT_FOUND then
        print("Projekt nie istnieje!")

    else
        print("Blad:", result.message)
    end

    -- Z automatycznym zapisem
    local result = api.check_key_and_save("XXXX-XXXX-XXXX-XXXX")

    -- Sprawdz zapisany klucz
    local check = api.check_saved_key()
    if check.has_valid_key then
        print("Masz wazny klucz!")
    else
        print("Pobierz klucz:", api.copy_key_url())
    end
]]
