--Removed invisibility aura from Megs Dreadshredder <Bilgewater Cartel> 
UPDATE creature_template_addon SET auras='' WHERE entry=38534;

--Removed invisibility aura from Jurrix Whitemane <Bad Dogs>=47018, Gargal <Bad Dogs>=47013,  Amakkar <Bad Dogs>=47011
UPDATE creature_template_addon SET auras='' WHERE entry IN (47018, 47013, 47011);

--Removed invisibility aura from Lunk=47269
UPDATE creature_template_addon SET auras='' WHERE entry=47269;

