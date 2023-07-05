/**
* @author          Maumita
* @date            Jul 05, 2023
* @description     Test class to test CreateAccContactAPI
* 
* */
@isTest
public class CreateAccContactAPITest {
    static testMethod void testDoPost(){
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        String JSONMsg = '{"Name": "LWC Kaanam","Type": "Customer - Direct","Phone": "+61470688711","Fax":"123" ,"AccountNumber": "12345","Industry": "Apparel","AnnualRevenue": "50" ,"NumberOfEmployees": "60","Ownership": "Public","Description": "Test Description","Rating": "Warm","contacts": [{"LastName": "Young","FirstName": "Andy","Salutation": "Mr","Phone": "(785) 241-6200","MobilePhone": "(785) 265-5350","Email": "a_young@dickenson.com","Title": "SVP, Operations","Department": "Internal Operations","Description": "Test Contact"},{"LastName": "Young","FirstName": "Not Andy","Salutation": "Mr","Phone": "(785) 241-6200","MobilePhone": "(785) 265-5350","Email": "not_young@dickenson.com","Title": "SVP, Operations","Department": "External Operations","Description": "Test Contact"}]}';
        
        req.requestURI = '/services/apexrest/CreateAccCont';		//Request Url  
        req.httpMethod = 'POST'; 									//Request Type
        req.requestBody = Blob.valueof(JSONMsg);
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        String  result = CreateAccContactAPI.doPost();
        System.assertEquals(result, 'Objects Created');
        Test.stopTest(); 
    }   
    
    static testMethod void testDoPostNegative(){
        
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
		req.requestURI = '/services/apexrest/CreateAccCont';		//Request Url  
        req.httpMethod = 'POST'; 									//Request Type
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        String  result = CreateAccContactAPI.doPost();
        System.assertNotEquals(result, 'Objects Created');
        Test.stopTest();
    }   
    
    @isTest
    private static void AccContactItemTest()
    {
        List<CreateAccContactAPI.ContactItem> restContactItem1 = new List<CreateAccContactAPI.ContactItem>();
		CreateAccContactAPI.AccContactItem controller = new CreateAccContactAPI.AccContactItem( 'name1', 'type1', 'phone1', 'fax1', 'accountNumber1', 'industry1', 'annualRevenue1', 'numberOfEmployees1', 'ownership1','description1','rating1',restContactItem1) ;
    }
}