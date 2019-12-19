-- Name: Kraylor Waves
-- Description: Waves of increasingly difficult enemies.
-- Type: Basic
-- Variation[Hard]: Difficulty starts at wave 5 and increases by 1.5 after the players defeat each wave. (Players are more quickly overwhelmed, leading to shorter games.)
-- Variation[Easy]: Makes each wave easier by decreasing the number of ships in each wave. (Takes longer for the players to be overwhelmed; good for new players.)

require("utils.lua")
-- For this scenario, utils.lua provides:
--   vectorFromAngle(angle, length)
--      Returns a relative vector (x, y coordinates)
--   setCirclePos(obj, x, y, angle, distance)
--      Returns the object with its position set to the resulting coordinates.

function randomStationTemplate()
	if random(0, 100) < 10 then
		return 'Huge Station'
	end
	if random(0, 100) < 20 then
		return 'Large Station'
	end
	if random(0, 100) < 50 then
		return 'Medium Station'
	end
	return 'Small Station'
end

function init()
	waveNumber = 0
	spawnWaveDelay = nil
	enemyList = {}
	friendlyList = {}

	PlayerSpaceship():setFaction("Human Navy"):setTemplate("Atlantis")

	for n=1, 2 do
		table.insert(friendlyList, SpaceStation():setTemplate(randomStationTemplate()):setFaction("Human Navy"):setPosition(random(-5000, 5000), random(-5000, 5000)))
	end
	friendlyList[1]:addReputationPoints(150.0)

	local x, y = vectorFromAngle(random(0, 360), 15000)
	for n=1, 5 do
		local xx, yy = vectorFromAngle(random(0, 360), random(2500, 10000))
		Nebula():setPosition(x + xx, y + yy)
	end

	for cnt=1,random(2, 7) do
		a = random(0, 360)
		a2 = random(0, 360)
		d = random(3000, 15000 + cnt * 5000)
		x, y = vectorFromAngle(a, d)
		for acnt=1,25 do
			dx1, dy1 = vectorFromAngle(a2, random(-1000, 1000))
			dx2, dy2 = vectorFromAngle(a2 + 90, random(-10000, 10000))
			Asteroid():setPosition(x + dx1 + dx2, y + dy1 + dy2)
		end
		for acnt=1,50 do
			dx1, dy1 = vectorFromAngle(a2, random(-1500, 1500))
			dx2, dy2 = vectorFromAngle(a2 + 90, random(-10000, 10000))
			VisualAsteroid():setPosition(x + dx1 + dx2, y + dy1 + dy2)
		end
	end

	spawnWave()

	for n=1, 6 do
		setCirclePos(SpaceStation():setTemplate(randomStationTemplate()):setFaction("Independent"), 0, 0, random(0, 360), random(15000, 30000))
	end
	Script():run("util_random_transports.lua")
end

function randomSpawnPointInfo(distance)
	if random(0, 100) < 50 then
		if random(0, 100) < 50 then
			x = -distance
		else
			x = distance
		end
		rx = 2500
		y = 0
		ry = 5000 + 1000 * waveNumber
	else
		x = 0
		rx = 5000 + 1000 * waveNumber
		if random(0, 100) < 50 then
			y = -distance
		else
			y = distance
		end
		ry = 2500
	end
	return x, y, rx, ry
end


function createEnemyGroup(difficulty)
	local faction = "Kraylor"
	local enemyList = {}
	local totalScore = 0
	--groups consist of gunships and occasionally few destroyers
	local gunships = {
		"Rockbreaker",
		"Rockbreaker Merchant",
		"Rockbreaker Murderer",
		"Rockbreaker Mercenary",
		"Rockbreaker Marauder",
		"Rockbreaker Military",
		"Spinebreaker",
	}
	local destroyers = {
		"Deathbringer",
		"Painbringer",
		"Doombringer",
	}
	local dest = math.random(math.floor(difficulty/3)) -- max d/3 points in destroyers
	local guns = difficulty - dest

	while totalScore < difficulty do
		local ship = CpuShip():setFaction(faction);
		if dest > 2.5 then
			local tmpl = destroyers[math.random(#destroyers)]
			local costs = {
				Deathbringer = 2.3,
				Painbringer = 2.5,
				Doombringer = 3.3,
			}
			local cost = costs[tmpl]
			if cost == nil then
				cost = 2.5
			end
			ship:setTemplate(tmpl)
			totalScore = totalScore + cost
			dest = dest - cost
		else
			ship:setTemplate(gunships[math.random(#gunships)])
			totalScore = totalScore + 1.3
			guns = guns - 1.3
		end
		table.insert(enemyList, ship)
	end

	return enemyList
end

function spawnWave()
	waveNumber = waveNumber + 1
	friendlyList[1]:addReputationPoints(150 + waveNumber * 15)


	if getScenarioVariation() == "Hard" then
		totalScoreRequirement = math.pow(waveNumber * 1.5 + 4, 1.3) * 10;
	elseif getScenarioVariation() == "Easy" then
		totalScoreRequirement = math.pow(waveNumber * 0.8, 1.3) * 9;
	else
		totalScoreRequirement = math.pow(waveNumber, 1.3) * 10;
	end

	local newEnemies = createEnemyGroup(totalScoreRequirement)

	spawnDistance = 20000
	spawnPointLeader = nil
	spawn_x, spawn_y, spawn_range_x, spawn_range_y = randomSpawnPointInfo(spawnDistance)
	for _,ship in ipairs(newEnemies) do
		ship:setPosition(random(-spawn_range_x, spawn_range_x) + spawn_x, random(-spawn_range_y, spawn_range_y) + spawn_y);
		ship:orderRoaming()
		table.insert(enemyList, ship);
	end

	globalMessage("Wave " .. waveNumber);
end

function update(delta)
	if spawnWaveDelay ~= nil then
		spawnWaveDelay = spawnWaveDelay - delta
		if spawnWaveDelay < 5 then
			globalMessage(math.ceil(spawnWaveDelay));
		end
		if spawnWaveDelay < 0 then
			spawnWave();
			spawnWaveDelay = nil;
		end
		return
	end
	enemy_count = 0
	friendly_count = 0
	for _, enemy in ipairs(enemyList) do
		if enemy:isValid() then
			enemy_count = enemy_count + 1
		end
	end
	for _, friendly in ipairs(friendlyList) do
		if friendly:isValid() then
			friendly_count = friendly_count + 1
		end
	end
	if enemy_count == 0 then
		spawnWaveDelay = 15.0;
		globalMessage("Wave cleared!");
	end
	if friendly_count == 0 then
		victory("Kraylor");
	end
end