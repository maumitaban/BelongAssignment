/**
* @author          Maumita
* @date            Jul 04, 2023
* @description     Rest API class to create Account and Contact 
* 
* */
@RestResource(urlMapping='/CreateAccCont')
global class CreateAccContactAPI {
    
    @HttpPost
    global static String doPost(){    
        AccContactItem accItem;
        Integer contactCount;
        Account acc = new Account();
        Id accId;
        List<Contact> contList = new List<Contact>();
        
        try{
            //get the json from the request
            RestRequest req = RestContext.request;
            RestResponse res = RestContext.response;
            String jsonText = req.requestBody.toString();
            if(jsonText!=null)
            {
                //parse JSON response to get all the field values.
                JSONParser parser = JSON.createParser(jsonText);
                while (parser.nextToken() != null) {
                    if(parser.getCurrentToken() == JSONToken.START_OBJECT) {
                        accItem = (AccContactItem)parser.readValueAs(AccContactItem.class);
                    }
                }
                
                contactCount = accItem.contacts.size();
                
                //assigning Account fields values
                if (accItem.name != null){
                    acc.Name = accItem.name;
                }
                if (accItem.type != null){
                    acc.Type = accItem.type;
                }
                if (accItem.phone != null){
                    acc.Phone = accItem.phone;
                }
                if (accItem.fax != null){
                    acc.Fax = accItem.fax;
                }
                if (accItem.accountNumber != null){
                    acc.AccountNumber = accItem.accountNumber;
                }
                if (accItem.industry != null){
                    acc.Industry = accItem.industry;
                }
                if (accItem.annualRevenue != null){
                    acc.AnnualRevenue = Decimal.valueOf(accItem.annualRevenue);
                }
                if (accItem.numberOfEmployees != null){
                    acc.NumberOfEmployees = Integer.valueOf(accItem.numberOfEmployees); 
                }
                if (accItem.ownership != null){
                    acc.Ownership = accItem.ownership;
                }
                if (accItem.description != null){
                    acc.Description = accItem.description;
                }
                if (accItem.rating != null){
                    acc.Rating = accItem.rating;
                }
                system.debug('acc >>>>>>>>>>>> '+acc);
                
                Insert acc;
                
                accId = [SELECT Id FROM Account WHERE Name = :accItem.name LIMIT 1].Id;
                
                //assigning Contact fields values
                for (Integer i=0;i<contactCount;i++){
                    Contact cnt = new Contact();
                    cnt.AccountId = accId;
                    cnt.LastName = accItem.contacts[i].lastName;
                    cnt.FirstName = accItem.contacts[i].firstName;
                    cnt.Salutation = accItem.contacts[i].salutation;
                    cnt.Phone = accItem.contacts[i].phone;
                    cnt.MobilePhone = accItem.contacts[i].mobilePhone;
                    cnt.Email = accItem.contacts[i].email;
                    cnt.Title = accItem.contacts[i].title;
                    cnt.Department = accItem.contacts[i].department;
                    cnt.Description = accItem.contacts[i].description;
                    contList.add(cnt);
                }
                
                Insert contList;
            }   
        }catch(Exception e){
            System.debug('Exception occurted : '+e.getMessage());
            String message = 'Exception occurred :' +e.getMessage();
            return message;
        }
        return('Objects Created');
    }
    
    /*
* Mapping of JSON object return from Tooiling API
* */
    public class AccContactItem{
        public String name;
        public String type;
        public String phone;
        public String fax;
        public String accountNumber;
        public String industry;
        public String annualRevenue;
        public String numberOfEmployees;
        public String ownership;
        public String description;
        public String rating;
        public List<ContactItem> contacts = new List<ContactItem>();
        
        public AccContactItem(String name1,String type1,String phone1,String fax1,String accountNumber1,String industry1,String annualRevenue1,String numberOfEmployees1,String ownership1,String description1,String rating1,List<ContactItem> restContactItem1){
            name = name1;
            type = type1;   
            phone = phone1;
            fax = fax1;
            accountNumber = accountNumber1;
            industry = industry1;
            annualRevenue = annualRevenue1;
            numberOfEmployees = numberOfEmployees1;
            ownership = ownership1;
            description = description1;
            rating = rating1;
            contacts = restContactItem1.clone();
        }
    }
    public class ContactItem{
        public String lastName;
        public String firstName;
        public String salutation;
        public String phone;
        public String mobilePhone;
        public String email;
        public String title;
        public String department;
        public String description;
    }
    
}