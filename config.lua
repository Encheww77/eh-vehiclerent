Config = {}

-- If the ped is floatting apply -1 to the z axis; like so vector4(459.6, -986.6, 24.7, 90.88) would now be vector4(459.6, -986.6, 24.7-1, 90.88)
Config.Locations = {
    {
        name = "Airport Rental",
        coords = vector3(-1034.39, -2733.25, 20.17),
        npc = {
            model = "a_m_y_business_03",
            coords = vector4(-1034.39, -2733.25, 19.17, 100.0),
            scenario = "WORLD_HUMAN_CLIPBOARD"
        },
        vehicles = {
            { model = "asbo", label = "Asbo", price = 500 },
            { model = "blista", label = "Blista", price = 750 },
            { model = "sanchez", label = "Sanchez", price = 1000 }
        },
        spawnPoints = {
            vector4(-1028.5, -2730.0, 20.17, 240.0),
            vector4(-1021.5, -2732.0, 20.17, 240.0),
            vector4(-1014.5, -2734.0, 20.17, 240.0)
        }
    },

    {
        name = "Cayo Perico",
        coords = vector3(4496.81, -4517.86, 4.41),
        npc = {
            model = "a_m_y_business_03",
            coords = vector4(4496.81, -4517.86, 4.41-1, 20.98),
            scenario = "WORLD_HUMAN_CLIPBOARD"
        },
        vehicles = {
            { model = "ec350f", label = "GasGas EC350F", price = 1000 }
        },
        spawnPoints = {
            vector4(4496.6, -4509.06, 4.19, 286.56)
        }
    },

    {
        name = "Downtown Rental",
        coords = vector3(219.75, -809.98, 30.68),
        npc = {
            model = "a_f_y_business_02",
            coords = vector4(219.75, -809.98, 29.68, 248.0),
            scenario = "WORLD_HUMAN_STAND_MOBILE"
        },
        vehicles = {
            { model = "adder", label = "Adder", price = 2000 },
            { model = "carbonizzare", label = "Carbonizzare", price = 1500 },
            { model = "comet2", label = "Comet", price = 1800 }
        },
        spawnPoints = {
            vector4(223.0, -802.0, 30.56, 160.0),
            vector4(228.0, -803.0, 30.54, 160.0),
            vector4(233.0, -804.0, 30.53, 160.0)
        }
    }
}

