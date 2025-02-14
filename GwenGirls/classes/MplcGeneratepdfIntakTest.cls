@isTest
public class MplcGeneratepdfIntakTest {
    static testMethod void testBatchJobForMPLC() {
        RecordType mplcRecordType = [SELECT Id,name FROM RecordType WHERE SObjectType = 'Intake__c' AND DeveloperName = 'MPLC' LIMIT 1];
        
        // Create a test Intake record
        
    Intake__c testIntake = new Intake__c(
            First_Name__c = 'TestFirstName',
            Birthdate__c = Date.today(),
            Home_Phone__c = '1234567890',
            RecordTypeId = mplcRecordType.Id,
            mplc_Signature__c = 'TestSignature',
            Community_Activities__c = true,
            DateOfSignature__c = Date.today()
        );
        
        insert testIntake;
        
        // Set up test data with the Intake record ID
        MplcGeneratepdfIntak batchJob = new MplcGeneratepdfIntak(testIntake.Id);
        
        Test.startTest();
        // Execute the batch job
        Database.executeBatch(batchJob);
        Test.stopTest();
        
        // Retrieve the updated Intake record
        Intake__c updatedIntake = [SELECT Id, PDF_Generated__c FROM Intake__c WHERE Id = :testIntake.Id];
        
        // Assert that the PDF_Generated__c field was updated
        System.assertEquals(true, updatedIntake.PDF_Generated__c);
    }
    
    static testMethod void testBatchJobForCC() {
        RecordType ccRecordType = [SELECT Id FROM RecordType WHERE SObjectType = 'Intake__c' AND DeveloperName = 'Caring_Connections' LIMIT 1];
        
        // Create a test Intake record
        
    Intake__c testIntake = new Intake__c(
            First_Name__c = 'TestFirstName',
            Birthdate__c = Date.today(),
            Home_Phone__c = '1234567890',
            RecordTypeId = ccRecordType.Id,
            mplc_Signature__c = 'TestSignature',
            Community_Activities__c = true,
            DateOfSignature__c = Date.today()
        );
        
        insert testIntake;
        
        // Set up test data with the Intake record ID
        MplcGeneratepdfIntak batchJob = new MplcGeneratepdfIntak(testIntake.Id);
        
        Test.startTest();
        // Execute the batch job
        Database.executeBatch(batchJob);
        Test.stopTest();
        
        // Retrieve the updated Intake record
        Intake__c updatedIntake = [SELECT Id, PDF_Generated__c FROM Intake__c WHERE Id = :testIntake.Id];
        
        // Assert that the PDF_Generated__c field was updated
        System.assertEquals(true, updatedIntake.PDF_Generated__c);
    }
    
    static testMethod void testBatchJobForYouth() {
        RecordType youthRecordType = [SELECT Id FROM RecordType WHERE SObjectType = 'Intake__c' AND DeveloperName = 'Youth_Development' LIMIT 1];        
        // Create a test Intake record
        
    Intake__c testIntake = new Intake__c(
            First_Name__c = 'TestFirstName',
            Birthdate__c = Date.today(),
            Home_Phone__c = '1234567890',
            RecordTypeId = youthRecordType.Id,
            mplc_Signature__c = 'TestSignature',
            Community_Activities__c = true,
            DateOfSignature__c = Date.today()
        );
        
        insert testIntake;
        
        // Set up test data with the Intake record ID
        MplcGeneratepdfIntak batchJob = new MplcGeneratepdfIntak(testIntake.Id);
        
        Test.startTest();
        // Execute the batch job
        Database.executeBatch(batchJob);
        Test.stopTest();
        
        // Retrieve the updated Intake record
        Intake__c updatedIntake = [SELECT Id, PDF_Generated__c FROM Intake__c WHERE Id = :testIntake.Id];
        
        // Assert that the PDF_Generated__c field was updated
        System.assertEquals(true, updatedIntake.PDF_Generated__c);
    }
}