-- SERENITY HUB // CANONICAL PUBLIC LOADER
if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Trỏ thẳng trực tiếp đến file main.lua kèm chống cache
local url = "https://raw.githubusercontent.com/haohanxinchao-rgb/kxm/refs/heads/main/main.lua?cb=" .. tostring(os.time()) .. tostring(math.random(100000, 999999))

local ok, source = pcall(function()
    return game:HttpGet(url, true)
end)

if not ok or type(source)~="string" or source=="" then
    error("[SERENITY HUB] Current loader is unavailable. Try again in a moment.", 0)
end

local fn, err = loadstring(source, "@SerenityHub/CurrentLoader")
source = nil

if not fn then
    error("[SERENITY HUB] Loader compile failed: "..tostring(err), 0)
end

return fn()
