tech_api.energy.register_device("itest2:monitor", "default", {
    class = { 'default' },
    type = 'monitor',
    linkable_faces = {'back', 'top', 'left', 'right', 'bottom'},
    callback = function(pos, dtime, network_info)
        local infostring = "request = " .. network_info.request .. "\n"
        infostring = infostring .. "provider available = " .. network_info.provider_available .. "EU; total available = " .. network_info.total_available .. "EU\n"
        infostring = infostring .. "total storage = " .. network_info.total_content / 1000 .. "KEU/" .. network_info.total_capacity /1000 .. "KEU\n"
        infostring = infostring .. "total usage = " .. network_info.usage .. "\n"
        infostring = infostring .. "storages rate = " .. network_info.storages_rate .. "\n"
        minetest.get_meta(pos):set_string("infotext", infostring)
        return 1 -- next callback (update) in 4 time units
    end
})

minetest.register_node("itest2:monitor", {
    groups = { snappy = 1 },
    paramtype2 = "facedir",
    on_construct = function(pos)
        tech_api.energy.on_construct(pos)
    end,
    on_destruct = function(pos)
        tech_api.energy.on_destruct(pos)
    end
})

