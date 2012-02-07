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
SD%Complete: 100
SDName: Premium
SDComment:
SDCategory:
EndScriptData */

#include "ScriptPCH.h"
#include <cstring>

#define PREMIUM_TYPE_ITEM                         1
#define PREMIUM_TYPE_LEVEL                        2
#define PREMIUM_TYPE_GOLD                         3
#define PREMIUM_TYPE_CURRENCY                     4
#define PREMIUM_TYPE_CUSTOMIZE                    5
#define PREMIUM_TYPE_CHANGE_RACE                  6
#define PREMIUM_TYPE_CHANGE_FACTION               7

#define PREMIUM_LANG_CODE_ALREADY_USED            "Premium code already used!"
#define PREMIUM_LANG_WRONG_CODE                   "Wrong Premium code."
#define PREMIUM_LANG_INSERT_CODE                  "Please insert your premium code."
#define PREMIUM_LANG_GOOD_BYE                     "Good Bye!"

#define PREMIUM_LANG_ERROR_ITEM                   "Sorry, you cant store the item!"
#define PREMIUM_LANG_ERROR_LEVEL                  "Sorry, you reach max level cap!"
#define PREMIUM_LANG_ERROR_GOLD                   "Sorry, you reach max gold limit cap!"
#define PREMIUM_LANG_ERROR_CURRENCIES             "Sorry, you reach max weekly currency cap!"

class npc_premium : public CreatureScript
{
    public:
        npc_premium() : CreatureScript("npc_premium") { }

    uint32 GetRightEntry(Unit* player, uint32 item)
    {
        for (std::map<uint32, uint32>::const_iterator itr = sObjectMgr->factionchange_items.begin(); itr != sObjectMgr->factionchange_items.end(); ++itr)
        {
            if(item == itr->first || item == itr->second)
                return player->ToPlayer()->GetTeam() == ALLIANCE ? itr->first : itr->second;
        }

        return item;
    }

