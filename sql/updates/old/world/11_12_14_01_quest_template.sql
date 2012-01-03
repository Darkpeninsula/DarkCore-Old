-- Fix faction for quest 26745 and 26323
UPDATE quest_template SET RequiredRaces=2098253 WHERE entry=26745;
UPDATE quest_template SET RequiredRaces=946 WHERE entry=26323;