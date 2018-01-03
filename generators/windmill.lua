
minetest.register_node("itest2:windmill",
    {description="Windmill",
    groups={energy=1, cracky=1},
    tiles={"itest_windmill_top.png", "itest_windmill_top.png", "itest_windmill_side.png"},
    on_construct = function(pos)
        tech_api.energy.on_construct(pos)
    end,
    on_destruct = function(pos)
        tech_api.energy.on_destruct(pos)
    end,
})

tech_api.energy.register_device("itest2:windmill", "default", {
    type = 'provider',
    max_rate = 25,
    linkable_faces = {"bottem", "top", "left", "right"},
    callback = function(pos, dtime, request)
        if pos.y > 50 then
            local produce = math.min(request, 25, math.floor(pos.y/10 + 0.5))
            minetest.get_meta(pos):set_string("infotext", "request=" .. request .. "EU/t - producing=" .. produce .. "EU/t")
            return produce, 60
        else
            minetest.get_meta(pos):set_string("infotext", "Too low to generate power!")
            return 0, -1
        end

  end
})
