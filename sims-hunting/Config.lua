Config                          = {}
Config.Align = 'top-left'

Config.WeaponList               = {
    {
        name        = "WEAPON_KNIFE", 
    },
    {
        name        = "WEAPON_MACHETE",
    },
    {
        name        = "WEAPON_DAGGER",
    },
    {
        name        = "WEAPON_SWITCHBLADE",
    }
}

Config.Animals = {
    boar = {
        name            = 'boar',
        model           = 'a_c_boar',
        hash            = GetHashKey('a_c_boar'),
        items           = {
            {
                item    = "carnejabali",
                label   = "Carne de Jabali",
                min     = 2,
                max     = 5,
            },
            {
                item    = "jabalipiel",
                label   = "Piel de Jabali",
                min     = 1,
                max     = 2,
            },
        },
    },
    coyote = {
        name            = 'coyote',
        model           = 'a_c_coyote', 
        hash            = GetHashKey('a_c_coyote'),
        items           = {
            {
                item    = "carnecoyote",
                label   = "Carne de Coyote",
                min     = 2,
                max     = 5,
            },
            {
                item    = "coyotepiel",
                label   = "Piel de Coyote",
                min     = 1,
                max     = 2,
            },
        },
    },
    deer = {
        name            = 'deer',
        model           = 'a_c_deer',
        hash            = GetHashKey('a_c_deer'),
        items           = {
            {
                item    = "carneciervo",
                label   = "Carne de Ciervo",
                min     = 2,
                max     = 5,
            },
            {
                item    = "ciervopiel",
                label   = "Piel de Ciervo",
                min     = 1,
                max     = 2,
            },
        },
    },
    mtlion = {
        name            = 'mtlion',
        model           = 'a_c_mtlion',
        hash            = GetHashKey('a_c_mtlion'), 
        items           = {
            {
                item    = "carneleon",
                label   = "Carne de Leon",
                min     = 2,
                max     = 5,
            },
            {
                item    = "leonpiel",
                label   = "Piel de Leon",
                min     = 1,
                max     = 2,
            },
        },
    },
    rabbit = {
        name            = 'rabbit',
        model           = 'a_c_rabbit_01', 
        hash            = GetHashKey('a_c_rabbit_01'),
        items           = {

            {
                item    = "carneconejo",
                label   = "Carne de Conejo",
                min     = 2,
                max     = 5,
            },
            {
                item    = "conejopiel",
                label   = "Piel de Conejo",
                min     = 1,
                max     = 2,
            },
        },
    },
}


Config.Shop = { vector3(-679.11, 5834.29, 17.33) }
Config.BuyItems = { 
	{id = 1, model = 'weapon_knife', label = 'Cuchillo', price = 250},
	{id = 2, model = 'weapon_musket', label = 'Escopeta de Mosquetera', price = 1200}
}
Config.SellItems = {
	carneconejo = 10,
	conejopiel = 30,
	carneleon = 35,
	leonpiel = 60,
	carneciervo = 25,
    ciervopiel = 50,
    carnejabali = 15,
    jabalipiel = 55,
    carnecoyote = 25,
    coyotepiel = 35,
}
