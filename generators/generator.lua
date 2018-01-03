
-- this file is basically a modified copy of
-- minetest_game/mods/default/furnaces.lua

local fs_helpers = pipeworks.fs_helpers

tube_entry = "^pipeworks_tube_connection_stony.png"

local function active_formspec(fuel_percent, item_percent, pos, meta)
	local formspec =
		"size[8,8.5]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"list[current_name;fuel;2.75,2.5;1,1;]"..
		"image[2.75,1.5;1,1;default_furnace_fire_bg.png^[lowpart:"..
		(100-fuel_percent)..":default_furnace_fire_fg.png]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[current_player;main]"..
		"listring[current_player;main]"..
		"listring[current_name;fuel]"..
		"listring[current_player;main]"..
		default.get_hotbar_bg(0, 4.25) ..
			fs_helpers.cycling_button(
				meta,
				"image_button[0,3.5;1,0.6",
				"split_material_stacks",
				{
					pipeworks.button_off,
					pipeworks.button_on
				}
			).."label[0.9,3.51;Allow splitting incoming material (not fuel) stacks from tubes]"
	return formspec
end

local function inactive_formspec(pos, meta)
	local formspec = "size[8,8.5]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[current_name;fuel;2.75,2.5;1,1;]"..
	"image[2.75,1.5;1,1;default_furnace_fire_bg.png]"..
	"list[current_player;main;0,4.25;8,1;]"..
	"list[current_player;main;0,5.5;8,3;8]"..
	"listring[current_player;main]"..
	"listring[current_player;main]"..
	"listring[current_name;fuel]"..
	"listring[current_player;main]"..
	default.get_hotbar_bg(0, 4.25) ..
		fs_helpers.cycling_button(
			meta,
			"image_button[0,3.5;1,0.6",
			"split_material_stacks",
			{
				pipeworks.button_off,
				pipeworks.button_on
			}
		).."label[0.9,3.51;Allow splitting incoming material (not fuel) stacks from tubes]"
	return formspec
end

--
-- Node callback functions that are the same for active and inactive furnace
--

local function can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("fuel")
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "fuel" then
		if minetest.get_craft_result({method="fuel", width=1, items={stack}}).time ~= 0 then
			return stack:get_count()
		else
			return 0
		end
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

local function furnace_node_timer(pos, elapsed)
	--
	-- Inizialize metadata
	--
	local meta = minetest.get_meta(pos)
	local fuel_time = meta:get_float("fuel_time") or 0
	local src_time = meta:get_float("src_time") or 0
	local fuel_totaltime = meta:get_float("fuel_totaltime") or 0

	local inv = meta:get_inventory()
	local srclist, fuellist

	local cookable, cooked
	local fuel

	local update = true
	while update do
		update = false
		fuellist = inv:get_list("fuel")
		local aftercooked
		cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = fuellist})

		-- Check if we have enough fuel to burn
		if fuel_time < fuel_totaltime then
			-- The furnace is currently active and has enough fuel
			fuel_time = fuel_time + elapsed
			if true then
				src_time = src_time + elapsed
			end
		else
			-- Furnace ran out of fuel
			if true then
				-- We need to get new fuel
				local afterfuel
				fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})

				if fuel.time == 0 then
					-- No valid fuel in fuel list
					fuel_totaltime = 0
					src_time = 0
				else
					-- Take fuel from fuel list
					inv:set_stack("fuel", 1, afterfuel.items[1])
					update = true
					fuel_totaltime = fuel.time + (fuel_time - fuel_totaltime)
					src_time = src_time + elapsed
				end
			else
				-- We don't need to get new fuel since there is no cookable item
				fuel_totaltime = 0
				src_time = 0
			end
			fuel_time = 0
		end

		elapsed = 0
	end

	if fuel and fuel_totaltime > fuel.time then
		fuel_totaltime = fuel.time
	end

	--
	-- Update formspec, infotext and node
	--
	local formspec = inactive_formspec(pos, meta)
	local item_state
	local item_percent = 0

	local fuel_state = "Empty"
	local active = "inactive "
	local result = false

	if fuel_totaltime ~= 0 then
		active = "active "
		local fuel_percent = math.floor(fuel_time / fuel_totaltime * 100)
		fuel_state = fuel_percent .. "%"
		formspec = active_formspec(fuel_percent, item_percent, pos, meta)
		swap_node(pos, "itest2:generator_active")
		-- make sure timer restarts automatically
		result = true
	else
		if not fuellist[1]:is_empty() then
			fuel_state = "0%"
		end
		swap_node(pos, "itest2:generator")
		-- stop timer on the inactive furnace
		minetest.get_node_timer(pos):stop()
	end


	--
	-- Set meta values
	--
	meta:set_float("fuel_totaltime", fuel_totaltime)
	meta:set_float("fuel_time", fuel_time)
	meta:set_float("src_time", src_time)
	meta:set_string("formspec", formspec)

	return result
