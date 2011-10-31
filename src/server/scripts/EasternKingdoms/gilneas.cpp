/*
 * Copyright (C) 2005-2011 MaNGOS <http://www.getmangos.com/>
 * Copyright (C) 2008-2011 Trinity <http://www.trinitycore.org/>
 * Copyright (C) 2010-2011 Project SkyFire <http://www.projectskyfire.org/>
 * Copyright (C) 2011-2012 Darkpeninsula Project <http://www.darkpeninsula.eu/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

/* ScriptData
Name: Gilneas City
%Complete: 10
Comment: 
Category: Gilneas
EndScriptData */

/* ContentData
TODO
EndContentData */

#include "ScriptPCH.h"

//Phase 1
enum eGilneasCityPhase1
{
    //Quests
    QUEST_LOCKDOWN = 14078,

    //Spells
    SPELL_PHASE_2 = 59073,

    //Say
    SAY_PRINCE_LIAM_GREYMANE_1 = -1638000,
    SAY_PRINCE_LIAM_GREYMANE_2 = -1638001,
    SAY_PRINCE_LIAM_GREYMANE_3 = -1638002,
    DELAY_SAY_PRINCE_LIAM_GREYMANE = 20000, //20 seconds repetition time

    SAY_PANICKED_CITIZEN_1 = -1638016,
    SAY_PANICKED_CITIZEN_2 = -1638017,
    SAY_PANICKED_CITIZEN_3 = -1638018,
    SAY_PANICKED_CITIZEN_4 = -1638019,
    #define DELAY_EMOTE_PANICKED_CITIZEN urand(5000, 15000) //5-15 second time
    #define DELAY_SAY_PANICKED_CITIZEN urand(30000, 120000) //30sec - 1.5min

    SAY_GILNEAS_CITY_GUARD_GATE_1 = -1638022,
    SAY_GILNEAS_CITY_GUARD_GATE_2 = -1638023,
    SAY_GILNEAS_CITY_GUARD_GATE_3 = -1638024,
    #define DELAY_SAY_GILNEAS_CITY_GUARD_GATE urand(30000, 120000) //30sec - 1.5min
};
//Phase 2
enum eGilneasCityPhase2
{
    //Sounds
    SOUND_SWORD_FLESH = 143,
    SOUND_SWORD_PLATE = 147,
    DELAY_SOUND = 500,
    DELAY_ANIMATE = 2000,

    //Spells
    SPELL_PHASE_4 = 59074,
    
    //NPCs
    NPC_PRINCE_LIAM_GREYMANE = 34913,
    NPC_GILNEAS_CITY_GUARD = 34916,
    NPC_RAMPAGING_WORGEN_1 = 34884,
    NPC_RAMPAGING_WORGEN_2 = 35660,
    NPC_FRIGHTENED_CITIZEN_1 = 34981,
    NPC_FRIGHTENED_CITIZEN_2 = 35836,

    //Say
    YELL_PRINCE_LIAM_GREYMANE_1 = -1638025,
    YELL_PRINCE_LIAM_GREYMANE_2 = -1638026,
    YELL_PRINCE_LIAM_GREYMANE_3 = -1638027,
    YELL_PRINCE_LIAM_GREYMANE_4 = -1638028,
    YELL_PRINCE_LIAM_GREYMANE_5 = -1638029,
    DELAY_YELL_PRINCE_LIAM_GREYMANE = 2000,
};

/*######
## npc_prince_liam_greymane_phase1
######*/

class npc_prince_liam_greymane_phase1 : public CreatureScript
{
public:
    npc_prince_liam_greymane_phase1() : CreatureScript("npc_prince_liam_greymane_phase1") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_prince_liam_greymane_phase1AI (pCreature);
    }

    struct npc_prince_liam_greymane_phase1AI : public ScriptedAI
    {
        npc_prince_liam_greymane_phase1AI(Creature *c) : ScriptedAI(c) {}

        uint32 tSay; //Time left for say
        uint32 cSay; //Current Say

        //Evade or Respawn
        void Reset()
        {
            tSay = DELAY_SAY_PRINCE_LIAM_GREYMANE; //Reset timer
            cSay = 1; //Start from 1
        }

        //Timed events
        void UpdateAI(const uint32 diff)
        {
            //Out of combat
            if (!me->getVictim())
            {
                //Timed say
                if (tSay <= diff)
                {
                    switch(cSay)
                    {
                        default:
                        case 1:
                            DoScriptText(SAY_PRINCE_LIAM_GREYMANE_1, me);
                            cSay++;
                            break;
                        case 2:
                            DoScriptText(SAY_PRINCE_LIAM_GREYMANE_2, me);
                            cSay++;
                            break;
                        case 3:
                            DoScriptText(SAY_PRINCE_LIAM_GREYMANE_3, me);
                            cSay = 1; //Reset to 1
                            break;
                    }

                    tSay = DELAY_SAY_PRINCE_LIAM_GREYMANE; //Reset the timer
                }
                else
                {
                    tSay -= diff;
                }
                return;
            }
        }
    };
};

