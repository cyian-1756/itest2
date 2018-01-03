dofile(minetest.get_modpath("itest2") .. "/funcs.lua")


local solarpanel = {
    node_name = "solarpanel",
    description = "Solarpanel",
    max_rate = 5,
    tiles={"itest_solar_panel_top.png", "itest_solar_panel_side.png", "itest_solar_panel_side.png"},
}

register_solarpanel(solarpanel)
