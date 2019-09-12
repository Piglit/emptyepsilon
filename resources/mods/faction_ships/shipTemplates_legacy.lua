--those templates from shipTemplates_OLD are still used by scripts...

	
--[[ Enemy ship types --]]
-- Fighters are quick agile ships that do not do a lot of damage, but usually come in larger groups. They are easy to take out, but should not be underestimated.
template = ShipTemplate():setName("Fighter"):setModel("small_fighter_1")
template:setRadarTrace("radar_fighter.png")
template:setDescription("Fighters are quick agile ships that do not do a lot of damage, but usually come in larger groups. They are easy to take out, but should not be underestimated.")
--                  Arc, Dir, Range, CycleTime, Dmg
template:setBeam(0, 60, 0, 1000.0, 4.0, 4)
template:setHull(30)
template:setShields(30)
template:setSpeed(120, 30, 25)
template:setDefaultAI('fighter')	-- set fighter AI, which dives at the enemy, and then flies off, doing attack runs instead of "hanging in your face".


-- The cruiser is an average ship you can encounter, it has average shields, and average beams. It's pretty much average with nothing special.
-- Karnack cruiser mark I
	-- Fabricated by: Repulse shipyards
	-- Due to it's versitility, this ship has found wide adoptation in most factions. Most factions have extensively retrofitted these ships
	-- to suit their combat doctrines. Because it's an older model, most factions have been selling stripped versions. This practice has led to this ship becomming an all time favourite with smugglers and other civillian parties. However, they have used it's adaptable nature to re-fit them with (illigal) weaponry.
template = ShipTemplate():setName("Karnack"):setModel("small_frigate_4"):setClass("Frigate", "Cruiser")
template:setRadarTrace("radar_cruiser.png")
template:setDescription("Fabricated by: Repulse shipyards. Due to it's versatility, this ship has found wide adoptation in most factions. Most factions have extensively retrofitted these ships to suit their combat doctrines. Because it's an older model, most factions have been selling stripped versions. This practice has led to this ship becomming an all time favourite with smugglers and other civillian parties. However, they have used it's adaptable nature to re-fit them with (illegal) weaponry.")
--                  Arc, Dir, Range, CycleTime, Dmg
template:setBeam(0, 60, -15, 1000.0, 6.0, 6)
template:setBeam(1, 60,  15, 1000.0, 6.0, 6)
template:setHull(60)
template:setShields(40, 40)
template:setSpeed(60, 6, 10)


-- The gunship is a ship equiped with a homing missile tube to do initial damage and then take out the enemy with 2 front firing beams. It's designed to quickly take out the enemies weaker then itself.
template = ShipTemplate():setName("Gunship"):setModel("battleship_destroyer_4_upgraded"):setClass("Frigate","Gunship")
template:setRadarTrace("radar_adv_gunship.png")
template:setDescription("The gunship is a ship equiped with a homing missile tube to do initial damage and then take out the enemy with 2 front firing beams. It's designed to quickly take out the enemies weaker then itself.")
--                  Arc, Dir, Range, CycleTime, Dmg
template:setBeam(0, 50,-15, 1000.0, 6.0, 8)
template:setBeam(1, 50, 15, 1000.0, 6.0, 8)
template:setTubes(1, 8.0) -- Amount of torpedo tubes
template:setHull(100)
template:setShields(100, 80, 80)
template:setSpeed(60, 5, 10)
template:setWeaponStorage("Homing", 4)


-- The Strikeship is a warp-drive equiped figher build for quick strikes, it's fast, it's agile, but does not do an extreme amount of damage, and lacks in rear shields.
template = ShipTemplate():setName("Strikeship"):setModel("small_frigate_3"):setClass("Starfighter","Strike")
template:setRadarTrace("radar_striker.png")
template:setDescription("The Strikeship is a warp-drive equipped figher build for quick strikes, it's fast, it's agile, but does not do an extreme amount of damage, and lacks in rear shields.")
--                  Arc, Dir, Range, CycleTime, Dmg
template:setBeam(0, 40,-5, 1000.0, 6.0, 6)
template:setBeam(1, 40, 5, 1000.0, 6.0, 6)
template:setHull(100)
template:setShields(80, 30, 30, 30)
template:setSpeed(70, 12, 12)
template:setWarpSpeed(1000)

-- The Advanced Striker is a jump-drive equipped figher build for quick strikes, it's slow but very agile, but does not do an extreme amount of damage, and lacks in shields. However, due to the jump drive, it's quick to get into the action.
template = ShipTemplate():setName("Adv. Striker"):setClass("Starfighter","Patrol"):setModel("dark_fighter_6")
template:setRadarTrace("radar_adv_striker.png")
template:setDescription("The Advanced Striker is a jump-drive equipped figher build for quick strikes, it's slow but very agile, but does not do an extreme amount of damage, and lacks in shields. However, due to the jump drive, it's quick to get into the action.")
--                  Arc, Dir, Range, CycleTime, Dmg
template:setBeam(0, 50,-15, 1000.0, 6.0, 6)
template:setBeam(1, 50, 15, 1000.0, 6.0, 6)
template:setHull(70)
template:setShields(50, 30)
template:setSpeed(45, 12, 15)
template:setJumpDrive(true)

