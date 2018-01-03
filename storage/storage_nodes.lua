
dofile(minetest.get_modpath("itest2") .. "/funcs.lua")

local batbox = {
    node_name = "batbox",
    description = "Batbox",
    max_rate = 32,
    capacity = 40000,
    tiles = {"itest_batbox_side.png", "itest_batbox_side.png", "itest_batbox_output.png", "itest_batbox_side.png", "itest_batbox_side.png", "itest_batbox_side.png"},
}

local cesu = {
    node_name = "cesu",
    description = "CESU",
    max_rate = 128,
    capacity = 300000,
    tiles = {"itest_batbox_side.png", "itest_batbox_side.png", "itest_batbox_output.png", "itest_batbox_side.png", "itest_batbox_side.png", "itest_batbox_side.png"},
}

local mfe_unit = {
    node_name = "mfe_unit",
    description = "MFE Unit",
    max_rate = 1024,
    capacity = 4000000,
    tiles={"itest_mfe_side.png", "itest_mfe_side.png", "itest_mfe_output.png", "itest_mfe_side.png", "itest_mfe_side.png", "itest_mfe_side.png"},

}

local mfs_unit = {
    node_name = "mfs_unit",
    description = "MFS Unit",
    max_rate = 2048,
    capacity = 40000000,
    tiles={"itest_mfe_side.png", "itest_mfe_side.png", "itest_mfe_output.png", "itest_mfe_side.png", "itest_mfe_side.png", "itest_mfe_side.png"},

}

local ACS_unit = {
    node_name = "acs_unit",
    description = "ACS Unit",
    max_rate = 8192,
    capacity = 160000000,
    tiles={"itest_mfe_side.png", "itest_mfe_side.png", "itest_mfe_output.png", "itest_mfe_side.png", "itest_mfe_side.png", "itest_mfe_side.png"},
}

register_storage(batbox)
register_storage(cesu)
register_storage(mfe_unit)
register_storage(mfs_unit)
register_storage(ACS_unit)
