--Quest: Winterfall Activity=28522
--Set correct drop value for quest item Winterfall Spirit Beads=21383
UPDATE creature_loot_template SET ChanceOrQuestChance=55 WHERE entry IN (7438, 7439, 7440, 7441, 7442) AND item=21383;
UPDATE creature_loot_template SET ChanceOrQuestChance=50 WHERE entry=10916 AND item=21383;
UPDATE creature_loot_template SET ChanceOrQuestChance=25 WHERE entry=10738 AND item=21383;