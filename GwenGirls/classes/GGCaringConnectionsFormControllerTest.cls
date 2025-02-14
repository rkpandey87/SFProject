@isTest
public class GGCaringConnectionsFormControllerTest {
 
    
    
    @isTest
    static void testGetPrimaryConcrnExpanMultiPicklistVal() {
        
        // Call the method to be tested
        List<GGCaringConnectionsFormController.WrapperAllValues> result = GGCaringConnectionsFormController.getPrimaryConcrnExpanMultiPicklistVal();
    }
    
     @isTest
    static void testGetWrapperValues() {
        // Test data
        String testLabel = 'Test Label';
        String testValue = 'Test Value';

        // Call the method to be tested
        GGCaringConnectionsFormController.WrapperAllValues result = GGCaringConnectionsFormController.getWrapperValues(testLabel, testValue); 
    }
    
    @isTest
    static void testGetSecConcernExpanMultiPicklistVal() {
        
        // Call the method to be tested
        List<GGCaringConnectionsFormController.WrapperAllValues> result = GGCaringConnectionsFormController.getSecConcernExpanMultiPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result1 = GGCaringConnectionsFormController.getThirdConcernExpanMultiPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result2 = GGCaringConnectionsFormController.getNeedCategoryExpanMultiPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result3 = GGCaringConnectionsFormController.getPrevSystemInvolveExpanMultiPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result4 = GGCaringConnectionsFormController.getGenderIdentityPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result5 = GGCaringConnectionsFormController.getRacialEthnicIdentityPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result6 = GGCaringConnectionsFormController.getGenderPronounsPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result7 = GGCaringConnectionsFormController.getPrimaryConcrnPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result8 = GGCaringConnectionsFormController.getSecondaryConcernPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result9 = GGCaringConnectionsFormController.getThirdConcernPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result10 = GGCaringConnectionsFormController.getImmedSafetyConcernPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result11 = GGCaringConnectionsFormController.getSafetyPlanPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result12 = GGCaringConnectionsFormController.getParentGuardianPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result13 = GGCaringConnectionsFormController.getConsentToParticipatePicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result14 = GGCaringConnectionsFormController.getYouth14ConsentPicklistVal();
        List<GGCaringConnectionsFormController.WrapperAllValues> result15 = GGCaringConnectionsFormController.getGuardianMailingStatePicklistVal();
        List<String> result16 = GGCaringConnectionsFormController.getNeighborhoodPicklistVal();
        List<GGCaringConnectionsFormController.wrapperList> result17 = GGCaringConnectionsFormController.getAllUsers();
    
    }
    
    
     @isTest
    static void testReturnChildRecList() {
        
        Id accountRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
        Id accountRecordTypeId1 = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child (CC)').getRecordTypeId();           // Create test data, for example, a parent record
        Contact parentRecord = new Contact(
            FirstName = 'TestParent',
            LastName = 'TestLast'

        );
        insert parentRecord;

        // Mocking the data returned by your picklist methods
        // Assuming getGenderIdentityPicklistVal(), getRacialEthnicIdentityPicklistVal(), etc., methods are present in your code
        // Create and insert the necessary records for these picklists

        // Create a child record related to the parent
        Contact childRecord = new Contact(
            FirstName = 'TestChild',
            LastName = 'TestLast',
            Name_of_Primary_Parent_Guardian__c = parentRecord.Id,
            RecordTypeId = accountRecordTypeId1
        );
        insert childRecord;

        // Instantiate the class
        GGCaringConnectionsFormController yourClassInstance = new GGCaringConnectionsFormController();

        // Call the method to be tested
        List<GGCaringConnectionsFormController.wrapperList> result = GGCaringConnectionsFormController.returnChildRecList(parentRecord.Id);

        
    }
    
