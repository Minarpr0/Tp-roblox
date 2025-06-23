local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local flingEnabled = false
local spin, velocityForce

-- Create GUI button
local gui = Instance.new("ScreenGui", localPlayer:WaitForChild("PlayerGui"))
gui.Name = "SpinFlingGUI"

local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0, 130, 0, 40)
button.Position = UDim2.new(1, -140, 0, 10)
button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
button.TextColor3 = Color3.new(1, 1, 1)
button.Text = "Spin-Fling OFF"

-- Enable fling
local function enableFling()
	if flingEnabled then return end
	flingEnabled = true
	button.Text = "Spin-Fling ON"

	-- Create spin
	spin = Instance.new("BodyAngularVelocity")
	spin.AngularVelocity = Vector3.new(0, 100, 0) -- spin faster
	spin.MaxTorque = Vector3.new(0, math.huge, 0)
	spin.P = 1250
	spin.Parent = hrp

	-- Create velocity to launch you around
	velocityForce = Instance.new("BodyVelocity")
	velocityForce.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	velocityForce.Velocity = Vector3.new(150, 0, 150) -- diagonally forward
	velocityForce.P = 5000
	velocityForce.Parent = hrp
end

-- Disable fling
local function disableFling()
	flingEnabled = false
	button.Text = "Spin-Fling OFF"

	if spin then spin:Destroy() end
	if velocityForce then velocityForce:Destroy() end
end

-- Toggle on click
button.MouseButton1Click:Connect(function()
	if flingEnabled then
		disableFling()
	else
		enableFling()
	end
end)

-- Reapply if character respawns
localPlayer.CharacterAdded:Connect(function(char)
	character = char
	hrp = character:WaitForChild("HumanoidRootPart")
end)