variation = template:copy("Striker"):setType("playership")
variation:setDescription("The Striker is the predecessor to the advanced striker, slow but agile, but does not do an extreme amount of damage, and lacks in shields")
variation:setBeam(0, 10,-15, 1000.0, 6.0, 6)
variation:setBeam(1, 10, 15, 1000.0, 6.0, 6)
--								  Arc, Dir, Rotate speed
variation:setBeamWeaponTurret( 0, 100, -15, 6)
variation:setBeamWeaponTurret( 1, 100,  15, 6)
variation:setHull(120)
variation:setSpeed(45, 15, 30)
variation:setJumpDrive(false)
variation:setCombatManeuver(250, 150)
variation:setEnergyStorage(500)

variation:setRepairCrewCount(2)

variation:addRoomSystem(4,0,3,1,"RearShield")
variation:addRoomSystem(3,1,3,1,"MissileSystem")
variation:addRoomSystem(0,1,1,1,"Beamweapons")
variation:addRoomSystem(1,1,1,3,"Reactor")
variation:addRoomSystem(2,2,3,1,"Warp")
variation:addRoomSystem(5,2,4,1,"JumpDrive")
variation:addRoomSystem(0,3,1,1,"Impulse")
variation:addRoomSystem(3,3,3,1,"Maneuver")
variation:addRoomSystem(4,4,3,1,"FrontShield")

variation:addDoor(1,1,false)
variation:addDoor(1,3,false)
variation:addDoor(2,2,false)
variation:addDoor(5,2,false)
variation:addDoor(4,3,true)
variation:addDoor(5,2,true)
variation:addDoor(4,1,true)
variation:addDoor(5,4,true)


--Cruiser: strike craft (fast in/out)
template = ShipTemplate():setName("Stalker Q7"):setClass("Frigate", "Cruiser: Strike ship"):setModel("small_frigate_3")
template:setDescription([[The Stalker is a strike ship designed to swoop into battle, deal damage quickly, and get out fast. The Q7 model is fitted with a warp drive.]])
template:setHull(50)
template:setShields(80, 30, 30, 30)
template:setSpeed(70, 12, 12)
template:setWarpSpeed(700)
template:setBeam(0, 40,-5, 1000.0, 6.0, 6)
template:setBeam(1, 40, 5, 1000.0, 6.0, 6)

variation = template:copy("Stalker R7")
variation:setDescription([[The Stalker is a strike ship designed to swoop into battle, deal damage quickly, and get out fast. The R7 model is fitted with a jump drive.]])
variation:setWarpSpeed(0)
variation:setJumpDrive(true)

template = ShipTemplate():setName("Ranus U"):setClass("Frigate", "Cruiser: Sniper"):setModel("MissileCorvetteGreen")
template:setDescription([[The Ranus U sniper is built to deal a large amounts of damage quickly and from a distance before escaping. It's the only basic frigate that carries nuclear weapons, even though it's also the smallest of all frigate-class ships.]])
template:setHull(30)
template:setShields(30, 5, 5)
template:setSpeed(50, 6, 20)
template:setTubes(3, 25.0)
template:weaponTubeDisallowMissle(1, "Nuke"):weaponTubeDisallowMissle(2, "Nuke")
template:setWeaponStorage("Homing", 6)
template:setWeaponStorage("Nuke", 2)

--[[                  Dreadnaught
Dreadnaughts are the largest ships.
They are so large and uncommon that every type is pretty much their own subclass.
They usually come with 6 or more shield sections, require a crew of 250+ to operate.

Think: Stardestroyer.
----------------------------------------------------------]]

template = ShipTemplate():setName("Odin"):setClass("Dreadnaught", "Odin"):setModel("space_station_2")
template:setRadarTrace("radartrace_largestation.png")
template:setDescription([[The Odin is a "ship" so large and unique that it's almost a class of its own.

The ship is often nicknamed the "all-father", a name that aptly describes the many roles this ship can fulfill. It's both a supply station and an extremely heavily armored and shielded weapon station capable of annihilating small fleets on its own.

Odin's core contains the largest jump drive ever created. About 150 support crew are needed to operate the jump drive alone, and it takes 5 days of continuous operation to power it.

Due to the enormous cost of this dreadnaught, only the richest star systems are able to build and maintain ships like the Odin. 

This machine's primary tactic is to jump into an unsuspecting enemy system and destroy everything before they know what hit them. It's effective and destructive, but extremely expensive.]])
template:setJumpDrive(true)
template:setTubes(16, 3.0)
template:setWeaponStorage("Homing", 1000)
for n=0,15 do
    template:setBeamWeapon(n, 90,  n * 22.5, 3200, 3, 10)
    template:setTubeDirection(n, n * 22.5)
end
template:setHull(2000)
template:setShields(1200, 1200, 1200, 1200, 1200, 1200)
template:setSpeed(0, 1, 0)
