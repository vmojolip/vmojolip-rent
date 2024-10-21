Config = {}

Config.CloseKey = 27 -- ESC (Key to close UI)

Config.RentSpace = {
    [1] = {
        ["blipname"] = "Wypożyczalnia La Mesa",
        ["pedmodel"] = "a_m_m_polynesian_01", -- https://docs.fivem.net/docs/game-references/ped-models/
        ["maincoords"] = {x = 855.98, y = -874.57, z = 25.38, heading = 204.09},
        ["spawnvehicles"] = {
            {x = 854.71, y = -882.47, z = 24.93, heading = 272.12},
            {x = 855.05, y = -885.27, z = 24.69, heading = 269.29},
            {x = 885.50, y = -909.27, z = 25.60, heading = 73.29},
            -- can add more
        },
    },
    [2] = {
        ["blipname"] = "Wypożyczalnia Alta Street",
        ["pedmodel"] = "a_m_m_salton_03",
        ["maincoords"] = {x = -329.27, y = -1085.19, z = 23.01, heading = 119.05},
        ["spawnvehicles"] = {
            {x = -354.98, y = -1087.71, z = 22.33, heading = 249.44},
            {x = -351.23, y = -1076.29, z = 22.33, heading = 252.28},
            {x = -335.57, y = -1106.70, z = 22.28, heading = 340.15},
        },
    },
    -- can add more
}

Config.Global = {
    ["openrent"] = "Otwórz wypożyczalnie",
    ["teleporttovehicle"] = false,
    ["sizetarget"] = vec3(0.8, 0.8, 2),
    ["debug"] = false,
}

Config.Vehicles = { -- https://docs.fivem.net/docs/game-references/vehicle-models/ (<-- here can find vehicle image, model and name)
    { model = "sultan2", name = "Sultan Classic", price = "1000", img = "img/sultan.png" },
    { model = "issi3", name = "Issi Classic", price = "900", img = "img/issi.png" },
    { model = "dilettante", name = "Dilettante", price = "800", img = "img/dilettante.png" },
    { model = "faggio", name = "Faggio", price = "300", img = "img/faggio.png" },
    { model = "infernus", name = "Infernus", price = "2000", img = "img/infernus.png" },

    -- can add more
}

-- functions --

Config.SpawnVehicleFunction = function(nameveh, priceveh, modelveh, plate)
    -- nameveh = vehicle name
    -- priceveh = vehicle rent price
    -- modelveh = vehicle model
    -- plate = vehicle plate

    -- you can add your own function here, e.g giving car keys
    print(nameveh, priceveh, modelveh, plate)
end