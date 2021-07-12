-- Name: Training: Battlecruiser
-- Type: Mission
-- Description: Combat Training Course
---
--- Objective: Defend your mothership and destroy all enemies in the area.
---
--- Description:
--- In this training you will face different armed oppenents that you must destroy one by one. The difficulty will start low and will increase slowly with every destroyed enemy.
---
--- Your ship is a Hathcock Battle Cruiser - a warp-driven cruiser with great beam power and few missiles.
---
--- This is a short mission for inexperienced players who prefer close combat.
-- Variation[Test Formations]: All enemies (and more stonger ones) are present at the beginning of the scenario. This is for testing formations.

-- secondary design goal: Test and example for script_formation


require "utils.lua"
require "script_formation.lua"

--- Ship creation functions
function createExuariFighterSquad(amount, posx, posy)
    local enemyList = script_formation.spawnFormation("Dagger", amount, posx, posy, "Exuari", "Alpha-")
    return enemyList
end

function createExuariInterceptorSquad(amount, posx, posy)
    local enemyList = script_formation.spawnFormation("Blade", amount, posx, posy, "Exuari", "Beta-")
    return enemyList
end

function createExuariBomberSquad(amount, posx, posy)
    local enemyList = script_formation.spawnFormation("Gunner", amount, posx, posy, "Exuari", "Gamma-")
    return enemyList
end

function createExuariStrikerSquad(amount, posx, posy)
    local enemyList = script_formation.spawnFormation("Strike", amount, posx, posy, "Exuari", "Delta-")
    return enemyList
end

function createExuariDefense()
    return CpuShip():setFaction("Exuari"):setTemplate("Warden")
end

function createExuariMothership()
    return CpuShip():setFaction("Exuari"):setTemplate("Ryder")
end

function createHumanMothership()
    local ship = CpuShip():setFaction("Human Navy"):setTemplate("Jump Carrier"):setScannedByFaction("Human Navy", true)
    ship:setTypeName("Steamroller"):setJumpDrive(false):setJumpDrive(false)
    ship:setHullMax(200):setHull(200):setShieldsMax(100,100):setShields(100,100)
    ship:setWeaponTubeCount(2):setTubeLoadTime(0, 10.0):setTubeLoadTime(1, 10.0):setWeaponStorage("HVLI", 20)
    ship:setBeamWeapon(0, 90, -10, 2000, 8, 11):setBeamWeapon(1, 90, 10, 2000, 8, 11)
    return ship
end

function init()
    allowNewPlayerShips(false)
    gu = 5000   -- grid unit for enemy spawns

    player = PlayerSpaceship():setTemplate("Hathcock"):setCallSign("Rookie 1"):setFaction("Human Navy"):setPosition(gu/4, -gu/4):setHeading(90):setLongRangeRadarRange(5*gu):addReputationPoints(140.0)

    bossposx = 10*gu
    bossposy = 0
    boss = createExuariMothership():setCallSign("Omega"):setPosition(bossposx, bossposy):orderDefendLocation(bossposx, bossposy)
    guard = createExuariDefense():setCallSign("Omicron"):setPosition(bossposx, bossposy+1000):orderDefendTarget(boss)

    dread = createHumanMothership():setCallSign("Liberator"):setPosition(-gu/4, gu/4):setHeading(90):orderAttack(boss)

    enemyWaveIndex = 1
    enemyList = {}
    nextWaveDreadPos = 0

    instr1 = false
    timer = 0
    finishedTimer = 5
    finishedFlag = false


--    bonus = CpuShip():setTemplate("Flavia Express"):setCallSign("Bonus"):setFaction("Criminals"):setShieldsMax(200, 200):setShields(200, 200):setPosition(rr+2000, -rr-2000):setHeading(225):orderFlyTowardsBlind(-rr, rr)

    createRandomAlongArc(Asteroid, 100, 2*gu, -1*gu, gu, 60, 220, 100)
    createRandomAlongArc(VisualAsteroid, 100, 2*gu, -1*gu, gu, 400, 270, 200)
    placeRandomAroundPoint(Nebula, 4, gu, 2*gu, 3.5*gu, 1.5*gu)
    placeRandomAroundPoint(Nebula, 4, gu, 3*gu, 6*gu, -2.5*gu)
    createRandomAlongArc(Asteroid, 100, 7*gu, 2*gu, 1.5*gu, 180, 270, 200)
    createRandomAlongArc(VisualAsteroid, 100, 7*gu, 2*gu, 1.5*gu, 180, 270, 1000)
    createObjectsOnLine(8*gu, -gu, 8*gu, gu, 1000, Mine, 2)

    spwanNextWave()
    instructions()
