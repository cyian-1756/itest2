minetest.register_node("itest2:quarry", {
    description = "Quarry",
    tiles = {"itest_generator_side.png"},
    groups = {cracky = 2, tubedevice = 1, energy = 1},
     paramtype2 = "facedir",
    is_ground_content = false,

    on_construct = function(pos)
        tech_api.energy.on_construct(pos)
        local meta = minetest.get_meta(pos)
        meta:set_int("dig_time", 0)
        local inv = meta:get_inventory()
        inv:set_size("dst", 12)
        meta:set_string("formspec",
          "size[8,9;]\n" ..
          "list[context;dst;0,1;4,3;]"..
          "list[current_player;main;0,5;8,4;]"
        )
    end,
    on_destruct = function(pos)
      tech_api.energy.on_destruct(pos)
    end,
})

minetest.register_node("itest2:quarry_iron_tip", {
    description = "Quarry",
    tiles = {"itest_generator_side.png"},
    groups = {cracky = 2, tubedevice = 1, energy = 1},
     paramtype2 = "facedir",
    is_ground_content = false,

    on_construct = function(pos)
        tech_api.energy.on_construct(pos)
        local meta = minetest.get_meta(pos)
        meta:set_int("dig_time", 0)
        local inv = meta:get_inventory()
        inv:set_size("dst", 12)
        meta:set_string("formspec",
          "size[8,9;]\n" ..
          "list[context;dst;0,1;4,3;]"..
          "list[current_player;main;0,5;8,4;]"
        )
    end,
    on_destruct = function(pos)
      tech_api.energy.on_destruct(pos)
    end,
})

local function qdig_node(pos, node_to_dig, dig_sideways, dig_forward, dig_y, node)
    local meta = minetest.get_meta(pos)
    local inv = meta:get_inventory()
    local drops = minetest.get_node_drops(node_to_dig.name, "")
        for _, dropped_item_ in ipairs(drops) do
            inv:add_item("dst", dropped_item)
        end
    minetest.remove_node({x = pos.x + dig_sideways, y=pos.y - dig_y, z=pos.z + dig_forward})
    return true
end

-- This returns true if it dug a node and false otherwise

local function quarry_dig(pos)
    local node = minetest.get_node(pos)
    local facedir_table = minetest.facedir_to_dir(node.param2)
    if facedir_table.x == 1 then
        for dig_y = 1, 300 do
            for dig_forward = 1, 10 do
                for dig_sideways = -5, 5 do
                    local node_to_dig = minetest.get_node({x = pos.x + dig_forward, y=pos.y - dig_y, z=pos.z + dig_sideways})
                    if node_to_dig.name ~= "air" then
                        return qdig_node(pos, node_to_dig, dig_sideways, dig_forward, dig_y, node)
                    end
                end
            end
        end
    elseif facedir_table.x == -1 then
        for dig_y = 1, 100 do
            for dig_forward = 1, 10 do
                for dig_sideways = -5, 5 do
                    local node_to_dig = minetest.get_node({x = pos.x-dig_forward, y=pos.y - dig_y, z=pos.z - dig_sideways})
                    if node_to_dig.name ~= "air" then
                        return qdig_node(pos, node_to_dig, dig_sideways, dig_forward, dig_y, node)
                    end
                end
            end
        end
    elseif facedir_table.z == 1 then
        for dig_y = 1, 100 do
            for dig_forward = 1, 10 do
                for dig_sideways = -5, 5 do
                    local node_to_dig = minetest.get_node({x = pos.x + dig_sideways, y=pos.y - dig_y, z=pos.z + dig_forward})
                    if node_to_dig.name ~= "air" then
                        return qdig_node(pos, node_to_dig, dig_sideways, dig_forward, dig_y, node)
                    end
                end
            end
        end
    elseif facedir_table.z == -1 then
        for dig_y = 1, 100 do
            for dig_forward = 1, 10 do
                for dig_sideways = -5, 5 do
                    local node_to_dig = minetest.get_node({x = pos.x - dig_sideways, y=pos.y - dig_y, z=pos.z - dig_forward})
                    if node_to_dig.name ~= "air" then
                        return qdig_node(pos, node_to_dig, dig_sideways, dig_forward, dig_y, node)
                    end
                end
            end
        end
    end
    return false
end

local quarry_config = {
    ticks_between_dig = 1,
    EU_per_node = 1024,
    max_rate = 2000
}

local quarry_iron_tip_config = {
    ticks_between_dig = 10,
    EU_per_node = 1024,
    max_rate = 2000
}

tech_api.energy.register_device("itest2:quarry", "default", {
    type = 'user',
    max_rate = quarry_config.max_rate,
    linkable_faces = {'back', 'top', 'left', 'right', 'bottom'},
    callback = function(pos, dtime, available)
        local can_consume = math.min(available, quarry_config.EU_per_node)
        local facedir_table = minetest.facedir_to_dir(minetest.get_node(pos).param2)
        if can_consume >= quarry_config.EU_per_node then
            local meta = minetest.get_meta(pos)
            if meta:get_int("dig_time") >= quarry_config.ticks_between_dig then
                if quarry_dig(pos) == true then

                    meta:set_int("dig_time", 0)
                    return quarry_config.EU_per_node, can_consume, 1
                else
                    return quarry_config.EU_per_node, 0, 1
                end
            else
                local i = meta:get_int("dig_time") + 1
                meta:set_int("dig_time", i)
                return quarry_config.EU_per_node, 0, 1
            end
        else
            return quarry_config.EU_per_node, 0, 1
        end
  end
})

tech_api.energy.register_device("itest2:quarry_iron_tip", "default", {
    type = 'user',
    max_rate = quarry_iron_tip_config.max_rate,
    linkable_faces = {'back', 'top', 'left', 'right', 'bottom'},
    callback = function(pos, dtime, available)
        local can_consume = math.min(available, quarry_iron_tip_config.EU_per_node)
        local facedir_table = minetest.facedir_to_dir(minetest.get_node(pos).param2)
        if can_consume >= quarry_iron_tip_config.EU_per_node then
            local meta = minetest.get_meta(pos)
            if meta:get_int("dig_time") >= quarry_iron_tip_config.ticks_between_dig then
                if quarry_dig(pos) == true then

                    meta:set_int("dig_time", 0)
                    return quarry_iron_tip_config.EU_per_node, can_consume, 1
                else
                    return quarry_iron_tip_config.EU_per_node, 0, 1
                end
            else
                local i = meta:get_int("dig_time") + 1
                meta:set_int("dig_time", i)
                return quarry_iron_tip_config.EU_per_node, 0, 1
            end
        else
            return quarry_iron_tip_config.EU_per_node, 0, 1
        end
  end
})
