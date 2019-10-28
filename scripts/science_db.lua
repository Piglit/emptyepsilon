--[[
	Everything in the science database files is just readable data for the science officer.
	This data does not affect the game in any other way and just contributes to the lore.
--]]
space_objects = ScienceDatabase():setName('Natural')
item = space_objects:addEntry('Asteroid')
item:setLongDescription([[Asteroids are minor planets, usually smaller than a few kilometers. Larger variants are sometimes refered to as planetoids.]])

item = space_objects:addEntry('Nebula')
item:setLongDescription([[Nebulae are the birthing places of new stars. These gas fields, usually created by the death of an old star, slowly form new stars due to the gravitational pull of its gas molecules. Because of the ever-changing nature of gas nebulae, most radar and scanning technologies are unable to penetrate them. Science officers are therefore advised to rely on probes and visual observations.]])

item = space_objects:addEntry('Black hole')
item:setLongDescription([[A black hole is a point of supercondensed mass with a gravitational pull so powerful that not even light can escape it. It has no locally detectable features, and can only be seen indirectly by blocking the view and distorting its surroundings, creating a strange circular mirror image of the galaxy. The black disc in the middle marks the event horizon, the boundary where even light can't escape it anymore. 
	
On the sensors, a black hole appears as a disc indicating the zone where the gravitational pull is getting dangerous, and soon will be stronger then the ship's impulse engines. An object that crosses a black hole is drawn toward its center and quickly ripped apart by the gravitational forces.]])

item = space_objects:addEntry('Wormhole')
item:setLongDescription([[A wormhole, also known as an Einstein-Rosen bridge, is a phenomena that connects two points of spacetime. Jump drives operate in a similar fashion, but instead of being created at will, a wormhole occupies a specific location in space. Objects that enter a wormhole instantaneously emerge from the other end, which might be anywhere from a few feet to thousands of light years away. 

Wormholes are rare, and most can move objects in only one direction. Traversable wormholes, which are stable and allow for movement in both directions, are even rarer. All wormholes generate tremendous sensor activity, which an astute science officer can detect even through disruptions such as nebulae.]])

weapons = ScienceDatabase():setName('Weapons')
item = weapons:addEntry('Homing missile')
item:addKeyValue('Range', '5.4u')
item:addKeyValue('Damage', '35')
item:setLongDescription([[This target-seeking missile is the workhorse of many space combat arsenals. It's compact enough to be fitted on frigates, and packs enough punch to be used on larger ships, though usually in more than a single missile tube.]])

item = weapons:addEntry('Nuke')
item:addKeyValue('Range', '5.4u')
item:addKeyValue('Blast radius', '1u')
item:addKeyValue('Damage at center', '160')
item:addKeyValue('Damage at edge', '30')
item:setLongDescription([[A nuclear missile is similar to a homing missile in that it can seek a target, but it moves and turns more slowly and explodes a greatly increased payload. Its nuclear explosion spans 1U of space and can take out multiple ships in a single shot.

Some captains oppose the use of nuclear weapons because their large explosions can lead to 'fragging', or unintentional friendly fire. Shields should protect crews from harmful radiation, but because these weapons are often used in the thick of battle, there's no way of knowing if hull plating or shields can provide enough protection.]])

item = weapons:addEntry('Mine')
item:addKeyValue('Drop distance', '1.2u')
item:addKeyValue('Trigger distance', '0.6u')
item:addKeyValue('Blast radius', '1u')
item:addKeyValue('Damage at center', '160')
item:addKeyValue('Damage at edge', '30')
item:setLongDescription([[Mines are often placed in defensive perimeters around stations. There are also old minefields scattered around the galaxy from older wars.

Some fearless captains use mines as offensive weapons, but their delayed detonation and blast radius make this use risky at best.]])

item = weapons:addEntry('EMP')
item:addKeyValue('Range', '5.4u')
item:addKeyValue('Blast radius', '1u')
item:addKeyValue('Damage at center', '160')
item:addKeyValue('Damage at edge', '30')
item:setLongDescription([[The electromagnetic pulse missile (EMP) reproduces the disruptive effects of a nuclear explosion, but without the destructive properties. This causes it to only affect shields within its blast radius, leaving their hulls intact. The EMP missile is also smaller and easier to store than heavy nukes. Many captains (and pirates) prefer EMPs over nukes for these reasons, and use them to knock out targets' shields before closing to disable them with focused beam fire.]])

item = weapons:addEntry('HVLI')
item:addKeyValue('Range', '5.4u')
item:addKeyValue('Damage', '7 each, 35 total')
item:addKeyValue('Burst', '5')
item:setLongDescription([[A high-velocity lead impactor (HVLI) fires a simple slug of lead at a high velocity. This weapon is usually found in simpler ships since it does not require guidance computers. This also means its projectiles fly in a straight line from its tube and can't pursue a target.

Each shot from an HVLI fires a burst of 5 projectiles, which increases the chance to hit but requires precision aiming to be effective.]])

sc_info = ScienceDatabase():setName('Planeten')
item = sc_info:addEntry("Planet cX58008")
item:setLongDescription([[Bei der ersten Erkundung des Planeten wurden folgende Daten erfasst:
Raumstationen: Hier werden Raumschiffe hergestellt und sie deinen auch als Zwischenstopp fuer verschiedene Reisende. Meist sind diese Raumstationen im Orbit eines Planeten oder aber als Repeater fuer das My.S.T. Signal im All positioniert.
Bevoelkerung:
Diese lebt hauptsaechlich nah der Armutsgrenze und kann ihr mickriges Gehalt nur durch gefaehrliche Tageloehner einsetze fuer die Firmen aufbessern. Auch sind diese Einsaetze die einzige Moeglichkeit sich in eine My.S.T. Station einlesen zu lassen und somit seine Lebensqualitaet zu verbessern. Weiter erhaelt man auf solchen Missionen auch sicher eine Datacard auf welcher alle relevanten Informationen der Person gespeichert sind und welche eine freiere Reisemoeglichkeit durch die Galaxie ermoeglicht.
Banditen:
Als Arbeiter welche von einer Firma auf einem nicht mehr rentablen Planeten zurueck gelassen wurden, schliessen sich diese meist zu verschiedenen Banditenclans zusammen und machen die Galaxie unsicher. Sie koennen jedoch wenn sie an einer My.S.T. Station registriert sind und sterben direkt auf einen Gefaengnisplaneten geportet werden. Da solche Banditengruppen haeufig den Firmen nichts als Ärger einbringen, werden auch Kopfgelder auf bestimmte Personen einzelner Gruppen ausgesetzt.]])
item = sc_info:addEntry("Maros")
item:setLongDescription([[
Niederschwerkraft Terraformingplanet des Eras-Konzerns. Wird als Agrar-Planet verwendet, mit Maisplantagen, die wegen der geringeren Schwerkraft und Dank Gen-Optimierung bis zu 8 Meter in den Himmel ragen. Nahezu das gesamte Asos-System wird durch Maros' Produktion mit Nahrung versorgt. Seit Generationen leben dort die Arbeiter-Familien, die die grossen Maschinen warten. Typen von Maros sind die, die alles fahren oder fliegen koennen, was ein Steuermodul hat. Ausserdem sind sie von etwas rauerem, einfacherem Gemuet – und natuerlich ist ihr verschrobener Aberglaube fester Bestandteil des Alltags. Jemand von Maros kennt eigentlich nur einen Grund, sich auf eine solche Mission einzulassen: Nix wie weg von Zuhausae!
]])
item = sc_info:addEntry("Kylissa-Da an")
item:setLongDescription([[
Zentralplanet mit Metropolen-Attituede. Kylissa-Da'an ist ein Hauptstadtplanet, welcher ueberwiegend urban bebaut ist und ueber keine Landwirtschaft o.ae. verfuegt. Auf den drei kuenstlich angelegten Monden wird die Versorgung durch Lebensmittel sichergestellt. Die prozentual geringe Unterschicht des aristokratischen Kylissa-Da'an wird mit MY.S.T.-Transferstationen auf die Monde projiziert, wo sie als Arbeiter jedweder Art funktionieren. Doch auch hier koennen die Arbeitsplaetze ausgehen. Was dann bleibt ist, intra-galaktisch auf Arbeitssuche zu gehen... Bewohner dieses Planeten zeichnen sich meist durch eine hohe Intelligenz und computertechnisches Verstaendnis, weniger durch Sportlichkeit und Hilfsbereitschaft aus. Sie kommen oft besser bekleidet und genaehrt sowie mit etwas mehr Geld bei der Arbeit an. Ihre Intelligenz laesst sie meist schnell den Umgang mit allen Maschinen meistern. Ausserdem sind sie ehrgeizig.
]])
item = sc_info:addEntry("Bagelos CX4")
item:setLongDescription([[
Bagelos CX4 ist ein Kleinstplanet, oder auch Mond, im Bagelos-System des Gasriesen Bagelos CX3, welcher in einem durchschnittlich-langweiligen Sonnensystem der Zwergsonne Bagelos liegt. Nach erfolgreichem terraforming durch den Eraz-Konzern wurde daraus ein vielversprechender Heimatort. Aufgrund seiner Abgelegenheit, seiner geringen Groesse und anderer, „dringender“Interessen von Eraz verkam Bagelos CX4 zu einem Dschungelmond, welcher von einer kleinen Flotte Hippies entdeckt und fuer sich in Anspruch genommen wurde.Angefuehrt von ihrem Guru, einem urspruenglich sehr angesehenen Doktor der Medizin, gruendeten sie dort eine grosse Kommune der inneren Balance und Ausgeglichenheit, freien Liebe und Naturverbundenheit und so weiter und so weiter, halluzinogene Dschungelpilze. Nichtsdestoweniger blieb die Heilkunst eine hohe Tugend auf Bagelos CX4 und jenem verschrobenem Guru und Doktor ist auch die Entwicklung der Harzgewebe-Dermafungische- Symbiontenhyphen-Verbundstoff-Regenerations-Mullbinden (vom Doktor „Pilzische Heilschmeichler Baumumarmung“, vom Rest der Galaxis schlicht „Medis“ oder „Medi-Packs“genannt) zu verdanken.
]])
item = sc_info:addEntry("Ur-Erde")
item:setLongDescription([[
Hier herrscht pure Anarchie. Die Natur erobert seit Jahren wieder Landstriche und Lebensraum der Menschen zurueck und schafft das mit darwinistischer Praezision, was dem Wort „Naturgewalt“ eine vollkommen neue Bedeutung verleiht. Die verbliebenen Menschen kaempfen taeglich um ihr Überleben und versuchen mit allen Mitteln in die wenigen von der Headless-Korporation kontrollierten Sicherheitsbereiche oder die noch selteneren Haefen zu kommen, um in „Ruhe leben“ oder wahrscheinlicher den Planeten verlassen zu koennen. Menschen vom Urplaneten sind zaeh und widerstandsfaehig, sie nehmen bereitwillig alle Arbeit an und wenn sie mal bei Headless gearbeitet haben, agieren und handeln sie genauso praezise wie der Konzern. Weiter sind sie niemals unbewaffnet, da selbst in den sicheren Gebieten niemals wirklicher Schutz, Sicherheit oder gar Geborgenheit zu erwarten waere. Man geht davon aus, dass Headless seine Mitarbeiter genetisch modifiziert, um seine hohen Praezisions- und Werkstandards aufrecht zu erhalten.
]])
item = sc_info:addEntry("Testos 13R0N")
item:setLongDescription([[
Planet Testos 13R0N ist ein masseschwerer Wuestenplanet im Testos-System, mit dem roten Riesen Testos als Zentrum. Testos 13R0N hat in den letzten Jahrzenten mit aller Kraft die Umruestung auf MY.S.T.-Systeme gesetzt, da das Ende von Testos nur noch die Frage einer kurzen Zeit ist und der Grossteil der zahlungsfaehigen Bevoelkerung sich bereits auf mobilen Raumstationen evakuiert hat. Die verbliebenen Menschen suchen Zu- und Ausflucht in ihren MY.S.T.-Projektionen, mit denen sie Arbeit finden und ihre trostlose Existenz aus der roten Wueste bringen koennen. Dementsprechend sind Leute von Testos 13R0N sehr draufgaengerisch, teilweise mit Leichtsinn der an Lebensmuedigkeit reicht, manchmal sowohl todes- als auch lebensverachtend – was als herausstellendes Merkmal in Zeiten des MY.S.T. keine Kleinigkeit ist!
]])
item = sc_info:addEntry("???#+*#*##???")
item:setLongDescription([[
Hier sind alle Ausserirdischen Lebensformen vertreten. Sie koennen von den exotischsten Planeten stammen und haben die unterschiedlichsten Koerperbauten. Klauen, Atem-Masken und Anzuege, Kaeferpanzer, Fell, glaenzende Schuppen oder alles gemischt...
]])
item = sc_info:addEntry("Ehzolok")
item:setLongDescription([[
Der grosse Mond Ehzolok kreist um den Gasriesen Log'goz und befindet sich im Zyron-System. Da er fuer Menschen mehr als unbewohnbar ist, haben sich hier Cyborgs und Androiden angesiedelt und feiern dort ihre Unabhaengigkeit. Die meiste Energie gewinnen sie durch die gezeitenbedingte Tektonik des Mondes, weniger durch Sonnenenergie. Warum MY.S.T. diese Wesen, die mehr Maschine und Computer sind als etwas menschliches, in die MY.S.T.-Reproduktion aufgenommen hat, weiss bis heute niemand. Erkennen kann man sie sicher daran, dass sie Roboterapplikationen an sich haben, sei es ein Roboterarm, oder -bein, blinkende Augen oder andere Platinen am Kopf... Ausserdem sind sie absolut gefuehlskalt und rational (es sei denn sie wurden irgendwann darauf programmiert Gefuehle zu zeigen – doch wie fehlerfrei?) und wenn sie Humor haben, dann offensichtlich welchen, den nur andere Androiden verstehen.
]])

allg_info = ScienceDatabase():setName('Technologie')
item = allg_info:addEntry("Myst-System")
item:setLongDescription([[Dieses System ist das Galaxis weite Transportsystem fuer kleine bis Mittelgrosse Gegenstaende. Hier koennen Personen, Materialkisten, kleine Geraetschaften, etc. gegen eine bestimmte Bezahlung transportiert werden. Alles was groesser ist muss jedoch mit Raumschiffen zu den jeweiligen Orten gebracht werden. Durch ihren Hochtechnischen Aufbau kann es jedoch auch jederzeit zu Fehlern kommen und schon der Verlust des kleinsten Teiles macht die meisten My.S.T. Stationen nicht mehr transportfaehig.  Neben dem Transport kann man jedoch auch durch einen Datenguertel sich selbst an eine Station binden und kann beim Todesfall mit allen eingelesenen Geraeten an eben dieser Station wieder hergestellt werden. Dies kostet natuerlich auch einen gewissen Betrag und ist nicht gaenzlich vor Fehlern gefeit.]])
