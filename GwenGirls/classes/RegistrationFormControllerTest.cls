/**
 * @description       : 
 * @author            : WINSupport
 * @group             : 
 * @last modified on  : 03-23-2021
 * @last modified by  : WINSupport
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   03-23-2021   WINSupport   Initial Version
**/
@isTest
public class RegistrationFormControllerTest {
    
    @testSetup 
    static void setup(){
        
        Id AccountRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();        
        Account account = new Account();
        account.Name = 'Parent Account';
        account.RecordTypeId = AccountRecordTypeId;
        insert account;
        
        Account school1 = new Account();
        school1.Name = 'School1';
        school1.Type = 'School';
        insert school1;
        
        Account school2 = new Account();
        school2.Name = 'School2';
        school2.Type = 'School';
        insert school2;
        
        Account school3 = new Account();
        school3.Name = 'School3';
        school3.Type = 'School';
        insert school3;
        
        Id ParentRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
        Contact parent1 = new Contact();
        parent1.AccountId = account.Id;
        parent1.FirstName = 'N';
        parent1.LastName = 'Murthy';
        parent1.RecordTypeId = ParentRecordTypeId; 
        parent1.Primary_Guardian_Relationship__c = 'Father';
        parent1.PIN__c = '765673';
        parent1.MailingStreet = 'Nehru Street';
        parent1.MailingCity = 'kkd';
        parent1.MailingState = 'AP';
        parent1.MailingPostalCode = '533004';
        parent1.Place_of_Employment__c = 'kkd';
        parent1.Phone = '7652345672';
        parent1.MobilePhone = '7652345672';
        parent1.npe01__WorkPhone__c = '7652345672';
        parent1.Email = 'sowndarya.nittala@diligentforeclabs.com';
        parent1.Household_Monthly_Income__c = 60000;
        parent1.Source_of_Income__c = 'Employment';
        parent1.Receive_Public_Assistance__c = 'Yes';
        parent1.Housing_Type__c = 'Apartment';
        parent1.Housing_Ownership__c = 'Rent';
        parent1.Time_In_Residence__c = 'test';
        insert parent1;
           
        Id ChildRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child').getRecordTypeId();
        Contact child1 = new Contact();
        child1.AccountId = account.Id;
        child1.FirstName = 'N1';
        child1.LastName = 'Pasalapudi';
        child1.RecordTypeId = ChildRecordTypeId; 
        child1.Birthdate = Date.today();
        child1.SSN__c = '101';
        child1.School__c = school1.Id;
        child1.Grade__c = '1';
        child1.Physician_Name__c = 'Test';
        child1.Physician__c = 'Testt';
        child1.Insurance_Number__c = 100000;
        child1.Most_Recent_Physical__c = Date.today();
        child1.Most_Recent_Vision_Exam__c = Date.today();
        child1.Most_Recent_Hearing_Exam__c = Date.today();
        child1.Most_Recent_Dental_Exam__c = Date.today();
        child1.Operations_Injuries__c = 'Test';
        child1.Medical_Needs__c = 'Test';
        child1.Medications__c = 'Test';
        child1.Takes_Medication__c = 'Inconsistent';
        child1.Physicians_Advice__c = 'Test';
        child1.Had_illness__c = 'Mumps';
        child1.MH_History_Detailed__c = 'Test';
        child1.Allergies_Detailed__c = 'Test';
        child1.Allergies__c = 'Medicine';
        child1.Child_will_Attend_Afterschool__c = 'Monday';
        child1.Emergency_Contact_First__c = 'test';
        child1.Emergency_Contact_Last__c = 'testt';
        child1.Emergency_Contact_Relationship__c = 'Family';
        child1.Emergency_Contact_Phone__c = '9874561230';
        child1.Emergency_Contact_Cell_Phone__c = '8796541230';
        child1.Approved_Pick_Up_1__c = '1';
        child1.Approved_Pick_Up_2__c = '2';
        child1.Approved_Pick_Up_1_Relationship__c = 'Family';
        child1.Approved_Pick_Up_2_Relationship__c = 'Family';
        child1.Approved_Pick_Up_1_Phone__c = '8974563210';
        child1.Approved_Pick_Up_2_Phone__c = '8745963210';
        child1.Name_of_Primary_Parent_Guardian__c = parent1.Id;
        insert child1;

        String child1id = child1.id;

        /*Contact child2 = new Contact();
        child2.AccountId = account.Id;
        child2.FirstName = 'N2';
        child2.LastName = 'Pasalapudi';
        child2.RecordTypeId = ChildRecordTypeId; 
        child2.Birthdate = Date.today();
        child2.SSN__c = '102';
        child2.School__c = school1.Id;
        child2.Grade__c = '1';
        child2.Physician_Name__c = 'Test';
        child2.Physician__c = 'Testt';
        child2.Insurance_Number__c = 100000;
        child2.Most_Recent_Physical__c = Date.today();
        child2.Most_Recent_Vision_Exam__c = Date.today();
        child2.Most_Recent_Hearing_Exam__c = Date.today();
        child2.Most_Recent_Dental_Exam__c = Date.today();
        child2.Operations_Injuries__c = 'Test';
        child2.Medical_Needs__c = 'Test';
        child2.Medications__c = 'Test';
        child2.Takes_Medication__c = 'Inconsistent';
        child2.Physicians_Advice__c = 'Test';
        child2.Had_illness__c = 'Mumps';
        child2.MH_History_Detailed__c = 'Test';
        child2.Allergies_Detailed__c = 'Test';
        child2.Allergies__c = 'Medicine';
        child2.Child_will_Attend_Afterschool__c = 'Monday';
        child2.Emergency_Contact_First__c = 'test';
        child2.Emergency_Contact_Last__c = 'testt';
        child2.Emergency_Contact_Relationship__c = 'Family';
        child2.Emergency_Contact_Phone__c = '9874561230';
        child2.Emergency_Contact_Cell_Phone__c = '8796541230';
        child2.Approved_Pick_Up_1__c = '1';
        child2.Approved_Pick_Up_2__c = '2';
        child2.Approved_Pick_Up_1_Relationship__c = 'Family';
        child2.Approved_Pick_Up_2_Relationship__c = 'Family';
        child2.Approved_Pick_Up_1_Phone__c = '8974563210';
        child2.Approved_Pick_Up_2_Phone__c = '8745963210';
        child2.Name_of_Primary_Parent_Guardian__c = parent1.Id;
        insert child2;

        String child2id = child2.id;

        Contact child3 = new Contact();
        child3.AccountId = account.Id;
        child3.FirstName = 'N3';
        child3.LastName = 'Pasalapudi';
        child3.RecordTypeId = ChildRecordTypeId; 
        child3.Birthdate = Date.today();
        child3.SSN__c = '103';
        child3.School__c = school1.Id;
        child3.Grade__c = '1';
        child3.Physician_Name__c = 'Test';
        child3.Physician__c = 'Testt';
        child3.Insurance_Number__c = 100000;
        child3.Most_Recent_Physical__c = Date.today();
        child3.Most_Recent_Vision_Exam__c = Date.today();
        child3.Most_Recent_Hearing_Exam__c = Date.today();
        child3.Most_Recent_Dental_Exam__c = Date.today();
        child3.Operations_Injuries__c = 'Test';
        child3.Medical_Needs__c = 'Test';
        child3.Medications__c = 'Test';
        child3.Takes_Medication__c = 'Inconsistent';
        child3.Physicians_Advice__c = 'Test';
        child3.Had_illness__c = 'Mumps';
        child3.MH_History_Detailed__c = 'Test';
        child3.Allergies_Detailed__c = 'Test';
        child3.Allergies__c = 'Medicine';
        child3.Child_will_Attend_Afterschool__c = 'Monday';
        child3.Emergency_Contact_First__c = 'test';
        child3.Emergency_Contact_Last__c = 'testt';
        child3.Emergency_Contact_Relationship__c = 'Family';
        child3.Emergency_Contact_Phone__c = '9874561230';
        child3.Emergency_Contact_Cell_Phone__c = '8796541230';
        child3.Approved_Pick_Up_1__c = '1';
        child3.Approved_Pick_Up_2__c = '2';
        child3.Approved_Pick_Up_1_Relationship__c = 'Family';
        child3.Approved_Pick_Up_2_Relationship__c = 'Family';
        child3.Approved_Pick_Up_1_Phone__c = '8974563210';
        child3.Approved_Pick_Up_2_Phone__c = '8745963210';
        child3.Name_of_Primary_Parent_Guardian__c = parent1.Id;
        insert child3;

        String child3id = child3.id;*/

        Id AfterSchoolRecordTypeId = Schema.SObjectType.Program__c.getRecordTypeInfosByName().get('After School').getRecordTypeId();
       
        Program__c prgm = new Program__c();
        prgm.Name = 'Program1';
        prgm.RecordTypeId = AfterSchoolRecordTypeId;
        insert prgm;
        
        Campaign campaign = new Campaign();
        campaign.Name = 'Campaign1';
        campaign.Program__c = prgm.Id;        
        insert campaign;        
    }
        

