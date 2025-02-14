/**
 * @description       : 
 * @author            : WINSupport
 * @group             : 
 * @last modified on  : 01-25-2021
 * @last modified by  : WINSupport
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   01-24-2021   WINSupport   Initial Version
**/
@isTest (seeAllData=false)
public class RegistrationUtilities_TC {
    public static testMethod void myTest(){

        Account acc = new Account(
            Name = 'School',                                  // Account Name
            //RecordTypeId = 'undefined',                         // Account Record Type
            Type = 'School',                                    // Type
            Phone = '(412) 215-6339',                           // Phone
            Fax = '(412) 215-6339'                            // Fax
            //KIDS_ID__c = '1',                                   // KIDS ID
        );
        insert acc;

        Contact YDS = new Contact(
            FirstName = 'YDS',
            LastName = 'YDS',
            GG_Staff_Status__c = 'Current',         // GG Staff Status
            //RecordTypeId = 'undefined',               // GG Family Member Record Type
            AccountId = acc.Id,                  // Account Name
            //YDS__c = 'undefined',                     // YDS or CM (u)
            KIDS_Supervisor__c = false,               // KIDS Supervisor
            KIDS_Manager_c__c = false,                // KIDS Manager
            npe01__PreferredPhone__c = 'Home',        // Preferred Phone
            npe01__Preferred_Email__c = 'Personal',   // Preferred Email
            DoNotCall = false,                        // Do Not Call
            HasOptedOutOfEmail = false,               // Email Opt Out
            npsp__is_Address_Override__c = false     // Address Override
        );
        insert YDS;

        Contact con1 = new Contact();
            //Current_Placement__c='undefined';//CurrentPlacement
            //KIDS_Active_Service_Episode_ID__c='12345';//KIDSActiveServiceEpisodeID
            //KIDS_ID__c='12345';//KIDSID
            //KIDS_Service_Episode_Id__c='1'//KIDSServiceEpisodeId
            //RecordTypeId='undefined';//GGFamilyMemberRecordType
            //Referral_Source__c='undefined';//ReferralSource
            con1.Abuse__c='Emotional';//Abuse
            con1.AccountId=acc.Id;
            con1.Act_33__c=date.Today();//Act33Complete
            con1.Act_34__c=date.Today();//Act34Compete
            con1.Active_Status__c='Active';//ActiveStatus
            con1.Agency_Involvement__c='Agency Involvement';//AgencyInvolvement
            con1.Allergies__c='Food';//Allergies
            con1.Allergies_Detailed__c='Allergies Detailed';//AllergiesDetailed
            con1.Alt_Transportation__c=false;//Alt.Transportation
            con1.Appropriate_Age__c='Freshmen Group';//AppropriateAge
            con1.Approved_Pick_Up_1__c='ApprovedPickUp1';//ApprovedPickUp1
            con1.Approved_Pick_Up_1_Phone__c='(412)215-6339';//ApprovedPickUp1Phone
            con1.Approved_Pick_Up_1_Relationship__c='Family';//ApprovedPickUp1Relationship
            con1.Approved_Pick_Up_2__c='ApprovedPickUp2';//ApprovedPickUp2
            con1.Approved_Pick_Up_2_Phone__c='(412)215-6339';//ApprovedPickUp2Phone
            con1.Approved_Pick_Up_2_Relationship__c='Family';//ApprovedPickUp2Relationship
            con1.Approved_Pick_Up_3__c='ApprovedPickup3';//ApprovedPickUp3
            con1.Approved_Pick_Up_3_Phone__c='(412)215-6339';//ApprovedPickUp3Phone
            con1.Approved_Pick_Up_3_Relationship__c='Family';//ApprovedPickUp3Relationship
            con1.Approved_Pick_Up_4__c='ApprovedPickUp4';//ApprovedPickUp4
            con1.Approved_Pick_Up_4_Phone__c='(412)215-6339';//ApprovedPickUp4Phone
            con1.Approved_Pick_Up_4_Relationship__c='Family';//ApprovedPickUp4Relationship
            con1.Attendance__c='Fair';//Attendance
            con1.Began_Services__c=date.Today();//BeganServices
            con1.Behavior_Problems__c=false;//BehaviorProblems
            con1.Behavioral_Issues__c='RAW';//BehavioralIssues
            con1.Behavioral_Issues_other__c='Behavioral Issues';//BehavioralIssues(other)
            con1.Between_8_18__c=false;//Between8-18
            con1.Birthdate__c=date.Today();//Birthdate
            con1.Child_will_Attend_Afterschool__c='Monday';//ChildwillAttendAfterschool
            con1.Children__c=0;//No.ofChildren
            con1.Comments__c='Comments';//Comments
            con1.Community_Activities__c=false;//CommunityActivities
            con1.Community_Collaborative__c=false;//CommunityCollaborative
            con1.Community_Resources__c='Good';//CommunityResources
            con1.Community_Service__c=12345;//CommunityService
            con1.Confidentiality_Statement__c=false;//ConfidentialityStatement
            con1.Conflicts_wParents__c=false;//Conflictsw/Parents
            con1.ConsentReturn_Unsupervised__c=false;//ConsenttoReturnUnsupervised
            con1.Contact_Type__c='Donor';//ContactType
            con1.Contraception__c='No';//Contraception
            con1.Court_Active__c=false;//CourtActive
            con1.Court_Referral__c=false;//CourtReferral
            con1.Current_DA_Concerns__c='Yes';//CurrentD/AConcerns
            con1.Current_Living_Situation__c='Birth Parents';//CurrentLivingSituation
            con1.CYF_Active__c=false;//CYFActive
            con1.CYF_Case_Worker__c='CaseWorker';//CYFCaseWorker
            con1.DA_Concerns_Detailed__c='DAConcernsDetailed';//D/AConcernsDetailed
            con1.DA_History__c='No';//D/AHistory
            con1.DA_Pregnancy__c='DADuringPregnancy';//D/ADuringPregnancy
            con1.Date_Grade_Level_Last_Set__c=date.Today();//DateGradeLevelLastSet
            con1.Date_of_Placement__c=date.Today();//DateofPlacement
            con1.Deferment_Reason__c='None';//DefermentReason
            con1.Developmental_Delay__c='Speech';//DevelopmentalDelay
            con1.Dietary_Requirements__c='Dietary Requirements';//DietaryRequirements
            con1.DoNotCall=false;//DoNotCall
            con1.Email='test@gmail.com';//Email
            con1.Emergency_Contact_2_Cell_Phone__c='(412)215-6339';//EmergencyContact2CellPhone
            con1.Emergency_Contact_2_First__c='EC2First';//EmergencyContact2First
            con1.Emergency_Contact_2_Last__c='EC2Last';//EmergencyContact2Last
            con1.Emergency_Contact_2_Phone__c='(412)215-6339';//EmergencyContact2Phone
            con1.Emergency_Contact_Cell_Phone__c='ECCellPhone';//EmergencyContactCellPhone
            con1.Emergency_Contact_First__c='ECFirst';//EmergencyContactFirst
            con1.Emergency_Contact_Last__c='ECLast';//EmergencyContactLast
            con1.Emergency_Contact_Phone__c='(412)215-6339';//EmergencyContactPhone
            con1.Emergency_Contact_Relationship__c='Family';//EmergencyContactRelationship
            con1.Emergency_Information__c=date.Today();//EmergencyInformation
            con1.Employed__c='Unemployed';//Employed
            con1.Eye_Color__c='Brown';//EyeColor
            con1.Family_Handbook_Acceptance__c=false;//FamilyHandbookAcceptance
            con1.Fathers_Involvement__c='Fathers Involvement';//Father'sInvolvement
            con1.FERPA__c=date.Today();//FERPA
            con1.FirstName='Con1';
            con1.Form_Completed__c=date.Today();//FormCompleted
            con1.Gender__c='Female';//Gender
            con1.GG_Staff_Status__c='Current';//GGStaffStatus
            con1.GPA__c='A-4.0';//GPA
            con1.Grade__c='1';//GradeLevel
            con1.Grade_History__c='Fair';//GradeHistory
            con1.Graduated__c=false;//Graduated
            con1.Graduation_Date__c=date.Today();//GraduationDate
            con1.Graduation_Type__c='GED';//GraduationType
            con1.Group_Expectations__c=false;//GroupExpectations
            con1.Group_Rules_Agreement__c=false;//GroupRulesAgreement
            con1.Guardian_City__c='Pittsburgh';//GuardianMailingCity
            con1.Guardian_State__c='PA';//GuardianMailingState
            con1.Guardian_Street__c='Guardian Street';//GuardianStreet
            con1.Guardian_Zip__c='15203';//GuardianZip/PostalCode
            con1.GW_Volunteers__Volunteer_Auto_Reminder_Email_Opt_Out__c=false;//VolunteerAuto-ReminderEmailOptOut
            con1.Had_illness__c='Measles';//HadIllness
            con1.Hair_Color__c='Black';//HairColor
            con1.HasOptedOutOfEmail=false;//EmailOptOut
            con1.HasOptedOutOfFax=false;//FaxOptOut
            con1.Height_feet__c=4;//Height(feet)
            con1.Height_inches__c=6;//Height(inches)
            con1.History_of_Abuse__c='Yes';//HistoryofAbuse
            con1.HomePhone='(412)215-6339';//HomePhone
            con1.Household_Monthly_Income__c=100;//HouseholdMonthlyIncome
            con1.Housing_Ownership__c='Rent';//HousingOwnership
            con1.Housing_Type__c='Single Family';//HousingType
            con1.How_do_you_hear_about_us__c='HowDidYouHear';//Howdoyouhearaboutus
            con1.Identifying_Marks__c='None';//IdentifyingMarks
            con1.IEP__c=false;//IEP
            con1.IEP_Review__c=date.Today();//IEPReview
            con1.In_School__c=false;//InSchool
            con1.Income_Source__c='IncomeSource';//IncomeSource
            con1.Insurance_Number__c=12345;//InsuranceNumber
            con1.Insurance_Provider__c='InsuranceProvider';//InsuranceProvider
            con1.Interest_Areas__c='Feeling better about myself';//InterestAreas
            con1.Interests_Specialty_Group__c=false;//InterestsinSpecialtyGroup
            con1.Intervention_Plan__c=false;//InterventionPlan
            con1.Juvenile_Probation__c='Juvenile Probation';//JuvenileProbation
            con1.KIDS_Manager_c__c=false;//KIDSManager
            con1.KIDS_Supervisor__c=false;//KIDSSupervisor
            con1.Language__c='English';//Language
            con1.Last_Physical_MM_YYYY__c='01/2021';//LastPhysical(MM/YYYY)`
            con1.LastName='Con2';
            con1.LeadSource='Web';//LeadSource
            con1.LMP__c=date.Today();//LMP
            con1.Medical_Needs__c='MedicalNeeds';//MedicalNeeds
            con1.Medical_Release__c=false;//MedicalRelease
            con1.Medications__c='Medications';//Medications
            con1.Menarche__c='Menarche';//Menarche
            con1.Menses__c='Menses';//Menses
            con1.Mental_Health_History__c='Yes';//MentalHealthHistory
            con1.Mentoring_101__c=date.Today();//Mentoring101Completed
            con1.MH_History_Detailed__c='MHHistoryDetailed';//MHHistoryDetailed
            con1.Missed_School__c=23;//MissedSchool
            con1.Mobile_Phone__c='(412)215-6339';//MobilePhone
            con1.MobilePhone='(412)215-6339';//Mobile
            con1.Most_Recent_Contact_Summary__c=date.Today();//MostRecentContactSummary
            con1.Most_Recent_Dental_Exam__c=date.Today();//MostRecentDentalExam
            con1.Most_Recent_Hearing_Exam__c=date.Today();//MostRecentHearingExam
            con1.Most_Recent_Physical__c=date.Today();//MostRecentPhysical
            con1.Most_Recent_Program_Participation__c=date.Today();//MostRecentProgramParticipation
            con1.Most_Recent_Touch_Point__c=date.Today();//MostRecentTouchPoint
            con1.Most_Recent_Vision_Exam__c=date.Today();//MostRecentVisionExam
            con1.npe01__AlternateEmail__c='test@gmail.com';//AlternateEmail
            con1.npe01__HomeEmail__c='test@gmail.com';//PersonalEmail
            con1.npe01__Preferred_Email__c='Personal';//PreferredEmail
            con1.npe01__PreferredPhone__c='Home';//PreferredPhone
            con1.npe01__Private__c=false;//Private
            con1.npo02__AverageAmount__c=0.00;//AverageGift
            con1.npo02__MembershipEndDate__c=date.Today();//MembershipEndDate
            con1.npo02__MembershipJoinDate__c=date.Today();//MembershipJoinDate
            con1.npsp__Do_Not_Contact__c=false;//DoNotContact
            con1.Number_of_Active_Primary_Children__c=3;//NumberofActivePrimaryChildren
            con1.Number_of_Primary_Children__c=3;//NumberofPrimaryChildren
            con1.Operations_Injuries__c='OperationsInjuries';//Operations/Injuries
            con1.Other_Caregiver_First__c='OtherCaregiverFirst';//OtherCaregiverFirst
            con1.Other_Caregiver_Last__c='OtherCaregiverLast';//OtherCaregiverLast
            con1.Other_Grade_Level__c='OtherGradeLevel';//OtherGradeLevel
            con1.Other_Guardian_Relationship__c='Friend';//OtherGuardianRelationshipType
            con1.Other_Phone__c='(412)215-6339';//OtherPhone
            con1.Out_of_C_S__c=false;//OutofCounty/State
            con1.Parenting__c=false;//Parenting
            con1.Partners__c=0;//No.ofPartners
            con1.Permission_to_Photograph__c=false;//PermissiontoPhotograph
            con1.Phone='(412)215-6339';//Phone
            con1.Physician__c='(412)215-6339';//Physician#
            con1.Physician_Facility__c='Physician Facility';//PhysicianFacility
            con1.Physician_Name__c='PhysicianName';//PhysicianName
            con1.Physicians_Advice__c='PhysiciansAdvice';//Physician'sAdvice
            con1.PIN__c='1234';//PIN(RegistrationForm)
            con1.Place_of_Employment__c='None';//PlaceofEmployment
            con1.Placement_Type__c='FH';//PlacementType
            con1.Pregnancy_Term__c='PregnancyTerm';//PregnancyTerm
            con1.Pregnancy_Trem__c='0';//PregnancyTrem
            con1.Pregnant_Parenting__c=false;//Pregnant/Parenting
            con1.PreGroup_Assessment__c=false;//Pre-GroupAssessment
            con1.Previous_Placements__c='Previous Placements';//PreviousPlacements
            con1.Primary_Guardian_First__c='PrimaryGuardianFirst';//PrimaryGuardianFirst
            con1.Primary_Guardian_Last__c='PrimaryGuardianLast';//PrimaryGuardianLast
            con1.Primary_Guardian_Relationship__c='Aunt';//PrimaryGuardianRelationshipType
            con1.PRN__c='PRN';//PRN
            con1.Problems_in_School__c=false;//ProblemsinSchool
            con1.Race__c='Caucasion';//Race
            con1.Reason_for_Deferment__c='ReasonforDeferment';//ReasonforDeferment
            con1.Receive_Public_Assistance__c='Yes';//ReceivePublicAssistance
            con1.Recent_IEP__c=date.Today();//RecentIEP
            con1.Recipient_ID__c=1;//RecipientID
            con1.Recommendation__c='Immediate Enrollment';//Recommendation
            con1.Referal_Completed__c='Telephone';//ReferralCompleted
            con1.Referral_Reason__c='ReferralReason';//ReferralReason
            con1.Referral_Received__c=dateTime.Now();//ReferralReceived
            con1.Referral_Recieved__c=dateTime.Now();//ReferralRecieved
            con1.Referral_Source_First__c='ReferralSourceFirst';//ReferralSourceFirst
            con1.Referral_Source_Last__c='ReferralSourceLast';//ReferralSourceLast
            con1.Referral_Source_Relationship__c='ReferralSourceRelationship';//ReferralSourceRelationship
            con1.Referral_Source_Type__c='Self';//ReferralSourceType
            con1.Referral_Type__c='East End';//ReferralType
            con1.Regional_Office__c='(412)215-6339';//RegionalOffice#
            con1.Release_Info_Consent__c=false;//ReleaseInfoConsent
            con1.Restitution__c=12345;//Restitution
            con1.Rewards_Points_Policy__c=false;//Rewards&PointsPolicy
            con1.Role__c='Parent';//Role
            con1.Salary__c=1000;//Salary
            con1.School__c=acc.Id;//School
            con1.School_Problems_Detailed__c='SchoolProblemsDetailed';//SchoolProblemsDetailed
            con1.Screening_Labs__c=false;//Screening&Labs
            con1.Sexual_Abuse__c='Sexual Abuse';//SexualAbuse
            con1.Sexually_Active__c=false;//SexuallyActive
            con1.Sickle_Cell__c=false;//SickleCell
            con1.Smokes_Cigarettes__c=false;//SmokesCigarettes
            con1.Source_of_Income__c='Employment';//SourceofIncome
            con1.SSN__c='***-**-5667';//SSN
            con1.Status__c='Referral';//Status
            con1.STD_Treatment__c='None';//STDTreatment
            con1.Takes_Medication__c='Consistent';//TakesMedication
            con1.Television_R_V__c=false;//Television/Radio/Video
            con1.Transportation_Consent__c=false;//TransportationConsent
            con1.Type__c='Prevention';//Type
            con1.Weight__c=80;//Weight
            con1.YDS_or_CM_c__c=YDS.Id;//YDSorCM(c)
        insert con1;

        List<Contact> cons = new List<Contact>();

        Contact con2 = con1.clone(false, false, false, false);
        cons.add(con2);
        Contact con3 = con1.clone(false, false, false, false);
        cons.add(con3);
        Contact con4 = con1.clone(false, false, false, false);
        cons.add(con4);
        Contact con5 = con1.clone(false, false, false, false);
        cons.add(con5);
        Contact con6 = con1.clone(false, false, false, false);
        cons.add(con6);
        Contact con7 = con1.clone(false, false, false, false);
        cons.add(con7);

        insert cons;

        Registration__c reg = new Registration__c();

        reg.Client__c = con1.Id;
        reg.Client2__c = con2.Id;
        reg.Client3__c = con3.Id;
        reg.Caregiver_Parent__c = con4.Id;
        reg.Caregiver_Parent__c = con5.Id;
        reg.Caregiver_Parent2__c = con6.Id;
        reg.Caregiver_Parent2__c = con7.Id;
        reg.YDS_or_CM_c__c = YDS.Id;

        insert reg;

        test.startTest();

            Set<Id> rids = new Set<Id>();
            rids.add(reg.Id);
            RegistrationUtilities.prepopulate(rids);


        test.stopTest();

    }

}