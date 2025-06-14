library testItem initializer InitTrig_MagicCloakLogic
    globals
        item MAGIC_CLOAK_ITEM      // 指定的物品类型
        integer killCount = 0    // 存储每位玩家的击杀数量
        boolean array hasCloak     // 标记玩家是否拥有该物品
        integer killItem = 'ratc'
    endglobals

    // 当单位获得物品时触发
    function OnItemPickup takes nothing returns nothing
        local unit u = GetTriggerUnit()
        local item it = GetManipulatedItem()
        local integer pid = GetPlayerId(GetOwningPlayer(u))

        // 判断是否为魔法斗篷（替换为你地图中物品的真实ID）
        if GetItemTypeId(it) == killItem then
            set hasCloak[pid] = true
            if killCount == 0 then
                call DisplayTextToPlayer(GetOwningPlayer(u), 0, 0, "你获得了魔法斗篷，开始追踪击杀数！")
            endif
        endif
    endfunction

   

    // 当玩家单位击杀单位时触发
    function OnUnitKill takes nothing returns nothing
        local unit killer = GetKillingUnit()
        local integer pid = GetPlayerId(GetOwningPlayer(killer))

        if hasCloak[pid] then
            set killCount = killCount + 1

            if killCount > 10 then
                // 移除魔法斗篷
                call DisplayTextToPlayer(GetOwningPlayer(killer), 0, 0, "你已击杀超过10个敌人，魔法斗篷已移除！")
                call RemoveItemTypeFromUnit(killer, killItem)
                set hasCloak[pid] = false
            endif
        endif
    endfunction

    function InitTrig_MagicCloakLogic takes nothing returns nothing
        local trigger t1 = CreateTrigger()
        local trigger t2 = CreateTrigger()
        local integer i = 0

        // 注册所有玩家拾取物品事件
        loop
            exitwhen i == bj_MAX_PLAYERS
            call BJDebugMsg("注册玩家" + I2S(i) + "的拾取物品事件")
            call TriggerRegisterPlayerUnitEvent(t1, Player(i), EVENT_PLAYER_UNIT_PICKUP_ITEM, null)
            // call TriggerRegisterPlayerUnitEvent(t2, Player(i), EVENT_PLAYER_UNIT_KILL, null)
            call TriggerRegisterPlayerUnitEvent(t2, Player(i), EVENT_PLAYER_UNIT_DEATH, null)
            set i = i + 1
        endloop

        call TriggerAddAction(t1, function OnItemPickup)
        call TriggerAddAction(t2, function OnUnitKill)
    endfunction
endlibrary