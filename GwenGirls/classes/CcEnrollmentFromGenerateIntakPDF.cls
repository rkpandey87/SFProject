Global class CcEnrollmentFromGenerateIntakPDF Implements Database.Batchable<sObject>, Database.stateful{
    Global string recId;
    Global  CcEnrollmentFromGenerateIntakPDF (string recordId) {
        this.recId = recordId;
        System.debug('##cv----> '+recordId);
    }  
    
    Global Database.QueryLocator Start(Database.BatchableContext bc){
        string strQuery='select Id from Intake__c where Id =:recId';        
        return Database.getQueryLocator(strQuery);  
    }
    Global void Execute(Database.BatchableContext bc,List<Intake__c> scope){
        System.debug('##scope----> '+scope); 
        PageReference pdfPage = Page.CcEnrollmentForm;
        pdfPage.getParameters().put('id', scope[0].Id);
        BLOB pdfBlob;
        IF (!Test.isRunningTest()) {
            pdfBlob = pdfPage.getContentAsPDF(); //generate the pdf BLOB
        } ELSE { 
            pdfBlob = BLOB.valueOf('Test');
        }
        
        // Create a ContentVersion record for the PDF
        ContentVersion cv = new ContentVersion();
        cv.Title = 'GeneratedPDF.pdf';
        cv.VersionData = pdfBlob;
        cv.PathOnClient = 'GeneratedPDF.pdf';
        cv.FirstPublishLocationId  = userinfo.getUserId();
        insert cv;
        
        //Associate the ContentVersion with the Intake record
        ContentVersion docLink = [SELECT Id,ContentDocumentId FROM ContentVersion WHERE Id =:cv.Id];
        
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = docLink.ContentDocumentId;
        cdl.LinkedEntityId = scope[0].Id;
        cdl.ShareType = 'V';
        cdl.Visibility = 'AllUsers';
        insert cdl;
        
        scope[0].PDF_Generated__c = true;
        update scope[0];
    }
    Global void Finish(Database.BatchableContext bc){
    }    
}