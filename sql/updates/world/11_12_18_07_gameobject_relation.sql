--Add start quest Message in bottle=26603 from gameobject Half-Buried Bottle=204406
DELETE FROM gameobject_questrelation WHERE id=204406 AND quest=26603;
INSERT INTO gameobject_questrelation VALUES (204406, 26603);

-- Wooden Outhouse now accept completed quest Caught!=4449
DELETE FROM gameobject_involvedrelation WHERE id=173265 AND quest=4449;
INSERT INTO gameobject_involvedrelation VALUES (173265, 4449);

--Removed old deprecated quest: A Sign of Hope=720, Murdaloc=739
DELETE FROM gameobject_questrelation WHERE id=2868 AND quest=720;
DELETE FROM gameobject_questrelation WHERE id=2875 AND quest=739;