    @isTest static void getPicklistValuesTest(){
        List<RegistrationFormController.optionWrapper> optionsList = RegistrationFormController.getPicklistValues('Account','Type');
        system.assert(optionsList.size()>0, 'got picklist values!');
    }
    
       
    @isTest static void getPageLoadDataGivenParent1OnlyTest(){
        Contact parent1 = [Select Id From Contact Where LastName = 'Murthy' limit 1];
        Campaign campaign = [Select Id From Campaign limit 1];        
        RegistrationFormController.ggFormWrapper  data = RegistrationFormController.getPageLoadData(parent1.Id, campaign.Id);        
    }
       
    @isTest static void getPageLoadDataWithParent1AndParent2Test(){
        Contact parent1 = [Select Id,AccountId From Contact Where LastName = 'Murthy' limit 1];
        Campaign campaign = [Select Id From Campaign limit 1];   
        
        Id ParentRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
        Contact parent2 = RegistrationFormControllerTest.getParent2();
        parent2.AccountId = parent1.AccountId;
        parent2.RecordTypeId = ParentRecordTypeId;
        insert parent2;
        RegistrationFormController.ggFormWrapper  data = RegistrationFormController.getPageLoadData(parent1.Id, campaign.Id);
        
    }
    

    @isTest static void getPageLoadDataChild1Test(){
        Contact parent1 = [Select Id,AccountId From Contact Where LastName = 'Murthy' limit 1];
        Campaign campaign = [Select Id From Campaign limit 1];   

        Contact child1 = new Contact();
        child1.FirstName = 'Satya';
        child1.LastName = 'Satya';
        child1.Name_of_Primary_Parent_Guardian__c = parent1.Id;
		insert child1;
         
        RegistrationFormController.ggFormWrapper  data = RegistrationFormController.getPageLoadData(parent1.Id, campaign.Id);
        
    }
    
    @isTest static void getPageLoadDataChild2Test(){
        Contact parent1 = [Select Id,AccountId From Contact Where LastName = 'Murthy' limit 1];
        Campaign campaign = [Select Id From Campaign limit 1];
        Account school1 = [Select Id from Account Where Name = 'School1' LIMIT 1];

        Id ChildRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child').getRecordTypeId();

        Contact child1 = new Contact();
        child1.FirstName = 'Satya';
        child1.LastName = 'Satya';
        child1.AccountId = parent1.AccountId;
        child1.RecordTypeId = ChildRecordTypeId; 
        child1.Name_of_Primary_Parent_Guardian__c = parent1.Id;
		insert child1;

        Contact child2 = new Contact();
        child2.AccountId = parent1.AccountId;
        child2.FirstName = 'N2';
        child2.LastName = 'Pasalapudi';
        child2.RecordTypeId = ChildRecordTypeId; 
        child2.Birthdate = Date.today();
        child2.SSN__c = '102';
        child2.School__c = school1.Id;
        child2.Grade__c = '1';
        child2.Physician_Name__c = 'Test';
        child2.Physician__c = 'Testt';
        child2.Insurance_Number__c = 100000;
        child2.Most_Recent_Physical__c = Date.today();
        child2.Most_Recent_Vision_Exam__c = Date.today();
        child2.Most_Recent_Hearing_Exam__c = Date.today();
        child2.Most_Recent_Dental_Exam__c = Date.today();
        child2.Operations_Injuries__c = 'Test';
        child2.Medical_Needs__c = 'Test';
        child2.Medications__c = 'Test';
        child2.Takes_Medication__c = 'Inconsistent';
        child2.Physicians_Advice__c = 'Test';
        child2.Had_illness__c = 'Mumps';
        child2.MH_History_Detailed__c = 'Test';
        child2.Allergies_Detailed__c = 'Test';
        child2.Allergies__c = 'Medicine';
        child2.Child_will_Attend_Afterschool__c = 'Monday';
        child2.Emergency_Contact_First__c = 'test';
        child2.Emergency_Contact_Last__c = 'testt';
        child2.Emergency_Contact_Relationship__c = 'Family';
        child2.Emergency_Contact_Phone__c = '9874561230';
        child2.Emergency_Contact_Cell_Phone__c = '8796541230';
        child2.Approved_Pick_Up_1__c = '1';
        child2.Approved_Pick_Up_2__c = '2';
        child2.Approved_Pick_Up_1_Relationship__c = 'Family';
        child2.Approved_Pick_Up_2_Relationship__c = 'Family';
        child2.Approved_Pick_Up_1_Phone__c = '8974563210';
        child2.Approved_Pick_Up_2_Phone__c = '8745963210';
        child2.Name_of_Primary_Parent_Guardian__c = parent1.Id;
		insert child2;
         
        RegistrationFormController.ggFormWrapper  data = RegistrationFormController.getPageLoadData(parent1.Id, campaign.Id);
        
    }    

