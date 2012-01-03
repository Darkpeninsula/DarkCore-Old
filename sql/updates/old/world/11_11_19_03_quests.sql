-- Fix quest-requirements for "A Meeting With Fate"
UPDATE quest_template SET RequiredRaces=690 WHERE entry=12755;

-- Fix tailoring quest "Cloth Scavenging"
UPDATE quest_template SET SkillOrClassMask=197, RequiredSkillValue=350 WHERE entry=13270;