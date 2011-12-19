-- Fix Battered Chest

--Added loot_item to 4 gameobject named Battered Chest 2843, 2849, 106318, 106319
DELETE FROM gameobject_loot_template WHERE entry in (2843, 2849, 106318, 106319);
INSERT INTO gameobject_loot_template VALUES 
(2843, 1179, 5, 1, 0, 1, 6),
(2843, 118, 5, 1, 0, 1, 7),
(2843, 858, 5, 1, 0, 1, 8),
(2843, 2318, 5, 1, 0, 1, 8),
(2843, 2455, 5, 1, 0, 1, 8),
(2843, 414, 2, 1, 0, 1, 6),
(2843, 2287, 2, 1, 0, 1, 4),
(2843, 4605, 2, 1, 0, 1, 6),
(2843, 4537, 2, 1, 0, 1, 5),
(2843, 4541, 2, 1, 0, 1, 5),
(2843, 2842, 2, 1, 0, 1, 4),
(2843, 2835, 2, 1, 0, 1, 8),
(2843, 2770, 2, 1, 0, 1, 6),
(2843, 2996, 2, 1, 0, 1, 6),
(2843, 2070, 1, 1, 0, 1, 5),
(2843, 2449, 1, 1, 0, 1, 8),
(2843, 4604, 1, 1, 0, 1, 4),
(2843, 2447, 1, 1, 0, 1, 7),
(2843, 4536, 1, 1, 0, 1, 4),
(2843, 765, 1, 1, 0, 1, 8),
(2843, 4540, 1, 1, 0, 1, 4),
(2843, 2450, 1, 1, 0, 1, 6),
(2843, 774, 1, 1, 0, 1, 2),
(2843, 818, 1, 1, 0, 1, 1),
(2843, 785, 1, 1, 0, 1, 4),
(2843, 783, 1, 1, 0, 1, 2),
(2843, 3577, 1, 1, 0, 1, 2);

--Set drop item entry data1 for Battered Chest 2843, 2849, 106318, 106319
UPDATE gameobject_template SET castBarCaption='Opening', data0=57, data1=2843 WHERE entry IN (2843, 2849, 106318, 106319);

--Replaced old gameobject (prev/next patch?) with Battered Chest=2843
UPDATE gameobject SET id=2843 WHERE id IN (2849, 106318, 106319);


--TODO: Add more spawn for Battered Chest in table gameobject
