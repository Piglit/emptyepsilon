require("utils.lua")

function mainMenu()
    if comms_target.comms_data == nil then
        comms_target.comms_data = {}
    end
    mergeTables(comms_target.comms_data, {
        friendlyness = random(0.0, 100.0),
		surrender_hull_threshold = 50,
        weapons = {
            Homing = "neutral",
            HVLI = "neutral",
            Mine = "neutral",
            Nuke = "friend",
            EMP = "friend"
        },
        weapon_cost = {
            Homing = math.random(1,4),
            HVLI = math.random(1,3),
            Mine = math.random(2,5),
            Nuke = math.random(12,18),
            EMP = math.random(7,13)
        },
        services = {
            supplydrop = "friend",
            reinforcements = "friend",
			fighters = "friend",
			refitDrive = "friend"
        },
        service_cost = {
            supplydrop = math.random(80,120),
            reinforcements = 150,
			--reinforcements_factor = math.random(16,24),
			fighterInterceptor = math.random(125,175),
			fighterBomber = math.random(150,200),
			fighterScout = math.random(175,225),
			refitDrive = math.random(100,200),
        },
        reputation_cost_multipliers = {
            friend = 1.0,
            neutral = 3.0
        },
        max_weapon_refill_amount = {
            friend = 1.0,
            neutral = 0.5
        }
    })

    -- comms_data is used globally
    comms_data = comms_target.comms_data

    if player:isEnemy(comms_target) then
		handleEnemy()
    end

    if comms_target:areEnemiesInRange(5000) then
        setCommsMessage("We are under attack! No time for chatting!");
        return true
    end
    if not player:isDocked(comms_target) then
        handleUndockedState()
    else
        handleDockedState()
    end
    return true
end

function handleDockedState()
    -- Handle communications while docked with this station.
    if player:isFriendly(comms_target) then
        setCommsMessage("Good day, officer! Welcome to " .. comms_target:getCallSign() .. ".\nWhat can we do for you today?")
    else
        setCommsMessage("Welcome to our lovely station " .. comms_target:getCallSign() .. ".")
    end

    if player:getWeaponStorageMax("Homing") > 0 then
        addCommsReply("Do you have spare homing missiles for us? ("..getWeaponCost("Homing").."rep each)", function()
            handleWeaponRestock("Homing")
        end)
    end
    if player:getWeaponStorageMax("HVLI") > 0 then
        addCommsReply("Can you restock us with HVLI? ("..getWeaponCost("HVLI").."rep each)", function()
            handleWeaponRestock("HVLI")
        end)
    end
    if player:getWeaponStorageMax("Mine") > 0 then
        addCommsReply("Please re-stock our mines. ("..getWeaponCost("Mine").."rep each)", function()
            handleWeaponRestock("Mine")
        end)
    end
    if player:getWeaponStorageMax("Nuke") > 0 then
        addCommsReply("Can you supply us with some nukes? ("..getWeaponCost("Nuke").."rep each)", function()
            handleWeaponRestock("Nuke")
        end)
    end
    if player:getWeaponStorageMax("EMP") > 0 then
        addCommsReply("Please re-stock our EMP missiles. ("..getWeaponCost("EMP").."rep each)", function()
            handleWeaponRestock("EMP")
        end)
    end
	local ptype = player:getTypeName()
	local stype = comms_target:getTypeName()
    if isAllowedTo(comms_data.fighters) then
		if stype == "Large Station" or stype == "Huge Station" then
			if ptype == "Atlantis" or ptype == "Crucible" or ptype == "Maverick" or ptype == "Benedict" or ptype == "Kiriya" then
				addCommsReply("Visit fighter bay", function()
					handleBuyShips()
				end)
			end
		end
	end
    if isAllowedTo(comms_data.refitDrive) then
		if stype == "Huge Station" and (player:hasWarpDrive() ~= player:hasJumpDrive()) then
			-- logical XOR with hasWarpDrive and hasJumpDrive
			addCommsReply("Refit your ships drive", function()
				handleChangeDrive()
			end)
		end
	end
end

function handleChangeDrive()
	if player:hasWarpDrive() and not player:hasJumpDrive() then
		setCommsMessage(string.format("Do you want us to change your warp drive to a jump drive? For only %i reputation.", getServiceCost("refitDrive")))
		addCommsReply("Make it so!", function()
			if not player:takeReputationPoints(getServiceCost("refitDrive")) then
				setCommsMessage("Insufficient reputation")
			else
				player:setWarpDrive(false)
				player:setJumpDrive(true)
				setCommsMessage("Consider it done.")
				return true
			end
		end)
	end
	if player:hasJumpDrive() and not player:hasWarpDrive() then
		setCommsMessage(string.format("Do you want us to change your jump drive to a warp drive? For only %i reputation.", getServiceCost("refitDrive")))
		addCommsReply("Make it so!", function()
			if not player:takeReputationPoints(getServiceCost("refitDrive")) then
				setCommsMessage("Insufficient reputation")
			else
				player:setWarpDrive(true)
				player:setJumpDrive(false)
				setCommsMessage("Consider it done.")
				return true
			end
		end)
	end
	addCommsReply("Back", mainMenu)
