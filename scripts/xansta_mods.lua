require("script_formation.lua")

function init_constants_xansta()

	missile_types = {'Homing', 'Nuke', 'Mine', 'EMP', 'HVLI'}
	--Ship Template Name List
	stl = {
		["Human Navy"]= {
			["MU52 Hornet"]= 5,
			["WX-Lindworm"]= 7,
			["Adder MK6"]= 8,
			["Phobos M3"]= 15, --15 as long ai can't use mines
			["Piranha M5"]= 20,
			["Nirvana R5M"]= 21,
			["Storm"]= 22,
		},
		["Mining Corporation"]= {
			["Yellow Hornet"]= 5,
			["Yellow Lindworm"]= 7,
			["Yellow Adder MK5"]= 7,
			["Yellow Adder MK4"]= 6,

			["Phobos Y2"]= 16,	
			["Piranha F12"]= 15,
			["Nirvana R5A"]= 20,
		},
		["Blue Star Cartell"]= {
			["Blue Hornet"]= 5,
			["Blue Lindworm"]= 7,
			["Blue Adder MK5"]= 7,
			["Blue Adder MK4"]= 6,

			["Phobos Vanguard"]= 16, 
			["Phobos Rear-Guard"]= 15, -- 15 as long ai can't use mines
			["Piranha Vanguard"]= 17,
			["Piranha Rear-Guard"]= 15, -- 15 as long ai can't use mines
			["Nirvana Vanguard"]= 20,
			["Nirvana Rear-Guard"]= 20,
		},
		["Criminals"]= {
			["Red Hornet"]= 5,
			["Red Lindworm"]= 7,
			["Red Adder MK5"]= 7,
			["Red Adder MK4"]= 6,

			["Phobos Firehawk"]= 16,
			["Piranha F12.M"]= 17,
			["Nirvana Thunder Child"]= 21,
			["Lightning Storm"]= 22,
		},
		["Ghosts"]= {
			["Advanced Hornet"]= 5,
			["Advanced Lindworm"]= 7,
			["Advanced Adder MK5"]= 7,
			["Advanced Adder MK4"]= 6,

			["Phobos G4"]= 17,
			["Piranha G4"]= 16,
			["Nirvana 0x81"]= 22,
			["Solar Storm"]= 22,
		},
		["Kraylor"]= {
			["Drone"]= 5,
			["Rockbreaker"]= 22,
			["Rockbreaker Merchant"]= 25,
			["Rockbreaker Murderer"]= 26,
			["Rockbreaker Mercenary"]= 28,
			["Rockbreaker Marauder"]= 30,
			["Rockbreaker Military"]= 32,
			["Spinebreaker"]= 24,
			["Deathbringer"]= 47,
			["Painbringer"]= 50,
			["Doombringer"]= 65,
		},
		["Exuari"]= {
			["Exuari Fighter"]= 4,
			["Exuari Interceptor"]= 5,
			["Exuari Bomber"]= 4,
			["Exuari Heavy Bomber"]= 5,
			["Exuari Alpha Striker"]= 25,
			["Exuari Beta Striker"]= 30,
			["Exuari Gamma Striker"]= 25,
			["Exuari Delta Striker"]= 30,
			["Exuari Guard"]= 20,
			["Exuari Sentinel"]= 15,
			["Exuari Warden"]= 20,
			["Exuari Savior"]= 25,
		},
		["Ktlitans"]= {
			["Ktlitan Drone"]= 5,	
			["Ktlitan Worker"]= 15,	
			["Ktlitan Fighter"]= 22,	
			["Ktlitan Scout"]= 30,	
			["Ktlitan Breaker"]= 45,	
			["Ktlitan Feeder"]= 60,	
			["Ktlitan Destroyer"]= 75,
			["Ktlitan Queen"]= 100,	
		},
		["other"]= {
			["MT52 Hornet"]= 5,
			["WX-Lindworm"]= 7,
			["Adder MK5"]= 7,
			["Adder MK4"]= 6,
			["Phobos T3"]= 15,
			["Piranha F8"]= 15,
			["Nirvana R5"]= 19,
		}
	}
	stln = {}
	stnl = {}
	stsl = {}
	for faction, list in pairs(stl) do
			stln[faction] = {}
			for key, value in pairs(list) do
				table.insert(stln[faction], key)
				table.insert(stnl, key)
				table.insert(stsl, value)
			end
	end

	--Player Ship Beams
	psb = {}
	psb["MP52 Hornet"] = 2
	psb["Adder MK7"] = 4
	psb["Phobos M3P"] = 2
	psb["Flavia P.Falcon"] = 2
	psb["Atlantis"] = 2
	psb["Melonidas"] = 2
	psb["Player Cruiser"] = 2
	psb["Player Fighter"] = 2
	psb["Striker"] = 2
	psb["ZX-Lindworm"] = 1
	psb["Ender"] = 12
	psb["Repulse"] = 2
	psb["Benedict"] = 2
	psb["Kiriya"] = 2
	psb["Nautilus"] = 2
	psb["Hathcock"] = 4
	psb["Hunter"] = 1
	psb["Melonidas"] = 2
	-- square grid deployment
	fleetPosDelta1x = {0,1,0,-1, 0,1,-1, 1,-1,2,0,-2, 0,2,-2, 2,-2,2, 2,-2,-2,1,-1, 1,-1}
	fleetPosDelta1y = {0,0,1, 0,-1,1,-1,-1, 1,0,2, 0,-2,2,-2,-2, 2,1,-1, 1,-1,2, 2,-2,-2}
	-- rough hexagonal deployment
	fleetPosDelta2x = {0,2,-2,1,-1, 1, 1,4,-4,0, 0,2,-2,-2, 2,3,-3, 3,-3,6,-6,1,-1, 1,-1,3,-3, 3,-3,4,-4, 4,-4,5,-5, 5,-5}
	fleetPosDelta2y = {0,0, 0,1, 1,-1,-1,0, 0,2,-2,2,-2, 2,-2,1,-1,-1, 1,0, 0,3, 3,-3,-3,3,-3,-3, 3,2,-2,-2, 2,1,-1,-1, 1}
	--list of goods available to buy, sell or trade 
	goodsList = {	{"food",0},
					{"medicine",0},
					{"nickel",0},
					{"platinum",0},
					{"gold",0},
					{"dilithium",0},
					{"tritanium",0},
					{"luxury",0},
					{"cobalt",0},
					{"impulse",0},
					{"warp",0},
					{"shield",0},
					{"tractor",0},
					{"repulsor",0},
					{"beam",0},
					{"optic",0},
					{"robotic",0},
					{"filament",0},
					{"transporter",0},
					{"sensor",0},
					{"communication",0},
					{"autodoc",0},
					{"lifter",0},
					{"android",0},
					{"nanites",0},
					{"software",0},
					{"circuit",0},
					{"battery",0}	}
	playerShipNamesForMP52Hornet = {"Dragonfly","Scarab","Mantis","Yellow Jacket","Jimminy","Flik","Thorny","Buzz"}
	playerShipNamesForPiranha = {"Razor","Biter","Ripper","Voracious","Carnivorous","Characid","Vulture","Predator"}
	playerShipNamesForFlaviaPFalcon = {"Ladyhawke","Hunter","Seeker","Gyrefalcon","Kestrel","Magpie","Bandit","Buccaneer"}
	playerShipNamesForPhobosM3P = {"Blinder","Shadow","Distortion","Diemos","Ganymede","Castillo","Thebe","Retrograde"}
	playerShipNamesForAtlantis = {"Excaliber","Thrasher","Punisher","Vorpal","Protang","Drummond","Parchim","Coronado"}
	playerShipNamesForCruiser = {"Excelsior","Velociraptor","Thunder","Kona","Encounter","Perth","Aspern","Panther"}
	playerShipNamesForMissileCruiser = {"Projectus","Hurlmeister","Flinger","Ovod","Amatola","Nakhimov","Antigone"}
	playerShipNamesForFighter = {"Buzzer","Flitter","Zippiticus","Hopper","Molt","Stinger","Stripe"}
	playerShipNamesForBenedict = {"Elizabeth","Ford","Vikramaditya","Liaoning","Avenger","Naruebet","Washington","Lincoln","Garibaldi","Eisenhower"}
	playerShipNamesForKiriya = {"Cavour","Reagan","Gaulle","Paulo","Truman","Stennis","Kuznetsov","Roosevelt","Vinson","Old Salt"}
	playerShipNamesForStriker = {"Sparrow","Sizzle","Squawk","Crow","Phoenix","Snowbird","Hawk"}
	playerShipNamesForLindworm = {"Seagull","Catapult","Blowhard","Flapper","Nixie","Pixie","Tinkerbell"}
	playerShipNamesForRepulse = {"Fiddler","Brinks","Loomis","Mowag","Patria","Pandur","Terrex","Komatsu","Eitan"}
	playerShipNamesForEnder = {"Mongo","Godzilla","Leviathan","Kraken","Jupiter","Saturn"}
	playerShipNamesForNautilus = {"October", "Abdiel", "Manxman", "Newcon", "Nusret", "Pluton", "Amiral", "Amur", "Heinkel", "Dornier"}
	playerShipNamesForHathcock = {"Hayha", "Waldron", "Plunkett", "Mawhinney", "Furlong", "Zaytsev", "Pavlichenko", "Pegahmagabow", "Fett", "Hawkeye", "Hanzo"}
	playerShipNamesForLeftovers = {"Foregone","Righteous","Masher"}
	playerShipNamesForMelonidas = {"U.S.S. Koenig Melonidas", "U.S.S. Koenig Melonidas II ", "U.S.S. Koenig Melonidas III"}
	playerShipNamesForHunter = {"Huntmaster", "Huntmaster II", "Huntmaster III"}

