-- Fear and Drain Life 
DELETE FROM `spell_script_names` WHERE `spell_id` IN ('5782','-5782','689','-689','89420','-89420');
INSERT INTO `spell_script_names` VALUES 
('5782','spell_warl_fear'),
('689','spell_warl_drain_life'),
('89420','spell_warl_drain_life');

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` = '6201';
INSERT INTO `spell_linked_spell` VALUES 
('6201','34130','0','Create Healthstone');

-- Removed Deprecated Spell
DELETE FROM `spell_script_names` WHERE `spell_id` = '47201';