    @isTest
    static void testReturnChildRecList1() {
       Id accountRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
        Id accountRecordTypeId1 = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child (CC)').getRecordTypeId();        
        // Create test data, for example, a parent record
        Contact parentRecord = new Contact(
            FirstName = 'TestParent',
            LastName = 'TestLast'

        );
        insert parentRecord;

        // Mocking the data returned by your picklist methods
        // Assuming getGenderIdentityPicklistVal(), getRacialEthnicIdentityPicklistVal(), etc., methods are present in your code
        // Create and insert the necessary records for these picklists

        // Create a child record related to the parent
        Contact childRecord = new Contact(
            FirstName = 'TestChild',
            LastName = 'TestLast',
           // Name_of_Primary_Parent_Guardian__c = parentRecord.Id,
            RecordTypeId = accountRecordTypeId1
        );
        insert childRecord;

        // Instantiate the class
        GGCaringConnectionsFormController yourClassInstance = new GGCaringConnectionsFormController();

        // Call the method to be tested
        List<GGCaringConnectionsFormController.wrapperList> result = GGCaringConnectionsFormController.returnChildRecList(parentRecord.Id);
        
    }
    
     @isTest
    static void testSaveIntakeRecord() {
        // Create test data as needed
        Contact testParentContact = new Contact(
            FirstName = 'TestParent',
            LastName = 'Contact',
            HomePhone = '1234567890',
            MailingStreet = '123 Test St',
            MailingCity = 'Test City',
            MailingState = 'TS',
            MailingPostalCode = '12345',
            npe01__HomeEmail__c = 'test@example.com',
            BestTimetoContactGuardian__c = 'Anytime'
        );
        insert testParentContact;

               String itemData = '[{"firstName":"ChildFirstName","lastName":"ChildLastName","Dob":"2000-01-01","gradeSelectedColumn":"10","schoolSelectedColumn":"SchoolA","parentfName":"ParentFirstName","parentlName":"ParentLastName","parentPhnNumber":"987-654-3210","childRecordId":"001000000000000AAA","caseId":"500000000000000AAA"}]';


        // Call the method to be tested
        Test.startTest();
        GGCaringConnectionsFormController.saveIntakeRecord(itemData, null, testParentContact.Id, null, null,null);
        Test.stopTest();

       
    }
    
