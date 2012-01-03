/*
####################
#PG RECOVERY SYSTEM#
####################
*/
-- SET @ultimatum := (select UNIX_TIMESTAMP(date("2010-11-01"))); -- unused
-- SELECT NAME FROM characters WHERE LEVEL=80 AND account>0 AND logout_time>=UNIX_TIMESTAMP(DATE("2010-05-01")) ORDER BY NAME;


-- ################## --
-- ### CLEANUP DB ### --
-- ################## --

-- Fix some Items' disenchant skill requirement
UPDATE item_template SET RequiredDisenchantSkill=375
WHERE entry BETWEEN 53491 AND 53509 OR entry IN (
54592, 55027, 55028, 55030, 55031, 55035, 55036, 
55038, 55040, 55495, 55496, 55503, 55504, 55505, 
55512, 55513, 55514, 55521, 55522, 55523, 55530, 
55531, 55532, 55539, 55540, 55541, 55548, 55549, 
55550, 55557, 55558, 55559, 57423, 57470, 57473, 
57474, 59390, 59391, 59404, 59421, 60942, 61057, 
61060, 61063, 61066, 61089, 61092, 61095, 61436, 
61439, 63709, 63712, 63715, 63718, 63727, 63730, 
63737, 63740, 63748, 63751, 63757, 63763, 63766, 
63770, 63773, 63775, 63782, 63784, 63809, 63812, 
63815, 63818, 63835, 63844, 63847, 63850, 63853, 
63856, 63859, 63862, 63865, 63868, 63871, 63874, 
63878, 63882, 63885, 63894, 63897, 63900, 63903, 
63922, 63925, 65786, 65789, 65796, 65800, 65806, 
65809, 65817, 65822, 65825, 65828, 65834, 65837, 
65841, 65845, 65848, 65852, 65858, 65865, 65868, 
65871, 65874, 65884, 65887, 62181, 62185, 68812);


-- Cleanup unused or deprecated entry/guid dependances
DELETE FROM script_waypoint WHERE entry=39271;
DELETE FROM creature_template_addon where entry=190000;
UPDATE creature_template_addon SET auras = NULL WHERE entry IN (35463, 35753) OR auras="";
UPDATE creature_template_addon SET auras="28305 1" WHERE entry=19668;
UPDATE creature_template_addon SET auras="29266 1" WHERE entry=20561;
UPDATE creature_template_addon SET auras="51019 0" WHERE entry=28239;
UPDATE creature_addon SET auras = NULL WHERE guid IN (2770, 2772, 2829, 3066, 3694, 3725, 3868, 3891, 3892, 3893, 
300361, 308914, 308969, 309330, 309509, 309637, 309955, 310063, 310170, 310196, 7236414) OR auras="";
UPDATE creature_addon SET auras="86603 0" WHERE guid=6430775;
DELETE FROM creature WHERE guid IN (
238811, 238819, 239235, 239375, 239418, 239434, 239681, 239688, 239798, 239888, 240000, 240141, 240276, 240402, 240717, 241476, 241552, 
241822, 242124, 242185, 242335, 258277, 277867, 277917, 277963, 277966, 277985, 278026, 278237, 278309, 278314, 278326, 278375, 278413, 
278628, 278799, 278811, 278927, 278930, 278957, 279126, 279538, 279587, 279606, 279627, 292924, 302448, 307770, 307945, 308070, 308107, 
308222, 308612, 308773, 324188, 324189, 324192, 324194, 324195, 324198, 324200, 324209, 324210, 324425, 324426, 324430, 324431, 324432, 
324433, 324434, 324436, 324437, 324438, 324441, 324449, 324880, 324890, 325322, 325323, 325324, 325540, 325541, 325542, 325544, 325546, 
325547, 325549, 325550, 325552, 325553, 325555, 325556, 325558, 325559, 325561, 325562, 325564, 325565, 325567, 325568, 325570, 325571);



-- Update some questgivers' flags
UPDATE creature_template SET npcflag = npcflag|2 WHERE entry IN (
1501, 1504, 1505, 1890, 3101, 35627, 37961, 38038, 38038, 38038, 38038, 38038, 38038, 38038, 38300, 38895, 49230, 49231, 49340, 
52135, 52135, 52374, 52467, 52669, 52669, 52669, 52669, 52669, 52669, 52669, 52669, 52669, 52669, 52671, 52671, 52671, 52671, 52749, 
52838, 52838, 52838, 52838, 52845, 52845, 52924, 52925, 52933, 53023, 53023, 53023, 53024, 53151, 53151,50082,52374, 52467, 52669, 
52669, 52669, 52669, 52669, 52669, 52669, 52669, 52669, 52669, 52669, 52671, 52671, 52671, 52671, 52838, 52838, 52838, 52844, 52845, 
52845, 52924, 52925, 52933, 53023, 53023, 53023, 53024, 53151);



-- Fix some NPC spawn-related bugs
UPDATE creature SET MovementType=1 WHERE guid IN (
57229, 72687, 75051, 100891, 101828, 268543, 268857, 269200, 269221, 295277, 294922, 306302, 306300, 
306033, 305979, 305926, 305884, 305867, 305854, 311131, 310802, 312291, 313298, 313260, 314360, 314735, 
255128, 265369, 304870, 243829, 267940, 267899, 267712, 267676, 314924, 321186, 54700, 54701, 272968, 
32336, 6631742, 305805, 305793, 305679, 305495, 305407, 305396, 305164, 305052, 290921, 313189, 7231610, 
7232200, 6597423, 6597422, 6597223, 6391486, 75099);
UPDATE creature SET spawndist=3 /* 3.07 is the average value for spawndist */  WHERE guid IN (
86611, 243426, 242967, 243168, 243615, 243447, 243777, 243674, 239484, 239514, 239677, 239683, 
240052, 240676, 240690, 242867, 269640, 242750, 12611, 12594, 310650, 314763, 254173, 244109, 
244601, 244140, 244243, 244931, 303998, 241647, 241007, 241122, 241607, 6597677);
DELETE FROM creature_addon WHERE guid IN (
238811, 238819, 239235, 239375, 239418, 239434,239681, 239688, 239798, 
239888, 240000, 240141, 240276, 240402, 240717, 241476, 241552, 241822, 
242124, 242185, 242335, 258277, 277867, 277917, 277963, 277966, 277985, 
278026, 278237, 278309, 278314, 278326, 278375, 278413, 278628, 278799, 
278811, 278927, 278930, 278957, 279126, 279538, 279587, 279606, 279627, 
292924, 302448, 307770, 307945, 308070, 308107, 308222, 308612, 308773, 
324188, 324189, 324192, 324194, 324195, 324198, 324200, 324209, 324210, 
324425, 324426, 324430, 324431, 324432, 324433, 324434, 324436, 324437, 
324438, 324441, 324449, 324880, 324890, 325322, 325323, 325324, 325540, 
325541, 325542, 325544, 325546, 325547, 325549, 325550, 325552, 325553, 
325555, 325556, 325558, 325559, 325561, 325562, 325564, 325565, 325567, 
325568, 325570, 325571);


