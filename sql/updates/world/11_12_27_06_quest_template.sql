--QUEST 1 Fresh out of the Grave=24959
--Fix same values in quest_template, removed duplicated entry in quest_start_scripts and fix Agatha=49044 npcflag
UPDATE quest_template SET Method=2, NextQuestId=28608, NextQuestInChain=0 WHERE entry=24959;
DELETE FROM quest_start_scripts WHERE id=24959;
INSERT INTO quest_start_scripts VALUES (24959, 0, 15, 73524, 0, 0, 0, 0, 0, 0);
INSERT INTO quest_start_scripts VALUES (24959, 0, 14, 73523, 0, 0, 0, 0, 0, 0);
UPDATE creature_template SET npcflag=3 WHERE entry=49044;


--QUEST 2 The Shadow Grave=28608
--Fix same values in quest_template and removed duplicated entry in quest_start_scripts 
UPDATE quest_template SET PrevQuestId=24959, NextQuestId=26799, NextQuestInChain=0 WHERE entry=28608;
DELETE FROM quest_start_scripts WHERE id=28608;
INSERT INTO quest_start_scripts VALUES (28608, 0, 15, 91938, 2, 0, 0, 0, 0, 0);


--QUEST 3 Those That Couldn't Be Saved=26799
--Fix same values in quest_template and Mindless Zombie=1501 npcflag
UPDATE quest_template SET RequiredRaces=16, PrevQuestId=28608, NextQuestId=28652, NextQuestInChain=0 WHERE entry=26799;
UPDATE creature_template SET npcflag=0 WHERE entry=1501;


--QUEST 4 Caretaker Caice=28652
--Fix same values in quest_template
UPDATE quest_template SET RequiredRaces=16, PrevQuestId=26799, NextQuestId=24960, NextQuestInChain=0 WHERE entry=28652;


--QUEST 5 The Wakening=24960
--Fix same values in quest_template and same dialogs in ncp_text and gossip_menu_option
UPDATE quest_template SET RequiredRaces=16, PrevQuestId=28652, NextQuestId=25089, NextQuestInChain=0, QuestFlags=524288, SoundAccept=890, SoundTurnIn=878 WHERE entry=24960;
UPDATE npc_text SET text0_0='Stand back, monster. You want a fight? Because I''ll fight you. I''ll fight any one of you creatures! Do you hear me?' WHERE ID=17566;
UPDATE npc_text SET text0_0='Oh really? Fine. I don''t want to join you and your Forsaken. Maybe I''ll start my own Forsaken! Maybe I''ll invent Forsaken with elbows!' WHERE ID=17567;
UPDATE gossip_menu_option SET option_text='Calm down, Valdred. Undertaker Mordo probably sewed some new ones on for you.' WHERE menu_id=17570;
UPDATE npc_text SET prob0=0, text0_1=NULL, text1_0=NULL, text1_1=NULL, text2_0=NULL, text2_1=NULL, text3_0=NULL, text3_1=NULL, text4_0=NULL, text4_1=NULL, text5_0=NULL, text5_1=NULL, text6_0=NULL, text6_1=NULL, text7_0=NULL, text7_1=NULL WHERE ID=17571;
--Added a new dialog in gossip_menu_option
DELETE FROM gossip_menu WHERE entry=17571;
INSERT INTO gossip_menu VALUES (17571, 17571);
DELETE FROM gossip_menu_option WHERE menu_id=17571;
INSERT INTO gossip_menu_option VALUES
(17571, 0, 0, 'Fight for the horde!', 1, 1, 0, 0, 0, 0, 0, NULL);
--Add conditions
DELETE FROM conditions WHERE SourceGroup=17564;
INSERT INTO conditions VALUES
(15, 17564, 0, 0, 9, 24960, 0, 0, 0, '', 'Gossip Menu Option not visible without quest taken');
DELETE FROM conditions WHERE SourceGroup=17566;
INSERT INTO conditions VALUES
(15, 17566, 0, 0, 9, 24960, 0, 0, 0, '', 'Gossip Menu Option not visible without quest taken');
DELETE FROM conditions WHERE SourceGroup=17569;
INSERT INTO conditions VALUES
(15, 17569, 0, 0, 9, 24960, 0, 0, 0, '', 'Gossip Menu Option not visible without quest taken');


--QUEST 6 Beyond the Graves=25089
--Fix same values in quest_template and removed duplicated entry in quest_start_scripts
UPDATE quest_template SET RequiredRaces=16, PrevQuestId=24960, NextQuestId=26800, NextQuestInChain=0 WHERE entry=25089;
DELETE FROM quest_start_scripts WHERE id=28800;
INSERT INTO quest_start_scripts VALUES (25089, 0, 15, 91576, 2, 0, 0, 0, 0, 0);


--QUEST 7 Recruitment (QUEST AUTOCOMPLETE, TODO Darnell's script)
--Fix same values in quest_template, removed ReqCreatureOrGoId1 and duplicated entry in quest_start_scripts
UPDATE quest_template SET RequiredRaces=16, PrevQuestId=25089, NextQuestId=28653, NextQuestInChain=0 WHERE entry=26800;
UPDATE quest_template SET ReqCreatureOrGOId1=0, ReqCreatureOrGoCount1=0 WHERE entry=26800; --To remove when Darnell's script will be fix
DELETE FROM quest_start_scripts WHERE id=26800;
INSERT INTO quest_start_scripts VALUES (26800, 0, 15, 91576, 2, 0, 0, 0, 0, 0);


--QUEST 8 Shadow Priest Sarvis
--Fix same values in quest_template 
UPDATE quest_template SET RequiredRaces=16, PrevQuestId=26800, NextQuestId=26801, NextQuestInChain=0 WHERE entry=28653;


--QUEST 9 Scourge on our Perimeter
--Fix same values in quest_template, added KillCredit to Wretched Ghoul=1502 and Rattlecage Skeleton=1890 npcflag
UPDATE quest_template SET RequiredRaces=16, NextQuestId=24961, NextQuestInChain=0 WHERE entry=26801;
UPDATE creature_template SET KillCredit1=1890 WHERE entry=1502;
UPDATE creature_template SET npcflag=0 WHERE entry=1890;



--QUEST Night Web's Hollow=24973
--Fix npcflag to npc Young Night Web Spider=1504 and Night Web Spider=1505
UPDATE creature_template SET npcflag=0 WHERE entry IN (1504, 1505);


--QUEST Assault on the Rotbrain Encampment=24971
--Fix same values in quest_template and npc Rotbrain Berserker=49422, Rotbrain Magus=49423, Marshal Redpath=424
UPDATE quest_template SET Method=2, RewSpellCast=0 WHERE entry=24971;
UPDATE creature_template SET npcflag=0 WHERE entry IN (49422, 49424);
UPDATE creature_template SET faction_A=14, faction_H=14 where entry BETWEEN 49422 AND 49424;








