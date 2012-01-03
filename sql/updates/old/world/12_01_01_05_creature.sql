--Quest: Friends Come In All Colors=14130
--Added missing creature Ergll, modify its template and set RequiredRaces (horde) to quest
DELETE FROM creature WHERE id=35142;
INSERT INTO creature VALUES
(NULL, 35142, 1, 1, 1, 0, 0, 4049.041992, -7253.491699, 3.694011, 2.972338, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0);
UPDATE creature_template SET minlevel=20, maxlevel=20, mindmg=50, maxdmg=65, attackpower=55 WHERE entry=35142;
UPDATE quest_template SET RequiredRaces=946 WHERE entry=14130;