-- Cleanup some errors in "Creature_template" table and related
UPDATE creature_template SET npcflag = npcflag|16 WHERE entry=4505;
UPDATE creature_template SET unit_class=1 WHERE entry IN (
52749, 52791, 52844, 52845, 53691, 54244, 54362, 54541, 500500, 53591, 53568, 
53528, 53544, 53553, 53561, 52665, 52669, 52671, 52658, 52321, 52289, 52300, 
52135, 51604, 52317, 52319, 52335, 52363, 52933, 53023, 53115, 53151, 53264, 
53024, 53517, 53526, 53493, 53271, 53265, 52932, 52925, 52374, 52428, 52467, 
52498, 52584, 52586, 52587, 52588, 52649, 52651, 52655, 52657);
UPDATE creature_template SET faction_A=2070, faction_H=2070 WHERE entry IN (11102, 16378, 46011, 51986); -- argent crusade
UPDATE creature_template SET faction_A=1891, faction_H=1891 WHERE entry IN (24061, 26877, 26879, 26880); -- valiance expedition
UPDATE creature_template SET faction_A=2233, faction_H=2233 WHERE entry=52932; -- Guardians of Hyjal (CATA)
UPDATE creature_template SET faction_A=190, faction_H=190 WHERE entry=53568; -- ambient (generic)
UPDATE creature_template SET lootid=0 WHERE entry IN (
36756, 39366, 39720, 39721, 39722, 40106, 
40252, 44835, 45893, 46753, 43687, 51613);
UPDATE creature_template SET skinloot=0 WHERE entry=18182;
DELETE FROM creature_equip_template WHERE entry=51535;
INSERT INTO creature_equip_template VALUES (51535, 65465, 0, 0);
UPDATE creature SET phaseMask=1 WHERE GUID=6628395;
UPDATE creature_template SET npcflag = (npcflag & npcflag-16777216) WHERE entry IN (29563, 31736, 31770, 31784, 31785, 33067, 33139, 34111);
DELETE FROM npc_vendor WHERE entry IN (
52032, 52032, 52032, 52032, 52032, 52032, 52032, 52032, 52032, 52032, 52032, 
52641, 52641, 52641, 52641, 52641, 52641, 52641, 52641, 52641, 52641, 52641, 
52641, 52641, 52641, 52641, 52641, 52641, 52641, 52641, 52641, 52641, 52641, 
52641, 52641, 52641, 52641, 52641, 52641, 52641, 52641, 52641, 52641, 52641, 
52641, 52641, 52641, 52641, 52641, 52641, 52641, 52641);
UPDATE creature_template SET npcflag = (npcflag | 128) WHERE entry = 3008;
DELETE FROM npc_vendor WHERE item IN (
68769, 68770, 68768, 68774, 68772, 68773, 69887, 69892, 
69210, 69209, 71033, 68769, 68773, 68770, 68772, 68774, 
68768, 68774, 68773, 68772, 68770, 68769, 68768, 68739, 
68774, 68773, 68772, 68770, 68769, 68768, 68740, 68660, 
68810, 68810, 68660, 68768, 68769, 68770, 68772, 68773, 
68774, 44945, 37100, 36900, 17967, 36914, 36915, 37706, 
18964, 45942, 10579, 17, 2090, 45280, 5632, 23578, 23579);

-- Update some NPC ModelIDs
DELETE FROM creature_template WHERE entry IN (
51637, 52289, 52317, 52319, 52321,52335, 52363, 52374, 52428, 
52467, 52498, 52584, 52586, 52587, 52588, 52649, 52651,52655, 
52657, 52658, 52665, 52749, 52925, 52932, 52933, 53023, 53024, 
53115, 53264, 53265, 53267, 53271, 53493, 53517, 53526, 53528, 
53691, 54362, 54541); /* ---> TO BE ADDED IN 4.2.0 <---
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=37561 WHERE entry=51637;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38673 WHERE entry=52289;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=37833 WHERE entry=52317;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=37834 WHERE entry=52319;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=37836 WHERE entry=52321;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=37844 WHERE entry=52335;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=37876 WHERE entry=52363;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=37814 WHERE entry=52374;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=37887 WHERE entry=52428;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=31801 WHERE entry=52467;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38227 WHERE entry=52498;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=37956 WHERE entry=52584;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=37957 WHERE entry=52586;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=37958 WHERE entry=52587;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=37959 WHERE entry=52588;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38761 WHERE entry=52649;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38006 WHERE entry=52651;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38009 WHERE entry=52655;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38010 WHERE entry=52657;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38011 WHERE entry=52658;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38017 WHERE entry=52665;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38256 WHERE entry=52749;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38086 WHERE entry=52925;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38089 WHERE entry=52932;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38087 WHERE entry=52933;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38126 WHERE entry=53023;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38124 WHERE entry=53024;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38765 WHERE entry=53115;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38255 WHERE entry=53264;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38258 WHERE entry=53265;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38012 WHERE entry=53267;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38674 WHERE entry=53271;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38364 WHERE entry=53493;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38376 WHERE entry=53517;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38380 WHERE entry=53526;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38381 WHERE entry=53528;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38448 WHERE entry=53691;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38769 WHERE entry=54362;
UPDATE creature_template SET Modelid4=0, Modelid3=0, Modelid2=0, Modelid1=38342 WHERE entry=54541;*/
DELETE FROM creature_model_info WHERE modelid IN
(51637, 52289, 52317, 52319, 52321, 52374, 52363, 52335, 52428, 52498, 52584, 52586, 
52587, 52588, 52649, 52651, 52655, 52657, 52658, 52749, 52665, 52925, 52932, 52933, 
53023, 53024, 53115, 53264, 53265, 53267, 53271, 53528, 54541, 54362, 53691, 53591, 
53526, 53517, 53493);
/*INSERT INTO creature_model_info (modelid, gender) VALUES
(51637, 0), (52289, 2), (52317, 1), (52319, 1), (52321, 0), 
(52374, 2), (52363, 2), (52335, 2), (52428, 2), (52498, 2), 
(52584, 1), (52586, 0), (52587, 0), (52588, 1), (52649, 2), 
(52651, 0), (52655, 2), (52657, 1), (52658, 0), (52749, 2), 
(52665, 2), (52925, 0), (52932, 2), (52933, 0), (53023, 1), 
(53024, 1), (53115, 2), (53264, 2), (53265, 2), (53267, 2), 
(53271, 2), (53528, 1), (54541, 2), (54362, 0), (53691, 2), 
(53591, 2), (53526, 2), (53517, 2), (53493, 2);*/


