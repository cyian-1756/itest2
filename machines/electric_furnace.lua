
-- this file is basically a modified copy of
-- minetest_game/mods/default/furnaces.lua

local fs_helpers = pipeworks.fs_helpers

tube_entry = "^pipeworks_tube_connection_stony.png"

--
-- Node callback functions that are the same for active and inactive furnace
--

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("src") and inv:is_empty("dst")
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "src" then
		return stack:get_count()
	elseif listname == "dst" then
		return 0
	end
end

local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

--
-- Node definitions
--

minetest.register_node("itest2:electric_furnace", {
	description = "Electric Furnace",
    tiles = { "electric_furnace_top.png",
              "electric_furnace_bottom.png",
              "electric_furnace_leftrightback.png",
              "electric_furnace_leftrightback.png",
              "electric_furnace_leftrightback.png",
              "electric_furnace_front.png" },
	groups = {cracky = 2, tubedevice = 1, tubedevice_receiver = 1, energy = 1},
	tube = {
		insert_object = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:add_item("src", stack)
		end,
		can_insert = function(pos,node,stack,direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:room_for_item("src", stack)
		end,
		input_inventory = "src",
		connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1}
	},
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),

	can_dig = can_dig,
	on_construct = function(pos)
        tech_api.energy.on_construct(pos)
		local meta = minetest.get_meta(pos)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
          "size[8,9;]\n" ..
          "list[context;src;2,1;1,1;]\n" ..
          "list[context;dst;5,1;2,2;]\n" ..
          "list[current_player;main;0,5;8,4;]"
        )
        local inv = meta:get_inventory()
            inv:set_size("src", 1)
            inv:set_size("dst", 4)
	end,
    on_destruct = function(pos)
      tech_api.energy.on_destruct(pos)
    end,

	on_metadata_inventory_move = function(pos)
        print("Asking for call back")
		tech_api.energy.request_callback(pos, "default")
	end,
	on_metadata_inventory_put = function(pos)
        print("Asking for call back")
		tech_api.energy.request_callback(pos, "default")
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "fuel", drops)
		drops[#drops+1] = "itest2:electric_furnace"
		minetest.remove_node(pos)
		return drops
	end,
	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
	on_receive_fields = function(pos, formname, fields, sender)
		if not pipeworks.may_configure(pos, sender) then return end
		fs_helpers.on_receive_fields(pos, fields)
        print("Asking for call back")
		tech_api.energy.request_callback(pos, "default")
	end,
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig
})

minetest.register_node("itest2:electric_furnace_active", {
	description = "Electric Furnace",
    tiles = { "electric_furnace_top.png",
              "electric_furnace_bottom.png",
              "electric_furnace_leftrightback.png",
              "electric_furnace_leftrightback.png",
              "electric_furnace_leftrightback.png",
              "electric_furnace_front_active.png" },
	groups = {cracky = 2, tubedevice = 1, tubedevice_receiver = 1, not_in_creative_inventory = 1},
	tube = {
		insert_object = function(pos,node,stack,direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local timer = minetest.get_node_timer(pos)
			if not timer:is_started() then
				timer:start(1.0)
			end
			return inv:add_item("fuel", stack)
		end,
		can_insert = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:room_for_item("fuel", stack)
		end,
		input_inventory = "fuel",
		connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1}
	},
    on_destruct = function(pos)
      tech_api.energy.on_destruct(pos)
    end,
	paramtype2 = "facedir",
	light_source = 8,
	drop = "itest2:electric_furnace",
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_timer = furnace_node_timer,

	can_dig = can_dig,

	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
	on_receive_fields = function(pos, formname, fields, sender)
		if not pipeworks.may_configure(pos, sender) then return end
		fs_helpers.on_receive_fields(pos, fields)
		local meta = minetest.get_meta(pos)
		local formspec = active_formspec(0, 0, pos, meta)
		meta:set_string("formspec", formspec)
	end,
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig
})

tech_api.energy.register_device("itest2:electric_furnace", "default", {
  class = { 'default' },
  type = 'user',
  max_rate = 32,
  linkable_faces = {'back', 'top', 'left', 'right', 'bottom', "front"},
  callback = function(pos, dtime, available)
    local meta = minetest.get_meta(pos)
    local cook_time = meta:get_float("cook_time") or 0.0
    local inv = meta:get_inventory()
    local srclist = inv:get_list("src")

    if srclist then
        meta:set_string("infotext", "Active")

    	local cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
    	local cookable = cooked.time ~= 0
        local needed_time = cooked.time / 5

        -- if we have something to cook
        if cookable then
          -- and we have enough energy
          if available >= 20 then
            -- increment the cooking time only if the dtime is reasonable
            -- this is necessary since, when we manually ask for a callback, the
            -- dtime may be really big (since the last callback was a long time ago)
            if dtime < 1 then
              cook_time = cook_time + dtime
              -- if we cooked the item
              if cook_time >= needed_time then
                -- place it in the dst slot
                if inv:room_for_item("dst", cooked.item) then
                  inv:add_item("dst", cooked.item)
                  inv:set_stack("src", 1, aftercooked.items[1])
                  cook_time = 0.0
                end
              end
              meta:set_float("cook_time", cook_time)
            end
            -- then return telling the API we're requesting 20 EU/t, we're consuming
            -- 20 EU/t (since they're available) and we want the next callback ASAP
            return 20, 20, 1
          else
            -- if we have less than 20 EU/t, then tell the API we're still looking
            -- for 20 EU/t but, since they're not available, we're consuming 0 at
            -- the moment. Also we're asking for callbacks ASAP so we can resume as
            -- soon as we have enough energy available
            return 20, 0, 1
          end
        else
          -- otherwise, if we have nothing to cook, ensure the cooking time stays 0
          if cook_time > 0.0 then
            cook_time = 0.0
            meta:set_float("cook_time", cook_time)
          end

          -- and return telling the API we are not requesting any power and we're
          -- obviously not consuming any too. And that we don't
          -- want any more callback until we manually tell it to call us back
          return 0, 0, -1
        end

        -- if, for some reason, an unhandled situation happened...
        return 0, 0, -1
    end
    return 0, 0, 8
  end
})
