-- Name: Training: Mine Layer 
-- Type: Mission
-- Description: Mine Layer Training Course
---

-- Goal: design an easy training for mine layers:
-- secondary goal: test multi hangar code


require "utils.lua"
require "script_hangar.lua"

function init()
	allowNewPlayerShips(false)

	player = PlayerSpaceship():setTemplate("Nautilus"):setCallSign("Rookie 1"):setFaction("Human Navy"):setPosition(0, 0):setHeading(90)
	rr = player:getLongRangeRadarRange()

	enemyList = {}
	
	timer = 0
	finishedTimer = 5
	finishedFlag = false

	station = SpaceStation():setTemplate('Small Station'):setCallSign("Maintainance Dock"):setRotation(random(0, 360)):setFaction("Human Navy"):setPosition(-800, 1200)
	wingman = CpuShip():setTemplate("Nirvana R5M"):setCallSign("Wingman"):setFaction("Human Navy"):setPosition(-800, -1700):setHeading(250):setScannedByFaction("Human Navy", true):orderDefendTarget(station)

	station2 = SpaceStation():setTemplate('Medium Station'):setCallSign("Civilian Station"):setRotation(random(0, 360)):setFaction("Human Navy"):setPosition(800, -rr*0.5)
	enemy_station = CpuShip():setTemplate("Ryder"):setFaction("Exuari"):orderStandGround()
	enemy_station:setPosition(0, -rr*0.9):setRotation(0):setCallSign("Omega")
	script_hangar.create(enemy_station, "Dagger", 3)
	script_hangar.append(enemy_station, "Blade", 3)
	script_hangar.config(enemy_station, "onLaunch", addToEnemiesList)
	script_hangar.create(enemy_station, "Gunner", 3)
	script_hangar.append(enemy_station, "Shooter", 3)
	script_hangar.append(enemy_station, "Jagger", 3)
	script_hangar.config(enemy_station, "triggerRange", rr*0.5)
	script_hangar.config(enemy_station, "onLaunch", addToEnemiesList)
	table.insert(enemyList, enemy_station)
	
	--createObjectsOnLine(rr/2, rr/4, rr/4, rr/2, 1000, Mine, 2)
	--createRandomAlongArc(Asteroid, 100, 0, 0, rr-2000, 180, 270, 1000)
	--createRandomAlongArc(VisualAsteroid, 100, 0, 0, rr-2000, 180, 270, 1000)
	--placeRandomAroundPoint(Nebula, 4, 10000, 10000, rr*0.75, -rr*0.75)
	
	--spwanNextWave()
	--instructions()
	wingman:sendCommsMessage(player, [[This is Commander Saberhagen.

In this training you will defend our stations against a carrier ship.
Your ship will be a Nautilus mine layer.

Commander Saberhagen out.]])

end

function addToEnemiesList(_, ship, _)
	table.insert(enemyList, ship)
end

function finished(delta)
	finishedTimer = finishedTimer - delta
	if finishedTimer < 0 then
		victory("Human Navy")
	end
	if finishedFlag == false then
		finishedFlag = true
		local bonusString = "survived."
		if not station2:isValid() then
			bonusString = "was destroyed."
		end
		globalMessage("Mission Complete. Your Time: "..tostring(math.floor(timer)).."s. Civilian Station "..bonusString)
	end
end

function update(delta)
	script_hangar.update(delta)
	timer = timer + delta
	if #enemyList == 0 then
		finished(delta)
	end
end

