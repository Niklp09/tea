tea = {}
local modpath = minetest.get_modpath("tea")

function tea.register_tea(modname, item, texture)
    if modname == nil or item == nil or texture == nil then
        minetest.log("warning", "[tea] Invalid api intput")
        return
    end

    local old_def = minetest.registered_nodes[modname .. ":" .. item]

    minetest.register_craftitem("tea:" .. item .. "_dried", {
        description = "dried " .. old_def.description,
        inventory_image = old_def.inventory_image .. "^[multiply:#A4A4A4"
    })

    minetest.register_craft({
        output = "tea:" .. item .. "_dried",
        type = "cooking",
        cooktime = 80,
        recipe = modname .. ":" .. item
    })

    minetest.register_craftitem("tea:" .. item .. "_powder", {
        description = old_def.description .. " powder",
        inventory_image = old_def.inventory_image .. "^[mask:tea_powder.png" .. "^[colorize:#A52A2A:80"
    })

    minetest.register_craft({
        output = "tea:" .. item .. "_powder",
        recipe = {{"farming:cutting_board", "tea:" .. item .. "_dried"}},
        replacements = {{"farming:cutting_board", "farming:cutting_board"}}
    })

    minetest.register_craftitem("tea:" .. item .. "_mixture", {
        description = old_def.description .. " tea mixture",
        inventory_image = old_def.inventory_image .. "^[multiply:#A4A4A4" .. "^[mask:tea_bag.png"
    })

    minetest.register_craft({
        output = "tea:" .. item .. "_mixture",
        recipe = {{"tea:" .. item .. "_powder", "vessels:drinking_glass", "bucket:bucket_water"}},
        replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
    })

    minetest.register_craftitem("tea:" .. item .. "_tea", {
        description = old_def.description .. " tea",
        inventory_image = old_def.inventory_image .. "^tea_cup.png",
        on_use = function(itemstack, user, pointed_thing)
            if user then
                return minetest.do_item_eat(3, "vessels:drinking_glass", itemstack, user, pointed_thing)
            end
        end
    })

    minetest.register_craft({
        output = "tea:" .. item .. "_tea",
        type = "cooking",
        cooktime = 100,
        recipe = "tea:" .. item .. "_mixture"
    })
end

dofile(modpath .. "/basic_tea.lua")

print("[tea] loaded")