@isTest
public class CcEnrollmentFromGenerateIntakPDFTest {
 @isTest
    static void testBatchExecution() {
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

        // Instantiate the batch class
        CcEnrollmentFromGenerateIntakPDF batchInstance = new CcEnrollmentFromGenerateIntakPDF(testIntake.Id);

        // Start the batch job
        Test.startTest();
        Database.executeBatch(batchInstance);
        Test.stopTest();

      
        // Retrieve the updated Intake record after the batch job
        Intake__c updatedIntake = [SELECT Id, PDF_Generated__c FROM Intake__c WHERE Id = :testIntake.Id];

        // Verify that the PDF_Generated__c field is set to true
        System.assertEquals(true, updatedIntake.PDF_Generated__c, 'PDF_Generated__c should be set to true');
    }
}