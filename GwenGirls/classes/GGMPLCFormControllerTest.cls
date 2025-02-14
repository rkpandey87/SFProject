@isTest
public class GGMPLCFormControllerTest {
   @isTest
    static void testGetSchoolPicklistVal() {
        // Test data setup
        Account testAccount = new Account(Type = 'School', Name = 'Test School');
        insert testAccount;
        

        // Call the method to test
        Test.startTest();
        List<GGMPLCFormController.WrapperAllValues> result = GGMPLCFormController.getSchoolPicklistVal();
        Test.stopTest();

        // Assertions
        System.assertEquals(2, result.size()); // Including the default '--Select--' value
        System.assertEquals('--Select--', result[0].label);
        System.assertEquals('--Select--', result[0].value);
        System.assertEquals('Test School', result[1].label);
        System.assertEquals(testAccount.Id, result[1].value);
    }
    
     @isTest
    static void testGetChildRecList() {
      
        Id accountRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
        Id accountRecordTypeId1 = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Client').getRecordTypeId();
        Contact parentContact = new Contact(
            FirstName = 'TestParent',
            LastName = 'LastName',
            RecordTypeId = accountRecordTypeId
        );
        insert parentContact;

        Contact childContact = new Contact(
            FirstName = 'TestChild',
            LastName = 'LastName',
            Name_of_Primary_Parent_Guardian__c = parentContact.Id,
            RecordTypeId = accountRecordTypeId1
        );
        insert childContact;
        
        Test.startTest();
        List<GGMPLCFormController.wrapperList> result = GGMPLCFormController.returnChildRecList(parentContact.Id);
        Test.stopTest();
        
        
    }
     @isTest
    static void testGetChildRecList1() {
      
        
        Contact parentContact = new Contact(
            FirstName = 'TestParent',
            LastName = 'LastName'
        );
        insert parentContact;

        Contact childContact = new Contact(
            FirstName = 'TestChild',
            LastName = 'LastName',
            Name_of_Primary_Parent_Guardian__c = parentContact.Id
        );
        insert childContact;
        
        Test.startTest();
        List<GGMPLCFormController.wrapperList> result = GGMPLCFormController.returnChildRecList('null');
        Test.stopTest();
        
        
    }
    
     @isTest
    public static void testSaveIntakeRecord() {
        // Test data setup
        Contact parentContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            HomePhone = '123-456-7890'
        );
        insert parentContact;

        String itemData = '[{"firstName":"ChildFirstName","lastName":"ChildLastName","Dob":"2000-01-01","gradeSelectedColumn":"10","schoolSelectedColumn":"SchoolA","parentfName":"ParentFirstName","parentlName":"ParentLastName","parentPhnNumber":"987-654-3210","childRecordId":"001000000000000AAA","caseId":"500000000000000AAA"}]';
        String mplcSign = 'MPLCSignature';
        String parentId = parentContact.Id;
        Boolean communityActivities = true;

        Test.startTest();
        // Call the method under test
        GGMPLCFormController.saveIntakeRecord(itemData, mplcSign, parentId, communityActivities);
        Test.stopTest();

       
    }
    @isTest
    public static void testSaveIntakeRecord1() {
        // Test data setup
        Contact parentContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            HomePhone = '123-456-7890'
            
        );
        insert parentContact;

        String itemData = '[{"firstName":"ChildFirstName","lastName":"ChildLastName","Dob":"2000-01-01","gradeSelectedColumn":"10","schoolSelectedColumn":"SchoolA","parentfName":"ParentFirstName","parentlName":"ParentLastName","parentPhnNumber":"987-654-3210","childRecordId":"001000000000000AAA","caseId":"500000000000000AAA"}]';
        String mplcSign = 'MPLCSignature';
       // String parentId = 'null';
        Boolean communityActivities = true;

        Test.startTest();
        // Call the method under test
        GGMPLCFormController.saveIntakeRecord(itemData, mplcSign, null, communityActivities);
        Test.stopTest();

       
    }

    @isTest
    static void testGetWrapperValues() {
        // Call the method to test
        GGMPLCFormController.WrapperAllValues result = GGMPLCFormController.getWrapperValues('Test Label', 'Test Value');

        // Assertions
        System.assertEquals('Test Label', result.label);
        System.assertEquals('Test Value', result.value);
    }

}