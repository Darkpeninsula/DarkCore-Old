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

#include "ScriptPCH.h"
#include "oculus.h"

enum Says
{
    SAY_AGGRO           = 0,
    SAY_AZURE           = 1,
    SAY_AZURE_EMOTE     = 2,
    SAY_DEATH           = 3
};

enum Spells
{
    SPELL_ENERGIZE_CORES                          = 50785, //Damage 5938 to 6562, effec2 Triggers 54069, effect3 Triggers 56251
    SPELL_CALL_AZURE_RING_CAPTAIN                 = 51002, //Effect    Send Event (12229)
    /*SPELL_CALL_AZURE_RING_CAPTAIN_2               = 51006, //Effect    Send Event (10665)
    SPELL_CALL_AZURE_RING_CAPTAIN_3               = 51007, //Effect    Send Event (18454)
    SPELL_CALL_AZURE_RING_CAPTAIN_4               = 51008, //Effect    Send Event (18455)*/
    SPELL_CALL_AMPLIFY_MAGIC                      = 51054,

    SPELL_CENTRIFUGE_SHIELD                       = 50053,

    SPELL_ICE_BEAM                                = 49549
};

enum Events
{
    EVENT_ENERGIZE_CORES = 1,
    EVENT_CALL_AZURE,
    EVENT_AMPLIFY_MAGIC
};

class boss_varos : public CreatureScript
{
public:
    boss_varos() : CreatureScript("boss_varos") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_varosAI (creature);
    }

    struct boss_varosAI : public BossAI
    {
        boss_varosAI(Creature* creature) : BossAI(creature, DATA_VAROS_EVENT)
        {
            DoCast(me, SPELL_CENTRIFUGE_SHIELD);
        }

        void Reset()
        {
            _Reset();

            events.ScheduleEvent(EVENT_AMPLIFY_MAGIC, urand(20, 25) * IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_ENERGIZE_CORES, urand(0, 15) * IN_MILLISECONDS);
            // not sure if this is handled by a timer or hp percentage
            events.ScheduleEvent(EVENT_CALL_AZURE, urand(15, 30) * IN_MILLISECONDS);

            instance->SetData(DATA_VAROS_EVENT, NOT_STARTED);
        }

        void AttackStart(Unit* attacker)
        {
            if (me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PASSIVE))
                return;

            BossAI::AttackStart(attacker);
        }

        void EnterCombat(Unit* /*who*/)
        {
            _EnterCombat();

            Talk(SAY_AGGRO);

            instance->SetData(DATA_VAROS_EVENT, IN_PROGRESS);
        }

        void UpdateAI(const uint32 diff)
        {
            //Return since we have no target
            if (!UpdateVictim())
                return;

            events.Update(diff);

            if (me->HasUnitState(UNIT_STAT_CASTING))
                return;

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_ENERGIZE_CORES:
                        DoCast(me, SPELL_ENERGIZE_CORES);
                        events.ScheduleEvent(EVENT_ENERGIZE_CORES, urand(12, 14) * IN_MILLISECONDS);
                        break;
                    case EVENT_CALL_AZURE:
                        // not sure how blizz handles this, i cant see any pattern between the differnt spells
                        DoCast(me, SPELL_CALL_AZURE_RING_CAPTAIN);
                        Talk(SAY_AZURE);
                        Talk(SAY_AZURE_EMOTE);
                        events.ScheduleEvent(EVENT_CALL_AZURE, urand(20, 25) * IN_MILLISECONDS);
                        break;
                    case EVENT_AMPLIFY_MAGIC:
                        DoCast(me->getVictim(), SPELL_CALL_AMPLIFY_MAGIC);
                        events.ScheduleEvent(EVENT_AMPLIFY_MAGIC, urand(17, 20) * IN_MILLISECONDS);
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

        void JustDied(Unit* /*killer*/)
        {
            _JustDied();

            Talk(SAY_DEATH);
            instance->SetData(DATA_VAROS_EVENT, DONE);
        }
    };
};

