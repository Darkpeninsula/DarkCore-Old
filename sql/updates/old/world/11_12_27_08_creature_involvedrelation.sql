--Quest: The Owls Have It=28638
--Set questflags to correct value
UPDATE quest_template SET QuestFlags="262152" WHERE entry=28638;

--Added involvedrelation
DELETE FROM `creature_involvedrelation` WHERE id=49537 AND quest=28638;
INSERT INTO `creature_involvedrelation` VALUES (49537, 28638);



--Quest: Screechy Keen=28745
--Removed wrong questrelation
DELETE FROM `creature_questrelation` WHERE id=7456 AND quest=28745;

--Added correct questrelation
DELETE FROM `creature_questrelation` WHERE id=49537 AND quest=28745;
INSERT INTO `creature_questrelation` VALUES (49537, 28745);

--Added correct involevedrelation
DELETE FROM `creature_involvedrelation` WHERE id=49537 AND quest=28745;
INSERT INTO `creature_involvedrelation` VALUES (49537, 28745);

--Fix npcflag for Winterspring Screecher=7456
UPDATE `creature_template` SET npcflag=0 WHERE entry=7456;

--Changed questflags (removed autocomplete)
UPDATE quest_template SET QuestFlags=524288 WHERE entry=28745;



--Quest: Heel-Hoot=50044
--Added correct questrelation
DELETE FROM `creature_questrelation` WHERE id=49537 AND quest=28782;
INSERT INTO `creature_questrelation` VALUES
(49537, 28782);

--Fix npcflag for Hell-Hoot=50044
UPDATE `creature_template` SET npcflag=0 WHERE entry=50044;

--Removed wrong questrelation
DELETE FROM creature_questrelation WHERE id=50044;