end

function spwanNextWave()

    local amount
    if getScenarioVariation() == "Test Formations" then
        amount = enemyWaveIndex
    else
        amount = enemyWaveIndex % 4 + 1
    end

    if enemyWaveIndex == 1 then
        enemyList = createExuariFighterSquad(amount, 2*gu, -1*gu)
        enemyList[1]:orderRoaming()
    elseif enemyWaveIndex == 2 then
        enemyList = createExuariInterceptorSquad(amount, 3.5*gu, 1.5*gu)
        enemyList[1]:orderAttack(player)
    elseif enemyWaveIndex == 3 then
        enemyList = createExuariBomberSquad(amount, 6*gu, -2.5*gu)
        enemyList[1]:orderAttack(dread)
    elseif enemyWaveIndex == 4 then
        enemyList = createExuariStrikerSquad(amount, 7*gu, 2*gu)
        enemyList[1]:orderAttack(dread)
    else
        return false
    end

    enemyWaveIndex = enemyWaveIndex + 1
    nextWaveDreadPos = nextWaveDreadPos + 2*gu
    return true
end

function instructions()
    if dread:isValid() then
        if enemyWaveIndex == 2 then
            dread:sendCommsMessage(player, [[This is Commander Saberhagen onboard the Liberator.

In this combat training you will practise your abilities with a Hathcock battlecruiser.
The Hathcock is a ship for those who seek close combat. Rely on her beams and the high turn rate.

We will face several small groups of enemies that will target the Liberator. 
Each group will be more difficult then the previous one. Your goal is to keep yourself and the Liberator alive.

Engage with your warp drive, when you are ready.

Commander Saberhagen out.]])
        elseif enemyWaveIndex == 4 and dread:isValid() then
            dread:sendCommsMessage(player, [[This is Commander Saberhagen.

You can dock at the Liberator if you need to restore your energy or if you need repairs.

Commander Saberhagen out.
]])
        elseif enemyWaveIndex == 5 then
            dread:sendCommsMessage(player, [[This is Commander Saberhagen.

Remember to use all of your capabilities to your advantage: Hacking, shield and beam frequencies, the database, energy management etc.

Commander Saberhagen out.
]])
        end
    end
end


function finished(delta)
    if getScenarioVariation() == "Test Formations" then
        return
    end
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
        globalMessage([[Mission Complete.
Your Time: ]]..formatTime(timer)..[[
Bonus target ]]..bonusString..[[

If you feel ready for combat and you liked the ship, play 'the mining outpost'.
If you want to try another ship, play another training mission.]])
    end
end


function update(delta)
    timer = timer + delta

    -- Count all surviving enemies.
    for i, enemy in ipairs(enemyList) do
        if not enemy:isValid() then
            table.remove(enemyList, i)
            -- Note: table.remove() inside iteration causes the next element to be skipped.
            -- This means in each update-cycle max half of the elements are removed.
            -- It does not matter here, since update is called regulary.
        end
    end

    dreadPosx, dreadPosy = dread:getPosition()
    if #enemyList == 0 or (dreadPosx ~= nil and dreadPosx > nextWaveDreadPos) or getScenarioVariation() == "Test Formations" then
        if not spwanNextWave() then
            finished(delta)
        else
            instructions()
        end
    end

--    if bonusSpawned and bonus:isValid() and distance(bonus, -rr, rr) < 100 then
--        bonus:setWarpDrive(true)
--        bonus:orderFlyTowardsBlind(-1000*rr, 1000*rr)
--    end
end

