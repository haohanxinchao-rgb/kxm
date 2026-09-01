-- Tạo một menu giao diện đơn giản có thể kéo thả
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")

-- Thiết lập ScreenGui
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "KXH_SimpleMenu"

-- Khung chính của Menu
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -100)
MainFrame.Size = UDim2.new(0, 250, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true -- Giúp bạn có thể bấm giữ và kéo menu đi quanh màn hình

-- Tiêu đề Menu
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "KXH Hub - Menu Tạm"
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold

-- Nút đóng Menu
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "X"
CloseButton.TextSize = 14
CloseButton.Font = Enum.Font.SourceSansBold

-- Sự kiện bấm nút X để ẩn menu
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
