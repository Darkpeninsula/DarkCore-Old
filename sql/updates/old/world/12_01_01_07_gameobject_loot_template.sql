--Quest: Shizz Work=10629
--Added missing loot
DELETE FROM gameobject_loot_template WHERE entry=184980;
INSERT INTO gameobject_loot_template VALUES
(184980, 30794, -20, 1, 0, 1, 1),
(184980, 5369, 56, 1, 0, 1, 1),
(184980, 6456, 45, 1, 0, 1, 1);