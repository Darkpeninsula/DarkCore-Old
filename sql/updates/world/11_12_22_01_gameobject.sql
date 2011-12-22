--Add missing spawn gameobject Scarlet Onslaught Daily Orders: Beach for quest Need to Know=12234
DELETE FROM gameobject WHERE id=188677;
INSERT INTO gameobject VALUES
(NULL, 188677, 571, 1, 1, 2567.591553, -388.749908, 3.593398, 5.759122, 0, 0, 0, 1, 3600, 100, 1);

--Add missing loot to gameobject Scarlet Onslaught Daily Orders: Beach
DELETE FROM gameobject_loot_template WHERE entry=188677 AND item=37269;
INSERT INTO gameobject_loot_template VALUES
(188677, 37269, -100, 1, 0, 1, 1);


--Removed Emerald Dragon Tear for quest Emerald Dragon Tear=12200
UPDATE gameobject SET id=188646 WHERE id=188650;