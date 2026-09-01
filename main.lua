-- SERENITY HUB // FULL PRO UI WITH TOGGLE BUTTON (FIXED)
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("SerenityHub_Pro") then
    playerGui.SerenityHub_Pro:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SerenityHub_Pro"
ScreenGui.Parent = playerGui
ScreenGui.ResetOnSpawn = false

-- 1. NÚT BẬT/TẮT MENU (Icon nhỏ ở cạnh màn hình, kéo thả được)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
ToggleButton.Position = UDim2.new(0.5, -215, 0.5, -180)
ToggleButton.Size = UDim2.new(0, 42, 0, 42)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "SR"
ToggleButton.TextColor3 = Color3.fromRGB(0, 229, 255)
ToggleButton.TextSize = 14
ToggleButton.Active = true
ToggleButton.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

-- 2. KHUNG MENU CHÍNH
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 24)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -140)
MainFrame.Size = UDim2.new(0, 460, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true -- Mặc định bật lên khi chạy script

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- SỬA LẠI SỰ KIỆN BẬT/TẮT MENU CHÍNH CHO CHUẨN XÁC
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- 3. THANH SIDEBAR BÊN TRÁI
local Sidebar = Instance.new("Frame")
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
Sidebar.Size = UDim2.new(0, 130, 1, 0)
Sidebar.BorderSizePixel = 0

local LogoTitle = Instance.new("TextLabel")
LogoTitle.Parent = Sidebar
LogoTitle.BackgroundTransparency = 1
LogoTitle.Position = UDim2.new(0, 10, 0, 12)
LogoTitle.Size = UDim2.new(1, -20, 0, 25)
LogoTitle.Font = Enum.Font.GothamBold
LogoTitle.Text = "SERENITY"
LogoTitle.TextColor3 = Color3.fromRGB(0, 229, 255)
LogoTitle.TextSize = 14
LogoTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Nút Đóng (X) hoàn toàn giao diện
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
CloseBtn.Position = UDim2.new(1, -28, 0, 8)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- 4. KHU VỰC NỘI DUNG VÀ TAB
local ContainerHolder = Instance.new("Frame")
ContainerHolder.Parent = MainFrame
ContainerHolder.BackgroundTransparency = 1
ContainerHolder.Position = UDim2.new(0, 140, 0, 40)
ContainerHolder.Size = UDim2.new(1, -150, 1, -50)

local Pages = {}
local function CreatePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Parent = ContainerHolder
    page.Active = true
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.ScrollBarThickness = 3
    page.Visible = false
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = page
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    
    Pages[name] = page
    return page
end

local TabHolder = Instance.new("Frame")
TabHolder.Parent = Sidebar
TabHolder.BackgroundTransparency = 1
TabHolder.Position = UDim2.new(0, 0, 0, 45)
TabHolder.Size = UDim2.new(1, 0, 1, -45)

local TabHolderLayout = Instance.new("UIListLayout")
TabHolderLayout.Parent = TabHolder
TabHolderLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabHolderLayout.Padding = UDim.new(0, 4)

local function AddTabButton(tabName, pageName)
    local btn = Instance.new("TextButton")
    btn.Parent = TabHolder
    btn.BackgroundTransparency = 1
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Font = Enum.Font.GothamMedium
    btn.Text = "    " .. tabName
    btn.TextColor3 = Color3.fromRGB(160, 160, 170)
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        Pages[pageName].Visible = true
        for _, b in pairs(TabHolder:GetChildren()) do
            if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(160, 160, 170) end
        end
        btn.TextColor3 = Color3.fromRGB(0, 229, 255)
    end)
end

CreatePage("Dashboard")
CreatePage("Vision")

AddTabButton("📊 Dashboard", "Dashboard")
AddTabButton("👁️ Vision", "Vision")
Pages["Dashboard"].Visible = true

