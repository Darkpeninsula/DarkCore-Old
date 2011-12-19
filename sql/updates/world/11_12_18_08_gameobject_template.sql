-- Fix for quest Counter-Plague Research

--Add missing gameobject template Flesh Giant Foot
DELETE FROM gameobject_template WHERE entry=205558;
INSERT INTO gameobject_template VALUES (205558, 3, 8077, 'Flesh Giant Foot', '', 'Retrieving', '', 0, 4, 1, 61366, 0, 0, 0, 0, 0, 43, 205558, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', 13329);

--Added it's loot
DELETE FROM gameobject_loot_template WHERE item=61366;
INSERT INTO gameobject_loot_template VALUES (205558, 61366, -100, 1, 0, 1, 1);

--Spawned gameobject
DELETE FROM gameobject WHERE id=205558;
INSERT INTO gameobject VALUES (NULL, 205558, 0, 1, 1, 2776.9790, -3295.3125, 96.2090, 0.36, 0, 0, 0, 0, 300, 100, 1); 



-- Fix for quest Scarlet Salvage

--Fix quest item drop for quest Scarlet Salvage (they are in Battered Chest 205879, 205878, 205881, 205880)
DELETE FROM gameobject_loot_template WHERE entry in (205879, 205878, 205881, 205880);
INSERT INTO gameobject_loot_template VALUES 
(205879, 61959, -100, 1, 0, 1, 1), 
(205878, 61960, -100, 1, 0, 1, 1), 
(205881, 61961, -100, 1, 0, 1, 1), 
(205880, 61962, -100, 1, 0, 1, 1);

--Fix data0 e data1 for 4 gameobject
UPDATE gameobject_template SET data0=57, data1=205879 WHERE entry=205879;
UPDATE gameobject_template SET data0=57, data1=205878 WHERE entry=205878;
UPDATE gameobject_template SET data0=57, data1=205881 WHERE entry=205881;
UPDATE gameobject_template SET data0=57, data1=205880 WHERE entry=205880;