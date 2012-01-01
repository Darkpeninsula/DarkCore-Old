--Quest: Impending Attack=9822
--Fixed field data0 to gameobject Ango'rosh Attack Plans
UPDATE gameobject_template SET data0=43 WHERE entry=182166;
--Set correct loot chance
UPDATE gameobject_loot_template SET ChanceOrQuestChance=-100 WHERE entry=182166;



--Quest: A Thousand Stories in the Sand=14201
--Changed data0 value
UPDATE gameobject_template SET data0=57 WHERE entry=195455;