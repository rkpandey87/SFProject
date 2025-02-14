@isTest
public class LwcLookupControllerTest {
    
 	@testSetup
    static void setup(){        
        Account school1 = new Account();
        school1.Name = 'School1';
        school1.Type = 'School';
        insert school1;
        
        Account school2 = new Account();
        school2.Name = 'School2';
        school2.Type = 'School';
        insert school2;
        
        Account school3 = new Account();
        school3.Name = 'School3';
        school3.Type = 'School';
        insert school3;            
    }
    

    @isTest static void findRecordsTest(){
        String searchKey = 'Sch';
        String objectName = 'Account';
        List<sobject> result = LwcLookupController.findRecords(searchKey,objectName);        
        system.assert(result.size()>0, 'got school list!');        
    }
    
    
    
    
    
    
    
}