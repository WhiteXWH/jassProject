library test
    struct ToolItem
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