    int32 Reward(Player *player, Creature *_Creature, const char* sCode)
    {
        if(!player)
            return 0;

        int32 Index = 0;
        int32 Type = 0;
        int32 Entry = 0;
        int32 Count = 0;
        int32 Rewaded = 0;

        if (QueryResult pResult = ExtraDatabase.PQuery("SELECT `id`,`type`,`entry`,`count`,`rewarded` FROM `coupons` WHERE `coupon` = '%s'", sCode))
        {
            Field* pFields = pResult->Fetch();

            Index   = pFields[0].GetInt32();
            Type    = pFields[1].GetInt32();
            Entry   = pFields[2].GetInt32();
            Count   = pFields[3].GetInt32();
            Rewaded = pFields[4].GetInt32();

            if(Rewaded == 0)
            {
                if(Type == PREMIUM_TYPE_ITEM)
                {
                    if(uint32 RightItem = GetRightEntry(player, Entry))
                    {
                        ItemPosCountVec dest;
                        uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, Entry, Count);
                        if (msg != EQUIP_ERR_OK)
                        {
                            _Creature->MonsterWhisper(PREMIUM_LANG_ERROR_ITEM,player->GetGUID());
                            return 0;
                        }
                        
                        player->AddItem(RightItem, Count);
                    }
                }
                
                if(Type == PREMIUM_TYPE_LEVEL)
                {
                    if(int8(player->getLevel() + Count) > sWorld->getIntConfig(CONFIG_MAX_PLAYER_LEVEL))
                    {
                        _Creature->MonsterWhisper(PREMIUM_LANG_ERROR_LEVEL,player->GetGUID());
                        return 0;
                    }
                    
                    player->GiveLevel(player->getLevel() + Count);
                    player->InitTalentForLevel();
                    player->SetUInt32Value(PLAYER_XP,0);
                }

                if(Type == PREMIUM_TYPE_GOLD)
                {
                    if(int32(player->GetMoney() + Count) >  MAX_MONEY_AMOUNT)
                    {
                        _Creature->MonsterWhisper(PREMIUM_LANG_ERROR_GOLD,player->GetGUID());
                        return 0;
                    }
                    
                    player->ModifyMoney(Count);
                }
                
                if(Type == PREMIUM_TYPE_CURRENCY)
                {
                    const CurrencyTypesEntry* currency = sCurrencyTypesStore.LookupEntry(Entry);
                    uint32 weekCap = currency->WeekCap;

                    if(int32(player->GetCurrency(Entry) + Count) >  weekCap)
                    {
                        _Creature->MonsterWhisper(PREMIUM_LANG_ERROR_CURRENCIES,player->GetGUID());
                        return 0;
                    }
                    
                    player->ModifyCurrency(Entry, Count);
                }


                if(Type == PREMIUM_TYPE_CUSTOMIZE)
                {
                    player->SetAtLoginFlag(AT_LOGIN_CUSTOMIZE);
                    SQLTransaction trans = CharacterDatabase.BeginTransaction();
                    trans->PAppend("UPDATE characters SET at_login = at_login | '8' WHERE guid = '%u'", player->GetGUIDLow());
                    CharacterDatabase.CommitTransaction(trans);
                    _Creature->MonsterWhisper(LANG_CUSTOMIZE_PLAYER,player->GetGUID());
                }

                if(Type == PREMIUM_TYPE_CHANGE_RACE)
                {
                    player->SetAtLoginFlag(AT_LOGIN_CHANGE_RACE);
                    SQLTransaction trans = CharacterDatabase.BeginTransaction();
                    trans->PAppend("UPDATE characters SET at_login = at_login | '128' WHERE guid = %u", player->GetGUIDLow());
                    CharacterDatabase.CommitTransaction(trans);
                    _Creature->MonsterWhisper(LANG_CUSTOMIZE_PLAYER,player->GetGUID());
                }

                if(Type == PREMIUM_TYPE_CHANGE_FACTION)
                {
                    player->SetAtLoginFlag(AT_LOGIN_CHANGE_FACTION);
                    SQLTransaction trans = CharacterDatabase.BeginTransaction();
                    trans->PAppend("UPDATE characters SET at_login = at_login | '64' WHERE guid = %u", player->GetGUIDLow());
                    CharacterDatabase.CommitTransaction(trans);
                    _Creature->MonsterWhisper(LANG_CUSTOMIZE_PLAYER,player->GetGUID());
                }
            }
            else
            {
                _Creature->MonsterWhisper(PREMIUM_LANG_CODE_ALREADY_USED,player->GetGUID());
            }
        }
        else
        {
            _Creature->MonsterWhisper(PREMIUM_LANG_WRONG_CODE,player->GetGUID());
        }
        return Index;
    }

    bool OnGossipHello(Player *player, Creature *_Creature)
    {
        uint32 idvendor = _Creature->GetEntry();
        player->ADD_GOSSIP_ITEM_EXTENDED(0, PREMIUM_LANG_INSERT_CODE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1, "", 0, true);
        player->ADD_GOSSIP_ITEM(0, PREMIUM_LANG_GOOD_BYE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+2);
        player->PlayerTalkClass->SendGossipMenu(idvendor,_Creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player *player, Creature *_Creature, uint32 sender, uint32 action )
    {
        if(action == GOSSIP_ACTION_INFO_DEF+2)
        {
            _Creature->MonsterWhisper(PREMIUM_LANG_GOOD_BYE,player->GetGUID());
            player->CLOSE_GOSSIP_MENU();
        }
        return true;
    }

    bool OnGossipSelectCode( Player *player, Creature *_Creature, uint32 sender, uint32 action, const char* sCode )
    {
        if(sender == GOSSIP_SENDER_MAIN)
        {
            if(action == GOSSIP_ACTION_INFO_DEF+1)
            {
                if(int32 Index = Reward(player, _Creature, sCode))
                {
                    if(Index > 0)
                    {
                        SQLTransaction trans = ExtraDatabase.BeginTransaction();
                        trans->PAppend("UPDATE coupons as T1, coupons_info as T2 SET T1.rewarded = '1', T2.account = '%u', T2.character = '%u' WHERE T1.id = '%u' AND T2.id = '%u'", player->GetSession()->GetAccountId(), player->GetGUIDLow(), Index, Index);
                        ExtraDatabase.CommitTransaction(trans);

                        player->SaveToDB();
                        _Creature->MonsterWhisper(PREMIUM_LANG_GOOD_BYE,player->GetGUID());
                        player->CLOSE_GOSSIP_MENU();
                        return true;
                    }
                }
            }
        }

        player->CLOSE_GOSSIP_MENU();
        return false;
    }
};

void AddSC_premium()
{
    new npc_premium;
}