end

function modify_player_ships(pobj)
	--called during setPlayers()
	if not pobj.modsAssigned then
		pobj.modsAssigned = true
		local tempPlayerType = pobj:getTypeName()
		if tempPlayerType == "MP52 Hornet" then
			if #playerShipNamesForMP52Hornet > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				local ni = math.random(1,#playerShipNamesForMP52Hornet)
				pobj:setCallSign(playerShipNamesForMP52Hornet[ni])
				table.remove(playerShipNamesForMP52Hornet,ni)
			end
			pobj.shipScore = 7
			pobj.maxCargo = 3
			pobj.autoCoolant = false
--			pobj:setWarpDrive(true)
		elseif tempPlayerType == "ZX-Lindworm" then
			if #playerShipNamesForLindworm > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = math.random(1,#playerShipNamesForLindworm)
				pobj:setCallSign(playerShipNamesForLindworm[ni])
				table.remove(playerShipNamesForLindworm,ni)
			end
			pobj.shipScore = 8
			pobj.maxCargo = 3
			pobj.autoCoolant = false
--			pobj:setWarpDrive(true)
		elseif tempPlayerType == "Adder MK7" then
			if #playerShipNamesForStriker > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = math.random(1,#playerShipNamesForStriker)
				pobj:setCallSign(playerShipNamesForStriker[ni])
				table.remove(playerShipNamesForStriker,ni)
			end
			pobj.shipScore = 8
			pobj.maxCargo = 4
			pobj.autoCoolant = false
