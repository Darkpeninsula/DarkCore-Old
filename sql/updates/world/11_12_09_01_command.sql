-- Command
DELETE FROM command where name IN ('modify arena', 'modify justice', 'modify conquest');
INSERT INTO `command` VALUES ('modify conquest', 1, 'Syntax: .modify conquest #value');
INSERT INTO `command` VALUES ('modify justice', 1, 'Syntax: .modify justice #value');