    @isTest static void getPageLoadDataChild3Test(){
        Contact parent1 = [Select Id,AccountId From Contact Where LastName = 'Murthy' limit 1];
        Campaign campaign = [Select Id From Campaign limit 1];
        Account school1 = [Select Id from Account Where Name = 'School1' LIMIT 1];

        Id ChildRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child').getRecordTypeId();
        
        Contact child1 = new Contact();
        child1.AccountId = parent1.AccountId;
        child1.RecordTypeId = ChildRecordTypeId; 
        child1.FirstName = 'Satya';
        child1.LastName = 'Satya';
        child1.Name_of_Primary_Parent_Guardian__c = parent1.Id;
		insert child1;

        Form__c form = new Form__c();
        form.Client__c = child1.Id;
        insert form;
        
        Contact child2 = new Contact();
        child2.AccountId = parent1.AccountId;
        child2.RecordTypeId = ChildRecordTypeId; 
        child2.FirstName = 'Sai';
        child2.LastName = 'Sri';
        child2.Name_of_Primary_Parent_Guardian__c = parent1.Id;
		insert child2;

        Form__c form2 = new Form__c();
        form2.Client__c = child2.Id;
        insert form2;

        Contact child3 = new Contact();
        child3.AccountId = parent1.AccountId;
        child3.FirstName = 'N3';
        child3.LastName = 'Pasalapudi';
        child3.RecordTypeId = ChildRecordTypeId; 
        child3.Birthdate = Date.today();
        child3.SSN__c = '103';
        child3.School__c = school1.Id;
        child3.Grade__c = '1';
        child3.Physician_Name__c = 'Test';
        child3.Physician__c = 'Testt';
        child3.Insurance_Number__c = 100000;
        child3.Most_Recent_Physical__c = Date.today();
        child3.Most_Recent_Vision_Exam__c = Date.today();
        child3.Most_Recent_Hearing_Exam__c = Date.today();
        child3.Most_Recent_Dental_Exam__c = Date.today();
        child3.Operations_Injuries__c = 'Test';
        child3.Medical_Needs__c = 'Test';
        child3.Medications__c = 'Test';
        child3.Takes_Medication__c = 'Inconsistent';
        child3.Physicians_Advice__c = 'Test';
        child3.Had_illness__c = 'Mumps';
        child3.MH_History_Detailed__c = 'Test';
        child3.Allergies_Detailed__c = 'Test';
        child3.Allergies__c = 'Medicine';
        child3.Child_will_Attend_Afterschool__c = 'Monday';
        child3.Emergency_Contact_First__c = 'test';
        child3.Emergency_Contact_Last__c = 'testt';
        child3.Emergency_Contact_Relationship__c = 'Family';
        child3.Emergency_Contact_Phone__c = '9874561230';
        child3.Emergency_Contact_Cell_Phone__c = '8796541230';
        child3.Approved_Pick_Up_1__c = '1';
        child3.Approved_Pick_Up_2__c = '2';
        child3.Approved_Pick_Up_1_Relationship__c = 'Family';
        child3.Approved_Pick_Up_2_Relationship__c = 'Family';
        child3.Approved_Pick_Up_1_Phone__c = '8974563210';
        child3.Approved_Pick_Up_2_Phone__c = '8745963210';
        child3.Name_of_Primary_Parent_Guardian__c = parent1.Id;
		insert child3;

        Form__c form3 = new Form__c();
        form3.Client__c = child3.Id;
        insert form3;
         
        RegistrationFormController.ggFormWrapper  data = RegistrationFormController.getPageLoadData(parent1.Id, campaign.Id);
        
    }    

    
    public static Contact getParent2(){
        Contact parent2 = new Contact();
        parent2.FirstName = 'N';
        parent2.LastName = 'Mother';
        parent2.Primary_Guardian_Relationship__c = 'Father';
        parent2.PIN__c = '765673';
        parent2.MailingStreet = 'Nehru Street';
        parent2.MailingCity = 'kkd';
        parent2.MailingState = 'AP';
        parent2.MailingPostalCode = '533004';
        parent2.Place_of_Employment__c = 'kkd';
        parent2.Phone = '7652345672';
        parent2.MobilePhone = '7652345672';
        parent2.npe01__WorkPhone__c = '7652345672';
        parent2.Email = 'sowndarya.nittala@diligentforeclabs.com';
        parent2.Household_Monthly_Income__c = 60000;
        parent2.Source_of_Income__c = 'Employment';
        parent2.Receive_Public_Assistance__c = 'Yes';
        parent2.Housing_Type__c = 'Apartment';
        parent2.Housing_Ownership__c = 'Rent';
        parent2.Time_In_Residence__c = 'test';
        return parent2;
    }        
    