local function AddToggleToPage(page, titleText, callback)
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Parent = page
    toggleBtn.BackgroundColor3 = Color3.fromRGB(28, 31, 38)
    toggleBtn.Size = UDim2.new(1, -5, 0, 35)
    toggleBtn.Font = Enum.Font.GothamMedium
    toggleBtn.Text = "  " .. titleText
    toggleBtn.TextColor3 = Color3.fromRGB(230, 230, 240)
    toggleBtn.TextSize = 12
    toggleBtn.TextXAlignment = Enum.TextXAlignment.Left
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = toggleBtn
    
    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        if state then
            toggleBtn.TextColor3 = Color3.fromRGB(0, 255, 128)
            toggleBtn.Text = "  " .. titleText .. " [ON]"
        else
            toggleBtn.TextColor3 = Color3.fromRGB(230, 230, 240)
            toggleBtn.Text = "  " .. titleText .. " [OFF]"
        end
        pcall(function() callback(state) end)
    end)
end

AddToggleToPage(Pages["Vision"], "Answer ESP (Ghi nhớ & Tô Nhanh)", function(state)
    local player = game:GetService("Players").LocalPlayer
    local playerGui = player:FindFirstChild("PlayerGui")
    
    if state then
        print("[Serenity Hub] Đã bật chế độ hỗ trợ gán đáp án thủ công siêu tốc!")
        if playerGui then
            for _, obj in pairs(playerGui:GetDescendants()) do
                -- Lọc các ô tròn đáp án A, B, C, D trên phiếu trả lời
                if obj:IsA("TextButton") or obj:IsA("ImageButton") then
                    local name = obj.Name:lower()
                    if name:match("^[abcd]$") or name:find("choice") or name:find("answer") then
                        -- Khi bấm vào bất kỳ ô nào, tự động tô sáng và lưu lại là đáp án đã chọn
                        if not obj:FindFirstChild("Manual_Connection") then
                            local conn = obj.MouseButton1Click:Connect(function()
                                -- Xóa viền các ô khác trong cùng câu, chỉ giữ lại ô này
                                local parent = obj.Parent
                                if parent then
                                    for _, sibling in pairs(parent:GetChildren()) do
                                        local oldStroke = sibling:FindFirstChild("Manual_ESP")
                                        if oldStroke then oldStroke:Destroy() end
                                    end
                                end
                                
                                -- Tạo viền xanh lá cực nổi bật cho ô vừa chọn
                                local stroke = Instance.new("UIStroke")
                                stroke.Name = "Manual_ESP"
                                stroke.Color = Color3.fromRGB(0, 255, 128)
                                stroke.Thickness = 3.5
                                stroke.Parent = obj
                            end)
                            
                            -- Đánh dấu đã gắn sự kiện
                            local marker = Instance.new("BoolValue")
                            marker.Name = "Manual_Connection"
                            marker.Parent = obj
                        end
                    end
                end
            end
        end
    else
        print("[Serenity Hub] Đã tắt chế độ ghi nhớ.")
        if playerGui then
            for _, obj in pairs(playerGui:GetDescendants()) do
                local stroke = obj:FindFirstChild("Manual_ESP")
                if stroke then stroke:Destroy() end
            end
        end
    end
end)

AddToggleToPage(Pages["Vision"], "Visual Classes", function(state)
    local players = game:GetService("Players")
    local lp = players.LocalPlayer
    for _, p in pairs(players:GetPlayers()) do
        if p ~= lp and p.Character then
            if state then
                if not p.Character:FindFirstChild("Player_Highlight") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "Player_Highlight"
                    hl.Parent = p.Character
                    hl.FillColor = Color3.fromRGB(0, 150, 255)
                    hl.FillTransparency = 0.5
                end
            else
                if p.Character:FindFirstChild("Player_Highlight") then
                    p.Character.Player_Highlight:Destroy()
                end
            end
        end
    end
end)

AddToggleToPage(Pages["Vision"], "Teacher ESP (Tìm giáo viên)", function(state)
    local workspace = game:GetService("Workspace")
    if state then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (obj.Name:lower():find("teacher") or obj.Name:lower():find("gv") or obj.Name:lower():find("giao vien")) then
                if not obj:FindFirstChild("ESP_Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP_Highlight"
                    highlight.Parent = obj
                    highlight.FillColor = Color3.fromRGB(255, 50, 50)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.4
                end
            end
        end
    else
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name == "ESP_Highlight" then
                obj:Destroy()
            end
        end
    end
end)
