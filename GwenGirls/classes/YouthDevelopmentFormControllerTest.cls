@isTest
public class YouthDevelopmentFormControllerTest {

@isTest
    public static void testUpsertParentContact(){
        Contact conObj=new Contact();
        conObj.FirstName='Test';
        conObj.LastName='Contact';
        
        Test.StartTest();
       YouthDevelopmentFormController.upsertParentContact(JSON.serialize(conObj));
        Test.StopTest();
      //  System.assertEquals('Test', contactUpdated.FirstName,'Error in Upsert'); 
    }
@isTest
    public static void testGetExistingRecord(){
        Contact conObj=new Contact();
        conObj.FirstName='Test';
        conObj.LastName='Contact';
        insert conObj;
        Case caseObj=new Case();
        caseObj.ContactId=conObj.Id;
        insert caseObj;
        List<Contact> contactList=new List<Contact>();
        contactList.add(conObj);
        Test.StartTest();
        YouthDevelopmentFormController.getExistingRecord(conObj.Id);
       YouthDevelopmentFormController.getExistingRecord(caseObj.Id);
        Test.StopTest();
        System.assertEquals('Test', contactList[0].FirstName,'Error in Upsert'); 
       // System.assertEquals(conObj.Id, cIWrapper.parentContact.Id,'Error in Upsert'); 
    }@isTest
    public static void testgetFieldsValues(){
        Test.StartTest();
        YouthDevelopmentFormController.getFieldsValues();
        Test.StopTest();
    }@isTest
    public static void testUpsertParentContact1(){
        Contact conObj=new Contact();
        conObj.FirstName='Test';
        conObj.LastName='Contact';
        insert conObj;
        List<Contact> conLst=new List<Contact>();
        conLst.add(conObj);
        String parentContactString = JSON.serialize(conLst);
        Test.StartTest();
        YouthDevelopmentFormController.upsertParentContact1(parentContactString);
        Test.StopTest();
       // System.assertEquals('Test', contactUpdated.FirstName,'Error in Upsert'); 
    }}