-- Cleanup *_loot_template tables
-- creature
UPDATE creature_loot_template SET ChanceOrQuestChance=0 WHERE groupid=1 AND entry IN (
36498, 31386, 31464, 33955, 31533, 31536, 31537, 31384, 
31381, 31350, 31349, 31362, 31465, 31469, 30510, 38462);
UPDATE creature_loot_template SET ChanceOrQuestChance=0 WHERE groupid=1 AND entry IN (
31538, 31386, 31360, 30540, 31464);
UPDATE creature_loot_template SET ChanceOrQuestChance=0 WHERE entry=38462 and groupid=3;
DELETE FROM creature_loot_template WHERE entry IN (
901, 902, 945, 8919, 9011, 9012, 9013, 9014, 9015, 39666, 
39680, 39699, 39701, 39706, 48337, 48702, 48710, 48714, 
48715, 48776, 48778, 48784, 48815, 48822, 48902, 48932, 
48936, 48940, 48941, 48943, 48944, 48951, 49043, 49541, 
49708, 49709, 49711, 49712, 51088, 51712);
DELETE FROM creature_loot_template WHERE entry=47901 AND item=68729;
DELETE FROM creature_loot_template WHERE entry=50061 AND item=67132;
DELETE FROM creature_loot_template WHERE entry=50061 AND item=67142;
DELETE FROM creature_loot_template WHERE entry=50061 AND item=67148;
DELETE FROM creature_loot_template WHERE entry=50061 AND item=67140;
DELETE FROM creature_loot_template WHERE entry=50063 AND item=69877;
DELETE FROM creature_loot_template WHERE entry=50063 AND item=67140;
DELETE FROM creature_loot_template WHERE entry=50063 AND item=67132;
DELETE FROM creature_loot_template WHERE entry=50063 AND item=67133;
DELETE FROM creature_loot_template WHERE entry=50063 AND item=68782;
DELETE FROM creature_loot_template WHERE entry=50063 AND item=68781;
DELETE FROM creature_loot_template WHERE entry=50063 AND item=69820;
DELETE FROM creature_loot_template WHERE entry=50056 AND item=69842;
DELETE FROM creature_loot_template WHERE entry=50056 AND item=67147;
DELETE FROM creature_loot_template WHERE entry=50056 AND item=67134;
DELETE FROM creature_loot_template WHERE entry=50056 AND item=67150;
DELETE FROM creature_loot_template WHERE entry=50056 AND item=68783;
DELETE FROM creature_loot_template WHERE entry=50056 AND item=67140;
DELETE FROM creature_loot_template WHERE entry=50056 AND item=69820;
DELETE FROM creature_loot_template WHERE entry=50056 AND item=67136;
DELETE FROM creature_loot_template WHERE entry=53691 AND item=71141;
DELETE FROM creature_loot_template WHERE entry=53691 AND item=69237;
DELETE FROM creature_loot_template WHERE entry=52558 AND item=71141;
DELETE FROM creature_loot_template WHERE entry=52558 AND item=69237;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=53691 AND item=71024;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=53691 AND item=71023;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=53691 AND item=71018;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=53691 AND item=71022;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=53691 AND item=71020;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=53691 AND item=71019;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=53691 AND item=71013;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=53691 AND item=71028;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=53691 AND item=71025;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=53691 AND item=71026;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71011;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71012;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=70992;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71006;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=70993;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71005;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71010;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71009;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71004;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=70991;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71003;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71007;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=70912;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71787;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71785;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71782;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71775;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71779;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71780;
UPDATE creature_loot_template SET mincountOrRef=1 WHERE entry=52558 AND item=71776;
-- gameobject
DELETE FROM gameobject_loot_template WHERE entry IN (24908, 161521, 161526);
DELETE FROM gameobject_loot_template WHERE item=51597;
DELETE FROM gameobject_loot_template WHERE mincountOrRef IN (
-11103, -11099, -11103, -11103, -11102, -11006, -11012, -11006, -11001, 
-11008, -11100, -11004, -11008, -11103, -11104, -11099, -11102, -11102, 
-11102, -11012, -11012, -11004, -11106, -11006, -11008, -11001, -11006, 
-11004, -11004, -11001, -11099, -11008, -11006, -11006, -11006, -11008, 
-11103, -11103, -11006, -11008, -11008, -11001, -11001, -11001, -11001, 
-11008, -11008, -11004, -11016, -11001, -12901, -34293, -34287, -34291, 
-34293, -34285, -34289, -34293, -34287, -34291, -34285, -34289, -34286, 
-34290, -34285, -34289, -34293, -34287, -34291, -34288, -34292);
-- item
DELETE FROM item_loot_template WHERE entry IN (39878, 48766, 68813);
DELETE FROM item_loot_template WHERE item IN (65503, 69771);
-- milling
DELETE FROM milling_loot_template WHERE entry IN (52183, 52185, 53038);
-- pickpocketing
DELETE FROM pickpocketing_loot_template WHERE entry IN (41500, 42937, 42938, 47607, 49874, 50039);
-- skinning
UPDATE skinning_loot_template SET mincountOrRef = 1 WHERE entry=52363 AND item=52976;
DELETE FROM skinning_loot_template WHERE entry IN (0, 33311, 35409, 35412, 40008, 51676);
-- fishing
DELETE FROM fishing_loot_template WHERE entry=58503 OR mincountOrRef IN (
-11103, -11099, -11103, -11103, -11102, -11006, -11012, -11006, -11001, 
-11008, -11100, -11004, -11008, -11103, -11104, -11099, -11102, -11102, 
-11102, -11012, -11012, -11004, -11106, -11006, -11008, -11001, -11006, 
-11004, -11004, -11001, -11099, -11008, -11006, -11006, -11006, -11008, 
-11103, -11103, -11006, -11008, -11008, -11001, -11001, -11001, -11001, 
-11008, -11008, -11004, -11016, -11001, -12901, -34293, -34287, -34291, 
-34293, -34285, -34289, -34293, -34287, -34291, -34285, -34289, -34286, 
-34290, -34285, -34289, -34293, -34287, -34291, -34288, -34292);
-- disenchant
DELETE FROM disenchant_loot_template WHERE entry IN (18, 21, 67134, 67136, 67140, 67147, 67150);
-- referenced loot
DELETE FROM reference_loot_template WHERE entry IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 
16, 100, 101, 3914, 7909, 7910, 10796, 13755, 14622, 16864, 16899, 18296, 18709, 18822, 19146, 19710, 
19719, 20736, 20875, 20885, 20888, 20890, 21004, 21232, 21296, 21321, 21371, 21695, 22712, 23436, 29304, 
29305, 29306, 29573, 29754, 29757, 29760, 29764, 29767, 29932, 30236, 30240, 30247, 30249, 30530, 31091, 
31092, 31096, 31099, 31103, 31367, 31368, 31370, 32303, 33490, 33497, 33805, 34851, 34855, 34857, 36917, 
36918, 37582, 40633, 43722, 43723, 45467, 45474, 45479, 45488, 45634, 45640, 45643, 45646, 45649, 45655, 
45661, 45893, 45928, 45934, 45943, 45947, 47557);
UPDATE reference_loot_template SET ChanceOrQuestChance=0 WHERE entry=11050 AND item IN 
(22739, 45188, 45189, 45190, 45191, 45194, 45195, 45196, 46109, 52985, 53071, 53072, 67597);

