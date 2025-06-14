library Tool
    //工具类，添加一些复用功能.
    
    struct ItemToolClass
        //从玩家单位移除某件装备
        static method RemoveItemTypeFromUnit takes unit whichUnit, integer itemId returns nothing
            local integer i = 0
            local item it

            loop
                exitwhen i >= UnitInventorySize(whichUnit)
                set it = UnitItemInSlot(whichUnit, i)
                if it != null and GetItemTypeId(it) == itemId then
                    call RemoveItem(it)
                    return
                endif
                set i = i + 1
            endloop
        endmethod
    endstruct

endlibrary