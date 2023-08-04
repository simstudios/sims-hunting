ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sims-hunting:giveitems')
AddEventHandler('sims-hunting:giveitems', function(animal)
	local xPlayer = ESX.GetPlayerFromId(source)
    for k,v in pairs(animal.items) do
        local itemName = v.item
        local count = math.random(v.min, v.max)
        if xPlayer.canCarryItem(itemName, count) then
            xPlayer.addInventoryItem(itemName, count)
            xPlayer.showNotification(Language['received'].. count .. "x " .. v.label)
        else
            xPlayer.showNotification(Language['notenoughspace'])
        end
    end
end)


ESX.RegisterServerCallback('sims-hunting:Buy', function(source, cb, weaponName,identifier)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.BuyItems[identifier].price
    local label = Config.BuyItems[identifier].label
	if xPlayer.getMoney() >= price then
	    xPlayer.removeMoney(price)
		xPlayer.addInventoryItem(weaponName, 1)
		xPlayer.showNotification('Has comprado 1x '..label..' por ~g~'..price..'$~g~')
		cb(true)
	else
		xPlayer.showNotification(Language['notenoughmoney'])
		cb(false)
	end	
end)

RegisterServerEvent("sims-hunting:Sell")
AddEventHandler("sims-hunting:Sell", function(itemName, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = Config.SellItems[itemName]
	local xItem = xPlayer.getInventoryItem(itemName)
	if not price then
		return
	end
	if xItem.count < amount then
        xPlayer.showNotification(Language['notenoughitems'])
		return
	end
	price = ESX.Math.Round(price * amount)
	xPlayer.addMoney(price)
	xPlayer.removeInventoryItem(xItem.name, amount)
    xPlayer.showNotification('Has vendido '..amount..'x '.. xItem.label ..' por ~g~'..ESX.Math.GroupDigits(price)..'$~g~')
end)