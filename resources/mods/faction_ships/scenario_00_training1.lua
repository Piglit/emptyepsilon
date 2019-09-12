-- Name: Training: Cruiser
-- Description: "Here's your chance to beat up some helpless opponents." - Commander Dafid
---
--- Objective: Destroy all enemy ships in the area.
---
--- Description:
--- During this training your will learn to coordinate the actions of your crew and destoy an exuari training ground.
--- 
--- Your ship is a Phobos light cruiser - the most common vessel in the navy.
--- 
--- Advice: set radar range down to 20, otherwise relay will be bored.

-- Type: Basic
function init()
	enemyList = {}
	timer = 0
	finishedTimer = 5
	finishedFlag = false
	
	bonusAvail = true
	bonus = CpuShip():setFaction("Exuari"):setTemplate("Exuari Alpha Striker"):setCallSign("bonus"):setPosition(-2341, -17052):orderFlyTowardsBlind(-80000, -40000):setTypeName("Exuari shuttle"):setWarpDrive(false):setBeamWeapon(0, 0, 355, 0, 0.1, 0.1):setBeamWeapon(1, 0, 355, 0, 0.1, 0.1):setHeading(-60)
	
    table.insert(enemyList, CpuShip():setFaction("Exuari"):setTemplate("Exuari Fighter"):setCallSign("Fgt1"):setPosition(2341, -5191):setBeamWeapon(0, 0, 0, 0, 0.1, 0.1):setHeading(60))
    table.insert(enemyList, CpuShip():setFaction("Exuari"):setTemplate("Exuari Fighter"):setCallSign("Fgt2"):setPosition(2933, -6555):setBeamWeapon(0, 0, 0, 0, 0.1, 0.1):setHeading(60))
    table.insert(enemyList, CpuShip():setFaction("Exuari"):setTemplate("Exuari Bomber"):setCallSign("B2"):setPosition(-8866, -9002):orderDefendLocation(-9798, -9869):setWeaponTubeCount(0):setWeaponStorageMax("HVLI", 0):setWeaponStorage("HVLI", 0):setBeamWeapon(0, 0, 0, 0, 0.1, 0.1):setHeading(60))
    table.insert(enemyList, CpuShip():setFaction("Exuari"):setTemplate("Exuari Bomber"):setCallSign("B1"):setPosition(-12407, -9067):orderDefendLocation(-11433, -9887):setWeaponTubeCount(0):setWeaponStorageMax("HVLI", 0):setWeaponStorage("HVLI", 0):setBeamWeapon(0, 0, 0, 0, 0.1, 0.1):setHeading(60))
    table.insert(enemyList, CpuShip():setFaction("Exuari"):setTemplate("Exuari Fighter"):setCallSign("A1"):setPosition(-24113, -12830):orderDefendLocation(-25570, -13055):setHeading(60))
    table.insert(enemyList, CpuShip():setFaction("Exuari"):setTemplate("Exuari Fighter"):setCallSign("A2"):setPosition(-26813, -12025):orderDefendLocation(-26425, -13447):setHeading(60))
    table.insert(enemyList, CpuShip():setFaction("Exuari"):setTemplate("Exuari Bomber"):setCallSign("BR2"):setPosition(-39545, -16424):orderStandGround():setBeamWeapon(0, 0, 0, 0, 0.1, 0.1):setHeading(60))
    table.insert(enemyList, CpuShip():setFaction("Exuari"):setTemplate("Exuari Bomber"):setCallSign("BR1"):setPosition(-41365, -15584):orderStandGround():setBeamWeapon(0, 0, 0, 0, 0.1, 0.1):setHeading(60))
    table.insert(enemyList, CpuShip():setFaction("Exuari"):setTemplate("Personnel Freighter 1"):setCallSign("Omega1"):setPosition(-34120, -6629):setTypeName("Exuari transport"):setHeading(60))
    table.insert(enemyList, CpuShip():setFaction("Exuari"):setTemplate("Personnel Freighter 1"):setCallSign("Omega2"):setPosition(-31698, -4868):setTypeName("Exuari transport"):setHeading(60))
    table.insert(enemyList, CpuShip():setFaction("Exuari"):setTemplate("Personnel Freighter 1"):setCallSign("Omega3"):setPosition(-29270, -2853):setTypeName("Exuari transport"):setHeading(60))
    table.insert(enemyList, CpuShip():setFaction("Exuari"):setTemplate("Goods Freighter 5"):setCallSign("FTR1"):setPosition(2787, -1822):orderFlyTowards(-42873, -13865):setTypeName("Exuari freighter"):setHeading(-60))
	
    PlayerSpaceship():setTemplate("Phobos M3P"):setPosition(18, -48):setCallSign("Rookie 1"):setJumpDrive(false)
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
	
	-- Count all surviving enemies and allies.
	for i, enemy in ipairs(enemyList) do
		if not enemy:isValid() then
			table.remove(enemyList, i)
		end
	end
	if #enemyList == 0 then
		if not bonusAvail then
			finished(delta)
		else
			if not bonus:isValid() then
				finished(delta)
			end
		end
		
	end

	if bonus:isValid() then
		local x,y = bonus:getPosition() 
		if x < -40000 then
			bonus:setWarpDrive(true)
		end
		if x < -50000 then
			bonusAvail = false
		end	
	end
	
end
