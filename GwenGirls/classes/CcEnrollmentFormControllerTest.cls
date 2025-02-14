@isTest
public class CcEnrollmentFormControllerTest {
 @isTest
    static void testCcEnrollmentFormController() {
        // Create a test Intake record
        Intake__c testIntake = new Intake__c(
           First_Name__c = 'TestFirstName',
            Birthdate__c = Date.today(),
            Home_Phone__c = '1234567890',
            mplc_Signature__c = 'TestSignature',
            Community_Activities__c = true,
            DateOfSignature__c = Date.today()
           
        );
        insert testIntake;
        
        Test.setCurrentPageReference(new PageReference('/apex/CcEnrollmentForm?id=' + testIntake.Id));

        Test.startTest();
        ApexPages.StandardController stdController = new ApexPages.StandardController(testIntake);
        CcEnrollmentFormController controllerUnderTest = new CcEnrollmentFormController(stdController);
        
        controllerUnderTest.getData(testIntake.Id);
        
        controllerUnderTest.signName522 = 'test522';
        controllerUnderTest.signName =  'Test';
        controllerUnderTest.signName1 = 'Test';
        
      // Test setSignature methods
        controllerUnderTest.setSignature();
        controllerUnderTest.setSignature1();
        controllerUnderTest.setSignature522();
        Test.stopTest();
        
    }
}