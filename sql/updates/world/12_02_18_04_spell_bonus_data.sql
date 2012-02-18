DELETE FROM spell_bonus_data WHERE entry = 1978;
INSERT INTO spell_bonus_data(entry, dot_bonus, comments) VALUES (1978, 0.4, "Hunter - Serpent Sting");

DELETE FROM spell_script_names WHERE spell_id = 1978;
INSERT INTO spell_script_names (spell_id, scriptname) VALUES (1978, "spell_hun_serpent_sting");