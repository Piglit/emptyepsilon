--Exuari ships
--
--Usage in scenarios:
-- Eighter Agent-Style: one to few ships attack chosen target.
-- Or Assault-Style: Carrier with defending Frigates start somewhere off-sector. Carrier starts waves of all kinds of fighters and Artillery. Upon first resistance, Strikers are started.
--
--Faction style (equipment):
-- shields weaker than kraylor/human shields
-- front shields stronger than rear shields
-- hull stronger than shields
-- weaker beams than kraylor/human beams
-- many missiles, including missiles of mass destruction
-- most hvli, less homing; both small
-- focus on small specialiced ships and fighters
-- small ships with many thin parts. Wings.
-- Models: small_frigate_{1-5} and maybe dark_fighter_6, small_fighter_1, space_cruiser_4 (as fighter)
-- TODO use pool of small_frigate in different size for (same) ship
--
--Tech details:
-- Beams
--  Exuari Fighter beam: rng 1000, cycle 4, dmg 4, dps 1
--  Exuari Striker beam: rng 1000, cycle 6, dmg 6, dps 1
--  Exuari Turret  beam: rng 1200, cycle 3/6/9, dmg 2/4/6, dps 0.66 
-- Hull/shields
--  Fighter 30, 30
--  Bomber  40, 30
--  Striker 50, 50/30 or 80/30/30/30
--  Frigate 70, 50/40 (more variation)
-- Engines
--  Fighter 120-130, 30-35, 25-30
--  Bomber  70, 20, 15
--  Striker 70, 12, 12 +warp
--  Frigate 40-70, 6-15, 8-20 
--  Station 20, 1.5, 3
--
--remaining Names
-- Butch
-- Ace
-- Wilder
--
--Striker Names
-- Racer
-- Hunter
-- Strike
-- Dash
--
--Fighter Names
-- Dagger
-- Blade
-- Gunner
-- Shooter
-- Jagger
--
--Defender Names
-- Warden
-- Sentinel
-- Guard
--
--Sniper Names
-- Flash
-- Ranger
-- Buster
--
--Defender Names (unused)
-- Rebel
-- Ransom
-- Rowdy
--
--Carrier Names
-- Ryder


--[[ Fighters --]]
-- Fighters are quick agile ships that do not do a lot of damage, but usually come in larger groups. They are easy to take out, but should not be underestimated.
template = ShipTemplate():setName("Dagger"):setClass("Exuari", "Starfighter - Fighter")
template:setModel("small_fighter_1")
template:setRadarTrace("radar_exuari_fighter.png")
template:setDescription("The Exuari fighter 'Dagger' is a single-seated spacecraft, very quick and agile, that does not do a lot of damage, but usually comes in larger groups. They are able to dodge most missiles and attack undefended areas of their enemies ships. However most of the Exuari fighter pilots expect their own death and do not care much about the enemies weapons ranges. Fighters are easy to take out, but should not be underestimated.")
--                  Arc, Dir, Range, CycleTime, Dmg
template:setBeam(0, 60, 0, 1000.0, 4.0, 4)
template:setHull(30)
template:setShields(30)
template:setSpeed(120, 30, 25)
template:setDefaultAI('fighter')	-- set fighter AI, which dives at the enemy, and then flies off, doing attack runs instead of "hanging in your face".
--threat level: 1(dps)+0(tube)+1.5(shields)+1.5(hull)+1.2(speed)+3(maneuver) = 1+1.5+1.5+1.2+3=8.2 => 4.1

variation = template:copy("Blade")
variation:setClass("Exuari", "Starfighter - Interceptor")
variation:setModel("dark_fighter_6")
variation:setDescription("The Exuari interceptor 'Blade' is a improved fighter, originaly designed to hunt down rougue fighters. Nowadays Blades are often seen as the first attack wave of a larger assault, closely followed by Daggers. Blade pilots are often considered as fearless, but most of them are just consumed by their instinct for hunting.")
--                  Arc, Dir, Range, CycleTime, Dmg
variation:setBeam(0, 60, 0, 1000.0, 4.0, 4)
variation:setBeam(1, 60, 0, 1000.0, 4.0, 4)
variation:setSpeed(130, 35, 30)
--threat level: 2(dps)+0(tube)+1.5(shields)+1.5(hull)+1.3(speed)+3(maneuver) = 2+1.5+1.5+1.3+3=9.3 => 4.7

