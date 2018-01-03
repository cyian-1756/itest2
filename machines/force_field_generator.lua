minetest.register_abm({
    nodenames ={"magic_mod:ward_pillar"},
    interval = 5,
    chance = 1,
    action = function(pos, node, active_object_count, active_object_count_wider)
        for len=1,11 do
            if minetest.get_node({x = pos.x + len, y = pos.y, z = pos.z}).name == "magic_mod:ward_pillar" then
                local ward = len -1
                for var=1,ward do
                    if minetest.get_node({x = pos.x + var, y = pos.y, z = pos.z}).name == "air" then
                        minetest.set_node({x = pos.x + var, y = pos.y, z = pos.z}, {name = "magic_mod:ward_wall"})
                    end
                end
            end
            if minetest.get_node({x = pos.x, y = pos.y, z = pos.z + len}).name == "magic_mod:ward_pillar" then
                local ward = len -1
                for var=1,ward do
                    if minetest.get_node({x = pos.x, y = pos.y, z = pos.z + var}).name == "air" then
                        minetest.set_node({x = pos.x, y = pos.y, z = pos.z + var}, {name = "magic_mod:ward_wall"})
                    end
                end
            end
        end
    end
})

minetest.register_node("itest2:force_field_emitter", {
    groups = {engery=1 },
    paramtype2 = "facedir",
    on_construct = function(pos)
        tech_api.energy.on_construct(pos)
    end,
    on_destruct = function(pos)
        tech_api.energy.on_destruct(pos)
    end
})

tech_api.energy.register_device("itest2:monitor", "default", {
    class = { 'default' },
    type = 'user',
    linkable_faces = {'back', 'top', 'left', 'right', 'bottom'},
    callback = function(pos, dtime, available)

        return 1, 1, 8
    end
})