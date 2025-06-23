local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- Variables to hold spin and fling instances
local spin = nil
local flingEnabled = false

-- Function to enable spin-fling
local function enableSpinFling()
    if spin then return end -- Already enabled
    
    spin = Instance.new("BodyAngularVelocity")
    spin.AngularVelocity = Vector3.new(0, 30, 0)
    spin.MaxTorque = Vector3.new(0, math.huge, 0)
    spin.Parent = hrp
    flingEnabled = true
end

-- Function to disable spin-fling
local function disableSpinFling()
    if spin then
        spin:Destroy()
        spin = nil
    end
    flingEnabled = false
end

-- Connect Touched event only once
hrp.Touched:Connect(function(otherPart)
    if not flingEnabled then return end
    
    local otherChar = otherPart.Parent
    if otherChar and otherChar ~= character then
        local otherHumanoidRoot = otherChar:FindFirstChild("HumanoidRootPart")
        if otherHumanoidRoot then
            local direction = (otherHumanoidRoot.Position - hrp.Position).Unit
            local flingVelocity = direction * 100 + Vector3.new(0, 200, 0)
            otherHumanoidRoot.Velocity = flingVelocity
        end
    end
end)

-- Create the toggle button GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpinFlingToggleGui"
ScreenGui.Parent = localPlayer:WaitForChild("PlayerGui")

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 120, 0, 40)
toggleButton.Position = UDim2.new(1, -130, 0, 10) -- top-right corner with margin
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Text = "Spin-Fling OFF"
toggleButton.Parent = ScreenGui

toggleButton.MouseButton1Click:Connect(function()
    if flingEnabled then
        disableSpinFling()
        toggleButton.Text = "Spin-Fling OFF"
    else
        enableSpinFling()
        toggleButton.Text = "Spin-Fling ON"
    end
end)