-- Clenup old achievements' dependances
DELETE FROM achievement_reward WHERE entry IN (4784, 4785);

-- Fix some errors in "Gameobject_template" table and related
DELETE FROM gameobject WHERE id IN (207320, 24729);
UPDATE gameobject SET spawntimesecs=180 WHERE guid=211908;
UPDATE gameobject_template SET displayID=6754 WHERE entry IN (181376, 181431, 185139);
UPDATE gameobject_template SET type=2 WHERE entry=208420;

-- Fix various AI Scripts
UPDATE creature_ai_scripts SET event_param4 = event_param3+(RAND()*10) where creature_id IN (
14688, 31277, 31271, 31242, 31222, 31196, 31195, 31194, 31193, 31192, 31191);
UPDATE creature_ai_scripts SET event_param2 = event_param1+(RAND()*10) where creature_id = 31222;
DELETE FROM smart_scripts WHERE entryorguid BETWEEN -209026 AND -209019;
UPDATE smart_scripts SET action_param1=14 WHERE event_type=25 AND entryorguid IN (29319, 29327);

-- Update TextMGR to current revision
UPDATE creature_text SET type=0 WHERE type=12;
UPDATE creature_text SET type=2 WHERE type=16;
UPDATE creature_text SET type=5 WHERE type=42;


-- Quest-related bugs
UPDATE quest_template SET /*questflags = questflags|4*/ specialflags=2 WHERE entry IN (
13168, 7482, 10722, 7481, 11708, 12573, 12807, 4285, 2278, 10107, 28400, 
12920, 695, 13152, 12537, 12032, 10166, 9645, 9718, 6001, 10108);
UPDATE quest_template SET PrevQuestId=0 WHERE entry=4361;
DELETE FROM gameobject_questrelation WHERE quest IN (28921, 27761, 27777, 27778);
DELETE FROM gameobject_involvedrelation WHERE quest IN (27760, 27761, 27777, 28921);
DELETE FROM areatrigger_involvedrelation WHERE quest=1719;
UPDATE quest_template SET ReqCreatureOrGOId1=0, ReqCreatureOrGOCount1=0 WHERE entry IN (
29200, 29165, 29122, 29241, 29168, 29172, 29175, 29163, 29162); 
UPDATE quest_template SET ReqCreatureOrGOId2=0, ReqCreatureOrGOCount2=0 WHERE entry IN (
29168, 29172, 29175);
UPDATE quest_template SET ReqCreatureOrGOId3=0, ReqCreatureOrGOCount3=0 WHERE entry IN (
29172, 29168);
UPDATE quest_template SET ReqItemId1=0, ReqItemCount1=0 WHERE entry IN (29186, 29166, 29252);
UPDATE quest_template SET RewItemId1=0, RewItemCount1=0 WHERE entry IN (29267, 29186);
UPDATE quest_template SET ReqItemId2=0, ReqItemCount2=0, SrcItemId=0, SrcItemCount=0 WHERE entry IN (52683);
UPDATE quest_template SET ReqItemId2=0, ReqItemCount2=0 WHERE entry IN (52683);
UPDATE quest_template SET SrcItemId=0, SrcItemCount=0 WHERE entry IN (
987654, 29165, 29126, 29147, 29148, 
29125, 29164, 29161, 29162, 25274);
UPDATE quest_template SET ReqSourceId2=0, ReqSourceCount2=0 WHERE entry=25274;
UPDATE quest_template SET RewChoiceItemId1=0, RewChoiceItemId2=0, RewChoiceItemId3=0,
RewChoiceItemCount1=0, RewChoiceItemCount2=0, RewChoiceItemCount3=0 WHERE entry IN (29253, 29186);
UPDATE quest_template SET RewChoiceItemId4=0, RewChoiceItemCount4=0 WHERE entry IN (29253);
UPDATE quest_template SET SpecialFlags=1 WHERE entry IN (
29163, 29166, 29126, 29147, 29148, 29125, 29164, 
29101, 29161, 29214, 29262, 987654, 29261); 
UPDATE quest_template SET RewRepFaction1=1158 WHERE RewRepFaction1=2233;
UPDATE quest_template SET RewRepFaction2=1158 WHERE RewRepFaction2=2233;
UPDATE quest_template SET SkillOrClassMask = 0 WHERE entry=28809;
DELETE FROM gameobject_questrelation WHERE quest=24492;
DELETE FROM creature_questrelation WHERE quest=24492;
INSERT INTO creature_questrelation VALUES (37113, 24492);
DELETE FROM gameobject_involvedrelation WHERE quest IN (25734, 25815, 25853);
DELETE FROM creature_involvedrelation WHERE quest IN (25734, 25815, 25853);
INSERT INTO creature_involvedrelation VALUES 
(41129, 25734), (1239, 25815), (41413, 25853);
DELETE FROM creature_involvedrelation WHERE id=53385;


