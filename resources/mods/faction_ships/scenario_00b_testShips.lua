-- Name: Duel
-- Type: Basic

gunships = {
	"Rockbreaker",
	"Rockbreaker Merchant",
	"Rockbreaker Murderer",
	"Rockbreaker Mercenary",
	"Rockbreaker Marauder",
	"Rockbreaker Military",
	"Spinebreaker",
}
destroyers = {
	"Deathbringer",
	"Painbringer",
	"Doombringer",
}
fighters = {
	"Exuari Fighter",
	"Exuari Interceptor",
	"Exuari Bomber",
	"Exuari Heavy Bomber",
}
strikers = {
	"Exuari Alpha Striker",
	"Exuari Beta Striker",
	"Exuari Gamma Striker",
	"Exuari Delta Striker",
}
frigate_types = {
	["Mining Corporation"] = {
		"Phobos Y2",			--D 2
		"Piranha F12",			--D 1
		"Nirvana R5A",			--D 3
		--"Flavia Falcon",		--D -
	},
	["Blue Star Cartell"] = {
		"Phobos Vanguard",		--D 2
		"Nirvana Vanguard",		--D 2
		"Piranha Vanguard",		--D 1
		"Phobos Rear-Guard",	--D 2
		"Piranha Rear-Guard",	--D 1
		"Nirvana Rear-Guard",	--D 2
		--"Flavia Express",		--D -
	},
	["Human Navy"] = {
		"Phobos M3",		--D 2
		"Piranha M5",		--D 1
		"Nirvana R5M",		--D 2
		"Flavia AT",		--D -
		"Storm",			--D -
		"Atlantis X23"		--D 3
	},
	["Ghosts"] = {
		"Phobos G4",		--D 1
		"Piranha G4",		--D -
		"Nirvana 0x81",		--D 1
		"Flavia Sniper",	--D 2
		"Solar Storm",		--D -
	},
	["Criminals"] = {
		"Phobos Firehawk",	--D 2
		"Piranha F12.M",	--D 1
		"Nirvana Thunder Child",	--D 1
		"Flavia Medusa",	--D -
		"Lightning Storm",	--D -
	},
	["Independent"] = {
		"Phobos T3",		--D 2
		"Piranha F8",		--D 1
		"Nirvana R5",		--D 
	},
}

function spawnKDestroyerDuell(x,y)
	local orig_y = y
	for faction, frigates in pairs(frigate_types) do
		for _,frg in ipairs(frigates) do
			for _,gs in ipairs(destroyers) do
				local s = CpuShip():setTemplate(frg):setFaction(faction):setPosition(x,y):setRotation(90):orderDefendLocation(x,y)
				CpuShip():setTemplate(frg):setFaction(faction):setPosition(x,y-5000):setRotation(90):orderDefendTarget(s)
				CpuShip():setTemplate(gs):setFaction("Exuari"):setPosition(x,y+6000):setRotation(-90):orderRoaming()
				y = y - 20000
			end
			x = x - 12000
			y = orig_y
		end
	end
end
function spawnKFrigateDuell(x,y)
	local orig_y = y
	for faction, frigates in pairs(frigate_types) do
		for _,frg in ipairs(frigates) do
			for _,gs in ipairs(gunships) do
				local s = CpuShip():setTemplate(frg):setFaction(faction):setPosition(x,y):setRotation(90):orderDefendLocation(x,y)
				CpuShip():setTemplate(frg):setFaction(faction):setPosition(x,y-5000):setRotation(90):orderDefendTarget(s)
				CpuShip():setTemplate(gs):setFaction("Exuari"):setPosition(x,y+6000):setRotation(-90):orderRoaming()
				y = y - 20000
			end
			x = x - 12000
			y = orig_y
		end
	end
end

function spawnKFighterDuell(x,y)
	for faction, frigates in pairs(frigate_types) do
		for _,frg in ipairs(frigates) do
			local s = CpuShip():setTemplate(frg):setFaction(faction):setPosition(x,y):setRotation(90):orderDefendLocation(x,y)	
			CpuShip():setTemplate("Drone"):setFaction("Exuari"):setPosition(x,y+5000):setRotation(-90):orderAttack(s)
			CpuShip():setTemplate("Drone"):setFaction("Exuari"):setPosition(x+300,y+5300):setRotation(-90):orderAttack(s)
			x = x - 10000
			table.insert(duellingShips, s)
		end
	end
end

function spawnEStrikerDuell(x,y)
	local orig_y = y
	local orig_x = x
	for faction, frigates in pairs(frigate_types) do
		for _,frg in ipairs(frigates) do
			for _,gs in ipairs(strikers) do
				local s = CpuShip():setTemplate(frg):setFaction(faction):setPosition(x,y):setRotation(90):orderDefendLocation(x,y)
				CpuShip():setTemplate(frg):setFaction(faction):setPosition(x,y-5000):setRotation(90):orderDefendTarget(s)
				CpuShip():setTemplate(gs):setFaction("Exuari"):setPosition(x,y+6000):setRotation(-90):orderRoaming()
				y = y - 20000
			end
			x = x - 12000
			y = orig_y
		end
	end
end

function spawnEFighterDuell(x,y)
	local orig_x = x
	local orig_y = y
	for faction, frigates in pairs(frigate_types) do
		for _,frg in ipairs(frigates) do
			for _,fgt in ipairs(fighters) do
				local s = CpuShip():setTemplate(frg):setFaction(faction):setPosition(x,y):setRotation(90):orderDefendLocation(x,y)	
				y = y - 6000
				leader = CpuShip():setTemplate(fgt):setFaction("Exuari"):setPosition(x,y):setRotation(-90):orderAttack(s)
				CpuShip():setTemplate(fgt):setFaction("Exuari"):setPosition(x,y):setRotation(-90):orderFlyFormation(leader, -300, -300)
				second = CpuShip():setTemplate(fgt):setFaction("Exuari"):setPosition(x,y):setRotation(-90):orderFlyFormation(leader, -300, 300)
				CpuShip():setTemplate(fgt):setFaction("Exuari"):setPosition(x,y):setRotation(-90):orderFlyFormation(second, -300, 300)
				x = x - 10000
				y = orig_y
			end
		end
		orig_y = orig_y + 15000
		y = orig_y
		x = orig_x
	end
end


function init()
	--single fighter against single frigate
	--spawnKFighterDuell(-15000, 0)
	--spawnKFighterDuell(-15000, -15000)
	--spawnKFighterDuell(-15000,  15000)
	--spawnKFighterDuell(-15000, -30000)
	
	--spawnEFighterDuell(-15000, 0)
	spawnEStrikerDuell(-15000, 0)
	
	
	--Single gunship against frigates
	--spawnKFrigateDuell(15000, 15000)
	
	--Single destroyer against frigates
	--spawnKDestroyerDuell(15000, 15000)
	
end

function update(delta)

end
