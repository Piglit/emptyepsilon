require("script_formation.lua")

Hangars = {}
local shipsWithHangars = {}

function Hangars.init()
	--shipsWithHangars = {}
end

function Hangars.update(dt)
	for idx,ship in ipairs(shipsWithHangars) do
		if ship == nil or not ship:isValid() or ship.hangar == nil then
			table.remove(shipsWithHangars, idx)
		else
			for _, obj in ipairs(ship:getObjectsInRange(7000)) do
				if ship:isEnemy(obj) then
					if ship.hangar.cooldownRemain > 0 then
						ship.hangar.cooldownRemain = ship.hangar.cooldownRemain - dt
					else
						if ship.hangar.remaining > 0 then
							ship.hangar.remaining = ship.hangar.remaining -1
							ship.hangar.cooldownRemain = ship.hangar.cooldownMax
							ship2 = CpuShip():setTemplate(ship.hangar.shipname)
							ship2:setFaction(ship:getFaction())
							local x,y = ship:getPosition()
							rot = ship:getRotation()
							setCirclePos(ship2, x,y, rot+180, 300)
							ship2:setRotation(rot)
							local idx = ship.hangar.nextIndex
							local leader = ship.hangar.nextLeader
							local second = ship.hangar.nextSecond
							leader, second = script_formation.buildFormationIncremental(ship2, idx, leader, second)
							ship.hangar.nextIndex = ship.hangar.nextIndex +1
							ship.hangar.nextLeader = leader
							ship.hangar.nextSecond = second
							if ship.hangar.onSpawn ~= nil then
								ship.hangar.onSpawn(ship, ship2, idx)
							end
						end
					end
				end
			end
		end
	end
end

function Hangars.create(mothership, childShipName, number, onSpawn)
	if faction == "Kraylor" then
		mothership.hangar = {
			shipname = childShipName,
			remaining = number,
			cooldownMax = 9.0,
			cooldownRemain = 10.0,
			nextIndex = 2,
			nextLeader = mothership,
			nextSecond = nil,
			onSpawn = onSpawn,
		}
	else
		mothership.hangar = {
			shipname = childShipName,
			remaining = number,
			cooldownMax = 9.0,
			cooldownRemain = 10.0,
			nextIndex = 1,
			nextLeader = nil,
			nextSecond = nil,
			onSpawn = onSpawn,
		}

	end
	table.insert(shipsWithHangars, mothership)
end