/*######
## npc_panicked_citizen
######*/

uint32 guid_panicked_nextsay = 0; //GUID of the Panicked Citizen that will say random text, this is to prevent more than 1 npc speaking
uint32 tSay_panicked = DELAY_SAY_PANICKED_CITIZEN; //Time left to say
class npc_panicked_citizen : public CreatureScript
{
public:
    npc_panicked_citizen() : CreatureScript("npc_panicked_citizen") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_panicked_citizenAI (pCreature);
    }

    struct npc_panicked_citizenAI : public ScriptedAI
    {
        npc_panicked_citizenAI(Creature *c) : ScriptedAI(c) {}
        
        uint32 tEmote; //Time left for doing an emote

        //Evade or Respawn
        void Reset()
        {
            if (me->GetPhaseMask() == 1)
            {
                tEmote = DELAY_EMOTE_PANICKED_CITIZEN; //Reset timer
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0); //Reset emote state
            }
        }
        
        void UpdateAI(const uint32 diff)
        {
            //Out of combat and in Phase 1
            if (!me->getVictim() && me->GetPhaseMask() == 1)
            {
                //Timed emote
                if(tEmote <= diff)
                {
                    //Do random emote (1, 5, 18, 20, 430)
                    me->HandleEmoteCommand(RAND(
                        EMOTE_ONESHOT_TALK,
                        EMOTE_ONESHOT_EXCLAMATION,
                        EMOTE_ONESHOT_CRY,
                        EMOTE_ONESHOT_BEG,
                        EMOTE_ONESHOT_COWER));

                    tEmote = DELAY_EMOTE_PANICKED_CITIZEN; //Reset timer
                }
                else
                {
                    tEmote -= diff;
                }

                //Randomly select an NPC to say the next random text
                if(!guid_panicked_nextsay)
                {
                    if(urand(0,1))
                    {
                        guid_panicked_nextsay = me->GetGUIDLow();
                    }
                }

                //If this is the selected npc to say
                if(guid_panicked_nextsay == me->GetGUIDLow())
                {
                    //Timed say
                    if(tSay_panicked <= diff)
                    {
                    
                        //Say random
                        DoScriptText(RAND(
                            SAY_PANICKED_CITIZEN_1,
                            SAY_PANICKED_CITIZEN_2,
                            SAY_PANICKED_CITIZEN_3,
                            SAY_PANICKED_CITIZEN_4), 
                        me);

                        guid_panicked_nextsay = 0; //Reset Selected next NPC
                        tSay_panicked = DELAY_SAY_PANICKED_CITIZEN; //Reset timer
                    }
                    else
                    {
                        tSay_panicked -= diff;
                    }
                }
            }
        }
    };

};

/*######
## npc_panicked_citizen_2
######*/

enum ePanicked_citizen_2
{
    #define PATHS_COUNT_PANICKED_CITIZEN 8
};

struct Waypoint
{
    uint32 pathID;
    float x, y;
};

