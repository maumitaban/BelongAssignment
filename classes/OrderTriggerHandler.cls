/**
* @author          Maumita
* @date            Jul 03, 2023
* @description     Trigger Handler class for Order Object to associate a Primary contact to the order 
* 
* */

public class OrderTriggerHandler {
    public static void beforeInsetOrder(List<Order> newOrder){
        List<Account> primCntList; 
        Id accId;
        Id contactId;
        for(Order ord: newOrder){
            System.debug('trigger handler class newOrder');
            if(ord.AccountId != null){
                accId = ord.AccountId;
                primCntList = [SELECT PrimaryContactId__c 
                               FROM Account 
                               WHERE Id= :accId
                               AND PrimaryContactId__c!= null
                               LIMIT 1];
                
                if (primCntList.size() > 0){
                    contactId=primCntList[0].PrimaryContactId__c;
                    ord.Associated_Contact__c = contactId;
                    System.debug('Associated_Contact__c updated '+contactId);
                }
            }
        }
    }
    
}