    @isTest static void saveFormWithChild1Test(){		
        Contact child1 = new Contact();
        child1.FirstName = 'Satya';
        child1.LastName = 'Satya';
        Contact child2 = null;
        Contact child3 = null;
        string child1Id = '';
        string child2Id = '';
        string child3Id = '';
        
        Contact parent1 = [select id,accountId,FirstName,LastName,Primary_Guardian_Relationship__c,PIN__c,
                           MailingStreet, MailingCity, MailingState, MailingPostalCode,
                           Place_of_Employment__c,Phone, MobilePhone, npe01__WorkPhone__c,
                           Email,Household_Monthly_Income__c,
                           Source_of_Income__c,Receive_Public_Assistance__c, Housing_Type__c,
                           Housing_Ownership__c,Time_In_Residence__c 
                           From Contact Where LastName = 'Murthy' limit 1];

        string parent1Id = parent1.Id;
        string Parent1AccountId = parent1.AccountId;
        string parent2Id = '';
        
        Campaign campaign = [Select Id From Campaign limit 1];
        string campaignId = campaign.Id;
        
        CampaignMember campaignmember = new CampaignMember();
        CampaignMember.CampaignId = campaignId; 
        CampaignMember.ContactId = parent1Id;
        insert CampaignMember;

        string CampaignMemberId = CampaignMember.Id;
        
        Program__c prgm = [Select Id From Program__c limit 1];
        string programId = prgm.Id;

        Contact parent2 = RegistrationFormControllerTest.getParent2();
        String[] child1JSON;

        string msg = RegistrationFormController.saveForm(child1,child2,child3,parent1,parent2,
                                             child1Id,child2Id,child3Id, 
                                             parent1Id, parent2Id,
                                             Parent1AccountId,campaignId,CampaignMemberId,programId,'Sowndarya',child1JSON,'Test'); 
        //system.assert(msg=='Form Submitted', 'Form Submitted');        
    }
     
    @isTest static void saveFormWithChild2Test(){		
        Contact child2 = [select id,FirstName,
                          LastName,
                          Birthdate,
                          SSN__c,
                          Grade__c,
                          Physician_Name__c,
                          Physician__c,
                          Insurance_Number__c,
                          Most_Recent_Physical__c,
                          Most_Recent_Vision_Exam__c,
                          Most_Recent_Hearing_Exam__c,
                          Most_Recent_Dental_Exam__c,
                          Operations_Injuries__c,
                          Medical_Needs__c,
                          Medications__c,
                          Takes_Medication__c,
                          Physicians_Advice__c,
                          Had_illness__c,
                          Allergies_Detailed__c,
                          Allergies__c,
                          Child_will_Attend_Afterschool__c,
                          Primary_Guardian_Relationship__c,
                          Place_of_Employment__c,
                          Phone,
                          MobilePhone,
                          Email,
                          Household_Monthly_Income__c,
                          Source_of_Income__c,
                          Receive_Public_Assistance__c,
                          Housing_Type__c,
                          Housing_Ownership__c,
                          Time_In_Residence__c,
                          Emergency_Contact_First__c,
                          Emergency_Contact_Last__c,
                          Emergency_Contact_Relationship__c,
                          Emergency_Contact_Phone__c,
                          Emergency_Contact_Cell_Phone__c,
                          Approved_Pick_Up_1__c,
                          Approved_Pick_Up_2__c,
                          Approved_Pick_Up_1_Relationship__c,
                          Approved_Pick_Up_2_Relationship__c,
                          Approved_Pick_Up_1_Phone__c,
                          Approved_Pick_Up_2_Phone__c
                          from Contact where LastName='Pasalapudi' AND FirstName='N1' limit 1 ];

        /*child2.FirstName = 'Sri';
        child2.LastName = 'Sai';*/
        Contact child1 = null;
        Contact child3 = null;
        string child1Id = '';
        string child2Id = '';
        string child3Id = '';
        
        Contact parent1 = [select id,accountId,FirstName,LastName,Primary_Guardian_Relationship__c,PIN__c,
                           MailingStreet, MailingCity, MailingState, MailingPostalCode,
                           Place_of_Employment__c,Phone, MobilePhone, npe01__WorkPhone__c,
                           Email,Household_Monthly_Income__c,
                           Source_of_Income__c,Receive_Public_Assistance__c, Housing_Type__c,
                           Housing_Ownership__c,Time_In_Residence__c 
                           From Contact Where LastName = 'Murthy' limit 1];

                           Id ChildRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child').getRecordTypeId();
                           Contact childx = new Contact();
                           childx.AccountId = parent1.AccountId;
                           childx.FirstName = 'x';
                           childx.LastName = 'Murthy';
                           childx.RecordTypeId = ChildRecordTypeId; 
                           childx.Birthdate = Date.today();
                           childx.SSN__c = 'x101';
                           //childx.School__c = school1.Id;
                           childx.Grade__c = '1';
                           childx.Physician_Name__c = 'Test';
                           childx.Physician__c = 'Testt';
                           childx.Insurance_Number__c = 100000;
                           childx.Most_Recent_Physical__c = Date.today();
                           childx.Most_Recent_Vision_Exam__c = Date.today();
                           childx.Most_Recent_Hearing_Exam__c = Date.today();
                           childx.Most_Recent_Dental_Exam__c = Date.today();
                           childx.Operations_Injuries__c = 'Test';
                           childx.Medical_Needs__c = 'Test';
                           childx.Medications__c = 'Test';
                           childx.Takes_Medication__c = 'Inconsistent';
                           childx.Physicians_Advice__c = 'Test';
                           childx.Had_illness__c = 'Mumps';
                           childx.MH_History_Detailed__c = 'Test';
                           childx.Allergies_Detailed__c = 'Test';
                           childx.Allergies__c = 'Medicine';
                           childx.Child_will_Attend_Afterschool__c = 'Monday';
                           childx.Emergency_Contact_First__c = 'test';
                           childx.Emergency_Contact_Last__c = 'testt';
                           childx.Emergency_Contact_Relationship__c = 'Family';
                           childx.Emergency_Contact_Phone__c = '9874561230';
                           childx.Emergency_Contact_Cell_Phone__c = '8796541230';
                           childx.Approved_Pick_Up_1__c = '1';
                           childx.Approved_Pick_Up_2__c = '2';
                           childx.Approved_Pick_Up_1_Relationship__c = 'Family';
                           childx.Approved_Pick_Up_2_Relationship__c = 'Family';
                           childx.Approved_Pick_Up_1_Phone__c = '8974563210';
                           childx.Approved_Pick_Up_2_Phone__c = '8745963210';
                           childx.Name_of_Primary_Parent_Guardian__c = parent1.Id;
                           insert childx;
                   

        string parent1Id = parent1.Id;
        string Parent1AccountId = parent1.AccountId;
        string parent2Id = '';
        
        Campaign campaign = [Select Id From Campaign limit 1];
        string campaignId = campaign.Id;
        Program__c prgm = [Select Id From Program__c limit 1];
        string programId = prgm.Id;
        
        CampaignMember campaignmember = new CampaignMember();
        CampaignMember.CampaignId = campaignId; 
        CampaignMember.ContactId = parent1Id;
        insert CampaignMember;
        string CampaignMemberId = CampaignMember.Id;

        String[] child1JSON;

        Contact parent2 = RegistrationFormControllerTest.getParent2();

        string msg = RegistrationFormController.saveForm(child1,childx,child3,parent1,parent2,
                                             child1Id,child2Id,child3Id, 
                                             parent1Id, parent2Id,
                                             Parent1AccountId,campaignId,CampaignMemberId,programId,'Sowndarya',child1JSON,'Test'); 
        //system.assert(msg=='Form Submitted', 'Form Submitted');        
    }
    
