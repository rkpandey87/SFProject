public without sharing class YouthDevelopmentIntakeFormController {
    
    public String Value {get;set;}
    
    public static String intakeRecordId {get;set;}
    Public List<Intake__c> intakeList{get;set;}
    public static string sAttName{get;set;}
    public static blob sAttBody{get;set;}
    public static string sAttType{get;set;}
     public string signatureinput {get;set;}
    public String signName { get;set;}
    public String signatureinput1 { get; set; }
    public String signName1 { get;set;}
    public String signatureinput2 { get; set; }
    public String signName2 { get;set;}
    public String signatureinput3 { get; set; }
    public String signName3 { get;set;}
    public String signatureinput4 { get; set; }
    public String signName4 { get;set;}
    public String signatureinput5 { get; set; }
    public String signName5 { get;set;}
    public String signatureinput6 { get; set; }
    public String signName6 { get;set;}
    public String signatureinput7 { get; set; }
    public String signName7 { get;set;}

    
    
    public YouthDevelopmentIntakeFormController(ApexPages.StandardController intake){
        Value= '&';
        
    }
    
     public void setSignature(){
        signName = signName; 
        
    }
    public void setSignature1(){
        
        signName1=signName1;
    }
    public void setSignature2(){
        
        signName2=signName2;
    }
    public void setSignature3(){
        
        signName3=signName3;
    }
    public void setSignature4(){
        
        signName4=signName4;
    }
    public void setSignature5(){
        
        signName5=signName5;
    }
    public void setSignature6(){
        
        signName6=signName6;
    }
    public void setSignature7(){
        
        signName7=signName7;
    }
    
    
    
    /*               Working                   */
    @AuraEnabled
    public static void saveIntakeData(decimal wt, decimal ht, string rc,date dt, string ssn,decimal grd, date condt){
        // decimal ht
        
        try{
            Intake__c inkRec= new Intake__c();
            inkRec.Name= 'GGTestForm';
            inkRec.D_O_B__c=dt;
            inkRec.SSN__c= ssn;
            inkRec.Weight_NUM__c= wt;
            inkRec.Height_feet__c= ht;
            inkRec.Race_TXT__c= rc;
            inkRec.Consent_Signed__c=condt;
            inkRec.Grade__c= grd;
            insert inkRec;
            intakeRecordId=inkRec.id;
            system.debug('##Intake__c===========> '+inkRec);
            system.debug('##intakeRecordId===========> '+intakeRecordId);
           
            
         /*   ContentDocumentLink cDocLink;
            ContentVersion cVersion;    
           // Intake__c intkRec;
            pageReference pdfPage;
            Blob pdfBody;
            Id conDocument;
            pdfPage = Page.youthDevelopmentFormAttachWithFile;
            pdfPage.getParameters().put('id',intakeRecordId);
            if(Test.isRunningTest()) { 
                pdfBody = blob.valueOf('Unit.Test');
            } else {
                  pdfBody = pdfPage.getContent();
                //pdfBody = pdfPage.getContentAsPdf();
            }
            System.debug('pdfBody==>'+pdfBody);        
            
            attachment pdfFile = new attachment();
            pdfFile.isPrivate  = false;
            pdfFile.body       = pdfBody;
            pdfFile.parentId   =intakeRecordId; // '5003B000005oRIx';
            pdfFile.Name       = 'Youth Development Intake form.pdf';        
            insert pdfFile; 
            system.debug('## pdfFile===>'+pdfFile);
            */
    
        
            /*
       // PageReference pdfPage = new PageReference('/apex/youthDevelopmentFormAttachWithFile?id=' + intakeRecordId);
        pageReference pdfPage;
         pdfPage = Page.youthDevelopmentFormAttachWithFile;
            Blob pdfBlob;
            pdfBlob = pdfPage.getContent();
       // pdfBlob = pdfPage.getContentAsPDF();
        // Save, email or handle the PDF as needed
        
        ContentVersion cont = new ContentVersion();
        cont.Title = 'GeneratedPDF';
        cont.PathOnClient = 'GeneratedPDF.pdf';
        cont.VersionData = pdfBlob;
        cont.Origin = 'H';
        insert cont;
         system.debug('##cont===========> '+cont);  
           */ 
         
        }catch(Exception ex){
            throw new AuraHandledException(ex.getMessage());
        }
 generatePDF1(intakeRecordId);
    }
    
    /*
    @AuraEnabled
    public static void generatePDFMethod() {
        PageReference pdfPage = new PageReference('/apex/youthDevelopmentFormAttachWithFile?id=' + intakeRecordId);
        Blob pdfBlob;
        pdfBlob = pdfPage.getContentAsPDF();
        // Save, email or handle the PDF as needed
        
        ContentVersion cont = new ContentVersion();
        cont.Title = 'GeneratedPDF';
        cont.PathOnClient = 'GeneratedPDF.pdf';
        cont.VersionData = pdfBlob;
        cont.Origin = 'H';
        insert cont;
         system.debug('##cont===========> '+cont);
        
    }
*/
    @AuraEnabled
public static void generatePDF1(String recordId) {
    PageReference pdfPage = new PageReference('/apex/youthDevelopmentFormAttachWithFile?id=' + recordId);
    Blob pdfBlob;
    pdfBlob = pdfPage.getContent();
    //pdfBlob = pdfPage.getContentAsPDF();
    
    ContentVersion cont = new ContentVersion();
    cont.Title = 'GeneratedPDF';
    cont.PathOnClient = 'GeneratedPDF.pdf';
    cont.VersionData = pdfBlob;
    cont.Origin = 'V';
    insert cont;
    system.debug('##cont===========> '+cont);
}

    
    
    
     @AuraEnabled
    public static blob generatePDF() { 
        ContentDocumentLink cDocLink;
        ContentVersion cVersion;    
        Intake__c intkRec;
        pageReference pdfPage;
        Blob pdfBody;
        Id conDocument;
        ContentDistribution cd;
        system.debug('## intakeRecordId--------->>'+intakeRecordId);
        if(intakeRecordId != Null) {
            intkRec = [SELECT Id, Name, D_O_B__c, SSN__c,Weight_NUM__c,Height_feet__c,Race_TXT__c,
                       Consent_Signed__c,Grade__c FROM Intake__c where id =:intakeRecordId Limit 1]; 
            
            
            pdfPage = Page.youthDevelopmentFormAttachWithFile;
            pdfPage.getParameters().put('id',intakeRecordId);
            if(Test.isRunningTest()) { 
                pdfBody = blob.valueOf('Unit.Test');
            } else {
                
              //  pdfBody = pdfPage.getContent();
              
                  pdfBody = pdfPage.getContentAsPdf();
            }
            System.debug('pdfBody==>'+pdfBody);
            
            
            // insert  pdf file into attachement 
            /*       
attachment pdfFile = new attachment();
pdfFile.isPrivate  = false;
pdfFile.body       = pdfBody;
pdfFile.parentId   = cont.Id; // '5003B000005oRIx';
pdfFile.Name       = 'Sdf Registration Form.pdf';        
insert pdfFile; 
system.debug('## pdfFile===>'+pdfFile);

*/   
            
            
            // insert  pdf file into File 
            cVersion = new ContentVersion();
            cVersion.ContentLocation = 'S';                         
            cVersion.PathOnClient ='Youth Development Intake form.pdf';       
            cVersion.Title = 'Youth Development Intake form.pdf ';         
            cVersion.VersionData = pdfBody;                   
            Insert cVersion;
            System.debug('cVersion==>'+cVersion);
            System.debug('File Title==>'+cVersion.Title );
            
            //After saved the Content Verison, get the ContentDocumentId
            conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id].ContentDocumentId;
            
            //Insert ContentDocumentLink
            cDocLink = new ContentDocumentLink();
            cDocLink.ContentDocumentId = conDocument;            
            cDocLink.LinkedEntityId = intkRec.Id;                    
            cDocLink.ShareType = 'V';                             
            cDocLink.Visibility = 'AllUsers';                  
            Insert cDocLink;
            System.debug('cDocLink==>'+cDocLink);
        //    return new pdfBody(intkRec.id);
            
        }
        return pdfBody;
    } 
   
    
    /*
@AuraEnabled(cacheable=true)
public static List<wrapperList> getIntakeDetails() {
List<Intake__c> intakeList= [Select Id
,Race_TXT__c
,Weight_NUM__c
,Height_feet__c
,D_O_B__c
,Name 
from Intake__c];
System.debug('##intakeList-----> '+intakeList);

List<wrapperList> wprList= new List<wrapperList>();

if(intakeList!=Null && intakeList.size()>0){
for(Intake__c lct: intakeList){
wrapperList wl= new wrapperList();
wl.dob= lct.D_O_B__c;
wl.race= lct.Race_TXT__c;
wl.weight= lct.Weight_NUM__c;
wl.height= lct.Height_feet__c;
wprList.add(wl);
System.debug('##wprList-----> '+wprList);
}
}
return wprList;
}



public class wrapperList{
@AuraEnabled
public string name{get;set;}
@AuraEnabled
public date dob{get;set;} 
@AuraEnabled
public string race{get;set;}
@AuraEnabled
public decimal weight{get;set;}
@AuraEnabled
public decimal height{get;set;}
}

*/
    
}