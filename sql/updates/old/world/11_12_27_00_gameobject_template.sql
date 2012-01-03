--Fix quest Waste Not, Want Not=10055 and cleanup of same deprecated gameobject for quest I Work... For the Horde!=10086
--Working gameobject container are Salvageable Metal=182797 and Salvageable Wood=182799
UPDATE gameobject_template SET castBarCaption='Opening', faction=0 WHERE entry IN (182797, 182799);
UPDATE gameobject_template SET questItem2=67419 WHERE entry=182797;
UPDATE gameobject_template SET questItem2=67420 WHERE entry=182799;

--Removed old container
UPDATE gameobject SET id=182797 WHERE id IN (182798, 182937, 182938);
UPDATE gameobject SET id=182799 WHERE id=182936;

--Added quest item loot for quest Waste Not, Want Not=10055
DELETE FROM gameobject_loot_template WHERE item IN (25911, 25912);
INSERT INTO gameobject_loot_template VALUES
(182797, 25912, -100, 1, 0, 1, 1),
(182799, 25911, -100, 1, 0, 1, 1);