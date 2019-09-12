Hangars = {}
local shipsWithHangars = {}

--Kraylor: inverse 4-finger formation: fighters in front of leader
--Exuari:  4-finger formation: fighters behind leader
--Human Navy: row formation: fight side by side
--Blue Star Cartell: line formation: behind each other
--Mining Corporation: undisciplined 4-finger
function Hangars.buildFormationIncremental(ship, idx, leader, second)
	local pos = idx % 4
	local faction = ship:getFaction()
	local x,y -- x - to the front, y - to starport
	
	if faction == "Kraylor" then
		x = 300
		y = 300
	elseif faction == "Exuari" then
		x = -300
		y = 300
	elseif faction == "Mining Corporation" then
		x = random(-200,-1000)
		y = random(200,600)
	elseif faction == "Blue Star Cartell" then
		x = -300
		if pos == 3 then
			x = 2*x
		end
		y = 0
	elseif faction == "Human Navy" then
		x = 0
		y = 300
	else 
		x = -1000
		y = 1000
	end
	
	if pos == 1 then
		if leader ~= nil then
			if idx % 8 == 5 then
				ship:orderFlyFormation(leader, 0, -4*y)
			else 
				ship:orderFlyFormation(leader, 4*x, 4*y)
			end
		else
			ship:orderRoaming()
		end
		leader = ship
		--first ship has roaming order!
	elseif pos == 2 then
		ship:orderFlyFormation(leader, x, -y)
	elseif pos == 3 then
		ship:orderFlyFormation(leader, x, y)
		second = ship
	elseif pos == 0 then
		ship:orderFlyFormation(second, x, y)
	end
	return leader, second
end

function Hangars.init()
	shipsWithHangars = {}
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
							leader, second = buildFormationIncremental(ship2, idx, leader, second)
							ship.hangar.nextIndex = ship.hangar.nextIndex +1
							ship.hangar.nextLeader = leader
							ship.hangar.nextSecond = second
						end
					end
				end
			end
		end
	end
end

function Hangars.create(mothership, childShipName, number)
	mothership.hangar = { 
		shipname = childShipName,
		remaining = number,
		cooldownMax = 9.0,
		cooldownRemain = 10.0,
		nextIndex = 2,
		nextLeader = mothership,
		nextSecond = nil,
	}
	table.insert(shipsWithHangars, mothership)
end

