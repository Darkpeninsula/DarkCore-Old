--All fix are for quest Survival of the Fattest
--Replaced old container with current Dustbelcher Meat=206420
UPDATE gameobject SET id=206420 WHERE id=206498;

--Double position gameobject, removed one
DELETE FROM gameobject WHERE guid=184731;

--Insert creature loot quest item to npc Dustbelcher Butcher
DELETE FROM creature_loot_template WHERE entry=46928 AND item=62544;
INSERT INTO creature_loot_template VALUES (46928, 62544, -1, 1, 0, 1, 1);

--Fix required race for quest horde and alliance
UPDATE quest_template SET RequiredRaces=946 WHERE entry=27879;
UPDATE quest_template SET RequiredRaces=2098253 WHERE entry=27825;