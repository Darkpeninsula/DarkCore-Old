--Fix correct % drop to "Count" Ungula's Mandible
UPDATE creature_loot_template set ChanceOrQuestChance=87 WHERE item=25459;

--Fix correct % drop to Elemental Goo for quest Elemental Goo=25156
UPDATE creature_loot_template SET ChanceOrQuestChance=-41 WHERE item=52506 AND entry=43480;
UPDATE creature_loot_template SET ChanceOrQuestChance=-39 WHERE item=52506 AND entry=40229;
UPDATE creature_loot_template SET ChanceOrQuestChance=-20 WHERE item=52506 AND entry=43254;
UPDATE creature_loot_template SET ChanceOrQuestChance=-14 WHERE item=52506 AND entry=44011;
UPDATE creature_loot_template SET ChanceOrQuestChance=-14 WHERE item=52506 AND entry=43374;
UPDATE creature_loot_template SET ChanceOrQuestChance=-11 WHERE item=52506 AND entry=40464;