end

function handleBuyShips()
	setCommsMessage("Here you can start fighters that can be taken by your pilots. You do have a fighter pilot waiting, do you?")
	addCommsReply(string.format("Purchase unmanned MP52 Hornet Interceptor for %i reputation", getServiceCost("fighterInterceptor")), function()
		if not player:takeReputationPoints(getServiceCost("fighterInterceptor")) then
			setCommsMessage("Insufficient reputation")
		else
			local ship = PlayerSpaceship():setTemplate("MP52 Hornet"):setFactionId(player:getFactionId())
			ship:setAutoCoolant(true)
			ship:commandSetAutoRepair(true)
			ship:setPosition(comms_target:getPosition())
			setCommsMessage("We have dispatched " .. ship:getCallSign() .. " to be manned by one of your pilots")
			return true
		end
		addCommsReply("Back", mainMenu)
	end)
	addCommsReply(string.format("Purchase unmanned ZX-Lindworm Bomber for %i reputation", getServiceCost("fighterBomber")), function()
		if not player:takeReputationPoints(getServiceCost("fighterBomber")) then
			setCommsMessage("Insufficient reputation")
		else
			local ship = PlayerSpaceship():setTemplate("ZX-Lindworm"):setFactionId(player:getFactionId())
			ship:setAutoCoolant(true)
			ship:commandSetAutoRepair(true)
			ship:setPosition(comms_target:getPosition())
			setCommsMessage("We have dispatched " .. ship:getCallSign() .. " to be manned by one of your pilots")
			return true
		end
		addCommsReply("Back", mainMenu)
	end)
	addCommsReply(string.format("Purchase unmanned Adder MK7 Scout for %i reputation", getServiceCost("fighterScout")), function()
		if not player:takeReputationPoints(getServiceCost("fighterScout")) then
			setCommsMessage("Insufficient reputation")
		else
			local ship = PlayerSpaceship():setTemplate("Adder MK7"):setFactionId(player:getFactionId())
			ship:setAutoCoolant(true)
			ship:commandSetAutoRepair(true)
			ship:setPosition(comms_target:getPosition())
			setCommsMessage("We have dispatched " .. ship:getCallSign() .. " to be manned by one of your pilots")
			return true
		end
		addCommsReply("Back", mainMenu)
	end)
	addCommsReply("Back", mainMenu)
end

function handleWeaponRestock(weapon)
    if not player:isDocked(comms_target) then setCommsMessage("You need to stay docked for that action."); return end
    if not isAllowedTo(comms_data.weapons[weapon]) then
        if weapon == "Nuke" then setCommsMessage("We do not deal in weapons of mass destruction.")
        elseif weapon == "EMP" then setCommsMessage("We do not deal in weapons of mass disruption.")
        else setCommsMessage("We do not deal in those weapons.") end
        return
    end
    local points_per_item = getWeaponCost(weapon)
    local item_amount = math.floor(player:getWeaponStorageMax(weapon) * comms_data.max_weapon_refill_amount[getFriendStatus()]) - player:getWeaponStorage(weapon)
    if item_amount <= 0 then
        if weapon == "Nuke" then
            setCommsMessage("All nukes are charged and primed for destruction.");
        else
            setCommsMessage("Sorry, sir, but you are as fully stocked as I can allow.");
        end
        addCommsReply("Back", mainMenu)
    else
        if not player:takeReputationPoints(points_per_item * item_amount) then
            setCommsMessage("Not enough reputation.")
            return
        end
        player:setWeaponStorage(weapon, player:getWeaponStorage(weapon) + item_amount)
        if player:getWeaponStorage(weapon) == player:getWeaponStorageMax(weapon) then
            setCommsMessage("You are fully loaded and ready to explode things.")
        else
            setCommsMessage("We generously resupplied you with some weapon charges.\nPut them to good use.")
        end
        addCommsReply("Back", mainMenu)
    end
end

