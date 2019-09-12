
function spawn_player_fleet()
	melonidas = PlayerSpaceship():setTemplate("Melonidas"):setCallSign("U.S.S. Koenig Melonidas"):setPosition(0,0):setControlCode("koenig")
	melonidas.nameAssigned = true
	huntmaster = PlayerSpaceship():setTemplate("Hunter"):setCallSign("Huntmaster"):setPosition(-1000,1000):setControlCode("hunt")
	huntmaster.nameAssigned = true
	regenbogenpony = PlayerSpaceship():setTemplate("Hathcock"):setCallSign("Regenbogenpony"):setPosition(-1000,-1000):setControlCode("metal")
	regenbogenpony.nameAssigned = true
	unsinkable = PlayerSpaceship():setTemplate("Phobos M3P"):setCallSign("Unsinkable"):setPosition(1000,1000):setControlCode("msdos")
	unsinkable.nameAssigned = true
	reichsflugkraken = PlayerSpaceship():setTemplate("Phobos M3P"):setCallSign("Reichsflugkraken"):setPosition(1000,-1000):setControlCode("scheibe")
	reichsflugkraken.nameAssigned = true
	
	--upgrade_player_ship(unsinkable, "energy")
	--upgrade_player_ship(unsinkable, "hull")
	--upgrade_player_ship(unsinkable, "shield")
	--upgrade_player_ship(unsinkable, "tube")
	--upgrade_player_ship(unsinkable, "missiles")
	--
	--upgrade_player_ship(unsinkable, "kojak")
	--upgrade_player_ship(unsinkable, "impulse-speed")
	--upgrade_player_ship(unsinkable, "rotation-speed")
	--upgrade_player_ship(unsinkable, "beam-cool")
	--upgrade_player_ship(unsinkable, "beam-cycle")
	--upgrade_player_ship(unsinkable, "beam-damage")
	--upgrade_player_ship(unsinkable, "beam-range")

	
	
end

--"Phobos M3P" -- light cruiser
--"Piranha M5P" -- missile cruiser
--"Hathcock" -- beam cruiser
--"Melonidas"
--"Hunter"

function upgrade_player_ship(ship, upgrade)
	--patrol duty
	if upgrade == "kojak" then
		local b = 0
		repeat
			newRange = ship:getBeamWeaponRange(b) * 1.1
			newCycle = ship:getBeamWeaponCycleTime(b) * .9
			newDamage = ship:getBeamWeaponDamage(b) * 1.1
			tempArc = ship:getBeamWeaponArc(b)
			tempDirection = ship:getBeamWeaponDirection(b)
			ship:setBeamWeapon(b,tempArc,tempDirection,newRange,newCycle,newDamage)
			b = b + 1
		until(ship:getBeamWeaponRange(b) < 1)
		ship.kojakUpgrade = true
	elseif upgrade == "impulse-speed" then
		ship:setImpulseMaxSpeed(ship:getImpulseMaxSpeed()*1.25)
		ship.nabbitUpgrade = true		--patrol (1.2)
		ship.morrisonUpgrade = true	--shoreline 
		ship.fasterImpulseUpgrade = "done"	--border
	elseif upgrade == "beam-cool" then
		local b = 0
		repeat
			ship:setBeamWeaponHeatPerFire(b,ship:getBeamWeaponHeatPerFire(b) * 0.5)
			b = b + 1
		until(ship:getBeamWeaponRange(b) < 1)
		ship.lisbonUpgrade = true		--patrol
		ship.coolBeamUpgrade = "done"	--border
	elseif upgrade == "rotation-speed" then
		ship:setRotationMaxSpeed(ship:getRotationMaxSpeed()*2)
		ship.artAnchorUpgrade = true	--patrol
		ship.spinUpgrade = true		--shoreline
		ship.increaseSpinUpgrade = "done"	--border (1.5)
	elseif upgrade == "tube" then
		originalTubes = ship:getWeaponTubeCount()
		ship:setWeaponTubeCount(originalTubes+1)
		ship:setWeaponTubeExclusiveFor(originalTubes, "Homing")
		ship:setWeaponStorageMax("Homing", ship:getWeaponStorageMax("Homing") + 2)
		ship:setWeaponStorage("Homing", ship:getWeaponStorage("Homing") + 2)
		ship.auxTubeUpgrade = "done"	--border
	--shoreline
	elseif upgrade == "beam-range" then	
		local b = 0
		repeat
			newRange = ship:getBeamWeaponRange(b) * 1.25
			tempCycle = ship:getBeamWeaponCycleTime(b)
			tempDamage = ship:getBeamWeaponDamage(b)
			tempArc = ship:getBeamWeaponArc(b)
			tempDirection = ship:getBeamWeaponDirection(b)
			ship:setBeamWeapon(b,tempArc,tempDirection,newRange,tempCycle,tempDamage)
			b = b + 1
		until(ship:getBeamWeaponRange(b) < 1)
		ship.marconiBeamUpgrade = true	--shoreline
		ship.longerBeamUpgrade = "done"	--border
	elseif upgrade == "beam-damage" then
		local b = 0
		repeat
			tempRange = ship:getBeamWeaponRange(b)
			tempCycle = ship:getBeamWeaponCycleTime(b)
			newDamage = ship:getBeamWeaponDamage(b) * 1.25
			tempArc = ship:getBeamWeaponArc(b)
			tempDirection = ship:getBeamWeaponDirection(b)
			ship:setBeamWeapon(b,tempArc,tempDirection,tempRange,tempCycle,newDamage)
			b = b + 1
		until(ship:getBeamWeaponRange(b) < 1)
		ship.nefathaUpgrade = true		--shoreline
		ship.damageBeamUpgrade = "done"	--border (1.2)
	elseif upgrade == "shield" then
		frontShieldValue = ship:getShieldMax(0)
		rearShieldValue = ship:getShieldMax(1)
		ship:setShieldsMax(frontShieldValue*1.25,rearShieldValue*1.25)
		ship.shieldUpgrade = true				--shoreline
		ship.strongerShieldsUpgrade = "done"	--border (1.2, front only)
	--border
	elseif upgrade == "beam-cycle" then
		local b = 0
		repeat
			local tempArc = ship:getBeamWeaponArc(b)
			local tempDir = ship:getBeamWeaponDirection(b)
			local tempRng = ship:getBeamWeaponRange(b)
			local tempCyc = ship:getBeamWeaponCycleTime(b)
			local tempDmg = ship:getBeamWeaponDamage(b)
			ship:setBeamWeapon(b,tempArc,tempDir,tempRng,tempCyc * .75,tempDmg)
			b = b + 1
		until(ship:getBeamWeaponRange(b) < 1)
		ship.shrinkBeamCycleUpgrade = "done"
	elseif upgrade == "missiles" then	
		missile_types = {'Homing', 'Nuke', 'Mine', 'EMP', 'HVLI'}
		for _, missile_type in ipairs(missile_types) do
			ship:setWeaponStorageMax(missile_type, math.ceil(ship:getWeaponStorageMax(missile_type)*1.25))
		end
		ship.moreMissilesUpgrade = "done"
	elseif upgrade == "hull" then		
		ship:setHullMax(ship:getHullMax()*1.5)
		ship:setHull(ship:getHullMax())
		ship.strongerHullUpgrade = "done"
	elseif upgrade == "energy" then	
		ship:setMaxEnergy(ship:getMaxEnergy()*1.25)
		ship:setEnergy(ship:getMaxEnergy())
		ship.efficientBatteriesUpgrade = "done"
	else
		print("unknown upgrade "..upgrade)
	end
end