template = ShipTemplate():setName("Gunner"):setClass("Exuari", "Starfighter - Light Bomber")
template:setModel("small_fighter_1")
template:setRadarTrace("radar_exuari_fighter.png")
template:setDescription("The Exuari light bomber 'Gunner' is a single-seated spacecraft, designed to circumvent their enemies defense lines and bring its deadly load to slow moving targets. Gunners are not as agile as other fighters, but still faster than most capitol ships. A group of Gunners can do a lot of damage to a single stationary target if not destroyed before their target is inside their weapons range. Piloting a Gunner is considered to be a recreational (and often lethal) activity within the Exuari society, so don't expect experienced pilots.")
--                  Arc, Dir, Range, CycleTime, Dmg
template:setBeam(0, 60, 0, 1000.0, 4.0, 4)
template:setHull(40)
template:setShields(30)
template:setSpeed(70, 20, 15)
template:setDefaultAI('fighter')	-- set fighter AI, which dives at the enemy, and then flies off, doing attack runs instead of "hanging in your face".
template:setTubes(1, 60.0)
template:setTubeSize(0, "small")
template:setWeaponStorage("HVLI", 1)
--threat level: 1(dps)+1(tube)+1.5(shields)+2(hull)+.7(speed)+2(maneuver) = 8.2 => 4.1

variation = template:copy("Shooter")
variation:setClass("Exuari", "Starfighter - Bomber")
variation:setDescription("The Exuari bomber 'Shooter' carries two rounds of HVLIs. To keep the vessel at low costs, it has no automatic missile recharge system, so the single pilot has to load the second round manually. Shooter pilots tend to stay on the battlefield, even without ammunition and enjoy death spreading. Due to it's long reload cycle a Shooter may easily be destroyed between its attack runs.")
variation:setTubeSize(0, "medium")
variation:setWeaponStorage("HVLI", 2)
--threat level: 1(dps)+2(tube)+1.5(shields)+2(hull)+.7(speed)+2(maneuver) = 9.2 => 4.7

variation = template:copy("Jagger")
variation:setClass("Exuari", "Starfighter - Heavy Bomber")
variation:setDescription("The Exuari heavy bomber 'Jagger' carries just a single round of improved HVLIs. Those are considered to be hull-penetrating and cause multiple times the damage of Gunner HVLIs.")
variation:setTubeSize(0, "large")

--[[ Strikers --]]
-- The Strikeship is a warp-drive equipped figher build for quick strikes, it's fast, it's agile, but does not do an extreme amount of damage, and lacks in rear shields.
template = ShipTemplate():setName("Racer"):setClass("Exuari","Striker")
template:setModel("small_frigate_1"):setRadarTrace("radar_exuari_1.png")
template:setDescription("The Exuari alpha striker 'Racer' is a warp-drive equipped Figter build for quick strikes. This spacecraft runs on a small crew and is often used as scout, interceptor or to perform preemptive attacks. It's fast, it's agile, but the striker beams do not cause an extreme amount of damage. Like all strikers, it lacks in rear shields.")
--                  Arc, Dir, Range, CycleTime, Dmg
template:setBeam(0, 40,-5, 1000.0, 6.0, 6)
template:setBeam(1, 40, 5, 1000.0, 6.0, 6)
template:setHull(50)
template:setShields(50, 30)
template:setSpeed(70, 12, 12)
template:setWarpSpeed(600)
--threat level: 2(dps)+0(tube)+2(shields)+2.5(hull)+5+0.7(speed)+1.2(maneuver) = 13.4 => 6.7

variation = template:copy("Hunter")
variation:setDescription("The Exuari beta striker 'Hunter' is a warp-drive equipped reinforement fighter. This spacecraft runs on a small crew and is often sent into battle to aid other Exuari ships when they engage in combat. It has an extra pair of striker beams and improved front shields. It's fast, it's agile, and can clean up what is left of the enemies fleet after an initial strike.")
variation:setModel("small_frigate_4"):setRadarTrace("radar_exuari_4.png")
variation:setBeam(2, 50,-15, 1000.0, 6.0, 6)
variation:setBeam(3, 50, 15, 1000.0, 6.0, 6)
variation:setShields(80, 30)
variation:setWarpSpeed(400)
--threat level: 4(dps)+0(tube)+2.5(shields)+2.5(hull)+4+0.7(speed)+1.2(maneuver) = 14.9 = 7.5

