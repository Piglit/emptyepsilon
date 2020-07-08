-- Name: Training: Battlecruiser
-- Type: Mission
-- Description: Combat Training Course
---
--- Objective: Destroy all enemy ships in the area.
---
--- Description:
--- In this training you will face different armed oppenents that you must destroy one by one. The difficulty will start low and will increase slowly with every destroyed enemy.
---
--- Your ship is a Hathcock Battle Cruiser - a warp-driven cruiser with great beam power and few missiles.
--- You will be escorted by a Nirvana Beam Cruiser as wingman.
-- Type: Basic

require "utils.lua"

function init()
	enemies = {
		"Yellow Hornet",
		"Blue Lindworm",
		"Red Adder MK4",
		"Phobos M3",
		"Advanced Adder MK5",
		"Phobos Y2",
		"Adder MK6",
		"Orca F12",
		"Nirvana R5A",
		{"Phobos Vanguard", "Phobos Rear-Guard"},
		"Orca M5",
		"Nirvana R5M",
		"Phobos Firehawk",
		{"Orca Vanguard", "Orca Rear-Guard"},
		"Nirvana Thunder Child",
		"Storm",
		"Phobos G4",
		"Orca F12.M",
		{"Nirvana Vanguard", "Nirvana Rear-Guard"},
		"Lightning Storm",
		"Orca G4",
		"Nirvana 0x81",
		"Solar Storm",
	}
	enemiesIndex = 1
	enemyList = {}
	
	instr1 = false
	timer = 0
	finishedTimer = 5
	rr = getLongRangeRadarRange()
	
	player = PlayerSpaceship():setTemplate("Hathcock"):setCallSign("Rookie 1"):setFaction("Human Navy"):setPosition(0, 0):setHeading(90)
	wingman = CpuShip():setTemplate("Nirvana R5M"):setCallSign("Wingman"):setFaction("Human Navy"):setPosition(-1000, -1000):setHeading(225):setScannedByFaction("Human Navy", true):orderDefendLocation(0,0)
	
	bonus = CpuShip():setTemplate("Flavia Express"):setCallSign("Bonus"):setFaction("Criminals"):setShieldsMax(200,200):setShields(200,200):setPosition(rr+2000,-rr-2000):setHeading(225):orderFlyTowardsBlind(-rr,rr)
	
	createObjectsOnLine(rr/2, rr/4, rr/4, rr/2, 1000, Mine, 2)
	createRandomAlongArc(Asteroid, 100, 0, 0, rr-2000, 180, 270, 1000)
	createRandomAlongArc(VisualAsteroid, 100, 0, 0, rr-2000, 180, 270, 1000)
	placeRandomAroundPoint(Nebula, 4, 10000, 10000, rr*0.75, -rr*0.75)
	
	wingman:sendCommsMessage(player, "Here is Commander Saberhagen. In this combat training you will practise your ability to beat up different types of armed enemies with a Hathcock battlecruiser. Whenever you destroy an opponent, the next one will appear just in sensor range. Use all of your capabilities to your advantage: Hacking, shield and beam frequencies, the database, energy management, your wingman etc. Engage with your warp drive, when you are ready. Commander Saberhagen out.")

	spwanNextWave()
end

function spwanNextWave()
	if enemiesIndex > #enemies then
		return false
	end
	
	local enemyTempl = enemies[enemiesIndex]
	enemiesIndex = enemiesIndex + 1
	local px, py = player:getPosition()
	local arc = random(0,360)
	if type(enemyTempl) == "table" then
		for i,et in ipairs(enemyTempl) do
			local enemy = CpuShip():setTemplate(et):setFaction("Criminals"):orderRoaming()
			setCirclePos(enemy, px, py, arc+i, rr-500)
			table.insert(enemyList, enemy)
		end
	else
		local enemy = CpuShip():setTemplate(enemyTempl):setFaction("Criminals"):orderRoaming()
		setCirclePos(enemy, px, py, arc, rr-500)
		table.insert(enemyList, enemy)
	end
	
	return true
end
	

function finished(delta)
	finishedTimer = finishedTimer - delta
	if finishedTimer < 0 then
		victory("Human Navy")
	end
	if finishedFlag == false then
		finishedFlag = true
		local bonusString = "escaped."
		if not bonus:isValid() then
			bonusString = "destroyed."
		end
		globalMessage("Mission Complete. Your Time: "..tostring(math.floor(timer)).."s. Bonus target "..bonusString)
	end
end


function update(delta)
	timer = timer + delta

	-- Count all surviving enemies.
	for i, enemy in ipairs(enemyList) do
		if not enemy:isValid() then
			table.remove(enemyList, i)
			break
		end
	end
	if #enemyList == 0 then
		if not spwanNextWave() then
			finished(delta)
		end
	end
	
	if bonusSpawned and bonus:isValid() and distance(bonus, -rr,rr) < 100 then
		bonus:setWarpDrive(true)
		bonus:orderFlyTowardsBlind(-1000*rr, 1000*rr)
	end
end

