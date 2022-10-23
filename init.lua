local modpath = minetest.get_modpath("tea")
tea = {}

function tea.register_tea(modname, item, texture)
    if modname == nil or item == nil or texture == nil then return end
    local old_def = minetest.registered_nodes[modname .. ":" .. item]

    minetest.register_craftitem("tea:" .. item .. "_dried", {
        description = "dried " .. old_def.description,
        inventory_image = old_def.inventory_image .. "^[combine:" .. old_def.inventory_image .. "^[opacity:100^[colorize:gray"
    })

    minetest.register_craft({
        output = "tea:" .. item .. "_dried",
        type = "cooking",
        cooktime = 80,
        recipe = modname .. ":" .. item
    })

    minetest.register_craftitem("tea:" .. item .. "_powder", {
        description = old_def.description .. " powder",
        inventory_image = old_def.inventory_image .. "^[mask:invisible.png"
    })

    minetest.register_craft({
        output = "tea:" .. item .. "_powder",
        recipe = {{"farming:cutting_board", "tea:" .. item .. "_dried"}},
        replacements = {{"farming:cutting_board", "farming:cutting_board"}}
    })

    minetest.register_craftitem("tea:" .. item .. "_mixture", {
        description = old_def.description .. " tea mixture",
        inventory_image = old_def.inventory_image
    })

    minetest.register_craft({
        output = "tea:" .. item .. "_mixture",
        recipe = {{"tea:" .. item .. "_powder", "vessels:drinking_glass", "bucket:bucket_water"}},
       -- replacements = {"bucket:bucket_empty"}
    })

    minetest.register_craftitem("tea:" .. item .. "_tea", {
        description = old_def.description .. " tea",
        inventory_image = "tea_cup.png"
    })

    minetest.register_craft({
        output = "tea:" .. item .. "_tea",
        type = "cooking",
        cooktime = 100,
        recipe = "tea:" .. item .. "_mixture"
    })
end

tea.register_tea("ethereal", "orange", "farming_orange.png")
tea.register_tea("ethereal", "lemon", "ethereal_lemon.png")