class npc_panicked_citizen_2 : public CreatureScript
{
public:
    npc_panicked_citizen_2() : CreatureScript("npc_panicked_citizen_2") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_panicked_citizen_2AI (pCreature);
    }

    struct npc_panicked_citizen_2AI : public ScriptedAI
    {
        npc_panicked_citizen_2AI(Creature *c) : ScriptedAI(c) {}

        bool running, onceRun;
        uint32 pathID, runDelay;
        Waypoint firstWaypoints[PATHS_COUNT_PANICKED_CITIZEN];

        void LoadWaypoints(Waypoint *waypoints)
        {
            QueryResult result[PATHS_COUNT_PANICKED_CITIZEN];
            result[0] = WorldDatabase.Query("SELECT `id`, `position_x`, `position_y` FROM waypoint_data WHERE id = 34851000 and `point` = 1");
            result[1] = WorldDatabase.Query("SELECT `id`, `position_x`, `position_y` FROM waypoint_data WHERE id = 34851001 and `point` = 1");
            result[2] = WorldDatabase.Query("SELECT `id`, `position_x`, `position_y` FROM waypoint_data WHERE id = 34851002 and `point` = 1");
            result[3] = WorldDatabase.Query("SELECT `id`, `position_x`, `position_y` FROM waypoint_data WHERE id = 34851003 and `point` = 1");
            result[4] = WorldDatabase.Query("SELECT `id`, `position_x`, `position_y` FROM waypoint_data WHERE id = 34851004 and `point` = 1");
            result[5] = WorldDatabase.Query("SELECT `id`, `position_x`, `position_y` FROM waypoint_data WHERE id = 34851005 and `point` = 1");
            result[6] = WorldDatabase.Query("SELECT `id`, `position_x`, `position_y` FROM waypoint_data WHERE id = 34851006 and `point` = 1");
            result[7] = WorldDatabase.Query("SELECT `id`, `position_x`, `position_y` FROM waypoint_data WHERE id = 34851007 and `point` = 1");

            for (uint8 i = 0; i < PATHS_COUNT_PANICKED_CITIZEN; i ++)
            {
                Field* pFields = result[i]->Fetch();
                waypoints[i].pathID = pFields[0].GetUInt32();
                waypoints[i].x = pFields[1].GetFloat();
                waypoints[i].y = pFields[2].GetFloat();
            }
        }

        uint32 FindNearestPath(Waypoint *paths)
        {
            uint32 pathIDs[PATHS_COUNT_PANICKED_CITIZEN], nearestPathID;
            float distances[PATHS_COUNT_PANICKED_CITIZEN], minDist;

            for (uint8 i = 0; i < PATHS_COUNT_PANICKED_CITIZEN; i ++)
            {
                distances[i] = me->GetDistance2d(paths[i].x, paths[i].y);
                pathIDs[i] = paths[i].pathID;
            }
            for (uint8 i = 0; i < PATHS_COUNT_PANICKED_CITIZEN; i ++)
            {
                if (i == 0)
                {
                    minDist = distances[i];
                    nearestPathID = pathIDs[i];
                }
                else if (minDist > distances[i])
                {
                    minDist = distances[i];
                    nearestPathID = pathIDs[i];
                }
            }
            return nearestPathID;
        }

        void Reset()
        {
            me->Respawn(1);
        }

        void JustRespawned()
        {
            if (me->GetDefaultMovementType() == WAYPOINT_MOTION_TYPE) 
            {
                me->SetUInt32Value(UNIT_NPC_EMOTESTATE, 0);
                runDelay = urand(2000, 8000);
                running = true;
                onceRun = true;
            }
            else running = false;
            
        }

        void UpdateAI(const uint32 diff)
        {
            if (running)
            {
                if (runDelay <= diff && onceRun)
                {
                    LoadWaypoints(firstWaypoints);
                    pathID = FindNearestPath(firstWaypoints);
                    me->GetMotionMaster()->MovePath(pathID, false);
                    me->HandleEmoteCommand(EMOTE_ONESHOT_COWER);
                    onceRun = false;
                }
                else runDelay -= diff;
            }
        }
    };
};

/*######
## npc_lieutenant_walden
######*/

class npc_lieutenant_walden : public CreatureScript
{
public:
    npc_lieutenant_walden() : CreatureScript("npc_lieutenant_walden") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_lieutenant_waldenAI (pCreature);
    }

    struct npc_lieutenant_waldenAI : public ScriptedAI
    {
        npc_lieutenant_waldenAI(Creature *c) : ScriptedAI(c) {}
        
        void sQuestReward(Player *pPlayer, const Quest *pQuest, uint32 data)
        {
            if (pQuest->GetQuestId() == QUEST_LOCKDOWN && pPlayer->GetPhaseMask() == 1)
                pPlayer->SetAuraStack(SPELL_PHASE_2, pPlayer, 1); //phaseshift
        }
    };

};