class npc_azure_ring_captain : public CreatureScript
{
    public:
        npc_azure_ring_captain() : CreatureScript("npc_azure_ring_captain") { }

        struct npc_azure_ring_captainAI : public ScriptedAI
        {
            npc_azure_ring_captainAI(Creature* creature) : ScriptedAI(creature)
            {
                instance = creature->GetInstanceScript();
            }

            void Reset()
            {
                targetGUID = 0;

                me->AddUnitMovementFlag(MOVEMENTFLAG_WALKING);
                me->SetReactState(REACT_AGGRESSIVE);
            }

            void SpellHitTarget(Unit* target, SpellEntry const* spell)
            {
                if (spell->Id == SPELL_ICE_BEAM)
                    EnterEvadeMode();
            }

            void UpdateAI(const uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                DoMeleeAttackIfReady();
            }

            void MovementInform(uint32 type, uint32 id)
            {
                if (type != POINT_MOTION_TYPE ||
                    id != ACTION_CALL_DRAGON_EVENT)
                    return;

                me->GetMotionMaster()->MoveIdle();

                if (Unit* target = ObjectAccessor::GetUnit(*me, targetGUID))
                    DoCast(target, SPELL_ICE_BEAM);
            }

            void DoAction(const int32 action)
            {
                switch (action)
                {
                   case ACTION_CALL_DRAGON_EVENT:
                        if (instance)
                        {
                            if (Creature* varos = ObjectAccessor::GetCreature(*me, instance->GetData64(DATA_VAROS)))
                            {
                                if (Unit* victim = varos->AI()->SelectTarget(SELECT_TARGET_RANDOM, 0))
                                {
                                    me->SetReactState(REACT_PASSIVE);
                                    me->RemoveUnitMovementFlag(MOVEMENTFLAG_WALKING);
                                    me->GetMotionMaster()->MovePoint(ACTION_CALL_DRAGON_EVENT, victim->GetPositionX(), victim->GetPositionY(), victim->GetPositionZ() + 20.0f);
                                    targetGUID = victim->GetGUID();
                                }
                            }
                        }
                        break;
                }
           }
        private:
            uint64 targetGUID;
            InstanceScript* instance;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_azure_ring_captainAI(creature);
        }
};

class spell_varos_centrifuge_shield : public SpellScriptLoader
{
    public:
        spell_varos_centrifuge_shield() : SpellScriptLoader("spell_varos_centrifuge_shield") { }

        class spell_varos_centrifuge_shield_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_varos_centrifuge_shield_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (!GetCaster()->ToCreature())
                    return;

                // flags taken from sniffs
                // UNIT_FLAG_UNK_9 -> means passive but it is not yet implemented in core
                if (GetCaster()->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_15|UNIT_FLAG_PASSIVE|UNIT_FLAG_OOC_NOT_ATTACKABLE|UNIT_FLAG_UNK_6))
                {
                    GetCaster()->ToCreature()->SetReactState(REACT_PASSIVE);
                    GetCaster()->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_15|UNIT_FLAG_PASSIVE|UNIT_FLAG_OOC_NOT_ATTACKABLE|UNIT_FLAG_UNK_6);
                }
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (!GetCaster()->ToCreature())
                    return;

                GetCaster()->ToCreature()->SetReactState(REACT_AGGRESSIVE);
                GetCaster()->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_UNK_15|UNIT_FLAG_PASSIVE|UNIT_FLAG_OOC_NOT_ATTACKABLE|UNIT_FLAG_UNK_6);
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_varos_centrifuge_shield_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                OnEffectApply += AuraEffectApplyFn(spell_varos_centrifuge_shield_AuraScript::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_varos_centrifuge_shield_AuraScript();
        }
};

void AddSC_boss_varos()
{
    new boss_varos();
    new npc_azure_ring_captain();
    new spell_varos_centrifuge_shield();
}