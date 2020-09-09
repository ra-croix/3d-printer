data:extend{
	{
		type = 'item',
		name = '3d-printer',
		icon = '__3d-printer__/graphics/icon/printer.png',
		icon_size = 64,
		icon_mipmaps = 4,
		stack_size = 10,
		placed_as_equipment_result = '3d-printer',
		order = 'b[personal-transport]',
		subgroup = 'transport',
	},	
	{
		type = 'recipe',
		name = 'filament',
		category = 'smelting',
		enabled = false,
		ingredients = {{'plastic-bar', 2}},
		results = {{'filament', 1}}
	},	
	{
		name = '3d-printer',
		type = 'movement-bonus-equipment',
		energy_consumption = '100kW',
		movement_bonus = 0.3,
		categories = {'armor'},
		shape = {
			type = 'full',
			width = 1,
			height = 2,
		},
		energy_source = {
			usage_priority = 'secondary-input',
			type = 'electric',
		},
		sprite = {
			filename = '__3d-printer__/graphics/equipment/printerthin.png',
			size = {32, 64},
		},
	},
	{
			type = 'recipe',
			name = '3d-printer',
			ingredients = {
				{'rocket-control-unit', 2},
				{'processing-unit', 10},
			},
			results = {{'3d-printer', 1}},
			enabled = false,
	},	
	{
		type = 'item',
		name = 'filament',
		icon = '__3d-printer__/graphics/icon/filament.png',
		icon_size = 64,
		stack_size = 500,
		subgroup = "raw-material",
		order = "b[filament]",
	},
	{
		type = 'technology',
		name = '3d-printer',
		icon = '__3d-printer__/graphics/equipment/printer.png',
		icon_size = 128,
		effects = {
			{
				recipe = '3d-printer',
				type = 'unlock-recipe'
			},
			{
				recipe = 'filament',
				type = 'unlock-recipe'
			},
		},
		prerequisites = {
			'logistic-system',
		},
		unit = {
			count = 20,
			ingredients = {
				{'automation-science-pack', 1},
				{'logistic-science-pack', 1},
			},
			time = 30,
		},
	},
}