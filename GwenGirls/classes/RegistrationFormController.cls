public  without sharing class RegistrationFormController {
    
    public static List<optionWrapper> getPicklistValues(String ObjectApi_name,String Field_name){
        List<optionWrapper> options = new List<optionWrapper>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(ObjectApi_name);
        Sobject Object_name = targetType.newSObject();
        Schema.sObjectType sobject_type = Object_name.getSObjectType();
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe();
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); 
        List<Schema.PicklistEntry> pick_list_values = field_map.get(Field_name).getDescribe().getPickListValues();
        optionWrapper op = new optionWrapper();
                op.label = 'None';
                op.value = 'None';
                options.add(op);

        for (Schema.PicklistEntry a : pick_list_values) {
            
            optionWrapper opt = new optionWrapper();
            opt.label = a.getLabel();
            opt.value = a.getValue();
            if(opt.value!='None'){
                options.add(opt);    
            }
            
        }
        return options;
    }
     
    
    @AuraEnabled
    public static ggFormWrapper getPageLoadData(String ParentId,String CampaignId) {
        
        ggFormWrapper ggObj = new ggFormWrapper();
        
        try{
            
            List<optionWrapper> options = new List<optionWrapper>();        
            System.debug('  ****start*** ');
            
            Contact ChildRecord1;
            Contact ChildRecord2;
            Contact ChildRecord3;
            Campaign campaignRec=[select Id,Program__r.Name,Program__c from Campaign where id=:CampaignId];
            ggObj.campaignRec=campaignRec;
            Id RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
            System.debug('RecordTypeId=='+RecordTypeId);
            Contact ParentRecord1=[select id,accountId,How_do_you_hear_about_us__c,FirstName,LastName,Primary_Guardian_Relationship__c,PIN__c,
                                    MailingStreet, MailingCity, MailingState, MailingPostalCode,
                                    Place_of_Employment__c,Phone, MobilePhone, npe01__WorkPhone__c,
                                    Email,Household_Monthly_Income__c,
                                    Source_of_Income__c,Receive_Public_Assistance__c, Housing_Type__c,
                                    Housing_Ownership__c,Time_In_Residence__c 
                                    from Contact where id=:ParentId and
                                    RecordTypeId=:RecordTypeId];
            System.debug('ParentRecord1=='+ParentRecord1);
            ggObj.ParentRecord1=ParentRecord1;
        
            system.debug('ParentRecord1.accountId---->'+ParentRecord1.accountId);
            System.debug('ParentRecord1.LastName---->'+ParentRecord1.LastName);
            if(ParentRecord1.accountId!=null)  {
                List<Contact> ParentRecordList = new List<Contact>();
                Contact ParentRecord2;
                ParentRecordList= [select id,accountId,RecordTypeId,FirstName,LastName,Primary_Guardian_Relationship__c,
                                        MailingStreet, MailingCity, MailingState, MailingPostalCode,
                                        Place_of_Employment__c,Phone, MobilePhone, npe01__WorkPhone__c,
                                        Email,Household_Monthly_Income__c,
                                        Source_of_Income__c,Receive_Public_Assistance__c, Housing_Type__c,
                                        Housing_Ownership__c,Time_In_Residence__c 
                                        from Contact where accountId=:ParentRecord1.accountId 
                                        and RecordTypeId=:RecordTypeId and id!=:ParentRecord1.id
                                        ];
    
                if(ParentRecordList.size()>0){
    
                    ParentRecord2 = ParentRecordList[0];
                    ggObj.ParentRecord2=ParentRecord2;    
                }                    
            }  
    
            List<Contact> ChildList = new List<Contact>();
            ChildList=[select id,FirstName,LastName,Birthdate,Age__c,
                                    SSN__c,Grade__c ,School__r.Name,School__c,Physician_Name__c,
                                    Most_Recent_Physical__c,Most_Recent_Vision_Exam__C,
                                    Most_Recent_Hearing_Exam__C,Physician__c,
                                    Most_Recent_Dental_Exam__c,Operations_Injuries__c,
                                    Medical_Needs__c,Insurance_Number__c,Insurance_Provider__c,
                                    Medications__c, Takes_Medication__c ,
                                    Physicians_Advice__c,
                                    Had_illness__c , MH_History_Detailed__c, Allergies__c ,
                                    Allergies_Detailed__c, Child_will_Attend_Afterschool__c,
                                    Emergency_Contact_First__c,
                                    Emergency_Contact_Last__c,Emergency_Contact_Relationship__c,
                                    Emergency_Contact_Phone__c, Emergency_Contact_Cell_Phone__c,
                                    Approved_Pick_Up_1__c, Approved_Pick_Up_2__c, 
                                    Approved_Pick_Up_1_Relationship__c,
                                    Approved_Pick_Up_2_Relationship__c, Approved_Pick_Up_1_Phone__c,
                                    Approved_Pick_Up_2_Phone__c
                                    from Contact 
                                    where Name_of_Primary_Parent_Guardian__c=:ParentId 
                                    order by createdDate asc limit 3];
            if(ChildList.size()>0){
                if(ChildList.size()==1){
                    ChildRecord1= ChildList[0];
                    ggObj.ChildRecord1 =ChildRecord1;    
                    ggObj.Child1SchoolName = ChildList[0].School__r.Name;
                    system.debug('ggObj.Child1SchoolName--->'+ggObj.Child1SchoolName);
                }
                if(ChildList.size()==2){
                    ChildRecord1= ChildList[0];
                    ChildRecord2= ChildList[1];    
                    ggObj.ChildRecord1 = ChildRecord1;
                    ggObj.Child1SchoolName = ChildList[0].School__r.Name;
                    ggObj.ChildRecord2 = ChildRecord2;    
                    ggObj.Child2SchoolName = ChildRecord2.School__r.Name;
                }
                if(ChildList.size()==3){
                    ChildRecord1= ChildList[0];
                    ChildRecord2= ChildList[1];
                    ChildRecord3= ChildList[2];
    
                    ggObj.ChildRecord1 = ChildRecord1;
                    ggObj.Child1SchoolName = ChildList[0].School__r.Name;
                    ggObj.ChildRecord2 = ChildRecord2;
                    ggObj.Child2SchoolName = ChildRecord2.School__r.Name;
                    ggObj.ChildRecord3 = ChildRecord3;
                    ggObj.Child3SchoolName = ChildRecord3.School__r.Name;
                }
            }
            
             
            if(ChildRecord1!=null){
                list<Form__c> ChildHealthRecordsList = new list<Form__c>();
                Form__c Child1HealthRecord;
                ChildHealthRecordsList = [select id,Days_Attending__c
                                            from Form__c 
                                            where Client__c =:ChildRecord1.id]; 
    
                if(ChildHealthRecordsList.size()>0)  {
                    Child1HealthRecord = ChildHealthRecordsList[0];
                    ggObj.Child1HealthRecord = Child1HealthRecord;    
                }                    
    
            }
                    
            if(ChildRecord2!=null){
                list<Form__c> ChildHealthRecordsList = new list<Form__c>();
    
                Form__c Child2HealthRecord;
                ChildHealthRecordsList=  [select id,Days_Attending__c
                                                    from Form__c 
                                                    where Client__c =:ChildRecord2.id]; 
                if(ChildHealthRecordsList.size()>0)  {
                    Child2HealthRecord = ChildHealthRecordsList[0];
                    ggObj.Child2HealthRecord = Child2HealthRecord;    
                }                             
            }            
    
            if(ChildRecord3!=null){
                list<Form__c> ChildHealthRecordsList = new list<Form__c>();
    
                Form__c Child3HealthRecord;
                ChildHealthRecordsList = [select id,Days_Attending__c
                                            from Form__c 
                                            where Client__c =:ChildRecord3.id]; 
    
                if(ChildHealthRecordsList.size()>0)  {
                    Child3HealthRecord = ChildHealthRecordsList[0];
                    ggObj.Child3HealthRecord = Child3HealthRecord;    
                } 
            }
            
            list<optionWrapper> SchoolOptionsList = new list<optionWrapper>();
            list<Account> AccountList = [select Id,Name,Type from Account where Type='School'];
            if(AccountList.size()>0){
                for(Account acc : AccountList){
                    optionWrapper wrap = new optionWrapper();
                    wrap.label = acc.Name;
                    wrap.value = acc.Id;
                    SchoolOptionsList.add(wrap);
                }
            }
            
            ggObj.SchoolOptionsList = SchoolOptionsList;
            ggObj.GradesList=RegistrationFormController.getPicklistValues('Contact','Grade__c');
            ggObj.ParentRelationshipList=RegistrationFormController.getPicklistValues('Contact','Primary_Guardian_Relationship__c');
            ggObj.PublicAssistancePickList=RegistrationFormController.getPicklistValues('Contact','Receive_Public_Assistance__c');
            ggObj.HousingTypePickList=RegistrationFormController.getPicklistValues('Contact','Housing_Type__c');
            ggObj.HousingOwnerShipPickList=RegistrationFormController.getPicklistValues('Contact','Housing_Ownership__c');
            ggObj.EmergencyContactRelationShipPickList=RegistrationFormController.getPicklistValues('Contact','Emergency_Contact_Relationship__c');
            ggObj.ApprovedPickup1RelationshipPickList=RegistrationFormController.getPicklistValues('Contact','Approved_Pick_Up_1_Relationship__c');
            ggObj.ApprovedPickup2RelationshipPickList=RegistrationFormController.getPicklistValues('Contact','Approved_Pick_Up_2_Relationship__c');
            ggObj.TakesMedicationPickList=RegistrationFormController.getPicklistValues('Contact','Takes_Medication__c');
            ggObj.SourceOfIncomeMultiPicklist=RegistrationFormController.getPicklistValues('Contact','Source_of_Income__c');
            ggObj.HaveHadIllnessMultiPicklist=RegistrationFormController.getPicklistValues('Contact','Had_illness__c');
            ggObj.AllergiesMultiPicklist=RegistrationFormController.getPicklistValues('Contact','Allergies__c');
            ggObj.DaysAttendAfterSchoolMultiPicklist = RegistrationFormController.getPicklistValues('Contact','Child_will_Attend_Afterschool__c');     
            System.debug('ggObj.HaveHadIllnessMultiPicklist  '+ggObj.HaveHadIllnessMultiPicklist);        
            System.debug('ggObj   '+ggObj);
            
            
        }catch(Exception e){
            system.debug('exception ---->'+e.getMessage());
        }        
        

        return ggObj;
    }
    
    
    @AuraEnabled
    public static String saveForm(Contact ChildRecord1,Contact ChildRecord2,Contact ChildRecord3,Contact ParentRecord1,Contact ParentRecord2,
                                    String Child1RecordId,String Child2RecordId,String Child3RecordId,String Parent1RecordId,
                                    String Parent2RecordId,String Parent1AccountId,String CampaignId,String CampaignMemberId, String ProgramId,string SignatureconvertedDataURI,
                                    /*String child1FirstName,String child1LastName,String child1Birthday,String child1Age,
                                    String child1SSN,String child1School,String child1Grade,String child1PhysicianName,
                                    String child1PhysicianPhone,String child1PhysicianInsuranceNumber,String child1LastPhysical,
                                    String child1LastVisionTest,String child1LastHearingExam,String child1Dental,
                                    String child1OperationInjuries1,String child1CurrentMedications,String child1TakeMedication,
                                    String child1SpecialNeeds,String child1PhysiciansAdvice,String child1HaveHad,
                                    String child1PhysicianDetails,String child1Allergies,String child1AllergiesDetails,String child1AttendAfterSchool,
                                    String child2FirstName,String child2LastName,String child2Birthday,String child2Age,
                                    String child2SSN,String child2School,String child2Grade,String child2PhysicianName,
                                    String child2PhysicianPhone,String child2PhysicianInsuranceNumber,String child2LastPhysical,
                                    String child2LastVisionTest,String child2LastHearingExam,String child2Dental,
                                    String child2OperationInjuries1,String child2CurrentMedications,String child2TakeMedication,
                                    String child2SpecialNeeds,String child2PhysiciansAdvice,String child2HaveHad,
                                    String child2PhysicianDetails,String child2Allergies,String child2AllergiesDetails,String child2AttendAfterSchool,
                                    String child3FirstName,String child3LastName,String child3Birthday,String child3Age,
                                    String child3SSN,String child3School,String child3Grade,String child3PhysicianName,
                                    String child3PhysicianPhone,String child3PhysicianInsuranceNumber,String child3LastPhysical,
                                    String child3LastVisionTest,String child3LastHearingExam,String child3Dental,
                                    String child3OperationInjuries1,String child3CurrentMedications,String child3TakeMedication,
                                    String child3SpecialNeeds,String child3PhysiciansAdvice,String child3HaveHad,
                                    String child3PhysicianDetails,String child3Allergies,String child3AllergiesDetails,String child3AttendAfterSchool,
                                    String EmergencyContactFirst,String EmergencyContactLast,String EmergencyContactRelationShip,
                                    String EmergencyPhone,String EmergencyCellPhone,String ApprovedPickUp1,String ApprovedPickup1Relationship,String ApprovedPickUp1Phone,
                                    String ApprovedPickUp2,String ApprovedPickup2Relationship,String ApprovedPickUp2Phone,
                                    String Parent1FirstName,String Parent1LastName,String Parent1Relationship,String Parent1Address,String Parent1City,
                                    String Parent1State,String Parent1ZipCode,String Parent1PlaceOfEmp,String Parent1HomePhone,String Parent1CellPhone,
                                    String Parent1WorkPhone,String Parent1emailAddress,String Parent1MonthlyIncome,String Parent1SourceIncome,String Parent1PublicAssistance,
                                    String Parent1HousingType,String Parent1HousingOwnerShip,String Parent2FirstName,String Parent2LastName,String Parent2Relationship,String Parent2Address,String Parent2City,
                                    String Parent2State,String Parent2ZipCode,String Parent2PlaceOfEmp,String Parent2HomePhone,String Parent2CellPhone,
                                    String Parent2WorkPhone,String Parent2emailAddress,String Parent2MonthlyIncome,String Parent2SourceIncome,String Parent2PublicAssistance,
                                    String Parent2HousingType,String Parent2HousingOwnerShip,String Parent3FirstName,String Parent3LastName,String Parent3Relationship,String Parent3Address,String Parent3City,
                                    String Parent3State,String Parent3ZipCode,String Parent3PlaceOfEmp,String Parent3HomePhone,String Parent3CellPhone,
                                    String Parent3WorkPhone,String Parent3emailAddress,String Parent3MonthlyIncome,String Parent3SourceIncome,String Parent3PublicAssistance,
                                    String Parent3HousingType,String Parent3HousingOwnerShip*/String[] child1JSON,String HowDoYouHearAboutUs
){
        System.debug('child1JSON'+child1JSON);
        System.debug('save form');
        system.debug('Parent1AccountId--->'+Parent1AccountId);
        String msg='';      
        try{
            System.debug('first');
            list<Contact> childsList = new list<Contact>();

            Id ParentRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
            Id ChildRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child').getRecordTypeId();
            system.debug('Parent1AccountId--->'+Parent1AccountId);
            system.debug('Parent1RecordId--->'+Parent1RecordId);
                   
            
            
            if(ParentRecord1.LastName!=null && ParentRecord1.LastName!='' && Parent1RecordId !=null){
                ParentRecord1.Id = Parent1RecordId;
                update ParentRecord1;
                System.debug('ParentRecord1 updated successfully');    
            }

            
            if(ParentRecord2!=null){
                ParentRecord2.RecordTypeId = ParentRecordTypeId;
                ParentRecord2.AccountId = Parent1AccountId;
                
                system.debug('ParentRecord2.AccountId---->'+ParentRecord2.AccountId);
                
                if((ParentRecord2.LastName!=null && ParentRecord2.LastName!='')&& (Parent2RecordId=='' || Parent2RecordId ==null)){
                    insert ParentRecord2;
                    Parent2RecordId = ParentRecord2.Id;
                    System.debug('ParentRecord2 inserted successfully');    
                }
                else if(ParentRecord2.LastName!=null && ParentRecord2.LastName!='' && Parent2RecordId !=null){
                    ParentRecord2.Id = Parent2RecordId;
                    ParentRecord2.AccountId = Parent1AccountId;
                    update ParentRecord2;
                    System.debug('ParentRecord2 updated successfully');    
                }                
            }
          
            
            
            if(ChildRecord1!=null){
                ChildRecord1.RecordTypeId = ChildRecordTypeId;
                ChildRecord1.Name_of_Primary_Parent_Guardian__c = Parent1RecordId;     
                ChildRecord1.AccountId = Parent1AccountId;
                
                if((ChildRecord1.LastName!=null && ChildRecord1.LastName!='')&& (Child1RecordId=='' || Child1RecordId ==null)){
                    insert ChildRecord1;
                    Child1RecordId = ChildRecord1.Id;
                    System.debug('ChildRecord1 inserted successfully');
                }
                else if(ChildRecord1.LastName!=null && ChildRecord1.LastName!='' && Child1RecordId !=null){
                    ChildRecord1.Id = Child1RecordId;
                    update ChildRecord1;
                    System.debug('ChildRecord1 updated successfully');    
                }
                
            }
            if(ChildRecord2!=null){
                ChildRecord2.RecordTypeId = ChildRecordTypeId;
                ChildRecord2.Name_of_Primary_Parent_Guardian__c = Parent1RecordId;
                ChildRecord2.AccountId = Parent1AccountId;
                
                if((ChildRecord2.LastName!=null && ChildRecord2.LastName!='') && (Child2RecordId=='' || Child2RecordId ==null)){
                    insert ChildRecord2;
                    Child2RecordId = ChildRecord2.Id;
                    System.debug('ChildRecord2 inserted successfully');    
                }
                else if(ChildRecord2.LastName!=null && ChildRecord2.LastName!='' && Child2RecordId !=null){
                    ChildRecord2.Id = Child2RecordId;
                    update ChildRecord2;
                    System.debug('ChildRecord2 updated successfully');    
                }                
            }
            
            
            if(ChildRecord3!=null){
                ChildRecord3.RecordTypeId = ChildRecordTypeId;
                ChildRecord3.Name_of_Primary_Parent_Guardian__c = Parent1RecordId;
                ChildRecord1.AccountId = Parent1AccountId;
                
                if((ChildRecord3.LastName!=null && ChildRecord3.LastName!='') && (Child3RecordId=='' || Child3RecordId ==null)){
                    insert ChildRecord3;
                    Child3RecordId = ChildRecord3.Id;
                    System.debug('ChildRecord3 inserted successfully');    
                }
                else if(ChildRecord3.LastName!=null && ChildRecord3.LastName!='' && Child3RecordId !=null){
                    ChildRecord3.Id = Child3RecordId;
                    update ChildRecord3;
                    System.debug('ChildRecord3 updated successfully');    
                }                
            }
             
            
            
            Id FormRecordTypeId = Schema.SObjectType.Form__c.getRecordTypeInfosByName().get('Registration').getRecordTypeId();
            list<Registration__c> regList = new list<Registration__c>([select id from Registration__c]);
            Integer regSize = regList.size()+1;
            Registration__c reg = new Registration__c();
            reg.Name = 'Registration '+regSize;
            if(ProgramId!=null && ProgramId!=''){
                reg.Program__c = ProgramId;

            }
            if(Child1RecordId!=''){
                reg.Client__c = Child1RecordId;
            }
            if(Child2RecordId!=''){
                reg.Client2__c = Child2RecordId; 
            }
            if(Child3RecordId!=''){
                reg.Client3__c = Child3RecordId;
            }
            if(Parent1RecordId!=''){
                reg.Caregiver_Parent__c = Parent1RecordId;
            }
            if(Parent2RecordId!=''){
                reg.Caregiver_Parent2__c = Parent2RecordId;
            }
            if(CampaignId!=''){
                reg.Campaign__c = CampaignId;
            }
            
            reg.Registration_Date__c = system.today();
            //reg.How_do_you_hear_about_us__c
            if(ChildRecord1!=null){
                reg.FirstName__c = ChildRecord1.FirstName;
                reg.LastName__c = ChildRecord1.LastName;
                reg.Birthdate__c = ChildRecord1.Birthdate;
                reg.SSN__c = ChildRecord1.SSN__c;
                reg.School__c = ChildRecord1.School__c;
                reg.Grade__c = ChildRecord1.Grade__c;
                reg.Physician_Name__c = ChildRecord1.Physician_Name__c;
                reg.Physician__c = ChildRecord1.Physician__c;
                reg.Insurance_Provider__c = ChildRecord1.Insurance_Provider__c;
                reg.Most_Recent_Physical__c = ChildRecord1.Most_Recent_Physical__c;
                reg.Most_Recent_Vision_Exam__c = ChildRecord1.Most_Recent_Vision_Exam__c;
                reg.Most_Recent_Hearing_Exam__c = ChildRecord1.Most_Recent_Hearing_Exam__c;
                reg.Most_Recent_Dental_Exam__c = ChildRecord1.Most_Recent_Dental_Exam__c;
                reg.Operations_Injuries__c = ChildRecord1.Operations_Injuries__c;
                reg.Medical_Needs__c = ChildRecord1.Medical_Needs__c;
                reg.Medications__c = ChildRecord1.Medications__c;
                reg.Takes_Medication__c = ChildRecord1.Takes_Medication__c;
                reg.Physicians_Advice__c = ChildRecord1.Physicians_Advice__c;
                reg.Had_illness__c = ChildRecord1.Had_illness__c;
                reg.MH_History_Detailed__c = ChildRecord1.MH_History_Detailed__c;
                reg.Allergies_Detailed__c = ChildRecord1.Allergies_Detailed__c;
                reg.Allergies__c = ChildRecord1.Allergies__c;
                reg.Child_will_Attend_Afterschool__c = ChildRecord1.Child_will_Attend_Afterschool__c;
                reg.Emergency_Contact_First__c = ChildRecord1.Emergency_Contact_First__c;
                reg.Emergency_Contact_Last__c = ChildRecord1.Emergency_Contact_Last__c;
                reg.Emergency_Contact_Relationship__c = ChildRecord1.Emergency_Contact_Relationship__c;
                reg.Emergency_Contact_Phone__c = ChildRecord1.Emergency_Contact_Phone__c;
                reg.Emergency_Contact_Cell_Phone__c = ChildRecord1.Emergency_Contact_Cell_Phone__c;
                reg.Approved_Pick_Up_1__c = ChildRecord1.Approved_Pick_Up_1__c;
                reg.Approved_Pick_Up_2__c = ChildRecord1.Approved_Pick_Up_2__c;
                reg.Approved_Pick_Up_1_Relationship__c = ChildRecord1.Approved_Pick_Up_1_Relationship__c;
                reg.Approved_Pick_Up_2_Relationship__c = ChildRecord1.Approved_Pick_Up_2_Relationship__c;
                reg.Approved_Pick_Up_1_Phone__c = ChildRecord1.Approved_Pick_Up_1_Phone__c;
                reg.Approved_Pick_Up_2_Phone__c = ChildRecord1.Approved_Pick_Up_2_Phone__c;
            }
            if(ChildRecord2!=null){
                reg.FirstName2__c = ChildRecord2.FirstName;
                reg.LastName2__c = ChildRecord2.LastName;
                reg.Birthdate2__c = ChildRecord2.Birthdate;
                reg.SSN2__c = ChildRecord2.SSN__c;
                reg.School2__c = ChildRecord2.School__c;
                reg.Grade2__c = ChildRecord2.Grade__c;
                reg.Physician_Name2__c = ChildRecord2.Physician_Name__c;
                reg.Physician2__c = ChildRecord2.Physician__c;
                reg.Insurance_Provider2__c = ChildRecord2.Insurance_Provider__c;
                reg.Most_Recent_Physical2__c = ChildRecord2.Most_Recent_Physical__c;
                reg.Most_Recent_Vision_Exam2__c = ChildRecord2.Most_Recent_Vision_Exam__c;
                reg.Most_Recent_Hearing_Exam2__c = ChildRecord2.Most_Recent_Hearing_Exam__c;
                reg.Most_Recent_Dental_Exam2__c = ChildRecord2.Most_Recent_Dental_Exam__c;
                reg.Operations_Injuries2__c = ChildRecord2.Operations_Injuries__c;
                reg.Medical_Needs2__c = ChildRecord2.Medical_Needs__c;
                reg.Medications2__c = ChildRecord2.Medications__c;
                reg.Takes_Medication2__c = ChildRecord2.Takes_Medication__c;
                reg.Physicians_Advice2__c = ChildRecord2.Physicians_Advice__c;
                reg.Had_illness2__c = ChildRecord2.Had_illness__c;
                reg.MH_History_Detailed2__c = ChildRecord2.MH_History_Detailed__c;
                reg.Allergies_Detailed2__c = ChildRecord2.Allergies_Detailed__c;
                reg.Allergies2__c = ChildRecord2.Allergies__c;
                reg.Child_will_Attend_Afterschool2__c = ChildRecord2.Child_will_Attend_Afterschool__c;
                reg.Emergency_Contact_First2__c = ChildRecord2.Emergency_Contact_First__c;
                reg.Emergency_Contact_Last2__c = ChildRecord2.Emergency_Contact_Last__c;
                reg.Emergency_Contact_Relationship2__c = ChildRecord2.Emergency_Contact_Relationship__c;
                reg.Emergency_Contact_Phone2__c = ChildRecord2.Emergency_Contact_Phone__c;
                reg.Emergency_Contact_Cell_Phone2__c = ChildRecord2.Emergency_Contact_Cell_Phone__c;
                reg.Approved_Pick_Up_12__c = ChildRecord2.Approved_Pick_Up_1__c;
                reg.Approved_Pick_Up_22__c = ChildRecord2.Approved_Pick_Up_2__c;
                reg.Approved_Pick_Up_1_Relationship2__c = ChildRecord2.Approved_Pick_Up_1_Relationship__c;
                reg.Approved_Pick_Up_2_Relationship2__c = ChildRecord2.Approved_Pick_Up_2_Relationship__c;
                reg.Approved_Pick_Up_1_Phone2__c = ChildRecord2.Approved_Pick_Up_1_Phone__c;
                reg.Approved_Pick_Up_2_Phone2__c = ChildRecord2.Approved_Pick_Up_2_Phone__c;
                
            }
            if(ChildRecord3!=null){
                reg.FirstName3__c = ChildRecord3.FirstName;
                reg.LastName3__c = ChildRecord3.LastName;
                reg.Birthdate3__c = ChildRecord3.Birthdate;
                reg.SSN3__c = ChildRecord3.SSN__c;
                reg.School3__c = ChildRecord3.School__c;
                reg.Grade3__c = ChildRecord3.Grade__c;
                reg.Physician_Name3__c = ChildRecord3.Physician_Name__c;
                reg.Physician3__c = ChildRecord3.Physician__c;
                reg.Insurance_Provider3__c = ChildRecord3.Insurance_Provider__c;
                reg.Most_Recent_Physical3__c = ChildRecord3.Most_Recent_Physical__c;
                reg.Most_Recent_Vision_Exam3__c = ChildRecord3.Most_Recent_Vision_Exam__c;
                reg.Most_Recent_Hearing_Exam3__c = ChildRecord3.Most_Recent_Hearing_Exam__c;
                reg.Most_Recent_Dental_Exam3__c = ChildRecord3.Most_Recent_Dental_Exam__c;
                reg.Operations_Injuries3__c = ChildRecord3.Operations_Injuries__c;
                reg.Medical_Needs3__c = ChildRecord3.Medical_Needs__c;
                reg.Medications3__c = ChildRecord3.Medications__c;
                reg.Takes_Medication3__c = ChildRecord3.Takes_Medication__c;
                reg.Physicians_Advice3__c = ChildRecord3.Physicians_Advice__c;
                reg.Had_illness3__c = ChildRecord3.Had_illness__c;
                reg.Allergies_Detailed3__c = ChildRecord3.Allergies_Detailed__c;
                reg.Allergies3__c = ChildRecord3.Allergies__c;
                reg.MH_History_Detailed3__c = ChildRecord3.MH_History_Detailed__c;
                reg.Child_will_Attend_Afterschool3__c = ChildRecord3.Child_will_Attend_Afterschool__c;
                reg.Emergency_Contact_First3__c = ChildRecord3.Emergency_Contact_First__c;
                reg.Emergency_Contact_Last3__c = ChildRecord3.Emergency_Contact_Last__c;
                reg.Emergency_Contact_Relationship3__c = ChildRecord3.Emergency_Contact_Relationship__c;
                reg.Emergency_Contact_Phone3__c = ChildRecord3.Emergency_Contact_Phone__c;
                reg.Emergency_Contact_Cell_Phone3__c = ChildRecord3.Emergency_Contact_Cell_Phone__c;
                reg.Approved_Pick_Up_13__c = ChildRecord3.Approved_Pick_Up_1__c;
                reg.Approved_Pick_Up_23__c = ChildRecord3.Approved_Pick_Up_2__c;
                reg.Approved_Pick_Up_1_Relationship3__c = ChildRecord3.Approved_Pick_Up_1_Relationship__c;
                reg.Approved_Pick_Up_2_Relationship3__c = ChildRecord3.Approved_Pick_Up_2_Relationship__c;
                reg.Approved_Pick_Up_1_Phone3__c = ChildRecord3.Approved_Pick_Up_1_Phone__c;
                reg.Approved_Pick_Up_2_Phone3__c = ChildRecord3.Approved_Pick_Up_2_Phone__c;
            }
            if(ParentRecord1!=null){
                reg.Primary_Guardian_Relationship__c = ParentRecord1.Primary_Guardian_Relationship__c;
                reg.MailingCity__c = ParentRecord1.MailingCity;
                reg.MailingState__c = ParentRecord1.MailingState;
                reg.MailingPostalCode__c = ParentRecord1.MailingPostalCode;
                reg.MailingStreet__c = ParentRecord1.MailingStreet;
                reg.Place_of_Employment__c = ParentRecord1.Place_of_Employment__c;
                reg.Phone__c = ParentRecord1.Phone;
                reg.MobilePhone__c = ParentRecord1.MobilePhone;
                reg.WorkPhone__c = ParentRecord1.npe01__WorkPhone__c;
                reg.Email__c = ParentRecord1.Email;
                reg.Household_Monthly_Income__c = ParentRecord1.Household_Monthly_Income__c;
                reg.Source_of_Income__c = ParentRecord1.Source_of_Income__c;
                reg.Receive_Public_Assistance__c = ParentRecord1.Receive_Public_Assistance__c;
                reg.Housing_Type__c = ParentRecord1.Housing_Type__c;
                reg.Housing_Ownership__c = ParentRecord1.Housing_Ownership__c;
                reg.Time_In_Residence__c = ParentRecord1.Time_In_Residence__c;
            }
            if(ParentRecord2!=null){
                reg.Primary_Guardian_Relationship2__c = ParentRecord2.Primary_Guardian_Relationship__c;
                reg.MailingCity2__c = ParentRecord2.MailingCity;
                reg.MailingState2__c = ParentRecord2.MailingState;
                reg.MailingPostalCode2__c = ParentRecord2.MailingPostalCode;
                reg.MailingStreet2__c = ParentRecord2.MailingStreet;
                reg.Place_of_Employment2__c = ParentRecord2.Place_of_Employment__c;
                reg.Phone2__c = ParentRecord2.Phone;
                reg.MobilePhone2__c = ParentRecord2.MobilePhone;
                reg.WorkPhone2__c = ParentRecord2.npe01__WorkPhone__c;
                reg.Email2__c = ParentRecord2.Email;
                reg.Household_Monthly_Income2__c = ParentRecord2.Household_Monthly_Income__c;
                reg.Source_of_Income2__c = ParentRecord2.Source_of_Income__c;
                reg.Receive_Public_Assistance2__c = ParentRecord2.Receive_Public_Assistance__c;
                reg.Housing_Type2__c = ParentRecord2.Housing_Type__c;
                reg.Housing_Ownership2__c = ParentRecord2.Housing_Ownership__c;
                reg.Time_In_Residence2__c = ParentRecord2.Time_In_Residence__c;
            }
            reg.Signature_DateTime__c = System.now();
            reg.How_do_you_hear_about_us__c = ParentRecord1.How_do_you_hear_about_us__c;
            //reg.SignatureContentVersionId__c = SignatureconvertedDataURI;

            insert reg;
            //reg.
           /* Form__c form = new Form__c();
            if(ProgramId!=null && ProgramId!=''){
                form.Program__c =ProgramId;

            }
            form.RecordTypeId = FormRecordTypeId;
            if(Child1RecordId!=''){
                form.Client__c = Child1RecordId;
            }
            if(Child2RecordId!=''){
                form.Client2__c = Child2RecordId; 
            }
            if(Child3RecordId!=''){
                form.Client3__c = Child3RecordId;
            }
            if(Parent1RecordId!=''){
                form.Caregiver_Parent__c = Parent1RecordId;
            }
            if(Parent2RecordId!=''){
                form.Caregiver_Parent2__c = Parent2RecordId;
            }
            if(CampaignId!=''){
                form.Campaign__c = CampaignId;
            }
            if(CampaignMemberId!=''){
                form.CampaignMemberId__c = CampaignMemberId;
            }
            form.Form_Completion_Date__c = system.today();*/
    
            try{

               // insert form;
                
                CampaignMember campaignmemberrec = [Select Id, Form__c From CampaignMember Where Id=:CampaignMemberId];
                //campaignmemberrec.Form__c = form.Id;
                //update campaignmemberrec;
    
                if(reg.Id!=null && SignatureconvertedDataURI!=null && SignatureconvertedDataURI!=''){
                    
                    ContentVersion cVersion = new ContentVersion();
                    cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
                    cVersion.PathOnClient = 'Signature.png';//File name with extention
                    cVersion.Title =  'Signature';//Name of the file
                    cVersion.VersionData =  EncodingUtil.base64Decode(SignatureconvertedDataURI);
                    Insert cVersion;
                    
                    //After saved the Content Verison, get the ContentDocumentId
                    Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id].ContentDocumentId;
                    
                    //Insert ContentDocumentLink
                    ContentDocumentLink cDocLink = new ContentDocumentLink();
                    cDocLink.ContentDocumentId = conDocument;//Add ContentDocumentId
                    cDocLink.LinkedEntityId = reg.Id;//Add attachment parentId
                    cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
                    cDocLink.Visibility = 'AllUsers';//AllUsers, InternalUsers, SharedUsers
                    
                    Insert cDocLink;    
                    
                    reg.SignatureContentVersionId__c = cVersion.Id;
                    update reg;
                }    

                msg='Form Submitted';
            }catch(Exception e){
                system.debug('error--->'+e.getMessage());
            }

        }  
        catch(Exception e){
           System.debug('error--->'+e.getMessage());
            String errormesage=e.getMessage();
            string returnMsg = '';
            if(errormesage.contains('Insurance_Provider__c duplicates')){
              returnMsg='Please Check Duplicate Insurance Information';
              System.debug('msg  '+returnMsg);
            }else if(errormesage.contains('INVALID_EMAIL_ADDRESS')){
                returnMsg='Please Enter Correct Email';
                System.debug('msg  '+returnMsg);
            }else if(errormesage.contains('NUMBER_OUTSIDE_VALID_RANGE, Insurance Number')){
                returnMsg='Insurance Number should be less than 18 digits';
                System.debug('msg  '+returnMsg);
            }else if(errormesage.contains('NUMBER_OUTSIDE_VALID_RANGE, Household Monthly Income')){
                returnMsg='Household Monthly Income should be less than 18 digits';
                System.debug('msg  '+returnMsg);
            }else{
                returnMsg = errormesage;
            }
            
             msg = returnMsg;

        }                               
        
        return msg;
    }
   
    public static Date replaceTime(Date dT){
        system.debug('dT--->'+dT);
        Date dateOnly = date.newinstance(dT.year(), dT.month(), dT.day());       
        return dateOnly;
    }

    public class ggFormWrapper{

        @AuraEnabled public list<optionWrapper> GradesList;
        @AuraEnabled public list<optionWrapper> ParentRelationshipList;
        @AuraEnabled public list<optionWrapper> PublicAssistancePickList;
        @AuraEnabled public list<optionWrapper> HousingTypePickList;
        @AuraEnabled public list<optionWrapper> HousingOwnerShipPickList;
        @AuraEnabled public list<optionWrapper> EmergencyContactRelationShipPickList;
        @AuraEnabled public list<optionWrapper> ApprovedPickup1RelationshipPickList;
        @AuraEnabled public list<optionWrapper> ApprovedPickup2RelationshipPickList;
        @AuraEnabled public list<optionWrapper> TakesMedicationPickList;
        @AuraEnabled public list<optionWrapper> SourceOfIncomeMultiPicklist;
        @AuraEnabled public list<optionWrapper> HaveHadIllnessMultiPicklist;
        @AuraEnabled public list<optionWrapper> AllergiesMultiPicklist;
        @AuraEnabled public list<optionWrapper> DaysAttendAfterSchoolMultiPicklist;


        @AuraEnabled public Contact ParentRecord1;
        @AuraEnabled public Contact ParentRecord2;

        @AuraEnabled public Contact  ChildRecord1;
        @AuraEnabled public Contact  ChildRecord2;
        @AuraEnabled public Contact  ChildRecord3;
        @AuraEnabled public string  Child1SchoolName;
        @AuraEnabled public string  Child2SchoolName;
        @AuraEnabled public string  Child3SchoolName;
        
        @AuraEnabled public Form__c Child1HealthRecord;
        @AuraEnabled public Form__c Child2HealthRecord;
        @AuraEnabled public Form__c Child3HealthRecord;

        @AuraEnabled public Campaign campaignRec;

        @AuraEnabled public list<optionWrapper> SchoolOptionsList;
    }
    
    public class optionWrapper{

        @AuraEnabled  public String label;
        @AuraEnabled public String value;
    }
    
}