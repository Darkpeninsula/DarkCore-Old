--
-- Guild News
--

DROP TABLE IF EXISTS `guild_news`;
CREATE TABLE `guild_news` (
 `guildid` int(12) NOT NULL,
 `type` int(10) NOT NULL,
 `date` int(12) NOT NULL,
 `value1` int(10) NOT NULL,
 `value2` int(10) NOT NULL,
 `source_guid` int(12) NOT NULL,
 `flags` int(10) NOT NULL,
 PRIMARY KEY (`guildid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Bank Tabs
--

ALTER TABLE guild_member
ADD COLUMN `BankResetTimeTab6` int(10) unsigned NOT NULL DEFAULT '0' AFTER `BankRemSlotsTab5`,
ADD COLUMN `BankRemSlotsTab6` int(10) unsigned NOT NULL DEFAULT '0' AFTER `BankResetTimeTab6`,
ADD COLUMN `BankResetTimeTab7` int(10) unsigned NOT NULL DEFAULT '0' AFTER `BankRemSlotsTab6`,
ADD COLUMN `BankRemSlotsTab7` int(10) unsigned NOT NULL DEFAULT '0' AFTER `BankResetTimeTab7`;

--
-- Professions
--

ALTER TABLE `guild_member` ADD COLUMN `FirstProffLevel` int(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `BankRemSlotsTab7`;
ALTER TABLE `guild_member` ADD COLUMN `FirstProffSkill` int(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `FirstProffLevel`;
ALTER TABLE `guild_member` ADD COLUMN `FirstProffRank` int(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `FirstProffSkill`;
ALTER TABLE `guild_member` ADD COLUMN `SecondProffLevel` int(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `FirstProffRank`;
ALTER TABLE `guild_member` ADD COLUMN `SecondProffSkill` int(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `SecondProffLevel`;
ALTER TABLE `guild_member` ADD COLUMN `SecondProffRank` int(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `SecondProffSkill`;