local function reverse_recipe(r)
    return {{r[1][1],r[2][1],r[3][1]},{r[1][2],r[2][2],r[3][2]},{r[1][3],r[2][3],r[3][3]}}
end

local function register_craft2(t)
    minetest.register_craft(t)
    t.recipe = reverse_recipe(t.recipe)
    minetest.register_craft(t)
end

minetest.register_node("itest2:machine",{description="Machine",
    groups={cracky=2},
    tiles={"itest_machine.png"},
})

minetest.register_node("itest2:advanced_machine",{description="Advanced machine",
    groups={cracky=2},
    tiles={"itest_advanced_machine.png"},
})

minetest.register_craftitem( "itest2:circuit", {
    description = "Electronic circuit",
    inventory_image = "itest_circuit.png",
})

minetest.register_craftitem( "itest2:advanced_circuit", {
    description = "Advanced circuit",
    inventory_image = "itest_advanced_circuit.png",
})

minetest.register_craftitem( "itest2:scrap", {
    description = "Scrap",
    inventory_image = "itest_scrap.png",
})

minetest.register_craftitem( "itest2:silicon_mesecon", {
    description = "Silicon-doped mesecon",
    inventory_image = "itest_silicon_mesecon.png",
})

minetest.register_node("itest2:silicon_mese_block",{description="Silicon-doped mese block",
    groups={cracky=2},
    tiles={"itest_silicon_mese_block.png"},
})

minetest.register_craftitem( "itest2:mixed_metal_ingot", {
    description = "Mixed metal ingot",
    inventory_image = "itest_mixed_metal_ingot.png",
})

minetest.register_craftitem( "itest2:advanced_alloy", {
    description = "Advanced alloy",
    inventory_image = "itest_advanced_alloy.png",
})

minetest.register_craftitem( "itest2:carbon_fibers", {
    description = "Carbon fibers",
    inventory_image = "itest_carbon_fibers.png",
})

minetest.register_craftitem( "itest2:combined_carbon_fibers", {
    description = "Combined carbon fibers",
    inventory_image = "itest_combined_carbon_fibers.png",
})

minetest.register_craftitem( "itest2:carbon_plate", {
    description = "Carbon plate",
    inventory_image = "itest_carbon_plate.png",
})

minetest.register_craft({
    type = "shapeless",
    output = "itest2:silicon_mesecon",
    recipe = {"mesecons:wire_00000000_off","technic:silicon_wafer","technic:copper_dust"}
})

minetest.register_craft({
    output = "itest2:silicon_mesecon 9",
    recipe = {{"itest2:silicon_mese_block"}}
})

minetest.register_craft({
    output = "itest2:silicon_mese_block",
    recipe =     {{"itest2:silicon_mesecon","itest2:silicon_mesecon","itest2:silicon_mesecon"},
    {"itest2:silicon_mesecon","itest2:silicon_mesecon","itest2:silicon_mesecon"},
    {"itest2:silicon_mesecon","itest2:silicon_mesecon","itest2:silicon_mesecon"}}
})

minetest.register_craft({
    type = "shapeless",
    output = "technic:bronze_dust 2",
    recipe = {"technic:copper_dust","technic:copper_dust",
        "technic:copper_dust","technic:tin_dust"}
})


minetest.register_craft({
    output = "itest2:copper_cable0_000000 6",
    recipe = {{"default:copper_ingot","default:copper_ingot","default:copper_ingot"}}
})

minetest.register_craft({
    output = "itest2:copper_cable1_000000 6",
    recipe = {{"technic:rubber","technic:rubber","technic:rubber"},
        {"default:copper_ingot","default:copper_ingot","default:copper_ingot"},
        {"technic:rubber","technic:rubber","technic:rubber"}}
})

minetest.register_craft({
    type = "shapeless",
    output = "itest2:copper_cable1_000000",
    recipe = {"itest2:copper_cable0_000000","technic:rubber"}
})

minetest.register_craft({
    output = "itest2:gold_cable0_000000 12",
    recipe = {{"default:gold_ingot","default:gold_ingot","default:gold_ingot"}}
})

minetest.register_craft({
    output = "itest2:gold_cable1_000000 4",
    recipe = {{"","technic:rubber",""},
        {"technic:rubber","default:gold_ingot","technic:rubber"},
        {"","technic:rubber",""}}
})

minetest.register_craft({
    output = "itest2:gold_cable2_000000 4",
    recipe = {{"technic:rubber","technic:rubber","technic:rubber"},
        {"technic:rubber","default:gold_ingot","technic:rubber"},
        {"technic:rubber","technic:rubber","technic:rubber"}}
})

