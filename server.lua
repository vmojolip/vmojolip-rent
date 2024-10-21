local ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback("vmojolip-rent:checkmoney", function(source, cb, price)
    local xPlayer = ESX.GetPlayerFromId(source)
	local money = 0
		
    money = xPlayer.getMoney()

    local price = tonumber(price)

	if money >= price then
        xPlayer.removeMoney(price)
        cb(true)
    else
        cb(false)
    end
end)