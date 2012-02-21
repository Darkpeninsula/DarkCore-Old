DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 17 AND `SourceEntry` = 86425;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 86425, 0, 19, 46393, 0, 0, 0, '', 'Billy Goat Blast');


DELETE FROM `spell_bonus_data` WHERE `entry` = 1978;

DELETE FROM `spell_proc_event` WHERE `entry` IN (87934,87935);
INSERT INTO `spell_proc_event` (`entry`, `SchoolMask`, `SpellFamilyName`, `SpellFamilyMask0`, `SpellFamilyMask1`, `SpellFamilyMask2`, `procFlags`, `procEx`, `ppmRate`, `CustomChance`, `Cooldown`) VALUES
(87934, 0, 0, 4096, 0, 0, 0, 0, 0, 0, 0),
(87935, 0, 0, 4096, 0, 0, 0, 0, 0, 0, 0);
