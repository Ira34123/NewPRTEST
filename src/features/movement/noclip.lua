local modified_parts = {};
local feature = Feature:new("noclip", game:GetService("RunService").Stepped, LPH_NO_VIRTUALIZE(function()
     local character = local_player.character
    if not character then return end

    for _, v in ipairs(character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
        end
    end
end));

function feature:disable()
   
end;

return feature