/*######
## npc_gilneas_city_guard_phase1
######*/
class npc_gilneas_city_guard_phase1 : public CreatureScript
{
public:
    npc_gilneas_city_guard_phase1() : CreatureScript("npc_gilneas_city_guard_phase1") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_gilneas_city_guard_phase1AI (pCreature);
    }

    struct npc_gilneas_city_guard_phase1AI : public ScriptedAI
    {
        npc_gilneas_city_guard_phase1AI(Creature *c) : ScriptedAI(c) {}
        
        uint32 tSay; //Time left for say

        //Evade or Respawn
        void Reset()
        {
            if (me->GetGUIDLow() == 3486400)
            {
                tSay = DELAY_SAY_GILNEAS_CITY_GUARD_GATE; //Reset timer
            }
        }
        
        void UpdateAI(const uint32 diff)
        {
            //Out of combat and
            if (me->GetGUIDLow() == 3486400)
            {
                //Timed say
                if(tSay <= diff)
                {
                    //Random say
                    DoScriptText(RAND(
                        SAY_GILNEAS_CITY_GUARD_GATE_1,
                        SAY_GILNEAS_CITY_GUARD_GATE_2,
                        SAY_GILNEAS_CITY_GUARD_GATE_3),
                    me);

                    tSay = DELAY_SAY_GILNEAS_CITY_GUARD_GATE; //Reset timer
                }
                else
                {
                    tSay -= diff;
                }
            }
        }
    };

};

/*######
## npc_gilneas_city_guard_phase2
######*/

class npc_gilneas_city_guard_phase2 : public CreatureScript
{
public:
    npc_gilneas_city_guard_phase2() : CreatureScript("npc_gilneas_city_guard_phase2") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_gilneas_city_guard_phase2AI (pCreature);
    }

    struct npc_gilneas_city_guard_phase2AI : public ScriptedAI
    {
        npc_gilneas_city_guard_phase2AI(Creature *c) : ScriptedAI(c) {}

        uint32 tAnimate, tSound, dmgCount, tSeek;
        bool playSnd;

        void Reset()
        {
            tAnimate = DELAY_ANIMATE;
            dmgCount = 0;
            tSound = DELAY_SOUND;
            playSnd = false;
            tSeek = urand(1000, 2000);
        }

        void DamageTaken(Unit * pWho, uint32 &uiDamage)
        {
            if (pWho->GetTypeId() == TYPEID_PLAYER)
            {
                me->getThreatManager().resetAllAggro();
                pWho->AddThreat(me, 1.0f);
                me->AddThreat(pWho, 1.0f);
                me->AI()->AttackStart(pWho);
                dmgCount = 0;
            }
            else if (pWho->isPet())
            {
                me->getThreatManager().resetAllAggro();
                me->AddThreat(pWho, 1.0f);
                me->AI()->AttackStart(pWho);
                dmgCount = 0;
            }
        }

        void DamageDealt(Unit* target, uint32& damage, DamageEffectType damageType)
        {
            if (target->GetEntry() == NPC_RAMPAGING_WORGEN_1)
                dmgCount ++;
        }

        void UpdateAI(const uint32 diff)
        {
            if (tSeek <= diff)
            {
                if ((me->isAlive()) && (!me->isInCombat() && (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) <= 1.0f)))
                    if (Creature* enemy = me->FindNearestCreature(NPC_RAMPAGING_WORGEN_1, 16.0f, true))
                        me->AI()->AttackStart(enemy);
                tSeek = urand(1000, 2000); //optimize cpu load, seeking only sometime between 1 and 2 seconds
            }
            else tSeek -= diff;

            if (!UpdateVictim())
                return;

            if (tSound <= diff)
            {
                me->PlayDistanceSound(SOUND_SWORD_FLESH);
                tSound = DELAY_SOUND;
                playSnd = false;
            }

            if (playSnd == true) tSound -= diff;

            if (dmgCount < 2)
                DoMeleeAttackIfReady();
            else if (me->getVictim()->GetTypeId() == TYPEID_PLAYER) dmgCount = 0;
            else if (me->getVictim()->isPet()) dmgCount = 0;
            else
            {
                if (tAnimate <= diff)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
                    playSnd = true;
                    tAnimate = DELAY_ANIMATE;
                }
                else
                    tAnimate -= diff;
                
            }
        }
    };

};

/*######
## npc_prince_liam_greymane_phase2
######*/