--			pobj:setJumpDrive(true)
--			pobj:setJumpDriveRange(3000,40000)
		elseif tempPlayerType == "Phobos M3P" then
			if #playerShipNamesForPhobosM3P > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = math.random(1,#playerShipNamesForPhobosM3P)
				pobj:setCallSign(playerShipNamesForPhobosM3P[ni])
				table.remove(playerShipNamesForPhobosM3P,ni)
			end
			pobj.shipScore = 19
			pobj.maxCargo = 10
--			pobj:setWarpDrive(true)
		elseif tempPlayerType == "Hathcock" then
			if #playerShipNamesForHathcock > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = math.random(1,#playerShipNamesForHathcock)
				pobj:setCallSign(playerShipNamesForHathcock[ni])
				table.remove(playerShipNamesForHathcock,ni)
			end
			pobj.shipScore = 30
			pobj.maxCargo = 6
		elseif tempPlayerType == "Piranha M5P" then
			if #playerShipNamesForPiranha > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = math.random(1,#playerShipNamesForPiranha)
				pobj:setCallSign(playerShipNamesForPiranha[ni])
				table.remove(playerShipNamesForPiranha,ni)
			end
			pobj.shipScore = 16
			pobj.maxCargo = 8
		elseif tempPlayerType == "Flavia P.Falcon" then
			if #playerShipNamesForFlaviaPFalcon > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = math.random(1,#playerShipNamesForFlaviaPFalcon)
				pobj:setCallSign(playerShipNamesForFlaviaPFalcon[ni])
				table.remove(playerShipNamesForFlaviaPFalcon,ni)
			end
			pobj.shipScore = 13
			pobj.maxCargo = 15
		elseif tempPlayerType == "Atlantis" then
			if #playerShipNamesForAtlantis > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = math.random(1,#playerShipNamesForAtlantis)
				pobj:setCallSign(playerShipNamesForAtlantis[ni])
				table.remove(playerShipNamesForAtlantis,ni)
			end
			pobj.shipScore = 52
			pobj.maxCargo = 6
		elseif tempPlayerType == "Melonidas" then
			if #playerShipNamesForMelonidas> 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = 1
				pobj:setCallSign(playerShipNamesForMelonidas[ni])
				table.remove(playerShipNamesForMelonidas,ni)
			end
			pobj.shipScore = 52
			pobj.maxCargo = 6
		elseif tempPlayerType == "Hunter" then
			if #playerShipNamesForHunter> 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = 1
				pobj:setCallSign(playerShipNamesForHunter[ni])
				table.remove(playerShipNamesForHunter,ni)
			end
			pobj.shipScore = 52
			pobj.maxCargo = 6
		elseif tempPlayerType == "Benedict" then
			if #playerShipNamesForBenedict > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = math.random(1,#playerShipNamesForBenedict)
				pobj:setCallSign(playerShipNamesForBenedict[ni])
				table.remove(playerShipNamesForBenedict,ni)
			end
			pobj.shipScore = 10
			pobj.maxCargo = 9
		elseif tempPlayerType == "Kiriya" then
			if #playerShipNamesForKiriya > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = math.random(1,#playerShipNamesForKiriya)
				pobj:setCallSign(playerShipNamesForKiriya[ni])
				table.remove(playerShipNamesForKiriya,ni)
			end
			pobj.shipScore = 10
			pobj.maxCargo = 9
		elseif tempPlayerType == "Repulse" then
			if #playerShipNamesForRepulse > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = math.random(1,#playerShipNamesForRepulse)
				pobj:setCallSign(playerShipNamesForRepulse[ni])
				table.remove(playerShipNamesForRepulse,ni)
			end
			pobj.shipScore = 14
			pobj.maxCargo = 12
		elseif tempPlayerType == "Ender" then
			if #playerShipNamesForEnder > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = math.random(1,#playerShipNamesForEnder)
				pobj:setCallSign(playerShipNamesForEnder[ni])
				table.remove(playerShipNamesForEnder,ni)
			end
			pobj.shipScore = 100
			pobj.maxCargo = 20
		elseif tempPlayerType == "Nautilus" then
			if #playerShipNamesForNautilus > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = math.random(1,#playerShipNamesForNautilus)
				pobj:setCallSign(playerShipNamesForNautilus[ni])
				table.remove(playerShipNamesForNautilus,ni)
			end
			pobj.shipScore = 12
			pobj.maxCargo = 7
		else
			if #playerShipNamesForLeftovers > 0 and not pobj.nameAssigned then
				pobj.nameAssigned = true
				ni = math.random(1,#playerShipNamesForLeftovers)
				pobj:setCallSign(playerShipNamesForLeftovers[ni])
				table.remove(playerShipNamesForLeftovers,ni)
			end
			pobj.shipScore = 24
			pobj.maxCargo = 5
--			pobj:setWarpDrive(true)
		end
	end
end


function spawn_enemies_faction(xOrigin, yOrigin, enemyStrength, enemyFaction, customShipNameList, customShipScoreList, strengthIsNumberOfShips)

	if strengthIsNumberOfShips == nil then
		strengthIsNumberOfShips = false
	end
	local enemyFactionScoreList = stl[enemyFaction]
	local enemyFactionNameList = stln[enemyFaction]
	if stl[enemyFaction] == nil then
		enemyFactionScoreList = stl["other"]
		enemyFactionNameList = stln["other"]
	end

	if customShipNameList ~= nil then
		enemyFactionNameList = customShipNameList
	end
	if customShipScoreList ~= nil then
		enemyFactionScoreList = customShipScoreList
	end
	
	local totalStrength = 0
	local enemyNameList = {}
	local enemyList = {}

	local enemyPosition = 0
	local sp = irandom(300,500)			--random spacing of spawned group
	local deployConfig = random(1,100)	--randomly choose between squarish formation and hexagonish formation

	local formationLeader = nil
	local formationSecond = nil

	-- Reminder: stsl and stnl are ship template score and name list
	while enemyStrength > 0 do
		local shipTemplateType = enemyFactionNameList[ irandom(1,#enemyFactionNameList) ]
		if strengthIsNumberOfShips then
			enemyStrength = enemyStrength -1
		else
			while enemyFactionScoreList[shipTemplateType] > enemyStrength * 1.1 + 5 do
				shipTemplateType = enemyFactionNameList[ irandom(1,#enemyFactionNameList) ]
			end		
			enemyStrength = enemyStrength - enemyFactionScoreList[shipTemplateType]
		end
		table.insert(enemyNameList, shipTemplateType)
		if enemyFactionScoreList[shipTemplateType] ~= nil then
			totalStrength = totalStrength + enemyFactionScoreList[shipTemplateType]
		end
	end

	-- here other formation or spawn logic is possible. E.g. Hangar code
	for index,shipTemplateType in ipairs(enemyNameList) do
		local ship = CpuShip():setFaction(enemyFaction):setTemplate(shipTemplateType):orderRoaming()
		enemyPosition = enemyPosition + 1
		if deployConfig < 50 then
			ship:setPosition(xOrigin+fleetPosDelta1x[enemyPosition]*sp,yOrigin+fleetPosDelta1y[enemyPosition]*sp)
		else 
			ship:setPosition(xOrigin+fleetPosDelta2x[enemyPosition]*sp,yOrigin+fleetPosDelta2y[enemyPosition]*sp)
		end
		if enemyFaction == "Kraylor" then
			--kraylor formation
			formationLeader, formationSecond = script_formation.buildFormationIncremental(ship, enemyPosition, formationLeader, formationSecond)
		end
		table.insert(enemyList, ship)
	end
	return enemyList, totalStrength
end


