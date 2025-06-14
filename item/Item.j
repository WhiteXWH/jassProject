//! import "util/Tool.j" 

library Item
    //定义装备基类
    struct ItemClass
        private integer itemId
        private integer killCount
        private integer killThreshold
        private boolean array hasCloak[12]

        static method create takes integer itemId, integer killThreshold returns ItemClass
            local ItemClass this = ItemClass.allocate() // 分配实例
            set this.itemId = itemId
            set this.killThreshold = killThreshold
            set this.killCount = 0
            return this
        endmethod

        method OnItemPickup takes nothing returns nothing
            local unit u = GetTriggerUnit()
            local item it = GetManipulatedItem()
            local integer pid = GetPlayerId(GetOwningPlayer(u))
    
            // 判断是否为目标物品（替换为你地图中物品的真实ID）
            if GetItemTypeId(it) == this.itemId then
                set hasCloak[pid] = true
            endif
        endmethod

        //判断击杀是否超过某个值并移除装备
        method OnUnitKill takes nothing returns nothing
            local unit killer = GetKillingUnit()
            local integer pid = GetPlayerId(GetOwningPlayer(killer))
    
            if hasCloak[pid] then
                set killCount = killCount + 1    
                if killCount > killThreshold then
                    call DisplayTextToPlayer(GetOwningPlayer(killer), 0, 0, "你已击杀超过10个敌人，魔法斗篷已移除！")
                    call ItemToolClass.RemoveItemTypeFromUnit(killer, killItem)
                    set hasCloak[pid] = false
                endif
            endif
        endmethod
        
        method onDestroy takes nothing returns nothing
            // call BJDebugMsg("item object 被销毁")
        endmethod
    endstruct

endlibrary