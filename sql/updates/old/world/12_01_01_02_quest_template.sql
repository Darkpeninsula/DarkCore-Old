--Quest: Speaking with Nezzliok=26301
--Fixed questflag
UPDATE quest_template SET QuestFlags=262152 WHERE entry=26301;

--Removed obsolete quest
DELETE FROM gameobject_questrelation WHERE quest=585;



--Quest: The Mind's Eye=26303 (horde) and 26781 (alliance)
--Added missing npc
DELETE FROM creature WHERE id=818;
INSERT INTO creature VALUES (NULL, 818, 0, 1, 1, 0, 0, -12346.207031, -1153.365234, 1.220142, 2.156448, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0);

--Fixed RequiredRaces of chain quest wich starts with Speaking with Nezzliok=26301
UPDATE quest_template SET RequiredRaces=946 WHERE entry IN (26301, 26302, 26303, 26305);
UPDATE quest_template SET RequiredRaces=2098253 WHERE entry=26781;