-- Various cleanups
DELETE FROM game_graveyard_zone WHERE ghost_zone=3535;
DELETE FROM gossip_scripts WHERE id IN (3701, 10857, 10858, 37552, 50139, 50140);
DELETE FROM areatrigger_involvedrelation WHERE id=0;
DELETE FROM areatrigger_tavern WHERE id=2286;
DELETE FROM game_graveyard_zone WHERE ghost_zone IN (33, 36);
UPDATE item_template SET RandomSuffix=0 WHERE entry IN (
45630, 56217, 56485, 56493, 56497, 56514, 63488, 63489, 63491, 63492, 63493, 
63494, 63495, 63496, 63497, 63498, 63499, 63500, 63501, 63502, 63503, 63504, 
63505, 63506, 63507, 65367, 65368, 65369, 65370, 65371, 65372, 65373, 65374, 
65375, 65376, 65377, 65378, 65379, 65380, 65381, 65382, 65383, 65384, 65385, 
65386, 68127, 68129, 68130, 68131, 68132);
UPDATE item_template SET RequiredReputationRank=0 WHERE entry=65435;
UPDATE item_template SET stat_type4=0, stat_value4=0 WHERE entry=62038;
UPDATE item_template SET stat_type2=7 WHERE stat_type2=127;
UPDATE item_template SET stat_type3=7 WHERE stat_type3=127;
UPDATE item_template SET stat_type4=7 WHERE stat_type4=127;
DELETE FROM event_scripts WHERE id=2609;
DELETE FROM gossip_menu_option WHERE menu_id=33238 AND id=0;
UPDATE gossip_menu_option SET id=0 WHERE id=1 AND menu_id=33238;
UPDATE gossip_menu_option SET id=1 WHERE id=2 AND menu_id=33238;
UPDATE gossip_menu_option SET id=2 WHERE id=3 AND menu_id=33238;
UPDATE gossip_menu_option SET id=3 WHERE id=4 AND menu_id=33238;
DELETE FROM gossip_menu_option WHERE menu_id=7034 AND id=0;
DELETE FROM gossip_menu_option WHERE menu_id=7560 AND id=3;
DELETE FROM gossip_menu_option WHERE menu_id=9709 AND id=2;
DELETE FROM gossip_menu_option WHERE menu_id=9709 AND id=3;
DELETE FROM gossip_menu_option WHERE menu_id=9709 AND id=4;
DELETE FROM gossip_menu_option WHERE menu_id=9709 AND id=5;
DELETE FROM gossip_menu_option WHERE menu_id=9709 AND id=6;
DELETE FROM gossip_menu_option WHERE menu_id=9709 AND id=7;
DELETE FROM gossip_menu_option WHERE menu_id=10668 AND id=4;
DELETE FROM gossip_menu_option WHERE menu_id=33238 AND id=0;
DELETE FROM spell_scripts WHERE id=43709;
DELETE FROM db_script_string WHERE entry IN (
2000000363, 2000000364, 2000000365, 2000000366, 2000000367, 
2000000368, 2000000369, 2000000370, 2000000371, 2000000372, 
2000000373, 2000000374, 2000000375, 2000000376, 2000000377, 
2000000378, 2000000380, 2000000381, 2000000382, 2000000383, 
2000001200, 2000001201, 2000001202);
DELETE FROM script_texts WHERE entry IN (
-1638010, -1638011, -1638012, -1638013, -1638014, -1638015, 
-1638024, -1638023, -1638003, -1638004, -1638005, -1638022, 
-1638009, -1638007, -1638008, -1638006);
DELETE FROM gossip_scripts WHERE datalong=21632 AND id=4362;
DELETE FROM gossip_scripts WHERE datalong=52508 AND id=36856;
DELETE FROM gossip_scripts WHERE datalong=2655 AND id=32346;
DELETE FROM gossip_scripts WHERE datalong=4287 AND id=2178;
DELETE FROM gossip_scripts WHERE datalong=4288 AND id=2179;
DELETE FROM gossip_scripts WHERE datalong=6002 AND id=3862;
DELETE FROM creature_ai_scripts WHERE id IN (3498002, 3257601, 3257602);
UPDATE creature_ai_scripts SET id=3498002 WHERE id=3498003;
UPDATE creature_ai_scripts SET id=3498003 WHERE id=3498004;
DELETE FROM instance_encounters WHERE entry IN (280, 793);
DELETE FROM npc_spellclick_spells WHERE quest_start=29082;

