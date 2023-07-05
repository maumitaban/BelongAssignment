/**
 * @author          Maumita
 * @date            Jul 03, 2023
 * @description     Trigger for Order Object to associate a Primary contact to the order 
 * 
 * */
trigger OrderTrigger on Order (before insert) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            OrderTriggerHandler.beforeInsetOrder(Trigger.new);
        }
    }
}