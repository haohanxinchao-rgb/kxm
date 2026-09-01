-- SERENITY HUB // ADVANCED TAB-BASED UI
local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("SerenityHub_Pro") then
    playerGui.SerenityHub_Pro:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Sidebar = Instance.new("Frame")
local SidebarCorner = Instance.new("UICorner")
local ContainerHolder = Instance.new("Frame")

ScreenGui.Parent = playerGui
ScreenGui.Name = "SerenityHub_Pro"
ScreenGui.ResetOnSpawn = false

-- Khung chính tổng thể
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 20, 24)
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -140)
MainFrame.Size = UDim2.new(0, 460, 0, 280)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Thanh Menu bên trái (Sidebar)
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
Sidebar.Size = UDim2.new(0, 130, 1, 0)
Sidebar.BorderSizePixel = 0

SidebarCorner.CornerRadius = UDim.new(0, 8)
SidebarCorner.Parent = Sidebar

-- Logo hoặc tên Hub trên Sidebar
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

-- Nút đóng giao diện góc phải trên cùng
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
CloseBtn.BackgroundTransparency = 0.2
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

-- Khu vực chứa nội dung các Tab bên phải
ContainerHolder.Parent = MainFrame
ContainerHolder.BackgroundTransparency = 1
ContainerHolder.Position = UDim2.new(0, 140, 0, 40)
ContainerHolder.Size = UDim2.new(1, -150, 1, -50)

-- Tạo các trang Tab (Frames)
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

-- Hàm tạo nút bấm chuyển Tab ở Sidebar
local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = Sidebar
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 4)

-- Đẩy các nút tab xuống dưới một chút so với Logo
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
    btn.BackgroundColor3 = Color3.fromRGB(30, 33, 40)
    btn.BackgroundTransparency = 1
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Font = Enum.Font.GothamMedium
    btn.Text = "   " .. tabName
    btn.TextColor3 = Color3.fromRGB(160, 160, 170)
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(for _, p in pairs(Pages) do p.Visible = false end
        Pages[pageName].Visible = true
        for _, b in pairs(TabHolder:GetChildren()) do
            if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(160, 160, 170) end
        end
        btn.TextColor3 = Color3.fromRGB(0, 229, 255)
    end)
end

-- Khởi tạo trang Dashboard và Vision giống trong video
CreatePage("Dashboard")
CreatePage("Vision")

AddTabButton("📊 Dashboard", "Dashboard")
AddTabButton("👁️ Vision", "Vision")

-- Mặc định mở trang Dashboard đầu tiên
Pages["Dashboard"].Visible = true

-- Hàm mẫu thêm tính năng vào trang (Page)
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
        }
        pcall(function() callback(state) end)
    end)
end

-- Thêm các nút chức năng vào tab Vision (mô phỏng như video)
AddToggleToPage(Pages["Vision"], "Answer ESP (Đáp án)", function(v)
    print("Answer ESP: ", v)
end)

AddToggleToPage(Pages["Vision"], "Visual Classes (Nhìn qua tường)", function(v)
    print("Visual Classes: ", v)
end)

AddToggleToPage(Pages["Vision"], "Teacher ESP (Tìm giáo viên)", function(v)
    print("Teacher ESP: ", v)
end)
