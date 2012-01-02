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
Name: gm_commandscript
%Complete: 100
Comment: All gm related commands
Category: commandscripts
EndScriptData */

#include "ScriptMgr.h"
#include "ObjectMgr.h"
#include "Chat.h"
#include "AccountMgr.h"

class gm_commandscript : public CommandScript
{
public:
    gm_commandscript() : CommandScript("gm_commandscript") { }

    ChatCommand* GetCommands() const
    {
        static ChatCommand gmCommandTable[] =
        {
            { "chat",           SEC_MODERATOR,      false, &HandleGMChatCommand,              "", NULL },
            { "fly",            SEC_ADMINISTRATOR,  false, &HandleGMFlyCommand,               "", NULL },
            { "ingame",         SEC_PLAYER,         true,  &HandleGMListIngameCommand,        "", NULL },
            { "list",           SEC_ADMINISTRATOR,  true,  &HandleGMListFullCommand,          "", NULL },
            { "visible",        SEC_MODERATOR,      false, &HandleGMVisibleCommand,           "", NULL },
            { "",               SEC_MODERATOR,      false, &HandleGMCommand,                  "", NULL },
            { NULL,             0,                  false, NULL,                              "", NULL }
        };
        static ChatCommand commandTable[] =
        {
            { "gm",             SEC_MODERATOR,      false, NULL,                     "", gmCommandTable },
            { NULL,             0,                  false, NULL,                               "", NULL }
        };
        return commandTable;
    }

