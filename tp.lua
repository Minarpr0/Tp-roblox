local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local teleportDistance = 10

-- Create the button
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ForwardButtonGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 120, 0, 50)
button.Position = UDim2.new(1, -130, 0.5, -25)  -- Right side, middle height
button.AnchorPoint = Vector2.new(1, 0.5)
button.Text = "Forward"
button.Font = Enum.Font.SourceSansBold
button.TextSize = 24
button.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
button.TextColor3 = Color3.new(1,1,1)
button.Parent = screenGui

-- Function to teleport forward
local function teleportForward()
    -- Update character and HumanoidRootPart in case of respawn
    character = player.Character
    if not character then return end
    humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local lookVector = humanoidRootPart.CFrame.LookVector
    local newPosition = humanoidRootPart.Position + (lookVector * teleportDistance)
    humanoidRootPart.CFrame = CFrame.new(newPosition, newPosition + lookVector)
end

button.MouseButton1Click:Connect(teleportForward)