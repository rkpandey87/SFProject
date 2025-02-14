Global class MplcGeneratepdfIntak Implements Database.Batchable<sObject>, Database.stateful{
    Global string recId;
    Global  MplcGeneratepdfIntak (string recordId) {
        this.recId = recordId;
        System.debug('##cv----> '+recordId);
    }  
    
    Global Database.QueryLocator Start(Database.BatchableContext bc){
        string strQuery='select Id,RecordType.name from Intake__c where  Id =:recId';  
        return Database.getQueryLocator(strQuery);  
    }
    Global void Execute(Database.BatchableContext bc,List<Intake__c> scope){
        
        System.debug('##scope----> '+scope);
        PageReference pdfPage;
        BLOB pdfBlob;
        if(scope[0].RecordType.name=='MPLC'){
            pdfPage =  Page.MplcPermissionsVfpage;
        }
        else if(scope[0].RecordType.name == 'Caring Connections'){
            pdfPage = Page.CcEnrollmentForm;
        }
        else if(scope[0].RecordType.name == 'Youth Development'){
            pdfPage = Page.ggsiteVfForm;
        }
         pdfPage.getParameters().put('id', scope[0].Id);
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