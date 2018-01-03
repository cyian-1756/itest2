dofile(minetest.get_modpath("itest2") .. "/storage/storage_nodes.lua")
dofile(minetest.get_modpath("itest2") .. "/craft.lua")
dofile(minetest.get_modpath("itest2") .. "/cables.lua")
dofile(minetest.get_modpath("itest2") .. "/machines/electric_furnace.lua")
dofile(minetest.get_modpath("itest2") .. "/machines/light.lua")
dofile(minetest.get_modpath("itest2") .. "/machines/quarry.lua")
dofile(minetest.get_modpath("itest2") .. "/machines/monitor.lua")
dofile(minetest.get_modpath("itest2") .. "/generators/solarpanel.lua")
dofile(minetest.get_modpath("itest2") .. "/generators/generator.lua")
dofile(minetest.get_modpath("itest2") .. "/generators/windmill.lua")
dofile(minetest.get_modpath("itest2") .. "/generators/watermill.lua")
dofile(minetest.get_modpath("itest2") .. "/generators/geothermal_generator.lua")
dofile(minetest.get_modpath("itest2") .. "/generators/geothermal_generator_passive.lua")
dofile(minetest.get_modpath("itest2") .. "/nodes/iron_furnace.lua")


hopper:add_container({{"bottom", "itest2:electric_furnace", "src"},
{"bottom", "itest2:electric_furnace_active", "src"},
{"bottom", "itest2:quarry", "dst"},
{"top", "itest2:electric_furnace", "dst"},
{"top", "itest2:electric_furnace_active", "dst"},})


register_fluid_cell({name = "fluid_cell_lava",
inventory_image = "itest2_fluid_cell_lava.png",
groups = {geothermal_generator_fuel = 1}, description = "Lava fluid cell"})
