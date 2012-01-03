-- Update Dual Talent Cost: 1000g -> 10g + fixed a little typo
UPDATE gossip_menu_option SET option_text="Purchase a Dual Talent Specialization" WHERE option_text="Purchase a Dual Talent Specialization.";
UPDATE gossip_menu_option SET box_money=100000 WHERE option_text="Purchase a Dual Talent Specialization" AND box_money=10000000;