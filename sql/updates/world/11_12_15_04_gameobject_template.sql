-- Fix Rich Adamantite Deposit, now it's minable
update gameobject_template
set flags=0
where entry=181569;

--Fix not lootable gameobject for quest "In case of Emergency...=10161"
update gameobject_template
set data0=57, data1=183394
where entry=183395 or entry=183396 or entry=183397;

--Fix not lootable gameobject for quest "I work for the horde!=10086"
UPDATE gameobject_loot_template SET ChanceOrQuestChance=-100 WHERE item IN (67419, 67420);
UPDATE gameobject_template SET flags=4, data0=1690 WHERE entry IN (182936, 182938);