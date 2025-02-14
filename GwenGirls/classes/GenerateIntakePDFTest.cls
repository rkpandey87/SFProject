@isTest
public class GenerateIntakePDFTest {
 @isTest
    static void testGenerateIntakePDFBatch() {
        // Create test data: Intake record
        Intake__c testIntake = new Intake__c(
            First_Name__c = 'TestFirstName',
            Birthdate__c = Date.today(),
            Home_Phone__c = '1234567890',
            mplc_Signature__c = 'TestSignature',
            Community_Activities__c = true,
            DateOfSignature__c = Date.today()
        );
        insert testIntake;
        
        // Create an instance of the batch class
        GenerateIntakePDF batchInstance = new GenerateIntakePDF(testIntake.Id);
        
        // Start the batch job
        Test.startTest();
        Database.executeBatch(batchInstance);
        Test.stopTest();
        
        // Verify that the PDF_Generated__c field is set to true
        Intake__c updatedIntake = [SELECT Id, PDF_Generated__c FROM Intake__c WHERE Id = :testIntake.Id LIMIT 1];
        System.assertEquals(true, updatedIntake.PDF_Generated__c, 'PDF_Generated__c field should be true');
        
        // Verify that the ContentDocumentLink is created
        ContentDocumentLink cdl = [SELECT Id FROM ContentDocumentLink WHERE LinkedEntityId = :testIntake.Id LIMIT 1];
        System.assertNotEquals(null, cdl, 'ContentDocumentLink should be created');
    }
    
}