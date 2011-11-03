DELETE FROM `command` WHERE `name` = 'remove dualspec';
INSERT INTO `command` (`name`, `security`, `help`) VALUES ('remove dualspec', 1, 'Syntax: .remove dualspec [$name]');