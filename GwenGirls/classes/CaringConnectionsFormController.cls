public without sharing class CaringConnectionsFormController {

    @AuraEnabled(cacheable=true)
    public static Map<String, List<fieldsWrapper>> getFieldsValues(){
        Map<String, List<fieldsWrapper>> mapOfFieldsValues=new Map<String, List<fieldsWrapper>>();
        mapOfFieldsValues.put('neighborhood',getFieldsMetadata('Contact','Neighborhood_CC__c'));
        mapOfFieldsValues.put('staffCompletingIntake',getCompletingStaff());
        mapOfFieldsValues.put('genderIdentity',getFieldsMetadata('Contact','GenderIdentity'));
        mapOfFieldsValues.put('genderPronouns',getFieldsMetadata('Contact','GenderPronouns__c'));
        mapOfFieldsValues.put('racialEthnicIdentity',getFieldsMetadata('Contact','Racial_Ethnic_Identity__c'));
        mapOfFieldsValues.put('youthrelationship',getFieldsMetadata('Contact','Primary_Guardian_Relationship__c'));
        mapOfFieldsValues.put('primaryConcern',getFieldsMetadata('Contact','Primary_Reason_for_Referral__c'));
        mapOfFieldsValues.put('secondaryConcern',getFieldsMetadata('Contact','Secondary_Reason_for_Referral__c'));
        mapOfFieldsValues.put('thirdConcern',getFieldsMetadata('Contact','Additional_Reason_for_Referral__c'));
        mapOfFieldsValues.put('needsCategory',getFieldsMetadata('Contact','Needs_Category__c'));
        mapOfFieldsValues.put('immediateSafetyConcerns',getFieldsMetadata('Contact','ImmediateSafetyConcerns__c'));
        mapOfFieldsValues.put('clientHasaSafetyPlan',getFieldsMetadata('Contact','ClientHasaSafetyPlan__c'));
        mapOfFieldsValues.put('previousSystemInvolvement',getFieldsMetadata('Contact','Previous_System_Involvement__c'));
        mapOfFieldsValues.put('guardianConsentReceived',getFieldsMetadata('Contact','GuardianConsentReceived__c'));
        mapOfFieldsValues.put('clientConsentReceived14YOA',getFieldsMetadata('Contact','ClientConsentReceived14YOA__c'));
        mapOfFieldsValues.put('guardianState',getFieldsMetadata('Contact','Guardian_State__c')); 
        mapOfFieldsValues.put('HousingType',getFieldsMetadata('Contact','Housing_Type__c')); 
        mapOfFieldsValues.put('referralType',getFieldsMetadata('Intake__c','Referral_Source_Type__c')); 
        mapOfFieldsValues.put('referralTypeExpanded',getFieldsMetadata('Intake__c','Referral_Source_Type_Expanded__c')); 
        mapOfFieldsValues.put('reasonForReferral',getFieldsMetadata('Intake__c','Reason_for_Referral_By_Referrer__c')); 
        return mapOfFieldsValues;  
    }
    
    
    public static List<fieldsWrapper> getFieldsMetadata(String objectName,String fieldName){
         List<fieldsWrapper> neighborhoodOption=new List<fieldsWrapper>();
         List<Schema.DescribeSobjectResult> results = Schema.describeSObjects(new List<String>{objectName});
        for(Schema.DescribeSobjectResult res : results) {
            for (Schema.PicklistEntry entry : res.fields.getMap().get(fieldName).getDescribe().getPicklistValues()) {
                if (entry.isActive()) {
                    fieldsWrapper fw=new fieldsWrapper();
                    fw.label=entry.getLabel();
                	fw.value=entry.getValue();
					neighborhoodOption.add(fw);
                }
            }
        }
        return neighborhoodOption;
    }
    
    public static List<fieldsWrapper> getCompletingStaff(){
		 List<fieldsWrapper> completingStaffOption=new List<fieldsWrapper>();
        // [SELECT Id,FirstName,LastName FROM User WHERE IsActive = true AND UserRoleId='00E2M000001i1pbUAA']
        for(User userObj:  [SELECT Id,Name,FirstName,LastName FROM User Where IsActive = true AND (Name LIKE '%Summer Haston%' OR Name LIKE '%Tymar Sutton%' OR Name LIKE '%Ryan Lewis%' OR  Name LIKE '%Alexis Young%' OR Name LIKE '%Miona Harvey%' ) ]){
            fieldsWrapper fw=new fieldsWrapper();
             fw.label=userObj.FirstName+' '+userObj.LastName;
             fw.value=userObj.Id;
            completingStaffOption.add(fw);
        }
        return completingStaffOption;
    }
    
    @AuraEnabled
    public static Contact upsertParentContact(String parentContactString){
        Contact conObj=(Contact)JSON.deserialize(parentContactString,Contact.class);
        conObj.RecordTypeId=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId(); 
        upsert conObj;
        return conObj;
    }
    
    @AuraEnabled(cacheable=true)
    public static GGFormController.contactIntakeWrapper getExistingRecord(String parentId){
          GGFormController.contactIntakeWrapper cIWrapper=new GGFormController.contactIntakeWrapper();  
        if(parentId!='nullId'){
            cIWrapper.parentContact=[Select id,FirstName,LastName,HomePhone,Mobile_Phone__c,Housing_Type__c,Household_Monthly_Income__c,npe01__WorkPhone__c,Primary_Guardian_Relationship__c,BestTimetoContactGuardian__c,MailingStreet,MailingCity,MailingState,MailingPostalCode,npe01__HomeEmail__c,Place_of_Employment__c,Guardian_Street__c,Guardian_City__c,Guardian_State__c,Guardian_Zip__c,Email,GuardianConsentReceived__c,ClientConsentReceived14YOA__c,WhyHasConsentNotBeenReceived__c,AdditionalInformationRegardingConsent__c from Contact Where Id=:parentId ];
            cIWrapper.childContact=[Select Id, FirstName, LastName,Referral_Source_First__c,Referral_Source_Last__c,Referrer_Title__c,ReferralPhone__c,Referral_Source_Type__c,Referral_Source_Type_Other__c,Reason_for_Referral_By_Referrer__c,  BestTimetoContactGuardian__c,AdditionalInformationRegardingConsent__c, Comments__c,Guardian_Street__c,Guardian_City__c,Guardian_State__c,Guardian_Zip__c,GuardianConsentReceived__c,ClientConsentReceived14YOA__c, Neighborhood_CC__c,Other_Neighborhood_CC__c, Brief_Explanation__c, Safety_plan_explanation__c, Primary_Guardian_Relationship__c, birthdate, GenderIdentity, GenderPronouns__c, Race__c,MobilePhone, Racial_Ethnic_Identity__c, case__c, HomePhone, PreferredName__c, Race_Other_Identity_Expansion__c, Primary_Reason_for_Referral__c, Secondary_Reason_for_Referral__c, Additional_Reason_for_Referral__c, Needs_Category__c, ImmediateSafetyConcerns__c, Previous_System_Involvement__c, ClientHasaSafetyPlan__c, CYFCaseNumber__c, Case_Worker__c, CYF_Case_Worker__c, RegionalOfficeforCYFServices__c, CYF_Active__c from Contact where RecordType.Name='Child (CC)' and Name_of_Primary_Parent_Guardian__c=:parentId];
        }
        return cIWrapper; 
    }

    public class fieldsWrapper{
        @AuraEnabled
        public String label;
        @AuraEnabled
        public String value;
    }
}