    @isTest static void saveFormWithChild3Test(){		
         Contact child3 = [select id,FirstName,
                          LastName,
                          Birthdate,
                          SSN__c,
                          Grade__c,
                          Physician_Name__c,
                          Physician__c,
                          Insurance_Number__c,
                          Most_Recent_Physical__c,
                          Most_Recent_Vision_Exam__c,
                          Most_Recent_Hearing_Exam__c,
                          Most_Recent_Dental_Exam__c,
                          Operations_Injuries__c,
                          Medical_Needs__c,
                          Medications__c,
                          Takes_Medication__c,
                          Physicians_Advice__c,
                          Had_illness__c,
                          Allergies_Detailed__c,
                          Allergies__c,
                          Child_will_Attend_Afterschool__c,
                          Primary_Guardian_Relationship__c,
                          Place_of_Employment__c,
                          Phone,
                          MobilePhone,
                          Email,
                          Household_Monthly_Income__c,
                          Source_of_Income__c,
                          Receive_Public_Assistance__c,
                          Housing_Type__c,
                          Housing_Ownership__c,
                          Time_In_Residence__c,
                          Emergency_Contact_First__c,
                          Emergency_Contact_Last__c,
                          Emergency_Contact_Relationship__c,
                          Emergency_Contact_Phone__c,
                          Emergency_Contact_Cell_Phone__c,
                          Approved_Pick_Up_1__c,
                          Approved_Pick_Up_2__c,
                          Approved_Pick_Up_1_Relationship__c,
                          Approved_Pick_Up_2_Relationship__c,
                          Approved_Pick_Up_1_Phone__c,
                          Approved_Pick_Up_2_Phone__c
                          from Contact where LastName='Pasalapudi' AND FirstName = 'N1' limit 1 ];

                          Contact parent1 = [select id,accountId,FirstName,LastName,Primary_Guardian_Relationship__c,PIN__c,
                           MailingStreet, MailingCity, MailingState, MailingPostalCode,
                           Place_of_Employment__c,Phone, MobilePhone, npe01__WorkPhone__c,
                           Email,Household_Monthly_Income__c,
                           Source_of_Income__c,Receive_Public_Assistance__c, Housing_Type__c,
                           Housing_Ownership__c,Time_In_Residence__c 
                           From Contact Where LastName = 'Murthy' limit 1];

                          Id ChildRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child').getRecordTypeId();
                          Contact childy = new Contact();
                          childy.AccountId = parent1.AccountId;
                          childy.FirstName = 'N1';
                          childy.LastName = 'Pasalapudi';
                          childy.RecordTypeId = ChildRecordTypeId; 
                          childy.Birthdate = Date.today();
                          childy.SSN__c = '101';
                          //childy.School__c = school1.Id;
                          childy.Grade__c = '1';
                          childy.Physician_Name__c = 'Test';
                          childy.Physician__c = 'Testt';
                          childy.Insurance_Number__c = 100000;
                          childy.Most_Recent_Physical__c = Date.today();
                          childy.Most_Recent_Vision_Exam__c = Date.today();
                          childy.Most_Recent_Hearing_Exam__c = Date.today();
                          childy.Most_Recent_Dental_Exam__c = Date.today();
                          childy.Operations_Injuries__c = 'Test';
                          childy.Medical_Needs__c = 'Test';
                          childy.Medications__c = 'Test';
                          childy.Takes_Medication__c = 'Inconsistent';
                          childy.Physicians_Advice__c = 'Test';
                          childy.Had_illness__c = 'Mumps';
                          childy.MH_History_Detailed__c = 'Test';
                          childy.Allergies_Detailed__c = 'Test';
                          childy.Allergies__c = 'Medicine';
                          childy.Child_will_Attend_Afterschool__c = 'Monday';
                          childy.Emergency_Contact_First__c = 'test';
                          childy.Emergency_Contact_Last__c = 'testt';
                          childy.Emergency_Contact_Relationship__c = 'Family';
                          childy.Emergency_Contact_Phone__c = '9874561230';
                          childy.Emergency_Contact_Cell_Phone__c = '8796541230';
                          childy.Approved_Pick_Up_1__c = '1';
                          childy.Approved_Pick_Up_2__c = '2';
                          childy.Approved_Pick_Up_1_Relationship__c = 'Family';
                          childy.Approved_Pick_Up_2_Relationship__c = 'Family';
                          childy.Approved_Pick_Up_1_Phone__c = '8974563210';
                          childy.Approved_Pick_Up_2_Phone__c = '8745963210';
                          childy.Name_of_Primary_Parent_Guardian__c = parent1.Id;
                          insert childy;



       /* child3.FirstName = 'Sri';
        child3.LastName = 'Sai';*/
        Contact child1 = null;
        Contact child2 = null;
        string child1Id = '';
        string child2Id = '';
        string child3Id = '';
        
        string parent1Id = parent1.Id;
        string Parent1AccountId = parent1.AccountId;
        string parent2Id = '';
        
        Campaign campaign = [Select Id From Campaign limit 1];
        string campaignId = campaign.Id;
        Program__c prgm = [Select Id From Program__c limit 1];
        string programId = prgm.Id;
        
        CampaignMember campaignmember = new CampaignMember();
        CampaignMember.CampaignId = campaignId; 
        CampaignMember.ContactId = parent1Id;
        insert CampaignMember;
        string CampaignMemberId = CampaignMember.Id;
         String[] child1JSON;
        Contact parent2 = RegistrationFormControllerTest.getParent2();
        string msg = RegistrationFormController.saveForm(child1,child2,childy,parent1,parent2,
                                             child1Id,child2Id,child3Id, 
                                             parent1Id, parent2Id,
                                             Parent1AccountId,campaignId,CampaignMemberId,programId,'Sowndarya',child1JSON,'Test'); 
    }     
    
