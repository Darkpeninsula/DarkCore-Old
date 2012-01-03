-- Guild XP
ALTER TABLE `guild` ADD `m_today_xp` bigint(20) NOT NULL AFTER `level`;
ALTER TABLE `guild` ADD `m_xp_cap` bigint(20) NOT NULL AFTER `m_today_xp`;