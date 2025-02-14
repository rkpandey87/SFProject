/**
 * @description       : 
 * @author            : WINSupport
 * @group             : 
 * @last modified on  : 01-25-2021
 * @last modified by  : WINSupport
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   01-18-2021   WINSupport   Initial Version
**/
public class RegistrationUtilities {
    public static void prepopulate(Set<Id> rids) {

        List<Registration__c> regs = new List<Registration__c>();
        List<Registration__c> upregs = new List<Registration__c>();
        Set<Id> conids = new Set<Id>();
        List<Contact> cons = new List<Contact>();
        Set<Id> acctids = new Set<Id>();
        List<Account> accts = new List<Account>();
        Map<Id,Contact> conmap = new Map<Id,Contact>();
        Map<Id,Account> acctmap = new Map<Id,Account>();


        SObjectType objtype = Schema.getGlobalDescribe().get('Registration__c'); 
        Map<String,Schema.SObjectField> objfields = objtype.getDescribe().fields.getMap(); 

        //Create the select string
        string logselect = 'Select ';

        for(string l : objfields.keyset()){
            logselect = logselect + objfields.get(l) + ', ';
        }

        logselect = logselect.substring(0,logselect.length()-2);
        logselect = logselect + '';
        logselect = logselect + ' FROM Registration__c WHERE Id IN: rids';

        try{
            regs  = Database.query(logselect); //Query for the log
        }catch(Exception e){
            system.debug('***********************ERROR Querying Registrations ***********************' + e.getMessage());
        }


       // regs = [
            //SELECT Id, OwnerId, IsDeleted, Name, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastViewedDate, LastReferencedDate, Caregiver_Parent__c, School__c, Campaign__c, Case__c, Client3__c, Neighborhood__c, Client2__c, Client__c, Caregiver_Parent2__c, Program__c, YDS_or_CM_c__c, Youth_Development_Specialist__c, Approved_Pick_Up_1_Phone__c, Approved_Pick_Up_1__c, Approved_Pick_Up_2__c, Approved_Pick_Up_2_Phone__c, Approved_Pick_Up_2_Relationship__c, Emergency_Contact_Cell_Phone__c, Allergies__c, Allergies_Detailed__c, Approved_Pick_Up_1_Relationship__c, Child_will_Attend_Afterschool__c, Takes_Medication__c, Most_Recent_Vision_Exam__c, Most_Recent_Hearing_Exam__c, Physician_Name__c, Physician__c, Most_Recent_Physical__c, Physicians_Advice__c, Operations_Injuries__c, Most_Recent_Dental_Exam__c, SSN__c, MH_History_Detailed__c, Grade__c, Had_illness__c, Insurance_Number__c, Medical_Needs__c, Insurance_Provider__c, Medications__c, Emergency_Contact_Last__c, Emergency_Contact_Phone__c, Emergency_Contact_Relationship__c, Emergency_Contact_First__c, Allergies2__c, Neighborhood2__c, Emergency_Contact_Cell_Phone2__c, Physicians_Advice3__c, SSN3__c, Physician_Name3__c, Physician3__c, Takes_Medication3__c, MH_History_Detailed3__c, Insurance_Number3__c, Medical_Needs3__c, Medications3__c, Insurance_Provider3__c, Most_Recent_Vision_Exam3__c, Operations_Injuries3__c, Most_Recent_Dental_Exam3__c, Most_Recent_Physical3__c, Most_Recent_Hearing_Exam3__c, Emergency_Contact_Phone3__c, Emergency_Contact_Last3__c, Grade3__c, Emergency_Contact_Relationship3__c, Had_illness3__c, Approved_Pick_Up_13__c, Approved_Pick_Up_2_Relationship3__c, Approved_Pick_Up_2_Phone3__c, Approved_Pick_Up_23__c, Approved_Pick_Up_1_Relationship3__c, Approved_Pick_Up_1_Phone3__c, Neighborhood3__c, Emergency_Contact_Cell_Phone3__c, Emergency_Contact_First3__c, Child_will_Attend_Afterschool3__c, Birthdate2__c, Allergies3__c, Allergies_Detailed3__c, Approved_Pick_Up_1_Relationship2__c, Approved_Pick_Up_12__c, Approved_Pick_Up_2_Phone2__c, Approved_Pick_Up_22__c, Approved_Pick_Up_2_Relationship2__c, Approved_Pick_Up_1_Phone2__c, MH_History_Detailed2__c, Insurance_Provider2__c, Most_Recent_Hearing_Exam2__c, Most_Recent_Dental_Exam2__c, Medications2__c, Grade2__c, Most_Recent_Physical2__c, Medical_Needs2__c, Insurance_Number2__c, Had_illness2__c, Birthdate3__c, Birthdate__c, Physicians_Advice2__c, School2__c, Most_Recent_Vision_Exam2__c, Physician_Name2__c, Takes_Medication2__c, SSN2__c, Operations_Injuries2__c, Physician2__c, Emergency_Contact_Phone2__c, Emergency_Contact_Last2__c, Emergency_Contact_First2__c, Child_will_Attend_Afterschool2__c, Emergency_Contact_Relationship2__c, Allergies_Detailed2__c, School3__c, Email2__c, Email3__c, Email__c, FirstName2__c, FirstName3__c, FirstName__c, Household_Monthly_Income_c2__c, Household_Monthly_Income_c3__c, Household_Monthly_Income_c__c, Housing_Ownership2__c, Housing_Ownership3__c, Housing_Ownership__c, Housing_Type2__c, Housing_Type3__c, Housing_Type__c, How_do_you_hear_about_us2__c, How_do_you_hear_about_us3__c, How_do_you_hear_about_us__c, LastName2__c, LastName3__c, LastName__c, MailingCity2__c, MailingCity3__c, MailingCity__c, MailingPostalCode2__c, MailingPostalCode3__c, MailingPostalCode__c, MailingState2__c, MailingState3__c, MailingState__c, MalingStreet2__c, MalingStreet3__c, MalingStreet__c, MobilePhone2__c, MobilePhone3__c, MobilePhone__c, Time_In_Residence__c, Source_of_Income__c, Time_In_Residence2__c, Source_of_Income2__c, Source_of_Income3__c, Time_In_Residence3__c, Primary_Guardian_Relationship__c, Primary_Guardian_Relationship2__c 
            //FROM Registration__c
            //WHERE Id IN: rids
        //];

        if(!regs.isEmpty()){
            for(Registration__c reg : regs){

                if(reg.Client__c != NULL){
                    conids.add(reg.Client__c);
                }

                if(reg.Client2__c != NULL){
                    conids.add(reg.Client2__c);
                }

                if(reg.Client3__c != NULL){
                    conids.add(reg.Client3__c);
                }

                if(reg.Caregiver_Parent__c != NULL){
                    conids.add(reg.Caregiver_Parent__c);
                }

                if(reg.Caregiver_Parent2__c != NULL){
                    conids.add(reg.Caregiver_Parent2__c);
                }

                if(reg.YDS_or_CM_c__c != NULL){
                    conids.add(reg.YDS_or_CM_c__c);
                }

            }
        }

        SObjectType objtype2 = Schema.getGlobalDescribe().get('Contact'); 
        Map<String,Schema.SObjectField> objfields2 = objtype2.getDescribe().fields.getMap(); 

        //Create the select string
        string logselect2 = 'Select ';

        for(string l2 : objfields2.keyset()){
            logselect2 = logselect2 + objfields2.get(l2) + ', ';
        }

        logselect2 = logselect2.substring(0,logselect2.length()-2);
        logselect2 = logselect2 + '';
        logselect2 = logselect2 + ' FROM Contact WHERE Id IN: conids';

        try{
            cons  = Database.query(logselect2); //Query for the log
        }catch(Exception e){
            system.debug('***********************ERROR Querying Contacts ***********************' + e.getMessage());
        }

        //if(!conids.isEmpty()){
            //cons = [
                //SELECT Id, IsDeleted, MasterRecordId, AccountId, LastName, FirstName, Salutation, MiddleName, Suffix, Name, RecordTypeId, OtherStreet, OtherCity, OtherState, OtherPostalCode, OtherCountry, OtherLatitude, OtherLongitude, OtherGeocodeAccuracy, OtherAddress, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, MailingLatitude, MailingLongitude, MailingGeocodeAccuracy, MailingAddress, Phone, Fax, MobilePhone, HomePhone, OtherPhone, AssistantPhone, ReportsToId, Email, Title, Department, AssistantName, LeadSource, Birthdate, Description, OwnerId, HasOptedOutOfEmail, HasOptedOutOfFax, DoNotCall, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, LastCURequestDate, LastCUUpdateDate, LastViewedDate, LastReferencedDate, EmailBouncedReason, EmailBouncedDate, IsEmailBounced, PhotoUrl, Jigsaw, JigsawContactId, IndividualId, npe01__AlternateEmail__c, npe01__HomeEmail__c, npe01__Home_Address__c, npe01__Last_Donation_Date__c, npe01__Lifetime_Giving_History_Amount__c, npe01__Organization_Type__c, npe01__Other_Address__c, npe01__PreferredPhone__c, npe01__Preferred_Email__c, npe01__Primary_Address_Type__c, npe01__Private__c, npe01__Secondary_Address_Type__c, npe01__SystemAccountProcessor__c, npe01__SystemIsIndividual__c, npe01__Type_of_Account__c, npe01__WorkEmail__c, npe01__WorkPhone__c, npe01__Work_Address__c, npo02__AverageAmount__c, npo02__Best_Gift_Year_Total__c, npo02__Best_Gift_Year__c, npo02__FirstCloseDate__c, npo02__Formula_HouseholdMailingAddress__c, npo02__Formula_HouseholdPhone__c, npo02__Household_Naming_Order__c, npo02__Household__c, npo02__LargestAmount__c, npo02__LastCloseDateHH__c, npo02__LastCloseDate__c, npo02__LastMembershipAmount__c, npo02__LastMembershipDate__c, npo02__LastMembershipLevel__c, npo02__LastMembershipOrigin__c, npo02__LastOppAmount__c, npo02__MembershipEndDate__c, npo02__MembershipJoinDate__c, npo02__Naming_Exclusions__c, npo02__NumberOfClosedOpps__c, npo02__NumberOfMembershipOpps__c, npo02__OppAmount2YearsAgo__c, npo02__OppAmountLastNDays__c, npo02__OppAmountLastYearHH__c, npo02__OppAmountLastYear__c, npo02__OppAmountThisYearHH__c, npo02__OppAmountThisYear__c, npo02__OppsClosed2YearsAgo__c, npo02__OppsClosedLastNDays__c, npo02__OppsClosedLastYear__c, npo02__OppsClosedThisYear__c, npo02__SmallestAmount__c, npo02__Soft_Credit_Last_Year__c, npo02__Soft_Credit_This_Year__c, npo02__Soft_Credit_Total__c, npo02__Soft_Credit_Two_Years_Ago__c, npo02__SystemHouseholdProcessor__c, npo02__TotalMembershipOppAmount__c, npo02__TotalOppAmount__c, npo02__Total_Household_Gifts__c, npsp__Batch__c, npsp__Current_Address__c, npsp__HHId__c, npsp__Primary_Affiliation__c, npsp__Soft_Credit_Last_N_Days__c, npsp__is_Address_Override__c, GW_Volunteers__Unique_Volunteer_Count__c, GW_Volunteers__Volunteer_Auto_Reminder_Email_Opt_Out__c, GW_Volunteers__Volunteer_Availability__c, GW_Volunteers__Volunteer_Last_Web_Signup_Date__c, GW_Volunteers__Volunteer_Manager_Notes__c, GW_Volunteers__Volunteer_Notes__c, GW_Volunteers__Volunteer_Organization__c, GW_Volunteers__Volunteer_Skills__c, GW_Volunteers__Volunteer_Status__c, GW_Volunteers__First_Volunteer_Date__c, GW_Volunteers__Last_Volunteer_Date__c, GW_Volunteers__Volunteer_Hours__c, Gender__c, npsp__Primary_Contact__c, npsp__Address_Verification_Status__c, npsp__Exclude_from_Household_Formal_Greeting__c, npsp__Exclude_from_Household_Informal_Greeting__c, npsp__Exclude_from_Household_Name__c, npsp__Deceased__c, npsp__Do_Not_Contact__c, npsp__First_Soft_Credit_Amount__c, npsp__First_Soft_Credit_Date__c, npsp__Largest_Soft_Credit_Amount__c, npsp__Largest_Soft_Credit_Date__c, npsp__Last_Soft_Credit_Amount__c, npsp__Last_Soft_Credit_Date__c, npsp__Number_of_Soft_Credits_Last_N_Days__c, npsp__Number_of_Soft_Credits_Last_Year__c, npsp__Number_of_Soft_Credits_This_Year__c, npsp__Number_of_Soft_Credits_Two_Years_Ago__c, npsp__Number_of_Soft_Credits__c, Case__c, Act_33__c, Act_34__c, Age__c, Agency_Involvement__c, Began_Services__c, Between_8_18__c, CYF_Active__c, CYF_Case_Worker__c, Child_will_Attend_Afterschool__c, Children__c, Comments__c, Community_Service__c, Contact_Type__c, Contraception__c, Court_Active__c, Court_Referral__c, Current_Placement__c, Date_of_Placement__c, Deferment_Reason__c, Dietary_Requirements__c, Emergency_Contact_2__c, Emergency_Contact__c, Employed__c, Eye_Color__c, Fathers_Involvement__c, Fingerprints_Completed__c, Form_Completed__c, Grade__c, Hair_Color__c, Height__c, Height_feet__c, Height_inches__c, Identifying_Marks__c, Income_Source__c, Insurance_Provider__c, Intake__c, Interest_Areas__c, Intervention_Plan__c, Interview_Complete__c, KIDS_ID__c, LMP__c, Language__c, Medical_Needs__c, Medications__c, Menarche__c, Menses__c, Mentoring_101__c, Name_of_Primary_Parent_Guardian__c, PRN__c, Parenting__c, Partners__c, Physician_Facility__c, Physician_Name__c, Physician__c, Place_of_Employment__c, Placement_Type__c, Pregnancy_Trem__c, Previous_Placements__c, Race__c, Recipient_ID__c, Recommendation__c, Referral_Recieved__c, Referral_Source__c, Regional_Office__c, Restitution__c, Role__c, SSN__c, STD_Treatment__c, Salary__c, School__c, Screening_Labs__c, Sexually_Active__c, Sibling__c, Sickle_Cell__c, Smokes_Cigarettes__c, Type__c, Volunteer_Organization__c, Weight__c, YDS__c, KIDS_Active_Service_Episode_ID__c, Neighborhood__c, Other_Grade_Level__c, Intake_Relationship_Type__c, YDS_or_CM_c__c, KIDS_Supervisor__c, KIDS_Manager_c__c, GG_Staff_Status__c, Case_Status_c__c, Abuse__c, Allergies_Detailed__c, Allergies__c, Alt_Transportation__c, Appropriate_Age__c, Approved_Pick_Up_1_Phone__c, Approved_Pick_Up_1_Relationship__c, Approved_Pick_Up_1__c, Approved_Pick_Up_2_Phone__c, Approved_Pick_Up_2_Relationship__c, Approved_Pick_Up_2__c, Approved_Pick_Up_3_Phone__c, Approved_Pick_Up_3_Relationship__c, Approved_Pick_Up_3__c, Approved_Pick_Up_4_Phone__c, Approved_Pick_Up_4_Relationship__c, Approved_Pick_Up_4__c, Attendance__c, Behavior_Problems__c, Behavioral_Issues__c, Behavioral_Issues_other__c, Birthdate__c, Case_Worker__c, Child_School_Performance__c, Community_Activities__c, Community_Collaborative__c, Community_Resources__c, Confidentiality_Statement__c, Conflicts_wParents__c, ConsentReturn_Unsupervised__c, Current_DA_Concerns__c, Current_Living_Situation__c, DA_Concerns_Detailed__c, DA_History__c, DA_Pregnancy__c, Developmental_Delay__c, Emergency_Contact_2_Cell_Phone__c, Emergency_Contact_2_First__c, Emergency_Contact_2_Last__c, Emergency_Contact_2_Phone__c, Emergency_Contact_Cell_Phone__c, Emergency_Contact_First__c, Emergency_Contact_Last__c, Emergency_Contact_Phone__c, Emergency_Information__c, FACE_Sheet__c, FERPA__c, Family_Handbook_Acceptance__c, Financial_Literacy__c, GPA__c, Grade_History__c, Graduated__c, Graduation_Date__c, Graduation_Type__c, Group_Expectations__c, Group_Rules_Agreement__c, Guardian_City__c, Guardian_State__c, Guardian_Street__c, Guardian_Zip__c, Had_illness__c, History_of_Abuse__c, Household_Monthly_Income__c, IEP_Review__c, IEP__c, In_School__c, Insurance_Number__c, Intake_Status__c, Interests_Specialty_Group__c, Juvenile_Probation__c, KIDS_Service_Episode_Id__c, Last_Physical_MM_YYYY__c, MH_History_Detailed__c, Medical_Release__c, Mental_Health_History__c, Missed_School__c, Mobile_Phone__c, Operations_Injuries__c, Other_Caregiver_First__c, Other_Caregiver_Last__c, Other_Guardian_Relationship__c, Other_Phone__c, Out_of_C_S__c, Permission_to_Photograph__c, Physicians_Advice__c, PreGroup_Assessment__c, Pregnancy_Term__c, Pregnant_Parenting__c, Primary_Guardian_First__c, Primary_Guardian_Last__c, Primary_Guardian_Relationship__c, Problems_in_School__c, Reason_for_Deferment__c, Recent_IEP__c, Referal_Completed__c, Referral_Reason__c, Referral_Received__c, Referral_Source_First__c, Referral_Source_Last__c, Referral_Source_Relationship__c, Referral_Source_Type__c, Referral_Type__c, Release_Info_Consent__c, Rewards_Points_Policy__c, School_Problems_Detailed__c, Sexual_Abuse__c, Status__c, Television_R_V__c, Transportation_Consent__c, Voluntary_Service__c, Weeks_Enrollment_Deferred__c, Next_Grade_Level_c__c, Date_Grade_Level_Last_Set__c, Last_Grade_Level_Update_is_Today_c__c, Grade_Level_Update_Needed__c, Emergency_Contact_Relationship__c, Housing_Ownership__c, Housing_Type__c, How_do_you_hear_about_us__c, Most_Recent_Dental_Exam__c, Most_Recent_Hearing_Exam__c, Most_Recent_Physical__c, Most_Recent_Vision_Exam__c, PIN__c, Receive_Public_Assistance__c, Source_of_Income__c, Takes_Medication__c, Time_In_Residence__c, Active_Status__c, Most_Recent_Contact_Summary__c, Most_Recent_Touch_Point__c, Most_Recent_Program_Participation__c, Number_of_Primary_Children__c, Number_of_Active_Primary_Children__c, Active_Status_Household_c__c, MostRecentRegistrationCampaignMemberId__c, MostRecentRegistrationURL__c, MostRecentRegistrationLink__c, Days_Since_Last_Contact_Summary__c, PIN_Auto_Numbered__c, RecordTypeName__c, Most_Recent_Registration_Campaign_Member__c 
                //FROM Contact
                //WHERE Id IN: conids
            //];
        //}

        if(!cons.isEmpty()){

            for(Contact con : cons){
                conmap.put(con.Id,con);
            }

            for(Registration__c regup : regs){

                Boolean prepopulate;
                prepopulate = FALSE;

                if(conmap.containsKey(regup.Client__c)){
                    if(regup.Allergies_Detailed__c == NULL && conmap.get(regup.Client__c).Allergies_Detailed__c != NULL){
                    prepopulate = TRUE;
                    regup.Allergies_Detailed__c=conmap.get(regup.Client__c).Allergies_Detailed__c ;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Allergies_Detailed2__c == NULL && conmap.get(regup.Client2__c).Allergies_Detailed__c != NULL){
                    prepopulate = TRUE;
                    regup.Allergies_Detailed2__c=conmap.get(regup.Client2__c).Allergies_Detailed__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Allergies_Detailed3__c == NULL && conmap.get(regup.Client3__c).Allergies_Detailed__c != NULL){
                    prepopulate = TRUE;
                    regup.Allergies_Detailed3__c=conmap.get(regup.Client3__c).Allergies_Detailed__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Approved_Pick_Up_1__c == NULL && conmap.get(regup.Client__c).Approved_Pick_Up_1__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_1__c=conmap.get(regup.Client__c).Approved_Pick_Up_1__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Approved_Pick_Up_1_Phone__c == NULL && conmap.get(regup.Client__c).Approved_Pick_Up_1_Phone__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_1_Phone__c=conmap.get(regup.Client__c).Approved_Pick_Up_1_Phone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Approved_Pick_Up_1_Phone2__c == NULL && conmap.get(regup.Client2__c).Approved_Pick_Up_1_Phone__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_1_Phone2__c=conmap.get(regup.Client2__c).Approved_Pick_Up_1_Phone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Approved_Pick_Up_1_Phone3__c == NULL && conmap.get(regup.Client3__c).Approved_Pick_Up_1_Phone__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_1_Phone3__c=conmap.get(regup.Client3__c).Approved_Pick_Up_1_Phone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Approved_Pick_Up_1_Relationship__c == NULL && conmap.get(regup.Client__c).Approved_Pick_Up_1_Relationship__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_1_Relationship__c=conmap.get(regup.Client__c).Approved_Pick_Up_1_Relationship__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Approved_Pick_Up_1_Relationship2__c == NULL && conmap.get(regup.Client2__c).Approved_Pick_Up_1_Relationship__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_1_Relationship2__c=conmap.get(regup.Client2__c).Approved_Pick_Up_1_Relationship__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Approved_Pick_Up_1_Relationship3__c == NULL && conmap.get(regup.Client3__c).Approved_Pick_Up_1_Relationship__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_1_Relationship3__c=conmap.get(regup.Client3__c).Approved_Pick_Up_1_Relationship__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Approved_Pick_Up_12__c == NULL && conmap.get(regup.Client2__c).Approved_Pick_Up_1__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_12__c=conmap.get(regup.Client2__c).Approved_Pick_Up_1__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Approved_Pick_Up_13__c == NULL && conmap.get(regup.Client3__c).Approved_Pick_Up_1__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_13__c=conmap.get(regup.Client3__c).Approved_Pick_Up_1__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Approved_Pick_Up_2__c == NULL && conmap.get(regup.Client__c).Approved_Pick_Up_2__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_2__c=conmap.get(regup.Client__c).Approved_Pick_Up_2__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Approved_Pick_Up_2_Phone__c == NULL && conmap.get(regup.Client__c).Approved_Pick_Up_2_Phone__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_2_Phone__c=conmap.get(regup.Client__c).Approved_Pick_Up_2_Phone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Approved_Pick_Up_2_Phone2__c == NULL && conmap.get(regup.Client2__c).Approved_Pick_Up_2_Phone__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_2_Phone2__c=conmap.get(regup.Client2__c).Approved_Pick_Up_2_Phone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Approved_Pick_Up_2_Phone3__c == NULL && conmap.get(regup.Client3__c).Approved_Pick_Up_2_Phone__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_2_Phone3__c=conmap.get(regup.Client3__c).Approved_Pick_Up_2_Phone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Approved_Pick_Up_2_Relationship__c == NULL && conmap.get(regup.Client__c).Approved_Pick_Up_2_Relationship__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_2_Relationship__c=conmap.get(regup.Client__c).Approved_Pick_Up_2_Relationship__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Approved_Pick_Up_2_Relationship2__c == NULL && conmap.get(regup.Client2__c).Approved_Pick_Up_2_Relationship__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_2_Relationship2__c=conmap.get(regup.Client2__c).Approved_Pick_Up_2_Relationship__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Approved_Pick_Up_2_Relationship3__c == NULL && conmap.get(regup.Client3__c).Approved_Pick_Up_2_Relationship__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_2_Relationship3__c=conmap.get(regup.Client3__c).Approved_Pick_Up_2_Relationship__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Approved_Pick_Up_22__c == NULL && conmap.get(regup.Client2__c).Approved_Pick_Up_2__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_22__c=conmap.get(regup.Client2__c).Approved_Pick_Up_2__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Approved_Pick_Up_23__c == NULL && conmap.get(regup.Client3__c).Approved_Pick_Up_2__c != NULL){
                    prepopulate = TRUE;
                    regup.Approved_Pick_Up_23__c=conmap.get(regup.Client3__c).Approved_Pick_Up_2__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Child_will_Attend_Afterschool__c == NULL && conmap.get(regup.Client__c).Child_will_Attend_Afterschool__c != NULL){
                    prepopulate = TRUE;
                    regup.Child_will_Attend_Afterschool__c=conmap.get(regup.Client__c).Child_will_Attend_Afterschool__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Child_will_Attend_Afterschool2__c == NULL && conmap.get(regup.Client2__c).Child_will_Attend_Afterschool__c != NULL){
                    prepopulate = TRUE;
                    regup.Child_will_Attend_Afterschool2__c=conmap.get(regup.Client2__c).Child_will_Attend_Afterschool__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Child_will_Attend_Afterschool3__c == NULL && conmap.get(regup.Client3__c).Child_will_Attend_Afterschool__c != NULL){
                    prepopulate = TRUE;
                    regup.Child_will_Attend_Afterschool3__c=conmap.get(regup.Client3__c).Child_will_Attend_Afterschool__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Emergency_Contact_Cell_Phone2__c == NULL && conmap.get(regup.Client__c).Emergency_Contact_Cell_Phone__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_Cell_Phone2__c=conmap.get(regup.Client__c).Emergency_Contact_Cell_Phone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Emergency_Contact_Cell_Phone2__c == NULL && conmap.get(regup.Client2__c).Emergency_Contact_Cell_Phone__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_Cell_Phone2__c=conmap.get(regup.Client2__c).Emergency_Contact_Cell_Phone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Emergency_Contact_Cell_Phone3__c == NULL && conmap.get(regup.Client3__c).Emergency_Contact_Cell_Phone__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_Cell_Phone3__c=conmap.get(regup.Client3__c).Emergency_Contact_Cell_Phone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Emergency_Contact_First__c == NULL && conmap.get(regup.Client__c).Emergency_Contact_First__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_First__c=conmap.get(regup.Client__c).Emergency_Contact_First__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Emergency_Contact_First2__c == NULL && conmap.get(regup.Client2__c).Emergency_Contact_First__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_First2__c=conmap.get(regup.Client2__c).Emergency_Contact_First__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Emergency_Contact_First3__c == NULL && conmap.get(regup.Client3__c).Emergency_Contact_First__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_First3__c=conmap.get(regup.Client3__c).Emergency_Contact_First__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Emergency_Contact_Last__c == NULL && conmap.get(regup.Client__c).Emergency_Contact_Last__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_Last__c=conmap.get(regup.Client__c).Emergency_Contact_Last__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Emergency_Contact_Last2__c == NULL && conmap.get(regup.Client2__c).Emergency_Contact_Last__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_Last2__c=conmap.get(regup.Client2__c).Emergency_Contact_Last__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Emergency_Contact_Last3__c == NULL && conmap.get(regup.Client3__c).Emergency_Contact_Last__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_Last3__c=conmap.get(regup.Client3__c).Emergency_Contact_Last__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Emergency_Contact_Phone__c == NULL && conmap.get(regup.Client__c).Emergency_Contact_Phone__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_Phone__c=conmap.get(regup.Client__c).Emergency_Contact_Phone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Emergency_Contact_Phone2__c == NULL && conmap.get(regup.Client2__c).Emergency_Contact_Phone__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_Phone2__c=conmap.get(regup.Client2__c).Emergency_Contact_Phone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Emergency_Contact_Phone3__c == NULL && conmap.get(regup.Client3__c).Emergency_Contact_Phone__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_Phone3__c=conmap.get(regup.Client3__c).Emergency_Contact_Phone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Emergency_Contact_Relationship__c == NULL && conmap.get(regup.Client__c).Emergency_Contact_Relationship__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_Relationship__c=conmap.get(regup.Client__c).Emergency_Contact_Relationship__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Emergency_Contact_Relationship2__c == NULL && conmap.get(regup.Client2__c).Emergency_Contact_Relationship__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_Relationship2__c=conmap.get(regup.Client2__c).Emergency_Contact_Relationship__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Emergency_Contact_Relationship3__c == NULL && conmap.get(regup.Client3__c).Emergency_Contact_Relationship__c != NULL){
                    prepopulate = TRUE;
                    regup.Emergency_Contact_Relationship3__c=conmap.get(regup.Client3__c).Emergency_Contact_Relationship__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Grade__c == NULL && conmap.get(regup.Client__c).Grade__c != NULL){
                    prepopulate = TRUE;
                    regup.Grade__c=conmap.get(regup.Client__c).Grade__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Grade2__c == NULL && conmap.get(regup.Client2__c).Grade__c != NULL){
                    prepopulate = TRUE;
                    regup.Grade2__c=conmap.get(regup.Client2__c).Grade__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Grade3__c == NULL && conmap.get(regup.Client3__c).Grade__c != NULL){
                    prepopulate = TRUE;
                    regup.Grade3__c=conmap.get(regup.Client3__c).Grade__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Had_illness__c == NULL && conmap.get(regup.Client__c).Had_illness__c != NULL){
                    prepopulate = TRUE;
                    regup.Had_illness__c=conmap.get(regup.Client__c).Had_illness__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Had_illness2__c == NULL && conmap.get(regup.Client2__c).Had_illness__c != NULL){
                    prepopulate = TRUE;
                    regup.Had_illness2__c=conmap.get(regup.Client2__c).Had_illness__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Had_illness3__c == NULL && conmap.get(regup.Client3__c).Had_illness__c != NULL){
                    prepopulate = TRUE;
                    regup.Had_illness3__c=conmap.get(regup.Client3__c).Had_illness__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Insurance_Number__c == NULL && conmap.get(regup.Client__c).Insurance_Number__c != NULL){
                    prepopulate = TRUE;
                    regup.Insurance_Number__c=conmap.get(regup.Client__c).Insurance_Number__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Insurance_Number2__c == NULL && conmap.get(regup.Client2__c).Insurance_Number__c != NULL){
                    prepopulate = TRUE;
                    regup.Insurance_Number2__c=conmap.get(regup.Client2__c).Insurance_Number__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Insurance_Number3__c == NULL && conmap.get(regup.Client3__c).Insurance_Number__c != NULL){
                    prepopulate = TRUE;
                    regup.Insurance_Number3__c=conmap.get(regup.Client3__c).Insurance_Number__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Insurance_Provider__c == NULL && conmap.get(regup.Client__c).Insurance_Provider__c != NULL){
                    prepopulate = TRUE;
                    regup.Insurance_Provider__c=conmap.get(regup.Client__c).Insurance_Provider__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Insurance_Provider2__c == NULL && conmap.get(regup.Client2__c).Insurance_Provider__c != NULL){
                    prepopulate = TRUE;
                    regup.Insurance_Provider2__c=conmap.get(regup.Client2__c).Insurance_Provider__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Insurance_Provider3__c == NULL && conmap.get(regup.Client3__c).Insurance_Provider__c != NULL){
                    prepopulate = TRUE;
                    regup.Insurance_Provider3__c=conmap.get(regup.Client3__c).Insurance_Provider__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Medical_Needs__c == NULL && conmap.get(regup.Client__c).Medical_Needs__c != NULL){
                    prepopulate = TRUE;
                    regup.Medical_Needs__c=conmap.get(regup.Client__c).Medical_Needs__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Medical_Needs2__c == NULL && conmap.get(regup.Client2__c).Medical_Needs__c != NULL){
                    prepopulate = TRUE;
                    regup.Medical_Needs2__c=conmap.get(regup.Client2__c).Medical_Needs__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Medical_Needs3__c == NULL && conmap.get(regup.Client3__c).Medical_Needs__c != NULL){
                    prepopulate = TRUE;
                    regup.Medical_Needs3__c=conmap.get(regup.Client3__c).Medical_Needs__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Medications__c == NULL && conmap.get(regup.Client__c).Medications__c != NULL){
                    prepopulate = TRUE;
                    regup.Medications__c=conmap.get(regup.Client__c).Medications__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Medications2__c == NULL && conmap.get(regup.Client2__c).Medications__c != NULL){
                    prepopulate = TRUE;
                    regup.Medications2__c=conmap.get(regup.Client2__c).Medications__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Medications3__c == NULL && conmap.get(regup.Client3__c).Medications__c != NULL){
                    prepopulate = TRUE;
                    regup.Medications3__c=conmap.get(regup.Client3__c).Medications__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.MH_History_Detailed__c == NULL && conmap.get(regup.Client__c).MH_History_Detailed__c != NULL){
                    prepopulate = TRUE;
                    regup.MH_History_Detailed__c=conmap.get(regup.Client__c).MH_History_Detailed__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.MH_History_Detailed2__c == NULL && conmap.get(regup.Client2__c).MH_History_Detailed__c != NULL){
                    prepopulate = TRUE;
                    regup.MH_History_Detailed2__c=conmap.get(regup.Client2__c).MH_History_Detailed__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.MH_History_Detailed3__c == NULL && conmap.get(regup.Client3__c).MH_History_Detailed__c != NULL){
                    prepopulate = TRUE;
                    regup.MH_History_Detailed3__c=conmap.get(regup.Client3__c).MH_History_Detailed__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Most_Recent_Dental_Exam__c == NULL && conmap.get(regup.Client__c).Most_Recent_Dental_Exam__c != NULL){
                    prepopulate = TRUE;
                    regup.Most_Recent_Dental_Exam__c=conmap.get(regup.Client__c).Most_Recent_Dental_Exam__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Most_Recent_Dental_Exam2__c == NULL && conmap.get(regup.Client2__c).Most_Recent_Dental_Exam__c != NULL){
                    prepopulate = TRUE;
                    regup.Most_Recent_Dental_Exam2__c=conmap.get(regup.Client2__c).Most_Recent_Dental_Exam__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Most_Recent_Dental_Exam3__c == NULL && conmap.get(regup.Client3__c).Most_Recent_Dental_Exam__c != NULL){
                    prepopulate = TRUE;
                    regup.Most_Recent_Dental_Exam3__c=conmap.get(regup.Client3__c).Most_Recent_Dental_Exam__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Most_Recent_Hearing_Exam__c == NULL && conmap.get(regup.Client__c).Most_Recent_Hearing_Exam__c != NULL){
                    prepopulate = TRUE;
                    regup.Most_Recent_Hearing_Exam__c=conmap.get(regup.Client__c).Most_Recent_Hearing_Exam__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Most_Recent_Hearing_Exam2__c == NULL && conmap.get(regup.Client2__c).Most_Recent_Hearing_Exam__c != NULL){
                    prepopulate = TRUE;
                    regup.Most_Recent_Hearing_Exam2__c=conmap.get(regup.Client2__c).Most_Recent_Hearing_Exam__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Most_Recent_Hearing_Exam3__c == NULL && conmap.get(regup.Client3__c).Most_Recent_Hearing_Exam__c != NULL){
                    prepopulate = TRUE;
                    regup.Most_Recent_Hearing_Exam3__c=conmap.get(regup.Client3__c).Most_Recent_Hearing_Exam__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Most_Recent_Physical__c == NULL && conmap.get(regup.Client__c).Most_Recent_Physical__c != NULL){
                    prepopulate = TRUE;
                    regup.Most_Recent_Physical__c=conmap.get(regup.Client__c).Most_Recent_Physical__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Most_Recent_Physical2__c == NULL && conmap.get(regup.Client2__c).Most_Recent_Physical__c != NULL){
                    prepopulate = TRUE;
                    regup.Most_Recent_Physical2__c=conmap.get(regup.Client2__c).Most_Recent_Physical__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Most_Recent_Physical3__c == NULL && conmap.get(regup.Client3__c).Most_Recent_Physical__c != NULL){
                    prepopulate = TRUE;
                    regup.Most_Recent_Physical3__c=conmap.get(regup.Client3__c).Most_Recent_Physical__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Most_Recent_Vision_Exam__c == NULL && conmap.get(regup.Client__c).Most_Recent_Vision_Exam__c != NULL){
                    prepopulate = TRUE;
                    regup.Most_Recent_Vision_Exam__c=conmap.get(regup.Client__c).Most_Recent_Vision_Exam__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Most_Recent_Vision_Exam2__c == NULL && conmap.get(regup.Client2__c).Most_Recent_Vision_Exam__c != NULL){
                    prepopulate = TRUE;
                    regup.Most_Recent_Vision_Exam2__c=conmap.get(regup.Client2__c).Most_Recent_Vision_Exam__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Most_Recent_Vision_Exam3__c == NULL && conmap.get(regup.Client3__c).Most_Recent_Vision_Exam__c != NULL){
                    prepopulate = TRUE;
                    regup.Most_Recent_Vision_Exam3__c=conmap.get(regup.Client3__c).Most_Recent_Vision_Exam__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Operations_Injuries__c == NULL && conmap.get(regup.Client__c).Operations_Injuries__c != NULL){
                    prepopulate = TRUE;
                    regup.Operations_Injuries__c=conmap.get(regup.Client__c).Operations_Injuries__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Operations_Injuries2__c == NULL && conmap.get(regup.Client2__c).Operations_Injuries__c != NULL){
                    prepopulate = TRUE;
                    regup.Operations_Injuries2__c=conmap.get(regup.Client2__c).Operations_Injuries__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Operations_Injuries3__c == NULL && conmap.get(regup.Client3__c).Operations_Injuries__c != NULL){
                    prepopulate = TRUE;
                    regup.Operations_Injuries3__c=conmap.get(regup.Client3__c).Operations_Injuries__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Physician__c == NULL && conmap.get(regup.Client__c).Physician__c != NULL){
                    prepopulate = TRUE;
                    regup.Physician__c=conmap.get(regup.Client__c).Physician__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Physician_Name__c == NULL && conmap.get(regup.Client__c).Physician_Name__c != NULL){
                    prepopulate = TRUE;
                    regup.Physician_Name__c=conmap.get(regup.Client__c).Physician_Name__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Physician_Name2__c == NULL && conmap.get(regup.Client2__c).Physician_Name__c != NULL){
                    prepopulate = TRUE;
                    regup.Physician_Name2__c=conmap.get(regup.Client2__c).Physician_Name__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Physician_Name3__c == NULL && conmap.get(regup.Client3__c).Physician_Name__c != NULL){
                    prepopulate = TRUE;
                    regup.Physician_Name3__c=conmap.get(regup.Client3__c).Physician_Name__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Physician2__c == NULL && conmap.get(regup.Client2__c).Physician__c != NULL){
                    prepopulate = TRUE;
                    regup.Physician2__c=conmap.get(regup.Client2__c).Physician__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Physician3__c == NULL && conmap.get(regup.Client3__c).Physician__c != NULL){
                    prepopulate = TRUE;
                    regup.Physician3__c=conmap.get(regup.Client3__c).Physician__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.SSN__c == NULL && conmap.get(regup.Client__c).SSN__c != NULL){
                    prepopulate = TRUE;
                    regup.SSN__c=conmap.get(regup.Client__c).SSN__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.SSN2__c == NULL && conmap.get(regup.Client2__c).SSN__c != NULL){
                    prepopulate = TRUE;
                    regup.SSN2__c=conmap.get(regup.Client2__c).SSN__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.SSN3__c == NULL && conmap.get(regup.Client3__c).SSN__c != NULL){
                    prepopulate = TRUE;
                    regup.SSN3__c=conmap.get(regup.Client3__c).SSN__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Takes_Medication__c == NULL && conmap.get(regup.Client__c).Takes_Medication__c != NULL){
                    prepopulate = TRUE;
                    regup.Takes_Medication__c=conmap.get(regup.Client__c).Takes_Medication__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Takes_Medication2__c == NULL && conmap.get(regup.Client2__c).Takes_Medication__c != NULL){
                    prepopulate = TRUE;
                    regup.Takes_Medication2__c=conmap.get(regup.Client2__c).Takes_Medication__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Takes_Medication3__c == NULL && conmap.get(regup.Client3__c).Takes_Medication__c != NULL){
                    prepopulate = TRUE;
                    regup.Takes_Medication3__c=conmap.get(regup.Client3__c).Takes_Medication__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Allergies__c == NULL && conmap.get(regup.Client__c).Allergies__c != NULL){
                    prepopulate = TRUE;
                    regup.Allergies__c=conmap.get(regup.Client__c).Allergies__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Allergies2__c == NULL && conmap.get(regup.Client2__c).Allergies__c != NULL){
                    prepopulate = TRUE;
                    regup.Allergies2__c=conmap.get(regup.Client2__c).Allergies__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Allergies3__c == NULL && conmap.get(regup.Client3__c).Allergies__c != NULL){
                    prepopulate = TRUE;
                    regup.Allergies3__c=conmap.get(regup.Client3__c).Allergies__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Birthdate__c == NULL && conmap.get(regup.Client__c).Birthdate != NULL){
                    prepopulate = TRUE;
                    regup.Birthdate__c=conmap.get(regup.Client__c).Birthdate;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Birthdate2__c == NULL && conmap.get(regup.Client2__c).Birthdate != NULL){
                    prepopulate = TRUE;
                    regup.Birthdate2__c=conmap.get(regup.Client2__c).Birthdate;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Birthdate3__c == NULL && conmap.get(regup.Client3__c).Birthdate != NULL){
                    prepopulate = TRUE;
                    regup.Birthdate3__c=conmap.get(regup.Client3__c).Birthdate;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.Email__c == NULL && conmap.get(regup.Caregiver_Parent__c).Email != NULL){
                    prepopulate = TRUE;
                    regup.Email__c=conmap.get(regup.Caregiver_Parent__c).Email;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.Email2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).Email != NULL){
                    prepopulate = TRUE;
                    regup.Email2__c=conmap.get(regup.Caregiver_Parent2__c).Email;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.FirstName__c == NULL && conmap.get(regup.Caregiver_Parent__c).FirstName != NULL){
                    prepopulate = TRUE;
                    regup.FirstName__c=conmap.get(regup.Caregiver_Parent__c).FirstName;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.FirstName2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).FirstName != NULL){
                    prepopulate = TRUE;
                    regup.FirstName2__c=conmap.get(regup.Caregiver_Parent2__c).FirstName;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.FirstName3__c == NULL && conmap.get(regup.Client__c).FirstName != NULL){
                    prepopulate = TRUE;
                    regup.FirstName3__c=conmap.get(regup.Client__c).FirstName;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.FirstName3__c == NULL && conmap.get(regup.Client2__c).FirstName != NULL){
                    prepopulate = TRUE;
                    regup.FirstName3__c=conmap.get(regup.Client2__c).FirstName;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.FirstName3__c == NULL && conmap.get(regup.Client3__c).FirstName != NULL){
                    prepopulate = TRUE;
                    regup.FirstName3__c=conmap.get(regup.Client3__c).FirstName;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.Household_Monthly_Income__c == NULL && conmap.get(regup.Caregiver_Parent__c).Household_Monthly_Income__c != NULL){
                    prepopulate = TRUE;
                    regup.Household_Monthly_Income__c=conmap.get(regup.Caregiver_Parent__c).Household_Monthly_Income__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.Household_Monthly_Income2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).Household_Monthly_Income__c != NULL){
                    prepopulate = TRUE;
                    regup.Household_Monthly_Income2__c=conmap.get(regup.Caregiver_Parent2__c).Household_Monthly_Income__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.Housing_Ownership__c == NULL && conmap.get(regup.Caregiver_Parent__c).Housing_Ownership__c != NULL){
                    prepopulate = TRUE;
                    regup.Housing_Ownership__c=conmap.get(regup.Caregiver_Parent__c).Housing_Ownership__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.Housing_Ownership2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).Housing_Ownership__c != NULL){
                    prepopulate = TRUE;
                    regup.Housing_Ownership2__c=conmap.get(regup.Caregiver_Parent2__c).Housing_Ownership__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.Housing_Type__c == NULL && conmap.get(regup.Caregiver_Parent__c).Housing_Type__c != NULL){
                    prepopulate = TRUE;
                    regup.Housing_Type__c=conmap.get(regup.Caregiver_Parent__c).Housing_Type__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.Housing_Type2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).Housing_Type__c != NULL){
                    prepopulate = TRUE;
                    regup.Housing_Type2__c=conmap.get(regup.Caregiver_Parent2__c).Housing_Type__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.How_do_you_hear_about_us__c == NULL && conmap.get(regup.Caregiver_Parent__c).How_do_you_hear_about_us__c != NULL){
                    prepopulate = TRUE;
                    regup.How_do_you_hear_about_us__c=conmap.get(regup.Caregiver_Parent__c).How_do_you_hear_about_us__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.LastName__c == NULL && conmap.get(regup.Caregiver_Parent__c).LastName != NULL){
                    prepopulate = TRUE;
                    regup.LastName__c=conmap.get(regup.Caregiver_Parent__c).LastName;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.LastName2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).LastName != NULL){
                    prepopulate = TRUE;
                    regup.LastName2__c=conmap.get(regup.Caregiver_Parent2__c).LastName;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.LastName3__c == NULL && conmap.get(regup.Client__c).LastName != NULL){
                    prepopulate = TRUE;
                    regup.LastName3__c=conmap.get(regup.Client__c).LastName;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.LastName3__c == NULL && conmap.get(regup.Client2__c).LastName != NULL){
                    prepopulate = TRUE;
                    regup.LastName3__c=conmap.get(regup.Client2__c).LastName;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.LastName3__c == NULL && conmap.get(regup.Client3__c).LastName != NULL){
                    prepopulate = TRUE;
                    regup.LastName3__c=conmap.get(regup.Client3__c).LastName;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.MailingCity__c == NULL && conmap.get(regup.Caregiver_Parent__c).MailingCity != NULL){
                    prepopulate = TRUE;
                    regup.MailingCity__c=conmap.get(regup.Caregiver_Parent__c).MailingCity;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.MailingCity2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).MailingCity != NULL){
                    prepopulate = TRUE;
                    regup.MailingCity2__c=conmap.get(regup.Caregiver_Parent2__c).MailingCity;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.MailingPostalCode__c == NULL && conmap.get(regup.Caregiver_Parent__c).MailingPostalCode != NULL){
                    prepopulate = TRUE;
                    regup.MailingPostalCode__c=conmap.get(regup.Caregiver_Parent__c).MailingPostalCode;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.MailingPostalCode2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).MailingPostalCode != NULL){
                    prepopulate = TRUE;
                    regup.MailingPostalCode2__c=conmap.get(regup.Caregiver_Parent2__c).MailingPostalCode;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.MailingState__c == NULL && conmap.get(regup.Caregiver_Parent__c).MailingState != NULL){
                    prepopulate = TRUE;
                    regup.MailingState__c=conmap.get(regup.Caregiver_Parent__c).MailingState;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.MailingState2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).MailingState != NULL){
                    prepopulate = TRUE;
                    regup.MailingState2__c=conmap.get(regup.Caregiver_Parent2__c).MailingState;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.MailingStreet__c == NULL && conmap.get(regup.Caregiver_Parent__c).MailingStreet != NULL){
                    prepopulate = TRUE;
                    regup.MailingStreet__c=conmap.get(regup.Caregiver_Parent__c).MailingStreet;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.MailingStreet2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).MailingStreet != NULL){
                    prepopulate = TRUE;
                    regup.MailingStreet2__c=conmap.get(regup.Caregiver_Parent2__c).MailingStreet;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.MobilePhone__c == NULL && conmap.get(regup.Caregiver_Parent__c).MobilePhone != NULL){
                    prepopulate = TRUE;
                    regup.MobilePhone__c=conmap.get(regup.Caregiver_Parent__c).MobilePhone;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.MobilePhone2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).MobilePhone != NULL){
                    prepopulate = TRUE;
                    regup.MobilePhone2__c=conmap.get(regup.Caregiver_Parent2__c).MobilePhone;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.WorkPhone__c == NULL && conmap.get(regup.Caregiver_Parent__c).npe01__WorkPhone__c != NULL){
                    prepopulate = TRUE;
                    regup.WorkPhone__c=conmap.get(regup.Caregiver_Parent__c).npe01__WorkPhone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.WorkPhone2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).npe01__WorkPhone__c != NULL){
                    prepopulate = TRUE;
                    regup.WorkPhone2__c=conmap.get(regup.Caregiver_Parent2__c).npe01__WorkPhone__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.Phone__c == NULL && conmap.get(regup.Caregiver_Parent__c).Phone != NULL){
                    prepopulate = TRUE;
                    regup.Phone__c=conmap.get(regup.Caregiver_Parent__c).Phone;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.Phone2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).Phone != NULL){
                    prepopulate = TRUE;
                    regup.Phone2__c=conmap.get(regup.Caregiver_Parent2__c).Phone;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.Physicians_Advice__c == NULL && conmap.get(regup.Client__c).Physicians_Advice__c != NULL){
                    prepopulate = TRUE;
                    regup.Physicians_Advice__c=conmap.get(regup.Client__c).Physicians_Advice__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.Physicians_Advice2__c == NULL && conmap.get(regup.Client2__c).Physicians_Advice__c != NULL){
                    prepopulate = TRUE;
                    regup.Physicians_Advice2__c=conmap.get(regup.Client2__c).Physicians_Advice__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.Physicians_Advice3__c == NULL && conmap.get(regup.Client3__c).Physicians_Advice__c != NULL){
                    prepopulate = TRUE;
                    regup.Physicians_Advice3__c=conmap.get(regup.Client3__c).Physicians_Advice__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.Place_of_Employment__c == NULL && conmap.get(regup.Caregiver_Parent__c).Place_of_Employment__c != NULL){
                    prepopulate = TRUE;
                    regup.Place_of_Employment__c=conmap.get(regup.Caregiver_Parent__c).Place_of_Employment__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.Place_of_Employment2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).Place_of_Employment__c != NULL){
                    prepopulate = TRUE;
                    regup.Place_of_Employment2__c=conmap.get(regup.Caregiver_Parent2__c).Place_of_Employment__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.Primary_Guardian_Relationship__c == NULL && conmap.get(regup.Caregiver_Parent__c).Primary_Guardian_Relationship__c != NULL){
                    prepopulate = TRUE;
                    regup.Primary_Guardian_Relationship__c=conmap.get(regup.Caregiver_Parent__c).Primary_Guardian_Relationship__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.Primary_Guardian_Relationship2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).Primary_Guardian_Relationship__c != NULL){
                    prepopulate = TRUE;
                    regup.Primary_Guardian_Relationship2__c=conmap.get(regup.Caregiver_Parent2__c).Primary_Guardian_Relationship__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.Receive_Public_Assistance__c == NULL && conmap.get(regup.Caregiver_Parent__c).Receive_Public_Assistance__c != NULL){
                    prepopulate = TRUE;
                    regup.Receive_Public_Assistance__c=conmap.get(regup.Caregiver_Parent__c).Receive_Public_Assistance__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.Receive_Public_Assistance2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).Receive_Public_Assistance__c != NULL){
                    prepopulate = TRUE;
                    regup.Receive_Public_Assistance2__c=conmap.get(regup.Caregiver_Parent2__c).Receive_Public_Assistance__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client__c)){
                    if(regup.School__c == NULL && conmap.get(regup.Client__c).School__c != NULL){
                    prepopulate = TRUE;
                    regup.School__c=conmap.get(regup.Client__c).School__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client2__c)){
                    if(regup.School2__c == NULL && conmap.get(regup.Client2__c).School__c != NULL){
                    prepopulate = TRUE;
                    regup.School2__c=conmap.get(regup.Client2__c).School__c;
                    }
                    }
                    if(conmap.containsKey(regup.Client3__c)){
                    if(regup.School3__c == NULL && conmap.get(regup.Client3__c).School__c != NULL){
                    prepopulate = TRUE;
                    regup.School3__c=conmap.get(regup.Client3__c).School__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.Source_of_Income__c == NULL && conmap.get(regup.Caregiver_Parent__c).Source_of_Income__c != NULL){
                    prepopulate = TRUE;
                    regup.Source_of_Income__c=conmap.get(regup.Caregiver_Parent__c).Source_of_Income__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.Source_of_Income2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).Source_of_Income__c != NULL){
                    prepopulate = TRUE;
                    regup.Source_of_Income2__c=conmap.get(regup.Caregiver_Parent2__c).Source_of_Income__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent__c)){
                    if(regup.Time_In_Residence__c == NULL && conmap.get(regup.Caregiver_Parent__c).Time_In_Residence__c != NULL){
                    prepopulate = TRUE;
                    regup.Time_In_Residence__c=conmap.get(regup.Caregiver_Parent__c).Time_In_Residence__c;
                    }
                    }
                    if(conmap.containsKey(regup.Caregiver_Parent2__c)){
                    if(regup.Time_In_Residence2__c == NULL && conmap.get(regup.Caregiver_Parent2__c).Time_In_Residence__c != NULL){
                    prepopulate = TRUE;
                    regup.Time_In_Residence2__c=conmap.get(regup.Caregiver_Parent2__c).Time_In_Residence__c;
                    }
                    }

                    if(prepopulate == TRUE){
                        regup.PrePopulateRegistration__c = FALSE;
                        upregs.add(regup);
                    }

            }

            if(!upregs.isEmpty()){
                update upregs;

                /*
                //Insert the Campaign Members
                if(!campmems.isEmpty()){

                    Database.SaveResult[] srList = Database.insert(campmems, false);

                    // Iterate through each returned result
                    for (Database.SaveResult sr : srList) {
                        if (sr.isSuccess()) {
                            // Operation was successful, so get the ID of the record that was processed
                            System.debug('Successfully inserted campaign member. Member ID: ' + sr.getId());
                        }
                        else {
                            // Operation failed, so get all errors                
                            for(Database.Error err : sr.getErrors()) {
                                System.debug('The following error has occurred.');                    
                                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                                System.debug('Campaign Member fields that affected this error: ' + err.getFields());
                            }
                        }
                    }
                }

                */
            }
        }

    }
}