    @isTest static void saveFormWithChild1UpdateTest(){		
        
        Account school1 = [select Id,Name,Type 
                           from Account 
                           where Name='School1' limit 1
						  ];        
        
        
        Contact child = new Contact();
        child.FirstName = 'Satya';
        child.LastName = 'Satya';
        insert child;

        Contact child1 = [select Id, FirstName,LastName,Birthdate,Age__c,
                          SSN__c,Grade__c ,School__c,Physician_Name__c,
                          Most_Recent_Physical__c,Most_Recent_Vision_Exam__C,
                          Most_Recent_Hearing_Exam__C,Physician__c,
                          Most_Recent_Dental_Exam__c,Operations_Injuries__c,
                          Medical_Needs__c,Insurance_Number__c,
                          Medications__c, Takes_Medication__c ,
                          Physicians_Advice__c,
                          Had_illness__c , MH_History_Detailed__c, Allergies__c ,
                          Allergies_Detailed__c,Emergency_Contact_First__c,
                          Emergency_Contact_Last__c,Emergency_Contact_Relationship__c,
                          Emergency_Contact_Phone__c, Emergency_Contact_Cell_Phone__c,
                          Approved_Pick_Up_1__c, Approved_Pick_Up_2__c, 
                          Approved_Pick_Up_1_Relationship__c,
                          Approved_Pick_Up_2_Relationship__c, Approved_Pick_Up_1_Phone__c,
                          Approved_Pick_Up_2_Phone__c
                          From Contact 
                          Where Id=:child.Id limit 1];
        child1.SSN__c = '12345';
        child1.School__c = school1.Id; 
        
         Contact child2 = [select id,FirstName,
                          LastName,
                          Birthdate,
                          SSN__c,
                          Grade__c,
                          Physician_Name__c,
                          Physician__c,
                          Insurance_Number__c,
                          Most_Recent_Physical__c,
                          Most_Recent_Vision_Exam__c,
                          Most_Recent_Hearing_Exam__c,
                          Most_Recent_Dental_Exam__c,
                          Operations_Injuries__c,
                          Medical_Needs__c,
                          Medications__c,
                          Takes_Medication__c,
                          Physicians_Advice__c,
                          Had_illness__c,
                          Allergies_Detailed__c,
                          Allergies__c,
                          Child_will_Attend_Afterschool__c,
                          Primary_Guardian_Relationship__c,
                          Place_of_Employment__c,
                          Phone,
                          MobilePhone,
                          Email,
                          Household_Monthly_Income__c,
                          Source_of_Income__c,
                          Receive_Public_Assistance__c,
                          Housing_Type__c,
                          Housing_Ownership__c,
                          Time_In_Residence__c,
                          Emergency_Contact_First__c,
                          Emergency_Contact_Last__c,
                          Emergency_Contact_Relationship__c,
                          Emergency_Contact_Phone__c,
                          Emergency_Contact_Cell_Phone__c,
                          Approved_Pick_Up_1__c,
                          Approved_Pick_Up_2__c,
                          Approved_Pick_Up_1_Relationship__c,
                          Approved_Pick_Up_2_Relationship__c,
                          Approved_Pick_Up_1_Phone__c,
                          Approved_Pick_Up_2_Phone__c
                          from Contact where LastName='Pasalapudi' AND FirstName ='N1' limit 1 ];

        Contact child3 = null;
        string child1Id = child1.Id;
        string child2Id = '';
        string child3Id = '';
        
        Contact parent1 = [select id,accountId,FirstName,LastName,Primary_Guardian_Relationship__c,PIN__c,
                           MailingStreet, MailingCity, MailingState, MailingPostalCode,
                           Place_of_Employment__c,Phone, MobilePhone, npe01__WorkPhone__c,
                           Email,Household_Monthly_Income__c,
                           Source_of_Income__c,Receive_Public_Assistance__c, Housing_Type__c,
                           Housing_Ownership__c,Time_In_Residence__c 
                           From Contact Where LastName = 'Murthy' limit 1];

        string parent1Id = parent1.Id;
        string Parent1AccountId = parent1.AccountId;
        string parent2Id = '';
        
        Campaign campaign = [Select Id From Campaign limit 1];
        string campaignId = campaign.Id;
        
        CampaignMember campaignmember = new CampaignMember();
        CampaignMember.CampaignId = campaignId; 
        CampaignMember.ContactId = parent1Id;
        insert CampaignMember;

        string CampaignMemberId = CampaignMember.Id;
        String[] child1JSON;

        Program__c prgm = [Select Id From Program__c limit 1];
        string programId = prgm.Id;
        Contact parent2 = RegistrationFormControllerTest.getParent2();

        string msg = RegistrationFormController.saveForm(child1,child2,child3,parent1,parent2,
                                             child1Id,child2Id,child3Id, 
                                             parent1Id, parent2Id,
                                             Parent1AccountId,campaignId,CampaignMemberId,programId,'Sowndarya',child1JSON,'Test');

       //system.assert(msg=='Form Submitted', 'Form Submitted!');
    }   
    
