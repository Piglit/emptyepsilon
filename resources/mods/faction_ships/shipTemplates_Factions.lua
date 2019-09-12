--each group of models with the same style becomes mapped to one faction.

--Faction Arlenians
--Models: none yet, maybe add some fancy stations

--Faction Kraylor
--Models: battleship_destroyer_{1-5}_upgraded
--Ships: Atlantis(1), Player Cruiser(5), Player Missile Cruiser(4)
require("shipTemplates_Kraylor.lua")

--Faction Ktlitan
--Models: sci_fi_alien_ship_{1-8}
--Style: Insect like looking ships. Maybe drop the "buglike" ship, it looks more like a bug than a ship.
require("shipTemplates_Ktlitan.lua")

--Faction Exuari
--Models: small_frigate_{1-5}, dark_fighter_6, small_fighter_1, Ender Battlecruiser
require("shipTemplates_Exuari.lua")

--Faction Human/Independ./Ghosts, ...
--Models: AdlerLongRangeScout, AtlasHeavyFighter, LindwurmFighter, WespeScout, HeavyCorvette, LaserCorvette, LightCorvette, MissileCorvette, MissileCorvette, MultiGunCorvette
--Style: different colors! Perfect for human/independend ships
--Ships: Phobos(AtlasHeavyFighterRed), Hathcock(HeavyCorvetteGreen/Red), Piranha(HeavyCorvetteRed), Flavia(LightCorvetteGreyi/Red), Hornet(WespeScoutYellow), Lindworm(LindwurmFighterBlue)
require("shipTemplates_Human.lua")


--Stations
--Models: space_station_{1-4}
require("shipTemplates_Stations.lua")
--Ships: defense platform (4), odin(2)
--require("shipTemplates_Dreadnaught.lua")

--Transports
--Models: transports_{1-5}_{1-5}
require("shipTemplates_Transports.lua")
--Ships: jump carrier (4,2)

--Objects
--Models: ammo_box, shield_generator, SensorBuoyMK{I-III}, artifact{1-8}

--unsorted
--Model: space_tug
--notice that it is the same model as [TODO] without the ugly gun
--Ships: Nautilus


