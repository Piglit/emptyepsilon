script_hangar = {}

require("script_formation.lua")
require("utils.lua")

local shipsWithHangars = {}

function script_hangar.update(dt)
	for sidx,ship in ipairs(shipsWithHangars) do
		if ship == nil or ship.hangar_queue == nil then
			table.remove(shipsWithHangars, sidx)
		elseif not ship:isValid() then
			ship.hangar_queue = nil
			table.remove(shipsWithHangars, sidx)
		elseif ship:areEnemiesInRange(7000) then
			for hidx, hangar in ipairs(ship.hangar_queue) do
				if hangar.cooldownRemain > 0 then
					hangar.cooldownRemain = hangar.cooldownRemain - dt
				elseif hangar.amount <= 0 then
					if #hangar.queue > 0 then
						local nextShip = table.remove(hangar.queue, 1)
						hangar.launchedShipTemplate = nextShip[1]
						hangar.amount = nextShip[2]
					end
				else
					hangar.amount = hangar.amount -1
					hangar.cooldownRemain = hangar.cooldownMax
					local ship2 = CpuShip():setTemplate(hangar.launchedShipTemplate)
					ship2:setFaction(ship:getFaction())
					local x,y = ship:getPosition()
					local rot = ship:getRotation()
					setCirclePos(ship2, x,y, rot+180, 300)
					ship2:setRotation(rot)
					local nidx = hangar.nextIndex
					local leader = hangar.nextLeader
					local second = hangar.nextSecond
					leader, second = script_formation.buildFormationIncremental(ship2, nidx, leader, second)
					hangar.nextIndex = nidx +1
					hangar.nextLeader = leader
					hangar.nextSecond = second
					if hangar.onSpawn ~= nil then
						hangar.onSpawn(ship, ship2, nidx)
					end
				end
			end
		end
	end
end

-- create a new hangar on the mothership that launches ships
-- when called multiple times: each call creates a parallel hangar
function script_hangar.create(mothership, launchedShipTemplate, amount, callbackOnLaunch, mothershipLeads)
	if mothership == nil or not mothership:isValid() then
		return
	end
	if mothership.hangar_queue == nil then
		mothership.hangar_queue = {}
		table.insert(shipsWithHangars, mothership)
	end

	local data = { 
		launchedShipTemplate = launchedShipTemplate,
		amount = amount,
		cooldownMax = 9.0,
		cooldownRemain = 10.0,
		nextIndex = 1,
		nextLeader = nil,
		nextSecond = nil,
		onLaunch = callbackOnLaunch,
		queue = {},
	}
	if mothershipLeads == true then
		data.nextIndex = 2
		data.nextLeader = mothership
	end

	table.insert(mothership.hangar_queue, data)

end

-- add new ships to an existing hangar
-- the ships are launchend after the ships already in the queue and are added to the last formation
-- when called on a ship without an existing hangar, create is called
function script_hangar.append(mothership, launchedShipTemplate, amount)
	if mothership == nil or not mothership:isValid() then
		return
	end
	if mothership.hangar_queue == nil then
		script_hangar.create(mothership, launchedShipTemplate, amount)
		return
	end
	local data = mothership.hangar_queue[#hangar_queue]
	if data.amount == 0 then
		data.launchedShipTemplate = launchedShipTemplate
		data.amount = amount
	else
		table.insert(data.queue, {launchedShipTemplate, amount})
	end
end
