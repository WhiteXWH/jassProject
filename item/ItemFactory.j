// import "Item.j"

library ItemFactory
    struct ItemFactoryClass
        private hashtable itemHash

        static method create takes nothing returns ItemFactoryClass
            local ItemFactoryClass this = ItemFactoryClass.allocate()
            set this.itemHash = InitHashtable()
        endmethod
        
        method setItem takes nothing returns nothing
            
        endmethod

        method createItem takes integer itemId, integer killThreshold returns ItemClass
            return 
        endmethod
    endstruct

endlibrary