    // Enables or disables hiding of the staff badge
    static bool HandleGMChatCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            if (handler->GetSession()->GetPlayer()->isGMChat())
                handler->GetSession()->SendNotification(LANG_GM_CHAT_ON);
            else
                handler->GetSession()->SendNotification(LANG_GM_CHAT_OFF);
            return true;
        }

        std::string argstr = (char*)args;

        if (argstr == "change")
        {
            if (handler->GetSession()->GetPlayer()->isGMChat())
                argstr = "off";
            else
                argstr = "on";
        }

        if (argstr == "on")
        {
            handler->GetSession()->GetPlayer()->SetGMChat(true);
            handler->GetSession()->SendNotification(LANG_GM_CHAT_ON);
            return true;
        }

        if (argstr == "off")
        {
            handler->GetSession()->GetPlayer()->SetGMChat(false);
            handler->GetSession()->SendNotification(LANG_GM_CHAT_OFF);
            return true;
        }

        handler->SendSysMessage(LANG_USE_BOL);
        handler->SetSentErrorMessage(true);
        return false;
    }

    static bool HandleGMFlyCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
            return false;

        Player *target = handler->getSelectedPlayer();
        if (!target)
            target = handler->GetSession()->GetPlayer();

        WorldPacket data(SMSG_MULTIPLE_PACKETS, 14);
        if (strncmp(args, "change", 7) == 0)
            if (target->canFly())
                data << uint16(SMSG_MOVE_UNSET_CAN_FLY);
            else
                data << uint16(SMSG_MOVE_SET_CAN_FLY);
        else if (strncmp(args, "on", 3) == 0)
            data << uint16(SMSG_MOVE_SET_CAN_FLY);
        else if (strncmp(args, "off", 4) == 0)
            data << uint16(SMSG_MOVE_UNSET_CAN_FLY);
        else
        {
            handler->SendSysMessage(LANG_USE_BOL);
            return false;
        }
        data.append(target->GetPackGUID());
        data << uint32(0);                                      // unknown
        target->SendMessageToSet(&data, true);
        handler->PSendSysMessage(LANG_COMMAND_FLYMODE_STATUS, handler->GetNameLink(target).c_str(), args);
        return true;
    }

    static bool HandleGMListIngameCommand(ChatHandler* handler, char const* /*args*/)
    {
        bool first = true;

        ACE_GUARD_RETURN(ACE_Thread_Mutex, guard, *HashMapHolder<Player>::GetLock(), true);
        HashMapHolder<Player>::MapType &m = sObjectAccessor->GetPlayers();
        for (HashMapHolder<Player>::MapType::const_iterator itr = m.begin(); itr != m.end(); ++itr)
        {
            AccountTypes itr_sec = itr->second->GetSession()->GetSecurity();
            if ((itr->second->isGameMaster() || (itr_sec > SEC_PLAYER && itr_sec <= AccountTypes(sWorld->getIntConfig(CONFIG_GM_LEVEL_IN_GM_LIST)))) &&
                (!handler->GetSession() || itr->second->IsVisibleGloballyFor(handler->GetSession()->GetPlayer())))
            {
                if (first)
                {
                    handler->SendSysMessage(LANG_GMS_ON_SRV);
                    first = false;
                }

                handler->SendSysMessage(handler->GetNameLink(itr->second).c_str());
            }
        }

        if (first)
            handler->SendSysMessage(LANG_GMS_NOT_LOGGED);

        return true;
    }

    /// Display the list of GMs
    static bool HandleGMListFullCommand(ChatHandler* handler, char const* /*args*/)
    {
        ///- Get the accounts with GM Level >0
        QueryResult result = LoginDatabase.Query("SELECT a.username, aa.gmlevel FROM account a, account_access aa WHERE a.id=aa.id AND aa.gmlevel > 0");
        if (result)
        {
            handler->SendSysMessage(LANG_GMLIST);
            handler->SendSysMessage(" ======================== ");
            handler->SendSysMessage(LANG_GMLIST_HEADER);
            handler->SendSysMessage(" ======================== ");

            ///- Circle through them. Display username and GM level
            do
            {
                Field *fields = result->Fetch();
                handler->PSendSysMessage("|%15s|%6s|", fields[0].GetCString(), fields[1].GetCString());
            }
            while (result->NextRow());

            handler->PSendSysMessage(" ======================== ");
        }
        else
            handler->PSendSysMessage(LANG_GMLIST_EMPTY);
        return true;
    }

    //Enable\Dissable Invisible mode
    static bool HandleGMVisibleCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            handler->PSendSysMessage(LANG_YOU_ARE, handler->GetSession()->GetPlayer()->isGMVisible() ?  handler->GetDarkCoreString(LANG_VISIBLE) : handler->GetDarkCoreString(LANG_INVISIBLE));
            return true;
        }

        std::string argstr = (char*)args;

        if (argstr == "change")
        {
            if (handler->GetSession()->GetPlayer()->isGMVisible())
                argstr = "off";
            else
                argstr = "on";
        }

        if (argstr == "on")
        {
            handler->GetSession()->GetPlayer()->SetGMVisible(true);
            handler->GetSession()->SendNotification(LANG_INVISIBLE_VISIBLE);
            return true;
        }

        if (argstr == "off")
        {
            handler->GetSession()->SendNotification(LANG_INVISIBLE_INVISIBLE);
            handler->GetSession()->GetPlayer()->SetGMVisible(false);
            return true;
        }

        handler->SendSysMessage(LANG_USE_BOL);
        handler->SetSentErrorMessage(true);
        return false;
    }

    //Enable\Dissable GM Mode
    static bool HandleGMCommand(ChatHandler* handler, char const* args)
    {
        if (!*args)
        {
            if (handler->GetSession()->GetPlayer()->isGameMaster())
                handler->GetSession()->SendNotification(LANG_GM_ON);
            else
                handler->GetSession()->SendNotification(LANG_GM_OFF);
            return true;
        }

        std::string argstr = (char*)args;

        if (argstr == "change")
        {
            if (handler->GetSession()->GetPlayer()->isGameMaster())
                argstr = "off";
            else
                argstr = "on";
        }

        if (argstr == "on")
        {
            handler->GetSession()->GetPlayer()->SetGameMaster(true);
            handler->GetSession()->SendNotification(LANG_GM_ON);
            handler->GetSession()->GetPlayer()->UpdateTriggerVisibility();
            #ifdef _DEBUG_VMAPS
            VMAP::IVMapManager *vMapManager = VMAP::VMapFactory::createOrGetVMapManager();
            vMapManager->processCommand("stoplog");
            #endif
            return true;
        }

        if (argstr == "off")
        {
            handler->GetSession()->GetPlayer()->SetGameMaster(false);
            handler->GetSession()->SendNotification(LANG_GM_OFF);
            handler->GetSession()->GetPlayer()->UpdateTriggerVisibility();
            #ifdef _DEBUG_VMAPS
            VMAP::IVMapManager *vMapManager = VMAP::VMapFactory::createOrGetVMapManager();
            vMapManager->processCommand("startlog");
            #endif
            return true;
        }

        handler->SendSysMessage(LANG_USE_BOL);
        handler->SetSentErrorMessage(true);
        return false;
    }
};

void AddSC_gm_commandscript()
{
    new gm_commandscript();
}