    @isTest static void saveFormWithChild2UpdateTest(){		
        
        Account school2 = [select Id,Name,Type 
                           from Account 
                           where Name='School2' limit 1
						  ];        
        
        
        Contact child = new Contact();
        child.FirstName = 'Sai';
        child.LastName = 'Sri';
        insert child;
        Contact child2 = [select Id, FirstName,LastName,Birthdate,Age__c,
                          SSN__c,Grade__c ,School__c,Physician_Name__c,
                          Most_Recent_Physical__c,Most_Recent_Vision_Exam__C,
                          Most_Recent_Hearing_Exam__C,Physician__c,
                          Most_Recent_Dental_Exam__c,Operations_Injuries__c,
                          Medical_Needs__c,Insurance_Number__c,Insurance_Provider__c,
                          Medications__c, Takes_Medication__c ,
                          Physicians_Advice__c,
                          Had_illness__c , MH_History_Detailed__c, Allergies__c ,
                          Allergies_Detailed__c,Emergency_Contact_First__c,
                          Emergency_Contact_Last__c,Emergency_Contact_Relationship__c,
                          Emergency_Contact_Phone__c, Emergency_Contact_Cell_Phone__c,
                          Approved_Pick_Up_1__c, Approved_Pick_Up_2__c, 
                          Approved_Pick_Up_1_Relationship__c,
                          Approved_Pick_Up_2_Relationship__c, Approved_Pick_Up_1_Phone__c,
                          Approved_Pick_Up_2_Phone__c
                          From Contact 
                          Where LastName='Pasalapudi' limit 1];

        child2.SSN__c = '12345';
        child2.School__c = school2.Id; 
        
        Contact child1 = null;
        Contact child3 = null;
        string child1Id = '';
        string child2Id = child2.Id;
        string child3Id = '';
        
        Contact parent1 = [select id,accountId,FirstName,LastName,Primary_Guardian_Relationship__c,PIN__c,
                           MailingStreet, MailingCity, MailingState, MailingPostalCode,
                           Place_of_Employment__c,Phone, MobilePhone, npe01__WorkPhone__c,
                           Email,Household_Monthly_Income__c,
                           Source_of_Income__c,Receive_Public_Assistance__c, Housing_Type__c,
                           Housing_Ownership__c,Time_In_Residence__c 
                           From Contact Where LastName = 'Murthy' limit 1];
        string parent1Id = parent1.Id;
        string Parent1AccountId = parent1.AccountId;
        string parent2Id = '';
        
        Campaign campaign = [Select Id From Campaign limit 1];
        string campaignId = campaign.Id;
        
        CampaignMember campaignmember = new CampaignMember();
        CampaignMember.CampaignId = campaignId; 
        CampaignMember.ContactId = parent1Id;
        insert CampaignMember;
        string CampaignMemberId = CampaignMember.Id;
         String[] child1JSON;
        Program__c prgm = [Select Id From Program__c limit 1];
        string programId = prgm.Id;
        Contact parent2 = RegistrationFormControllerTest.getParent2();
        string msg = RegistrationFormController.saveForm(child1,child2,child3,parent1,parent2,
                                             child1Id,child2Id,child3Id, 
                                             parent1Id, parent2Id,
                                             Parent1AccountId,campaignId,CampaignMemberId,programId,'Sowndarya',child1JSON,'Test'); 
        //system.assert(msg=='Form Submitted', 'Form Submitted!');        
    }
    
