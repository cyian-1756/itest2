function register_storage(node_info)

    minetest.register_node("itest2:" .. node_info.node_name,
        {description=node_info.description,
        groups={cracky=2, energy=1},
        paramtype2 = "facedir",
        legacy_facedir_simple = true,
        tiles = node_info.tiles,
        on_construct = function(pos)
          tech_api.energy.on_construct(pos)
        end,
        on_destruct = function(pos)
          tech_api.energy.on_destruct(pos)
      end,
    })

    -- also register the storage device as a transporter
    tech_api.energy.register_transporter("itest2:" .. node_info.node_name, {
      class = 'default',
      callback = function(new_connected_faces)

      end
    })

    tech_api.energy.register_device("itest2:" .. node_info.node_name, "default", {
      class = { 'default' },
      type = 'storage',
      max_rate = node_info.max_rate,
      capacity = node_info.capacity,
      linkable_faces = {'back', 'top', 'left', 'right', 'bottom'},
      callback = function(pos, dtime, storage_info)
        minetest.get_meta(pos):set_string("infotext", "content=" .. storage_info.content / 1000 .. "/" .. storage_info.capacity / 1000 .. "KEU - current rate=" .. storage_info.current_rate .. "EU/t")
        return 0, 1 -- next callback (update) in 4 time units
      end
    })
end

function register_solarpanel(node_info)

    minetest.register_node("itest2:" .. node_info.node_name,
        {description=node_info.description,
        groups={cracky=2, energy=1},
        tiles = node_info.tiles,
        on_construct = function(pos)
          tech_api.energy.on_construct(pos)
        end,
        on_destruct = function(pos)
          tech_api.energy.on_destruct(pos)
      end,
    })

    tech_api.energy.register_device("itest2:" .. node_info.node_name, "default", {
      class = { 'default' },
      type = 'provider',
      max_rate = node_info.max_rate,
      linkable_faces = {'back', 'left', 'right', 'bottom'},
      callback = function(pos, dtime, request)
          local l=minetest.env:get_node_light({x=pos.x, y=pos.y+1, z=pos.z})
          local produce
          if not l or l < 15 then
             produce = 0
          else
             produce = math.min(request, node_info.max_rate)
          end
          minetest.get_meta(pos):set_string("infotext", "request=" .. request .. "EU/t - producing=" .. produce .. "EU/t")
          return produce, 8 -- return energy produced, and ask next callback within 8 time units
      end
    })
end

function register_fluid_cell(node_info)
    minetest.register_craftitem("itest2:" .. node_info.name, {
        description = node_info.description,
        inventory_image = node_info.inventory_image,
        stack_max = 99,
        groups = node_info.groups,
        })
end
