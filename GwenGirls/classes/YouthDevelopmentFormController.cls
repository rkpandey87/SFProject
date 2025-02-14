public without sharing class YouthDevelopmentFormController {
     @AuraEnabled(cacheable=true)
    public static Map<String, List<CaringConnectionsFormController.fieldsWrapper>> getFieldsValues(){
        Map<String, List<CaringConnectionsFormController.fieldsWrapper>> mapOfFieldsValues=new Map<String, List<CaringConnectionsFormController.fieldsWrapper>>();
        mapOfFieldsValues.put('youthrelationship',CaringConnectionsFormController.getFieldsMetadata('Contact','Primary_Guardian_Relationship__c'));
        mapOfFieldsValues.put('OtherGaurgian',CaringConnectionsFormController.getFieldsMetadata('Contact','Other_Guardian_Relationship__c'));
        mapOfFieldsValues.put('HousingType',CaringConnectionsFormController.getFieldsMetadata('Contact','Housing_Type__c')); 
        mapOfFieldsValues.put('guardianState',CaringConnectionsFormController.getFieldsMetadata('Contact','Guardian_State__c')); 
        mapOfFieldsValues.put('genderIdentity',CaringConnectionsFormController.getFieldsMetadata('Contact','GenderIdentity'));
        mapOfFieldsValues.put('School', getSchoolPicklistVal());
        mapOfFieldsValues.put('Grade',CaringConnectionsFormController.getFieldsMetadata('Contact','Grade__c'));
        mapOfFieldsValues.put('Race',CaringConnectionsFormController.getFieldsMetadata('Intake__c','Race__c'));
        mapOfFieldsValues.put('InterestAreas',CaringConnectionsFormController.getFieldsMetadata('Contact','Interest_Areas__c'));
        mapOfFieldsValues.put('ApprovedPickUp1',CaringConnectionsFormController.getFieldsMetadata('Contact','Approved_Pick_Up_1_Relationship__c'));
        mapOfFieldsValues.put('ApprovedPickUp2',CaringConnectionsFormController.getFieldsMetadata('Contact','Approved_Pick_Up_2_Relationship__c'));
        mapOfFieldsValues.put('HadIllness',CaringConnectionsFormController.getFieldsMetadata('Contact','Had_illness__c'));
        mapOfFieldsValues.put('MentalHealthDiagnosis',CaringConnectionsFormController.getFieldsMetadata('Contact','Mental_Health_History__c'));
        mapOfFieldsValues.put('Allergies',CaringConnectionsFormController.getFieldsMetadata('Contact','Allergies__c'));
        mapOfFieldsValues.put('ChildAttendProgram',CaringConnectionsFormController.getFieldsMetadata('Contact','Child_will_Attend_Afterschool__c'));
        mapOfFieldsValues.put('ReferralSource',CaringConnectionsFormController.getFieldsMetadata('Intake__c','How_did_you_hear_about_us__c'));
        mapOfFieldsValues.put('ReceivePublicAssistance',CaringConnectionsFormController.getFieldsMetadata('Contact','Receive_Public_Assistance__c'));
        mapOfFieldsValues.put('HousingOwnership',CaringConnectionsFormController.getFieldsMetadata('Contact','Housing_Ownership__c'));
        mapOfFieldsValues.put('IncomeSource',CaringConnectionsFormController.getFieldsMetadata('Intake__c','Income_Source__c'));
         mapOfFieldsValues.put('MedicationCompliance',CaringConnectionsFormController.getFieldsMetadata('Intake__c','Medication_Compliance__c'));
        return mapOfFieldsValues;
    }
     @AuraEnabled
    public static Contact upsertParentContact(String parentContactString){
        Contact conObj=(Contact)JSON.deserialize(parentContactString,Contact.class);
        conObj.RecordTypeId=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId(); 
        upsert conObj;
        return conObj;
    }
  
     @AuraEnabled
    public static ParentWrapper upsertParentContact1(String parentContactString){
        String RecordTypeId=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
        ParentWrapper  parentWpr = new ParentWrapper();
        List<Contact> conLst=(List<Contact>) JSON.deserialize(parentContactString,List<Contact>.class);
        List<Contact> contactsToInsert = New List<Contact>();
        Map<Integer, Id> contactIdMap = new Map<Integer, Id>();
        if (!conLst.isEmpty()) {
            for(contact con:conLst){
                con.RecordTypeId = RecordTypeId;
                contactsToInsert.add(con);
            }
            if (!contactsToInsert.isEmpty()) {
                upsert contactsToInsert;
                if(contactsToInsert.size()>0){
                    parentWpr.PrimaryParent =contactsToInsert[0];
                    if(contactsToInsert.size()>1){
                        parentWpr.SecondaryParent =contactsToInsert[1]; 
                    }
                   
                }
              }
         }
        
        return parentWpr;
    }
   
     @AuraEnabled(cacheable=true)
    public static GGFormController.contactIntakeWrapper getExistingRecord(String parentId){
        
        GGFormController.contactIntakeWrapper cIWrapper=new GGFormController.contactIntakeWrapper();  
        if(parentId!='nullId'){
            contact parentRec = new contact();
            List<contact> parentRecLst = new List<contact>();
            List<Contact>childLst = new List<Contact>();
            // get parent contact details from query and assign to wrapper variables 
           parentRecLst=[Select id,FirstName,LastName,HomePhone,Mobile_Phone__c,Housing_Type__c,
                                     Household_Monthly_Income__c,npe01__WorkPhone__c,Primary_Guardian_Relationship__c,
                                     BestTimetoContactGuardian__c,MailingStreet,MailingCity,MailingState,
                                     MailingPostalCode,npe01__HomeEmail__c,Place_of_Employment__c,
                                     Guardian_Street__c,Guardian_City__c,Guardian_State__c,
                                     Receive_Public_Assistance__c, Income_Source__c, Housing_Ownership__c,
                                     Guardian_Zip__c,Email,GuardianConsentReceived__c,
                                     ClientConsentReceived14YOA__c,WhyHasConsentNotBeenReceived__c,
                                     AdditionalInformationRegardingConsent__c,
                                     Other_Caregiver_First__c,Other_Caregiver_Last__c,
                                     Other_Guardian_Relationship__c,OtherStreet,OtherCity,
                                     OtherState,OtherPostalCode	
                                     from Contact Where Id=:parentId ];
            
            if(parentRecLst!=Null && parentRecLst.size()>0){
                cIWrapper.parentContact =parentRecLst[0];
            }
            else{
                cIWrapper.parentContact = new Contact();
            }
            
            // get Childs  contact details from query and assign to wrapper variables 
            childLst=[Select Id,FirstName,LastName,Case__c,GenderIdentity	
                                    ,Race__c,Weight__c,Height_feet__c,Height_inches__c
                                    ,Identifying_Marks__c,Hair_Color__c,SSN__c,Grade__c,In_School__c
                                    ,IEP__c,Place_of_Employment__c,Interest_Areas__c,Eye_Color__c,Emergency_Contact_First__c
                                    ,Emergency_Contact_Last__c,Emergency_Contact_Phone__c,Emergency_Contact_Relationship__c,Emergency_Contact_2_First__c
                                    ,Emergency_Contact_2_Last__c,Emergency_Contact_2_Phone__c,Approved_Pick_Up_1__c
                                    ,Approved_Pick_Up_1_Relationship__c,Approved_Pick_Up_1_Phone__c,Approved_Pick_Up_2__c
                                    ,Approved_Pick_Up_2_Relationship__c,Approved_Pick_Up_2_Phone__c,Physician_Name__c
                                    ,Insurance_Number__c,Last_Physical_MM_YYYY__c,Operations_Injuries__c,Medications__c
                                    ,Physician__c, Insurance_Provider__c ,Most_Recent_Vision_Exam__c,Most_Recent_Hearing_Exam__c ,Most_Recent_Dental_Exam__c 
                                    ,Had_illness__c,Mental_Health_History__c,MH_History_Detailed__c
                                    ,Allergies__c,Allergies_Detailed__c,Child_will_Attend_Afterschool__c
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
                                    ,Name_of_Primary_Parent_Guardian__r.OtherPostalCode ,birthdate,School__c 
                                    , Intake__c,Intake__r.How_did_you_hear_about_us__c,Intake__r.Caregiver_Parent__c,Intake__r.Caregiver_Parent__r.FirstName, 
                                     Emergency_Contact__c,Emergency_Contact_2__c
                                    from Contact where RecordType.Name='Client' and Name_of_Primary_Parent_Guardian__c=:parentId ORDER BY createdDate ]; //and Case__c!=Null
         
                 cIWrapper.childContact = childLst;
          
          }
        system.debug('#cIWrapper====>'+cIWrapper);
        return cIWrapper; 
    }

 public static List<CaringConnectionsFormController.fieldsWrapper> getSchoolPicklistVal(){
     List<account>accountRecList= [Select Id,Type,Name From Account Where Type='School' Limit 5];
     List<CaringConnectionsFormController.fieldsWrapper> pickListValues= new List<CaringConnectionsFormController.fieldsWrapper>();  
     CaringConnectionsFormController.fieldsWrapper wprdefVal= new CaringConnectionsFormController.fieldsWrapper();   
     wprdefVal.label= '--Select--';
     wprdefVal.value=  '--Select--';
     
     pickListValues.add(wprdefVal);
     
     if(accountRecList!=Null && accountRecList.size()>0){
         for(Account accObj: accountRecList){
             CaringConnectionsFormController.fieldsWrapper  wprAccObj= new CaringConnectionsFormController.fieldsWrapper();
             if(accObj.name!=null){wprAccObj.label= accObj.name;}
             if(accObj.Id!=null){wprAccObj.value= accObj.id;}
             pickListValues.add(wprAccObj);
          }
     }
     System.debug('##pickListValues----> '+pickListValues);
     return pickListValues;
    }
    
    public class ParentWrapper{
        @AuraEnabled
        public contact PrimaryParent;
        @AuraEnabled
        public contact SecondaryParent;
    }
 }