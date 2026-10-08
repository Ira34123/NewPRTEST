local feature = Feature:new("no_aerials")

local part
function feature:enable()
  print("Enabled")
  local root = local_player.root_part
  if root and root:FindFirstChild("GroundSensor") then
      task.wait(0.1)
      part = Instance.new("Part")
      print("SetPart")
      root.GroundSensor.SensedPart = part
  end
end

function feature:disable()
  if part then
    part:Destroy()
  end
end

return feature
