local light = {
	description = "Light",
	paramtype2 = "facedir",
    tiles = {"voltbuild_light.png"},
	groups = {energy=1, cracky=2},
    drop = "itest2:light_off",
    on_construct = function(pos)
      tech_api.energy.on_construct(pos)
    end,
    on_destruct = function(pos)
      tech_api.energy.on_destruct(pos)
    end
}

tech_api.energy.register_device("itest2:light_on", "default", {
  class = { 'default' },
  type = 'user',
  max_rate = 2,
  linkable_faces = {'back', 'top', 'left', 'right', 'bottom', "rear"},
  callback = function(pos, dtime, available)
    --   This callback is empty because the call back in light_off is the only one that will ever be run
    -- because swap_node is a bit fucky
  end
})

tech_api.energy.register_device("itest2:light_off", "default", {
    class = { 'default' },
    type = 'user',
    max_rate = 2,
    linkable_faces = {'back', 'top', 'left', 'right', 'bottom'},
    callback = function(pos, dtime, available)
        if available > 0 then
            minetest.swap_node(pos, {name="itest2:light_on"})
            return 1, 1, 8
        else
            minetest.swap_node(pos, {name="itest2:light_off"})
            return 1, 0, 8
        end
  end
})


local light_on = {
	description = "Light",
	tiles = {"voltbuild_light.png"},
	paramtype2 = "facedir",
    light_source = 12,
    drop = "itest2:light_off",
	groups = {energy=1, cracky=2, not_in_creative_inventory=1},
    on_construct = function(pos)
      tech_api.energy.on_construct(pos)
    end,
    on_destruct = function(pos)
      tech_api.energy.on_destruct(pos)
    end
}

minetest.register_node("itest2:light_off", light)
minetest.register_node("itest2:light_on", light_on)
