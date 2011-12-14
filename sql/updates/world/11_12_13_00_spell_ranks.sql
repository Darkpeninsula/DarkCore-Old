-- Fix Lifeblood Rk 8 (525/525 Herbalism) 
-- (this also fixes the Herbalism graphic bug in profession tab)
DELETE FROM spell_ranks WHERE first_spell_id=81708 AND rank=8;
INSERT INTO spell_ranks VALUES (81708, 74497, 8); -- lifeblood, rank 8;