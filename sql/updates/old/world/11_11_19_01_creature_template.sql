-- Cleanup some spawns
DELETE FROM creature where guid IN (322816, 294962);

-- Set Tina Skyden's proper faction 
UPDATE creature_template SET faction_A=72, faction_H=72 WHERE entry=42426;

-- Fix many erroneus flight-masters' factions
UPDATE creature_template SET faction_A=210, faction_H=210 WHERE npcflag = (npcflag|8192) AND faction_a=72;

-- Cleanup some spawns
DELETE FROM creature where guid IN (322816, 294962);

-- Set Tina Skyden's proper faction 
UPDATE creature_template SET faction_A=72, faction_H=72 WHERE entry=42426;

-- Fix many erroneus flight-masters' factions
UPDATE creature_template SET faction_A=210, faction_H=210 WHERE npcflag = (npcflag|8192) AND faction_a=72;

-- Update High General Abbendis faction
UPDATE creature_template SET faction_A=66, faction_H=66 WHERE entry=29077;

-- Update "Tainted Arcane Wraith" for quest "Felendren the Banished"
UPDATE creature_template SET faction_A=14, faction_H=14 WHERE entry=15298;

-- Delete custom stuff from Landro: no more unoffy sells will be accomplished
UPDATE creature_template SET npcflag=1 WHERE entry=17249;
DELETE FROM npc_vendor WHERE entry=17249;

-- Fix Shazdar's items extended cost
DELETE FROM npc_vendor WHERE entry=49737;
INSERT INTO npc_vendor VALUES
(49737, 0, 62786, 0, 0, 0),
(49737, 0, 62787, 0, 0, 0),
(49737, 0, 62788, 0, 0, 0),
(49737, 0, 65406, 0, 0, 3322),
(49737, 0, 65407, 0, 0, 3322),
(49737, 0, 65408, 0, 0, 3322),
(49737, 0, 65409, 0, 0, 3322),
(49737, 0, 65410, 0, 0, 3322),
(49737, 0, 65411, 0, 0, 3322),
(49737, 0, 65412, 0, 0, 3322),
(49737, 0, 65413, 0, 0, 3322),
(49737, 0, 65414, 0, 0, 3322),
(49737, 0, 65415, 0, 0, 3322),
(49737, 0, 65416, 0, 0, 3322),
(49737, 0, 65417, 0, 0, 3322),
(49737, 0, 65418, 0, 0, 3322),
(49737, 0, 65419, 0, 0, 3322),
(49737, 0, 65420, 0, 0, 3322),
(49737, 0, 65421, 0, 0, 3322),
(49737, 0, 65422, 0, 0, 3322),
(49737, 0, 65423, 0, 0, 3322),
(49737, 0, 65424, 0, 0, 3322),
(49737, 0, 65425, 0, 0, 3322),
(49737, 0, 65426, 0, 0, 3322),
(49737, 0, 65427, 0, 0, 3322),
(49737, 0, 65428, 0, 0, 3322),
(49737, 0, 65429, 0, 0, 3322),
(49737, 0, 65430, 0, 0, 3322),
(49737, 0, 65431, 0, 0, 3322),
(49737, 0, 65432, 0, 0, 3023),
(49737, 0, 65433, 0, 0, 3023),
(49737, 0, 65513, 0, 0, 3024);

-- Update Rejuvenation training cost by Gart Mistrunner
UPDATE npc_trainer SET spellcost=60 WHERE spell=774 AND entry=3060;

-- Fix "Eitrigg" and templates and add their spawn locations
UPDATE creature_template SET minlevel=85, maxlevel=85, faction_A=76, faction_H=76 WHERE entry=48568;
UPDATE creature_template SET faction_A=189, faction_H=189, minlevel=85, maxlevel=85 WHERE entry=48109;
DELETE FROM creature WHERE id IN (48568, 48109);
INSERT INTO creature (id, map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, 
orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, DeathState, MovementType, 
npcflag, unit_flags, dynamicflags) VALUES
(48568, 0, 1, 1, 0, 0, -7917.25, -1868.87, 132.498, 3.98464, 300, 0, 0, 840, 0, 0, 0, 0, 0, 0),
(48109, 0, 1, 65534, 0, 0, -7947.22, -1927.15, 132.241, 0.45032, 300, 0, 0, 84, 0, 0, 0, 0, 0, 0);