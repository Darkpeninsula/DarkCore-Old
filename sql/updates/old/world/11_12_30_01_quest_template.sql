--Fix required npc kill for quest The Earthen Oath=13005
UPDATE quest_template SET ReqCreatureOrGOId1=29984, ReqCreatureOrGOId2=29978 WHERE entry=13005;