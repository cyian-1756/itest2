minetest.register_node("itest2:watermill",
    {description="Watermill",
    groups={energy=1,cracky=2},
    tiles={"itest_watermill_top.png", "itest_watermill_top.png", "itest_watermill_side.png"},
    on_construct = function(pos)
        tech_api.energy.on_construct(pos)
    end,
    on_destruct = function(pos)
        tech_api.energy.on_destruct(pos)
    end,
})

tech_api.energy.register_device("itest2:watermill", "default", {
    type = 'provider',
    max_rate = 25,
    linkable_faces = {"bottem", "top", "left", "right"},
    callback = function(pos, dtime, request)
        local prod = 0
        for x = pos.x-1, pos.x+1 do
            for y = pos.y-1, pos.y+1 do
                for z = pos.z-1, pos.z+1 do
                    local n = minetest.env:get_node({x=x,y=y,z=z})
                    if n.name == "default:water_source" or n.name == "default:water_flowing" then
                        prod = prod+1
                    end
                end
            end
        end
        local produce = math.min(prod, 25)
        minetest.get_meta(pos):set_string("infotext", "request=" .. request .. "EU/t - producing=" .. produce .. "EU/t")
        return produce, 8
  end
})
