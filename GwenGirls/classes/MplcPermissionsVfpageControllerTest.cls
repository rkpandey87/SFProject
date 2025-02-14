@isTest
public class MplcPermissionsVfpageControllerTest {
    @isTest
    static void testMPLCSave() {
        // Create a test record ID
        Intake__c testIntake = new Intake__c(
            First_Name__c = 'TestFirstName',
            Birthdate__c = Date.today(),
            Home_Phone__c = '1234567890',
            mplc_Signature__c = 'TestSignature',
            Community_Activities__c = true,
            DateOfSignature__c = Date.today()
        );
        insert testIntake;
        
        ApexPages.currentPage().getParameters().put('id', testIntake.Id);
        
        // Set up test data
        MplcPermissionsVfpageController controller = new MplcPermissionsVfpageController();
        controller.studentName = 'TestStudent';
        controller.studentbirthday = Date.today();
        controller.homephone = '9876543210';
        controller.signatureinput522 = 'TestSignatureInput';
        controller.signName522 = 'TestSign';
        controller.isParticipate = false; // Set to false for testing
        controller.DateOfSignature = Date.today();
        
        Test.startTest();
        ApexPages.currentPage().getParameters().put('id', testIntake.Id);
        
        // Call the MPLCSave method
        controller.getData(testIntake.Id);
        
        Test.stopTest();
        System.assertEquals(true, controller.isParticipate);        
    }
}