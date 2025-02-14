@isTest
public class GGFormControllerTest {
    
   
    
    @isTest
    public static void GGFormControllerDependentMethodTest(){
         List<Account> listOfAccount=GGFormController.getSchoolPicklist();
        String parentContactString='{"FirstName":"Testing Parent First Name","LastName":"Testing Parent Last Name","HomePhone":"123456789","Email":"testing@gmail.com"}';
        Contact testCon=GGFormController.upsertParentContact(parentContactString);
        String recordType=Schema.SObjectType.Intake__c.getRecordTypeInfosByName().get('MPLC').getRecordTypeId();
        String listOfIntakeString='[{"Name_of_Primary_Parent_Guardian__c":"'+testCon.Id+'","Community_Activities__c":true,"mplc_Signature__c":"Test","RecordTypeId":"'+recordType+'","Name":"Testing Child First Name_Testing Child Last Name_MPLC","First_Name__c":"Testing Child First Name","Last_Name__c":"Testing Child Last Name","Home_Phone__c":"123456789","Birthdate__c":"2007-04-29","DateOfSignature__c":"2024-05-21","Grade__c":"11"}]';
        Boolean isRecordInserted=GGFormController.createIntake(listOfIntakeString);
        Boolean isRecordInsertedAgain=GGFormController.createIntake(null); 
        GGFormController.ContactIntakeWrapper conIntakeWrapp=GGFormController.getExistingRecords(testCon.Id);
        List<CaringConnectionsFormController.fieldsWrapper> listOfCCFC=GGFormController.getSiteUsers();
        Contact ggMainControllerContact=[Select id,LastName,FirstName, PIN__c from Contact where id=:testCon.Id];
        List<GGMainFormController.wrapperList> listOfGGMform= GGMainFormController.filterContactRecAsPerRecType(ggMainControllerContact.FirstName,ggMainControllerContact.LastName,ggMainControllerContact.PIN__c);
        
    }
    
   

}