function handleUndockedState()
    --Handle communications when we are not docked with the station.
    if player:isFriendly(comms_target) then
        setCommsMessage("This is " .. comms_target:getCallSign() .. ". Good day, officer.\nIf you need supplies, please dock with us first.")
    else
        setCommsMessage("This is " .. comms_target:getCallSign() .. ". Greetings.\nIf you want to do business, please dock with us first.")
    end
    if isAllowedTo(comms_target.comms_data.services.supplydrop) then
        addCommsReply("Can you send a supply drop? ("..getServiceCost("supplydrop").."rep)", function()
            if player:getWaypointCount() < 1 then
                setCommsMessage("You need to set a waypoint before you can request backup.");
            else
                setCommsMessage("To which waypoint should we deliver your supplies?");
                for n=1,player:getWaypointCount() do
                    addCommsReply("WP" .. n, function()
                        if player:takeReputationPoints(getServiceCost("supplydrop")) then
                            local position_x, position_y = comms_target:getPosition()
                            local target_x, target_y = player:getWaypoint(n)
                            local script = Script()
                            script:setVariable("position_x", position_x):setVariable("position_y", position_y)
                            script:setVariable("target_x", target_x):setVariable("target_y", target_y)
                            script:setVariable("faction_id", comms_target:getFactionId()):run("supply_drop.lua")
                            setCommsMessage("We have dispatched a supply ship toward WP" .. n);
                        else
                            setCommsMessage("Not enough reputation!");
                        end
                        addCommsReply("Back", mainMenu)
                    end)
                end
            end
            addCommsReply("Back", mainMenu)
        end)
    end
    if isAllowedTo(comms_target.comms_data.services.reinforcements) then
        addCommsReply("Please send reinforcements! ("..getServiceCost("reinforcements").."rep)", function()
            if player:getWaypointCount() < 1 then
                setCommsMessage("You need to set a waypoint before you can request reinforcements.");
            else
                setCommsMessage("To which waypoint should we dispatch the reinforcements?");
                for n=1,player:getWaypointCount() do
                    addCommsReply("WP" .. n, function()
                        if player:takeReputationPoints(getServiceCost("reinforcements")) then
                            local ship = CpuShip():setFactionId(comms_target:getFactionId()):setPosition(comms_target:getPosition()):setTemplate("Adder MK5"):setScanned(true):orderDefendLocation(player:getWaypoint(n))
                            setCommsMessage("We have dispatched " .. ship:getCallSign() .. " to assist at WP" .. n);
                        else
                            setCommsMessage("Not enough reputation!");
                        end
                        addCommsReply("Back", mainMenu)
                    end)
                end
            end
            addCommsReply("Back", mainMenu)
        end)
    end
end

function handleEnemy()
	local min_shields = 100
	local shieldCount = comms_target:getShieldCount()
	if shieldCount == 0 then
		min_shields = 0
	else
		for n=0,shieldCount do
			local sl = comms_target:getShieldLevel(n)
			if sl < min_shields then
				min_shields = sl
			end
		end
	end
	if min_shields >= 100 then
		return false -- hang up
	end
	if min_shields > friendlyness then
		setCommsMessage("You will never break our shields!")
		return true
	end
	setCommsMessage("You may have done some damage, but you will never defeat us!")
	addCommsReply("Try something different - surrender.", function()
		local hull_percent = 100 * comms_target:getHull() / comms_target:getHullMax()
		if hull_percent > surrender_hull_threshold then
			setCommsMessage("The moment to surrender has not yet arrived. We choose to stand and fight!")
			return true
		end
		if hull_percent < friendlyness then
			setCommsMessage("The moment we surrender is the moment we lose our identity. We will hold on a little longer.")
			return true
		end
		local surrender_cost = hull_percent * math.random(1,4)
		setCommsMessage("Maybe we can find a solution to end this conflict.")
		addCommsReply(string.format("Surrender now. [reputation cost: %i]", surrender_cost), function()
			if not player:takeReputationPoints(surrender_cost) then
				setCommsMessage("Insufficient reputation")
			else
				comms_target:setFaction("Independent")
				comms_data.surrender_hull_threshold = comms_target:getHull() / 2
			end
		end)
	end)
end

function isAllowedTo(state)
    if state == "friend" and player:isFriendly(comms_target) then
        return true
    end
    if state == "neutral" and not player:isEnemy(comms_target) then
        return true
    end
    return false
end

-- Return the number of reputation points that a specified weapon costs for the
-- current player.
function getWeaponCost(weapon)
    return math.ceil(comms_data.weapon_cost[weapon] * comms_data.reputation_cost_multipliers[getFriendStatus()])
end

-- Return the number of reputation points that a specified service costs for
-- the current player.
function getServiceCost(service)
    return math.ceil(comms_data.service_cost[service])
end

function getFriendStatus()
    if player:isFriendly(comms_target) then
        return "friend"
    else
        return "neutral"
    end
end

mainMenu()
