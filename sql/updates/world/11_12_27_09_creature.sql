--Fix npcflag for quest A Taste for Bear=28637 (removed autocommplete)
UPDATE quest_template SET QuestFlags=262152 WHERE entry=28637;



--Quest: A Little Gamy=28719
--Added missing creature Shardtooth Mauler=7443
DELETE FROM creature WHERE id=7433;
INSERT INTO creature VALUES
(NULL, 7443, 1, 1, 1, 0, 0, 7322.152832, -4594.605957, 590.224426, 0.971465, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7329.253906, -4527.419922, 597.182129, 1.462339, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7302.013672, -4474.883789, 622.048035, 2.132284, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7292.624023, -4417.274414, 649.050476, 1.796918, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7265.964844, -4334.078613, 670.820251, 2.141708, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7222.396973, -4313.584961, 680.761963, 2.517914, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7195.823730, -4273.715332, 700.589355, 1.897449, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7136.095703, -4226.847168, 695.845825, 1.161531, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7087.347168, -4218.394043, 697.058777, 2.923966, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7173.880859, -4175.284180, 707.284973, 4.739805, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7119.798340, -4310.949707, 666.069275, 5.333562, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7160.068848, -4379.262207, 650.095032, 5.255808, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7189.059082, -4405.808594, 646.567810, 5.334348, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7213.569824, -4440.000488, 631.558594, 5.334348, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7240.813477, -4478.004395, 619.994934, 5.334348, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7263.285645, -4509.351563, 598.411804, 5.334348, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7275.315430, -4574.329102, 589.861328, 4.526173, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7217.609375, -4579.727539, 610.851929, 2.435442, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7158.660156, -4568.859863, 621.456238, 3.424261, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7158.660156, -4568.859863, 621.456238, 3.424261, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7120.228516, -4588.011230, 637.627869, 1.858177, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7105.587891, -4528.657715, 617.148193, 3.113244, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7099.250488, -4487.948730, 629.160156, 2.075732, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7096.649902, -4434.652832, 648.437073, 2.473929, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7093.892578, -4401.599121, 658.744507, 2.154272, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7070.309570, -4386.342285, 679.239197, 2.283863, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7144.371094, -4329.881348, 660.760132, 2.356120, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7191.345215, -4300.157715, 680.034546, 0.672226, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7231.768555, -4309.116699, 685.140808, 6.085975, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(NULL, 7443, 1, 1, 1, 0, 0, 7277.073730, -4378.054688, 655.674683, 5.844854, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0);

--Fix npcflag for Shardtooth Mauler=7443
UPDATE creature_template SET npcflag=0 WHERE entry=7443;

--Changed questflags (removed autocomplete)
UPDATE quest_template SET QuestFlags=524288 WHERE entry=28719;



--Quest: Ursius=28639
--Added missing creature Ursius=10806
DELETE FROM creature WHERE id=10806;
INSERT INTO creature VALUES(NULL, 10806, 1, 1, 1, 0, 0, 7121.075195, -4665.069824, 638.785156, 1.393209, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0);



--Quest: Vyral the Vile=8321
--Added missing npc Vyral the Vile=15202
DELETE FROM creature WHERE id=15202;
INSERT INTO creature VALUES (NULL, 15202, 1, 1, 1, 0, 0, -6326.045898, 11.472135, 6.509413, 5.770006, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0);