    @isTest static void saveFormWithChild3UpdateTest(){		
        
        Account school3 = [select Id,Name,Type 
                           from Account 
                           where Name='School3' limit 1
						  ];        
        
        
       Contact child = [select id,FirstName,
                          LastName,
                          Birthdate,
                          SSN__c,
                          Grade__c,
                          Physician_Name__c,
                          Physician__c,
                          Insurance_Number__c,
                          Most_Recent_Physical__c,
                          Most_Recent_Vision_Exam__c,
                          Most_Recent_Hearing_Exam__c,
                          Most_Recent_Dental_Exam__c,
                          Operations_Injuries__c,
                          Medical_Needs__c,
                          Medications__c,
                          Takes_Medication__c,
                          Physicians_Advice__c,
                          Had_illness__c,
                          Allergies_Detailed__c,
                          Allergies__c,
                          Child_will_Attend_Afterschool__c,
                          Primary_Guardian_Relationship__c,
                          Place_of_Employment__c,
                          Phone,
                          MobilePhone,
                          Email,
                          Household_Monthly_Income__c,
                          Source_of_Income__c,
                          Receive_Public_Assistance__c,
                          Housing_Type__c,
                          Housing_Ownership__c,
                          Time_In_Residence__c,
                          Emergency_Contact_First__c,
                          Emergency_Contact_Last__c,
                          Emergency_Contact_Relationship__c,
                          Emergency_Contact_Phone__c,
                          Emergency_Contact_Cell_Phone__c,
                          Approved_Pick_Up_1__c,
                          Approved_Pick_Up_2__c,
                          Approved_Pick_Up_1_Relationship__c,
                          Approved_Pick_Up_2_Relationship__c,
                          Approved_Pick_Up_1_Phone__c,
                          Approved_Pick_Up_2_Phone__c
                          from Contact where LastName='Pasalapudi' limit 1 ];

        Contact child3 = [select id,FirstName,
        LastName,
        Birthdate,
        SSN__c,
        Grade__c,
        Physician_Name__c,
        Physician__c,
        Insurance_Number__c,
        Most_Recent_Physical__c,
        Most_Recent_Vision_Exam__c,
        Most_Recent_Hearing_Exam__c,
        Most_Recent_Dental_Exam__c,
        Operations_Injuries__c,
        Medical_Needs__c,
        Medications__c,
        Takes_Medication__c,
        Physicians_Advice__c,
        Had_illness__c,
        Allergies_Detailed__c,
        Allergies__c,
        Child_will_Attend_Afterschool__c,
        Primary_Guardian_Relationship__c,
        Place_of_Employment__c,
        Phone,
        MobilePhone,
        Email,
        Household_Monthly_Income__c,
        Source_of_Income__c,
        Receive_Public_Assistance__c,
        Housing_Type__c,
        Housing_Ownership__c,
        Time_In_Residence__c,
        Emergency_Contact_First__c,
        Emergency_Contact_Last__c,
        Emergency_Contact_Relationship__c,
        Emergency_Contact_Phone__c,
        Emergency_Contact_Cell_Phone__c,
        Approved_Pick_Up_1__c,
        Approved_Pick_Up_2__c,
        Approved_Pick_Up_1_Relationship__c,
        Approved_Pick_Up_2_Relationship__c,
        Approved_Pick_Up_1_Phone__c,
        Approved_Pick_Up_2_Phone__c
        From Contact 
        Where LastName='Pasalapudi' limit 1];

        child3.SSN__c = '12345';
        child3.School__c = school3.Id; 
        
        Contact child1 = null;
        Contact child2 = null;
        string child1Id = '';
        string child2Id = '';
        string child3Id = child3.Id;
        
        Contact parent1 = [select id,accountId,FirstName,LastName,Primary_Guardian_Relationship__c,PIN__c,
                           MailingStreet, MailingCity, MailingState, MailingPostalCode,
                           Place_of_Employment__c,Phone, MobilePhone, npe01__WorkPhone__c,
                           Email,Household_Monthly_Income__c,
                           Source_of_Income__c,Receive_Public_Assistance__c, Housing_Type__c,
                           Housing_Ownership__c,Time_In_Residence__c 
                           From Contact Where LastName = 'Murthy' limit 1];
        string parent1Id = parent1.Id;
        string Parent1AccountId = parent1.AccountId;
        string parent2Id = '';
        
        Campaign campaign = [Select Id From Campaign limit 1];
        string campaignId = campaign.Id;
        
        CampaignMember campaignmember = new CampaignMember();
        CampaignMember.CampaignId = campaignId; 
        CampaignMember.ContactId = parent1Id;
        insert CampaignMember;
        string CampaignMemberId = CampaignMember.Id;
         String[] child1JSON;
        Program__c prgm = [Select Id From Program__c limit 1];
        string programId = prgm.Id;
        Contact parent2 = RegistrationFormControllerTest.getParent2();
        string msg = RegistrationFormController.saveForm(child1,child2,child3,parent1,parent2,
                                             child1Id,child2Id,child3Id, 
                                             parent1Id, parent2Id,
                                             Parent1AccountId,campaignId,CampaignMemberId,programId,'Sowndarya',child1JSON,'Test'); 
    }
    
    
    @isTest static void saveFormWithParent2UpdateTest(){		
        
        Account school3 = [select Id,Name,Type 
                           from Account 
                           where Name='School3' limit 1
						  ];        
        
        Contact child = new Contact();
        child.FirstName = 'Sai';
        child.LastName = 'Sowmya';
        insert child;
        Contact child3 = [select Id, FirstName,LastName,Birthdate,Age__c,
                          SSN__c,Grade__c ,School__c,Physician_Name__c,
                          Most_Recent_Physical__c,Most_Recent_Vision_Exam__C,
                          Most_Recent_Hearing_Exam__C,Physician__c,
                          Most_Recent_Dental_Exam__c,Operations_Injuries__c,
                          Medical_Needs__c,Insurance_Number__c,
                          Medications__c, Takes_Medication__c ,
                          Physicians_Advice__c,
                          Had_illness__c , MH_History_Detailed__c, Allergies__c ,
                          Allergies_Detailed__c,Emergency_Contact_First__c,
                          Emergency_Contact_Last__c,Emergency_Contact_Relationship__c,
                          Emergency_Contact_Phone__c, Emergency_Contact_Cell_Phone__c,
                          Approved_Pick_Up_1__c, Approved_Pick_Up_2__c, 
                          Approved_Pick_Up_1_Relationship__c,
                          Approved_Pick_Up_2_Relationship__c, Approved_Pick_Up_1_Phone__c,
                          Approved_Pick_Up_2_Phone__c
                          From Contact 
                          Where Id=:child.Id limit 1];
        child3.SSN__c = '12345';
        child3.School__c = school3.Id; 
        
        Contact child1 = null;
        Contact child2 = null;
        string child1Id = '';
        string child2Id = '';
        string child3Id = child3.Id;
        
        Contact parent1 = [select id,accountId,FirstName,LastName,Primary_Guardian_Relationship__c,PIN__c,
                           MailingStreet, MailingCity, MailingState, MailingPostalCode,
                           Place_of_Employment__c,Phone, MobilePhone, npe01__WorkPhone__c,
                           Email,Household_Monthly_Income__c,
                           Source_of_Income__c,Receive_Public_Assistance__c, Housing_Type__c,
                           Housing_Ownership__c,Time_In_Residence__c 
                           From Contact Where LastName = 'Murthy' limit 1];
        string parent1Id = parent1.Id;
        string Parent1AccountId = parent1.AccountId;
        string parent2Id = '';
        
        Campaign campaign = [Select Id From Campaign limit 1];
        string campaignId = campaign.Id;
        
        CampaignMember campaignmember = new CampaignMember();
        CampaignMember.CampaignId = campaignId; 
        CampaignMember.ContactId = parent1Id;
        insert CampaignMember;
        string CampaignMemberId = CampaignMember.Id;
        
        Program__c prgm = [Select Id From Program__c limit 1];
        string programId = prgm.Id;
        Contact parent = RegistrationFormControllerTest.getParent2();
        insert parent;
        Contact parent2 = [select id,accountId,FirstName,LastName,Primary_Guardian_Relationship__c,PIN__c,
                           MailingStreet, MailingCity, MailingState, MailingPostalCode,
                           Place_of_Employment__c,Phone, MobilePhone, npe01__WorkPhone__c,
                           Email,Household_Monthly_Income__c,
                           Source_of_Income__c,Receive_Public_Assistance__c, Housing_Type__c,
                           Housing_Ownership__c,Time_In_Residence__c 
                           From Contact Where Id=:parent.Id limit 1];
        parent2Id = parent2.Id; 
        parent2.Place_of_Employment__c = 'vizag';
         String[] child1JSON;
        string msg = RegistrationFormController.saveForm(child1,child2,child3,parent1,parent2,
                                             child1Id,child2Id,child3Id, 
                                             parent1Id, parent2Id,
                                             Parent1AccountId,campaignId,CampaignMemberId,programId,'Sowndarya',child1JSON,'Test'); 
        RegistrationFormController.replaceTime(Date.today());
    }    
    
    
    
    
    
}