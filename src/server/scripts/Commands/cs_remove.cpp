/*
 * Copyright (C) 2005-2012 MaNGOS <http://www.getmangos.com/>
 * Copyright (C) 2008-2012 Trinity <http://www.trinitycore.org/>
 * Copyright (C) 2010-2012 Project SkyFire <http://www.projectskyfire.org/>
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
Name: cs_remove
%Complete: 100
Comment: All remove related commands
Category: commandscripts
EndScriptData */

#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "Player.h"


/* Remove Dual Spec Command */
#define SPELL_DUAL_SPEC 63651 //Revert to One Talent Specialization

class remove_commandscript : public CommandScript
{
    public:
        remove_commandscript() : CommandScript("remove_commandscript") { }

        ChatCommand* GetCommands() const
        {
            static ChatCommand removeCommandTable[] =
            {
                { "dualspec",    SEC_MODERATOR,       false, &HandleRemoveDualSpecCommand,       "", NULL },
                { NULL,                      0,       false, NULL,                               "", NULL }
            };
            static ChatCommand commandTable[] =
            {
                { "remove",      SEC_MODERATOR,       false, NULL,                               "", removeCommandTable},
                { NULL,                      0,       false, NULL,                               "", NULL }
            };
            return commandTable;
        }

        static bool HandleRemoveDualSpecCommand(ChatHandler* handler, const char* args)
        {
            std::string name;
            Player *player;
            char *TargetName = strtok((char*)args, " ");
            if (!TargetName)
            {
                player = handler->getSelectedPlayer();
                if (player)
                {
                    name = player->GetName();
                    normalizePlayerName(name);
                }
            }
            else
            {
                name = TargetName;
                normalizePlayerName(name);
                player = sObjectAccessor->FindPlayerByName(name.c_str());
            }

            if (!player)
            {
                // Try reset talents as Hunter Pet
                Creature* creature = handler->getSelectedCreature();
                if (creature && creature->isPet())
                {
                    Unit *owner = creature->GetOwner();
                    if (owner && owner->GetTypeId() == TYPEID_PLAYER && ((Pet *)creature)->IsPermanentPetFor(owner->ToPlayer()))
                    {
                        ((Pet *)creature)->resetTalents(true);
                        owner->ToPlayer()->SendTalentsInfoData(true);

                        ChatHandler(owner->ToPlayer()).SendSysMessage(LANG_RESET_PET_TALENTS);
                        return true;
                    }
                }
            }
            else
            {
                player->ActivateSpec(1);
                player->resetTalents(true);
                player->SendTalentsInfoData(false);
                player->ActivateSpec(0);
                player->CastSpell(player, SPELL_DUAL_SPEC, true);
                ChatHandler(player).SendSysMessage(LANG_RESET_TALENTS);

                Pet* pet = player->GetPet();
                Pet::resetTalentsForAllPetsOf(player, pet);

                if (pet)
                    player->SendTalentsInfoData(true);

                return true;
            }

            handler->SendSysMessage(LANG_NO_CHAR_SELECTED);
            return false;
        }
};

void AddSC_remove_commandscript()
{
    new remove_commandscript();
}