ESX = exports["es_extended"]:getSharedObject()

-- Shop
CreateThread(function()
	while true do
		local sleep = 1000
		for k, v in pairs(Config.Shop) do
			local me = PlayerPedId()
			local heading = GetEntityHeading(me)
			if GetDistanceBetweenCoords(GetEntityCoords(me), v) <= 5 then
					sleep = 0
				if GetDistanceBetweenCoords(GetEntityCoords(me),v) <= 1.8 and not IsPedDeadOrDying(me, true) then
					if not IsPedInAnyVehicle(me, false) then
						ESX.ShowHelpNotification(Language['shop'])
						if IsControlJustReleased(0, 38) then
							Shop()
						end 

					end
				end
			end
		end
		Wait(sleep)
	end
end)

-- Blips
CreateThread(function()
    for k, v in pairs(Config.Shop) do
	local blip = AddBlipForCoord(v)
	SetBlipSprite (blip, 141)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.6)
	SetBlipColour (blip, 31)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentSubstringPlayerName(Language['shoptitle'])
	EndTextCommandSetBlipName(blip)
    end
end)

--- Functions
function Shop()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
		title    = Language['shoptitle'],
		align    = Config.Align,
		elements = {
			{label = Language['buy'], value = 'buy'},
			{label = Language['sell'], value = 'sell'}
	}}, function(data, menu)
		if data.current.value == 'buy' then
			buy()
	    elseif data.current.value == 'sell' then
		    sell()
	    end
		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function buy(zone)
	local elements = {}
	ShopOpen = true

	for k,v in ipairs(Config.BuyItems) do
		table.insert(elements, {
			label = ('%s <span style="color:green;">$%s</span>'):format(v.label, ESX.Math.GroupDigits(v.price)),
			name  = v.label,
			model = v.model,
			price = v.price,
			identifier = v.id
		})
	end

	ESX.UI.Menu.CloseAll()	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
		title = Language['shoptitle'],
		align = Config.Align,
		elements = elements
	}, function(data, menu)
		ESX.TriggerServerCallback('sims-hunting:Buy', function(bought)
		end, data.current.model,data.current.identifier)
	end, function(data, menu)
		ShopOpen = false
		menu.close()

		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = 'Tienda de Caceria'
		CurrentActionData = { zone = zone }
	end, function(data, menu)
	end)
end

function sell()
	ESX.UI.Menu.CloseAll()
	local elements = {}
	menuOpen = true
	for k, v in pairs(ESX.GetPlayerData().inventory) do
		local price = Config.SellItems[v.name]
		if price and v.count > 0 then
			table.insert(elements, {
				label = ('%s - <span style="color:green;">%s</span>'):format(v.label, "$" .. ESX.Math.GroupDigits(price)),
				name = v.name,
				price = price,

				-- menu properties
				type = 'slider',
				value = 1,
				min = 1,
				max = v.count
			})
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell', {
		title    = Language['shoptitle'],
		align    = Config.Align,
		elements = elements
	}, function(data, menu)
		TriggerServerEvent('sims-hunting:Sell', data.current.name, data.current.value)
	end, function(data, menu)
		menu.close()
		menuOpen = false
	end)
end
