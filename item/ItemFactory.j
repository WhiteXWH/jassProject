// import "Item.j"

library ItemFactory
    struct ItemFactoryClass
        private hashtable itemHash = InitHashtable()

        static method create takes integer[] itemArray, return ItemFactoryClass
            local ItemFactoryClass this = ItemFactoryClass.allocate()
            
        endmethod


        method createItem takes integer itemId, integer killThreshold return ItemClass
            return 
        endmethod
    endstruct

endlibrary