variation = template:copy("Strike")
variation:setDescription("The Exuari gamma striker 'Strike' is a warp-drive equipped tactical bomber build for quick strikes against strong shielded targets. This spacecraft runs on a small crew and is equipped with HVLIs and an EMP. It's fast, it's agile, and can do a great amount of damage in short time.")
variation:setModel("small_frigate_3"):setRadarTrace("radar_exuari_3.png")
variation:setTubes(1, 10.0)
variation:setWeaponStorage("EMP", 1)
variation:setWeaponStorage("HVLI", 2)
variation:setWarpSpeed(300)
--threat level: 2(dps)+3(tube)+2(shields)+2.5(hull)+2.5+0.7(speed)+1.2(maneuver) = 13.9 => 6.5

variation = template:copy("Dash")
variation:setDescription("The Exuari delta striker 'Dash' is a warp-drive equipped endurance bomber build for prolonged strikes. This spacecraft runs on a small crew and combines reinforced front shields with a good amount of HVLIs. It's fast, it's agile, and can take some damage.")
variation:setModel("small_frigate_5"):setRadarTrace("radar_exuari_5.png")
variation:setTubes(1, 10.0)
variation:setWeaponStorage("HVLI", 4)
variation:setHull(70)
variation:setShields(80, 30)
variation:setWarpSpeed(200)
--threat level: 2(dps)+4(tube)+2.5(shields)+3.5(hull)+1.5+0.7(speed)+1.2(maneuver) = 15.4 => 7.7

--[[ Frigates--]]
--Frigates are non-warp capable ships, mostly used to defend bases or to build the rear line in an assault.

template = ShipTemplate():setName("Guard"):setClass("Exuari", "Frigate")
template:setModel("transport_1_1"):setRadarTrace("radar_exuari_frigate_1.png")
template:setDescription([[The Exuari Guard is not impressive, trying to be a alround escort or defense vessel. It has powering problems, causing the reload cycle of beams and missiles to take longer than expected. The Guard is equipped with turret beams and a large stock of different missiles, including homing missiles and mines.]])
template:setHull(70)
template:setShields(50, 40)
template:setSpeed(55, 10, 10)
template:setBeamWeapon(0, 10, -15, 1200, 9, 6)
template:setBeamWeapon(1, 10,  15, 1200, 9, 6)
template:setBeamWeaponTurret(0, 180, -15, 5)
template:setBeamWeaponTurret(1, 180,  15, 5)
template:setTubes(3, 60.0)
template:setWeaponStorage("Mine", 6)
template:setWeaponStorage("HVLI", 20)
template:setWeaponStorage("Homing", 6)
template:setTubeDirection(0, -1):weaponTubeDisallowMissle(0, "Mine")
template:setTubeDirection(1,  1):weaponTubeDisallowMissle(1, "Mine")
template:setTubeDirection(2,  180):setWeaponTubeExclusiveFor(2, "Mine")
--threat level: 2(dps)+12(tube)+2.5(shields)+3.5(hull)+0.5(speed)+1(maneuver) = 21.5 => 10.8

template = ShipTemplate():setName("Sentinel"):setClass("Exuari", "Frigate")
template:setModel("transport_3_1"):setRadarTrace("radar_exuari_frigate_2.png")
template:setDescription([[The Exuari Sentinel is an anti-fighter frigate. It has several rapid-firing, low-damage point-defense turret beams to quickly take out starfighters.]])
template:setBeamWeapon(0, 20, -9, 1200, 3, 2)
template:setBeamWeapon(1, 20,  9, 1200, 3, 2)
template:setBeamWeapon(2, 20,  50, 1200, 3, 2)
template:setBeamWeapon(3, 20, -50, 1200, 3, 2)
template:setBeamWeaponTurret(0, 180, -9, 5)
template:setBeamWeaponTurret(1, 180,  9, 5)
template:setBeamWeaponTurret(2, 180,  50, 5)
template:setBeamWeaponTurret(3, 180, -50, 5)
template:setHull(70)
template:setShields(50, 40)
template:setSpeed(70, 15, 10)
--threat level: 4(dps)+0(tube)+2.5(shields)+3.5(hull)+0.7(speed)+1.5(maneuver) = 12.2 => 6.1

