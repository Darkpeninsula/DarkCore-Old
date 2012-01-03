--All fix are for quest for quest Slap and Cap=28336

--Update npc Panicking Worker fields
UPDATE creature_template SET gossip_menu_id=48331, npcflag=3, iconName='', minlevel=48, maxlevel=49, faction_A=2159, faction_H=2159, mindmg=112, maxdmg=112, attackpower=206, baseattacktime=2000, AIName='SmartAI' WHERE entry=48331;

--Add missing npc Panicking Worker=48331
DELETE FROM creature WHERE id=48331;
INSERT INTO creature VALUES
(NULL, 48331, 1, 1, 1, 0, 0, 6662.397949, -1297.142944, 461.761932, 1.518870, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6627.151855, -1223.132080, 455.009979, 1.664954, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6534.845703, -1247.815552, 439.282715, 2.887819, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6505.854492, -1322.266113, 439.246796, 4.336881, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6507.595215, -1386.960571, 436.580505, 5.547959, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6532.032227, -1400.688477, 438.122681, 6.093809, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6536.717285, -1431.493286, 439.412537, 5.289559, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6501.050293, -1440.262085, 436.954498, 3.406174, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6498.016113, -1475.270386, 438.808502, 4.614117, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6536.031738, -1504.517578, 439.340698, 5.686187, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6557.433105, -1487.563843, 443.503296, 0.995788, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6603.168945, -1501.749023, 474.231934, 4.785340, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6608.217773, -1592.673706, 488.089600, 6.197480, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6594.481934, -1624.864014, 494.694458, 4.316453, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6550.535156, -1650.498779, 500.445953, 4.316453, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0),
(NULL, 48331, 1, 1, 1, 0, 0, 6774.258301, -1604.991699, 482.745056, 5.760010, 300, 0, 0, 2062, 0, 0, 0, 0, 0, 0);

--Add gossip_menu
DELETE FROM gossip_menu WHERE entry=48331;
INSERT INTO gossip_menu VALUES
(48331, 48331);

--Add gossip_menu_option
DELETE FROM gossip_menu_option WHERE menu_id=48331;
INSERT INTO gossip_menu_option VALUES
(48331, 0, 0, 'Calm down stupid goblin. Returns to work, i can be more dangerous of a Wargen. <Slaps Panicking Worker>', 1, 1, 0, 0, 0, 0, 0, NULL);

--Add npc_text
DELETE FROM npc_text WHERE id=48331;
INSERT INTO npc_text VALUES
(48331, 'I''m scared, i can''t work. There are a lots of Worgen in this zone; i''ve seen their footstep.', NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 1);

--Add smart_scripts to npc Panicking Worker
DELETE FROM smart_scripts WHERE entryorguid=48331;
INSERT INTO smart_scripts VALUES
(48331, 0, 0, 1, 62, 0, 100, 0, 48331, 0, 0, 0, 72, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'close gossip'),
(48331, 0, 1, 2, 61, 0, 100, 1, 0, 0, 0, 0, 33, 48331, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'quest objective...'),
(48331, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'despawn');

--Add conditions
DELETE FROM conditions WHERE SourceGroup=48331;
INSERT INTO conditions VALUES
(15, 48331, 0, 0, 9, 28336, 0, 0, 0, '', 'Gossip Menu Option not visible without quest taken');