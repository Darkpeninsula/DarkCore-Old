--Add missing gameobject Narkk's Handbombs for quest Prepare for Takeoff
DELETE FROM gameobject WHERE id=204587;
INSERT INTO gameobject VALUES (NULL, 204587, 0, 1, 1, -14335.443359, 429.261047, 6.626423, 4.41, 0, 0, 0, 0, 300, 100, 1);

--Fix bug gameobject 201738, now it's like Budding Flower 201737
UPDATE gameobject SET id=201737 WHERE id=201738;