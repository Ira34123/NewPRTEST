local modified_parts = {};
local touched_parts = {}
local feature = Feature:new("noclip", game:GetService("RunService").Stepped, LPH_NO_VIRTUALIZE(function()
    if is_chime and aztup.flags.chime_safety then
        return aztup_toggles.noclip:SetValue(false)    
end;
    
    if not local_player.character then
        return    
end;

    if aztup.flags.dont_noclip_while_knocked and EffectReplicator:HasEffect("Knocked") then
           for _, modified_part in modified_parts do
        if modified_part then
            modified_part.CanCollide = true;
        end
    end;

    for part, table in pairs(touched_parts) do
        if part then
            part.CanTouch = table[1]
            part.CanQuery = table[2]
        end
    end

    table.clear(modified_parts);
    table.clear(touched_parts)
        return    
end;

        if not EffectReplicator:FindEffect("TPSafe") then
            EffectReplicator:CreateEffect("TPSafe");
        end;
    
        local body_parts = {
        local_player.character:FindFirstChild("Head"),
        local_player.character:FindFirstChild("HumanoidRootPart"),
    }

    for _, part in local_player.character:QueryDescendants('BasePart[CanCollide = true]') do 
        part.CanCollide = false; 
             
        if not table.find(modified_parts, part) then 
            table.insert(modified_parts, part); 
        end; 
    end;

    
    for _, body_part in ipairs(body_parts) do
        if body_part then
            local touching = body_part:GetTouchingParts()
    
            if #touching > 0 then
                for _, part in ipairs(touching) do
                    if part.CanCollide then
                        part.CanCollide = false
                        local cantouch = part.CanTouch 
                        part.CanTouch = false
                    
                        local canquery = part.CanQuery 
                        part.CanQuery = false
                        
    
                        if not table.find(modified_parts, part) then
                            table.insert(modified_parts, part)
                        end

                        if not touched_parts[part] then
                            touched_parts[part] = {cantouch, canquery}
                        end
                    end
                end
            end
        end
    end


    return
end));

function feature:disable()
    for _, modified_part in modified_parts do
        if modified_part then
            modified_part.CanCollide = true;
        end
    end;

    for part, table in pairs(touched_parts) do
        if part then
            part.CanTouch = table[1]
            part.CanQuery = table[2]
        end
    end

    table.clear(modified_parts);
    table.clear(touched_parts)
end;

return feature
