-- Name: Exuari ship comms
-- Description: Exuari ship comms. friendlyness equals mood.
-- mood	< 25: bored (wants to attack)
-- 		< 50: calm  (ignores you)
-- 		< 75: excited (wants to attack)
-- 		>   : frenzied (ignores you)

function mainMenu()
	if comms_target.comms_data == nil then
		comms_target.comms_data = {friendlyness = random(25.0, 75.0)}
	end
	comms_data = comms_target.comms_data
	
	if player:isFriendly(comms_target) then
		return friendlyComms(comms_data)
	end
	if player:isEnemy(comms_target) and comms_target:isFriendOrFoeIdentifiedBy(player) then
		return enemyComms(comms_data)
	end
	return neutralComms(comms_data)
end

function friendlyComms(comms_data)
	if comms_data.friendlyness < 0 then
		return false
	elseif comms_data.friendlyness < 25 then
		setCommsMessage("A night out here in the black can be boring, right?")
	elseif comms_data.friendlyness < 50 then
		setCommsMessage("Sir, what activity to you suggest?")
	elseif comms_data.friendlyness < 75 then
		setCommsMessage("Why are you ruining the moment?")
	else
		setCommsMessage("KILL!!")
	end

	addCommsReply("Defend a waypoint", function() 
		friendlyDefendWaypoint(comms_data)
	end)

	addCommsReply("Assist me", function()
		friendlyAssistMe(comms_data)
	end)

	addCommsReply("Seek and destroy enemies at will", function()
		friendlyRoaming(comms_data)
	end)

	addCommsReply("Report status", function()
		friendlyReportStatus(comms_data)
	end)

	for _, obj in ipairs(comms_target:getObjectsInRange(5000)) do
		if obj.typeName == "SpaceStation" and not comms_target:isEnemy(obj) then
			addCommsReply("Dock at " .. obj:getCallSign(), function()
				friendlyDockAt(comms_data, obj)
			end)
		elseif comms_target:isEnemy(obj) then
			addCommsReply("Attack " .. obj:getCallSign(), function()
				friendlyAttack(comms_data, obj)
			end)
		end
	end
	
	return true
end

function friendlyDefendWaypoint(comms_data)
	if comms_data.friendlyness < 20 then
		setCommsMessage("Defense? Not Attack? No-no-no, I suggest, you better suggest something more fun.")
		comms_data.friendlyness = comms_data.friendlyness - random(1, 5)
		addCommsReply("Back", mainMenu)
	elseif comms_data.friendlyness > 80 then
		setCommsMessage("NOO! KILL! DEATH!")
		comms_target:orderRoaming()
		comms_data.friendlyness = comms_data.friendlyness - random(1, 5)
		return true
	else
		-- calm or excited enough to listen to this order
		if player:getWaypointCount() == 0 then
			setCommsMessage("No waypoints set. Please set a waypoint first.")
			addCommsReply("Back", mainMenu)
		else
			setCommsMessage("Which waypoint should we defend?");
			for n=1,player:getWaypointCount() do
				addCommsReply("Defend WP" .. n, function()
					comms_target:orderDefendLocation(player:getWaypoint(n))
					setCommsMessage("We are heading to assist at WP" .. n ..".")
					comms_data.friendlyness = comms_data.friendlyness + random(1, 5)
					addCommsReply("Back", mainMenu)
				end)
			end
		end
	end
end

function friendlyAssistMe(comms_data)
	if comms_data.friendlyness < 0 then
		setCommsMessage("No way. I think your life is as boring as mine.")
		return true
	elseif comms_data.friendlyness < 70 then
		setCommsMessage("Understood. Heading toward you to join your killing spree.")
		comms_data.friendlyness = comms_data.friendlyness + random(5, 15)
		comms_target:orderDefendTarget(player)
		addCommsReply("Back", mainMenu)
	elseif comms_data.friendlyness < 80 then
		setCommsMessage("Heading toward you to blast fun-holes in your ship.")
		comms_data.friendlyness = comms_data.friendlyness - random(1, 5)	-- minus: change to recover
		comms_target:orderAttack(player)
		return true
	else
		setCommsMessage("KILL! DEATH!")
		comms_data.friendlyness = comms_data.friendlyness - random(1, 5)
		comms_target:orderRoaming()
		return true
	end
end

function friendlyRoaming(comms_data)
	if comms_data.friendlyness < 75 then
		setCommsMessage("Understood. Looking forward for some amusement.")
		comms_target:orderRoaming()
		comms_data.friendlyness = comms_data.friendlyness + random(1, 15)
		return true
	else
		setCommsMessage("YES! KILL! DEATH!")
		comms_data.friendlyness = comms_data.friendlyness + random(1, 10)
		comms_target:orderRoaming()
		return true
	end
end

