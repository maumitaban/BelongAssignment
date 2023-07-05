/**
* @author          Maumita
* @date            Jul 04, 2023
* @description     Test class to cover the class OrderTriggerHandler
* 
* */
@isTest
public class OrderTriggerHandlerTest {
    
    @isTest
    private static void beforeInsetOrderTest(){
        Contact cnt = new Contact();
        cnt.FirstName='TestFirst';
        cnt.LastName='TestLast';
        cnt.Contact_Role__c = 'Business User';
        cnt.Email = 'test@gmail.com';
        insert cnt;
        
        Id cntId = [SELECT Id FROM Contact WHERE FirstName = 'TestFirst'].Id;
        Account acc = new Account();
        acc.Name = 'TestAcc';
        acc.Rating = 'Hot';
        acc.PrimaryContactId__c = cntId;
        insert acc;
        
        Id accId = [SELECT Id FROM Account WHERE Name = 'TestAcc'].Id;
        
        Contract contr = new Contract();
        contr.AccountId = accId;
        contr.Status = 'Draft';
        contr.StartDate = System.today();
        contr.ContractTerm = 12;
        insert contr;
        Id contractId = [SELECT Id FROM Contract WHERE AccountId = :accId].Id;
        
        Order ord = new Order();
        ord.AccountId = accId;
        ord.ContractId = contractId;
        ord.EffectiveDate = System.today();
        ord.Status = 'Draft';
        
        insert ord;
    }
    
}