-- ultimating
DELETE FROM creature_loot_template WHERE item IN (
71023, 71018, 71022, 71020, 71019, 71013, 71028, 71025, 71026, 
71011, 71012, 70992, 71006, 70993, 71005, 71010, 71009, 71004, 
70991, 71003, 71007, 70912, 71787, 71785, 71782, 71775, 71779, 
71780, 71776, 71024);
UPDATE creature_loot_template SET mincountorref=1 WHERE entry=53691 AND item=71014;
UPDATE creature_loot_template SET chanceorquestchance=0 WHERE groupid=2 AND entry IN (
30540, 31386, 31360, 31464, 31538);
UPDATE creature_template SET lootid=0 WHERE lootid IN (43687);
DELETE FROM skinning_loot_template WHERE entry=52363;
UPDATE gameobject_template SET data1=0 WHERE entry IN (
2867, 14777, 14778, 179545, 179553, 180370, 180371, 180372, 180373, 
180374, 186748, 186750,190394, 191349, 201778, 201939, 202478, 202865, 
203071, 203139, 206570, 207472, 207473, 207484, 207512, 207520);
DELETE FROM db_script_string WHERE entry IN (
2000000057, 2000000063, 2000000084, 2000000085, 2000000086, 
2000000093, 2000000095, 2000000096, 2000000097, 2000000100, 
2000000101, 2000000105, 2000000106, 2000000432, 2000000433, 
2000000434, 2000000435, 2000000436);
UPDATE quest_template SET ReqSpellCast1=0 WHERE entry=29164;
UPDATE quest_template SET RewItemId1=0, RewItemCount1=0 WHERE entry IN (68833, 69748);
DELETE FROM smart_scripts WHERE entryorguid=21419;
DELETE FROM smart_scripts WHERE entryorguid=17551 AND id=1;
UPDATE smart_scripts SET id=1 WHERE id=2 AND entryorguid=17551;
UPDATE smart_scripts SET id=2 WHERE id=3 AND entryorguid=17551;
DELETE from waypoint_scripts WHERE id IN (1739, 2000, 2001, 5011);
UPDATE creature_template SET equipment_id=0 WHERE entry=500500;
UPDATE quest_template SET specialflags=specialflags|2 WHERE entry=2608;
DELETE FROM quest_template WHERE entry = 8555 OR entry = 4022;
INSERT INTO quest_template 
(`entry`, `Method`, `ZoneOrSort`, `SkillOrClassMask`, `MinLevel`, `MaxLevel`, `QuestLevel`, `Type`, `RequiredRaces`, 
`RequiredSkillValue`, `RepObjectiveFaction`, `RepObjectiveValue`, `RepObjectiveFaction2`, `RepObjectiveValue2`, 
`RequiredMinRepFaction`, `RequiredMinRepValue`, `RequiredMaxRepFaction`, `RequiredMaxRepValue`, `SuggestedPlayers`, 
`LimitTime`, `QuestFlags`, `SpecialFlags`, `CharTitleId`, `PlayersSlain`, `BonusTalents`, `RewardArenaPoints`, 
`PrevQuestId`, `NextQuestId`, `ExclusiveGroup`, `NextQuestInChain`, `RewXPId`, `SrcItemId`, `SrcItemCount`, `SrcSpell`, 
`Title`, `Details`, `Objectives`, `OfferRewardText`, `RequestItemsText`, `EndText`, `CompletedText`, `ObjectiveText1`, 
`ObjectiveText2`, `ObjectiveText3`, `ObjectiveText4`, `ReqItemId1`, `ReqItemId2`, `ReqItemId3`, `ReqItemId4`, 
`ReqItemId5`, `ReqItemId6`, `ReqItemCount1`, `ReqItemCount2`, `ReqItemCount3`, `ReqItemCount4`, `ReqItemCount5`, 
`ReqItemCount6`, `ReqSourceId1`, `ReqSourceId2`, `ReqSourceId3`, `ReqSourceId4`, `ReqSourceCount1`, `ReqSourceCount2`, 
`ReqSourceCount3`, `ReqSourceCount4`, `ReqCreatureOrGOId1`, `ReqCreatureOrGOId2`, `ReqCreatureOrGOId3`, `ReqCreatureOrGOId4`, 
`ReqCreatureOrGOCount1`, `ReqCreatureOrGOCount2`, `ReqCreatureOrGOCount3`, `ReqCreatureOrGOCount4`, `ReqSpellCast1`, 
`ReqSpellCast2`, `ReqSpellCast3`, `ReqSpellCast4`, `RewChoiceItemId1`, `RewChoiceItemId2`, `RewChoiceItemId3`, 
`RewChoiceItemId4`, `RewChoiceItemId5`, `RewChoiceItemId6`, `RewChoiceItemCount1`, `RewChoiceItemCount2`, `RewChoiceItemCount3`, 
`RewChoiceItemCount4`, `RewChoiceItemCount5`, `RewChoiceItemCount6`, `RewItemId1`, `RewItemId2`, `RewItemId3`, `RewItemId4`, 
`RewItemCount1`, `RewItemCount2`, `RewItemCount3`, `RewItemCount4`, `RewRepFaction1`, `RewRepFaction2`, `RewRepFaction3`, 
`RewRepFaction4`, `RewRepFaction5`, `RewRepValueId1`, `RewRepValueId2`, `RewRepValueId3`, `RewRepValueId4`, `RewRepValueId5`, 
`RewRepValue1`, `RewRepValue2`, `RewRepValue3`, `RewRepValue4`, `RewRepValue5`, `RewHonorAddition`, `RewHonorMultiplier`, `unk0`, 
`RewOrReqMoney`, `RewMoneyMaxLevel`, `RewSpell`, `RewSpellCast`, `RewMailTemplateId`, `RewMailDelaySecs`, `PointMapId`, 
`PointX`, `PointY`, `PointOpt`, `DetailsEmote1`, `DetailsEmote2`, `DetailsEmote3`, `DetailsEmote4`, `DetailsEmoteDelay1`, 
`DetailsEmoteDelay2`, `DetailsEmoteDelay3`, `DetailsEmoteDelay4`, `IncompleteEmote`, `CompleteEmote`, `OfferRewardEmote1`, 
`OfferRewardEmote2`, `OfferRewardEmote3`, `OfferRewardEmote4`, `OfferRewardEmoteDelay1`, `OfferRewardEmoteDelay2`, 
`OfferRewardEmoteDelay3`, `OfferRewardEmoteDelay4`, `StartScript`, `CompleteScript`, `WDBVerified`) VALUES (
8555, 0, 440, 0, 60, 0, 60, 0, 0, 0, 0, 0, 0, 0, 910, 0, 0, 0, 0, 0, 64, 
0, 0, 0, 0, 0, 8519, 0, 0, 0, 1, 0, 0, 0, 'The Charge of the Dragonflights', '', '', 
'Eranikus, Vaelastrasz, and Azuregos... No doubt you know of these dragons, mortal. 
It is no coincidence, then, that they have played such influential roles as watchers of our world.
$B$BUnfortunately (and my own naivety is partially to blame) whether by agents of the Old Gods or 
betrayal by those that would call them friend, each guardian has fallen to tragedy. The extent of 
which has fueled my own distrust towards your kind.$B$BSeek them out... And $R, prepare yourself for the worst.', 
NULL, NULL, NULL, '', '', '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 910, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 1, 0, 570, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12340),
(4022, 2, 46, 0, 52, 0, 54, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 0, 0, 0, 0, 0, 3481, 4024, 4022, 4024, 5, 0, 
0, 0, 'A Taste of Flame', 'The flight is aware of your work in the Searing Gorge.$B$BShow it to me, $r. The molt, imbecile.', 
'Show Cyrus Therepentous the Black Dragonflight Molt you received from Kalaran Windblade.$B', '<Cyrus examines the molt.>
$B$BYou have proven that you are not entirely useless, mortal.', '<Cyrus\'s eyes form two blazing spheres.>', 'Proof Presented', 
'Speak to Cyrus Therepentous at Slither Rock in the Burning Steppes.', '', '', '', '', 10575, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4800, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 12340);
DELETE FROM spell_loot_template WHERE entry IN (
73500, 75183, 78866, 80615, 84193, 85325, 85435, 
86656, 86883, 86884, 86885, 87628, 88343, 95399, 
95406);
INSERT INTO spell_loot_template (entry, item, chanceorquestchance, groupid, mincountorref, maxcount) VALUES
(73500, 62791, 100, 0, 1, 2),
(73500, 52338, 2, 0, 1, 1),
(73500, 52339, 1, 0, 1, 1),
(75183, 52325, 100, 0, 8, 11),
(75183, 52326, 100, 0, 8, 11),
(78866, 54464, 100, 0, 1,1),
(80615, 58864, 50, 0, 1, 1),
(80615, 58865, 0, 1, 1, 1),
(80615, 58866, 0, 1, 1, 1),
(85325, 45047, 100, 0, 50, 50),
(85325, 35223, 100, 0, 50, 50),
(85325, 46779, 100, 0, 50, 50),
(85325, 23720, 10, 1, 1, 1),
(85325, 49284, 10, 1, 1, 1),
(85325, 49283, 10, 1, 1, 1),
(85325, 49286, 10, 1, 1, 1),
(85325, 49285, 10, 1, 1, 1),
(85325, 49282, 10, 1, 1, 1),
(85435, 57197, 100, 0, 1, 1),
(86883, 57197, 100, 0, 1, 1),
(86656, 57197, 100, 0, 1, 1),
(86884, 57197, 100, 0, 1, 1),
(86885, 62338, 100, 0, 1, 1),
(87628, 62649, 100, 0, 1, 1),
(88343, 57197, 100, 0, 1, 1),
(95399, 52983, 100, 0, 1, 1),
(95406, 52988, 100, 0, 1, 1),
(84193, 62559, 3, 1, 1, 1),
(84193, 62558, 3, 1, 1, 1),
(84193, 62562, 3, 1, 1, 1),
(84193, 62557, 3, 1, 1, 1),
(84193, 62561, 3, 1, 1, 1),
(84193, 62560, 3, 1, 1, 1),
(84193, 62554, 3, 1, 1, 1),
(84193, 62552, 3, 1, 1, 1),
(84193, 62553, 3, 1, 1, 1),
(84193, 62563, 3, 1, 1, 1),
(84193, 62555, 3, 1, 1, 1),
(84193, 62556, 3, 1, 1, 1),
(84193, 62567, 3, 1, 1, 1),
(84193, 62573, 3, 1, 1, 1),
(84193, 62572, 3, 1, 1, 1),
(84193, 62574, 3, 1, 1, 1),
(84193, 62575, 3, 1, 1, 1),
(84193, 62576, 3, 1, 1, 1),
(84193, 62571, 3, 1, 1, 1),
(84193, 62570, 3, 1, 1, 1),
(84193, 62566, 3, 1, 1, 1),
(84193, 62565, 3, 1, 1, 1),
(84193, 62247, 3, 1, 1, 1),
(84193, 62568, 3, 1, 1, 1),
(84193, 62569, 3, 1, 1, 1),
(84193, 62564, 3, 1, 1, 1),
(84193, 62588, 6, 2, 1, 1),
(84193, 62580, 6, 2, 1, 1),
(84193, 62581, 6, 2, 1, 1),
(84193, 62579, 6, 2, 1, 1),
(84193, 62591, 6, 2, 1, 1),
(84193, 62246, 6, 2, 1, 1),
(84193, 62577, 6, 2, 1, 1),
(84193, 62582, 6, 2, 1, 1),
(84193, 62578, 6, 2, 1, 1),
(84193, 62590, 6, 2, 1, 1),
(84193, 62583, 6, 2, 1, 1),
(84193, 62589, 6, 2, 1, 1),
(84193, 62587, 6, 2, 1, 1),
(84193, 62584, 6, 2, 1, 1),
(84193, 62585, 6, 2, 1, 1),
(84193, 62586, 6, 2, 1, 1),
(84193, 60839, 15, 3, 1, 1),
(84193, 62598, 15, 3, 1, 1),
(84193, 62600, 15, 3, 1, 1),
(84193, 62599, 15, 3, 1, 1),
(84193, 62601, 15, 3, 1, 1),
(84193, 62602, 10, 4, 1, 1),
(84193, 60841, 10, 4, 1, 1),
(84193, 62604, 10, 4, 1, 1),
(84193, 62603, 10, 4, 1, 1),
(84193, 62605, 10, 4, 1, 1),
(84193, 60842, 10, 5, 1, 1),
(84193, 62606, 10, 6, 1, 1),
(84193, 60843, 10, 6, 1, 1),
(84193, 60845, 5, 7, 1, 1),
(84193, 60840, 4, 8, 1, 1),
(84193, 60844, 1, 9, 1, 1);
DELETE FROM creature_questrelation WHERE id IN (
52374, 52467, 52749, 52925, 52933, 53023, 53023, 53023, 53024);
DELETE FROM creature_involvedrelation WHERE id IN (
52374, 52467, 52749, 52925, 52933, 53023, 53023, 53023, 53024);
UPDATE creature_template SET modelid3=0 WHERE entry=53591;
DELETE FROM creature_loot_template where item=71014;
DELETE FROM gameobject_template WHERE data1 IN (14777, 14778);
DELETE FROM creature_ai_scripts WHERE id IN (30004256, 371201, 30024897, 30005327, 30004134, 50000303, 30004624);
UPDATE creature_template SET ainame="" WHERE entry IN (3712, 12430, 12429, 12428, 12427, 12423, 8658);
UPDATE quest_template SET ReqCreatureOrGOId2=0, ReqCreatureOrGOcount2=0 WHERE entry=29163;
DELETE FROM gameobject WHERE guid IN (183163, 183208);

UPDATE `gameobject_template` SET `data0` = '7001' WHERE `entry` = '181165';
-- Temp Disable in Wait to Sniff more Information - type=22
UPDATE `gameobject_template` SET `type` = '4' WHERE `entry` = '204422';
DELETE FROM `spell_ranks` WHERE `spell_id` = '9635';
DELETE FROM `spell_ranks` WHERE `spell_id` = '1178';
DELETE FROM `spell_group` WHERE `spell_id` IN ('51726','51734','51735','60431','60432');
DELETE FROM `spell_proc_event` WHERE `entry` IN ('34859','34753','16810','16811','16812','16813','17329','27009','53312','18120','18119','31834','50294');
DELETE FROM `spell_group_stack_rules` WHERE `group_id` IN ('1337','16','1114');
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN ('643','1032','57339','10290','10291','10292','10293','10298','10299','10300','10301','19876','19888','19895','19896','19897','19898','19899','19900','57340','27149','27150','27151','27152','27153','48941','48942','48943','48945','48947','54043');
UPDATE `creature_template` SET `spell1` = '0' WHERE `entry` IN ('51850','52289','52300','52749','52844','53115','53264','53271','53267','54362');
UPDATE `creature_template` SET `spell2` = '0' WHERE `entry` IN ('44428','52289','52749','52844','53115','53271','53267','500500');
UPDATE `creature_template` SET `spell3` = '0' WHERE `entry` IN ('52649','53115','53264','53271','53267','53265');
UPDATE `creature_template` SET `spell4` = '0' WHERE `entry` IN ('52791','53264','54362');
UPDATE `creature_template` SET `spell5` = '0' WHERE `entry` IN ('54362');
-- Temp Delete Spell Rallying Cry on Trainer
DELETE FROM `npc_trainer` WHERE `spell` = '97462';
DELETE FROM `instance_encounters` WHERE `creditEntry` IN ('58630','59046','68572','68574');
UPDATE `creature_ai_scripts` SET `event_param1` = '0' WHERE `event_param1` IN ('2052','1243');
UPDATE `creature_ai_scripts` SET `action2_param1` = '0' WHERE `action2_param1` IN ('11762');
UPDATE `creature_ai_scripts` SET `action1_param1` = '0' WHERE `action1_param1` IN ('782');
DELETE FROM `spell_scripts` WHERE `id` = '51662';
DELETE FROM `spell_area` WHERE `spell`='35480' AND `racemask`='1722';
DELETE FROM `spell_area` WHERE `spell`='35481' AND `racemask`='1722';
UPDATE `quest_template` SET `RewSpell` = '0' WHERE `RewSpell` IN ('98279','99031','98280');
UPDATE `quest_template` SET `RewSpellCast` = '0' WHERE `RewSpellCast` IN ('98279','98280');
DELETE FROM `spell_target_position` WHERE `id` IN ('11011','35376','35727','55554','88775');


DELETE FROM spell_group WHERE id IN ('2007','2008','2009','2010','2011','2012');
DELETE FROM spell_group_stack_rules WHERE group_id IN ('2007','2008','2009','2010','2011','2012');

-- forti, scroll of forti, prayer of forti
INSERT INTO spell_group VALUES 
(2007, 8099),
(2007, 21562),
(2007, 69377);
INSERT INTO spell_group_stack_rules VALUES (2007,1);

-- arcane intellect, scroll of int, arcane brilliance, dalaran brilliance
INSERT INTO spell_group VALUES 
(2008, 8096),
(2008, 61316),
(2008, 1459);
INSERT INTO spell_group_stack_rules VALUES (2008,1);

-- prayer of spirit, spirit, scroll of spirit
INSERT INTO spell_group VALUES (2009, 8112);
INSERT INTO spell_group_stack_rules VALUES (2009,1);

-- strength of earth totem, horn, str scroll
INSERT INTO spell_group values
(2010, 8076),
(2010, 57330),
(2010, 8115);
INSERT INTO spell_group_stack_rules VALUES (2010,1);

-- strength of earth totem, horn, agi scroll
INSERT INTO spell_group values
(2011, 8076),
(2011, 57330),
(2011, 8118);
INSERT INTO spell_group_stack_rules VALUES (2011,1);

-- might, battleshout, blessing of might
INSERT INTO spell_group values
(2012, 19740),
(2012, 6673);
INSERT INTO spell_group_stack_rules VALUES (2012,1);

-- Cleanup Spell Bonus Data
DELETE FROM `spell_bonus_data` WHERE `entry` IN ('50294');

-- Cleanup Creature Addons
DELETE FROM `creature_addon` WHERE `guid` IN
('238811','238819','239235','239375','239418','239434','239681',
 '239688','239798','239888','240000','240141','240276','240402',
 '240717','241476','241552','241822','242124','242185','242335',
 '258277','277867','277917','277963','277966','277985','278026',
 '278237','278309','278314','278326','278375','278413','278628',
 '278799','278811','278927','278930','278957','279126','279538',
 '279587','279606','279627','292924','302448','307770','307945',
 '308070','308107','308222','308612','308773','324188','324189',
 '324192','324194','324195','324198','324200','324209','324210',
 '324425','324426','324430','324431','324432','324433','324434',
 '324436','324437','324438','324441','324449','324880','324890',
 '325322','325323','325324','325540','325541','325542','325544',
 '325546','325547','325549','325550','325552','325553','325555',
 '325556','325558','325559','325561','325562','325564','325565',
 '325567','325568','325570','325571');

DELETE FROM `spell_script_names` WHERE `spell_id` IN ('58630','59046','59450','64899','64985','65074','65195','68184','68572','68574','69366','-50294','-33851','5604','5698','13161','-53303','-53304');
DELETE FROM spell_area WHERE spell=42316;

DELETE FROM `spell_linked_spell` WHERE `spell_effect` IN ('57339','57340');