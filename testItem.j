//! import "item/Item.j"

library testItem initializer InitTrig_MagicCloakLogic
    globals 
        integer killItem = 'ratc'
        integer killThreshold = 10
        ItemClass gcItem
    endglobals

    function OnItemPickupDelegate takes nothing returns nothing
        call gcItem.OnItemPickup()
    endfunction
    
    function OnUnitKillDelegate takes nothing returns nothing
        call gcItem.OnUnitKill()
    endfunction

    function InitTrig_MagicCloakLogic takes nothing returns nothing
        local trigger t1 = CreateTrigger()
        local trigger t2 = CreateTrigger()
        local integer i = 0
        set gcItem = ItemClass.create(killItem, killThreshold)

        // 注册所有玩家拾取物品事件
        loop
            exitwhen i == bj_MAX_PLAYERS
            call TriggerRegisterPlayerUnitEvent(t1, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM, null)
            call TriggerRegisterPlayerUnitEvent(t2, Player(i), EVENT_PLAYER_UNIT_DEATH, null)
            set i = i + 1
        endloop
        
        call TriggerAddAction(t1, function OnItemPickupDelegate)
        call TriggerAddAction(t2, function OnUnitKillDelegate)
    endfunction
endlibrary