template = ShipTemplate():setName("Warden"):setClass("Exuari", "Frigate")
template:setModel("transport_4_1"):setRadarTrace("radar_exuari_frigate_3.png")
template:setDescription([[The Exuari Warden is a heavy artillery frigate, it fires bunches of missiles from forward facing tubes. Only a single point defense turret is present.]])
template:setBeamWeapon(0, 20, 0, 1200, 3, 2)
template:setBeamWeaponTurret(0, 270, 0, 5)
template:setHull(50)
template:setShields(30, 30)
template:setSpeed(40, 6, 8)
template:setTubes(5, 15.0)
template:setWeaponStorage("HVLI", 15)
template:setWeaponStorage("Homing", 15)
template:setTubeDirection(0,  0)
template:setTubeDirection(1, -1)
template:setTubeDirection(2,  1)
template:setTubeDirection(3, -2)
template:setTubeDirection(4,  2)
--threat level: 1(dps)+15(tube)+1.5(shields)+2.5(hull)+0.4(speed)+.6(maneuver) = 21 => 10.5

--[[ Artillery--]]
--Artillery are non-warp capable ships, mostly used to delivers Nukes to their enemies. They may be disguised as Transport ships (or are refurbished freighters). 
template = ShipTemplate():setName("Flash"):setClass("Exuari", "Artillery")
template:setModel("small_frigate_2"):setRadarTrace("radar_exuari_2.png")
template:setDescription([[The Exuari Flash is a special artillery sniper, built to deal a large amounts of damage quickly and from a distance before escaping. It's a basic freighter that carries nuclear weapons. Some say, this is what happens to freighters, when they fall into the hands of the Exuari.]])
template:setHull(30)
template:setShields(30, 5, 5)
template:setSpeed(50, 6, 20)
template:setTubes(3, 25.0)
template:weaponTubeDisallowMissle(1, "Nuke"):weaponTubeDisallowMissle(2, "Nuke")
template:setWeaponStorage("Homing", 6)
template:setWeaponStorage("Nuke", 2)
--threat level: 0(dps)+16(tube)+1(shields)+1.5(hull)+0.5(speed)+.6(maneuver) = 19.6 => 9.8

variation = template:copy("Ranger")
variation:setDescription([[The Exuari Ranger is a special sniper, built to deal large amounts of damage over a large area and from a distance before escaping. It's a basic frigate that carries nuclear weapons, even though it's also one of the smallest of all frigate-class ships.]])
variation:setSpeed(55, 6, 20)
variation:setTubes(1, 15.0)
variation:setTubeSize(0, "small")
variation:setWeaponStorage("Homing", 0)
variation:setWeaponStorage("Nuke", 4)

variation = template:copy("Buster")
variation:setDescription([[The Exuari Buster is a special sniper, built to deal a large amount of damage quickly and from a distance before escaping. It's a basic frigate that carries nuclear weapons, even though it's also one of the smallest of all frigate-class ships.]])
variation:setSpeed(50, 6, 20)
variation:setTubes(1, 15.0)
variation:setTubeSize(0, "large")
variation:setWeaponStorage("Nuke", 1)


--[[ Station/Transport--]]
-- The battle station is a huge ship with many defensive features. It can be docked by smaller ships.
template = ShipTemplate():setName("Ryder"):setModel("Ender Battlecruiser"):setClass("Exuari","Carrier")
template:setRadarTrace("radar_battleship.png")
template:setDescription("The Exuari 'Ryder' is a large carrier spacecraft with many defensive features. It can be docked by smaller ships to refuel or carry them. Unlike a station it is equipped with a slow impulse drive and capable of interstellar travel. It is used as a habitation for Exuari crews and has a hangar bay. A commom Exuari assault strategy is to keep a Ryder off the sensor range of the desired target, while fighters and artillery start from the carrier.")
--                  Arc, Dir, Range, CycleTime, Dmg
template:setBeam(0,  20, -90, 1200.0, 6.1, 4):setBeamWeaponTurret(0, 160, -90, 5)
template:setBeam(1,  20, -90, 1200.0, 6.0, 4):setBeamWeaponTurret(1, 160, -90, 5)
template:setBeam(2,  20,  90, 1200.0, 6.1, 4):setBeamWeaponTurret(2, 160,  90, 5)
template:setBeam(3,  20,  90, 1200.0, 6.0, 4):setBeamWeaponTurret(3, 160,  90, 5)
template:setBeam(4,  20, -90, 1200.0, 5.9, 4):setBeamWeaponTurret(4, 160, -90, 5)
template:setBeam(5,  20, -90, 1200.0, 6.2, 4):setBeamWeaponTurret(5, 160, -90, 5)
template:setBeam(6,  20,  90, 1200.0, 5.9, 4):setBeamWeaponTurret(6, 160,  90, 5)
template:setBeam(7,  20,  90, 1200.0, 6.2, 4):setBeamWeaponTurret(7, 160,  90, 5)
template:setBeam(8,  20, -90, 1200.0, 6.1, 4):setBeamWeaponTurret(8, 160, -90, 5)
template:setBeam(9,  20, -90, 1200.0, 6.0, 4):setBeamWeaponTurret(9, 160, -90, 5)
template:setBeam(10, 20,  90, 1200.0, 6.1, 4):setBeamWeaponTurret(10, 160,  90, 5)
template:setBeam(11, 20,  90, 1200.0, 6.0, 4):setBeamWeaponTurret(11, 160,  90, 5)
template:setHull(100)
template:setShields(250)
template:setSpeed(20, 1.5, 3)
template:setDockClasses("Exuari")
template:setSharesEnergyWithDocked(true)
--threat level: 12(dps)+0(tube)+12(shields)+5(hull)+0.2(speed)+0(maneuver) = 29.2 => 14.6 

variation = template:copy("Fortress")
variation:setDescription("The Exuari Fortress is a huge carrier with many defensive features. It can be docked by smaller ships to refuel or carry them. Unlike a station it is equipped with a slow impulse drive. The shields of this base carrier are sayed to be undestroyable.")
--                  Arc, Dir, Range, CycleTime, Dmg
variation:setBeam(0,  20, -90, 2400.0, 6.1, 4):setBeamWeaponTurret(0, 160, -90, 5)
variation:setBeam(1,  20, -90, 2400.0, 6.0, 4):setBeamWeaponTurret(1, 160, -90, 5)
variation:setBeam(2,  20,  90, 2400.0, 6.1, 4):setBeamWeaponTurret(2, 160,  90, 5)
variation:setBeam(3,  20,  90, 2400.0, 6.0, 4):setBeamWeaponTurret(3, 160,  90, 5)
variation:setBeam(4,  20, -90, 2400.0, 5.9, 4):setBeamWeaponTurret(4, 160, -90, 5)
variation:setBeam(5,  20, -90, 2400.0, 6.2, 4):setBeamWeaponTurret(5, 160, -90, 5)
variation:setBeam(6,  20,  90, 2400.0, 5.9, 4):setBeamWeaponTurret(6, 160,  90, 5)
variation:setBeam(7,  20,  90, 2400.0, 6.2, 4):setBeamWeaponTurret(7, 160,  90, 5)
variation:setBeam(8,  20, -90, 2400.0, 6.1, 4):setBeamWeaponTurret(8, 160, -90, 5)
variation:setBeam(9,  20, -90, 2400.0, 6.0, 4):setBeamWeaponTurret(9, 160, -90, 5)
variation:setBeam(10, 20,  90, 2400.0, 6.1, 4):setBeamWeaponTurret(10, 160,  90, 5)
variation:setBeam(11, 20,  90, 2400.0, 6.0, 4):setBeamWeaponTurret(11, 160,  90, 5)
variation:setShields(2500)
--threat level: 12(dps)+0(tube)+120(shields)+5(hull)+0.2(speed)+0(maneuver) = 137.2 => 68

