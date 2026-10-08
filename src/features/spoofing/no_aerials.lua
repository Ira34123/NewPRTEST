local feature = Feature:new("no_aerials")

local part
function feature:enable()
  local root = local_player.root_part
  if root and root:FindFirstChild("GroundSensor") then
    if not root.GroundSensor.SensedPart or not lastPart then
        part = Instance.new("Part")
        getgenv().lastPart = part
        root.GroundSensor.SensedPart = part
    end
  end
end

function feature:disable()
  if part then
    part:Destroy()
  end
end

return feature
