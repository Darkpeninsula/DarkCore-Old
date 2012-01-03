--Killing Greater Lava Spider now counts for The Spiders Have to Go=27980
UPDATE creature_template SET KillCredit1=5857 WHERE entry=5858;



--Quest: Blood Tour=28446
--Killing Black Wyrmkin now counts as objective
UPDATE creature_template SET KillCredit1=7040 WHERE entry=7041;

--Fixed RequiredRaces
UPDATE quest_template SET RequiredRaces=946 WHERE entry=28446;
UPDATE quest_template SET RequiredRaces=2098253 WHERE entry=28314;