global without sharing class CcEnrollmentFormController {
    
    public Boolean isPdfMode { get; set; }
    public Intake__c Intake{get;set;}
    
    Id CcEf = Schema.SObjectType.Intake__c.getRecordTypeInfosByName().get('Caring Connections').getRecordTypeId();
    
    global CcEnrollmentFormController(ApexPages.StandardController Intake) {
        
        if(ApexPages.currentPage().getParameters().containsKey('id') ) {
            string recordId = ApexPages.currentPage().getParameters().get('id');
            
            getData(recordId);
        }
    }
    
    public void getData(string recordId) {
        Intake = [Select
                  First_Name__c
                  ,Last_Name__c
                  ,AdditionalInformationRegardingConsent__c
                  ,PreferredName__c
                  ,Gender_Identity__c
                  , Home_Phone__c
                  , Community_Activities__c
                  ,Signature_TC__c
                  ,Race__c
                  ,Race_Other__c
                  ,Birthdate__c
                  ,Age__c
                  ,GenderPronouns__c
                  ,GuardianPhone__c
                  ,Mailing_Street__c
                  ,Mailing_City__c
                  ,Mailing_State__c
                  ,Mailing_Zip_Code__c
                  , Guardian_Street__c
                  ,Guardian_City__c
                  ,Guardian_State__c
                  ,Guardian_Zip__c
                  ,Additional_Information__c
                  ,Comments__c
                  ,Brief_Explanation__c
                  ,CYFCaseNumber__c
                  ,CYF_Case_Worker__c
                  ,Case_Worker__c
                  ,RegionalOfficeforCYFServices__c
                  ,Primary_Guardian_First__c
                  ,Primary_Guardian_Last__c
                  ,Primary_Guardian_Relationship__c
                  ,Personal_Email__c
                  ,Gender__c
                  ,Youth_Signature__c
                  ,mplc_Signature__c
                  ,CYF_Active__c
                  ,Neighborhood_CC__c
                  ,Owner.Name
                  ,Owner.Title
                  ,Owner.Phone
                  ,Primary_Reason_for_Referral__c
                  ,Primary_Reason_for_Referral_Expanded__c
                  ,Additional_Reason_for_Referral__c
                  ,Additional_Reason_for_Referral_Expanded__c
                  ,Community_Collaborative__c
                  from Intake__c where Id=:recordId];
        
    }
}