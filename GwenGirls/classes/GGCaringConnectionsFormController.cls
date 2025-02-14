public without sharing class GGCaringConnectionsFormController {
    public static String childId {get;set;}
    public static List<Intake__c> newRecList {get;set;}
    public static List<User> usrlist {get;set;}
    public static String intakeRecordId {get;set;} 
    public static String parentRecordId {get;set;}
    public static List<Contact> getChildRecList {get;set;}
    public static List<Contact> updateParentRecList{get;set;}
    public static date dateOfSignature{get;set;}
    public static List<Schema.PicklistEntry> pick_list_values {get;set;}    
    public static List<selectOption> options {get;set;}
    //public static String errMSG {get;set;}
    //   public static List<String> selectedValues {get;set;}
    public static string select1 {get;set;} 
    
    
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getPrimaryConcrnExpanMultiPicklistVal(){
        // List<string> pickListValues = new List<string>();
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Primary_Reason_for_Referral_Expanded__c.getDescribe();
        // WrapperAllValues wprdefVal= new WrapperAllValues();   
        //  wprdefVal.label= '--Select--';
        // wprdefVal.value=  '--Select--';
        //  pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            //wprAll.add(pickVal.getValue());
            //  wprAll.add(pickVal.getLabel());
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            System.debug('##pickListValues----> '+pickListValues);
        }
        return pickListValues;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getSecConcernExpanMultiPicklistVal(){
        // List<string> pickListValues = new List<string>();
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Secondary_Reason_for_Referral_Expanded__c.getDescribe();
        // WrapperAllValues wprdefVal= new WrapperAllValues();   
        //  wprdefVal.label= '--Select--';
        // wprdefVal.value=  '--Select--';
        //  pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            //wprAll.add(pickVal.getValue());
            //  wprAll.add(pickVal.getLabel());
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }
        
        return pickListValues;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getThirdConcernExpanMultiPicklistVal(){
        // List<string> pickListValues = new List<string>();
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Additional_Reason_for_Referral_Expanded__c.getDescribe();
        // WrapperAllValues wprdefVal= new WrapperAllValues();   
        //  wprdefVal.label= '--Select--';
        // wprdefVal.value=  '--Select--';
        //  pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            //wprAll.add(pickVal.getValue());
            //  wprAll.add(pickVal.getLabel());
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }
        
        return pickListValues;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getNeedCategoryExpanMultiPicklistVal(){
        // List<string> pickListValues = new List<string>();
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Needs_Category__c.getDescribe();
        // WrapperAllValues wprdefVal= new WrapperAllValues();   
        //  wprdefVal.label= '--Select--';
        // wprdefVal.value=  '--Select--';
        //  pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            //wprAll.add(pickVal.getValue());
            //  wprAll.add(pickVal.getLabel());
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }
        
        return pickListValues;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getPrevSystemInvolveExpanMultiPicklistVal(){
        // List<string> pickListValues = new List<string>();
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Previous_System_Involvement__c.getDescribe();
        // WrapperAllValues wprdefVal= new WrapperAllValues();   
        //  wprdefVal.label= '--Select--';
        // wprdefVal.value=  '--Select--';
        //  pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            //wprAll.add(pickVal.getValue());
            //  wprAll.add(pickVal.getLabel());
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }
        
        return pickListValues;
    }
    
    
    
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getGenderIdentityPicklistVal(){
        // List<string> pickListValues = new List<string>();
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.GenderIdentity.getDescribe();
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            //wprAll.add(pickVal.getValue());
            //  wprAll.add(pickVal.getLabel());
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }
        
        return pickListValues;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getRacialEthnicIdentityPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Racial_Ethnic_Identity__c.getDescribe();
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }   
        return pickListValues;
    }
    
    
    
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getGenderPronounsPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.GenderPronouns__c.getDescribe();
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            //wprAll.add(pickVal.getValue());
            //  wprAll.add(pickVal.getLabel());
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }   
        return pickListValues;
    }
    
    
    
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getPrimaryConcrnPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Primary_Reason_for_Referral__c.getDescribe();
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            //wprAll.add(pickVal.getValue());
            //  wprAll.add(pickVal.getLabel());
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            //  wprAll.defaultVal= 'Select';
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }   
        return pickListValues;
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getSecondaryConcernPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Secondary_Reason_for_Referral__c.getDescribe();
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            //wprAll.add(pickVal.getValue());
            //  wprAll.add(pickVal.getLabel());
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }   
        return pickListValues;
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getThirdConcernPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Additional_Reason_for_Referral__c.getDescribe();
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            //wprAll.add(pickVal.getValue());
            //  wprAll.add(pickVal.getLabel());
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }   
        return pickListValues;
    }
    
    
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getImmedSafetyConcernPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.ImmediateSafetyConcerns__c.getDescribe();
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            //wprAll.add(pickVal.getValue());
            //  wprAll.add(pickVal.getLabel());
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }   
        return pickListValues;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getSafetyPlanPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.ClientHasaSafetyPlan__c.getDescribe();
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            //wprAll.add(pickVal.getValue());
            //  wprAll.add(pickVal.getLabel());
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }   
        return pickListValues;
    }
    
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getParentGuardianPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Primary_Guardian_Relationship__c.getDescribe();
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            //wprAll.add(pickVal.getValue());
            //  wprAll.add(pickVal.getLabel());
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }   
        return pickListValues;
    }
    
    
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getConsentToParticipatePicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.GuardianConsentReceived__c.getDescribe();
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }   
        return pickListValues;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getYouth14ConsentPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.ClientConsentReceived14YOA__c.getDescribe();
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }   
        return pickListValues;
    }
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getGuardianMailingStatePicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Guardian_State__c.getDescribe();
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);
        
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            WrapperAllValues wprAll= new WrapperAllValues();
            wprAll.label= pickVal.getLabel();
            wprAll.value= pickVal.getValue();
            pickListValues.add(wprAll);
            
            System.debug('##pickListValues----> '+pickListValues);
        }   
        return pickListValues;
    }
    
    
    
    
    @AuraEnabled(cacheable=true)
    public static List<wrapperList> returnChildRecList(string parentRecId){
        
        List<WrapperAllValues> lstPick = getGenderIdentityPicklistVal();
        System.debug('lstPick===> '+lstPick);
        
        List<WrapperAllValues> lstPickRacialEthnicIdentity = getRacialEthnicIdentityPicklistVal();
        System.debug('lstPickRacialEthnicIdentity===> '+lstPickRacialEthnicIdentity);   
        
        List<WrapperAllValues> lstPickGenderPronoun = getGenderPronounsPicklistVal();
        System.debug('lstPickGenderPronoun===> '+lstPickGenderPronoun);
        
        List<WrapperAllValues> lstprimaryConcern = getPrimaryConcrnPicklistVal();
        System.debug('lstprimaryConcern===> '+lstprimaryConcern);
        
        List<WrapperAllValues> lstsecondaryConcern = getSecondaryConcernPicklistVal();
        System.debug('lstsecondaryConcern===> '+lstsecondaryConcern);
        
        List<WrapperAllValues> lstthirdConcern = getThirdConcernPicklistVal();
        System.debug('lstthirdConcern===> '+lstthirdConcern);
        
        List<WrapperAllValues> lstImmSafetyConcern = getImmedSafetyConcernPicklistVal();
        System.debug('lstImmSafetyConcern===> '+lstImmSafetyConcern);
        
        List<WrapperAllValues> lstSafetyPlan = getSafetyPlanPicklistVal();
        System.debug('lstSafetyPlan===> '+lstSafetyPlan);
        
        List<WrapperAllValues> lstParentGuardian = getParentGuardianPicklistVal();
        System.debug('lstParentGuardian===> '+lstParentGuardian);
        
        List<WrapperAllValues> lstConsentToParticipate = getConsentToParticipatePicklistVal();
        System.debug('lstConsentToParticipate===> '+lstConsentToParticipate);
        
        List<WrapperAllValues> lstYouth14Consent = getYouth14ConsentPicklistVal();
        System.debug('lstYouth14Consent===> '+lstYouth14Consent);
        
        List<WrapperAllValues> lstGuardianMailingState = getGuardianMailingStatePicklistVal();
        System.debug('***lstGuardianMailingState===> '+lstGuardianMailingState);  
        
        /* Multipicklist:- */
        List<WrapperAllValues> lstPrimaryConcrnMultiPick = getPrimaryConcrnExpanMultiPicklistVal();
        System.debug('lstPrimaryConcrnMultiPick===> '+lstPrimaryConcrnMultiPick);
        
        
        List<WrapperAllValues> lstSecondaryConcrnMultiPick = getSecConcernExpanMultiPicklistVal();
        System.debug('lstSecondaryConcrnMultiPick===> '+lstSecondaryConcrnMultiPick);
        
        List<WrapperAllValues> lstThirdConcrnMultiPick = getThirdConcernExpanMultiPicklistVal();
        System.debug('lstThirdConcrnMultiPick===> '+lstThirdConcrnMultiPick);
        
        List<WrapperAllValues> lstNeedCategoryMultiPick = getNeedCategoryExpanMultiPicklistVal();
        System.debug('lstNeedCategoryMultiPick===> '+lstNeedCategoryMultiPick);
        
        List<WrapperAllValues> lstPrevSystemInvolveMultiPick = getPrevSystemInvolveExpanMultiPicklistVal();
        System.debug('lstPrevSystemInvolveMultiPick===> '+lstPrevSystemInvolveMultiPick);
        
        
        
        dateOfSignature= System.today();
        List<wrapperList> wprList= new List<wrapperList>();
        if(parentRecId!=NULL){
            getChildRecList= [Select FirstName
                              ,LastName,Comments__c	,Brief_Explanation__c,Safety_plan_explanation__c
                              ,Name_of_Primary_Parent_Guardian__r.FirstName
                              ,Name_of_Primary_Parent_Guardian__r.LastName
                              ,Name_of_Primary_Parent_Guardian__r.HomePhone
                              ,Name_of_Primary_Parent_Guardian__r.BestTimetoContactGuardian__c
                              ,Primary_Guardian_Relationship__c
                              ,Name_of_Primary_Parent_Guardian__r.MailingStreet
                              ,Name_of_Primary_Parent_Guardian__r.MailingCity 
                              ,Name_of_Primary_Parent_Guardian__r.MailingState
                              ,Name_of_Primary_Parent_Guardian__r.MailingPostalCode
                              ,Name_of_Primary_Parent_Guardian__r.Guardian_Street__c
                              ,Name_of_Primary_Parent_Guardian__r.Guardian_City__c
                              ,Name_of_Primary_Parent_Guardian__r.Guardian_State__c
                              ,Name_of_Primary_Parent_Guardian__r.Guardian_Zip__c
                              ,Name_of_Primary_Parent_Guardian__r.Email
                              ,Name_of_Primary_Parent_Guardian__r.npe01__HomeEmail__c
                              
                              ,Name_of_Primary_Parent_Guardian__r.GuardianConsentReceived__c
                              ,Name_of_Primary_Parent_Guardian__r.ClientConsentReceived14YOA__c
                              
                              ,Name_of_Primary_Parent_Guardian__r.WhyHasConsentNotBeenReceived__c
                              ,Name_of_Primary_Parent_Guardian__r.AdditionalInformationRegardingConsent__c
                              ,birthdate
                              ,GenderIdentity
                              ,GenderPronouns__c	
                              ,Race__c
                              ,Racial_Ethnic_Identity__c //Picklist type
                              ,case__c
                              ,HomePhone
                              ,PreferredName__c
                              ,Race_Other_Identity_Expansion__c
                              ,MailingStreet
                              ,MailingCity
                              ,MailingState
                              ,MailingPostalCode
                              ,Primary_Reason_for_Referral__c
                              ,Primary_Reason_for_Referral_Expanded__c
                              ,Secondary_Reason_for_Referral__c
                              ,Secondary_Reason_for_Referral_Expanded__c
                              ,Additional_Reason_for_Referral__c
                              ,Additional_Reason_for_Referral_Expanded__c
                              ,Needs_Category__c
                              ,ImmediateSafetyConcerns__c
                              ,Previous_System_Involvement__c
                              ,ClientHasaSafetyPlan__c
                              ,CYFCaseNumber__c
                              ,Case_Worker__c // cyf phone Number field
                              ,CYF_Case_Worker__c
                              ,RegionalOfficeforCYFServices__c
                              ,CYF_Active__c
                              from Contact where
                              RecordType.Name='Child (CC)' and Name_of_Primary_Parent_Guardian__c=:parentRecId and Name_of_Primary_Parent_Guardian__c!=NULL];
            System.debug('##getChildRecList-----> '+getChildRecList);
        }
        
        if(getChildRecList!=Null && getChildRecList.size()>0){
            for(Contact lct: getChildRecList){
                
                
                wrapperList wl= new wrapperList();
                if(lct.Comments__c!=null){
                    wl.comment=lct.Comments__c;
                }
                
                System.debug('lct.Safety_plan_explanation__c: '+lct.Safety_plan_explanation__c);
                if(lct.Safety_plan_explanation__c!=null){
                  System.debug('working');
                    wl.SafetyPlanExplaination=lct.Safety_plan_explanation__c;
                }
                if(lct.Brief_Explanation__c!=null){
                    wl.briefExplaination=lct.Brief_Explanation__c;
                }
                if(lct.Primary_Reason_for_Referral_Expanded__c!=null){
                    select1= lct.Primary_Reason_for_Referral_Expanded__c;
                    system.debug(select1);
                }
                
                /* Here is the selected value which are split semicolon of Multipicklist field */
                if(lct.Primary_Reason_for_Referral_Expanded__c!=null){
                    wl.selectedValues = lct.Primary_Reason_for_Referral_Expanded__c.split(';');
                    system.debug(wl.selectedValues);
                    
                }
                
                if(lct.Secondary_Reason_for_Referral_Expanded__c!=null){
                    wl.selectedValuesSecConcern = lct.Secondary_Reason_for_Referral_Expanded__c.split(';');
                    system.debug(wl.selectedValuesSecConcern);
                    
                }
                
                if(lct.Additional_Reason_for_Referral_Expanded__c!=null){
                    wl.selectedValuesThirdConcern = lct.Additional_Reason_for_Referral_Expanded__c.split(';');
                    system.debug(wl.selectedValuesThirdConcern);
                    
                }
                
                if(lct.Needs_Category__c!=null){
                    wl.selectedValuesReasonForReferral = lct.Needs_Category__c.split(';');
                    system.debug(wl.selectedValuesReasonForReferral);
                    
                }
                if(lct.Previous_System_Involvement__c!=null){
                    wl.selectedValuesPreviousSystemInvolve = lct.Previous_System_Involvement__c.split(';');
                    system.debug(wl.selectedValuesPreviousSystemInvolve);
                    
                }
                
                /* Picklist selected and all Column  */
                
                if(lstPick!=null){
                    wl.genIdentityColumn= lstPick;
                }
                
                if(lct.GenderIdentity!=null){
                    wl.genIdentitySelectedColumn= lct.GenderIdentity;
                }else{
                    wl.genIdentitySelectedColumn= '--Select--';
                }
                
                if(lstPickRacialEthnicIdentity!=null){
                    wl.racialEthnicIdentityColumn= lstPickRacialEthnicIdentity;
                }
                
                if(lct.Racial_Ethnic_Identity__c!=null){
                    wl.racialEthnicIdentitySelectedColumn= lct.Racial_Ethnic_Identity__c;
                }else{
                    wl.racialEthnicIdentitySelectedColumn= '--Select--';
                }
                
                
                
                if(lstPickGenderPronoun!=null){
                    wl.genPronounColumn= lstPickGenderPronoun;
                }
                
                if(lct.GenderPronouns__c!=null){
                    wl.genPronounSelectedColumn= lct.GenderPronouns__c;
                }else{
                    wl.genPronounSelectedColumn= '--Select--';
                }
                
                
                if(lstprimaryConcern!=null){
                    wl.primaryConcernColumn= lstprimaryConcern;
                }
                
                if(lct.Primary_Reason_for_Referral__c!=null){
                    wl.primaryConcernSelectedColumn= lct.Primary_Reason_for_Referral__c;
                }else{
                    wl.primaryConcernSelectedColumn= '--Select--';
                }
                
                
                /*    Multipicklist    */ 
                if(lstPrimaryConcrnMultiPick!=null){
                    wl.primaryConcernMultiPickColumn= lstPrimaryConcrnMultiPick;
                }
                
                
                if(wl.selectedValues!=null){
                    wl.primaryConcrnMultiPickSelectedColumn= wl.selectedValues;
                }
                
                if(lstSecondaryConcrnMultiPick!=null){
                    wl.secondaryConcernMultiPickColumn= lstSecondaryConcrnMultiPick;
                }
                
                
                if(wl.selectedValuesSecConcern!=null){
                    wl.secondaryConcernMultiPickSelectedColumn= wl.selectedValuesSecConcern;
                }
                
                
                if(lstThirdConcrnMultiPick!=null){
                    wl.thirdConcernMultiPickColumn= lstThirdConcrnMultiPick;
                }
                
                
                if(wl.selectedValuesThirdConcern!=null){
                    wl.thirdConcernMultiPickSelectedColumn= wl.selectedValuesThirdConcern;
                }
                
                
                if(lstNeedCategoryMultiPick!=null){
                    wl.reasonForReferralMultiPickColumn= lstNeedCategoryMultiPick;
                }
                
                
                if(wl.selectedValuesReasonForReferral!=null){
                    wl.reasonForReferralMultiPickSelectedColumn= wl.selectedValuesReasonForReferral;
                }
                
                
                if(lstPrevSystemInvolveMultiPick!=null){
                    wl.previousSystemInvolveMultiPickColumn= lstPrevSystemInvolveMultiPick;
                }
                
                
                if(wl.selectedValuesPreviousSystemInvolve!=null){
                    wl.previousSystemInvolveMultiPickSelectedColumn= wl.selectedValuesPreviousSystemInvolve;
                }
                
                
                
                
                System.debug('wl.primaryConcernMultiPickColumn==> '+wl.primaryConcernMultiPickColumn);
                //  System.debug('wl.primaryConcrnMultiPickSelectedColumn==> '+wl.primaryConcrnMultiPickSelectedColumn);
                
                
                /*                Multipicklist   Closed          */
                
                if(lstsecondaryConcern!=null){
                    wl.secondaryConcernColumn= lstsecondaryConcern;
                }
                
                if(lct.Secondary_Reason_for_Referral__c!=null){
                    wl.secondaryConcernSelectedColumn= lct.Secondary_Reason_for_Referral__c;
                }else{
                    wl.secondaryConcernSelectedColumn= '--Select--';     
                }
                
                if(lstthirdConcern!=null){
                    wl.thirdConcernColumn= lstthirdConcern;
                }
                
                if(lct.Additional_Reason_for_Referral__c!=null){
                    wl.thirdConcernSelectedColumn= lct.Additional_Reason_for_Referral__c;
                }else{
                    wl.thirdConcernSelectedColumn= '--Select--';     
                }
                
                
                
                if(lstImmSafetyConcern!=null){
                    wl.immSafetyConcernColumn= lstImmSafetyConcern;
                }
                
                if(lct.ImmediateSafetyConcerns__c!=null){
                    wl.immSafetyConcernSelectedColumn= lct.ImmediateSafetyConcerns__c;
                }else{
                    wl.immSafetyConcernSelectedColumn= '--Select--';     
                }
                
                
                if(lstSafetyPlan!=null){
                    wl.safetyPlanColumn= lstSafetyPlan;
                }
                
                if(lct.ClientHasaSafetyPlan__c!=null){
                    wl.safetyPlanSelectedColumn= lct.ClientHasaSafetyPlan__c;
                }else{
                    wl.safetyPlanSelectedColumn= '--Select--';     
                }
                
                
                
                if(lstParentGuardian!=null){
                    wl.relationshipToChildColumn= lstParentGuardian;
                }
                
                /*   if(lct.Name_of_Primary_Parent_Guardian__r.Primary_Guardian_Relationship__c!=null){
wl.relationshipToChildSelectedColumn= lct.Name_of_Primary_Parent_Guardian__r.Primary_Guardian_Relationship__c;
}*/
                
                if(lct.Primary_Guardian_Relationship__c!=null){
                    wl.relationshipToChildSelectedColumn= lct.Primary_Guardian_Relationship__c;
                }else{
                    wl.relationshipToChildSelectedColumn= '--Select--';     
                }   
                
                
                
                
                if(lct.Name_of_Primary_Parent_Guardian__r.BestTimetoContactGuardian__c!=null){
                    wl.bestTimeToContactParent= lct.Name_of_Primary_Parent_Guardian__r.BestTimetoContactGuardian__c;
                }
                
                if(lstConsentToParticipate!=null){
                    wl.participateInCC4YouthColumn= lstConsentToParticipate;
                }
                
                if(lct.Name_of_Primary_Parent_Guardian__r.GuardianConsentReceived__c!=null){
                    wl.participateInCC4YouthSelectedColumn= lct.Name_of_Primary_Parent_Guardian__r.GuardianConsentReceived__c;
                }else{
                    wl.participateInCC4YouthSelectedColumn= '--Select--';     
                } 
                
                if(lstYouth14Consent!=null){
                    wl.youth14Column= lstYouth14Consent;
                }
                
                
                if(lct.Name_of_Primary_Parent_Guardian__r.ClientConsentReceived14YOA__c!=null){
                    wl.youth14SelectedColumn= lct.Name_of_Primary_Parent_Guardian__r.ClientConsentReceived14YOA__c;
                }else{
                    wl.participateInCC4YouthSelectedColumn= '--Select--';     
                } 
                
                
                
                
                
                
                if(lct.Id!=null){
                    wl.childRecordId= lct.Id;
                }
                if(lct.FirstName!=null){
                    wl.firstName=lct.FirstName; 
                }
                if(lct.LastName!=null){
                    wl.lastName=lct.LastName;
                }
                if(lct.Birthdate!=null){
                    wl.Dob=lct.Birthdate; 
                }
                if(lct.HomePhone!=null){
                    wl.homePhn= lct.HomePhone;
                }
                if(lct.PreferredName__c!=null){
                    wl.preferedName= lct.PreferredName__c;
                }
                if(lct.MailingStreet!=null){
                    wl.mailingStreet= lct.MailingStreet;
                }				
                
                if(lct.MailingCity!=null){
                    wl.mailingCity= lct.MailingCity;
                }	
                if(lct.MailingState!=null){
                    wl.mailingState= lct.MailingState;
                }	
                if(lct.MailingPostalCode!=null){
                    wl.mailingPostalCode= lct.MailingPostalCode;
                }	
                if(lct.Race_Other_Identity_Expansion__c!=null){
                    wl.identityExpansion= lct.Race_Other_Identity_Expansion__c;
                }
                if(lct.CYFCaseNumber__c!=null){
                    wl.cyfCaseNumber= lct.CYFCaseNumber__c;
                }	
                if(lct.CYF_Case_Worker__c!=null){
                    wl.cyfCaseWorkerName= lct.CYF_Case_Worker__c;
                }	
                if(lct.RegionalOfficeforCYFServices__c!=null){
                    wl.cyfRegionalOfficeServices= lct.RegionalOfficeforCYFServices__c;
                }	
                if(lct.CYF_Active__c!=null){
                    wl.cyfFamilyCase= lct.CYF_Active__c;
                }	
                if(lct.Case_Worker__c!=null){
                    wl.cyfCasePhoneNumber= lct.Case_Worker__c; 
                }	
                if(lct.Race__c!=null){
                    wl.race= lct.Race__c;         
                }	
                if(lct.Name_of_Primary_Parent_Guardian__r.FirstName!=null){
                    wl.parentfName= lct.Name_of_Primary_Parent_Guardian__r.FirstName;
                }	
                if(lct.Name_of_Primary_Parent_Guardian__r.LastName!=null){
                    wl.parentlName= lct.Name_of_Primary_Parent_Guardian__r.LastName;
                }	
                if(lct.Name_of_Primary_Parent_Guardian__r.HomePhone!=null){
                    wl.parentPhnNumber= lct.Name_of_Primary_Parent_Guardian__r.HomePhone; 
                }
                
                /*    if(lct.Name_of_Primary_Parent_Guardian__r.Email!=null){
wl.parentEmail= lct.Name_of_Primary_Parent_Guardian__r.Email; 
}*/
                
                if(lct.Name_of_Primary_Parent_Guardian__r.npe01__HomeEmail__c!=null){
                    wl.parentEmail= lct.Name_of_Primary_Parent_Guardian__r.npe01__HomeEmail__c; 
                }
                
                
                /* Mapped Parent/Guardian  Address*/
                if(lct.Name_of_Primary_Parent_Guardian__r.MailingStreet!=null){
                    wl.parentMailingStreet= lct.Name_of_Primary_Parent_Guardian__r.MailingStreet;
                }					
                
                if(lct.Name_of_Primary_Parent_Guardian__r.MailingCity!=null){
                    wl.parentMailingCity= lct.Name_of_Primary_Parent_Guardian__r.MailingCity; 
                }
                /*   if(lct.Name_of_Primary_Parent_Guardian__r.Guardian_State__c!=null){
wl.parentMailingState= lct.Name_of_Primary_Parent_Guardian__r.Guardian_State__c;
}*/
                
                if(lstGuardianMailingState!=null){
                    wl.guardianMailingStateColumn= lstGuardianMailingState;
                }
                
                
                
                if(lct.Name_of_Primary_Parent_Guardian__r.MailingState!=null){
                    wl.guardianMailingStateSelectedColumn= lct.Name_of_Primary_Parent_Guardian__r.MailingState;
                }else{
                    wl.guardianMailingStateSelectedColumn= '--Select--';     
                }   
                
                if(lct.Name_of_Primary_Parent_Guardian__r.MailingPostalCode!=null){
                    wl.parentMailingPostalCode=lct.Name_of_Primary_Parent_Guardian__r.MailingPostalCode; 
                }
                
                if(lct.Name_of_Primary_Parent_Guardian__r.WhyHasConsentNotBeenReceived__c!=null){
                    wl.whyConsentNotReceived= lct.Name_of_Primary_Parent_Guardian__r.WhyHasConsentNotBeenReceived__c;     
                }
                if(lct.Name_of_Primary_Parent_Guardian__r.AdditionalInformationRegardingConsent__c!=null){
                    wl.additionalInfoRegardingConsent= lct.Name_of_Primary_Parent_Guardian__r.AdditionalInformationRegardingConsent__c;
                }
                if(dateOfSignature!=null){
                    wl.currDateOfSignature=dateOfSignature;
                }
                if(lct.Case__c!=null){
                    wl.caseId= lct.Case__c;
                }				
                
                
                if(wl.childRecordId!=null){
                    childId=  wl.childRecordId; 
                }	
                wl.youthSignature= null;
                wl.printYouthSignature=null;
                wprList.add(wl);
                System.debug('##wl.caseId-----> '+wl.caseId);
                System.debug('##wprList1-----> '+wprList);
                System.debug('##childId-----> '+childId);
                System.debug('######wl.parentfName-----> '+wl.parentfName);
                System.debug('######wl.parentlName-----> '+wl.parentlName);
                System.debug('######wl.parentPhnNumber-----> '+wl.parentPhnNumber);
                System.debug('######wl.race-----> '+wl.race);
                System.debug('##wl.youthSignature-----> '+wl.youthSignature);
            }
        }else{
            /* Check Null Condition for all of these wrapper string to avoid run time error  */
            
            wrapperList wprNewParent= new wrapperList();
            wprNewParent.childRecordId=null; //newRecFlag
            wprNewParent.firstName=null; 
            wprNewParent.Dob=null;
            wprNewParent.homePhn=null;
            wprNewParent.preferedName= null;
            wprNewParent.mailingStreet=null;
            wprNewParent.mailingCity= null;
            wprNewParent.mailingState= null;
            wprNewParent.mailingPostalCode=null;
            wprNewParent.identityExpansion= null;
            wprNewParent.race=null;
            if(lstPick!=null){
                wprNewParent.genIdentityColumn= lstPick;      
            }
            
            if(lstPickRacialEthnicIdentity!=null){
                wprNewParent.racialEthnicIdentityColumn= lstPickRacialEthnicIdentity;
            }
            
            if(lstPickGenderPronoun!=null){
                wprNewParent.genPronounColumn= lstPickGenderPronoun;
            }
            
            if(lstprimaryConcern!=null){
                wprNewParent.primaryConcernColumn= lstprimaryConcern;
            }
            /* Multipicklist */
            if(lstPrimaryConcrnMultiPick!=null){
                wprNewParent.primaryConcernMultiPickColumn= lstPrimaryConcrnMultiPick;
            }
            
            if(lstSecondaryConcrnMultiPick!=null){
                wprNewParent.secondaryConcernMultiPickColumn= lstSecondaryConcrnMultiPick;
            }
            
            if(lstThirdConcrnMultiPick!=null){
                wprNewParent.thirdConcernMultiPickColumn= lstThirdConcrnMultiPick;
            }
            
            if(lstNeedCategoryMultiPick!=null){
                wprNewParent.reasonForReferralMultiPickColumn= lstNeedCategoryMultiPick;
            }
            
            if(lstPrevSystemInvolveMultiPick!=null){
                wprNewParent.previousSystemInvolveMultiPickColumn= lstPrevSystemInvolveMultiPick;
            }
            
            
            
            /*                Multipicklist  Closed              */
            
            if(lstsecondaryConcern!=null){
                wprNewParent.secondaryConcernColumn= lstsecondaryConcern;
            }
            if(lstthirdConcern!=null){
                wprNewParent.thirdConcernColumn= lstthirdConcern;
            }
            
            
            if(lstImmSafetyConcern!=null){
                wprNewParent.immSafetyConcernColumn= lstImmSafetyConcern;
            }
            if(lstSafetyPlan!=null){
                wprNewParent.safetyPlanColumn= lstSafetyPlan;
            }
            if(lstParentGuardian!=null){
                wprNewParent.relationshipToChildColumn= lstParentGuardian;
            }
            if(lstConsentToParticipate!=null){
                wprNewParent.participateInCC4YouthColumn= lstConsentToParticipate;
            }
            if(lstYouth14Consent!=null){
                wprNewParent.youth14Column= lstYouth14Consent;
            }
            wprNewParent.bestTimeToContactParent= null; 
            wprNewParent.parentEmail= null; 
            wprNewParent.cyfCaseNumber= null;
            wprNewParent.cyfCaseWorkerName= null;
            wprNewParent.cyfRegionalOfficeServices= null;
            wprNewParent.cyfFamilyCase= false;
            wprNewParent.cyfCasePhoneNumber= null;   
            wprNewParent.additionalConcern=  null;
            // wprNewParent.racialEthnicIdentity=null; 
            wprNewParent.lastName=null;
            wprNewParent.parentfName= null;
            wprNewParent.parentlName=null;
            wprNewParent.parentPhnNumber=null;
            wprNewParent.parentMailingStreet=null;
            wprNewParent.parentMailingCity=null;
            wprNewParent.parentMailingState=null;
            //  wprNewParent.parentMailingPostalCode=null;
            
            if(lstGuardianMailingState!=null){
                wprNewParent.guardianMailingStateColumn= lstGuardianMailingState;
            }
            //  wprNewParent.personalEmail= null;  
            wprNewParent.whyConsentNotReceived= null;
            wprNewParent.additionalInfoRegardingConsent= null;
            if(dateOfSignature!=null){
                wprNewParent.currDateOfSignature=dateOfSignature;
            }
            
            wprNewParent.youthSignature= null;
            wprNewParent.printYouthSignature=null;
            wprList.add(wprNewParent);
            System.debug('##wprList2-----> '+wprList);
            System.debug('##wprNewParent.youthSignature-----> '+wprNewParent.youthSignature);
            System.debug('##wprNewParent.youthSignature-----> '+wprNewParent.youthSignature);
            System.debug('## wprNewParent.primaryConcernMultiPickColumn Testing-----> '+ wprNewParent.primaryConcernMultiPickColumn);
            
        }
        return wprList;
    }
    
    
    @AuraEnabled
    public static void saveIntakeRecord(string itemData, string mplcSign, string parentId, string neighborhoodPickVal, string usrId,string otherNeighborhood){ 
        
        system.debug('****usrId==========> '+usrId);
        system.debug('###itemData==========> '+itemData);
        system.debug('###mplcSign==========> '+mplcSign);
        system.debug('###parentId==========> '+parentId);
        
        system.debug('###neighborhoodPickVal==========> '+neighborhoodPickVal);
        
        String newParentGuardianId;
        string parentRecdIdVar;
        
        dateOfSignature= System.today();
        if(parentId!=null){
            parentRecdIdVar= parentId;
            system.debug('###parentRecdIdVar==========> '+parentRecdIdVar);
        }
        
        string fname;
        string lname;
        string dob;
        String clientId;
        string parFName;
        string parLName;
        string parPhnNumber;
        string parMailingStreet;
        string parMailingCity;
        string parMailingState;
        string parMailingPostalCode;
        
        string csId;
        string Race;
        string RacialEthnicIdentity;
        string youthSign;
        
        
        /*     Child Rec Expanded Sections Field    */
        String preferName;
        String hmPhone;
        String racialIdentity;
        String identityExpan;
        String mlStreet;
        String mlCity;
        String mlState;
        String mlPostalCode;
        string prsnlEmail;
        
        String cyfCsNo;
        String cyfCsWorkerNm;
        String cyfRegOfficeService;
        boolean cyfFamilyCs;
        String cyfCsPhnNo;
        
        string genderIdentity;
        string genderPronoun;
        string primaryConcern;
        string secondaryConcern;
        string thirdConcern;
        string immSafetyConcern;
        string safetyPlan;
        
        string parentGuardianRelationship;
        string bestTimeToContacParent;
        string consentToParticipate;
        string youth14Consent;
        string allstring;
        string whyConsentNotReceive;
        string additionalInfoConsent;
        string parStandardEml;
        
        
        Map<String, Object> mapItem;
        List<Object> lstItemData;
        system.debug('###itemData===========> '+itemData);
        
        if(itemData!=null){
            lstItemData = (List<Object>)JSON.deserializeUntyped(itemData);
        }
        
        
        try{
            Id caringConnectionsRecTypeId = Schema.SObjectType.Intake__c.getRecordTypeInfosByName().get('Caring Connections').getRecordTypeId();
            Id parentGuardianRTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId(); 
            newRecList = new List<Intake__c>();
            List<wrapperList> wprListNew= new List<wrapperList>();
            List<Contact> newConList= new List<Contact>();
            
            // Created new Parent record to attached their Id in 'New Parent' case scenario.
            If(parentid!=null && parentid!='nullId'){
                
                /* Implemented Logic To Update the  Parent Contact In Case Of Existing RecId*/
                //Email are remaining Into it
                updateParentRecList= new List<Contact>();
                Contact conObj= [Select id,firstName,lastName,HomePhone,MailingStreet,MailingCity,MailingState,MailingPostalCode,npe01__HomeEmail__c,BestTimetoContactGuardian__c from contact where Id=:parentid];
                system.debug('****conObj 1:===========> '+conObj);
                
                
                if(lstItemData!=Null && lstItemData.size()>0){
                    mapItem = (Map<String, Object>) lstItemData[0];
                }
                parFName= string.valueOf(mapItem.get('parentfName')); 
                parLName= string.valueOf(mapItem.get('parentlName'));
                parPhnNumber=string.valueOf(mapItem.get('parentPhnNumber'));
                parMailingStreet= string.valueOf(mapItem.get('parentMailingStreet'));
                parMailingCity= string.valueOf(mapItem.get('parentMailingCity'));
                parMailingState= string.valueOf(mapItem.get('guardianMailingStateSelectedColumn'));
                parMailingPostalCode= string.valueOf(mapItem.get('parentMailingPostalCode'));
                parStandardEml= string.valueOf(mapItem.get('parentEmail'));
                bestTimeToContacParent= string.valueOf(mapItem.get('bestTimeToContactParent'));
                
                system.debug('****parMailingStreet:===========> '+parMailingStreet);
                system.debug('****parMailingCity:===========> '+parMailingCity);
                system.debug('****parMailingState:===========> '+parMailingState);
                system.debug('****parMailingPostalCode:===========> '+parMailingPostalCode);
                
                conObj.firstName= parFName;
                conObj.lastName= parLName;
                conObj.HomePhone= parPhnNumber;
                conObj.mailingStreet= parMailingStreet;
                conObj.mailingCity= parMailingCity;
                conObj.mailingState= parMailingState;
                conObj.mailingPostalCode= parMailingPostalCode;
                conObj.npe01__HomeEmail__c=parStandardEml;
                conObj.BestTimetoContactGuardian__c=bestTimeToContacParent;
                updateParentRecList.add(conObj);
                system.debug('****conObj 2:===========> '+conObj);
                system.debug('****updateParentRecList:===========> '+updateParentRecList);
                system.debug('****updateParentRecList Size:===========> '+updateParentRecList.size());
                
                if(updateParentRecList!=null && updateParentRecList.size()>0){
                    update  updateParentRecList; 
                    system.debug('######updateParentRecList:===========> '+updateParentRecList);
                }
                
                
            }else{
                if(lstItemData!=Null && lstItemData.size()>0){
                    mapItem = (Map<String, Object>) lstItemData[0];
                    system.debug('######mapItem:===========> '+mapItem);
                    system.debug('######lstItemData[0]:===========> '+lstItemData[0]);
                }
                
                if(mapItem.get('parentfName')!=null){
                    parFName= string.valueOf(mapItem.get('parentfName')); 
                    system.debug('######parFName Test Value::===========> '+parFName);
                }
                if(mapItem.get('parentlName')!=null){
                    parLName= string.valueOf(mapItem.get('parentlName')); 
                    system.debug('######parLName Test Value:===========> '+parLName); 
                }
                if(mapItem.get('parentPhnNumber')!=null){
                    parPhnNumber=string.valueOf(mapItem.get('parentPhnNumber'));
                    system.debug('######parPhnNumber Test Value:===========> '+parPhnNumber); 
                }
                if(mapItem.get('parentEmail')!=null){
                    parStandardEml=string.valueOf(mapItem.get('parentEmail'));
                    system.debug('****parPhnNumber Test Value:===========> '+parStandardEml); 
                }
                
                if(mapItem.get('bestTimeToContactParent')!=null){
                    bestTimeToContacParent=string.valueOf(mapItem.get('bestTimeToContactParent'));
                    system.debug('****parPhnNumber Test Value:===========> '+bestTimeToContacParent); 
                }
                
                if(mapItem.get('parentMailingStreet')!=null){
                    parMailingStreet= string.valueOf(mapItem.get('parentMailingStreet'));
                    system.debug('****Street Insert1:===========> '+parMailingStreet); 
                }
                
                if(mapItem.get('parentMailingCity')!=null){
                    parMailingCity= string.valueOf(mapItem.get('parentMailingCity'));
                    system.debug('****City Insert1:===========> '+parMailingCity); 
                }
                
                if(mapItem.get('guardianMailingStateSelectedColumn')!=null){
                    parMailingState= string.valueOf(mapItem.get('guardianMailingStateSelectedColumn'));
                    system.debug('****State Insert1:===========> '+parMailingState); 
                }
                
                if(mapItem.get('parentMailingPostalCode')!=null){
                    parMailingPostalCode= string.valueOf(mapItem.get('parentMailingPostalCode'));
                    system.debug('****Postal Code Insert1:===========> '+parMailingPostalCode); 
                }
                
                
                
                
                
                system.debug('######parFName:===========> '+parFName);
                system.debug('######parLName:===========> '+parLName);
                system.debug('######parPhnNumber:===========> '+parPhnNumber);
                
                // Creating Parent Record as per data collect from User during Intake form Submission
                Contact con= new Contact();
                con.firstName= parFName;
                con.lastName= parLName;
                con.HomePhone= parPhnNumber;
                
                con.npe01__HomeEmail__c= parStandardEml;
                con.BestTimetoContactGuardian__c= bestTimeToContacParent;
                con.MailingStreet= parMailingStreet;
                System.debug('parMailingCity: '+parMailingCity+'  '+parMailingState);
                con.MailingState=  parMailingState;
                con.MailingCity= parMailingCity;
                con.MailingPostalCode= parMailingPostalCode;
                con.RecordTypeId=parentGuardianRTypeId;
                newConList.add(con);
                system.debug('****con.HomePhone:===========> '+newConList);
                system.debug('****CONTACT List Size:===========> '+newConList.size());
                
            }
            
            
            if(newConList!=null && newConList.size()>0){
                insert newConList[0];
                newParentGuardianId= newConList[0].id;
                system.debug('######newParentGuardianId:===========> '+newParentGuardianId);
                system.debug('######newRecList3:===========> '+newConList[0]);
                system.debug('****con.npe01__HomeEmail__c:===========> '+newConList[0].npe01__HomeEmail__c);
                
            }
            
            if(lstItemData!=Null && lstItemData.size()>0){
                for(Object itemObj : lstItemData) {                        
                    mapItem = (Map<String, Object>) itemObj;    
                    System.debug('mapItem: '+mapItem);
                    fname = string.valueof(mapItem.get('firstName'));
                    lname = string.valueOf(mapItem.get('lastName'));                                               
                    dob = string.valueOf(mapItem.get('Dob'));  
                    
                    
                    system.debug('######fname:===========> '+fname);
                    system.debug('######lname:===========> '+lname);
                    system.debug('######dob:===========> '+dob);                  
                    clientId= string.valueOf(mapItem.get('childRecordId')); 
                    parFName= string.valueOf(mapItem.get('parentfName')); 
                    parLName= string.valueOf(mapItem.get('parentlName'));
                    parPhnNumber=string.valueOf(mapItem.get('parentPhnNumber'));
                    
                    /* Inserting Parent details Into Intake from User Input data*/
                    parMailingStreet= string.valueOf(mapItem.get('parentMailingStreet'));
                    parMailingCity= string.valueOf(mapItem.get('parentMailingCity'));
                    parMailingState= string.valueOf(mapItem.get('guardianMailingStateSelectedColumn'));
                    parMailingPostalCode= string.valueOf(mapItem.get('parentMailingPostalCode'));
                    system.debug('****parMailingStreet:===========> '+parMailingStreet); 
                    system.debug('****parMailingCity:===========> '+parMailingCity); 
                    system.debug('****parMailingState:===========> '+parMailingState); 
                    system.debug('****parMailingPostalCode:===========> '+parMailingPostalCode); 
                    
                    
                    csId= string.valueOf(mapItem.get('caseId'));
                    genderIdentity= string.valueOf(mapItem.get('genIdentitySelectedColumn'));
                    genderPronoun= string.valueOf(mapItem.get('genPronounSelectedColumn'));
                    RacialEthnicIdentity= string.valueOf(mapItem.get('racialEthnicIdentitySelectedColumn'));
                    system.debug('****RacialEthnicIdentity:===========> '+RacialEthnicIdentity); 
                    
                    primaryConcern = string.valueOf(mapItem.get('primaryConcernSelectedColumn'));
                    secondaryConcern = string.valueOf(mapItem.get('secondaryConcernSelectedColumn'));
                    thirdConcern = string.valueOf(mapItem.get('thirdConcernSelectedColumn'));
                    immSafetyConcern= string.valueOf(mapItem.get('immSafetyConcernSelectedColumn'));
                    safetyPlan= string.valueOf(mapItem.get('safetyPlanSelectedColumn'));
                    system.debug('######primaryConcern:===========> '+primaryConcern); 
                    
                    /* Issues With these values  */
                    
                    //  bestTimeToContacParentTest= string.valueOf(mapItem.get('additionalInfoRegardingConsent')); 
                    //  additionalInfoConsentTest= string.valueOf(mapItem.get('additionalInfoRegardingConsent')); 
                    parStandardEml= string.valueOf(mapItem.get('parentEmail')); //Test these
                    parentGuardianRelationship= string.valueOf(mapItem.get('relationshipToChildSelectedColumn'));
                    bestTimeToContacParent= string.valueOf(mapItem.get('bestTimeToContactParent'));
                    consentToParticipate= string.valueOf(mapItem.get('participateInCC4YouthSelectedColumn'));
                    youth14Consent= string.valueOf(mapItem.get('youth14SelectedColumn'));
                    whyConsentNotReceive= string.valueOf(mapItem.get('whyConsentNotReceived'));//Test these
                    additionalInfoConsent=string.valueOf(mapItem.get('additionalInfoRegardingConsent'));//Test these
                    
                    preferName= string.valueOf(mapItem.get('preferedName'));
                    hmPhone= string.valueOf(mapItem.get('homePhn'));
                    Race= string.valueOf(mapItem.get('race'));
                    
                    identityExpan= string.valueOf(mapItem.get('identityExpansion'));
                    mlStreet= string.valueOf(mapItem.get('mailingStreet'));
                    mlCity= string.valueOf(mapItem.get('mailingCity'));
                    mlState= string.valueOf(mapItem.get('mailingState'));
                    mlPostalCode= string.valueOf(mapItem.get('mailingPostalCode'));
                    youthSign= string.valueOf(mapItem.get('youthSignature'));
                    //   if(mapItem.get('cyfFamilyCase')!=null){
                    cyfFamilyCs= boolean.valueOf(mapItem.get('cyfFamilyCase'));//boolean.valueOf(mapItem.get('cyfFamilyCase'));
                    //  }
                    
                    
                    System.debug('##youthSign Test===> '+youthSign);
                    System.debug('##cyfFamilyCs Testing===> '+cyfFamilyCs);
                    
                    /* Safety and Risk Assessment */
                    cyfCsNo= string.valueOf(mapItem.get('cyfCaseNumber'));
                    cyfCsWorkerNm =string.valueOf(mapItem.get('cyfCaseWorkerName'));
                    cyfRegOfficeService  =string.valueOf(mapItem.get('cyfRegionalOfficeServices'));
                    cyfCsPhnNo   =string.valueOf(mapItem.get('cyfCasePhoneNumber'));
                    
                    
                    
                    
                    /* Multipicklist value  */
                    
                    string priConcrnMultiPickVal =  string.valueOf(mapItem.get('primaryConcrnMultiPickSelectedColumn'));
                    system.debug('**priConcrnMultiPickVal Testing==> '+priConcrnMultiPickVal);
                    
                    string secConcrnMultiPickVal=  string.valueOf(mapItem.get('secondaryConcernMultiPickSelectedColumn'));
                    system.debug('**secConcrnMultiPickVal Testing==> '+secConcrnMultiPickVal);
                    string thirdConcrnMultiPickVal=  string.valueOf(mapItem.get('thirdConcernMultiPickSelectedColumn'));
                    system.debug('**thirdConcrnMultiPickVal Testing==> '+thirdConcrnMultiPickVal);
                    string rsnForReferralMultiPickVal=  string.valueOf(mapItem.get('reasonForReferralMultiPickSelectedColumn'));
                    system.debug('**rsnForReferralMultiPickVal Testing==> '+rsnForReferralMultiPickVal);
                    string previousSystemInvolveMultiPickVal=  string.valueOf(mapItem.get('previousSystemInvolveMultiPickSelectedColumn'));
                    system.debug('**previousSystemInvolveMultiPickVal Testing==> '+previousSystemInvolveMultiPickVal);
                    
                    
                    // binds the itemData  list with wrapper list to pass clientId to existing child Lookup 
                    wrapperList wlNew= new wrapperList();
                    wlNew.childRecordId= clientId;                   
                    wlNew.firstName= fname;                
                    wlNew.lastName= lname;                
                    wlNew.Dob= date.valueOf(dob);   
                    wlNew.comment=String.valueOf(mapItem.get('comment'));
                    wlNew.briefExplaination=String.valueOf(mapItem.get('SafetyPlanExplaination'));
                    wlNew.SafetyPlanExplaination=String.valueOf(mapItem.get('briefExplaination'));
                    
                    /*    Holding Parent details In Wrapper List     */         
                    wlNew.parentfName=parFName;              
                    wlNew.parentlName=parLName;            
                    wlNew.parentPhnNumber=parPhnNumber;
                    wlNew.parentMailingStreet=parMailingStreet; 
                    wlNew.parentMailingCity=parMailingCity; 
                    wlNew.guardianMailingStateSelectedColumn=parMailingState; 
                    wlNew.parentMailingPostalCode=parMailingPostalCode; 
                    //test these       
                    wlNew.caseId=csId;
                    wlNew.youthSignature=youthSign;
                    wlNew.genIdentitySelectedColumn 	= genderIdentity;
                    wlNew.genPronounSelectedColumn 	= genderPronoun;
                    wlNew.racialEthnicIdentitySelectedColumn= RacialEthnicIdentity;
                    
                    wlNew.primaryConcernSelectedColumn 	= primaryConcern;
                    wlNew.secondaryConcernSelectedColumn 	= secondaryConcern;
                    wlNew.thirdConcernSelectedColumn 	= thirdConcern;
                    wlNew.immSafetyConcernSelectedColumn 	= immSafetyConcern;
                    wlNew.safetyPlanSelectedColumn 	= safetyPlan;
                    
                    
                    
                    /* Issues With these values  */
                    System.debug('##Value1-----> '+consentToParticipate);
                    System.debug('##Value2-----> '+youth14Consent);
                    System.debug('##Value3-----> '+whyConsentNotReceive);
                    System.debug('##Value4-----> '+additionalInfoConsent);
                    System.debug('##Value5-----> '+parStandardEml);
                    System.debug('##Value6-----> '+bestTimeToContacParent);
                    System.debug('##Value7-----> '+parentGuardianRelationship);
                    
                    //  wlNew.additionalInfoRegardingConsent= additionalInfoConsent;
                    //  System.debug('##Value8-----> '+wlNew.additionalInfoRegardingConsent);
                    
                    /* Testing Parent/Guardian */
                    system.debug('***parentGuardianRelationship:===========> '+ parentGuardianRelationship); 
                    wlNew.participateInCC4YouthSelectedColumn 	= consentToParticipate;
                    wlNew.youth14SelectedColumn= youth14Consent;                      
                    wlNew.whyConsentNotReceived= whyConsentNotReceive;
                    wlNew.additionalInfoRegardingConsent= additionalInfoConsent;
                    wlNew.bestTimeToContactParent 	= bestTimeToContacParent;
                    wlNew.relationshipToChildSelectedColumn 	= parentGuardianRelationship;
                    wlNew.parentEmail =  parStandardEml;
                    system.debug('**wlNew.relationshipToChildSelectedColumn:===========> '+ wlNew.relationshipToChildSelectedColumn);
                    
                    
                    /* Assign  Multipicklist value to wrapper*/
                    
                    if(priConcrnMultiPickVal!=null){
                        
                        priConcrnMultiPickVal.remove('');
                        system.debug('***priConcrnMultiPickVal:===========> '+ priConcrnMultiPickVal);
                        wlNew.primaryConcrnMultiPickSelectedColumn= priConcrnMultiPickVal.split(';');
                        allstring = string.join(wlNew.primaryConcrnMultiPickSelectedColumn,',');
                        system.debug('**wlNew.primaryConcrnMultiPickSelectedColumn:===========> '+ wlNew.primaryConcrnMultiPickSelectedColumn);
                        system.debug('allstring'+ allstring);
                        
                    }
                    
                    if(secConcrnMultiPickVal!=null){
                        
                        secConcrnMultiPickVal.remove('');
                        system.debug('***secConcrnMultiPickVal:===========> '+ secConcrnMultiPickVal);
                        wlNew.secondaryConcernMultiPickSelectedColumn= secConcrnMultiPickVal.split(';');
                        allstring = string.join(wlNew.secondaryConcernMultiPickSelectedColumn,',');
                        system.debug('**wlNew.secondaryConcernMultiPickSelectedColumn:===========> '+ wlNew.secondaryConcernMultiPickSelectedColumn);
                        system.debug('allstring'+ allstring);
                        
                    }
                    
                    if(thirdConcrnMultiPickVal!=null){
                        
                        thirdConcrnMultiPickVal.remove('');
                        system.debug('***thirdConcrnMultiPickVal:===========> '+ thirdConcrnMultiPickVal);
                        wlNew.thirdConcernMultiPickSelectedColumn= thirdConcrnMultiPickVal.split(';');
                        allstring = string.join(wlNew.thirdConcernMultiPickSelectedColumn,',');
                        system.debug('**wlNew.thirdConcernMultiPickSelectedColumn:===========> '+ wlNew.thirdConcernMultiPickSelectedColumn);
                        system.debug('allstring'+ allstring);
                        
                    }
                    
                    if(rsnForReferralMultiPickVal!=null){
                        
                        rsnForReferralMultiPickVal.remove('');
                        system.debug('***rsnForReferralMultiPickVal:===========> '+ rsnForReferralMultiPickVal);
                        wlNew.reasonForReferralMultiPickSelectedColumn= rsnForReferralMultiPickVal.split(';');
                        allstring = string.join(wlNew.reasonForReferralMultiPickSelectedColumn,',');
                        system.debug('**wlNew.reasonForReferralMultiPickSelectedColumn:===========> '+ wlNew.reasonForReferralMultiPickSelectedColumn);
                        system.debug('allstring'+ allstring);
                        
                    }
                    
                    
                    if(previousSystemInvolveMultiPickVal!=null){
                        
                        previousSystemInvolveMultiPickVal.remove('');
                        system.debug('***previousSystemInvolveMultiPickVal:===========> '+ previousSystemInvolveMultiPickVal);
                        wlNew.previousSystemInvolveMultiPickSelectedColumn= previousSystemInvolveMultiPickVal.split(';');
                        allstring = string.join(wlNew.previousSystemInvolveMultiPickSelectedColumn,',');
                        system.debug('**wlNew.previousSystemInvolveMultiPickSelectedColumn:===========> '+ wlNew.previousSystemInvolveMultiPickSelectedColumn);
                        system.debug('allstring'+ allstring);
                        
                    }
                    
                    
                    wlNew.preferedName=preferName;
                    wlNew.homePhn= hmPhone;
                    wlNew.mailingStreet=mlStreet;
                    wlNew.mailingCity=mlCity;
                    wlNew.mailingState=mlState;
                    wlNew.mailingPostalCode=mlPostalCode;
                    wlNew.identityExpansion=identityExpan;
                    wlNew.race= Race;
                    
                    wlNew.cyfCaseNumber= cyfCsNo;
                    wlNew.cyfCaseWorkerName= cyfCsWorkerNm;
                    wlNew.cyfRegionalOfficeServices= cyfRegOfficeService;             
                    wlNew.cyfCasePhoneNumber= cyfCsPhnNo;   
                    wlNew.cyfFamilyCase= cyfFamilyCs;   
                    
                    wprListNew.add(wlNew);
                    system.debug('#####wprListNew:===========> '+wprListNew);
                    system.debug('#####wprListNew:===========> '+wprListNew.size());
                    system.debug('#####wprListNew:===========> '+wlNew.parentfName);
                    system.debug('#####wprListNew:===========> '+wlNew.parentlName);
                    system.debug('########caseId:===========> '+wlNew.caseId);
                    system.debug('######## wlNew.additionalInfoRegardingConsent testing:===========> '+wlNew.additionalInfoRegardingConsent);
                    // system.debug('######## wlNew.cyfFamilyCase testing:===========> '+wlNew.cyfFamilyCase);
                    //  system.debug('######## wlNew.cyfFamilyCase testing:===========> '+wlNew.cyfFamilyCase);
                    system.debug('######## wlNew.primaryConcrnMultiPickSelectedColumn testing:===========> '+wlNew.primaryConcrnMultiPickSelectedColumn);
                }
            }
            
            if(wprListNew!= Null && wprListNew.size()>0){
                for(wrapperList wprRec: wprListNew){  
                    
                    If(parentid!=null && parentid!='nullId'){
                        string clientIdNew= wprRec.childRecordId;
                        If(clientIdNew!=null && clientIdNew!='newRecFlag'){
                            // Existing client record;
                            
                            system.debug('#####wprRec:===========> '+wprRec);             
                            Intake__c inkRec= new Intake__c();
                            inkRec.Name= wprRec.firstName+ '_' +wprRec.lastName + '_' +'Caring Connections';
                            inkRec.First_Name__c=wprRec.firstName;
                            inkRec.Comments__c=wprRec.comment;
                            inkRec.Safety_plan_explanation__c=wprRec.SafetyPlanExplaination;
                            inkRec.Brief_Explanation__c=wprRec.briefExplaination;
                            inkRec.Last_Name__c= wprRec.lastName;
                            inkRec.Birthdate__c= date.valueOf(wprRec.Dob);
                            inkRec.DateOfSignature__c= dateOfSignature;
                            inkRec.Name_of_Primary_Parent_Guardian__c= parentRecdIdVar;
                            inkRec.Client__c= wprRec.childRecordId;
                            inkRec.case__c= wprRec.caseId;
                            inkRec.Mobile_Phone__c= wprRec.homePhn;
                            if(wprListNew[0].parentPhnNumber!=null){
                                inkRec.GuardianPhone__c= wprListNew[0].parentPhnNumber;
                            }
                            
                            
                            inkRec.PreferredName__c= wprRec.preferedName;
                            inkRec.Home_Phone__c= wprRec.homePhn;
                            inkRec.Mailing_Street__c= wprRec.mailingStreet;
                            inkRec.Mailing_City__c= wprRec.mailingCity;
                            inkRec.Mailing_State__c= wprRec.mailingState;
                            inkRec.Mailing_Zip_Code__c=wprRec.mailingPostalCode;
                            inkRec.Race_Other__c	= wprRec.identityExpansion;
                            inkRec.Race__c	= wprRec.racialEthnicIdentitySelectedColumn;
                            System.debug('**Race: ===> '+inkRec.Race__c);
                            
                            /*  These Value would isert Into  Parent/guardian section of Intake*/
                            if(wprListNew[0].parentMailingStreet!=null){
                                inkRec.Guardian_Street__c= wprListNew[0].parentMailingStreet;
                            }
                            if(wprListNew[0].parentMailingCity!=null){
                                inkRec.Guardian_City__c= wprListNew[0].parentMailingCity;
                            }
                            if(wprListNew[0].guardianMailingStateSelectedColumn!=null){
                                inkRec.Guardian_State__c= wprListNew[0].guardianMailingStateSelectedColumn;
                            }
                            if(wprListNew[0].parentMailingPostalCode!=null){
                                inkRec.Guardian_Zip__c= wprListNew[0].parentMailingPostalCode;
                            }
                            
                            
                            
                            
                            system.debug('****wprRec.guardianMailingStateSelectedColumn:===========> '+wprRec.guardianMailingStateSelectedColumn);    
                            
                            if(wprRec.genIdentitySelectedColumn!=null && wprRec.genIdentitySelectedColumn!= '--Select--'){
                                inkRec.Gender_Identity__c= wprRec.genIdentitySelectedColumn;
                            }
                            if(wprRec.genPronounSelectedColumn!=null && wprRec.genPronounSelectedColumn!= '--Select--'){
                                inkRec.GenderPronouns__c= wprRec.genPronounSelectedColumn;
                            }
                            
                            
                            
                            if(wprRec.primaryConcernSelectedColumn!=null && wprRec.primaryConcernSelectedColumn!= '--Select--'){
                                inkRec.Primary_Reason_for_Referral__c= wprRec.primaryConcernSelectedColumn;
                            }
                            
                            if(wprRec.secondaryConcernSelectedColumn!=null && wprRec.secondaryConcernSelectedColumn!= '--Select--'){
                                inkRec.Secondary_Reason_for_Referral__c= wprRec.secondaryConcernSelectedColumn;
                            }
                            
                            if(wprRec.thirdConcernSelectedColumn!=null && wprRec.thirdConcernSelectedColumn!= '--Select--'){
                                inkRec.Additional_Reason_for_Referral__c= wprRec.thirdConcernSelectedColumn;
                            }
                            
                            if(wprRec.immSafetyConcernSelectedColumn!=null && wprRec.immSafetyConcernSelectedColumn!= '--Select--'){
                                inkRec.ImmediateSafetyConcerns__c= wprRec.immSafetyConcernSelectedColumn;
                            }
                            
                            if(wprRec.safetyPlanSelectedColumn!=null && wprRec.safetyPlanSelectedColumn!= '--Select--'){
                                inkRec.ClientHasaSafetyPlan__c= wprRec.safetyPlanSelectedColumn;
                            }
                            
                            
                            /*   if(wprListNew[0].relationshipToChildSelectedColumn!=null && wprListNew[0].relationshipToChildSelectedColumn!= '--Select--'){
inkRec.Primary_Guardian_Relationship__c= wprListNew[0].relationshipToChildSelectedColumn;
}*/
                            
                            if(wprRec.relationshipToChildSelectedColumn!=null && wprRec.relationshipToChildSelectedColumn!= '--Select--'){
                                inkRec.Primary_Guardian_Relationship__c= wprRec.relationshipToChildSelectedColumn;
                                System.debug('***inkRec.Primary_Guardian_Relationship__c==> '+inkRec.Primary_Guardian_Relationship__c);
                            }
                            
                            
                            if(wprListNew[0].bestTimeToContactParent!=null){
                                inkRec.BestTimetoContactGuardian__c= wprListNew[0].bestTimeToContactParent;
                            }
                            
                            
                            if(wprListNew[0].participateInCC4YouthSelectedColumn!=null && wprListNew[0].participateInCC4YouthSelectedColumn!= '--Select--'){
                                inkRec.GuardianConsentReceived__c=  wprListNew[0].participateInCC4YouthSelectedColumn;
                                System.debug('##inkRec.GuardianConsentReceived__c--->'+inkRec.GuardianConsentReceived__c);
                            }
                            
                            if(wprListNew[0].youth14SelectedColumn!=null && wprListNew[0].youth14SelectedColumn!= '--Select--'){
                                inkRec.ClientConsentReceived14YOA__c= wprListNew[0].youth14SelectedColumn;
                                System.debug('##inkRec.ClientConsentReceived14YOA__c--->'+inkRec.ClientConsentReceived14YOA__c);
                            } 
                            
                            if(wprListNew[0].additionalInfoRegardingConsent!=null){
                                inkRec.AdditionalInformationRegardingConsent__c= wprListNew[0].additionalInfoRegardingConsent;
                                System.debug('##inkRec.AdditionalInformationRegardingConsent__c--->'+inkRec.AdditionalInformationRegardingConsent__c);
                            } 
                            
                            if(wprListNew[0].whyConsentNotReceived!=null){
                                inkRec.WhyHasConsentNotBeenReceived__c= wprListNew[0].whyConsentNotReceived;
                                System.debug('##inkRec.WhyHasConsentNotBeenReceived__c--->'+inkRec.WhyHasConsentNotBeenReceived__c);
                            } 
                            
                            if(wprListNew[0].parentEmail!=null){
                                inkRec.Personal_Email__c= wprListNew[0].parentEmail;
                            }
                            
                            
                            
                            /* Multipicklist: Field are mapped with dynamic Values  from Intake Form */
                            if(wprRec.primaryConcrnMultiPickSelectedColumn!=null){
                                string val=String.join(wprRec.primaryConcrnMultiPickSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Primary_Reason_for_Referral_Expanded__c= bal.replace(')', ' ');
                                system.debug('**inkRec.Primary_Reason_for_Referral_Expanded__c:===========> '+inkRec.Primary_Reason_for_Referral_Expanded__c);   
                            }
                            
                            if(wprRec.secondaryConcernMultiPickSelectedColumn!=null){
                                string val=String.join(wprRec.secondaryConcernMultiPickSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Secondary_Reason_for_Referral_Expanded__c= bal.replace(')', ' ');
                                system.debug('**inkRec.Secondary_Reason_for_Referral_Expanded__c:===========> '+inkRec.Secondary_Reason_for_Referral_Expanded__c);   
                            }
                            
                            if(wprRec.thirdConcernMultiPickSelectedColumn!=null){
                                string val=String.join(wprRec.thirdConcernMultiPickSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Additional_Reason_for_Referral_Expanded__c= bal.replace(')', ' ');
                                
                                system.debug('**inkRec.Additional_Reason_for_Referral_Expanded__c:===========> '+inkRec.Additional_Reason_for_Referral_Expanded__c);   
                            }
                            
                            if(wprRec.reasonForReferralMultiPickSelectedColumn!=null){
                                string val=String.join(wprRec.reasonForReferralMultiPickSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Needs_Category__c= bal.replace(')', ' ');
                                system.debug('**inkRec.Needs_Category__c:===========> '+inkRec.Needs_Category__c);   
                            }
                            
                            if(wprRec.previousSystemInvolveMultiPickSelectedColumn!=null){
                                string val=String.join(wprRec.previousSystemInvolveMultiPickSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Previous_System_Involvement__c= bal.replace(')', ' ');
                                system.debug('**inkRec.Previous_System_Involvement__c:===========> '+inkRec.Previous_System_Involvement__c);   
                            }
                            /* Multipicklist closed  */
                            
                            /* Safety and Risk Assessment */
                            inkRec.CYFCaseNumber__c =   wprRec.cyfCaseNumber;
                            inkRec.CYF_Case_Worker__c = wprRec.cyfCaseWorkerName;
                            inkRec.RegionalOfficeforCYFServices__c = wprRec.cyfRegionalOfficeServices;
                            inkRec.Case_Worker__c =     wprRec.cyfCasePhoneNumber;                           
                            inkRec.Neighborhood_CC__c= neighborhoodPickVal;
                            inkRec.Other_Neighborhood_CC__c=otherNeighborhood;
                            inkRec.mplc_Signature__c= mplcSign;
                            inkRec.CYF_Active__c =     wprRec.cyfFamilyCase;  //wprRec.cyfFamilyCase;true
                            inkRec.Youth_Signature__c  = wprRec.youthSignature;
                            inkRec.RecordTypeId = caringConnectionsRecTypeId;
                            if(usrId!=null){
                                inkRec.OwnerId	= usrId;
                                System.debug('****Existing parent case usrId==>+usrId');
                            }
                            newRecList.add(inkRec);
                            system.debug('######inkRec.Primary_Reason_for_Referral_Expanded__c Testing:===========> '+inkRec.Primary_Reason_for_Referral_Expanded__c);  
                            system.debug('#####newRecList2:===========> '+newRecList);
                            system.debug('#####inkRec.Client__c:===========> '+wprRec.childRecordId);
                            system.debug('#####wprRec.caseId:===========> '+wprRec.caseId);
                            system.debug('#####inkRec.case__c:===========> '+inkRec.case__c);
                            system.debug('######inkRec.GenderIdentity:===========> '+inkRec.Gender_Identity__c);
                            system.debug('######inkRec.GenderPronouns__c:===========> '+inkRec.GenderPronouns__c);
                            system.debug('######inkRec.Neighborhood_CC__c:===========> '+inkRec.Neighborhood_CC__c);
                            system.debug('######inkRec.Youth_Signature__c Test1:===========> '+inkRec.Youth_Signature__c);
                            system.debug('######wprRec.youthSignature Test1:===========> '+wprRec.youthSignature);
                            system.debug('######wprRec.cyfFamilyCase Testing3:===========> '+wprRec.cyfFamilyCase);
                        }
                        else{
                            //  Existing parent new client;
                            
                            Intake__c inkRec= new Intake__c();
                            inkRec.Name= wprRec.firstName+ '_' +wprRec.lastName + '_' +'Caring Connections';
                            inkRec.First_Name__c=  wprRec.firstName;
                            inkRec.Comments__c=wprRec.comment;
                            inkRec.Safety_plan_explanation__c=wprRec.SafetyPlanExplaination;
                            inkRec.Brief_Explanation__c=wprRec.briefExplaination;
                            inkRec.Last_Name__c= wprRec.lastName;
                            inkRec.Birthdate__c= date.valueOf(wprRec.Dob);
                            inkRec.DateOfSignature__c= dateOfSignature;
                            inkRec.Name_of_Primary_Parent_Guardian__c= parentRecdIdVar;
                            
                            inkRec.Mobile_Phone__c= wprRec.homePhn;
                            if(wprListNew[0].parentPhnNumber!=null){
                                inkRec.GuardianPhone__c= wprListNew[0].parentPhnNumber;
                            }
                            
                            if(wprRec.genIdentitySelectedColumn!=null && wprRec.genIdentitySelectedColumn!= '--Select--'){
                                inkRec.Gender_Identity__c= wprRec.genIdentitySelectedColumn;
                            }
                            if(wprRec.genPronounSelectedColumn!=null && wprRec.genPronounSelectedColumn!= '--Select--'){
                                inkRec.GenderPronouns__c= wprRec.genPronounSelectedColumn;
                            }
                            
                            if(wprRec.primaryConcernSelectedColumn!=null && wprRec.primaryConcernSelectedColumn!= '--Select--'){
                                inkRec.Primary_Reason_for_Referral__c= wprRec.primaryConcernSelectedColumn;
                            }
                            
                            if(wprRec.secondaryConcernSelectedColumn!=null && wprRec.secondaryConcernSelectedColumn!= '--Select--'){
                                inkRec.Secondary_Reason_for_Referral__c= wprRec.secondaryConcernSelectedColumn;
                            }
                            
                            if(wprRec.thirdConcernSelectedColumn!=null && wprRec.thirdConcernSelectedColumn!= '--Select--'){
                                inkRec.Additional_Reason_for_Referral__c= wprRec.thirdConcernSelectedColumn;
                            }
                            
                            if(wprRec.immSafetyConcernSelectedColumn!=null && wprRec.immSafetyConcernSelectedColumn!= '--Select--'){
                                inkRec.ImmediateSafetyConcerns__c= wprRec.immSafetyConcernSelectedColumn;
                            }
                            
                            if(wprRec.safetyPlanSelectedColumn!=null && wprRec.safetyPlanSelectedColumn!= '--Select--'){
                                inkRec.ClientHasaSafetyPlan__c= wprRec.safetyPlanSelectedColumn;
                            }
                            
                            /*    if(wprListNew[0].relationshipToChildSelectedColumn!=null && wprListNew[0].relationshipToChildSelectedColumn!= '--Select--'){
inkRec.Primary_Guardian_Relationship__c= wprListNew[0].relationshipToChildSelectedColumn;
}
*/
                            
                            if(wprRec.relationshipToChildSelectedColumn!=null && wprRec.relationshipToChildSelectedColumn!= '--Select--'){
                                inkRec.Primary_Guardian_Relationship__c= wprRec.relationshipToChildSelectedColumn;
                                System.debug('***inkRec.Primary_Guardian_Relationship__c==> '+inkRec.Primary_Guardian_Relationship__c);
                            }
                            
                            if(wprListNew[0].bestTimeToContactParent!=null){
                                inkRec.BestTimetoContactGuardian__c= wprListNew[0].bestTimeToContactParent;
                            }
                            
                            
                            if(wprListNew[0].participateInCC4YouthSelectedColumn!=null && wprListNew[0].participateInCC4YouthSelectedColumn!= '--Select--'){
                                inkRec.GuardianConsentReceived__c=  wprListNew[0].participateInCC4YouthSelectedColumn;
                                System.debug('##inkRec.GuardianConsentReceived__c--->'+inkRec.GuardianConsentReceived__c);
                            }
                            
                            if(wprListNew[0].youth14SelectedColumn!=null && wprListNew[0].youth14SelectedColumn!= '--Select--'){
                                inkRec.ClientConsentReceived14YOA__c= wprListNew[0].youth14SelectedColumn;
                                System.debug('##inkRec.ClientConsentReceived14YOA__c--->'+inkRec.ClientConsentReceived14YOA__c);
                            } 
                            
                            if(wprListNew[0].additionalInfoRegardingConsent!=null){
                                inkRec.AdditionalInformationRegardingConsent__c= wprListNew[0].additionalInfoRegardingConsent;
                                System.debug('##inkRec.AdditionalInformationRegardingConsent__c--->'+inkRec.AdditionalInformationRegardingConsent__c);
                            } 
                            
                            if(wprListNew[0].whyConsentNotReceived!=null){
                                inkRec.WhyHasConsentNotBeenReceived__c= wprListNew[0].whyConsentNotReceived;
                                System.debug('##inkRec.WhyHasConsentNotBeenReceived__c--->'+inkRec.WhyHasConsentNotBeenReceived__c);
                            } 
                            
                            if(wprListNew[0].parentEmail!=null){
                                inkRec.Personal_Email__c= wprListNew[0].parentEmail;
                            }
                            
                            /* Multipicklist: Field are mapped with dynamic Values  from Intake Form */
                            if(wprRec.primaryConcrnMultiPickSelectedColumn!=null){
                                string val=String.join(wprRec.primaryConcrnMultiPickSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Primary_Reason_for_Referral_Expanded__c= bal.replace(')', ' ');
                                system.debug('**inkRec.Primary_Reason_for_Referral_Expanded__c:===========> '+inkRec.Primary_Reason_for_Referral_Expanded__c);   
                            }
                            
                            if(wprRec.secondaryConcernMultiPickSelectedColumn!=null){
                                string val=String.join(wprRec.secondaryConcernMultiPickSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Secondary_Reason_for_Referral_Expanded__c= bal.replace(')', ' ');
                                system.debug('**inkRec.Secondary_Reason_for_Referral_Expanded__c:===========> '+inkRec.Secondary_Reason_for_Referral_Expanded__c);   
                            }
                            
                            if(wprRec.thirdConcernMultiPickSelectedColumn!=null){
                                string val=String.join(wprRec.thirdConcernMultiPickSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Additional_Reason_for_Referral_Expanded__c= bal.replace(')', ' ');
                                system.debug('**inkRec.Additional_Reason_for_Referral_Expanded__c:===========> '+inkRec.Additional_Reason_for_Referral_Expanded__c);   
                            }
                            
                            if(wprRec.reasonForReferralMultiPickSelectedColumn!=null){
                                string val=String.join(wprRec.reasonForReferralMultiPickSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Needs_Category__c= bal.replace(')', ' ');
                                system.debug('**inkRec.Needs_Category__c:===========> '+inkRec.Needs_Category__c);   
                            }
                            
                            if(wprRec.previousSystemInvolveMultiPickSelectedColumn!=null){
                                string val=String.join(wprRec.previousSystemInvolveMultiPickSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Previous_System_Involvement__c= bal.replace(')', ' ');
                                system.debug('**inkRec.Previous_System_Involvement__c:===========> '+inkRec.Previous_System_Involvement__c);   
                            }
                            /* Multipicklist closed  */
                            
                            inkRec.PreferredName__c= wprRec.preferedName;
                            inkRec.Home_Phone__c= wprRec.homePhn;
                            inkRec.Mailing_Street__c= wprRec.mailingStreet;
                            inkRec.Mailing_City__c= wprRec.mailingCity;
                            inkRec.Mailing_State__c= wprRec.mailingState;
                            inkRec.Mailing_Zip_Code__c=wprRec.mailingPostalCode;
                            inkRec.Race_Other__c	= wprRec.identityExpansion;
                            inkRec.Race__c	= wprRec.racialEthnicIdentitySelectedColumn;
                            System.debug('**Race: ===> '+inkRec.Race__c);
                            
                            /*  These Value would isert Into  Parent/guardian section of Intake*/
                            if(wprListNew[0].parentMailingStreet!=null){
                                inkRec.Guardian_Street__c= wprListNew[0].parentMailingStreet;
                            }
                            if(wprListNew[0].parentMailingCity!=null){
                                inkRec.Guardian_City__c= wprListNew[0].parentMailingCity;
                            }
                            if(wprListNew[0].guardianMailingStateSelectedColumn!=null){
                                inkRec.Guardian_State__c= wprListNew[0].guardianMailingStateSelectedColumn;
                            }
                            if(wprListNew[0].parentMailingPostalCode!=null){
                                inkRec.Guardian_Zip__c= wprListNew[0].parentMailingPostalCode;
                            }
                            System.debug('****wprRec.guardianMailingStateSelectedColumn==> '+wprRec.guardianMailingStateSelectedColumn);
                            
                            /* Safety and Risk Assessment */
                            inkRec.CYFCaseNumber__c =   wprRec.cyfCaseNumber;
                            inkRec.CYF_Case_Worker__c = wprRec.cyfCaseWorkerName;
                            inkRec.RegionalOfficeforCYFServices__c = wprRec.cyfRegionalOfficeServices;
                            inkRec.CYF_Active__c =      wprRec.cyfFamilyCase;
                            inkRec.Case_Worker__c =     wprRec.cyfCasePhoneNumber;
                            
                            inkRec.Neighborhood_CC__c= neighborhoodPickVal;
                            inkRec.Other_Neighborhood_CC__c=otherNeighborhood;
                            inkRec.mplc_Signature__c= mplcSign;
                            inkRec.Youth_Signature__c  = wprRec.youthSignature;
                            inkRec.RecordTypeId = caringConnectionsRecTypeId;
                            
                            if(usrId!=null){
                                inkRec.OwnerId	= usrId;
                                System.debug('****Existing parent New case usrId==>+usrId');
                            }
                            newRecList.add(inkRec);
                            system.debug('######inkRec.Primary_Reason_for_Referral_Expanded__c Testing:===========> '+inkRec.Primary_Reason_for_Referral_Expanded__c);  
                            system.debug('#####newRecList1:===========> '+newRecList);
                            system.debug('######inkRec.Community_Activities__c:===========> '+inkRec.Community_Activities__c);
                            system.debug('######inkRec.GenderIdentity:===========> '+inkRec.Gender_Identity__c);
                            system.debug('######inkRec.GenderPronouns__c:===========> '+inkRec.GenderPronouns__c);
                            system.debug('######inkRec.Neighborhood_CC__c:===========> '+inkRec.Neighborhood_CC__c);
                            system.debug('######inkRec.Youth_Signature__c Test2:===========> '+inkRec.Youth_Signature__c);
                            system.debug('######wprRec.youthSignature Test2:===========> '+wprRec.youthSignature);
                            system.debug('######wprRec.cyfFamilyCase Testing:===========> '+wprRec.cyfFamilyCase);
                        }
                    }
                    else{
                        
                        //  New parent case recod;
                        
                        Intake__c inkRec= new Intake__c();
                        inkRec.Name= wprRec.firstName+ '_' +wprRec.lastName + '_' +'Caring Connections';
                        inkRec.First_Name__c=  wprRec.firstName;
                         inkRec.Comments__c=wprRec.comment;
                            inkRec.Safety_plan_explanation__c=wprRec.SafetyPlanExplaination;
                            inkRec.Brief_Explanation__c=wprRec.briefExplaination;
                        inkRec.Last_Name__c= wprRec.lastName;
                        inkRec.Birthdate__c= date.valueOf(wprRec.Dob);
                        inkRec.DateOfSignature__c= dateOfSignature;
                        inkRec.Name_of_Primary_Parent_Guardian__c= newParentGuardianId; 
                        
                        
                        
                        if(wprRec.genIdentitySelectedColumn!=null && wprRec.genIdentitySelectedColumn!= '--Select--'){
                            inkRec.Gender_Identity__c= wprRec.genIdentitySelectedColumn;
                        }
                        if(wprRec.genPronounSelectedColumn!=null && wprRec.genPronounSelectedColumn!= '--Select--'){
                            inkRec.GenderPronouns__c= wprRec.genPronounSelectedColumn;
                        }
                        
                        
                        if(wprRec.primaryConcernSelectedColumn!=null && wprRec.primaryConcernSelectedColumn!= '--Select--'){
                            inkRec.Primary_Reason_for_Referral__c= wprRec.primaryConcernSelectedColumn;
                        }
                        
                        if(wprRec.secondaryConcernSelectedColumn!=null && wprRec.secondaryConcernSelectedColumn!= '--Select--'){
                            inkRec.Secondary_Reason_for_Referral__c= wprRec.secondaryConcernSelectedColumn;
                        }
                        
                        if(wprRec.thirdConcernSelectedColumn!=null && wprRec.thirdConcernSelectedColumn!= '--Select--'){
                            inkRec.Additional_Reason_for_Referral__c= wprRec.thirdConcernSelectedColumn;
                        }
                        
                        if(wprRec.immSafetyConcernSelectedColumn!=null && wprRec.immSafetyConcernSelectedColumn!= '--Select--'){
                            inkRec.ImmediateSafetyConcerns__c= wprRec.immSafetyConcernSelectedColumn;
                        }
                        
                        if(wprRec.safetyPlanSelectedColumn!=null && wprRec.safetyPlanSelectedColumn!= '--Select--'){
                            inkRec.ClientHasaSafetyPlan__c= wprRec.safetyPlanSelectedColumn;
                        }
                        
                        /*   if(wprListNew[0].relationshipToChildSelectedColumn!=null && wprListNew[0].relationshipToChildSelectedColumn!= '--Select--'){
inkRec.Primary_Guardian_Relationship__c= wprListNew[0].relationshipToChildSelectedColumn;
}
*/
                        
                        
                        if(wprRec.relationshipToChildSelectedColumn!=null && wprRec.relationshipToChildSelectedColumn!= '--Select--'){
                            inkRec.Primary_Guardian_Relationship__c= wprRec.relationshipToChildSelectedColumn;
                            System.debug('***inkRec.Primary_Guardian_Relationship__c==> '+inkRec.Primary_Guardian_Relationship__c);
                        }
                        
                        
                        if(wprListNew[0].bestTimeToContactParent!=null){
                            inkRec.BestTimetoContactGuardian__c= wprListNew[0].bestTimeToContactParent;
                        }
                        
                        if(wprListNew[0].participateInCC4YouthSelectedColumn!=null && wprListNew[0].participateInCC4YouthSelectedColumn!= '--Select--'){
                            inkRec.GuardianConsentReceived__c=  wprListNew[0].participateInCC4YouthSelectedColumn;
                        }
                        
                        if(wprListNew[0].youth14SelectedColumn!=null && wprListNew[0].youth14SelectedColumn!= '--Select--'){
                            inkRec.ClientConsentReceived14YOA__c= wprListNew[0].youth14SelectedColumn;
                        } 
                        
                        if(wprListNew[0].additionalInfoRegardingConsent!=null){
                            inkRec.AdditionalInformationRegardingConsent__c= wprListNew[0].additionalInfoRegardingConsent;
                        } 
                        
                        if(wprListNew[0].whyConsentNotReceived!=null){
                            inkRec.WhyHasConsentNotBeenReceived__c= wprListNew[0].whyConsentNotReceived;
                        }
                        
                        if(wprListNew[0].parentEmail!=null){
                            inkRec.Personal_Email__c= wprListNew[0].parentEmail;
                        }
                        
                        
                        system.debug('######wprListNew[0].relationshipToChildSelectedColumn:===========> '+wprListNew[0].relationshipToChildSelectedColumn);
                        system.debug('######wprListNew[0].bestTimeToContactParent:===========> '+wprListNew[0].bestTimeToContactParent);
                        system.debug('######wprListNew[0].participateInCC4YouthSelectedColumn:===========> '+wprListNew[0].participateInCC4YouthSelectedColumn);
                        system.debug('######wprListNew[0].youth14SelectedColumn:===========> '+wprListNew[0].youth14SelectedColumn);
                        system.debug('######wprListNew[0].additionalInfoRegardingConsent:===========> '+wprListNew[0].additionalInfoRegardingConsent);
                        system.debug('######wprListNew[0].whyConsentNotReceived:===========> '+wprListNew[0].whyConsentNotReceived);
                        
                        /* Multipicklist: Field are mapped with dynamic Values  from Intake Form */
                        if(wprRec.primaryConcrnMultiPickSelectedColumn!=null){
                            string val=String.join(wprRec.primaryConcrnMultiPickSelectedColumn,',').replaceAll(',', ';');
                            string bal=val.replace('(', ' ');
                            inkRec.Primary_Reason_for_Referral_Expanded__c= bal.replace(')', ' ');
                            system.debug('**inkRec.Primary_Reason_for_Referral_Expanded__c:===========> '+inkRec.Primary_Reason_for_Referral_Expanded__c);   
                        }
                        
                        if(wprRec.secondaryConcernMultiPickSelectedColumn!=null){
                            string val=String.join(wprRec.secondaryConcernMultiPickSelectedColumn,',').replaceAll(',', ';');
                            string bal=val.replace('(', ' ');
                            inkRec.Secondary_Reason_for_Referral_Expanded__c= bal.replace(')', ' ');
                            system.debug('**inkRec.Secondary_Reason_for_Referral_Expanded__c:===========> '+inkRec.Secondary_Reason_for_Referral_Expanded__c);   
                        }
                        
                        if(wprRec.thirdConcernMultiPickSelectedColumn!=null){
                            string val=String.join(wprRec.thirdConcernMultiPickSelectedColumn,',').replaceAll(',', ';');
                            string bal=val.replace('(', ' ');
                            inkRec.Additional_Reason_for_Referral_Expanded__c= bal.replace(')', ' ');
                            system.debug('**inkRec.Additional_Reason_for_Referral_Expanded__c:===========> '+inkRec.Additional_Reason_for_Referral_Expanded__c);   
                        }
                        
                        if(wprRec.reasonForReferralMultiPickSelectedColumn!=null){
                            string val=String.join(wprRec.reasonForReferralMultiPickSelectedColumn,',').replaceAll(',', ';');
                            string bal=val.replace('(', ' ');
                            inkRec.Needs_Category__c= bal.replace(')', ' ');
                            system.debug('**inkRec.Needs_Category__c:===========> '+inkRec.Needs_Category__c);   
                        }
                        
                        if(wprRec.previousSystemInvolveMultiPickSelectedColumn!=null){
                            string val=String.join(wprRec.previousSystemInvolveMultiPickSelectedColumn,',').replaceAll(',', ';');
                            string bal=val.replace('(', ' ');
                            inkRec.Previous_System_Involvement__c= bal.replace(')', ' ');
                            system.debug('**inkRec.Previous_System_Involvement__c:===========> '+inkRec.Previous_System_Involvement__c);   
                        }
                        /* Multipicklist closed  */
                        
                        inkRec.PreferredName__c= wprRec.preferedName;
                        inkRec.Home_Phone__c= wprRec.homePhn;
                        
                        inkRec.Mobile_Phone__c= wprRec.homePhn;
                        if(wprListNew[0].parentPhnNumber!=null){
                            inkRec.GuardianPhone__c= wprListNew[0].parentPhnNumber;
                        }
                        
                        inkRec.Mailing_Street__c= wprRec.mailingStreet;
                        inkRec.Mailing_City__c= wprRec.mailingCity;
                        inkRec.Mailing_State__c= wprRec.mailingState;
                        inkRec.Mailing_Zip_Code__c=wprRec.mailingPostalCode;
                        inkRec.Race_Other__c	= wprRec.identityExpansion;
                        inkRec.Race__c	= wprRec.racialEthnicIdentitySelectedColumn;
                        System.debug('**Race: ===> '+inkRec.Race__c);
                        
                        /*  These Value would isert Into  Parent/guardian section of Intake*/
                        if(wprListNew[0].parentMailingStreet!=null){
                            inkRec.Guardian_Street__c= wprListNew[0].parentMailingStreet;
                        }
                        if(wprListNew[0].parentMailingCity!=null){
                            inkRec.Guardian_City__c= wprListNew[0].parentMailingCity;
                        }
                        if(wprListNew[0].guardianMailingStateSelectedColumn!=null){
                            inkRec.Guardian_State__c= wprListNew[0].guardianMailingStateSelectedColumn;
                        }
                        if(wprListNew[0].parentMailingPostalCode!=null){
                            inkRec.Guardian_Zip__c= wprListNew[0].parentMailingPostalCode;
                        }
                        system.debug('**inkRec.Guardian_State__c:===========> '+inkRec.Guardian_State__c);  
                        /* Testing */
                        
                        
                        /* Safety and Risk Assessment */
                        inkRec.CYFCaseNumber__c =   wprRec.cyfCaseNumber;
                        inkRec.CYF_Case_Worker__c = wprRec.cyfCaseWorkerName;
                        inkRec.RegionalOfficeforCYFServices__c = wprRec.cyfRegionalOfficeServices;
                        inkRec.CYF_Active__c =      wprRec.cyfFamilyCase;
                        inkRec.Case_Worker__c =     wprRec.cyfCasePhoneNumber;                   
                        inkRec.mplc_Signature__c= mplcSign;
                        inkRec.Youth_Signature__c  = wprRec.youthSignature;
                        inkRec.Neighborhood_CC__c= neighborhoodPickVal;
                          inkRec.Other_Neighborhood_CC__c=otherNeighborhood;
                        inkRec.RecordTypeId = caringConnectionsRecTypeId;
                        if(usrId!=null){
                            inkRec.OwnerId	= usrId;
                            System.debug('****New Parent case usrId==>+usrId');
                        }
                        newRecList.add(inkRec);
                        
                        system.debug('######inkRec.Primary_Reason_for_Referral_Expanded__c Testing:===========> '+inkRec.Primary_Reason_for_Referral_Expanded__c);  
                        system.debug('######newRecList3:===========> '+newRecList);
                        system.debug('######inkRec.Neighborhood_CC__c:===========> '+inkRec.Neighborhood_CC__c);
                        
                        system.debug('######newParentGuardianId:===========> '+newParentGuardianId);
                        system.debug('######inkRec.GenderIdentity:===========> '+inkRec.Gender_Identity__c);
                        system.debug('######inkRec.GenderPronouns__c:===========> '+inkRec.GenderPronouns__c);
                        system.debug('######inkRec.Neighborhood_CC__c:===========> '+inkRec.Neighborhood_CC__c);
                        system.debug('#wprRec.participateInCC4YouthSelectedColumn:===========> '+wprRec.participateInCC4YouthSelectedColumn);
                        
                        system.debug('#wprRec.personalEmail:===========> '+ wprRec.parentEmail); 
                        system.debug('######inkRec.Youth_Signature__c Test3:===========> '+inkRec.Youth_Signature__c);
                        system.debug('######wprRec.youthSignature Test3:===========> '+wprRec.youthSignature);  
                        system.debug('######wprRec.cyfFamilyCase Testing1:===========> '+wprRec.cyfFamilyCase);
                    }
                    
                }
            }
            system.debug('###fname==========> '+fname);
            system.debug('###lname==========> '+lname);
            system.debug('###dob==========> '+dob);
            system.debug('###dob==========> '+parFName);
            system.debug('###dob==========> '+parLName);
            
            if(newRecList!=Null && newRecList.size()>0){
                insert newRecList;
                system.debug('###Intake Record List New===========> '+newRecList);  
                system.debug('###Intake Record List Size===========> '+newRecList.size()); 
            }                      
        }catch(Exception ex){
            // string err= errMSG;
            // errMSG= ex.getMessage();
            //errMSG= err;
            System.debug('Error Msg:====> '+ ex.getMessage()+ 'Error Line No:====> '+ex.getLineNumber());
            
            
        }
        //  return errMSG;
    }
    
    
    
    @AuraEnabled(cacheable=true)
    public static List<string> getNeighborhoodPicklistVal(){
        List<string> pickListValues = new List<string>();
        Schema.DescribeFieldResult pickList = Contact.Neighborhood_CC__c.getDescribe();
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            pickListValues.add(pickVal.getValue());
            System.debug('##pickListValues----> '+pickListValues);
        }   
        return pickListValues;
    }
    
    
    // Mapped User List Into Wrapper and Returning their
    
    @AuraEnabled(cacheable=true)
    public static List<wrapperList> getAllUsers() {
        usrlist= [SELECT Id, FirstName, LastName, Email FROM User WHERE IsActive = true AND UserRoleId='00E2M000001i1pbUAA'];
        System.debug('usrlist==> '+usrlist);
        List<wrapperList> wprList= new List<wrapperList>();
        
        if(usrlist!=Null && usrlist.size()>0){
            for(User usr: usrlist){
                wrapperList wprUsr= new wrapperList();
                if(usr.FirstName!=null){ // && usr.FirstName!=''
                    wprUsr.usrFirstNm= usr.FirstName;
                }
                if(usr.LastName!=null){ // && usr.LastName!=''
                    wprUsr.usrLastNm= usr.LastName;
                }
                
                if(usr.Id!=null){
                    wprUsr.usrId= usr.Id;
                }
                
                wprList.add(wprUsr);
                System.debug('wprList==> '+wprList);
            }
        }       
        return wprList;   
    }
    
    
    
    /*    Picklist (Multi-Select):  Testing     */
    
    
    
    public class wrapperList{
        
        /*        Picklist Fields Column         */
        
        @AuraEnabled
        public List<WrapperAllValues> genIdentityColumn{get;set;}
        
        @AuraEnabled
        public string genIdentitySelectedColumn{get;set;}
        
        @AuraEnabled
        public List<WrapperAllValues> genPronounColumn{get;set;}
        
        @AuraEnabled
        public string genPronounSelectedColumn{get;set;}
        
        /*  Top 3 concerns for Child  */
        @AuraEnabled
        public List<WrapperAllValues> primaryConcernColumn{get;set;}
        
        @AuraEnabled
        public string primaryConcernSelectedColumn{get;set;}
        
        @AuraEnabled
        public List<WrapperAllValues> secondaryConcernColumn{get;set;}
        
        @AuraEnabled
        public string secondaryConcernSelectedColumn{get;set;}
        
        
        @AuraEnabled
        public List<WrapperAllValues> thirdConcernColumn{get;set;}
        
        @AuraEnabled
        public string thirdConcernSelectedColumn{get;set;}
        
        
        
        
        
        
        /*    Multi Picklist Fields Column   */
        
        @AuraEnabled
        public List<WrapperAllValues> primaryConcernMultiPickColumn{get;set;}
        
        @AuraEnabled
        public List<string> selectedValues{get;set;}
        
        @AuraEnabled
        public List<string> primaryConcrnMultiPickSelectedColumn{get;set;}
        
        @AuraEnabled
        public List<WrapperAllValues> secondaryConcernMultiPickColumn{get;set;}
        
        @AuraEnabled
        public List<string> selectedValuesSecConcern{get;set;}
        
        @AuraEnabled
        public List<string> secondaryConcernMultiPickSelectedColumn{get;set;}
        
        @AuraEnabled
        public List<WrapperAllValues> thirdConcernMultiPickColumn{get;set;}
        
        @AuraEnabled
        public List<string> selectedValuesThirdConcern{get;set;}
        
        @AuraEnabled
        public List<string> thirdConcernMultiPickSelectedColumn{get;set;}
        
        @AuraEnabled
        public List<WrapperAllValues>  reasonForReferralMultiPickColumn{get;set;}
        
        @AuraEnabled
        public List<string> selectedValuesReasonForReferral{get;set;}
        
        @AuraEnabled
        public List<string> reasonForReferralMultiPickSelectedColumn{get;set;}
        
        
        @AuraEnabled
        public List<WrapperAllValues> previousSystemInvolveMultiPickColumn{get;set;}
        
        @AuraEnabled
        public List<string> selectedValuesPreviousSystemInvolve{get;set;}
        
        @AuraEnabled
        public List<string> previousSystemInvolveMultiPickSelectedColumn{get;set;}
        
        
        /*           Closed Multi Picklist           */
        
        
        
        
        /*  SAFETY & RISK ASSESSMENT   */
        
        @AuraEnabled
        public List<WrapperAllValues> immSafetyConcernColumn{get;set;}
        
        @AuraEnabled
        public string immSafetyConcernSelectedColumn{get;set;}
        
        @AuraEnabled
        public List<WrapperAllValues> safetyPlanColumn{get;set;}
        
        @AuraEnabled
        public string safetyPlanSelectedColumn{get;set;}
        
        /* Parent/Guardian */
        @AuraEnabled
        public List<WrapperAllValues> relationshipToChildColumn{get;set;}
        
        @AuraEnabled 
        public String comment{get;set;}
        @AuraEnabled 
        public String briefExplaination{get;set;}
        @AuraEnabled 
        public String SafetyPlanExplaination{get;set;}
        
        @AuraEnabled
        public string relationshipToChildSelectedColumn{get;set;}
        
        @AuraEnabled
        public List<WrapperAllValues> bestTimeToContactColumn{get;set;}
        
        @AuraEnabled
        public string bestTimeToContactSelectedColumn{get;set;}
        
        /*  CONSENT TO TREATMENT */
        
        @AuraEnabled
        public List<WrapperAllValues> participateInCC4YouthColumn{get;set;}
        
        @AuraEnabled
        public string participateInCC4YouthSelectedColumn{get;set;}
        
        @AuraEnabled
        public List<WrapperAllValues> youth14Column{get;set;}
        
        @AuraEnabled
        public string youth14SelectedColumn{get;set;}
        
        
        @AuraEnabled
        public string childRecordId{get;set;}
        @AuraEnabled
        public string firstName{get;set;}
        @AuraEnabled
        public string lastName{get;set;}
        @AuraEnabled
        public date Dob{get;set;}
        @AuraEnabled
        public string childPhnNumber{get;set;} 
        @AuraEnabled
        public string preferedName{get;set;}  
        @AuraEnabled
        public string mailingStreet{get;set;} 
        @AuraEnabled
        public string mailingCity{get;set;} 
        @AuraEnabled
        public string mailingState{get;set;} 
        @AuraEnabled
        public string mailingPostalCode{get;set;} 
        @AuraEnabled
        public string identityExpansion{get;set;} 
        
        @AuraEnabled
        public string genIdentity{get;set;} 
        
        @AuraEnabled
        public string genPronoun{get;set;} 
        
        
        @AuraEnabled
        public string primaryConcern{get;set;}
        
        @AuraEnabled
        public string additionalConcern{get;set;}
        @AuraEnabled
        public string homePhn{get;set;}
        @AuraEnabled
        public string race{get;set;}
        
        
        @AuraEnabled
        public List<WrapperAllValues> racialEthnicIdentityColumn{get;set;}
        
        @AuraEnabled
        public string racialEthnicIdentitySelectedColumn{get;set;}
        
        
        /*              SAFETY & RISK ASSESSMENT                    */
        @AuraEnabled
        public string cyfCaseNumber{get;set;} 
        @AuraEnabled
        public string cyfCaseWorkerName{get;set;} 
        @AuraEnabled
        public string cyfRegionalOfficeServices{get;set;}
        @AuraEnabled
        public boolean cyfFamilyCase{get;set;}  
        @AuraEnabled
        public string cyfCasePhoneNumber{get;set;}  
        
        
        /*   Parent Details   */  
        @AuraEnabled
        public string parentfName{get;set;} 
        @AuraEnabled
        public string parentlName{get;set;} 
        @AuraEnabled
        public string parentPhnNumber{get;set;}
        @AuraEnabled
        public string parentSign{get;set;}
        
        @AuraEnabled
        public string parentEmail{get;set;}
        
        @AuraEnabled
        public string bestTimeToContactParent{get;set;} 
        @AuraEnabled
        public string parentGuardianRelationship{get;set;} 
        
        @AuraEnabled
        public string parentMailingStreet{get;set;} 
        @AuraEnabled
        public string parentMailingCity{get;set;} 
        @AuraEnabled
        public string parentMailingState{get;set;} 
        @AuraEnabled
        public string parentMailingPostalCode{get;set;} 
        
        @AuraEnabled
        public List<WrapperAllValues> guardianMailingStateColumn{get;set;}
        
        @AuraEnabled
        public string guardianMailingStateSelectedColumn{get;set;}
        
        @AuraEnabled
        public string guardianConsentParticipateReceived{get;set;} 
        @AuraEnabled
        public string clientConsentYouth14{get;set;} 
        
        @AuraEnabled
        public string whyConsentNotReceived{get;set;} 
        @AuraEnabled
        public string additionalInfoRegardingConsent{get;set;} 
        
        @AuraEnabled
        public date currDateOfSignature{get;set;} 
        
        @AuraEnabled
        public string youthSignature{get;set;} 
        @AuraEnabled
        public string printYouthSignature{get;set;}
        
        @AuraEnabled
        public string caseId{get;set;} 
        
        /* User details */
        @AuraEnabled
        public string usrFirstNm{get;set;} 
        @AuraEnabled
        public string usrLastNm{get;set;} 
        @AuraEnabled
        public string usrId{get;set;} 
    }
    
    public class WrapperAllValues {
        @AuraEnabled
        public string label{get;set;}
        @AuraEnabled
        public string value{get;set;}
        
        //  @AuraEnabled
        //  public string defaultVal{get;set;}        
    }
    
    public static WrapperAllValues getWrapperValues(string label, string val) {
        WrapperAllValues api = new WrapperAllValues();
        api.label = label;
        api.value = val;
        
        return api;
    }
    
    
}