class npc_prince_liam_greymane_phase2 : public CreatureScript
{
public:
    npc_prince_liam_greymane_phase2() : CreatureScript("npc_prince_liam_greymane_phase2") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_prince_liam_greymane_phase2AI (pCreature);
    }

    struct npc_prince_liam_greymane_phase2AI : public ScriptedAI
    {
        npc_prince_liam_greymane_phase2AI(Creature *c) : ScriptedAI(c) {}

        uint32 tAnimate, tSound, dmgCount, tYell, tSeek;
        bool playSnd, doYell;

        void Reset()
        {
            tAnimate = DELAY_ANIMATE;
            dmgCount = 0;
            tSound = DELAY_SOUND;
            playSnd = false;
            tSeek = urand(1000, 2000);
            doYell = true;
            tYell = DELAY_YELL_PRINCE_LIAM_GREYMANE;
        }
        
        void sGossipHello(Player *pPlayer)
        {
            if ((pPlayer->GetQuestStatus(14094) == QUEST_STATUS_REWARDED) && (pPlayer->GetPhaseMask() == 2))
                pPlayer->SetAuraStack(SPELL_PHASE_4, pPlayer, 1); //phaseshift
        }

        void DamageTaken(Unit * pWho, uint32 &uiDamage)
        {
            if (pWho->GetTypeId() == TYPEID_PLAYER)
            {
                me->getThreatManager().resetAllAggro();
                pWho->AddThreat(me, 1.0f);
                me->AddThreat(pWho, 1.0f);
                me->AI()->AttackStart(pWho);
                dmgCount = 0;
            }
            else if (pWho->isPet())
            {
                me->getThreatManager().resetAllAggro();
                me->AddThreat(pWho, 1.0f);
                me->AI()->AttackStart(pWho);
                dmgCount = 0;
            }
        }

        void DamageDealt(Unit* target, uint32& damage, DamageEffectType damageType)
        {
            if (target->GetEntry() == NPC_RAMPAGING_WORGEN_1)
                dmgCount ++;
        }

        void UpdateAI(const uint32 diff)
        {
            //If creature has no target
            if (!UpdateVictim())
            {
                if (tSeek <= diff)
                {
                    //Find worgen nearby
                    if (me->isAlive() && !me->isInCombat() && (me->GetDistance2d(me->GetHomePosition().GetPositionX(), me->GetHomePosition().GetPositionY()) <= 1.0f))
                        if (Creature* enemy = me->FindNearestCreature(NPC_RAMPAGING_WORGEN_1, 16.0f, true))
                            me->AI()->AttackStart(enemy);
                    tSeek = urand(1000, 2000);//optimize cpu load
                }
                else tSeek -= diff;

                //Yell only once after Reset()
                if(doYell)
                {
                    //Yell Timer
                    if(tYell <= diff)
                    {
                        //Random yell
                        DoScriptText(RAND(
                            YELL_PRINCE_LIAM_GREYMANE_1,
                            YELL_PRINCE_LIAM_GREYMANE_2,
                            YELL_PRINCE_LIAM_GREYMANE_3,
                            YELL_PRINCE_LIAM_GREYMANE_4,
                            YELL_PRINCE_LIAM_GREYMANE_5),
                        me);

                        doYell = false;
                    }
                    else
                        tYell -= diff;
                }
            }
            else
            {
                //Play sword attack sound
                if (tSound <= diff)
                {
                    me->PlayDistanceSound(SOUND_SWORD_FLESH);
                    tSound = DELAY_SOUND;
                    playSnd = false;
                }

                if (playSnd == true) tSound -= diff;

                //Attack
                if (dmgCount < 2)
                    DoMeleeAttackIfReady();
                else if (me->getVictim()->GetTypeId() == TYPEID_PLAYER) dmgCount = 0;
                else if (me->getVictim()->isPet()) dmgCount = 0;
                else
                {
                    if (tAnimate <= diff)
                    {
                        me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
                        playSnd = true;
                        tAnimate = DELAY_ANIMATE;
                    }
                    else
                        tAnimate -= diff;
                
                }

                //Stop yell timer on combat
                doYell = false;
            }
        }
    };

};

/*######
## npc_rampaging_worgen
######*/

enum eRampaging_worgen
{
    #define SPELL_ENRAGE 8599
    #define CD_ENRAGE 30000
};

