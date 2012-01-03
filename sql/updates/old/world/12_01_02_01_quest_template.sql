-- Quest: Turn It Off! Turn It Off!=28335 (horde) and Oil and Irony=28385 (alliance)
-- Added required races
UPDATE quest_template SET RequiredRaces=946 WHERE entry=28335;
UPDATE quest_template SET RequiredRaces=2098253 WHERE entry=28385;

-- Added missing involvedrelation
DELETE FROM gameobject_involvedrelation WHERE id=207104;
INSERT INTO gameobject_involvedrelation VALUES
(207104, 28335),
(207104, 28385);

-- Added missing gameobject_template Master Control Pump
DELETE FROM gameobject_template WHERE entry=207104;
INSERT INTO gameobject_template VALUES
(207104, 2, 9877, 'Master Control Pump', '', '', '', 35, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', 13329);

-- Spawned Master Control Pump
DELETE FROM gameobject WHERE id=207104;
INSERT INTO gameobject VALUES
(NULL, 207104, 1, 1, 1, 6331.974121, -1870.405273, 433.178009, 0.684012, 0, 0, 0, 0, 300, 100, 1);



-- Quest: Fire in the Hole!=28368
-- Added required races
UPDATE quest_template SET RequiredRaces=946 WHERE entry=28368;

-- Added missing questrelation
DELETE FROM gameobject_questrelation WHERE id=207104;
INSERT INTO gameobject_questrelation VALUES
(207104, 28368);

-- Fixed values for npc Grolvitar the Everburning
UPDATE creature_template SET faction_A=14, faction_H=14, minlevel=49, maxlevel=49, mindmg=105, maxdmg=125, attackpower=250, baseattacktime=2000, mingold=200, maxgold=800, AIName='SmartAI' WHERE entry=48352;

-- Spawned Grolvitar the Everburning
DELETE FROM creature WHERE id=48352;
INSERT INTO creature VALUES
(NULL, 48352, 1, 1, 1, 0, 0, 6339.691895, -1567.596191, 445.389496, 1.305259, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0);

-- Add smart_scripts to Grolvitar the Everburning
DELETE FROM smart_scripts WHERE entryorguid=48352 AND source_type=0;
INSERT INTO smart_scripts VALUES
(48352, 0, 0, 0, 0, 0, 100, 0, 1000, 2000, 15000, 20000, 11, 13729, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Flame Shock'),
(48352, 0, 1, 0, 0, 0, 100, 0, 5000, 6000, 15000, 20000, 11, 75024, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Cast Rush of Flame'),
(48352, 0, 2, 0, 9, 0, 100, 0, 15, 20, 15000, 20000, 11, 75025, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Cast Rush of Flame');



-- Quest: The Timbermaw Tribe=28373 (horde) and 28392 (alliance)
-- Added required races
UPDATE quest_template SET RequiredRaces=946 WHERE entry=28373;
UPDATE quest_template SET RequiredRaces=2098253 WHERE entry=28392;



-- Quest: Deadwood of the North=28338
-- Added killcredit to npc Deadwood Avenger and Deadwood Shaman
UPDATE creature_template SET KillCredit1=7156 WHERE entry IN (7157, 7158);



--Quest: Feathers for Grazle=28396 and Feathers for Nafien=28395
-- Set repetible
UPDATE quest_template SET SpecialFlags=1 WHERE entry=28395 OR entry=28396;
--Set drop Deadwood Headdress Feather to correct %
UPDATE creature_loot_template SET ChanceOrQuestChance=50 WHERE entry IN (9464, 7156, 7157, 7158) AND item=21377;
UPDATE creature_loot_template SET ChanceOrQuestChance=25 WHERE entry IN (9462, 7153, 7154, 7155) AND item=21377;
UPDATE creature_loot_template SET ChanceOrQuestChance=10 WHERE entry = 14342 AND item=21377;
