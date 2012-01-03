--Added quest-item's loot for quest Arelion's Journal=9374
INSERT INTO item_loot_template (`entry`,`item`,`ChanceOrQuestChance`,`lootmode`,`groupid`,`mincountOrRef`,`maxcount`) VALUES
(31955, 23339, 100, 1, 1, 1, 1);

-- Thema89 appended fix begins --
-- Add Flame-Scarred Junkbox loot
DELETE FROM item_loot_template WHERE entry=63349;
INSERT INTO item_loot_template (entry, item, ChanceOrQuestChance) VALUES
(63349, 63300, 20),
(63349, 67348,2),
(63349, 62323,2),
(63349, 68047,2),
(63349, 67319,2),
(63349, 67335,2),
-- insert 3/3 very rare Cataclysm drops
(63349, 68161,0.1), -- Krol Decapitator
(63349, 68162,0.1), -- Spinerender
(63349, 68163,0.1); -- The Twilight Blade
-- Thema89 appended fix ends --