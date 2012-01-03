--Quest: The Cursed Crew=25817
--Fix creature_template values Cursed Marine and Cursed Sailor
UPDATE creature_template SET faction_A = 14, faction_H=14, minlevel=22, maxlevel=23, mindmg=33, maxdmg=44, attackpower=80, baseattacktime=2000, equipment_id=1591 WHERE entry=41427;
UPDATE creature_template SET faction_A = 14, faction_H=14, minlevel=22, maxlevel=23, mindmg=33, maxdmg=44, attackpower=80, baseattacktime=2000 WHERE entry=41428;



--Quest: Lifting the Curse=25818
--Add equip for npc Captain Halyndor
DELETE FROM creature_equip_template WHERE entry=41429;
INSERT INTO creature_equip_template VALUES
(41429, 3935, 5094, 0);

--Fix creature_template values Captain Halyndor
UPDATE creature_template SET faction_A = 14, faction_H=14, minlevel=22, maxlevel=23, mindmg=39, maxdmg=51, attackpower=90, baseattacktime=2000, equipment_id=41429 WHERE entry=41429;

--Add spawn creature
DELETE FROM creature WHERE id=41429;
INSERT INTO creature VALUES
(NULL, 41429, 0, 1, 1, 3494, 0, -2801.718750, -1011.846252, 4.557975, 4.907493, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0);

--Fix quest item drop
UPDATE creature_loot_template SET ChanceOrQuestChance=-100 WHERE entry=41429 AND item = 2629;

--Add gameobject Intrepid's Locked Strongbox witch ends quest
DELETE FROM gameobject WHERE id=112948;
INSERT INTO gameobject VALUES
(NULL, 112948, 0, 1, 1, -2814.084961, -984.112825, -13.23298, 4.34, 0, 0, 0, 0, 300, 100, 1);

--Added involved relation to gameobject
DELETE FROM gameobject_involvedrelation WHERE id=112948 AND quest=25818;
INSERT INTO gameobject_involvedrelation VALUES (112948, 25818); 



--Quest:The Eye of Paleth=25819
--Added quest relation
DELETE FROM gameobject_questrelation WHERE id=112948 AND quest=25819;
INSERT INTO gameobject_questrelation VALUES (112948, 25819); 

--Quest: The Third Fleet, Cursed to Roam, The Cursed Crew, Lifting the Curse, The Eye of Paleth
UPDATE quest_template SET RequiredRaces=2098253 WHERE entry BETWEEN 25815 AND 25819;



--Quest: The Ravaged Caravan=749
--Added quest involved relation
DELETE FROM gameobject_involvedrelation WHERE id=2908 AND quest=749;
INSERT INTO gameobject_involvedrelation VALUES
(2908, 749);