-- Plate Specialization
DELETE FROM `spell_learn_spell` WHERE `entry` IN('87509','87510','87511');
INSERT INTO `spell_learn_spell` VALUES (87509, 86526, 1);
INSERT INTO `spell_learn_spell` VALUES (87510, 86524, 1);
INSERT INTO `spell_learn_spell` VALUES (87511, 86525, 1);