     @isTest
    static void testSaveIntakeRecord1() {
        // Create test data as needed
        Contact testParentContact = new Contact(
            FirstName = 'TestParent',
            LastName = 'Contact',
            HomePhone = '1234567890',
            MailingStreet = '123 Test St',
            MailingCity = 'Test City',
            MailingState = 'TS',
            MailingPostalCode = '12345',
            npe01__HomeEmail__c = 'test@example.com',
            BestTimetoContactGuardian__c = 'Anytime'
        );
        insert testParentContact;

               String itemData = '[{"firstName":"ChildFirstName","lastName":"ChildLastName","Dob":"2000-01-01","gradeSelectedColumn":"10","schoolSelectedColumn":"SchoolA","parentfName":"ParentFirstName","parentlName":"ParentLastName","parentPhnNumber":"987-654-3210","reasonForReferralMultiPickSelectedColumn":"hhfn","thirdConcernMultiPickSelectedColumn":"bgg","cyfFamilyCase":"3663","primaryConcrnMultiPickSelectedColumn":"fghc","secondaryConcernMultiPickSelectedColumn":"ffffg","previousSystemInvolveMultiPickSelectedColumn":"dfdj","parentMailingStreet":"fhfv","parentMailingCity":"fhcg","guardianMailingStateSelectedColumn":"cchc","parentMailingPostalCode":"5445"}]';


        // Call the method to be tested
        Test.startTest();
        GGCaringConnectionsFormController.saveIntakeRecord(itemData, null, null, null, null,null);
        Test.stopTest();
        
        
    }
    
    
     @isTest
    static void testSaveIntakeRecord2() {
         Contact testParentContact = new Contact(
            FirstName = 'TestParent1',
            LastName = 'Contact1',
            HomePhone = '1234567890',
            MailingStreet = '123 Test St',
            MailingCity = 'Test City',
            MailingState = 'TS',
            MailingPostalCode = '12345',
            npe01__HomeEmail__c = 'test1@example.com',
            BestTimetoContactGuardian__c = 'Anytime'
        );
        insert testParentContact;
        
        contact testChildRec=new Contact(
        	FirstName='ChildFN',
            LastName='ChildLN',
            Name_of_Primary_Parent_Guardian__c=testParentContact.Id
            
        );
        insert testChildRec;
        
        String itemData='[{"bestTimeToContactParent":"Testing","briefExplaination":"Test  Safety Plan Explanation", "childRecordId":"'+testChildRec.Id+'", "comment":"Test Comment","currDateOfSignature":"2024-03-17","cyfCaseNumber":"Test CYF Case Number", "cyfCasePhoneNumber":"123456789","cyfCaseWorkerName":"Test CYF Caseworkers Name","cyfFamilyCase":true, "cyfRegionalOfficeServices":"Test Regional Office for CYF Services","Dob":"2024-02-25", "firstName":"Test Child First Name", "genIdentityColumn":[{"label":"--Select--","value":"--Select--"},{"label":"Cis Girl/Woman","value":"Cis Girl/Woman"}, {"label":"Cis Boy/Man","value":"Cis Boy/Man"},{"label":"Transgender Girl/Woman","value":"Transgender Girl/Woman"}, {"label":"Transgender Boy/Man","value":"Transgender Boy/Man"},{"label":"Genderqueer/non-binary/gender fluid","value":"Genderqueer/non-binary/gender fluid"}, {"label":"Other (list)","value":"Other (list)"}], "genIdentitySelectedColumn":"Cis Boy/Man","genPronounColumn":[{"label":"--Select--","value":"--Select--"}, {"label":"she/her","value":"she/her"},{"label":"he/him","value":"he/him"},{"label":"they/their","value":"they/their"},{"label":"Other","value":"Other"}], "genPronounSelectedColumn":"she/her","guardianMailingStateColumn":[{"label":"--Select--","value":"--Select--"},{"label":"AL","value":"AL"},{"label":"AK","value":"AK"},{"label":"AZ","value":"AZ"},{"label":"AR","value":"AR"},{"label":"CA","value":"CA"},{"label":"CO","value":"CO"},{"label":"CT","value":"CT"},{"label":"DE","value":"DE"},{"label":"FL","value":"FL"},{"label":"GA","value":"GA"},{"label":"HI","value":"HI"},{"label":"ID","value":"ID"},{"label":"IL","value":"IL"},{"label":"IN","value":"IN"},{"label":"IA","value":"IA"},{"label":"KS","value":"KS"},{"label":"KY","value":"KY"},{"label":"LA","value":"LA"},{"label":"ME","value":"ME"},{"label":"MD","value":"MD"},{"label":"MA","value":"MA"},{"label":"MI","value":"MI"},{"label":"MN","value":"MN"},{"label":"MS","value":"MS"},{"label":"MO","value":"MO"},{"label":"MT","value":"MT"},{"label":"NE","value":"NE"},{"label":"NV","value":"NV"},{"label":"NH","value":"NH"},{"label":"NJ","value":"NJ"},{"label":"NM","value":"NM"},{"label":"NY","value":"NY"},{"label":"NC","value":"NC"},{"label":"ND","value":"ND"},{"label":"OH","value":"OH"},{"label":"OK","value":"OK"},{"label":"OR","value":"OR"},{"label":"PA","value":"PA"},{"label":"RI","value":"RI"},{"label":"SC","value":"SC"},{"label":"SD","value":"SD"},{"label":"TN","value":"TN"},{"label":"TX","value":"TX"},{"label":"UT","value":"UT"},{"label":"VT","value":"VT"},{"label":"VA","value":"VA"},{"label":"WA","value":"WA"},{"label":"WV","value":"WV"},{"label":"WI","value":"WI"},{"label":"WY","value":"WY"}], "guardianMailingStateSelectedColumn":"AL","homePhn":"123456789","identityExpansion":"Test Expansion", "immSafetyConcernColumn":[{"label":"--Select--","value":"--Select--"},{"label":"Yes","value":"Yes"},{"label":"No","value":"No"}], "immSafetyConcernSelectedColumn":"Yes","lastName":"Test Child Last Name","mailingCity":"Test City","mailingPostalCode":"12345", "mailingState":"AL","mailingStreet":"Test Street","parentEmail":"testparentemail@gmail.com","parentfName":"Test Parent Data First Name", "parentlName":"Test Parent Data Last Name","parentMailingCity":"Test City","parentMailingPostalCode":"12345","parentMailingStreet":"Test Street","parentPhnNumber":"0987654321", "participateInCC4YouthColumn":[{"label":"--Select--","value":"--Select--"},{"label":"Yes","value":"Yes"},{"label":"No","value":"No"}], "participateInCC4YouthSelectedColumn":"--Select--","preferedName":"Test Preferred Name", "previousSystemInvolveMultiPickColumn":[{"label":"Juvenile Justice","value":"Juvenile Justice"},{"label":"Child Welfare","value":"Child Welfare"},{"label":"Disability Service","value":"Disability Service"}, {"label":"Special Education (IEP/504)","value":"Special Education (IEP/504)"},{"label":"Behavioral Health Services","value":"Behavioral Health Services"}], "previousSystemInvolveMultiPickSelectedColumn":["Juvenile Justice"], "primaryConcernColumn":[{"label":"--Select--","value":"--Select--"},{"label":"Basic Needs","value":"Basic Needs"},{"label":"Benefits & Income","value":"Benefits & Income"}, {"label":"Substance Use","value":"Substance Use"},{"label":"Education & Workforce Development","value":"Education & Workforce Development"}, {"label":"Truancy","value":"Truancy"},{"label":"Legal","value":"Legal"},{"label":"Mental/Behavioral & Physical Health","value":"Mental/Behavioral & Physical Health"}, {"label":"Parent-Child/Family Conflict","value":"Parent-Child/Family Conflict"},{"label":"Family Relationship Violence","value":"Family Relationship Violence"}, {"label":"Teen Dating Violence","value":"Teen Dating Violence"},{"label":"Social","value":"Social"},{"label":"Systems Navigation","value":"Systems Navigation"}], "primaryConcernMultiPickColumn":[{"label":"Childcare/Out of School Time","value":"Childcare/Out of School Time"}, {"label":"Clothing/Household Goods/Furniture","value":"Clothing/Household Goods/Furniture"},{"label":"Food Assistance","value":"Food Assistance"}, {"label":"Housing/Shelter Assistance","value":"Housing/Shelter Assistance"},{"label":"Utilities","value":"Utilities"}, {"label":"Transportation","value":"Transportation"},{"label":"Income Support incl SNAP & TANF","value":"Income Support incl SNAP & TANF"}, {"label":"Money Management/Financial Literacy","value":"Money Management/Financial Literacy"},{"label":"Drugs","value":"Drugs"},{"label":"Alcohol","value":"Alcohol"}, {"label":"Education","value":"Education"},{"label":"Employment, Job Training, Life Skills","value":"Employment, Job Training, Life Skills"}, {"label":"Child Advocacy","value":"Child Advocacy"},{"label":"Documents (ID, Birth Certificate, Social Security Card)","value":"Documents (ID, Birth Certificate, Social Security Card)"}, {"label":"Expungement","value":"Expungement"},{"label":"Parent Advocacy","value":"Parent Advocacy"},{"label":"Victim Services","value":"Victim Services"}, {"label":"Case Management: General Individual/Family Support","value":"Case Management: General Individual/Family Support"},{"label":"Family Therapy","value":"Family Therapy"}, {"label":"Grief & Loss","value":"Grief & Loss"},{"label":"Health & Wellness","value":"Health & Wellness"}, {"label":"Individual Therapy","value":"Individual Therapy"},{"label":"Medication Access or Management","value":"Medication Access or Management"}, {"label":"Pregnancy & Post-Partum","value":"Pregnancy & Post-Partum"},{"label":"Social Enrichment","value":"Social Enrichment"},{"label":"Sports and Recreation","value":"Sports and Recreation"},{"label":"Aging (Elderly)","value":"Aging (Elderly)"}, {"label":"Benefits","value":"Benefits"},{"label":"Child Welfare","value":"Child Welfare"},{"label":"Juvenile Justice","value":"Juvenile Justice"},{"label":"IDD","value":"IDD"}], "primaryConcernSelectedColumn":"Basic Needs","primaryConcrnMultiPickSelectedColumn":["Utilities"],"racialEthnicIdentityColumn":[{"label":"--Select--","value":"--Select--"},{"label":"African American/Black","value":"African American/Black"},{"label":"American Indian/Alaskan Native/Native American","value":"American Indian/Alaskan Native/Native American"},{"label":"Asian/Pacific Islander","value":"Asian/Pacific Islander"},{"label":"Caucasian/White","value":"Caucasian/White"},{"label":"Latina/Latino/Latinx","value":"Latina/Latino/Latinx"},{"label":"Mediterranian","value":"Mediterranian"},{"label":"Multiracial/Multiethnic","value":"Multiracial/Multiethnic"},{"label":"South Asian","value":"South Asian"},{"label":"Other","value":"Other"},{"label":"East Asian","value":"East Asian"},{"label":"Middle Eastern","value":"Middle Eastern"}], "racialEthnicIdentitySelectedColumn":"American Indian/Alaskan Native/Native American", "reasonForReferralMultiPickColumn":[{"label":"Aging Systems Coordination","value":"Aging Systems Coordination"},{"label":"Benefits Navigation","value":"Benefits Navigation"},{"label":"Clothing/Household Goods/Furniture","value":"Clothing/Household Goods/Furniture"},{"label":"Child Welfare Systems Navigation","value":"Child Welfare Systems Navigation"},{"label":"Education","value":"Education"},{"label":"Employment, Job Training, Life Skills","value":"Employment, Job Training, Life Skills"},{"label":"Family or Parent/Teen Conflict","value":"Family or Parent/Teen Conflict"},{"label":"Food Assistance","value":"Food Assistance"},{"label":"Grief & Loss","value":"Grief & Loss"},{"label":"Health and Wellness","value":"Health and Wellness"},{"label":"Housing/Shelter","value":"Housing/Shelter"},{"label":"Individual & Family Support","value":"Individual & Family Support"},{"label":"Incoming Support, including SNAP & TANF","value":"Incoming Support, including SNAP & TANF"},{"label":"Juvenile Justice System Navigation","value":"Juvenile Justice System Navigation"},{"label":"Legal","value":"Legal"},{"label":"Mental & Behavioral Health","value":"Mental & Behavioral Health"},{"label":"Money Management/Financial Literacy","value":"Money Management/Financial Literacy"},{"label":"Pregnancy & Post-Partum","value":"Pregnancy & Post-Partum"},{"label":"Social Service Case Management","value":"Social Service Case Management"},{"label":"Social Enrichment","value":"Social Enrichment"},{"label":"Sports and Recreation","value":"Sports and Recreation"},{"label":"Substance Use","value":"Substance Use"},{"label":"Transportation","value":"Transportation"},{"label":"Utilities","value":"Utilities"},{"label":"Victims Services","value":"Victims Services"},{"label":"Other","value":"Other"}], "reasonForReferralMultiPickSelectedColumn":["Benefits Navigation"], "relationshipToChildColumn":[{"label":"--Select--","value":"--Select--"},{"label":"Aunt","value":"Aunt"},{"label":"Cousin","value":"Cousin"},{"label":"Coworker","value":"Coworker"},{"label":"Employer","value":"Employer"},{"label":"Family","value":"Family"},{"label":"Father","value":"Father"},{"label":"Foster Parent","value":"Foster Parent"},{"label":"Friend","value":"Friend"},{"label":"Grandfather","value":"Grandfather"},{"label":"Grandmother","value":"Grandmother"},{"label":"Grandparent","value":"Grandparent"},{"label":"Husband","value":"Husband"},{"label":"Mother","value":"Mother"},{"label":"Parent","value":"Parent"},{"label":"Partner","value":"Partner"},{"label":"Sibling","value":"Sibling"},{"label":"Step Father","value":"Step Father"},{"label":"Step Mother","value":"Step Mother"},{"label":"Uncle","value":"Uncle"},{"label":"Wife","value":"Wife"},{"label":"Caregiver","value":"Caregiver"},{"label":"Emergency Contact","value":"Emergency Contact"},{"label":"Referral","value":"Referral"},{"label":"None","value":"None"}], "relationshipToChildSelectedColumn":"Aunt","safetyPlanColumn":[{"label":"--Select--","value":"--Select--"},{"label":"Yes","value":"Yes"},{"label":"No","value":"No"}], "safetyPlanSelectedColumn":"Yes","secondaryConcernColumn":[{"label":"--Select--","value":"--Select--"},{"label":"Basic Needs","value":"Basic Needs"},{"label":"Benefits & Income","value":"Benefits & Income"},{"label":"Substance Use","value":"Substance Use"},{"label":"Education & Workforce Development","value":"Education & Workforce Development"},{"label":"Truancy","value":"Truancy"},{"label":"Legal","value":"Legal"},{"label":"Mental/Behavioral & Physical Health","value":"Mental/Behavioral & Physical Health"},{"label":"Parent-Child/Family Conflict","value":"Parent-Child/Family Conflict"},{"label":"Family Relationship Violence","value":"Family Relationship Violence"},{"label":"Teen Dating Violence","value":"Teen Dating Violence"},{"label":"Social","value":"Social"},{"label":"Systems Navigation","value":"Systems Navigation"}], "secondaryConcernMultiPickColumn":[{"label":"Childcare/Out of School Time","value":"Childcare/Out of School Time"},{"label":"Clothing/Household Goods/Furniture","value":"Clothing/Household Goods/Furniture"},{"label":"Food Assistance","value":"Food Assistance"},{"label":"Housing/Shelter Assistance","value":"Housing/Shelter Assistance"},{"label":"Utilities","value":"Utilities"},{"label":"Transportation","value":"Transportation"},{"label":"Income Support incl SNAP & TANF","value":"Income Support incl SNAP & TANF"},{"label":"Money Management/Financial Literacy","value":"Money Management/Financial Literacy"},{"label":"Drugs","value":"Drugs"},{"label":"Alcohol","value":"Alcohol"},{"label":"Education","value":"Education"},{"label":"Employment, Job Training, Life Skills","value":"Employment, Job Training, Life Skills"},{"label":"Child Advocacy","value":"Child Advocacy"},{"label":"Documents (ID, Birth Certificate, Social Security Card)","value":"Documents (ID, Birth Certificate, Social Security Card)"},{"label":"Expungement","value":"Expungement"},{"label":"Parent Advocacy","value":"Parent Advocacy"},{"label":"Victim Services","value":"Victim Services"},{"label":"Case Management: General Individual/Family Support","value":"Case Management: General Individual/Family Support"},{"label":"Family Therapy","value":"Family Therapy"},{"label":"Grief & Loss","value":"Grief & Loss"},{"label":"Health & Wellness","value":"Health & Wellness"},{"label":"Individual Therapy","value":"Individual Therapy"},{"label":"Medication Access or Management","value":"Medication Access or Management"},{"label":"Pregnancy & Post-Partum","value":"Pregnancy & Post-Partum"},{"label":"Social Enrichment","value":"Social Enrichment"},{"label":"Sports and Recreation","value":"Sports and Recreation"},{"label":"Aging (Elderly)","value":"Aging (Elderly)"},{"label":"Benefits","value":"Benefits"},{"label":"Child Welfare","value":"Child Welfare"},{"label":"Juvenile Justice","value":"Juvenile Justice"},{"label":"IDD","value":"IDD"}], "secondaryConcernMultiPickSelectedColumn":["Utilities"],"secondaryConcernSelectedColumn":"Basic Needs","selectedValues":["Utilities"], "selectedValuesPreviousSystemInvolve":["Juvenile Justice"],"selectedValuesReasonForReferral":["Benefits Navigation"],"selectedValuesSecConcern":["Utilities"], "selectedValuesThirdConcern":["Utilities"],"thirdConcernColumn":[{"label":"--Select--","value":"--Select--"},{"label":"Basic Needs","value":"Basic Needs"},{"label":"Benefits & Income","value":"Benefits & Income"},{"label":"Substance Use","value":"Substance Use"},{"label":"Education & Workforce Development","value":"Education & Workforce Development"},{"label":"Truancy","value":"Truancy"},{"label":"Legal","value":"Legal"},{"label":"Mental/Behavioral & Physical Health","value":"Mental/Behavioral & Physical Health"},{"label":"Parent-Child/Family Conflict","value":"Parent-Child/Family Conflict"},{"label":"Family Relationship Violence","value":"Family Relationship Violence"},{"label":"Teen Dating Violence","value":"Teen Dating Violence"},{"label":"Social","value":"Social"},{"label":"Systems Navigation","value":"Systems Navigation"}], "thirdConcernMultiPickColumn":[{"label":"Childcare/Out of School Time","value":"Childcare/Out of School Time"},{"label":"Clothing/Household Goods/Furniture","value":"Clothing/Household Goods/Furniture"},{"label":"Food Assistance","value":"Food Assistance"},{"label":"Housing/Shelter Assistance","value":"Housing/Shelter Assistance"},{"label":"Utilities","value":"Utilities"},{"label":"Transportation","value":"Transportation"},{"label":"Income Support incl SNAP & TANF","value":"Income Support incl SNAP & TANF"},{"label":"Money Management/Financial Literacy","value":"Money Management/Financial Literacy"},{"label":"Drugs","value":"Drugs"},{"label":"Alcohol","value":"Alcohol"},{"label":"Education","value":"Education"},{"label":"Employment, Job Training, Life Skills","value":"Employment, Job Training, Life Skills"},{"label":"Child Advocacy","value":"Child Advocacy"},{"label":"Documents (ID, Birth Certificate, Social Security Card)","value":"Documents (ID, Birth Certificate, Social Security Card)"},{"label":"Expungement","value":"Expungement"},{"label":"Parent Advocacy","value":"Parent Advocacy"},{"label":"Victim Services","value":"Victim Services"},{"label":"Case Management: General Individual/Family Support","value":"Case Management: General Individual/Family Support"},{"label":"Family Therapy","value":"Family Therapy"},{"label":"Grief & Loss","value":"Grief & Loss"},{"label":"Health & Wellness","value":"Health & Wellness"},{"label":"Individual Therapy","value":"Individual Therapy"},{"label":"Medication Access or Management","value":"Medication Access or Management"},{"label":"Pregnancy & Post-Partum","value":"Pregnancy & Post-Partum"},{"label":"Social Enrichment","value":"Social Enrichment"},{"label":"Sports and Recreation","value":"Sports and Recreation"},{"label":"Aging (Elderly)","value":"Aging (Elderly)"},{"label":"Benefits","value":"Benefits"},{"label":"Child Welfare","value":"Child Welfare"},{"label":"Juvenile Justice","value":"Juvenile Justice"},{"label":"IDD","value":"IDD"}], "thirdConcernMultiPickSelectedColumn":["Utilities"],"thirdConcernSelectedColumn":"Basic Needs","youth14Column":[{"label":"--Select--","value":"--Select--"},{"label":"Yes","value":"Yes"},{"label":"No","value":"No"}], "cyfFamilyCaseString":"true","isChildSectionOpen":true,"SafetyPlanExplaination":"Test Plan ","youthSignature":"Test Child Signatue"}]';
        
  		Test.startTest();
        GGCaringConnectionsFormController.saveIntakeRecord(itemData, 'TestingSign', testParentContact.Id, null, null,null);
        Test.stopTest();        
            
    }
    
    
}