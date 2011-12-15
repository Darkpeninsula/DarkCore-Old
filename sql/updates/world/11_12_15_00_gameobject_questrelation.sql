--Remove relations between gameobject and deprecated (bugged) quest 586=Speaking with Gan'zulah and 1261=Marg Speaks
DELETE FROM gameobject_questrelation WHERE quest=586;
DELETE FROM gameobject_questrelation WHERE quest=1261;