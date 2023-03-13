if minetest.get_modpath("ethereal") then
    tea.register_tea("ethereal", "orange", "farming_orange.png")
    tea.register_tea("ethereal", "lemon", "ethereal_lemon.png")
end

if minetest.get_modpath("default") then
    tea.register_tea("default", "apple", "default_apple.png")
end