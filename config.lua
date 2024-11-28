Config = {}

Config.Debug = true

Config.Dealerships = {
    [1] = {
        SetJob = 'pdm',
        Blip = {
            location = vector3(100.0, -1395.0, 29.0),
            label = "Dealership",
            sprite = 52,
            color = 3
        },

        VehicleCategory = '*',
        Menu = {
            Selling = {
                vector3(-36.41, -1092.31, 26.28)
            },
            Admin = {
                vector3(-30.08, -1106.31, 26.26)
            }
        },

        Mission = {
            TruckModel = 'Hauler',
            TrailerModel = 'tr4',

            BlipTrailer = { sprite = 479, color = 5 },
            BlipDelivery = { sprite = 478, color = 5 },
            
            StartPoint = vector4(-45.62, -1082.45, 26.97, 71.68),
            GetPoints = {
                vector4(1017.69, -3130.12, 5.97, 359.81),
                vector4(961.54, -3207.88, 5.97, 179.75),
                vector4(1034.05, -3208.49, 5.94, 177.79),
                vector4(1058.33, -3154.27, 5.97, 179.14)
            },
            EndPoint = vector3(-29.86, -1081.32, 26.86)
        }
    }
}