minetest.register_craft({
    type = "shapeless",
    output = "itest2:gold_cable1_000000",
    recipe = {"itest2:gold_cable0_000000","technic:rubber"}
})

minetest.register_craft({
    type = "shapeless",
    output = "itest2:gold_cable2_000000",
    recipe = {"itest2:gold_cable1_000000","technic:rubber"}
})

minetest.register_craft({
    type = "shapeless",
    output = "itest2:gold_cable2_000000",
    recipe = {"itest2:gold_cable0_000000","technic:rubber","technic:rubber"}
})

minetest.register_craft({
    output = "itest2:tin_cable0_000000 9",
    recipe = {{"moreores:tin_ingot","moreores:tin_ingot","moreores:tin_ingot"}}
})

minetest.register_craft({
    output = "itest2:hv_cable0_000000 12",
    recipe = {{"technic:cast_iron_ingot","technic:cast_iron_ingot","technic:cast_iron_ingot"}}
})

minetest.register_craft({
    output = "itest2:hv_cable1_000000 4",
    recipe = {{"","technic:rubber",""},
        {"technic:rubber","technic:cast_iron_ingot","technic:rubber"},
        {"","technic:rubber",""}}
})

minetest.register_craft({
    output = "itest2:hv_cable2_000000 4",
    recipe = {{"technic:rubber","technic:rubber","technic:rubber"},
        {"technic:rubber","technic:cast_iron_ingot","technic:rubber"},
        {"technic:rubber","technic:rubber","technic:rubber"}}
})

minetest.register_craft({
    type = "shapeless",
    output = "itest2:hv_cable1_000000",
    recipe = {"itest2:hv_cable0_000000","technic:rubber"}
})

minetest.register_craft({
    type = "shapeless",
    output = "itest2:hv_cable2_000000",
    recipe = {"itest2:hv_cable1_000000","technic:rubber"}
})

minetest.register_craft({
    type = "shapeless",
    output = "itest2:hv_cable3_000000",
    recipe = {"itest2:hv_cable2_000000","technic:rubber"}
})

minetest.register_craft({
    type = "shapeless",
    output = "itest2:hv_cable2_000000",
    recipe = {"itest2:hv_cable0_000000","technic:rubber","technic:rubber"}
})

minetest.register_craft({
    type = "shapeless",
    output = "itest2:hv_cable3_000000",
    recipe = {"itest2:hv_cable1_000000","technic:rubber","technic:rubber"}
})

minetest.register_craft({
    type = "shapeless",
    output = "itest2:hv_cable3_000000",
    recipe = {"itest2:hv_cable0_000000","technic:rubber","technic:rubber","technic:rubber"}
})

register_craft2({
    output = "itest2:glass_fiber_cable_000000 4",
    recipe = {{"default:glass","default:glass","default:glass"},
        {"mesecons:wire_00000000_off","default:diamond","mesecons:wire_00000000_off"},
        {"default:glass","default:glass","default:glass"}}
})

minetest.register_craft({
    output = "itest2:detector_cable_off_000000",
    recipe = {{"","itest2:circuit",""},
        {"mesecons:wire_00000000_off","itest2:hv_cable3_000000","mesecons:wire_00000000_off"},
        {"","mesecons:wire_00000000_off",""}}
})

minetest.register_craft({
    output = "itest2:splitter_cable_000000",
    recipe = {{"","mesecons:wire_00000000_off",""},
        {"itest2:hv_cable3_000000","mesecons_walllever:wall_lever_off","itest2:hv_cable3_000000"},
        {"","mesecons:wire_00000000_off",""}}
})

minetest.register_craft({
    output = "itest2:re_battery",
    recipe = {{"","itest2:copper_cable1_000000",""},
        {"moreores:tin_ingot","itest2:copper_cable1_000000","moreores:tin_ingot"},
        {"moreores:tin_ingot","itest2:copper_cable1_000000","moreores:tin_ingot"}}
})

minetest.register_craft({
    output = "itest2:re_battery",
    recipe = {{"","itest2:tin_cable0_000000",""},
        {"moreores:tin_ingot","technic:lead_dust","moreores:tin_ingot"},
        {"moreores:tin_ingot","technic:sulfur_dust","moreores:tin_ingot"}}
})