class npc_rampaging_worgen : public CreatureScript
{
public:
    npc_rampaging_worgen() : CreatureScript("npc_rampaging_worgen") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_rampaging_worgenAI (pCreature);
    }

    struct npc_rampaging_worgenAI : public ScriptedAI
    {
        npc_rampaging_worgenAI(Creature *c) : ScriptedAI(c) {}

        uint32 tEnrage;
        uint32 dmgCount;
        uint32 tAnimate;
        uint32 tSound;
        bool playSound, willCastEnrage;
        
        void Reset()
        {
            tEnrage = 0;
            dmgCount = 0;
            tAnimate = DELAY_ANIMATE;
            tSound = DELAY_SOUND;
            playSound = false;
            willCastEnrage = urand(0, 1);
        }

        void DamageDealt(Unit* target, uint32& damage, DamageEffectType damageType)
        {
            if (target->GetEntry() == NPC_GILNEAS_CITY_GUARD || target->GetEntry() == NPC_PRINCE_LIAM_GREYMANE)
                dmgCount ++;
        }

        void DamageTaken(Unit * pWho, uint32 &uiDamage)
        {
            if (pWho->GetTypeId() == TYPEID_PLAYER)
            {
                me->getThreatManager().resetAllAggro();
                pWho->AddThreat(me, 1.0f);
                me->AddThreat(pWho, 1.0f);
                me->AI()->AttackStart(pWho);
                dmgCount = 0;
            }
            else if (pWho->isPet())
            {
                me->getThreatManager().resetAllAggro();
                me->AddThreat(pWho, 1.0f);
                me->AI()->AttackStart(pWho);
                dmgCount = 0;
            }
        }
        
        void UpdateAI(const uint32 diff)
        {
            if (!UpdateVictim())
                return;

            if (tEnrage <= diff && willCastEnrage)
            {
                if (me->GetHealthPct() <= 30)
                {
                    me->MonsterTextEmote(-106, 0);
                    DoCast(me, SPELL_ENRAGE);
                    tEnrage = CD_ENRAGE;
                }
            }
            else tEnrage -= diff;

            //play attack sound
            if (playSound == true) tSound -= diff;

            if (tSound <= diff)
            {
                me->PlayDistanceSound(SOUND_SWORD_PLATE);
                tSound = DELAY_SOUND;
                playSound = false;
            }
            
            if (dmgCount < 2)
                DoMeleeAttackIfReady();
            else if (me->getVictim()->GetTypeId() == TYPEID_PLAYER) dmgCount = 0;
            else if (me->getVictim()->isPet()) dmgCount = 0;
            else
            {
                if (tAnimate <= diff)
                {
                    me->HandleEmoteCommand(EMOTE_ONESHOT_ATTACKUNARMED);
                    tAnimate = DELAY_ANIMATE;
                    playSound = true;
                }
                else
                tAnimate -= diff;
            }
            
        }
    };

};

class npc_rampaging_worgen2 : public CreatureScript
{
public:
    npc_rampaging_worgen2() : CreatureScript("npc_rampaging_worgen2") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_rampaging_worgen2AI (pCreature);
    }

    struct npc_rampaging_worgen2AI : public ScriptedAI
    {
        npc_rampaging_worgen2AI(Creature *c) : ScriptedAI(c) {}

        uint16 tRun, tEnrage;
        bool onceRun, willCastEnrage;
        float x, y, z;

        void JustRespawned()
        {
            tEnrage = 0;
            tRun = 500;
            onceRun = true;
            x = me->m_positionX+cos(me->m_orientation)*8;
            y = me->m_positionY+sin(me->m_orientation)*8;
            z = me->m_positionZ;
            willCastEnrage = urand(0, 1);
        }

        void UpdateAI(const uint32 diff)
        {
            if (tRun <= diff && onceRun)
            {
                me->GetMotionMaster()->MoveCharge(x, y, z, 8);
                onceRun = false;
            }
            else tRun -= diff;

            if (!UpdateVictim())
                return;

            if (tEnrage <= diff)
            {
                if (me->GetHealthPct() <= 30 && willCastEnrage)
                {
                    me->MonsterTextEmote(-106, 0);
                    DoCast(me, SPELL_ENRAGE);
                    tEnrage = CD_ENRAGE;
                }
            }
            else tEnrage -= diff;

            DoMeleeAttackIfReady();
        }
    };

};

/*######
## go_merchant_square_door
######*/

enum eMerchant_square_door
{
    #define SUMMON1_TTL 300000
    #define QUEST_EVAC_MERC_SQUA 14098
};

class go_merchant_square_door : public GameObjectScript
{
public:
    go_merchant_square_door() : GameObjectScript("go_merchant_square_door") { }

    float x, y, z, wx, wy, angle;
    uint8 spawnKind;
    GameObject* pGO;

