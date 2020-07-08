script_formation = {}


--returns leader, second
--still works if second is omitted
--Kraylor: inverse 4-finger formation: fighters in front of leader
--Exuari:  4-finger formation: fighters behind leader
--Human Navy: row formation: fight side by side
--Blue Star Cartell: line formation: behind each other
--Mining Corporation: undisciplined 4-finger
function script_formation.buildFormationIncremental(ship, idx, leader, second)
	if leader == nil or not leader:isValid() then
		ship:orderRoaming()
		return ship, second
	end

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
		if idx % 8 == 5 then
			ship:orderFlyFormation(leader, 0, -4*y)
		else
			ship:orderFlyFormation(leader, 4*x, 4*y)
		end
		leader = ship
		--first ship has roaming order!
	elseif pos == 2 then
		ship:orderFlyFormation(leader, x, -y)
	elseif pos == 3 then
		ship:orderFlyFormation(leader, x, y)
		second = ship
	elseif pos == 0 then
		if second == nil or not second:isValid() then
			ship:orderFlyFormation(leader, 2*x, 2*y)
		else
			ship:orderFlyFormation(second, x, y)
		end
	end
	return leader, second
end


