print("KXH Hub đã chạy thành công!")

-- Tạo một thông báo nhỏ trong game để kiểm chứng
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "KXH Hub",
    Text = "Load thành công từ main.lua!",
    Duration = 5
})
