--Fix faction to Cyrukh the Firelord <The Dirge of Karabor>, objective for The Cipher of Damnation=10588
UPDATE creature_template SET faction_A=16, faction_H=16 WHERE entry=21181;

--Add missing npc Osborn Obnoticus and fix his faction
UPDATE creature_template SET faction_A=23, faction_H=23, baseattacktime=2000, flags_extra=2 WHERE entry=43884;
DELETE FROM creature WHERE id=43884;
INSERT INTO creature VALUES
(NULL, 43884, 0, 1, 1, 0, 0, -11307.420898, -194.072113, 75.411751, 3.078344, 300, 0, 0, 773, 811, 0, 0, 0, 0, 0);

--Add missing npc General Twinbraid and fix his faction
UPDATE creature_template SET minlevel=37, maxlevel=37, faction_A=55, faction_H=55, baseattacktime=2000, flags_extra=2 WHERE entry=39118;
DELETE FROM creature WHERE id=39118;
INSERT INTO creature VALUES
(NULL, 39118, 1, 1, 1, 0, 0, -3623.906982, 1886.854370, 91.670166, 5.350297, 300, 0, 0, 4008, 0, 0, 0, 0, 0, 0);

--Fix not targetable o not attaccable npc for quest Words of Power=11942
UPDATE creature_template SET npcflag=0, unit_flags=0 WHERE entry IN (25392, 26076, 26073);