minetest.register_craft({
    output = "itest2:single_use_battery 20",
    recipe = {{"","itest2:tin_cable0_000000",""},
        {"technic:rubber","itest2:tin_cable0_000000","technic:rubber"},
        {"technic:rubber","itest2:tin_cable0_000000","technic:rubber"}},
})

minetest.register_craft({
    output = "itest2:energy_crystal",
    recipe = {{"mesecons:wire_00000000_off","mesecons:wire_00000000_off","mesecons:wire_00000000_off"},
        {"mesecons:wire_00000000_off","default:diamond","mesecons:wire_00000000_off"},
        {"mesecons:wire_00000000_off","mesecons:wire_00000000_off","mesecons:wire_00000000_off"}}
})

minetest.register_craft({
    output = "itest2:lapotron_crystal",
    recipe = {{"itest2:silicon_mesecon","itest2:circuit","itest2:silicon_mesecon"},
        {"itest2:silicon_mesecon","itest2:energy_crystal","itest2:silicon_mesecon"},
        {"itest2:silicon_mesecon","itest2:circuit","itest2:silicon_mesecon"}}
})

minetest.register_craft({
    output = "itest2:batbox",
    recipe = {{"group:wood","itest2:copper_cable1_000000","group:wood"},
        {"itest2:re_battery","itest2:re_battery","itest2:re_battery"},
        {"group:wood","group:wood","group:wood"}}
})

minetest.register_craft({
    output = "itest2:cesu",
    recipe = {{"itest2:re_battery","itest2:hv_cable1_000000","itest2:re_battery"},
        {"itest2:re_battery","itest2:machine","itest2:re_battery"},
        {"itest2:re_battery","itest2:re_battery","itest2:re_battery"}}
})

minetest.register_craft({
    output = "itest2:mfe_unit",
    recipe = {{"itest2:gold_cable2_000000","itest2:energy_crystal","itest2:gold_cable2_000000"},
        {"itest2:energy_crystal","itest2:machine","itest2:energy_crystal"},
        {"itest2:gold_cable2_000000","itest2:energy_crystal","itest2:gold_cable2_000000"}}
})

minetest.register_craft({
    output = "itest2:mfs_unit",
    recipe = {{"itest2:lapotron_crystal","itest2:advanced_circuit","itest2:lapotron_crystal"},
        {"itest2:lapotron_crystal","itest2:mfe_unit","itest2:lapotron_crystal"},
        {"itest2:lapotron_crystal","itest2:advanced_machine","itest2:lapotron_crystal"}}
})

