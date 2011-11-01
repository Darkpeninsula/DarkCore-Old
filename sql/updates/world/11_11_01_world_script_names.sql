DELETE FROM `spell_script_names` WHERE `spell_id` IN ('50524','67533','50053','70701','56641','1120','80398','79513');
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(50524,'spell_dk_runic_power_feed'),
(67533,'spell_item_red_rider_air_rifle'),
(50053,'spell_varos_centrifuge_shield'),
(70701,'spell_putricide_expunged_gas'),
(56641,'spell_hun_steady_shot'),
(1120, 'spell_warl_drain_soul'),
(80398,'spell_warlock_dark_intent'),
(79513,'item_tiki_torch');

DELETE FROM `areatrigger_scripts` WHERE `entry` IN (5369,5423);
INSERT INTO `areatrigger_scripts` (`entry`,`ScriptName`) VALUES
(5369, 'at_RX_214_repair_o_matic_station'),
(5423, 'at_RX_214_repair_o_matic_station');

UPDATE `creature_template` SET `ScriptName` = 'npc_lord_darius_crowley' WHERE `entry` = '35077';
UPDATE `creature_template` SET `ScriptName` = 'npc_josiah_avery' WHERE `entry` = '35369';
UPDATE `creature_template` SET `ScriptName` = 'npc_eye_of_acherus' WHERE `entry` = '28511';
UPDATE `creature_template` SET `ScriptName` = 'npc_prospector_anvilward' WHERE `entry` = '15420';
UPDATE `creature_template` SET `ScriptName`='mob_shattered_rumbler' WHERE `entry`=17157;
UPDATE `creature_template` SET `ScriptName`='mob_lump' WHERE `entry`=18351;
UPDATE `creature_template` SET `ScriptName`='npc_altruis_the_sufferer' WHERE `entry`=18417;
UPDATE `creature_template` SET `ScriptName`='npc_lantresor_of_the_blade' WHERE `entry`=18261;
UPDATE `creature_template` SET `ScriptName`='mob_sparrowhawk' WHERE `entry`=22979;
UPDATE `creature_template` SET `ScriptName`='npc_azure_ring_captain' WHERE `entry`=27638;
UPDATE `creature_template` SET `ScriptName`='npc_jungle_punch_target' WHERE `entry` IN(27986,28047,28568);
UPDATE `creature_template` SET `ScriptName`='npc_brunnhildar_prisoner' WHERE `entry`=29639;