    bool OnGossipHello(Player *pPlayer, GameObject *pGO)
    {
        if (pPlayer->GetQuestStatus(QUEST_EVAC_MERC_SQUA) == QUEST_STATUS_INCOMPLETE)
        {
            pGO->Use(pPlayer);
            spawnKind = urand(1, 3); //1,2=citizen, 3=citizen&worgen (66%,33%)
            angle=pGO->GetOrientation();
            x=pGO->GetPositionX()-cos(angle)*2;
            y=pGO->GetPositionY()-sin(angle)*2;
            z=pGO->GetPositionZ();
            wx = x-cos(angle)*2;
            wy = y-sin(angle)*2;
            
            if (spawnKind < 3)
            {
                if (Creature *spawnedCreature = pGO->SummonCreature(NPC_FRIGHTENED_CITIZEN_1,x,y,z,angle,TEMPSUMMON_TIMED_DESPAWN,SUMMON1_TTL))
                {
                    spawnedCreature->SetPhaseMask(6, 1);
                    spawnedCreature->Respawn(1);
                }
            }
            else
            {
                if (Creature *spawnedCitizen = pGO->SummonCreature(NPC_FRIGHTENED_CITIZEN_2,x,y,z,angle,TEMPSUMMON_TIMED_DESPAWN,SUMMON1_TTL))
                {
                    spawnedCitizen->SetPhaseMask(6, 1);
                    spawnedCitizen->Respawn(1);
                    if (Creature *spawnedWorgen = pGO->SummonCreature(NPC_RAMPAGING_WORGEN_2,wx,wy,z,angle,TEMPSUMMON_TIMED_DESPAWN,SUMMON1_TTL))
                    {
                        spawnedWorgen->SetPhaseMask(6, 1);
                        spawnedWorgen->Respawn(1);
                        spawnedWorgen->AddThreat(spawnedCitizen, 1.0f);
                        spawnedWorgen->AddThreat(pPlayer, 1.0f);
                     }
                }
            }
            pPlayer->KilledMonsterCredit(35830, 0);
            return true;
        }   
        return false;
    }
};

/*######
## npc_frightened_citizen
######*/

enum eFrightened_citizen
{
    SAY_CITIZEN_1 = -1638003,
    SAY_CITIZEN_2 = -1638004,
    SAY_CITIZEN_3 = -1638005,
    SAY_CITIZEN_4 = -1638006,
    SAY_CITIZEN_5 = -1638007,
    SAY_CITIZEN_6 = -1638008,
    SAY_CITIZEN_7 = -1638009,
    SAY_CITIZEN_8 = -1638010,
    SAY_CITIZEN_1b = -1638011,
    SAY_CITIZEN_2b = -1638012,
    SAY_CITIZEN_3b = -1638013,
    SAY_CITIZEN_4b = -1638014,
    SAY_CITIZEN_5b = -1638015,
    #define PATHS_COUNT 2
};

struct Point
{
    float x, y;
};

struct WayPointID
{
    int pathID, pointID;
};

struct Paths
{
    uint8 pointsCount[8];//pathID, pointsCount
    Point paths[8][10];//pathID, pointID, Point
};

class npc_frightened_citizen : public CreatureScript
{
public:
    npc_frightened_citizen() : CreatureScript("npc_frightened_citizen") { }

    CreatureAI* GetAI(Creature* pCreature) const
    {
        return new npc_frightened_citizenAI (pCreature);
    }

    struct npc_frightened_citizenAI : public ScriptedAI
    {
        npc_frightened_citizenAI(Creature *c) : ScriptedAI(c) {}

        uint16 tRun, tRun2, tSay;
        bool onceRun, onceRun2, onceGet, onceSay;
        float x, y, z;
        WayPointID nearestPointID;
        Paths paths;
        
        Paths LoadPaths()
        {
            Paths paths;
            QueryResult result[PATHS_COUNT];
            result[0] = WorldDatabase.Query("SELECT `id`, `point`, `position_x`, `position_y` FROM waypoint_data WHERE id = 349810 ORDER BY `point`");
            result[1] = WorldDatabase.Query("SELECT `id`, `point`, `position_x`, `position_y` FROM waypoint_data WHERE id = 349811 ORDER BY `point`");
            if (result[0]) paths.pointsCount[0] = result[0]->GetRowCount();
            else
            {
                sLog->outError("waypoint_data for frightened citizen missing");
                return paths;
            }
            if (result[1]) paths.pointsCount[1] = result[1]->GetRowCount();
            else
            {
                sLog->outError("waypoint_data for frightened citizen missing");
                return paths;
            }
            uint8 j;
            for (uint8 i = 0; i < PATHS_COUNT; i ++)
            {
                j = 0;
                do
                {
                    Field* pFields = result[i]->Fetch();
                    paths.paths[i][j].x = pFields[2].GetFloat();
                    paths.paths[i][j].y = pFields[3].GetFloat();
                    j++;
                }
                while (result[i]->NextRow());
            }

            return paths;
        }

