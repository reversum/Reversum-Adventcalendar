local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData              = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local blips = {
	{title="Adventskalender", colour=4, id=781, x = 225.08, y = -911.77, z = 31.12}
}
	
Citizen.CreateThread(function()
	DisplayRadar(true)

	for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.8)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)

local advent = {
    {x = 225.08,y = -911.77,z = 31.12}
}


function show()
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = "open"
	})
end

-- xs3_prop_int_xmas_tree_01

RegisterNUICallback("openday", function(data, cb)
startAnimation()
end)
RegisterNUICallback("cursor", function(data, cb)
	SetNuiFocus(false, false)

end)
RegisterNUICallback("gewinne", function(data, cb)

	TriggerServerEvent("moeglichegewinne")

end)

function startAnimation()
	local introcam
	local yarrack
	local yarrack2

	DisplayRadar(false)

	RequestModel('xs3_prop_int_xmas_tree_01')
	
	while not HasModelLoaded('xs3_prop_int_xmas_tree_01') do
		Citizen.Wait(1)
	end
	
	 yarrack = CreateObject('xs3_prop_int_xmas_tree_01', 190.97, -912.87, 30.69-1, true, true, true)
	PlaceObjectOnGroundProperly(yarrack)
	SetEntityHeading(yarrack, 51.86)

	introcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
	SetCamActive(introcam, true)
	SetFocusArea(191.87, -913.26, 30.69, 0.0, 0.0, 0.0)
	SetCamParams(introcam, 195.1, -915.55, 35.69, 0.0, 0.0, 66.22, 42.2442, 0, 1, 1, 2)
	SetCamParams(introcam, 195.1, -915.55, 30.69, 0.0, 0.0, 66.22, 42.2442, 2000, 0, 0, 2)
	RenderScriptCams(true, false, 3000, 1, 1)
	Wait(2000)
	ESX.TriggerServerCallback('versuchetagzuoeffnen', function(type)
		SetCamParams(introcam, 189.83, -915.2, 30.69, 0.0, 0.0, 100.47, 42.2442, 500, 0, 0, 2)
		if type == "vehicle" then
			SetCamParams(introcam, 191.78, -914.8, 30.69, 0.0, 0.0, 100.47, 42.2442, 500, 0, 0, 2)

			local model = "revolter"
			if not IsModelInCdimage(model) then return end
			RequestModel(model)
			while not HasModelLoaded(model) do 
			  Citizen.Wait(10)
			end
			
			 yarrack2 = CreateVehicle(model, 185.97, -915.6, 30.69-1, true, false)
			PlaceObjectOnGroundProperly(yarrack2)
			SetEntityHeading(yarrack2, 275.86)
		
		end
		if type == "item" then
			RequestModel('prop_toolchest_01')
	
			while not HasModelLoaded('prop_toolchest_01') do
				Citizen.Wait(1)
			end
			
			 yarrack2 = CreateObject('prop_toolchest_01', 185.97, -915.6, 30.69-1, true, true, true)
			PlaceObjectOnGroundProperly(yarrack2)
			SetEntityHeading(yarrack2, 275.86)
		
		end
		if type == "money" then
			RequestModel('ex_prop_crate_money_sc')
	
			while not HasModelLoaded('ex_prop_crate_money_sc') do
				Citizen.Wait(1)
			end
			
			 yarrack2 = CreateObject('ex_prop_crate_money_sc',185.97, -915.6, 30.69-1, true, true, true)
			PlaceObjectOnGroundProperly(yarrack2)
			SetEntityHeading(yarrack2, 275.86)
		
		end

		Wait(3500)
		DestroyCam(introcam, 0)
		DeleteEntity(yarrack)
		DeleteEntity(yarrack2)

		RenderScriptCams(0, 0, 1, 1, 1)
	end)	


end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

	
        for k in pairs(advent) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, advent[k].x, advent[k].y, advent[k].z)

            if dist <= 2.5 then
				local cam = GetRenderingCam()

				if cam == -1 then
					hintToDisplay('Drücke ~INPUT_CONTEXT~ um dein Türchen zu öffnen.')

				if IsControlJustPressed(0, Keys['E']) then
					show()

           end
		   end
		   end
        end
    end
end)

local coordsVisible = false

function DrawGenericText(text)
	SetTextColour(186, 186, 186, 255)
	SetTextFont(7)
	SetTextScale(0.378, 0.378)
	SetTextWrap(0.0, 1.0)
	SetTextCentre(false)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 205)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.40, 0.00)
end
