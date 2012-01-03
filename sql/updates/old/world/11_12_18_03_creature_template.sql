--Trolls give KillCredit for quest Zul'Mamwe Mambo=26405
UPDATE creature_template SET KillCredit1=43024 WHERE entry IN (1059, 783, 782, 42858, 781, 672, 784, 669, 670);

--Airwyn Bantamflax <Explorers' League> now not attack horde player
UPDATE creature_template SET unit_flags=131072 WHERE entry=44112;