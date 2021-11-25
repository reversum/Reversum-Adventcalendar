ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)


RegisterNetEvent("moeglichegewinne")
AddEventHandler("moeglichegewinne", function()
	local gewinne = {}
	local date_table = os.date("*t")
	local day = date_table.day	
	for k, v in pairs(Config["Days"][day]) do

		if v.item then
			table.insert(gewinne, v.item)
		elseif v.money then
			table.insert(gewinne, "Geld ("..v.money .. "$)")
		elseif v.vehicle then
			table.insert(gewinne, v.vehicle)
		end
	end
	final = "" .. table_to_string(gewinne)
	final = final:gsub("{", "")
	final = final:gsub("}", "")
	final = final:gsub('"', '')

	TriggerClientEvent("notifications", source, "white", "MÖGLICHE GEWINNE FÜR HEUTE", final)


end)

ESX.RegisterServerCallback('versuchetagzuoeffnen', function(source, cb)


	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	local date_table = os.date("*t")
	local day = date_table.day

	MySQL.Async.fetchScalar('SELECT day FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(tag)
		
    if tag ~= day then
		TriggerClientEvent("notifications", xPlayer.source, "red", "Fehler", "Du hast bereits das Türchen für heute geöffnet.")
		return

	else
	MySQL.Sync.execute('UPDATE users SET day = @day WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@day'] = day
	})

	local gesamt = 0
	belohnungen = {}
	for k, v in pairs(Config["Days"][day]) do

			if v.item then
				if v.amount then
					table.insert(belohnungen, {item = v.item ,amount = v.amount, tier = v.tier})
				else
					table.insert(belohnungen, {item = v.item ,amount = 1, tier = v.tier})
				end
			elseif v.weapon then
				table.insert(belohnungen, {weapon = v.weapon , tier = v.tier})
			elseif v.vehicle then
				table.insert(belohnungen, {vehicle = v.vehicle, tier = v.tier})
			end
			gesamt = gesamt + 1
	end
	local random = math.random(1,gesamt)
Wait(1000)
if belohnungen[random].item then
	TriggerClientEvent("notifications", xPlayer.source, "aqua", "ADVENTSKALENDER", "Oh! Guck mal was da drin war: Item.")
	xPlayer.addInventoryItem(belohnungen[random].item, belohnungen[random].count)
	cb("item")

elseif belohnungen[random].vehicle then
	TriggerClientEvent("notifications", xPlayer.source, "aqua", "ADVENTSKALENDER", "Oh! Guck mal was da drin war: Fahrzeug.")
	cb("vehicle")

elseif belohnungen[random].money then
	TriggerClientEvent("notifications", xPlayer.source, "aqua", "ADVENTSKALENDER", "Oh! Guck mal was da drin war: Geld.")
	xPlayer.addMoney(belohnungen[random].money)
	cb("money")

end
    end
	end)

end)

function table_to_string(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        -- Check the key type (ignore any numerical keys - assume its an array)
        if type(k) == "string" then
            result = result.."[\""..k.."\"]".."="
        end

        -- Check the value type
        if type(v) == "table" then
            result = result..table_to_string(v)
        elseif type(v) == "boolean" then
            result = result..tostring(v)
        else
            result = result.."\""..v.."\""
        end
        result = result..","
    end
    -- Remove leading commas from the result
    if result ~= "" then
        result = result:sub(1, result:len()-1)
    end
    return result.."}"
end
