--Add missing item into Renn's Supplies for quest Recover the Cargo!=27237
DELETE FROM item_loot_template WHERE entry=33045;
INSERT INTO item_loot_template VALUES
(33045, 33044, -100, 1, 0, 1, 1),
(33045, 33040, -100, 1, 0, 1, 1);