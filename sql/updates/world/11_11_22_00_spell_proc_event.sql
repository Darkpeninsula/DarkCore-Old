-- Fix Finger of Frost
DELETE FROM `spell_proc_event` WHERE `entry` = '74396';
INSERT INTO `spell_proc_event` VALUES (74396, 84, 3, 685904631, 1151048, 0, 65536, 3, 0, 0, 0);