end

--
-- Node definitions
--

minetest.register_node("itest2:generator", {
	description = "Generator",
    tiles = {
        "itest_generator_side.png", "itest_generator_side.png", "itest_generator_side.png",
        "itest_generator_side.png", "itest_generator_side.png", "itest_generator_front.png"},
	groups = {cracky = 2, tubedevice = 1, tubedevice_receiver = 1},
	tube = {
		insert_object = function(pos, node, stack, direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local timer = minetest.get_node_timer(pos)
			if not timer:is_started() then
				timer:start(1.0)
			end
			return inv:add_item("fuel", stack)
		end,
		can_insert = function(pos,node,stack,direction)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			return inv:room_for_item("fuel", stack)
		end,
		input_inventory = "fuel",
		connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1}
	},
	paramtype2 = "facedir",
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),

	can_dig = can_dig,

	on_timer = furnace_node_timer,

	on_construct = function(pos)
        tech_api.energy.on_construct(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", inactive_formspec(pos, meta))
		local inv = meta:get_inventory()
		inv:set_size('fuel', 1)
	end,
    on_destruct = function(pos)
      tech_api.energy.on_destruct(pos)
    end,

	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		-- start timer function, it will sort out whether furnace can burn or not.
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "fuel", drops)
		drops[#drops+1] = "itest2:generator"
		minetest.remove_node(pos)
		return drops
	end,
	allow_metadata_inventory_put = allow_metadata_inventory_put,
	allow_metadata_inventory_move = allow_metadata_inventory_move,
	allow_metadata_inventory_take = allow_metadata_inventory_take,
	on_receive_fields = function(pos, formname, fields, sender)
		if not pipeworks.may_configure(pos, sender) then return end
		fs_helpers.on_receive_fields(pos, fields)
		local meta = minetest.get_meta(pos)
		local formspec = inactive_formspec(pos, meta)
		meta:set_string("formspec", formspec)
	end,
	after_place_node = pipeworks.after_place,
	after_dig_node = pipeworks.after_dig
})

minetest.register_node("itest2:generator_active", {
	description = "Generator",
    tiles = {
        "itest_generator_side.png", "itest_generator_side.png", "itest_generator_side.png",
        "itest_generator_side.png", "itest_generator_side.png", "itest_generator_front_active.png"},
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
	drop = "itest2:generator",
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

tech_api.energy.register_device("itest2:generator_active", "default", {
  class = { 'default' },
  type = 'provider',
  max_rate = 50,
  linkable_faces = {'back', 'top', 'left', 'right', 'bottom'},
  callback = function(pos, dtime, request)
    local produce = math.min(request, 50)
    minetest.get_meta(pos):set_string("infotext", "request=" .. request .. "EU/t - producing=" .. produce .. "EU/t")
    return produce, 8 -- return energy produced, and ask next callback within 8 time units
  end
})

tech_api.energy.register_device("itest2:generator", "default", {
  class = { 'default' },
  type = 'provider',
  max_rate = 0,
  linkable_faces = {'back', 'top', 'left', 'right', 'bottom'},
  callback = function(pos, dtime, request)
      if minetest.get_node(pos).name == "itest2:generator_active" then
          local produce = math.min(request, 50)
          minetest.get_meta(pos):set_string("infotext", "request=" .. request .. "EU/t - producing=" .. produce .. "EU/t")
          return produce, 8
      else
          return 0, 8
      end
  end
})
