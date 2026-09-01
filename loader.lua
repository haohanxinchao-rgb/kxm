local BASE = "https://raw.githubusercontent.com/haohanxinchao-rgb/kxm/main/"
local url = BASE .. "loader.lua?cb=" .. tostring(os.time()) .. tostring(math.random(100000, 999999))

local ok, source = pcall(function()
    return game:HttpGet(url, true)
end)

if not ok or type(source) ~= "string" or source == "" then
    error("Không thể tải script!", 0)
end

local fn, err = loadstring(source, "@MyHub/Main")
if not fn then
    error("Lỗi biên dịch: " .. tostring(err), 0)
end

return fn()