        void MultiDistanceMeter(Point *p, uint8 pointsCount, float *dist)
        {
            for (uint8 i = 0; i <= (pointsCount-1); i++)
            {
                dist[i] = me->GetDistance2d(p[i].x, p[i].y);
            }
        }

        WayPointID GetNearestPoint(Paths paths)
        {
            WayPointID nearestPointID;
            float dist[PATHS_COUNT][10], lowestDists[PATHS_COUNT];
            uint8 nearestPointsID[PATHS_COUNT], lowestDist;
            for (uint8 i = 0; i <= PATHS_COUNT-1; i++)
            {
                MultiDistanceMeter(paths.paths[i], paths.pointsCount[i], dist[i]);
                for (uint8 j = 0; j <= paths.pointsCount[i]-1; j++)
                {
                    if (j == 0)
                    {
                        lowestDists[i] = dist[i][j];
                        nearestPointsID[i] = j;
                    }
                    else if (lowestDists[i] > dist[i][j])
                    {
                        lowestDists[i] = dist[i][j];
                        nearestPointsID[i] = j;
                    }
                }
            }
            for (uint8 i = 0; i < PATHS_COUNT; i++)
            {
                if (i == 0)
                    {
                        lowestDist = lowestDists[i];
                        nearestPointID.pointID = nearestPointsID[i];
                        nearestPointID.pathID = i;
                    }
                    else if (lowestDist > lowestDists[i])
                    {
                        lowestDist = lowestDists[i];
                        nearestPointID.pointID = nearestPointsID[i];
                        nearestPointID.pathID = i;
                    }
            }
            return nearestPointID;
        }
        
        void JustRespawned()
        {
            paths = LoadPaths();
            tRun = 500;
            tRun2 = 2500;
            tSay = 1000;
            onceRun = onceRun2 = onceSay = onceGet = true;
            x = me->m_positionX+cos(me->m_orientation)*5;
            y = me->m_positionY+sin(me->m_orientation)*5;
            z = me->m_positionZ;
        }

        void UpdateAI(const uint32 diff)
        {
            if (tRun <= diff && onceRun)
            {
                me->GetMotionMaster()->MoveCharge(x, y, z, 8);
                onceRun = false;
            }
            else tRun -= diff;

            if (tSay <= diff && onceSay)
            {
                if (me->GetEntry() == NPC_FRIGHTENED_CITIZEN_1)
                    DoScriptText(RAND(SAY_CITIZEN_1, SAY_CITIZEN_2, SAY_CITIZEN_3, SAY_CITIZEN_4, SAY_CITIZEN_5, SAY_CITIZEN_6, SAY_CITIZEN_7, SAY_CITIZEN_8), me);
                else
                    DoScriptText(RAND(SAY_CITIZEN_1b, SAY_CITIZEN_2b, SAY_CITIZEN_3b, SAY_CITIZEN_4b, SAY_CITIZEN_5b), me);
                onceSay = false;
            }
            else tSay -= diff;
            
            if (tRun2 <= diff)
            {
                if (onceGet)
                {
                    nearestPointID = GetNearestPoint(paths);
                    onceGet = false;
                }
                else
                {
                    if (me->GetDistance2d(paths.paths[nearestPointID.pathID][nearestPointID.pointID].x, paths.paths[nearestPointID.pathID][nearestPointID.pointID].y) > 1)
                        me->GetMotionMaster()->MoveCharge(paths.paths[nearestPointID.pathID][nearestPointID.pointID].x, paths.paths[nearestPointID.pathID][nearestPointID.pointID].y, z, 8);
                    else
                        nearestPointID.pointID ++;
                    if (nearestPointID.pointID >= paths.pointsCount[nearestPointID.pathID]) me->DespawnOrUnsummon();
                }
            }
            else tRun2 -= diff;
        }
    };
};



void AddSC_gilneas()
{
    new npc_gilneas_city_guard_phase1();
    new npc_gilneas_city_guard_phase2();
    new npc_prince_liam_greymane_phase1();
    new npc_prince_liam_greymane_phase2();
    new npc_rampaging_worgen();
    new npc_rampaging_worgen2();
    new go_merchant_square_door();
    new npc_frightened_citizen();
    new npc_panicked_citizen();
    new npc_panicked_citizen_2();
    new npc_lieutenant_walden();
}
