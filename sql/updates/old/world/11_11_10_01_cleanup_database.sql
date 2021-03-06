UPDATE creature_template set equipment_id=0 WHERE entry IN (35451, 35490, 36597, 36823, 38579, 39166, 39167, 39168, 39217);
UPDATE creature SET spawndist=3 WHERE id=2110;
UPDATE creature SET MovementType=1 WHERE id IN(
1922, 41143, 39157, 38300, 23584, 41122, 41146, 1115, 
8544, 1420, 1142, 48205, 2734);
DELETE FROM creature_addon WHERE guid BETWEEN 91585 AND 91592 OR guid=1502011;
UPDATE creature_loot_template SET groupid=1 WHERE chanceorquestchance=0 AND entry IN (
46210, 46211, 47775, 47776, 49052, 49054, 49055, 49051, 49584, 49980, 49620, 49585, 49986, 
49621, 49904, 49905, 49898, 49899, 49585, 49585, 49584, 49898, 49584, 49621, 49620, 49986, 
49904, 49585, 49980, 49621, 49986, 49584, 49899, 49620, 49620, 49584, 49584, 49584, 49585, 
49621, 49621, 49980, 49905, 49899, 49905, 49584, 49986, 49584, 49898, 49620, 49899, 49980, 
49585, 49899, 49620, 49899, 49905, 49980, 49898, 49620, 49584, 49986, 49585, 49904, 49980, 
49980, 49986, 49986, 49980, 49986, 49584, 49980, 49980, 49980, 49905, 49621, 49621, 49620, 
50132, 50132, 50132, 50132, 50133, 50133, 50133, 50133, 50133, 50132, 50132, 50133, 50132, 
50133, 50132, 50133, 50133, 50133, 50132, 50132, 50132, 50132, 50133, 50133, 50133, 50132, 
50133, 50132, 50132, 50133, 50133, 50132, 51103, 51105, 51106, 51103, 51106, 51106, 51105, 
51106, 51102, 51106, 51106, 51105, 51102, 51106, 51102, 51106, 51103, 51102, 51102, 51103, 
51103, 51102, 51105, 51102, 51105, 51105, 51102, 51103, 51105, 51102, 51105, 51103, 51103, 
51106, 51103, 51106, 51105, 51106, 51105, 51103, 51102, 51105, 51106, 51102, 51102, 51103, 
51105, 51105, 51106, 51102, 51106, 51105, 51102, 51105, 51106, 51103, 51106, 51105, 51102, 
51103, 51103, 51103);
DELETE FROM skinning_loot_template WHERE entry IN (
27971, 27972, 31383, 31387, 33113, 33293, 33885, 
34003, 34106, 34267, 34268, 34273, 34274);
DELETE FROM creature_loot_template WHERE mincountorref IN (-26041, -35063);
DELETE FROM conditions WHERE SourceGroup=24095;
UPDATE creature_template_addon SET auras=NULL WHERE entry IN (
24178, 31237, 36823, 37094, 38579, 39137, 39189, 39217);
UPDATE creature_addon SET auras=NULL WHERE guid IN (
13423, 13424, 150211, 150211);
UPDATE creature_text SET type=0 WHERE type=12;
UPDATE creature_text SET type=1 WHERE type=14;
UPDATE creature_text SET type=2 WHERE type=16;
UPDATE creature_text SET type=3 WHERE type=41;
UPDATE creature_text SET type=4 WHERE type=15;
UPDATE creature_text SET type=5 WHERE type=42;
UPDATE script_texts SET type=0 WHERE type=12;
DELETE FROM gameobject WHERE id=500001 OR GUID=6001626;
UPDATE creature_template SET npcflag=npcflag|2 WHERE entry IN (16483, 16522);
DELETE FROM creature_involvedrelation WHERE quest=256;
UPDATE gameobject_template SET data1=0 WHERE entry IN (201710, 202212, 202336, 202337);
UPDATE quest_template set specialflags=specialflags|2 WHERE entry=10577;
DELETE FROM creature_loot_template WHERE entry IN (
46210, 46211, 47775, 47776, 49051, 49052, 49054, 49055, 
49584, 49585, 49620, 49621, 49898, 49899, 49904, 49905, 
49980, 49986, 50132, 50133, 51102, 51103, 51105, 51106);
DELETE FROM creature_addon WHERE guid=150211;
UPDATE creature SET MovementType=1 WHERE id=2110;
UPDATE creature SET spawndist=3 WHERE id IN (1142, 48205);
UPDATE quest_template SET NextQuestInChain=14923 WHERE entry=14214;
UPDATE quest_template SET ReqCreatureOrGOCount1=80 WHERE quest=14218;
UPDATE quest_template SET method=2 WHERE entry=14293;
UPDATE creature_template SET faction_A=11, faction_H=11 WHERE entry=42406;
UPDATE `creature_template` SET `ScriptName`='npc_nestlewood_owlkin' WHERE `entry`='16518';
UPDATE `creature_template` SET `Scriptname`='npc_sylvanas_hor_part1' WHERE `entry`=37223;
UPDATE `creature_template` SET `Scriptname`='npc_jaina_hor_part1' WHERE `entry`=37221;
UPDATE `creature_template` SET `spell1` = '0' WHERE `entry` IN ('8510','18176','18179');
UPDATE `creature_template` SET `npcflag` = '0' WHERE `entry` = '27593';
DELETE FROM `spell_script_names` WHERE `spell_id`=-6143 AND `ScriptName`='spell_mage_incanters_absorbtion_absorb';