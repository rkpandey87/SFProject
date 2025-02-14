public without sharing class GGYouthDevelopmentIntakeFormController {
    public static String childId {get;set;}
    public static List<Intake__c> newRecList {get;set;}
    public static String intakeRecordId {get;set;} 
    public static String parentRecordId {get;set;}
    public static List<Contact> getChildRecList {get;set;}
    public static List<Account> accountRecList {get;set;}
    public static List<Contact> getParentRecList {get;set;}
    public static date dateOfSignature{get;set;}




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
    public static List<WrapperAllValues> getSchoolPicklistVal(){
         accountRecList= [Select Id,Type,Name From Account Where Type='School' Limit 5];
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();  
      
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);

      if(accountRecList!=Null && accountRecList.size()>0){
        for(Account accObj: accountRecList){
            
            
            WrapperAllValues  wprAccObj= new WrapperAllValues();
         if(accObj.name!=null){ // && usr.FirstName!=''
         wprAccObj.label= accObj.name;
         }

         if(accObj.Id!=null){
            wprAccObj.value= accObj.id;
         }
         pickListValues.add(wprAccObj);

        }
    }
            System.debug('##pickListValues----> '+pickListValues);
   
        return pickListValues;
    }

    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getGradePicklistVal(){
        // List<string> pickListValues = new List<string>();
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Grade__c.getDescribe();
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
    public static List<WrapperAllValues> getPrimaryParentRelationshipPicklistVal(){
        
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
    public static List<WrapperAllValues> getSecondaryParentRelationshipPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Other_Guardian_Relationship__c.getDescribe();
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
    public static List<WrapperAllValues> getMailingStatePicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.MailingState.getDescribe();
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
    public static List<WrapperAllValues> getOtherStatePicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.OtherState.getDescribe();
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
    public static List<WrapperAllValues> getHadIllnessMultiPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Had_illness__c.getDescribe();
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
    public static List<WrapperAllValues> getHousingTypePicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Housing_Type__c.getDescribe();
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
    public static List<WrapperAllValues> getApprovedRelationship1PicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Approved_Pick_Up_1_Relationship__c.getDescribe();
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
    public static List<WrapperAllValues> getApprovedRelationship2PicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Approved_Pick_Up_2_Relationship__c.getDescribe();
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
    public static List<WrapperAllValues> getMentalHealthHistoryPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Mental_Health_History__c.getDescribe();
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
    public static List<WrapperAllValues> getAllergiesMultiPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Allergies__c.getDescribe();
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
    public static List<WrapperAllValues> getChildAttendAfterSchoolMultiPicklistVal(){
        
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Child_will_Attend_Afterschool__c.getDescribe();
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
    public static List<WrapperAllValues> getInterestAreasMultiPicklistVal(){
        // List<string> pickListValues = new List<string>();
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();
        
        Schema.DescribeFieldResult pickList = Contact.Interest_Areas__c.getDescribe();
        
        
        for(Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
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
    public static List<wrapperList> returnChildRecList(string parentRecId){
        dateOfSignature= System.today();
        

        List<WrapperAllValues> lstPick = getGenderIdentityPicklistVal();
        System.debug('lstPick===> '+lstPick);

        List<WrapperAllValues> lstSchoolPick = getSchoolPicklistVal();
        System.debug('lstSchoolPick===> '+lstSchoolPick);

        List<WrapperAllValues> lstGradePick = getGradePicklistVal();
        System.debug('lstGradePick===> '+lstGradePick);

        List<WrapperAllValues> lstPrimaryParentRelationshipPick = getPrimaryParentRelationshipPicklistVal();
        System.debug('lstPrimaryParentRelationshipPick===> '+lstPrimaryParentRelationshipPick);

        List<WrapperAllValues> lstSecondaryParentRelationshipPick = getSecondaryParentRelationshipPicklistVal();
        System.debug('lstSecondaryParentRelationshipPick===> '+lstSecondaryParentRelationshipPick);

        List<WrapperAllValues> lstMailingStatePick = getMailingStatePicklistVal();
        System.debug('lstSecondaryParentRelationshipPick===> '+lstSecondaryParentRelationshipPick);

        List<WrapperAllValues> lstOtherStatePick = getOtherStatePicklistVal();
        System.debug('lstSecondaryParentRelationshipPick===> '+lstSecondaryParentRelationshipPick);

        List<WrapperAllValues> lstInterestAreasMultiPick = getInterestAreasMultiPicklistVal();
        System.debug('lstInterestAreasMultiPick===> '+lstInterestAreasMultiPick);

        List<WrapperAllValues> lstHadIllnessMultiPick = getHadIllnessMultiPicklistVal();
        System.debug('lstHadIllnessMultiPick===> '+lstHadIllnessMultiPick); 

        List<WrapperAllValues> lstHousingTypePick = getHousingTypePicklistVal();
        System.debug('lstHousingTypePick===> '+lstHousingTypePick); 

        List<WrapperAllValues> lstApprovedRelationship2Pick = getApprovedRelationship2PicklistVal();
        System.debug('lstApprovedRelationship2Pick===> '+lstApprovedRelationship2Pick); 

        List<WrapperAllValues> lstApprovedRelationship1Pick = getApprovedRelationship1PicklistVal();
        System.debug('lstApprovedRelationship1Pick===> '+lstApprovedRelationship1Pick); 

        List<WrapperAllValues> lstMentalHealthHistoryPick = getMentalHealthHistoryPicklistVal();
        System.debug('lstMentalHealthHistoryPick===> '+lstMentalHealthHistoryPick); 

        List<WrapperAllValues> lstAllergiesMultiPick = getAllergiesMultiPicklistVal();
        System.debug('lstAllergiesMultiPick===> '+lstAllergiesMultiPick); 

        List<WrapperAllValues> lstChildAttendAfterSchoolMultiPick = getChildAttendAfterSchoolMultiPicklistVal();
        System.debug('lstChildAttendAfterSchoolMultiPick===> '+lstChildAttendAfterSchoolMultiPick); 



        List<wrapperList> wprList= new List<wrapperList>();
        if(parentRecId!=NULL){
            getChildRecList= [Select FirstName
                              ,LastName
                              ,GenderIdentity	
                              ,Race__c
                              ,Weight__c
                              ,Height_feet__c
                              ,Height_inches__c
                              ,Identifying_Marks__c
                              ,Hair_Color__c
                              ,SSN__c
                              ,Grade__c
                              ,In_School__c
                              ,IEP__c
                              ,Place_of_Employment__c
                              ,Interest_Areas__c
                              ,Eye_Color__c
                              
                              ,Emergency_Contact_First__c
                              ,Emergency_Contact_Last__c
                              ,Emergency_Contact_Phone__c
                              ,Emergency_Contact_Relationship__c
                              ,Emergency_Contact_2_First__c
                              ,Emergency_Contact_2_Last__c
                              ,Emergency_Contact_2_Phone__c
                              ,Approved_Pick_Up_1__c
                              ,Approved_Pick_Up_1_Relationship__c
                              ,Approved_Pick_Up_1_Phone__c
                              ,Approved_Pick_Up_2__c
                              ,Approved_Pick_Up_2_Relationship__c
                              ,Approved_Pick_Up_2_Phone__c
                              ,Physician_Name__c
                              ,Insurance_Number__c
                              ,Last_Physical_MM_YYYY__c
                              ,Operations_Injuries__c
                              ,Medications__c
                              ,Had_illness__c
                              ,Mental_Health_History__c
                              ,MH_History_Detailed__c
                              ,Allergies__c
                              ,Allergies_Detailed__c
                              ,Child_will_Attend_Afterschool__c
                              ,Name_of_Primary_Parent_Guardian__r.Housing_Type__c
                              ,Name_of_Primary_Parent_Guardian__r.Primary_Guardian_First__c
                              ,Name_of_Primary_Parent_Guardian__r.Primary_Guardian_Last__c
                              ,Name_of_Primary_Parent_Guardian__r.firstName
                              ,Name_of_Primary_Parent_Guardian__r.lastName
                              ,Name_of_Primary_Parent_Guardian__r.Primary_Guardian_Relationship__c
                              ,Name_of_Primary_Parent_Guardian__r.MailingStreet
                              ,Name_of_Primary_Parent_Guardian__r.MailingCity
                              ,Name_of_Primary_Parent_Guardian__r.MailingState
                              ,Name_of_Primary_Parent_Guardian__r.MailingpostalCode
                              ,Name_of_Primary_Parent_Guardian__r.Place_of_Employment__c
                              ,Name_of_Primary_Parent_Guardian__r.Household_Monthly_Income__c
                              ,Name_of_Primary_Parent_Guardian__r.HomePhone
                              ,Name_of_Primary_Parent_Guardian__r.Mobile_Phone__c
                              ,Name_of_Primary_Parent_Guardian__r.npe01__WorkPhone__c
                              ,Name_of_Primary_Parent_Guardian__r.Email
                              ,Name_of_Primary_Parent_Guardian__r.Other_Caregiver_First__c
                              ,Name_of_Primary_Parent_Guardian__r.Other_Caregiver_Last__c
                              ,Name_of_Primary_Parent_Guardian__r.Other_Guardian_Relationship__c
                              ,Name_of_Primary_Parent_Guardian__r.OtherStreet
                              ,Name_of_Primary_Parent_Guardian__r.OtherCity
                              ,Name_of_Primary_Parent_Guardian__r.OtherState
                              ,Name_of_Primary_Parent_Guardian__r.OtherPostalCode 
                              ,birthdate
                              ,School__c
                              from Contact where RecordType.Name='Client' and Name_of_Primary_Parent_Guardian__c=:parentRecId and Name_of_Primary_Parent_Guardian__c!=NULL]; 
            System.debug('##getChildRecList-----> '+getChildRecList); //Grade__c
            
          
        }
        
        if(getChildRecList!=Null && getChildRecList.size()>0){
            for(Contact lct: getChildRecList){
                wrapperList wl= new wrapperList();
                
                wl.childRecordId= lct.Id;
                wl.firstName=lct.FirstName; 
                wl.lastName=lct.LastName;
                wl.Dob=lct.Birthdate; 
                //wl.Grade=lct.Birthdate; 
               
                
                wl.currDateOfSignature=dateOfSignature;
                wl.ssn= lct.SSN__c;
                wl.race = lct.Race__c;
                wl.weight = lct.Weight__c;
                wl.htfeet = lct.Height_feet__c;
                wl.htInches = lct.Height_inches__c;
                wl.IdentifyMarks = lct.Identifying_Marks__c;
                wl.hairColor = lct.Hair_Color__c;
                wl.eyeColor = lct.Eye_Color__c;
                wl.currentlyEnrollInSchool=lct.In_School__c;
                wl.Iep=  lct.IEP__c;
                wl.placeOfEmployment=  lct.Place_of_Employment__c;

               
             /* Here is the selected value which are split semicolon of Multipicklist field- Interest Areas */
              
               if(lct.Interest_Areas__c!=null){
                wl.selectedAreaOfInterestValues = lct.Interest_Areas__c.split(';');
                system.debug(wl.selectedAreaOfInterestValues);
                
               }


            if(lstInterestAreasMultiPick!=null){
                wl.areaOfInterestMultiPickColumn= lstInterestAreasMultiPick;
            }
            
            
            if(wl.selectedAreaOfInterestValues!=null){
                wl.areaOfInterestSelectedColumn= wl.selectedAreaOfInterestValues;
             }


             if(lct.Had_illness__c!=null){
                wl.selectedHadIllnessValues = lct.Had_illness__c.split(';');
                system.debug(wl.selectedHadIllnessValues);
                
               }


            if(lstHadIllnessMultiPick!=null){
                wl.hadIllnessMultiPickColumn= lstHadIllnessMultiPick;
            }
            
            
            if(wl.selectedHadIllnessValues!=null){
                wl.hadIllnessSelectedColumn= wl.selectedHadIllnessValues;
                System.debug('wl.hadIllnessSelectedColumn==>'+wl.hadIllnessSelectedColumn);
             }

             /* Mental Health Section  */

             if(lstMentalHealthHistoryPick!=null){
                wl.mentalHealthHistoryColumn= lstMentalHealthHistoryPick;
                System.debug('wl.mentalHealthHistoryColumn==>'+wl.mentalHealthHistoryColumn);
            }
            
            if(lct.Mental_Health_History__c!=null){
                wl.mentalHealthHistorySelectedColumn= lct.Mental_Health_History__c;
                System.debug('***wl.mentalHealthHistorySelectedColumn==>'+lct.Mental_Health_History__c);
            }else{
                 wl.mentalHealthHistorySelectedColumn= '--Select--';
            }

            if(lct.MH_History_Detailed__c!=null){
                wl.mhHistoryDetailed= lct.MH_History_Detailed__c;
            }
          


            /*Allergies  Section*/

            if(lct.Allergies__c!=null){
                wl.selectedAllergiesValues = lct.Allergies__c.split(';');
                system.debug(wl.selectedAllergiesValues);
                
               }


            if(lstAllergiesMultiPick!=null){
                wl.allergiesMultiPickColumn= lstAllergiesMultiPick;
            }
            
            
            if(wl.selectedAllergiesValues!=null){
                wl.allergiesSelectedColumn= wl.selectedAllergiesValues;
                System.debug('wl.allergiesSelectedColumn==>'+wl.allergiesSelectedColumn);
             }

             if(lct.Allergies_Detailed__c!=null){
                wl.allergiesDetailed= lct.Allergies_Detailed__c;
             }
            

           /*    PROGRAM ATTENDANCE  Section*/

           if(lct.Child_will_Attend_Afterschool__c!=null){
            wl.selectedChildAttendAfterSchoolValues = lct.Child_will_Attend_Afterschool__c.split(';');
            system.debug(wl.selectedChildAttendAfterSchoolValues);
            
           }


        if(lstChildAttendAfterSchoolMultiPick!=null){
            wl.childAttendAfterSchoolMultiPickColumn= lstChildAttendAfterSchoolMultiPick;
        }
        
        
        if(wl.selectedChildAttendAfterSchoolValues!=null){
            wl.childAttendAfterSchoolSelectedColumn= wl.selectedChildAttendAfterSchoolValues;
            System.debug('wl.allergiesSelectedColumn==>'+wl.childAttendAfterSchoolSelectedColumn);
         }



                if(lstSchoolPick!=null){
                    wl.schoolColumn= lstSchoolPick;
                    System.debug('wl.schoolColumn==>'+wl.schoolColumn);
                }
                
                if(lct.School__c!=null){
                    wl.schoolSelectedColumn= lct.School__c;
                    System.debug('***wl.schoolSelectedColumn==>'+lct.School__c);
                }else{
                     wl.schoolSelectedColumn= '--Select--';
                }

                if(lstPick!=null){
                    wl.genIdentityColumn= lstPick;
                }
                
                if(lct.GenderIdentity!=null){
                    wl.genIdentitySelectedColumn= lct.GenderIdentity;
                }else{
                     wl.genIdentitySelectedColumn= '--Select--';
                }
                
                if(lstGradePick!=null){
                    wl.gradeColumn= lstGradePick;
                }
                
                if(lct.Grade__c!=null){
                    wl.gradeSelectedColumn= lct.Grade__c;
                }else{
                     wl.gradeSelectedColumn= '--Select--';
                }

                /* SOURCE OF INCOME Section*/
                if(lstHousingTypePick!=null){
                    wl.housingColumn= lstHousingTypePick;
                    System.debug('wl.housingColumn==>'+wl.housingColumn);
                }
                
                if(lct.Name_of_Primary_Parent_Guardian__r.Housing_Type__c!=null){
                    wl.housingSelectedColumn= lct.Name_of_Primary_Parent_Guardian__r.Housing_Type__c;
                    System.debug('***wl.housingSelectedColumn==>'+lct.Name_of_Primary_Parent_Guardian__r.Housing_Type__c);
                }else{
                     wl.housingSelectedColumn= '--Select--';
                }


               /* EMERGENCY CONTACTS  */
               if(lct.Emergency_Contact_First__c!= NULL){
                wl.emergencyContactfName1=lct.Emergency_Contact_First__c;
               }

               if(lct.Emergency_Contact_Last__c!= NULL){
                wl.emergencyContactLName1= lct.Emergency_Contact_Last__c;
               }

               if(lct.Emergency_Contact_Phone__c!= NULL){
                wl.emergencyContactPhone1= lct.Emergency_Contact_Phone__c;
               }

               if(lct.Emergency_Contact_2_First__c!= NULL){
                wl.emergencyContactfName2= lct.Emergency_Contact_2_First__c;
               }

               if(lct.Emergency_Contact_2_Last__c!= NULL){
                wl.emergencyContactLName2= lct.Emergency_Contact_2_Last__c;
               }

               if(lct.Emergency_Contact_2_Phone__c!= NULL){
                wl.emergencyContactPhone2= lct.Emergency_Contact_2_Phone__c;
               }
               
               
              
               
               
              

                /* APPROVED PICK-UPS Section*/
                if(lct.Approved_Pick_Up_1__c!= NULL){
                    wl.approvedPickupName1= lct.Approved_Pick_Up_1__c;
                }

                if(lct.Approved_Pick_Up_1_Phone__c!= NULL){
                    wl.approvedPickupPhone1= lct.Approved_Pick_Up_1_Phone__c;
                }

                if(lct.Approved_Pick_Up_2__c!= NULL){
                    wl.approvedPickupName2= lct.Approved_Pick_Up_2__c;
                }

                if(lct.Approved_Pick_Up_2_Phone__c!= NULL){
                    wl.approvedPickupPhone2= lct.Approved_Pick_Up_2_Phone__c;
                }
             
                if(lstApprovedRelationship1Pick!=null){
                    wl.approvedPickupRelationshipColumn= lstApprovedRelationship1Pick;
                    System.debug('wl.approvedPickupRelationshipColumn==>'+wl.approvedPickupRelationshipColumn);
                }
                
                if(lct.Approved_Pick_Up_1_Relationship__c!=null){
                    wl.approvedPickupRelationshipSelectedColumn= lct.Approved_Pick_Up_1_Relationship__c;
                 
                }else{
                     wl.approvedPickupRelationshipSelectedColumn= '--Select--';
                }

                if(lstApprovedRelationship2Pick!=null){
                    wl.approvedPickupRelationshipColumn2= lstApprovedRelationship2Pick;
                    System.debug('wl.approvedPickupRelationshipColumn2==>'+wl.approvedPickupRelationshipColumn2);
                }
                
                if(lct.Approved_Pick_Up_2_Relationship__c!=null){
                    wl.approvedPickupRelationshipSelectedColumn2= lct.Approved_Pick_Up_2_Relationship__c;
                 
                }else{
                     wl.approvedPickupRelationshipSelectedColumn2= '--Select--';
                }
              
                
                

                /*  HEALTH AND WELLNESS INFORMATION Section*/

                if(lct.Physician_Name__c!= NULL){
                    wl.physicianName=lct.Physician_Name__c;
                }

                if(lct.Insurance_Number__c!= NULL){
                    wl.insuranceNumber= lct.Insurance_Number__c;
                }

                if(lct.Last_Physical_MM_YYYY__c!= NULL){
                    wl.lastPhysical= lct.Last_Physical_MM_YYYY__c;
                }

                if(lct.Operations_Injuries__c!= NULL){
                    wl.operationInjuries= lct.Operations_Injuries__c;
                }

                if(lct.Medications__c!= NULL){
                    wl.medications= lct.Medications__c;
                }
                
               
                
               
                

                if(lstPrimaryParentRelationshipPick!=null){
                    wl.primaryParentRelationshipColumn= lstPrimaryParentRelationshipPick;
                    System.debug('wl.primaryParentRelationshipColumn==>'+wl.primaryParentRelationshipColumn);
                }
                
                if(lct.Name_of_Primary_Parent_Guardian__r.Primary_Guardian_Relationship__c!=null){
                    wl.primaryParentRelationshipSelectedColumn= lct.Name_of_Primary_Parent_Guardian__r.Primary_Guardian_Relationship__c;
                    System.debug('***wl.primaryParentRelationshipSelectedColumn==>'+lct.Name_of_Primary_Parent_Guardian__r.Primary_Guardian_Relationship__c);
                }else{
                     wl.primaryParentRelationshipSelectedColumn= '--Select--';
                }

                if(lstSecondaryParentRelationshipPick!=null){
                    wl.secondaryParentRelationshipColumn= lstSecondaryParentRelationshipPick;
                    System.debug('wl.secondaryParentRelationshipColumn==>'+wl.secondaryParentRelationshipColumn);
                }
                
                if(lct.Name_of_Primary_Parent_Guardian__r.Other_Guardian_Relationship__c!=null){
                    wl.secondaryParentRelationshipSelectedColumn= lct.Name_of_Primary_Parent_Guardian__r.Other_Guardian_Relationship__c;
                    System.debug('***wl.secondaryParentRelationshipSelectedColumn==>'+lct.Name_of_Primary_Parent_Guardian__r.Other_Guardian_Relationship__c);
                }else{
                     wl.secondaryParentRelationshipSelectedColumn= '--Select--';
                }

                if(lstMailingStatePick!=null){
                    wl.primaryParentMailingStateColumn= lstMailingStatePick;
                    System.debug('wl.primaryParentMailingStateColumn==>'+wl.primaryParentMailingStateColumn);
                }  
                if(lct.Name_of_Primary_Parent_Guardian__r.MailingState!=null){
                    wl.primaryParentMailingStateSelectedColumn= lct.Name_of_Primary_Parent_Guardian__r.MailingState;
                    System.debug('***wl.primaryParentMailingStateSelectedColumn==>'+lct.Name_of_Primary_Parent_Guardian__r.MailingState);
                }else{
                     wl.primaryParentMailingStateSelectedColumn= '--Select--';
                }

                if(lstOtherStatePick!=null){
                    wl.secondaryParentMailingStateColumn= lstOtherStatePick;
                    System.debug('wl.secondaryParentMailingStateColumn==>'+wl.secondaryParentMailingStateColumn);
                }  
                if(lct.Name_of_Primary_Parent_Guardian__r.OtherState!=null){
                    wl.secondaryParentMailingStateSelectedColumn= lct.Name_of_Primary_Parent_Guardian__r.OtherState;
                    System.debug('***wl.secondaryParentMailingStateSelectedColumn==>'+lct.Name_of_Primary_Parent_Guardian__r.OtherState);
                }else{
                     wl.secondaryParentMailingStateSelectedColumn= '--Select--';
                }


                /* Primary Parent Details */

               // Don't use these fields- Primary_Guardian_First__c, Primary_Guardian_Last__c instead of that use fields-firstName,lastname for primary contact.
                wl.primaryParentfName= lct.Name_of_Primary_Parent_Guardian__r.firstName;
                wl.primaryParentlName= lct.Name_of_Primary_Parent_Guardian__r.lastname;
               // wl.primaryParentPhnNumber=  lct.Name_of_Primary_Parent_Guardian__r.Primary_Guardian_Relationship__c;
                wl.primaryParentMailingStreet=  lct.Name_of_Primary_Parent_Guardian__r.MailingStreet;
                wl.primaryParentMailingCity=  lct.Name_of_Primary_Parent_Guardian__r.MailingCity;
                wl.primaryParentMailingState=  lct.Name_of_Primary_Parent_Guardian__r.MailingState;
                wl.primaryParentMailingPostalCode=   lct.Name_of_Primary_Parent_Guardian__r.MailingpostalCode;

                wl.primaryParentPlaceOfEmployment= lct.Name_of_Primary_Parent_Guardian__r.Place_of_Employment__c;
                wl.homePhn= lct.Name_of_Primary_Parent_Guardian__r.HomePhone;
                wl.mobilePhn= lct.Name_of_Primary_Parent_Guardian__r.Mobile_Phone__c;
                wl.workPhn= lct.Name_of_Primary_Parent_Guardian__r.npe01__WorkPhone__c;
                wl.email= lct.Name_of_Primary_Parent_Guardian__r.Email;
                wl.monthlyIncome= lct.Name_of_Primary_Parent_Guardian__r.Household_Monthly_Income__c;

                /* Secondary Parent Details */

                wl.secondaryParentfName= lct.Name_of_Primary_Parent_Guardian__r.Other_Caregiver_First__c;

                wl.secondaryParentlName= lct.Name_of_Primary_Parent_Guardian__r.Other_Caregiver_Last__c;
              //  wl.secondaryParentPhnNumber= lct.Name_of_Primary_Parent_Guardian__r.OtherState;
                wl.secondaryParentMailingStreet= lct.Name_of_Primary_Parent_Guardian__r.OtherStreet;
                wl.secondaryParentMailingCity= lct.Name_of_Primary_Parent_Guardian__r.OtherCity;
                wl.secondaryParentMailingState= lct.Name_of_Primary_Parent_Guardian__r.OtherState;
                wl.secondaryParentMailingPostalCode= lct.Name_of_Primary_Parent_Guardian__r.OtherPostalCode ;

              

                //wl.gradeSelectedColumn= null;
                childId=  wl.childRecordId;
                wprList.add(wl);
               
                System.debug('##wprList1-----> '+wprList);
                System.debug('##childId-----> '+childId);
               
                System.debug('***wl.gradeSelectedColumn-----> '+wl.gradeSelectedColumn);
            }
        }else{
            wrapperList wprNewParent= new wrapperList();
           
          
            wprNewParent.firstName=null; 
            wprNewParent.Dob=null; 
            wprNewParent.lastName=null;

          

            wprNewParent.currentlyEnrollInSchool=null;
            wprNewParent.Iep=  null;
            wprNewParent.placeOfEmployment=  null;
            wprNewParent.primaryParentPlaceOfEmployment= null;

            wprNewParent.primaryParentfName=  null;
            wprNewParent.primaryParentlName= null;
            wprNewParent.primaryParentPhnNumber=  null;
            wprNewParent.primaryParentMailingStreet=  null;
            wprNewParent.primaryParentMailingCity=  null;
            wprNewParent.primaryParentMailingState=  null;
            wprNewParent.primaryParentMailingPostalCode=    null;

            wprNewParent.secondaryParentMailingState= null;
            wprNewParent.secondaryParentMailingStreet= null;
            wprNewParent.secondaryParentMailingCity= null;
            wprNewParent.secondaryParentMailingPostalCode= null;

            if(lstInterestAreasMultiPick!=null){
                wprNewParent.areaOfInterestMultiPickColumn= lstInterestAreasMultiPick;
            }

            if(lstPick!=null){
                wprNewParent.genIdentityColumn= lstPick;      
            }

            if(lstSchoolPick!=null){
                wprNewParent.schoolColumn= lstSchoolPick;
                 System.debug('##wprNewParent.schoolColumn-----> '+wprNewParent.schoolColumn);
             }

             if(lstGradePick!=null){
                wprNewParent.gradeColumn= lstGradePick;
            }

            /*Source Of Income Section */
            if(lstHousingTypePick!=null){
                wprNewParent.housingColumn= lstHousingTypePick;
                System.debug('wprNewParent.housingColumn==>'+wprNewParent.housingColumn);
            }

            wprNewParent.monthlyIncome= Null;

            /* EMERGENCY CONTACTS Section */
            
            wprNewParent.emergencyContactfName1= Null;
  
            wprNewParent.emergencyContactLName1= Null;
   
            wprNewParent.emergencyContactPhone1= Null;
  
            wprNewParent.emergencyContactfName2= Null;
  
            wprNewParent.emergencyContactLName2= Null;
   
            wprNewParent.emergencyContactPhone2= Null;

             /* APPROVED PICK-UPS Section*/          
             wprNewParent.approvedPickupName1= Null;
             wprNewParent.approvedPickupPhone1= Null;
             wprNewParent.approvedPickupName2= Null;
             wprNewParent.approvedPickupPhone2= Null;

             if(lstApprovedRelationship1Pick!=null){
                wprNewParent.approvedPickupRelationshipColumn= lstApprovedRelationship1Pick;
                System.debug('wprNewParent.approvedPickupRelationshipColumn==>'+wprNewParent.approvedPickupRelationshipColumn);
            }

            if(lstApprovedRelationship2Pick!=null){
                wprNewParent.approvedPickupRelationshipColumn2= lstApprovedRelationship2Pick;
                System.debug('wprNewParent.approvedPickupRelationshipColumn2==>'+wprNewParent.approvedPickupRelationshipColumn2);
            }

             
   /*  HEALTH AND WELLNESS INFORMATION Section*/

             wprNewParent.physicianName= Null;
             wprNewParent.insuranceNumber= Null;
             wprNewParent.lastPhysical= Null;
             wprNewParent.operationInjuries= Null;
             wprNewParent.medications= Null;

             if(lstHadIllnessMultiPick!=null){
                wprNewParent.hadIllnessMultiPickColumn= lstHadIllnessMultiPick;
            }

       /*  Mental Health INFORMATION Section*/ 
       if(lstMentalHealthHistoryPick!=null){
        wprNewParent.mentalHealthHistoryColumn= lstMentalHealthHistoryPick;
        System.debug('wprNewParent.mentalHealthHistoryColumn==>'+wprNewParent.mentalHealthHistoryColumn);
     }    

     
     wprNewParent.mhHistoryDetailed= null;
    

     /* ALLERGIES */
     if(lstAllergiesMultiPick!=null){
        wprNewParent.allergiesMultiPickColumn= lstAllergiesMultiPick;
    }

    wprNewParent.allergiesDetailed= null;
   
    /* PROGRAM ATTENDANCE */
    if(lstChildAttendAfterSchoolMultiPick!=null){
        wprNewParent.childAttendAfterSchoolMultiPickColumn= lstChildAttendAfterSchoolMultiPick;
    }

            if(lstPrimaryParentRelationshipPick!=null){
                wprNewParent.primaryParentRelationshipColumn= lstPrimaryParentRelationshipPick;
                System.debug('wprNewParent.primaryParentRelationshipColumn==>'+wprNewParent.primaryParentRelationshipColumn);
            }

            if(lstSecondaryParentRelationshipPick!=null){
                wprNewParent.secondaryParentRelationshipColumn= lstSecondaryParentRelationshipPick;
                System.debug('wprNewParent.secondaryParentRelationshipColumn==>'+wprNewParent.secondaryParentRelationshipColumn);
            }

            if(lstMailingStatePick!=null){
                wprNewParent.primaryParentMailingStateColumn= lstMailingStatePick;
                System.debug('wprNewParent.primaryParentMailingStateColumn==>'+wprNewParent.primaryParentMailingStateColumn);
            }  
            
             if(lstOtherStatePick!=null){
                wprNewParent.secondaryParentMailingStateColumn= lstOtherStatePick;
                System.debug('wprNewParent.secondaryParentMailingStateColumn==>'+wprNewParent.secondaryParentMailingStateColumn);
            }  

           wprNewParent.ssn= null;
           wprNewParent.race = null;
           wprNewParent.weight = null;
           wprNewParent.htfeet = null;
           wprNewParent.htInches = null;
           wprNewParent.IdentifyMarks = null;
           wprNewParent.hairColor = null;
           wprNewParent.eyeColor =null;
            wprNewParent.currDateOfSignature=dateOfSignature;
            wprList.add(wprNewParent);
            System.debug('##wprList2-----> '+wprList);
            System.debug('***wprNewParent.gradeSelectedColumn-----> '+wprNewParent.gradeSelectedColumn);
        }
        return wprList;
    }


    @AuraEnabled(cacheable=true)
    public static List<string> getHearAboutUsPicklistVal(){
        List<string> pickListValues = new List<string>();
        Schema.DescribeFieldResult pickList = Contact.Neighborhood_CC__c.getDescribe();
        for( Schema.PicklistEntry pickVal : pickList.getPicklistValues()){
            pickListValues.add(pickVal.getValue());
            System.debug('##pickListValues----> '+pickListValues);
        }   
        return pickListValues;
    }
    


    @AuraEnabled
    public static void saveIntakeRecord(string itemData, string parentId){ 
    
       
        system.debug('###itemData==========> '+itemData);
        system.debug('###parentId==========> '+parentId);
       
        
        String newParentGuardianId;
        
        
        dateOfSignature= System.today();
        
    /* Attach these Parent Id in case of existing Parent record */
    string parentRecdIdVar;
    if(parentId!=NULL){
         parentRecdIdVar= parentId;
    }
        
        system.debug('###parentRecdIdVar==========> '+parentRecdIdVar);
        
        /* CLIENT INFORMATION */
        string fname;
        string lname;
        string dob;
        string SSN;
        string genderIdentity;
        string WEIGHT;
        string heightFeet;
        string heightInches;
        string identifyingMarks;
        string hairColor;
        string eyeColor;

        /* SCHOOL INFORMATION */
        string gradeVal;
        string schoolVal;
        boolean youthEnrolledInSchool;
        boolean youthIep;
        String clientId;


       
      
 /* YOUTH AGES 14+ */
 string childPlaceOfEmployment;
 string allstring;
 string areaOfInterestMultiPickSelected;

  /* EMERGENCY CONTACTS */
  string emergencyConFName1;
  string emergencyConLName1;
  string emergencyConPhone1;
  string emergencyConFName2;
  string emergencyConLName2;
  string emergencyConPhone2;

   /* APPROVED PICK-UPS */
   string approvePickupName1;
   string approvePickupRelationship1;
   string approvePickupPhone1;
   string approvePickupName2;
   string approvePickupRelationship2;
   string approvePickupPhone2;


    /* TRANSPORTATION METHODS */
     /* ALTERNATE ADDRESS */

      /* HEALTH AND WELLNESS INFORMATION */
      string childPhysicianName;
      string InsuranceNumber;
      string OperationInjuries;
      string medications;
      string hadIllnessMultiPickSelected;


       /* MENTAL HEALTH INFORMATION */
       string mentalHealthDiagnosis;
       string addMentalHealthInfo;

        /* COVID-19 SCREENING   */

         /* ALLERGIES */
         string allergies;
         string allergyDetail;


         /* PROGRAM ATTENDANCE */
         string childAttendAfterProgram;

      // List<String> areaOfInterestMultiPickSelected;

       /*  PARENT(S)/GUARDIAN(S) INFORMATION  */     

        string primaryParFName;
        string primaryParLName;
        string parPhnNumber;
        string primaryParRelationSelected;
        string primaryParMailingStreet;
        string primaryParMailingCity;
        string primaryParMailingState;
        string primaryParMailingPostalCode;
        string primaryParPlaceOfEmployment;
        string primaryParHomePhone;
        string primaryParMobilePhone;
        string primaryParWorkPhone;
        string primaryParEmail;
        string primaryParHouseholdMonthlyIncome;
        string housingType;
        string csId;

        string secondaryParFName;
        string secondaryParLName;
        string secondaryParRelationSelected;
        string secondaryParMailingStreet;
        string secondaryParMailingCity;
        string secondaryParMailingState;
        string secondaryParMailingPostalCode;
        
        System.debug('##schoolVal===> '+schoolVal);
        Map<String, Object> mapItem;
        system.debug('###itemData===========> '+itemData);
        
        List<Object> lstItemData = (List<Object>)JSON.deserializeUntyped(itemData);
        
        try{
            Id youthRecTypeId = Schema.SObjectType.Intake__c.getRecordTypeInfosByName().get('Youth Development').getRecordTypeId();
            Id parentGuardianRTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId(); 
            newRecList = new List<Intake__c>();
            List<wrapperList> wprListNew= new List<wrapperList>();
            List<Contact> newConList= new List<Contact>();
            
            // Created new Parent record to attached their Id in 'New Parent' case scenario.
            If(parentid!=null && parentid!='nullId'){
                
          
		  
		  
		  
                
          }else{
            if(lstItemData!=Null && lstItemData.size()>0){
                    mapItem = (Map<String, Object>) lstItemData[0];
              }
                primaryParFName= string.valueOf(mapItem.get('primaryParentfName')); 
                primaryParLName= string.valueOf(mapItem.get('primaryParentlName'));
                primaryParRelationSelected= string.valueOf(mapItem.get('primaryParentRelationshipSelectedColumn'));
                parPhnNumber=string.valueOf(mapItem.get('homePhn'));
                primaryParMailingStreet= string.valueOf(mapItem.get('primaryParentMailingStreet'));
                 primaryParMailingCity=  string.valueOf(mapItem.get('primaryParentMailingCity'));
                 primaryParMailingState=  string.valueOf(mapItem.get('primaryParentMailingState'));
                 primaryParMailingPostalCode=  string.valueOf(mapItem.get('primaryParentMailingPostalCode'));
                 primaryParPlaceOfEmployment=  string.valueOf(mapItem.get('placeOfEmployment'));
               
                 primaryParMobilePhone=  string.valueOf(mapItem.get('mobilePhn'));
                 primaryParWorkPhone=  string.valueOf(mapItem.get('workPhn'));
                 primaryParEmail=  string.valueOf(mapItem.get('email'));
                 if(string.valueOf(mapItem.get('monthlyIncome'))!=NULL){
                    primaryParHouseholdMonthlyIncome= string.valueOf(mapItem.get('monthlyIncome'));
                 }

                  housingType= string.valueOf(mapItem.get('housingSelectedColumn')); 

                  secondaryParFName= string.valueOf(mapItem.get('secondaryParentfName'));
                  secondaryParLName= string.valueOf(mapItem.get('secondaryParentlName'));
                  secondaryParRelationSelected= string.valueOf(mapItem.get('secondaryParentRelationshipSelectedColumn'));
                  secondaryParMailingStreet= string.valueOf(mapItem.get('secondaryParentMailingStreet'));
                  secondaryParMailingCity= string.valueOf(mapItem.get('secondaryParentMailingCity'));
                  secondaryParMailingState= string.valueOf(mapItem.get('secondaryParentMailingState'));
                  secondaryParMailingPostalCode= string.valueOf(mapItem.get('secondaryParentMailingPostalCode'));
                

                
                
                
                // Creating Parent Record as per data collect from User during Intake form Submission
                Contact con= new Contact();
                con.firstName= primaryParFName;
                con.lastName= primaryParLName;
                con.Primary_Guardian_Relationship__c= primaryParRelationSelected;
                con.MailingStreet= primaryParMailingStreet;
                con.MailingCity= primaryParMailingCity;
                con.MailingState= primaryParMailingState;
                con.MailingpostalCode= primaryParMailingPostalCode;
                con.Place_of_Employment__c= primaryParPlaceOfEmployment;
                con.HomePhone= parPhnNumber;
                con.Mobile_Phone__c= primaryParMobilePhone;
                con.npe01__WorkPhone__c= primaryParWorkPhone;
                con.Email= primaryParEmail;
                con.Household_Monthly_Income__c= decimal.valueOf(primaryParHouseholdMonthlyIncome);
                con.Housing_Type__c=housingType;
               // con.Household_Monthly_Income__c= decimal.valueOf(primaryParHouseholdMonthlyIncome);

                con.Other_Caregiver_First__c= secondaryParFName;
                con.Other_Caregiver_Last__c= secondaryParLName;
                con.Other_Guardian_Relationship__c= secondaryParRelationSelected;
                con.OtherStreet= secondaryParMailingStreet;
                con.OtherCity= secondaryParMailingCity;
                con.OtherState= secondaryParMailingState;
                con.OtherPostalCode= secondaryParMailingPostalCode;
                

              
                con.RecordTypeId=parentGuardianRTypeId;
                newConList.add(con);
                system.debug('****con.HomePhone:===========> '+con.HomePhone);
                
              }
            
            
            if(newConList!=null && newConList.size()>0){
                insert newConList[0];
                newParentGuardianId= newConList[0].id;
                system.debug('****newParentGuardianId:===========> '+newParentGuardianId);
                system.debug('****newRecList3:===========> '+newConList[0]);
                
            }
            
            if(lstItemData!=Null && lstItemData.size()>0){
                for(Object itemObj : lstItemData) {                        
                    mapItem = (Map<String, Object>) itemObj;

                    /*Client Id and Existing Case Id */
                    clientId= string.valueOf(mapItem.get('childRecordId')); 
                    csId= string.valueOf(mapItem.get('caseId'));
                    
                    /*    CLIENT INFORMATION     */
                    fname = string.valueof(mapItem.get('firstName'));
                    lname = string.valueOf(mapItem.get('lastName')); 
                    if(mapItem.get('Dob')!=null){
                        dob = string.valueOf(mapItem.get('Dob')); 
                    }
                   
                    if(mapItem.get('ssn')!=NULL){
                        SSN= string.valueOf(mapItem.get('ssn')); 
                    }
                    System.debug('****SSN===> '+SSN);
                   
                    if(mapItem.get('genIdentitySelectedColumn')!=NULL){
                        genderIdentity= string.valueOf(mapItem.get('genIdentitySelectedColumn')); 
                    }
                    System.debug('****genderIdentity===> '+genderIdentity);

                    if(mapItem.get('weight')!=NULL){
                        WEIGHT= string.valueOf(mapItem.get('weight')); 
                    }
                    System.debug('****WEIGHT===> '+WEIGHT);

                    if(mapItem.get('htfeet')!=NULL){
                        heightFeet= string.valueOf(mapItem.get('htfeet')); 
                    }
                    System.debug('****heightFeet===> '+heightFeet);

                    if(mapItem.get('htInches')!=NULL){
                        heightInches= string.valueOf(mapItem.get('htInches')); 
                    }
                    System.debug('****heightInches===> '+heightInches);

                    if(mapItem.get('IdentifyMarks')!=NULL){
                        identifyingMarks= string.valueOf(mapItem.get('IdentifyMarks')); 
                    }
                    System.debug('****identifyingMarks===> '+identifyingMarks);

                    if(mapItem.get('hairColor')!=NULL){
                        hairColor= string.valueOf(mapItem.get('hairColor')); 
                    }
                    System.debug('****hairColor===> '+hairColor);

                    if(mapItem.get('eyeColor')!=NULL){
                        eyeColor= string.valueOf(mapItem.get('eyeColor')); 
                    }
                    System.debug('****eyeColor===> '+eyeColor);
                     
                     
                     
                    
                     
                    

                     /*    SCHOOL INFORMATION   */ 
                    gradeVal=string.valueOf(mapItem.get('gradeSelectedColumn'));
                    schoolVal= string.valueOf(mapItem.get('schoolSelectedColumn'));
                    if(mapItem.get('currentlyEnrollInSchool')!=null){
                        youthEnrolledInSchool= boolean.valueOf(mapItem.get('currentlyEnrollInSchool'));
                    }
                   
                    if(mapItem.get('Iep')!=null){
                        youthIep= boolean.valueOf(mapItem.get('Iep'));
                    }
                    
                    System.debug('****gradeVal===> '+gradeVal);
                    System.debug('****schoolVal===> '+schoolVal);

                     /*    YOUTH AGES 14+   */ 

                     childPlaceOfEmployment=  string.valueOf(mapItem.get('placeOfEmployment'));

                      areaOfInterestMultiPickSelected =  string.valueOf(mapItem.get('areaOfInterestSelectedColumn'));
                    system.debug('**priConcrnMultiPickVal Testing==> '+areaOfInterestMultiPickSelected);

                    /* EMERGENCY CONTACTS */
                     emergencyConFName1= string.valueOf(mapItem.get('emergencyContactfName1'));
                     emergencyConLName1= string.valueOf(mapItem.get('emergencyContactLName1'));
                     emergencyConPhone1= string.valueOf(mapItem.get('emergencyContactPhone1'));
                     emergencyConFName2= string.valueOf(mapItem.get('emergencyContactfName2'));
                     emergencyConLName2= string.valueOf(mapItem.get('emergencyContactLName2'));
                     emergencyConPhone2= string.valueOf(mapItem.get('emergencyContactPhone2'));

                     /* APPROVED PICK-UPS */
                    approvePickupName1=       string.valueOf(mapItem.get('approvedPickupName1'));
                    approvePickupRelationship1= string.valueOf(mapItem.get('approvedPickupRelationshipSelectedColumn'));
                    approvePickupPhone1= string.valueOf(mapItem.get('approvedPickupPhone1'));
                    approvePickupName2= string.valueOf(mapItem.get('approvedPickupName2'));
                    approvePickupRelationship2= string.valueOf(mapItem.get('approvedPickupRelationshipSelectedColumn2'));
                    approvePickupPhone2= string.valueOf(mapItem.get('approvedPickupPhone2'));

                      /* HEALTH AND WELLNESS INFORMATION */
                      childPhysicianName=       string.valueOf(mapItem.get('physicianName'));
                    InsuranceNumber=       string.valueOf(mapItem.get('insuranceNumber'));
                    OperationInjuries=       string.valueOf(mapItem.get('operationInjuries'));
                    medications=       string.valueOf(mapItem.get('medications'));
                    hadIllnessMultiPickSelected=       string.valueOf(mapItem.get('hadIllnessSelectedColumn'));

                    /*     MENTAL HEALTH INFORMATION      */
                    mentalHealthDiagnosis=  string.valueOf(mapItem.get('mentalHealthHistorySelectedColumn'));
                    addMentalHealthInfo=  string.valueOf(mapItem.get('mhHistoryDetailed'));

                   /*     ALLERGIES       */
                    allergies=  string.valueOf(mapItem.get('allergiesSelectedColumn'));
                     allergyDetail=  string.valueOf(mapItem.get('allergiesDetailed'));


                     /*     PROGRAM ATTENDANCE    */
                     childAttendAfterProgram=  string.valueOf(mapItem.get('childAttendAfterSchoolSelectedColumn'));

                    /*   Primary Parent   */

                    primaryParFName= string.valueOf(mapItem.get('primaryParentfName')); 
                    primaryParLName= string.valueOf(mapItem.get('primaryParentlName'));
                    primaryParRelationSelected= string.valueOf(mapItem.get('primaryParentRelationshipSelectedColumn'));
                    parPhnNumber=string.valueOf(mapItem.get('homePhn'));
                    primaryParMailingStreet= string.valueOf(mapItem.get('primaryParentMailingStreet'));
                     primaryParMailingCity=  string.valueOf(mapItem.get('primaryParentMailingCity'));
                     primaryParMailingState=  string.valueOf(mapItem.get('primaryParentMailingState'));
                     primaryParMailingPostalCode=  string.valueOf(mapItem.get('primaryParentMailingPostalCode'));
                     primaryParPlaceOfEmployment=  string.valueOf(mapItem.get('placeOfEmployment'));
                   
                     primaryParMobilePhone=  string.valueOf(mapItem.get('mobilePhn'));
                     primaryParWorkPhone=  string.valueOf(mapItem.get('workPhn'));
                     primaryParEmail=  string.valueOf(mapItem.get('email'));
                     primaryParHouseholdMonthlyIncome= string.valueOf(mapItem.get('monthlyIncome'));
    
                    /*   Secondary Parent   */
                      secondaryParFName= string.valueOf(mapItem.get('secondaryParentfName'));
                      secondaryParLName= string.valueOf(mapItem.get('secondaryParentlName'));
                      secondaryParRelationSelected= string.valueOf(mapItem.get('secondaryParentRelationshipSelectedColumn'));
                      secondaryParMailingStreet= string.valueOf(mapItem.get('secondaryParentMailingStreet'));
                      secondaryParMailingCity= string.valueOf(mapItem.get('secondaryParentMailingCity'));
                      secondaryParMailingState= string.valueOf(mapItem.get('secondaryParentMailingState'));
                      secondaryParMailingPostalCode= string.valueOf(mapItem.get('secondaryParentMailingPostalCode'));

                   


                    
            // binds the itemData  list with wrapper list to pass clientId to existing child Lookup 
                    wrapperList wlNew= new wrapperList();
                    if(clientId!=Null){
                        wlNew.childRecordId= clientId;
                    }
                    if(csId!=Null){
                        wlNew.caseId=csId;
                    }
                   
            /*   Hold  CLIENT INFORMATION  from User  in Wrapper   */
                     if(fname!=Null){
                        wlNew.firstName= fname;
                    }

                    if(lname!=Null){
                        wlNew.lastName= lname;
                    }

                    if(dob!=Null){
                        wlNew.Dob= date.valueOf(dob);
                    }

                    if(SSN!=Null){
                        wlNew.ssn= SSN;
                    }

                    if(genderIdentity!=Null){
                        wlNew.genIdentitySelectedColumn= genderIdentity;
                    }
                    if(WEIGHT!=Null){
                        wlNew.weight= decimal.valueOf(WEIGHT);
                    }
                    if(heightFeet!=Null){
                        wlNew.htfeet= decimal.valueOf(heightFeet);
                    }
                    if(heightInches!=Null){
                        wlNew.htInches= decimal.valueOf(heightInches);
                    }
                    if(identifyingMarks!=Null){
                        wlNew.IdentifyMarks= identifyingMarks;
                    }
                    if(hairColor!=Null){
                        wlNew.hairColor= hairColor;
                    }
                    if(eyeColor!=Null){
                        wlNew.eyeColor= eyeColor;
                    }
                   
                   
                 /*   Hold  SCHOOL INFORMATION  from User  in Wrapper   */   
                 if(gradeVal!=null){
                    wlNew.gradeSelectedColumn= gradeVal;
                }
                    if(schoolVal!=null){
                        wlNew.schoolSelectedColumn= schoolVal;
                    }

                    if(youthEnrolledInSchool!=null){
                        wlNew.currentlyEnrollInSchool= youthEnrolledInSchool;
                    }

                    if(youthIep!=null){
                        wlNew.Iep= youthIep;
                    }
                   
               /*   Hold  YOUTH AGES 14+  from User  in Wrapper   */    
               if(childPlaceOfEmployment!=null){
                wlNew.placeOfEmployment= childPlaceOfEmployment;
            }

            if(areaOfInterestMultiPickSelected!=null){
                        
                areaOfInterestMultiPickSelected.remove('');
                system.debug('***areaOfInterestMultiPickSelected:===========> '+ areaOfInterestMultiPickSelected);
                wlNew.areaOfInterestSelectedColumn= areaOfInterestMultiPickSelected.split(';');
                allstring = string.join(wlNew.areaOfInterestSelectedColumn,',');
                system.debug('**wlNew.areaOfInterestSelectedColumn:===========> '+ wlNew.areaOfInterestSelectedColumn);
                system.debug('allstring'+ allstring);
                
            }

            /*  Hold EMERGENCY CONTACTS from User  in Wrapper  */
            if(emergencyConFName1!=null){
                wlNew.emergencyContactfName1= emergencyConFName1;
            }

            if(emergencyConLName1!=null){
                wlNew.emergencyContactLName1= emergencyConLName1;
            }

            if(emergencyConPhone1!=null){
                wlNew.emergencyContactPhone1= emergencyConPhone1;
            }

            if(emergencyConFName2!=null){
                wlNew.emergencyContactfName2= emergencyConFName2;
            }

            if(emergencyConLName2!=null){
                wlNew.emergencyContactLName2= emergencyConLName2;
            }

            if(emergencyConPhone2!=null){
                wlNew.emergencyContactPhone2= emergencyConPhone2;
            }
           
           
           
            
           
           


            /*  Hold APPROVED PICK-UPS from User  in Wrapper  */
            if(approvePickupName1!=null){
                wlNew.approvedPickupName1= approvePickupName1;
            }
            if(approvePickupRelationship1!=null){
                wlNew.approvedPickupRelationshipSelectedColumn= approvePickupRelationship1;
            }
            if(approvePickupPhone1!=null){
                wlNew.approvedPickupPhone1= approvePickupPhone1;
            }
            if(approvePickupName2!=null){
                wlNew.approvedPickupName2= approvePickupName2;
            }
            if(approvePickupRelationship2!=null){
                wlNew.approvedPickupRelationshipSelectedColumn2= approvePickupRelationship2;
            }
            if(approvePickupPhone2!=null){
                wlNew.approvedPickupPhone2= approvePickupPhone2;
            }
           
           
          
          
            
        



            /*  Hold HEALTH AND WELLNESS INFORMATION from User  in Wrapper  */
            if(childPhysicianName!=null){
                wlNew.physicianName= childPhysicianName;
            }
            if(decimal.valueOf(InsuranceNumber)!=null){
                wlNew.insuranceNumber= decimal.valueOf(InsuranceNumber);
            }
            if(OperationInjuries!=null){
                wlNew.operationInjuries= OperationInjuries;
            }
            if(medications!=null){
                wlNew.medications= medications;
            }

            if(hadIllnessMultiPickSelected!=null){
                        
                hadIllnessMultiPickSelected.remove('');
                system.debug('***areaOfInterestMultiPickSelected:===========> '+ areaOfInterestMultiPickSelected);
                wlNew.hadIllnessSelectedColumn= hadIllnessMultiPickSelected.split(';');
                system.debug('**wlNew.areaOfInterestSelectedColumn:===========> '+ wlNew.areaOfInterestSelectedColumn);            
            }

            /*  Hold MENTAL HEALTH INFORMATION from User  in Wrapper  */
            if(mentalHealthDiagnosis!=null){
                wlNew.mentalHealthHistorySelectedColumn= mentalHealthDiagnosis;
            }

            if(addMentalHealthInfo!=null){
                wlNew.mhHistoryDetailed= addMentalHealthInfo;
            }
           
          


            /*  Hold ALLERGIES from User  in Wrapper  */
            if(allergies!=null){
                        
                allergies.remove('');
                system.debug('***areaOfInterestMultiPickSelected:===========> '+ areaOfInterestMultiPickSelected);
                wlNew.allergiesSelectedColumn= allergies.split(';');
                system.debug('**wlNew.allergiesSelectedColumn:===========> '+ wlNew.allergiesSelectedColumn);            
            }

            if(allergyDetail!=null){
                wlNew.allergiesDetailed= allergyDetail;
            }
            
          
            
            /*  Hold PROGRAM ATTENDANCE from User  in Wrapper  */
            if(childAttendAfterProgram!=null){
                        
                childAttendAfterProgram.remove('');
                system.debug('***areaOfInterestMultiPickSelected:===========> '+ areaOfInterestMultiPickSelected);
                wlNew.childAttendAfterSchoolSelectedColumn= childAttendAfterProgram.split(';');
                system.debug('**wlNew.childAttendAfterSchoolSelectedColumn:===========> '+ wlNew.childAttendAfterSchoolSelectedColumn);            
            }
               

          

             /*   Hold  Primary Parent  from User  in Wrapper   */ 
             
             if(primaryParFName!=null){
                wlNew.primaryParentfName= primaryParFName;
            }

            if(primaryParLName!=null){
                wlNew.primaryParentlName= primaryParLName;
            }

            if(primaryParRelationSelected!=null){
                wlNew.primaryParentRelationshipSelectedColumn= primaryParRelationSelected;
            }

            if(parPhnNumber!=null){
                wlNew.homePhn= parPhnNumber;
            }

            if(primaryParMailingStreet!=null){
                wlNew.primaryParentMailingStreet= primaryParMailingStreet;
            }

            if(primaryParMailingCity!=null){
                wlNew.primaryParentMailingCity= primaryParMailingCity;
            }

            if(primaryParMailingState!=null){
                wlNew.primaryParentMailingState= primaryParMailingState;
            }

            if(primaryParMailingPostalCode!=null){
                wlNew.primaryParentMailingPostalCode= primaryParMailingPostalCode;
            }

            if(primaryParPlaceOfEmployment!=null){
                wlNew.placeOfEmployment= primaryParPlaceOfEmployment;
            }

            if(primaryParMobilePhone!=null){
                wlNew.mobilePhn= primaryParMobilePhone;
            }

            if(primaryParWorkPhone!=null){
                wlNew.workPhn= primaryParWorkPhone;
            }

            if(primaryParEmail!=null){
                wlNew.email= primaryParEmail;
            }

            if(primaryParHouseholdMonthlyIncome!=null){
                wlNew.monthlyIncome= decimal.valueOf(primaryParHouseholdMonthlyIncome);
            }
                  
         /*   Hold  Secondary Parent  from User  in Wrapper   */     
         
         if(secondaryParFName!=null){
            wlNew.secondaryParentfName= secondaryParFName;
        }

        if(secondaryParLName!=null){
            wlNew.secondaryParentlName= secondaryParLName;
        }

        if(secondaryParRelationSelected!=null){
            wlNew.secondaryParentRelationshipSelectedColumn= secondaryParRelationSelected;
        }

        if(secondaryParMailingStreet!=null){
            wlNew.secondaryParentMailingStreet= secondaryParMailingStreet;
        }

        if(secondaryParMailingCity!=null){
            wlNew.secondaryParentMailingCity= secondaryParMailingCity;
        }

        if(secondaryParMailingState!=null){
            wlNew.secondaryParentMailingState= secondaryParMailingState;
        }

        if(secondaryParMailingPostalCode!=null){
            wlNew.secondaryParentMailingPostalCode= secondaryParMailingPostalCode;
        }
                    wprListNew.add(wlNew);
                    system.debug('****wprListNew:===========> '+wprListNew);
                    system.debug('****wprListNew:===========> '+wprListNew.size());
                   
                    system.debug('########caseId:===========> '+wlNew.caseId);
                    system.debug('########ClientId:===========> '+wlNew.childRecordId);
                    system.debug('########wlNew.gradeSelectedColumn:===========> '+wlNew.gradeSelectedColumn);
                    system.debug('########wlNew.schoolSelectedColumn:===========> '+wlNew.schoolSelectedColumn);
                }
            }
            
            if(wprListNew!= Null && wprListNew.size()>0){
                for(wrapperList wprRec: wprListNew){  
                    system.debug('****wprRec:===========> '+wprRec); 
                    system.debug('****wprListNew:===========> '+wprListNew); 
                    
                    If(parentid!=null && parentid!='nullId'){
                        string clientIdNew= wprRec.childRecordId;
                        If(clientIdNew!=null && clientIdNew!='newRecFlag'){
                            // Existing client record;
                            
                            system.debug('***wprRec.gradeSelectedColumn:===========> '+wprRec.gradeSelectedColumn); 
                                      
                            Intake__c inkRec= new Intake__c();
                            inkRec.Name= wprRec.firstName+ '_' +wprRec.lastName + '_' +'Youth Development';
                            inkRec.First_Name__c=wprRec.firstName;
                            inkRec.Last_Name__c= wprRec.lastName;
                            inkRec.Birthdate__c= date.valueOf(wprRec.Dob);
                            inkRec.SSN__c= wprRec.ssn;
                            inkRec.Gender_Identity__c = wprRec.genIdentitySelectedColumn;
                            inkRec.Weight_NUM__c = wprRec.weight;
                            inkRec.Height_feet__c= wprRec.htfeet;
                            inkRec.Height_inches__c= wprRec.htInches;
                            inkRec.Identifying_Marks__c= wprRec.IdentifyMarks;
                            inkRec.Hair_Color__c= wprRec.hairColor;
                            inkRec.Eye_Color__c= wprRec.eyeColor;
                            //inkRec.School__c= wprRec.schoolSelectedColumn;
                            inkRec.Grade__c= decimal.valueOf(wprRec.gradeSelectedColumn);
                            inkRec.In_School__c= wprRec.currentlyEnrollInSchool;
                            inkRec.IEP__c= wprRec.Iep;

                            /* YOUTH AGES 14+ */
                            inkRec.Place_of_Employment__c= wprRec.placeOfEmployment;

                            
                             if(wprRec.areaOfInterestSelectedColumn!=null){
                                string val=String.join(wprRec.areaOfInterestSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Interest_Areas__c= bal.replace(')', ' ');
                                system.debug('**inkRec.Interest_Areas__c:===========> '+inkRec.Interest_Areas__c);   
                            }
                          

                           /* EMERGENCY CONTACTS */
                           inkRec.Emergency_Contact_First__c= wprRec.emergencyContactfName1;
                           inkRec.Emergency_Contact_Last__c= wprRec.emergencyContactLName1;
                           inkRec.Emergency_Contact_Phone__c= wprRec.emergencyContactPhone1;
                           
                           inkRec.Emergency_Contact_2_First__c= wprRec.emergencyContactfName2;
                           inkRec.Emergency_Contact_2_Last__c= wprRec.emergencyContactLName2;
                           inkRec.Emergency_Contact_2_Phone__c= wprRec.emergencyContactPhone2;

                            /* APPROVED PICK-UPS */
                            inkRec.Approved_Pick_Up_1__c= wprRec.approvedPickupName1;
                            if(wprRec.approvedPickupRelationshipSelectedColumn!=null && wprRec.approvedPickupRelationshipSelectedColumn!= '--Select--'){
                                inkRec.Approved_Pick_Up_1_Relationship__c= wprRec.approvedPickupRelationshipSelectedColumn;
                                system.debug('#####Existing Parent New:===========> '+wprRec.approvedPickupRelationshipSelectedColumn);
                            }

                            if(wprRec.approvedPickupRelationshipSelectedColumn2!=null && wprRec.approvedPickupRelationshipSelectedColumn2!= '--Select--'){
                                inkRec.Approved_Pick_Up_2_Relationship__c= wprRec.approvedPickupRelationshipSelectedColumn2;
                                system.debug('#####Existing Parent New:===========> '+wprRec.approvedPickupRelationshipSelectedColumn2);
                            }
                            inkRec.Approved_Pick_Up_1_Phone__c= wprRec.approvedPickupPhone1 ;
                            inkRec.Approved_Pick_Up_2__c= wprRec.approvedPickupName2;
                            inkRec.Approved_Pick_Up_2_Phone__c= wprRec.approvedPickupPhone2;

                            
                             /* TRANSPORTATION METHODS */
                              /* ALTERNATE ADDRESS */

                               /* HEALTH AND WELLNESS INFORMATION */
                               inkRec.Physician_Name__c= wprRec.physicianName;
                              
                               inkRec.Insurance_Number__c= wprRec.insuranceNumber;
                              
                               inkRec.Operations_Injuries__c= wprRec.operationInjuries;
                             
                               inkRec.Medications__c= wprRec.medications;

                               if(wprRec.hadIllnessSelectedColumn!=null){
                                string val=String.join(wprRec.hadIllnessSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Had_illness__c= bal.replace(')', ' ');
                                system.debug('**inkRec.Interest_Areas__c:===========> '+inkRec.Had_illness__c);   
                                 }
                               
                            

                                /* MENTAL HEALTH INFORMATION */
                                if(wprRec.mentalHealthHistorySelectedColumn!=null && wprRec.mentalHealthHistorySelectedColumn!= '--Select--'){
                                    inkRec.Mental_Health_History__c= wprRec.mentalHealthHistorySelectedColumn;
                                    system.debug('#####Existing Parent New:===========> '+wprRec.mentalHealthHistorySelectedColumn);
                                }

                               
                                inkRec.MH_History_Detailed__c= wprRec.mhHistoryDetailed;

                        /*    COVID-19 SCREENING   */


                         /*       ALLERGIES          */
                                 
                             if(wprRec.allergiesSelectedColumn!=null){
                                string val=String.join(wprRec.allergiesSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Allergies__c= bal.replace(')', ' ');
                                system.debug('**inkRec.Interest_Areas__c:===========> '+inkRec.Allergies__c);   
                            }
                               
                             inkRec.Allergies_Detailed__c= wprRec.allergiesDetailed;


                        /*       PROGRAM ATTENDANCE       */
                                 
                             if(wprRec.childAttendAfterSchoolSelectedColumn!=null){
                                string val=String.join(wprRec.childAttendAfterSchoolSelectedColumn,',').replaceAll(',', ';');
                                string bal=val.replace('(', ' ');
                                inkRec.Child_will_Attend_Afterschool__c= bal.replace(')', ' ');
                                system.debug('**inkRec.Interest_Areas__c:===========> '+inkRec.Child_will_Attend_Afterschool__c);   
                            }
                                 // inkRec.Child_will_Attend_Afterschool__c


                            inkRec.Primary_Guardian_First__c= wprRec.primaryParentfName;
                            inkRec.Primary_Guardian_Last__c= wprRec.primaryParentlName;
                            inkRec.Primary_Guardian_Relationship__c= wprRec.primaryParentRelationshipSelectedColumn;
                            inkRec.Guardian_Street__c= wprRec.primaryParentMailingStreet;
                            inkRec.Guardian_City__c	= wprRec.primaryParentMailingCity;
                            inkRec.Guardian_State__c= wprRec.primaryParentMailingState;
                            inkRec.Guardian_Zip__c= wprRec.primaryParentMailingPostalCode;
                            inkRec.Mobile_Phone__c= wprRec.mobilePhn;
                            inkRec.Work_Phone__c= wprRec.workPhn;
                            inkRec.Work_Email__c= wprRec.email;
                            inkRec.Household_Monthly_Income__c= wprRec.monthlyIncome;
                            
                         
                            inkRec.Other_Caregiver_First__c= wprRec.secondaryParentfName;
                            inkRec.Other_Caregiver_Last__c= wprRec.secondaryParentlName;
                            inkRec.Other_Guardian_Relationship__c= wprRec.secondaryParentRelationshipSelectedColumn;
                            inkRec.Other_State__c= wprRec.secondaryParentMailingStreet;
                            inkRec.Other_Street__c= wprRec.secondaryParentMailingCity;
                            inkRec.Other_Zip_Code__c= wprRec.secondaryParentMailingState;
                            inkRec.Other_City__c= wprRec.secondaryParentMailingPostalCode;
                     
                        
                            if(wprRec.schoolSelectedColumn!=null && wprRec.schoolSelectedColumn!= '--Select--'){
                                inkRec.School__c= wprRec.schoolSelectedColumn;
                                system.debug('#####Existing Parent New:===========> '+wprRec.schoolSelectedColumn);
                            }
                            
                            inkRec.DateOfSignature__c= dateOfSignature;
                            /* Attach existing parent Record Id */
                            inkRec.Name_of_Primary_Parent_Guardian__c= parentRecdIdVar;
                            inkRec.Client__c= wprRec.childRecordId;
                            inkRec.case__c= wprRec.caseId;
                          
                            inkRec.RecordTypeId = youthRecTypeId;
                            system.debug('****inkRec:===========> '+inkRec);
                            newRecList.add(inkRec);
                            system.debug('#####newRecList2:===========> '+newRecList);
                            system.debug('#####inkRec.Client__c:===========> '+wprRec.childRecordId);
                            system.debug('#####wprRec.caseId:===========> '+wprRec.caseId);
                            system.debug('#####inkRec.case__c:===========> '+inkRec.case__c);
                          
                            system.debug('######inkRec.Grade__c:===========> '+inkRec.Grade__c);
                        }
                        else{
                            //  Existing parent new client;
                            system.debug('***wprRec.gradeSelectedColumn1:===========> '+wprRec.gradeSelectedColumn); 
                            Intake__c inkRec= new Intake__c();
                            inkRec.Name= wprRec.firstName+ '_' +wprRec.lastName + '_' +'Youth Development';
                            inkRec.First_Name__c=wprRec.firstName;
                            inkRec.Last_Name__c= wprRec.lastName;
                            inkRec.Birthdate__c= date.valueOf(wprRec.Dob);
                            inkRec.SSN__c= wprRec.ssn;
                            inkRec.Gender_Identity__c = wprRec.genIdentitySelectedColumn;
                            inkRec.Weight_NUM__c = wprRec.weight;
                            inkRec.Height_feet__c= wprRec.htfeet;
                            inkRec.Height_inches__c= wprRec.htInches;
                            inkRec.Identifying_Marks__c= wprRec.IdentifyMarks;
                            inkRec.Hair_Color__c= wprRec.hairColor;
                            inkRec.Eye_Color__c= wprRec.eyeColor;
                            //inkRec.School__c= wprRec.schoolSelectedColumn;
                            inkRec.Grade__c= decimal.valueOf(wprRec.gradeSelectedColumn);
                            inkRec.In_School__c= wprRec.currentlyEnrollInSchool;
                            inkRec.IEP__c= wprRec.Iep;
                            inkRec.Place_of_Employment__c= wprRec.placeOfEmployment;
                          //  inkRec.Interest_Areas__c= wprRec.areaOfInterestSelectedColumn;



                  /* YOUTH AGES 14+ */
                  inkRec.Place_of_Employment__c= wprRec.placeOfEmployment;

                            
                  if(wprRec.areaOfInterestSelectedColumn!=null){
                     string val=String.join(wprRec.areaOfInterestSelectedColumn,',').replaceAll(',', ';');
                     string bal=val.replace('(', ' ');
                     inkRec.Interest_Areas__c= bal.replace(')', ' ');
                     system.debug('**inkRec.Interest_Areas__c:===========> '+inkRec.Interest_Areas__c);   
                 }
               

                /* EMERGENCY CONTACTS */
                inkRec.Emergency_Contact_First__c= wprRec.emergencyContactfName1;
                inkRec.Emergency_Contact_Last__c= wprRec.emergencyContactLName1;
                inkRec.Emergency_Contact_Phone__c= wprRec.emergencyContactPhone1;
                
                inkRec.Emergency_Contact_2_First__c= wprRec.emergencyContactfName2;
                inkRec.Emergency_Contact_2_Last__c= wprRec.emergencyContactLName2;
                inkRec.Emergency_Contact_2_Phone__c= wprRec.emergencyContactPhone2;

                 /* APPROVED PICK-UPS */
                 inkRec.Approved_Pick_Up_1__c= wprRec.approvedPickupName1;
                 if(wprRec.approvedPickupRelationshipSelectedColumn!=null && wprRec.approvedPickupRelationshipSelectedColumn!= '--Select--'){
                     inkRec.Approved_Pick_Up_1_Relationship__c= wprRec.approvedPickupRelationshipSelectedColumn;
                     system.debug('#####Existing Parent New:===========> '+wprRec.approvedPickupRelationshipSelectedColumn);
                 }

                 if(wprRec.approvedPickupRelationshipSelectedColumn2!=null && wprRec.approvedPickupRelationshipSelectedColumn2!= '--Select--'){
                     inkRec.Approved_Pick_Up_2_Relationship__c= wprRec.approvedPickupRelationshipSelectedColumn2;
                     system.debug('#####Existing Parent New:===========> '+wprRec.approvedPickupRelationshipSelectedColumn2);
                 }
                 inkRec.Approved_Pick_Up_1_Phone__c= wprRec.approvedPickupPhone1 ;
                 inkRec.Approved_Pick_Up_2__c= wprRec.approvedPickupName2;
                 inkRec.Approved_Pick_Up_2_Phone__c= wprRec.approvedPickupPhone2;

                 
                  /* TRANSPORTATION METHODS */
                   /* ALTERNATE ADDRESS */

                    /* HEALTH AND WELLNESS INFORMATION */
                    inkRec.Physician_Name__c= wprRec.physicianName;
                   
                    inkRec.Insurance_Number__c= wprRec.insuranceNumber;
                   
                    inkRec.Operations_Injuries__c= wprRec.operationInjuries;
                  
                    inkRec.Medications__c= wprRec.medications;

                    if(wprRec.hadIllnessSelectedColumn!=null){
                     string val=String.join(wprRec.hadIllnessSelectedColumn,',').replaceAll(',', ';');
                     string bal=val.replace('(', ' ');
                     inkRec.Had_illness__c= bal.replace(')', ' ');
                     system.debug('**inkRec.Interest_Areas__c:===========> '+inkRec.Had_illness__c);   
                      }
                    
                 

                     /* MENTAL HEALTH INFORMATION */
                     if(wprRec.mentalHealthHistorySelectedColumn!=null && wprRec.mentalHealthHistorySelectedColumn!= '--Select--'){
                         inkRec.Mental_Health_History__c= wprRec.mentalHealthHistorySelectedColumn;
                         system.debug('#####Existing Parent New:===========> '+wprRec.mentalHealthHistorySelectedColumn);
                     }

                    
                     inkRec.MH_History_Detailed__c= wprRec.mhHistoryDetailed;

             /*    COVID-19 SCREENING   */


              /*       ALLERGIES          */
                      
                  if(wprRec.allergiesSelectedColumn!=null){
                     string val=String.join(wprRec.allergiesSelectedColumn,',').replaceAll(',', ';');
                     string bal=val.replace('(', ' ');
                     inkRec.Allergies__c= bal.replace(')', ' ');
                     system.debug('**inkRec.Interest_Areas__c:===========> '+inkRec.Allergies__c);   
                 }
                    
                  inkRec.Allergies_Detailed__c= wprRec.allergiesDetailed;


             /*       PROGRAM ATTENDANCE       */
                      
                  if(wprRec.childAttendAfterSchoolSelectedColumn!=null){
                     string val=String.join(wprRec.childAttendAfterSchoolSelectedColumn,',').replaceAll(',', ';');
                     string bal=val.replace('(', ' ');
                     inkRec.Child_will_Attend_Afterschool__c= bal.replace(')', ' ');
                     system.debug('**inkRec.Interest_Areas__c:===========> '+inkRec.Child_will_Attend_Afterschool__c);   
                 }
                      // inkRec.Child_will_Attend_Afterschool__c

                          


                            inkRec.Primary_Guardian_First__c= wprRec.primaryParentfName;
                            inkRec.Primary_Guardian_Last__c= wprRec.primaryParentlName;
                            inkRec.Primary_Guardian_Relationship__c= wprRec.primaryParentRelationshipSelectedColumn;
                            inkRec.Guardian_Street__c= wprRec.primaryParentMailingStreet;
                            inkRec.Guardian_City__c	= wprRec.primaryParentMailingCity;
                            inkRec.Guardian_State__c= wprRec.primaryParentMailingState;
                            inkRec.Guardian_Zip__c= wprRec.primaryParentMailingPostalCode;
                            inkRec.Mobile_Phone__c= wprRec.mobilePhn;
                            inkRec.Work_Phone__c= wprRec.workPhn;
                            inkRec.Work_Email__c= wprRec.email;
                            inkRec.Household_Monthly_Income__c= wprRec.monthlyIncome;
                            
                         
                            inkRec.Other_Caregiver_First__c= wprRec.secondaryParentfName;
                            inkRec.Other_Caregiver_Last__c= wprRec.secondaryParentlName;
                            inkRec.Other_Guardian_Relationship__c= wprRec.secondaryParentRelationshipSelectedColumn;
                            inkRec.Other_State__c= wprRec.secondaryParentMailingStreet;
                            inkRec.Other_Street__c= wprRec.secondaryParentMailingCity;
                            inkRec.Other_Zip_Code__c= wprRec.secondaryParentMailingState;
                            inkRec.Other_City__c= wprRec.secondaryParentMailingPostalCode;
                     
                        
                            if(wprRec.schoolSelectedColumn!=null && wprRec.schoolSelectedColumn!= '--Select--'){
                                inkRec.School__c= wprRec.schoolSelectedColumn;
                                system.debug('#####Existing Parent New:===========> '+wprRec.schoolSelectedColumn);
                            }
                            
                          
                            inkRec.DateOfSignature__c= dateOfSignature;
                            inkRec.Name_of_Primary_Parent_Guardian__c= parentRecdIdVar;
                          
                           // inkRec.case__c= wprRec.caseId;
                          
                            inkRec.RecordTypeId = youthRecTypeId;

                            newRecList.add(inkRec);
                            system.debug('#####newRecList1:===========> '+newRecList);
                            system.debug('######inkRec.Community_Activities__c:===========> '+inkRec.Community_Activities__c);
                            system.debug('######inkRec.Grade__c:===========> '+inkRec.Grade__c);
                        //    system.debug('######inkRec.School__c:===========> '+inkRec.School__c);
                        }
                    }
                    else{
                        
                        //  New parent case recod;
                        system.debug('***wprRec.gradeSelectedColumn2:===========> '+wprRec.gradeSelectedColumn); 
                        Intake__c inkRec= new Intake__c();
                        inkRec.Name= wprRec.firstName+ '_' +wprRec.lastName + '_' +'Youth Development';
                        inkRec.First_Name__c=wprRec.firstName;
                        inkRec.Last_Name__c= wprRec.lastName;
                        inkRec.Birthdate__c= date.valueOf(wprRec.Dob);
                        inkRec.SSN__c= wprRec.ssn;
                        inkRec.Gender_Identity__c = wprRec.genIdentitySelectedColumn;
                        inkRec.Weight_NUM__c = wprRec.weight;
                        inkRec.Height_feet__c= wprRec.htfeet;
                        inkRec.Height_inches__c= wprRec.htInches;
                        inkRec.Identifying_Marks__c= wprRec.IdentifyMarks;
                        inkRec.Hair_Color__c= wprRec.hairColor;
                        inkRec.Eye_Color__c= wprRec.eyeColor;
                        //inkRec.School__c= wprRec.schoolSelectedColumn;
                        inkRec.Grade__c= decimal.valueOf(wprRec.gradeSelectedColumn);
                        inkRec.In_School__c= wprRec.currentlyEnrollInSchool;
                        inkRec.IEP__c= wprRec.Iep;
                        inkRec.Place_of_Employment__c= wprRec.placeOfEmployment;
                      //  inkRec.Interest_Areas__c= wprRec.areaOfInterestSelectedColumn;



                       /* YOUTH AGES 14+ */
                       inkRec.Place_of_Employment__c= wprRec.placeOfEmployment;

                            
                       if(wprRec.areaOfInterestSelectedColumn!=null){
                          string val=String.join(wprRec.areaOfInterestSelectedColumn,',').replaceAll(',', ';');
                          string bal=val.replace('(', ' ');
                          inkRec.Interest_Areas__c= bal.replace(')', ' ');
                          system.debug('**inkRec.Interest_Areas__c:===========> '+inkRec.Interest_Areas__c);   
                      }
                    

                     /* EMERGENCY CONTACTS */
                     inkRec.Emergency_Contact_First__c= wprRec.emergencyContactfName1;
                     inkRec.Emergency_Contact_Last__c= wprRec.emergencyContactLName1;
                     inkRec.Emergency_Contact_Phone__c= wprRec.emergencyContactPhone1;
                     
                     inkRec.Emergency_Contact_2_First__c= wprRec.emergencyContactfName2;
                     inkRec.Emergency_Contact_2_Last__c= wprRec.emergencyContactLName2;
                     inkRec.Emergency_Contact_2_Phone__c= wprRec.emergencyContactPhone2;

                      /* APPROVED PICK-UPS */
                      inkRec.Approved_Pick_Up_1__c= wprRec.approvedPickupName1;
                      if(wprRec.approvedPickupRelationshipSelectedColumn!=null && wprRec.approvedPickupRelationshipSelectedColumn!= '--Select--'){
                          inkRec.Approved_Pick_Up_1_Relationship__c= wprRec.approvedPickupRelationshipSelectedColumn;
                          system.debug('#####Existing Parent New:===========> '+wprRec.approvedPickupRelationshipSelectedColumn);
                      }
                    

                      if(wprRec.approvedPickupRelationshipSelectedColumn2!=null && wprRec.approvedPickupRelationshipSelectedColumn2!= '--Select--'){
                          inkRec.Approved_Pick_Up_2_Relationship__c= wprRec.approvedPickupRelationshipSelectedColumn2;
                          system.debug('#####Existing Parent New:===========> '+wprRec.approvedPickupRelationshipSelectedColumn2);
                      }
                      inkRec.Approved_Pick_Up_1_Phone__c= wprRec.approvedPickupPhone1 ;
                      inkRec.Approved_Pick_Up_2__c= wprRec.approvedPickupName2;
                      inkRec.Approved_Pick_Up_2_Phone__c= wprRec.approvedPickupPhone2;

                      
                       /* TRANSPORTATION METHODS */
                        /* ALTERNATE ADDRESS */

                         /* HEALTH AND WELLNESS INFORMATION */
                         inkRec.Physician_Name__c= wprRec.physicianName;
                        
                         inkRec.Insurance_Number__c= wprRec.insuranceNumber;
                        
                         inkRec.Operations_Injuries__c= wprRec.operationInjuries;
                       
                         inkRec.Medications__c= wprRec.medications;

                         if(wprRec.hadIllnessSelectedColumn!=null){
                          string val=String.join(wprRec.hadIllnessSelectedColumn,',').replaceAll(',', ';');
                          string bal=val.replace('(', ' ');
                          inkRec.Had_illness__c= bal.replace(')', ' ');
                          system.debug('**inkRec.Interest_Areas__c:===========> '+inkRec.Had_illness__c);   
                           }
                         
                      

                          /* MENTAL HEALTH INFORMATION */
                          if(wprRec.mentalHealthHistorySelectedColumn!=null && wprRec.mentalHealthHistorySelectedColumn!= '--Select--'){
                              inkRec.Mental_Health_History__c= wprRec.mentalHealthHistorySelectedColumn;
                              system.debug('#####Existing Parent New:===========> '+wprRec.mentalHealthHistorySelectedColumn);
                          }

                         
                          inkRec.MH_History_Detailed__c= wprRec.mhHistoryDetailed;

                  /*    COVID-19 SCREENING   */


                   /*       ALLERGIES          */
                           
                       if(wprRec.allergiesSelectedColumn!=null){
                          string val=String.join(wprRec.allergiesSelectedColumn,',').replaceAll(',', ';');
                          string bal=val.replace('(', ' ');
                          inkRec.Allergies__c= bal.replace(')', ' ');
                          system.debug('**inkRec.Interest_Areas__c:===========> '+inkRec.Allergies__c);   
                      }
                         
                       inkRec.Allergies_Detailed__c= wprRec.allergiesDetailed;


                  /*       PROGRAM ATTENDANCE       */
                           
                       if(wprRec.childAttendAfterSchoolSelectedColumn!=null){
                          string val=String.join(wprRec.childAttendAfterSchoolSelectedColumn,',').replaceAll(',', ';');
                          string bal=val.replace('(', ' ');
                          inkRec.Child_will_Attend_Afterschool__c= bal.replace(')', ' ');
                          system.debug('**inkRec.Interest_Areas__c:===========> '+inkRec.Child_will_Attend_Afterschool__c);   
                      }
                           // inkRec.Child_will_Attend_Afterschool__c



                        inkRec.Primary_Guardian_First__c= wprRec.primaryParentfName;
                        inkRec.Primary_Guardian_Last__c= wprRec.primaryParentlName;
                        inkRec.Primary_Guardian_Relationship__c= wprRec.primaryParentRelationshipSelectedColumn;
                        inkRec.Guardian_Street__c= wprRec.primaryParentMailingStreet;
                        inkRec.Guardian_City__c	= wprRec.primaryParentMailingCity;
                        inkRec.Guardian_State__c= wprRec.primaryParentMailingState;
                        inkRec.Guardian_Zip__c= wprRec.primaryParentMailingPostalCode;
                        inkRec.Mobile_Phone__c= wprRec.mobilePhn;
                        inkRec.Work_Phone__c= wprRec.workPhn;
                        inkRec.Work_Email__c= wprRec.email;
                        inkRec.Household_Monthly_Income__c= wprRec.monthlyIncome;
                        
                        
                        inkRec.Other_Caregiver_First__c= wprRec.secondaryParentfName;
                        inkRec.Other_Caregiver_Last__c= wprRec.secondaryParentlName;
                        inkRec.Other_Guardian_Relationship__c= wprRec.secondaryParentRelationshipSelectedColumn;
                        inkRec.Other_State__c= wprRec.secondaryParentMailingStreet;
                        inkRec.Other_Street__c= wprRec.secondaryParentMailingCity;
                        inkRec.Other_Zip_Code__c= wprRec.secondaryParentMailingState;
                        inkRec.Other_City__c= wprRec.secondaryParentMailingPostalCode;
                 
                    
                        if(wprRec.schoolSelectedColumn!=null && wprRec.schoolSelectedColumn!= '--Select--'){
                            inkRec.School__c= wprRec.schoolSelectedColumn;
                            system.debug('#####Existing Parent New:===========> '+wprRec.schoolSelectedColumn);
                        }
                        
                        /* MultiSelect- Picklist */
                    /*    if(wprRec.areaOfInterestSelectedColumn!=null){
                            string val=String.join(wprRec.areaOfInterestSelectedColumn,',').replaceAll(',', ';');
                            string bal=val.replace('(', ' ');
                            inkRec.Interest_Areas__c= bal.replace(')', ' ');
                            system.debug('**inkRec.Interest_Areas__c:===========> '+inkRec.Interest_Areas__c);   
                        }*/

                        inkRec.DateOfSignature__c= dateOfSignature;

                        /* In New Child Case Attach Newly created Parent */
                        if(newParentGuardianId!=null){
                            inkRec.Name_of_Primary_Parent_Guardian__c= newParentGuardianId;   
                        }
                       
                     /* if(wprRec.caseId!= NULL){
                        inkRec.case__c= wprRec.caseId;
                      }
                        */
                      
                        inkRec.RecordTypeId = youthRecTypeId;
                        system.debug('****inkRec:===========> '+inkRec);
                        newRecList.add(inkRec);
                        system.debug('######newRecList3:===========> '+newRecList);
                        system.debug('######inkRec.Community_Activities__c:===========> '+inkRec.Community_Activities__c);
                        system.debug('######newParentGuardianId:===========> '+newParentGuardianId);
                        system.debug('######inkRec.Grade__c:===========> '+inkRec.Grade__c);
                     
                    }
                    
                }
            }
            
            system.debug('###fname==========> '+fname);
            system.debug('###lname==========> '+lname);
            system.debug('###dob==========> '+dob);
          
            if(newRecList!=Null && newRecList.size()>0){
                insert newRecList;
                system.debug('###Intake Record List New===========> '+newRecList);  
                system.debug('###Intake Record List Size===========> '+newRecList.size()); 
            }                      
        }catch(Exception ex){
            system.debug('Error Msg:====> '+ ex.getMessage()+ 'Error Line No:====> '+ex.getLineNumber()); 
            throw new AuraHandledException('Error Msg:====> '+ ex.getMessage()+ 'Error Line No:====> '+ex.getLineNumber());
           
        }
    }

    public class wrapperList{
        @AuraEnabled
        public string childRecordId{get;set;}

        @AuraEnabled
        public string caseId{get;set;}  

        @AuraEnabled
        public string firstName{get;set;}
        @AuraEnabled
        public string lastName{get;set;}
        @AuraEnabled
        public date Dob{get;set;}

        @AuraEnabled
       public string ssn{get;set;}
        @AuraEnabled
        public string race{get;set;}
         @AuraEnabled
        public decimal weight{get;set;} 
        @AuraEnabled
        public decimal htfeet{get;set;}
        @AuraEnabled
        public decimal htInches{get;set;}
         @AuraEnabled
         public string IdentifyMarks{get;set;}
        @AuraEnabled
         public string hairColor{get;set;}
         @AuraEnabled
          public string eyeColor{get;set;}
          @AuraEnabled
          public boolean currentlyEnrollInSchool{get;set;}
          @AuraEnabled
          public boolean Iep{get;set;}

          @AuraEnabled
          public string placeOfEmployment{get;set;}

    /* SOURCE OF INCOME Section*/
    @AuraEnabled
    public List<WrapperAllValues> housingColumn{get;set;}
    @AuraEnabled
    public string  housingSelectedColumn{get;set;}

   /* EMERGENCY CONTACTS Section */
   @AuraEnabled
   public string emergencyContactfName1{get;set;}
   @AuraEnabled
   public string emergencyContactLName1{get;set;}
   @AuraEnabled
   public string emergencyContactPhone1{get;set;}
   @AuraEnabled
   public string emergencyContactfName2{get;set;}
   @AuraEnabled
   public string emergencyContactLName2{get;set;}
   @AuraEnabled
   public string emergencyContactPhone2{get;set;}

    /* APPROVED PICK-UPS Section*/

    @AuraEnabled
    public string approvedPickupName1{get;set;}
    @AuraEnabled
    public List<WrapperAllValues> approvedPickupRelationshipColumn{get;set;}
    @AuraEnabled
    public string  approvedPickupRelationshipSelectedColumn{get;set;}
    @AuraEnabled
    public string approvedPickupPhone1{get;set;}
    @AuraEnabled
    public string approvedPickupName2{get;set;}
    @AuraEnabled
    public List<WrapperAllValues> approvedPickupRelationshipColumn2{get;set;}
    @AuraEnabled
    public string  approvedPickupRelationshipSelectedColumn2{get;set;}
    @AuraEnabled
    public string approvedPickupPhone2{get;set;}


    /*  HEALTH AND WELLNESS INFORMATION Section*/
    @AuraEnabled
    public string physicianName{get;set;}
    @AuraEnabled
    public decimal insuranceNumber{get;set;}
    @AuraEnabled
    public string lastPhysical{get;set;}
    @AuraEnabled
    public string operationInjuries{get;set;}
    @AuraEnabled
    public string medications{get;set;}

    @AuraEnabled
    public List<WrapperAllValues> hadIllnessMultiPickColumn{get;set;}
    
    @AuraEnabled
    public List<string> selectedHadIllnessValues{get;set;}
    
    @AuraEnabled
    public List<string> hadIllnessSelectedColumn{get;set;}


    /* MENTAL HEALTH INFORMATION Section*/
    @AuraEnabled
    public List<WrapperAllValues> mentalHealthHistoryColumn{get;set;}  

    @AuraEnabled
    public string mentalHealthHistorySelectedColumn{get;set;}

    @AuraEnabled
    public string mhHistoryDetailed{get;set;}

    /*  COVID-19 SCREENING Section*/

    /*  ALLERGIES Section*/
    @AuraEnabled
    public List<WrapperAllValues> allergiesMultiPickColumn{get;set;}
    
    @AuraEnabled
    public List<string> selectedAllergiesValues{get;set;}
    
    @AuraEnabled
    public List<string> allergiesSelectedColumn{get;set;}
    
    @AuraEnabled
    public string allergiesDetailed{get;set;}


    /* PROGRAM ATTENDANCE Section*/
    @AuraEnabled
    public List<WrapperAllValues> childAttendAfterSchoolMultiPickColumn{get;set;}
    
    @AuraEnabled
    public List<string> selectedChildAttendAfterSchoolValues{get;set;}
    
    @AuraEnabled
    public List<string> childAttendAfterSchoolSelectedColumn{get;set;}          
              
              
              

      /* Primary Parent Details  */ 
          @AuraEnabled
          public string primaryParentPlaceOfEmployment{get;set;}
          @AuraEnabled
          public string homePhn{get;set;}
          @AuraEnabled
          public string mobilePhn{get;set;}

          @AuraEnabled
          public string workPhn{get;set;}
          @AuraEnabled
          public string email{get;set;}

          @AuraEnabled
          public decimal monthlyIncome{get;set;}
          


       
        @AuraEnabled
        public string primaryParentfName{get;set;} 
        @AuraEnabled
        public string primaryParentlName{get;set;} 
        @AuraEnabled
        public string primaryParentPhnNumber{get;set;}
        @AuraEnabled
        public string primaryParentRelationhips{get;set;}

        @AuraEnabled
        public string primaryParentMailingStreet{get;set;} 
        @AuraEnabled
        public string primaryParentMailingCity{get;set;} 

        @AuraEnabled
        public string primaryParentMailingStateSelectedColumn{get;set;} 

        @AuraEnabled
        public string primaryParentMailingState{get;set;}  

        @AuraEnabled
        public List<WrapperAllValues> primaryParentMailingStateColumn{get;set;}

        

        @AuraEnabled
        public string primaryParentMailingPostalCode{get;set;} 


  /* Secondary Parent Details  */ 
        @AuraEnabled
        public string secondaryParentMailingStateSelectedColumn{get;set;} 

       

        @AuraEnabled
        public List<WrapperAllValues> secondaryParentMailingStateColumn{get;set;}

        @AuraEnabled
        public string secondaryParentfName{get;set;} 
        @AuraEnabled
        public string secondaryParentlName{get;set;} 
        @AuraEnabled
        public string secondaryParentPhnNumber{get;set;}

        @AuraEnabled
        public List<WrapperAllValues> secondaryParentRelationshipColumn{get;set;}
        @AuraEnabled
        public string secondaryParentRelationshipSelectedColumn{get;set;}

        @AuraEnabled
        public string secondaryParentMailingStreet{get;set;} 
        @AuraEnabled
        public string secondaryParentMailingCity{get;set;} 
        @AuraEnabled
        public string secondaryParentMailingState{get;set;}  
        @AuraEnabled
        public string secondaryParentMailingPostalCode{get;set;} 

        @AuraEnabled
        public string secondaryPlaceOfEmployment{get;set;} 

        @AuraEnabled
        public string secondaryHomePhn{get;set;} 
        @AuraEnabled
        public string secondaryMobilePhn{get;set;} 
        @AuraEnabled
        public string secondaryWorkPhn{get;set;} 
        @AuraEnabled
        public string secondaryEmail{get;set;} 



        @AuraEnabled
        public string parentSign{get;set;}   
        @AuraEnabled
        public date currDateOfSignature{get;set;} 
       
        
        @AuraEnabled
        public List<WrapperAllValues> schoolColumn{get;set;}
        @AuraEnabled
        public string schoolSelectedColumn{get;set;}

        @AuraEnabled
        public List<WrapperAllValues> genIdentityColumn{get;set;}
        @AuraEnabled
        public string  genIdentitySelectedColumn{get;set;}

        @AuraEnabled
        public List<WrapperAllValues> gradeColumn{get;set;}
        @AuraEnabled
        public string gradeSelectedColumn{get;set;}

        @AuraEnabled
        public List<WrapperAllValues> primaryParentRelationshipColumn{get;set;}
        @AuraEnabled
        public string primaryParentRelationshipSelectedColumn{get;set;}

        /* Area Of Interest Multipicklist */

        @AuraEnabled
        public List<WrapperAllValues> areaOfInterestMultiPickColumn{get;set;}
        
        @AuraEnabled
        public List<string> selectedAreaOfInterestValues{get;set;}
        
        @AuraEnabled
        public List<string> areaOfInterestSelectedColumn{get;set;}
        
        
    }
    
    public class WrapperAllValues {
        @AuraEnabled
        public string label{get;set;}
        @AuraEnabled
        public string value{get;set;}
        
    }
    
}