function friendlyReportStatus(comms_data)
	if comms_data.friendlyness < 75 then
		msg = "Hull: " .. math.floor(comms_target:getHull() / comms_target:getHullMax() * 100) .. "%\n"
		shields = comms_target:getShieldCount()
		if shields == 1 then
			msg = msg .. "Shield: " .. math.floor(comms_target:getShieldLevel(0) / comms_target:getShieldMax(0) * 100) .. "%\n"
		elseif shields == 2 then
			msg = msg .. "Front Shield: " .. math.floor(comms_target:getShieldLevel(0) / comms_target:getShieldMax(0) * 100) .. "%\n"
			msg = msg .. "Rear Shield: " .. math.floor(comms_target:getShieldLevel(1) / comms_target:getShieldMax(1) * 100) .. "%\n"
		else
			for n=0,shields-1 do
				msg = msg .. "Shield " .. n .. ": " .. math.floor(comms_target:getShieldLevel(n) / comms_target:getShieldMax(n) * 100) .. "%\n"
			end
		end

		missile_types = {'Homing', 'Nuke', 'Mine', 'EMP', 'HVLI'}
		for i, missile_type in ipairs(missile_types) do
			if comms_target:getWeaponStorageMax(missile_type) > 0 then
					msg = msg .. missile_type .. " Missiles: " .. math.floor(comms_target:getWeaponStorage(missile_type)) .. "/" .. math.floor(comms_target:getWeaponStorageMax(missile_type)) .. "\n"
			end
		end

		if comms_data.friendlyness < 25 then
			msg = msg .. "and utterly bored."
		end
		setCommsMessage(msg);
		addCommsReply("Back", mainMenu)
	else
		setCommsMessage("Status: KILLING! DYING!!")
		addCommsReply("Back", mainMenu)
	end
end

function friendlyDockAt(comms_data, obj)
	if comms_data.friendlyness < 30 then
		setCommsMessage("Refusing to dock at " .. obj:getCallSign() .. ", since this sounds even more boring.");
		comms_data.friendlyness = comms_data.friendlyness - random(1, 5)
		addCommsReply("Back", mainMenu)
	if comms_data.friendlyness < 60 then
		setCommsMessage("Docking at " .. obj:getCallSign() .. ".");
		comms_data.friendlyness = comms_data.friendlyness - random(10, 20)
		comms_target:orderDock(obj)
		addCommsReply("Back", mainMenu)
	else
		setCommsMessage("NOO! KILL! DEATH!")
		comms_target:orderRoaming()
		comms_data.friendlyness = comms_data.friendlyness - random(1, 5)
		return true
	end
end

function friendlyAttack(comms_data, obj)
	if comms_data.friendlyness < 70 then
		setCommsMessage("Heading forward to kill " .. obj:getCallSign() .. ".");
		comms_data.friendlyness = comms_data.friendlyness + random(10, 20)
		addCommsReply("Back", mainMenu)
	else
		setCommsMessage("KILLING " .. obj:getCallSign() .. "!!");
		comms_data.friendlyness = comms_data.friendlyness + random(10, 20)
		addCommsReply("Back", mainMenu)
	end
end


function enemyComms(comms_data)
	local change = 0
	if comms_data.friendlyness < 0 then
		return false
	end
	comms_target.friendlyness = comms_target.friendlyness + random(1,5)
	if comms_data.friendlyness < 25 then
		setCommsMessage("Send us your coordinates, so we can blow holes in your hulk.")
		change = 100 - 1.5*comms_data.friendlyness	-- [100, 62.5]
	elseif comms_data.friendlyness < 50 then
		setCommsMessage("Stay out of our way, or your death will amuse us extremely!")
		change = comms_data.friendlyness - 5	-- [20, 45]
	elseif comms_data.friendlyness < 75 then
		setCommsMessage("Come closer, so your death will amuse us extremely!")
		change = comms_data.friendlyness - 5	-- [45, 70]
	else
		setCommsMessage("KILL! DEATH!!");
		change = 150 - 1.5*comms_data.friendlyness	-- [37.5, 0]
	end

	local taunts = {"Proud and insolent creature, prepare to meet your doom.", "It's time to duell!", "Wouldn't you rather play chess? It's less destructive of ships.", "I have not time to spare while you cruise around; prepare instead for death."}
	for _,taunt in ipairs(taunts) do
		addCommsReply(taunt, function()
			comms_target.friendlyness = comms_target.friendlyness + random(5,25)
			if random(0, 100) < change then
				-- ignore everything else and attack player
				comms_target:orderAttack(player)
				if comms_data.friendlyness > 75 then
					setCommsMessage("I WILL KILL YOU DEAD!!")
				else
					setCommsMessage("Locked onto your coordinates, heading towards your destruction.")
				end
			elseif random(0, 100) < change then
				-- (reroll) move towards player, but attack everything on the way
				comms_target:orderFlyTowards(player:getPosition())
				if comms_data.friendlyness > 75 then
					setCommsMessage("I WILL KILL YOU DEAD! AND EVERYONE IN MY WAY!!")
				else
					setCommsMessage("Saved your coordinates. heading towards your destruction, as soon as we have time for it. Please meet us midways.")
				end
			else
				-- ignore player taunt
				if comms_data.friendlyness > 75 then
					setCommsMessage("DEATH PARTY IS HERE! YOU COME HERE TO DIE!!")
				else
					setCommsMessage("Ha-ha. If you truly have a death wish, we should meet at our coordinates.");
				end
			end
		end)
	end
end

function neutralComms(comms_data)
	if comms_data.friendlyness < 0 then
		return false
	elseif comms_data.friendlyness < 25 then
		setCommsMessage("A night out here in the black can be boring, right?")
	elseif comms_data.friendlyness < 50 then
		setCommsMessage("Sorry, we have no time to chat with you.\nWe are on an important mission.")
	elseif comms_data.friendlyness < 75 then
		setCommsMessage("Sorry, we have no time to chat with you.\nWe are on a killing spree.")
	else
		setCommsMessage("KILL! DEATH!!");
	end
	return true
end

mainMenu()