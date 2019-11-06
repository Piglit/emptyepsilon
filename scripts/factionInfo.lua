neutral = FactionInfo():setName("Fraktionslos")
neutral:setGMColor(128, 128, 128)	--grey
neutral:setDescription([[Fraktionslose Schiffe sind meist Haendler oder zivile Reisende.]])

human = FactionInfo():setName("Allied")
human:setGMColor(255, 255, 255)	--white
human:setDescription([[Diese meist fraktionslosen Schiffe sind mit euch verbuendet.]])

kraylor = FactionInfo():setName("P-Rats")
kraylor:setGMColor(255, 0, 0)	--red
kraylor:setEnemy(human)
kraylor:setDescription([[Die P-Rats sind eine Zweckgemeinschaft aus raumfahrenden Banditen. Ihre Geschichte begann auf einem jener Planeten, welche zu Minenzwecken mit Raumschiffen erstbesiedelt werden mussten. Als sie dort vom DUST-Konzern zurueckgelassen wurden, schafften sie es einige Schiffe zu kapern und mit ihnen den Planeten zu verlassen. Um an das zu kommen, was ihnen zusteht, kapern und ueberfallen sie andere Schiffe und vergroessern dadurch ihre Flotte.]])

f1 = FactionInfo():setName("My.S.T")
f1:setGMColor(255, 165, 0)	--orange
f1:setDescription([[Sorgt durch ihr revolutionaeres Transportsystem dafuer das fast alles innerhalb von Sekunden durch die Galaxis geportet werden kann. Diese Technologie bietet My.S.T. den anderen Firmen, gegen bestimmte Auflagen, an.]])

f2 = FactionInfo():setName("Dust")
f2:setGMColor(255, 255, 0)	--yellow
f2:setDescription([[Ist der groesste Lieferant fuer Bodenstoffe und besonders aktiv an der Kolonialisierung beteiligt. Hier werden auch die Leistungsstaerksten Planetenfahrzeuge gebaut.]])

f3 = FactionInfo():setName("Eraz")
f3:setGMColor(0, 128, 0)	--green
f3:setDescription([[Ein Konzern welcher sich auf die Produktion von Nahrung und das Terraformen von Planeten spezialisiert hat. Um dies zu bewerkstelligen werden hier die maechtigsten Raumkreuzer gebaut.]])

f4 = FactionInfo():setName("Objekon")
f4:setGMColor(255, 0, 255)	--magenta/fuchsia
f4:setDescription([[Hat sich fuer die Produktion von extrem Hochwertigen Waffen entschieden. Als Testgebiet nutzt die Firma meist aufgegebene Planeten.]])

f5 = FactionInfo():setName("Headless")
f5:setGMColor(192, 192, 192)	--silver
f5:setDescription([[Steht fuer Qualitaet im Nanosektor und entwickelt spezielle Schutzanzuege fuer verschiedenste Einsatzorte.]])

f6 = FactionInfo():setName("NetMaxx")
f6:setGMColor(0, 0, 255)	--blue
f6:setDescription([[Unterstuetzt durch ihre Vielseitigkeit meist die untere Schicht. Sie hat ein Monopol auf den Handel und kommt durch Kontakte an so ziemlich alles was man fuer Bare Muenze kaufen kann.]])

f7 = FactionInfo():setName("Trouge")
f7:setGMColor(0, 255, 255)	--cyan/aqua
f7:setDescription([[Ist die beliebteste Firma unter der armen Bevoelkerung da sie durch ihre Shows und Aktionen vom langweiligen tristen Leben ablenken kann. Ausserdem bauten sie auch noch aus Spass Waffen die explodieren koennen.]])

black = FactionInfo():setName("Black-Ops")
black:setGMColor(0, 255, 0)	--lime
black:setDescription([[Agenten, die nicht zu ihrer Auftraggeber-Firma zugeordnet werden können.]])
black:setEnemy(human)
black:setEnemy(kraylor)
black:setEnemy(neutral)