minetest.register_craft({
    output = "itest2:iron_furnace",
    recipe = {{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
        {"default:steel_ingot","default:furnace","default:steel_ingot"},
        {"default:steel_ingot","default:steel_ingot","default:steel_ingot"}}
})

minetest.register_craft({
    output = "itest2:iron_furnace",
    recipe = {{"","default:steel_ingot",""},
        {"default:steel_ingot","","default:steel_ingot"},
        {"default:steel_ingot","default:furnace","default:steel_ingot"}}
})

minetest.register_craft({
    output = "itest2:machine",
    recipe = {{"technic:cast_iron_ingot","technic:cast_iron_ingot","technic:cast_iron_ingot"},
        {"technic:cast_iron_ingot","","technic:cast_iron_ingot"},
        {"technic:cast_iron_ingot","technic:cast_iron_ingot","technic:cast_iron_ingot"}}
})

register_craft2({
    output = "itest2:advanced_machine",
    recipe = {{"","itest2:advanced_alloy",""},
        {"itest2:carbon_plate","itest2:machine","itest2:carbon_plate"},
        {"","itest2:advanced_alloy",""}}
})

minetest.register_craft({
    output = "itest2:mixed_metal_ingot 2",
    recipe = {{"technic:cast_iron_ingot","technic:cast_iron_ingot","technic:cast_iron_ingot"},
        {"default:bronze_ingot","default:bronze_ingot","default:bronze_ingot"},
        {"moreores:tin_ingot","moreores:tin_ingot","moreores:tin_ingot"}}
})

minetest.register_craft({
    output = "itest2:carbon_fibers",
    recipe = {{"technic:coal_dust","technic:coal_dust"},
        {"technic:coal_dust","technic:coal_dust"}}
})

minetest.register_craft({
    type = "shapeless",
    output = "itest2:combined_carbon_fibers",
    recipe = {"itest2:carbon_fibers","itest2:carbon_fibers"}
})

minetest.register_craft({
    output = "itest2:generator",
    recipe = {{"","itest2:re_battery",""},
        {"technic:cast_iron_ingot","technic:cast_iron_ingot","technic:cast_iron_ingot"},
        {"","itest2:iron_furnace",""}}
})

minetest.register_craft({
    output = "itest2:generator",
    recipe = {{"itest2:re_battery"},
        {"itest2:machine"},
        {"default:furnace"}}
})

register_craft2({
    output = "itest2:circuit",
    recipe = {{"itest2:copper_cable1_000000","itest2:copper_cable1_000000","itest2:copper_cable1_000000"},
        {"mesecons:wire_00000000_off","technic:cast_iron_ingot","mesecons:wire_00000000_off"},
        {"itest2:copper_cable1_000000","itest2:copper_cable1_000000","itest2:copper_cable1_000000"}}
})

register_craft2({
    output = "itest2:advanced_circuit",
    recipe = {{"mesecons:wire_00000000_off","technic:gold_dust","mesecons:wire_00000000_off"},
        {"itest2:silicon_mesecon","itest2:circuit","itest2:silicon_mesecon"},
        {"mesecons:wire_00000000_off","technic:gold_dust","mesecons:wire_00000000_off"}}
})

minetest.register_craft({
    output = "itest2:lv_transformer",
    recipe = {{"group:wood","itest2:copper_cable1_000000","group:wood"},
        {"default:copper_ingot","default:copper_ingot","default:copper_ingot"},
        {"group:wood","itest2:copper_cable1_000000","group:wood"}}
})

minetest.register_craft({
    output = "itest2:mv_transformer",
    recipe = {{"itest2:gold_cable2_000000"},
        {"itest2:machine"},
        {"itest2:gold_cable2_000000"}}
})

minetest.register_craft({
    output = "itest2:hv_transformer",
    recipe = {{"","itest2:hv_cable3_000000",""},
        {"itest2:circuit","itest2:mv_transformer","itest2:energy_crystal"},
        {"","itest2:hv_cable3_000000",""}}
})

minetest.register_craft({
    output = "itest2:electric_furnace",
    recipe = {{"","itest2:circuit",""},
        {"mesecons:wire_00000000_off","itest2:iron_furnace","mesecons:wire_00000000_off"}}
})

minetest.register_craft({
    output = "itest2:extractor",
    recipe = {{"itest2:treetap","itest2:machine","itest2:treetap"},
        {"itest2:treetap","itest2:circuit","itest2:treetap"},
        {"default:brick","default:brick","default:brick"}}
})

minetest.register_craft({
    output = "itest2:macerator",
    recipe = {{"default:gravel","itest2:re_battery","default:gravel"},
        {"default:sandstonebrick","itest2:machine","default:sandstonebrick"},
        {"default:desert_stone","default:desert_stone","default:desert_stone"}}
})

minetest.register_craft({
    output = "itest2:compressor",
    recipe = {{"default:bronze_ingot","","default:bronze_ingot"},
        {"default:bronze_ingot","itest2:machine","default:bronze_ingot"},
        {"default:bronze_ingot","itest2:circuit","default:bronze_ingot"}}
})

minetest.register_craft({
    output = "itest2:recycler",
    recipe = {{"","technic:gold_dust",""},
        {"default:dirt","itest2:compressor","default:dirt"},
        {"technic:cast_iron_ingot","default:dirt","technic:cast_iron_ingot"}}
})

minetest.register_craft({
    output = "itest2:mining_pipe 8",
    recipe = {{"technic:cast_iron_ingot","","technic:cast_iron_ingot"},
        {"technic:cast_iron_ingot","","technic:cast_iron_ingot"},
        {"technic:cast_iron_ingot","itest2:treetap","technic:cast_iron_ingot"}}
})

minetest.register_craft({
    output = "itest2:miner",
    recipe = {{"itest2:advanced_circuit","itest2:extractor","itest2:advanced_circuit"},
        {"","itest2:mining_pipe",""},
        {"","itest2:mining_pipe",""}}
})

minetest.register_craft({
    output = "itest2:solarpanel",
    recipe = {{"technic:coal_dust","default:glass","technic:coal_dust"},
        {"default:glass","technic:coal_dust","default:glass"},
        {"moreores:tin_ingot","itest2:generator","moreores:tin_ingot"}}
})

minetest.register_craft({
    output = "itest2:watermill",
    recipe = {{"default:stick","group:wood","default:stick"},
        {"group:wood","itest2:generator","group:wood"},
        {"default:stick","group:wood","default:stick"}}
})

minetest.register_craft({
    output = "itest2:windmill",
    recipe = {{"default:steel_ingot","","default:steel_ingot"},
        {"","itest2:generator",""},
        {"default:steel_ingot","","default:steel_ingot"}}
})

minetest.register_craft({
    output = "itest2:mining_drill_discharged",
    recipe = {{"","technic:cast_iron_ingot",""},
        {"technic:cast_iron_ingot","itest2:circuit","technic:cast_iron_ingot"},
        {"technic:cast_iron_ingot","itest2:re_battery","technic:cast_iron_ingot"}}
})

minetest.register_craft({
    output = "itest2:diamond_drill_discharged",
    recipe = {{"","default:diamond",""},
        {"default:diamond","itest2:mining_drill","default:diamond"}}
})

minetest.register_craft({
    output = "itest2:diamond_drill_discharged",
    recipe = {{"","default:diamond",""},
        {"default:diamond","itest2:mining_drill_discharged","default:diamond"}}
})

minetest.register_craft({
    output = "itest2:od_scanner",
    recipe = {{"","technic:gold_dust",""},
        {"itest2:circuit","itest2:re_battery","itest2:circuit"},
        {"itest2:copper_cable1_000000","itest2:copper_cable1_000000","itest2:copper_cable1_000000"}}
})

minetest.register_craft({
    output = "itest2:ov_scanner",
    recipe = {{"","technic:gold_dust",""},
        {"technic:gold_dust","itest2:advanced_circuit","technic:gold_dust"},
        {"itest2:gold_cable2_000000","itest2:od_scanner","itest2:gold_cable2_000000"}}
})

minetest.register_craft({
    output = "technic:cast_iron_ingot 8",
    recipe = {{"itest2:machine"}}
})

minetest.register_craft({
    type = "cooking",
    output = "technic:rubber",
    recipe = "itest2:sticky_resin"
})

minetest.register_craft({
    type = "cooking",
    output = "default:copper_ingot",
    recipe = "technic:copper_dust"
})

minetest.register_craft({
    type = "cooking",
    output = "default:bronze_ingot",
    recipe = "technic:bronze_dust"
})

minetest.register_craft({
    type = "cooking",
    output = "moreores:tin_ingot",
    recipe = "technic:tin_dust"
})

minetest.register_craft({
    type = "cooking",
    output = "moreores:silver_ingot",
    recipe = "technic:silver_dust"
})

minetest.register_craft({
    type = "cooking",
    output = "default:gold_ingot",
    recipe = "technic:gold_dust"
})

minetest.register_craft({
    type = "cooking",
    output = "itest2:ignis_dust 2",
    recipe = "itest2:ice_with_ignis",
})

minetest.register_craft({
    output = "itest2:medpack",
    recipe = {{"default:glass","group:wood","default:glass"},
        {"group:wood","group:wood","group:wood"},
        {"default:glass","group:wood","default:glass"}},
})

minetest.register_craft({
    output = "itest2:hospital",
    recipe = {{"itest2:medpack","itest2:ov_scanner","itest2:medpack"},
        {"itest2:medpack","itest2:machine","itest2:medpack"},
        {"itest2:extractor","itest2:circuit","itest2:compressor"}},
})

minetest.register_craft({
    output = "itest2:nuclear_reactor",
    recipe = {{"itest2:advanced_alloy","itest2:windmill","itest2:advanced_alloy"},
        {"itest2:lapotron_crystal","itest2:advanced_machine","itest2:lapotron_crystal"},
        {"itest2:advanced_alloy","itest2:advanced_circuit","itest2:advanced_alloy"}},
})

minetest.register_craft({
    output = "itest2:casing",
    recipe = {{"technic:cast_iron_ingot","itest2:advanced_alloy","technic:cast_iron_ingot"}},
})

minetest.register_craft({
    output = "itest2:reactor_wiring",
    recipe = {{"itest2:hv_cable3_000000"}},
})

minetest.register_craft({
    output = "itest2:hv_cable3_000000",
    recipe = {{"itest2:reactor_wiring"}},
})

minetest.register_tool("itest2:re_battery",{
    description = "RE Battery",
    inventory_image = "itest_re_battery.png",
    tool_capabilities =
        {max_drop_level=0,
        groupcaps={fleshy={times={}, uses=1, maxlevel=0}}}
})

minetest.register_tool("itest2:solar_battery",{
    description = "Solar Battery",
    inventory_image = "voltbuild_solar_battery.png",
    tool_capabilities =
        {max_drop_level=0,
        groupcaps={fleshy={times={}, uses=1, maxlevel=0}},solar=2}
})
minetest.register_tool("itest2:energy_crystal",{
    description = "Energy crystal",
    inventory_image = "itest_energy_crystal.png",
    tool_capabilities =
        {max_drop_level=0,
        groupcaps={fleshy={times={}, uses=1, maxlevel=0}}}
})

minetest.register_tool("itest2:lapotron_crystal",{
    description = "Lapotron crystal",
    inventory_image = "itest_lapotron_crystal.png",
    tool_capabilities =
        {max_drop_level=0,
        groupcaps={fleshy={times={}, uses=1, maxlevel=0}}}
})

minetest.register_tool("itest2:lapotron_crystal_block",{
    description = "Lapotron crystal",
    inventory_image = "itest_lapotron_crystal.png",
    tool_capabilities =
        {max_drop_level=0,
        groupcaps={fleshy={times={}, uses=1, maxlevel=0}}}
})

minetest.register_craftitem("itest2:single_use_battery",{
    description = "Single use battery",
    inventory_image = "itest_single_use_battery.png",
})

minetest.register_craft({
    output = "itest2:hv_cable3_000000",
    recipe = {{"itest2:reactor_wiring"}},
})

minetest.register_craft({
    type = "fuel",
    recipe = "itest2:fluid_cell_lava",
    burntime = 60,

})

minetest.register_craft({
    output = "itest2:fluid_cell_empty 2",
    recipe = {{"","",""},
        {"moreores:tin_ingot","default:glass","moreores:tin_ingot"},
        {"","",""}}
})

minetest.register_craft({
    output = "itest2:geothermal_generator",
    recipe = {{"default:glass","itest2:fluid_cell_empty","default:glass"},
        {"default:glass","itest2:fluid_cell_empty","default:glass"},
        {"moreores:tin_ingot","itest2:generator","moreores:tin_ingot"}}
})

minetest.register_craftitem("itest2:fluid_cell_empty", {
    description = "Fluid Cell",
    inventory_image = "itest2_fluid_cell_empty.png",
    stack_max = 99,
    liquids_pointable = true,
    groups = {fluid_cell = 1},
    on_use = function(itemstack, user, pointed_thing)
        if pointed_thing.type ~= "node" then
            return
        end
            local node = minetest.get_node(pointed_thing.under)
            local item_count = user:get_wielded_item():get_count()
            if node.name == "default:lava_source" then
                if item_count > 1 then
                    local inv = user:get_inventory()
                    if inv:room_for_item("main", {name="itest2:fluid_cell_lava"}) then
                        inv:add_item("main", "itest2:fluid_cell_lava")
                    else
                        local pos = user:getpos()
                        pos.y = math.floor(pos.y + 0.5)
                        minetest.add_item(pos, "itest2:fluid_cell_lava")
                    end
                    minetest.add_node(pointed_thing.under, {name = "air"})
                    itemstack:take_item()
                else
                    itemstack:take_item()
                    minetest.add_node(pointed_thing.under, {name = "air"})
                    itemstack:add_item("itest2:fluid_cell_lava")
                end
            elseif node.name == "default:water_source" then
                if item_count > 1 then
                    local inv = user:get_inventory()
                    if inv:room_for_item("main", {name="itest2:fluid_cell_water"}) then
                        inv:add_item("main", "itest2:fluid_cell_water")
                    else
                        local pos = user:getpos()
                        pos.y = math.floor(pos.y + 0.5)
                        minetest.add_item(pos, "itest2:fluid_cell_water")
                    end
                    minetest.add_node(pointed_thing.under, {name = "air"})
                    itemstack:take_item()
                else
                    itemstack:take_item()
                    minetest.add_node(pointed_thing.under, {name = "air"})
                    itemstack:add_item("itest2:fluid_cell_water")
                end
            end
        return itemstack
    end
})

minetest.register_craft({
    output = "itest2:quarry",
    recipe =  {{"itest2:gold_cable2_000000","itest2:advanced_circuit","itest2:gold_cable2_000000"},
    {"default:chest","itest2:machine","default:chest"},
    {"","default:diamondblock",""}}
})

minetest.register_craft({
    output = "itest2:quarry_iron_tip",
    recipe =  {{"itest2:gold_cable2_000000","itest2:advanced_circuit","itest2:gold_cable2_000000"},
    {"default:chest","itest2:machine","default:chest"},
    {"","default:steelblock",""}}
})
