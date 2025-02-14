/**********************************************************************
* Name:     WSTestIntakeTools
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     19 June 2017
* ======================================================
* ======================================================
* Purpose:                                                           
* Test Class for Intake Tools
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       22 Feb 2017     TGM         Development
* 2.0       19 June 2017    TGM         Modifications for YDS CM Reference
***********************************************************************/
@isTest
private class WSTestIntakeTools {

	// public static Intake__c theIntake;

	static testMethod void unitTest1(){ //Insert Intake
		Test.startTest();
		List<Intake__c> ins = new List<Intake__c>();
		Set<Id> ids = new Set<Id>();
		WSIntakeTools.beforeInsertIntake(ins);
		WSIntakeTools.createContactfromIntake(ids);
		WSIntakeTools.createCaseFromIntake(ids);
		WSIntakeTools.createFormfromIntake(ids);
		WSIntakeUpdateFormTools.updateRelatedRecords(ids);
		Test.stopTest();
		
		/*

		WSCustomAdminSettings__c settings = WSCustomAdminSettings__c.getInstance();
		String ParentRecordType = settings.Parent_Contact_Record_Type__c;
		String ClientRecordType = settings.Client_Contact_Default_Record_Type__c;
		String OtherRecordType = settings.Other_Contact_Record_Type__c;

		Intake__c i = new Intake__c ();

		i.Intake_Status__c = 'Complete';

		//Picklists

		i.Abstraction__c  = WSUtilities.getPickValues('Abstraction__c')[0]; //Picklist
		i.Abuse__c  = WSUtilities.getPickValues('Abuse__c')[0]; //Picklist (Multi-Select)
		i.Activities__c  = WSUtilities.getPickValues('Activities__c')[0]; //Picklist (Multi-Select)
		i.Affect__c  = WSUtilities.getPickValues('Affect__c')[0]; //Picklist
		i.Allergies__c  = WSUtilities.getPickValues('Allergies__c')[0]; //Picklist (Multi-Select)
		i.Attendance__c  = WSUtilities.getPickValues('Attendance__c')[0]; //Picklist
		i.Attention__c  = WSUtilities.getPickValues('Attention__c')[0]; //Picklist
		i.Attitude__c  = WSUtilities.getPickValues('Attitude__c')[0]; //Picklist
		i.Behavioral_Issues__c  = WSUtilities.getPickValues('Behavioral_Issues__c')[0]; //Picklist (Multi-Select)
		i.Boundaries__c  = WSUtilities.getPickValues('Boundaries__c')[0]; //Picklist
		i.Child_will_Attend_Afterschool__c  = WSUtilities.getPickValues('Child_will_Attend_Afterschool__c')[0]; //Picklist (Multi-Select)
		i.Clothing__c  = WSUtilities.getPickValues('Clothing__c')[0]; //Picklist
		i.Community_Resources__c  = WSUtilities.getPickValues('Community_Resources__c')[0]; //Picklist
		i.Concentration__c  = WSUtilities.getPickValues('Concentration__c')[0]; //Picklist
		i.Coping_Ability__c  = WSUtilities.getPickValues('Coping_Ability__c')[0]; //Picklist
		i.Cosmetic_use__c  = WSUtilities.getPickValues('Cosmetic_use__c')[0]; //Picklist
		i.Course_Description__c  = WSUtilities.getPickValues('Course_Description__c')[0]; //Picklist
		i.Current_DA_Concerns__c  = WSUtilities.getPickValues('Current_DA_Concerns__c')[0]; //Picklist
		i.Current_Living_Situation__c  = WSUtilities.getPickValues('Current_Living_Situation__c')[0]; //Picklist
		i.DA_History__c  = WSUtilities.getPickValues('DA_History__c')[0]; //Picklist
		i.Decision_Making__c  = WSUtilities.getPickValues('Decision_Making__c')[0]; //Picklist
		i.Defective_Memory__c  = WSUtilities.getPickValues('Defective_Memory__c')[0]; //Picklist
		i.Developmental_Delay__c  = WSUtilities.getPickValues('Developmental_Delay__c')[0]; //Picklist
		i.Education_Program__c  = WSUtilities.getPickValues('Education_Program__c')[0]; //Picklist
		i.Education_Type__c  = WSUtilities.getPickValues('Education_Type__c')[0]; //Picklist
		i.Educational_Support__c  = WSUtilities.getPickValues('Educational_Support__c')[0]; //Picklist
		i.Eye_Contact__c  = WSUtilities.getPickValues('Eye_Contact__c')[0]; //Picklist
		i.Facial_Expresion__c  = WSUtilities.getPickValues('Facial_Expresion__c')[0]; //Picklist
		i.Family_Discussion__c  = WSUtilities.getPickValues('Family_Discussion__c')[0]; //Picklist
		i.Family_Functioning_Level__c  = WSUtilities.getPickValues('Family_Functioning_Level__c')[0]; //Picklist (Multi-Select)
		i.Fund_Knowledge__c  = WSUtilities.getPickValues('Fund_Knowledge__c')[0]; //Picklist
		i.Gender__c  = WSUtilities.getPickValues('Gender__c')[0]; //Picklist
		i.GPA__c  = WSUtilities.getPickValues('GPA__c')[0]; //Picklist
		i.Grade_History__c  = WSUtilities.getPickValues('Grade_History__c')[0]; //Picklist
		i.Graduation_Type__c  = WSUtilities.getPickValues('Graduation_Type__c')[0]; //Picklist
		i.Grooming__c  = WSUtilities.getPickValues('Grooming__c')[0]; //Picklist
		i.Guardian_State__c  = WSUtilities.getPickValues('Guardian_State__c')[0]; //Picklist
		i.Had_illness__c  = WSUtilities.getPickValues('Had_illness__c')[0]; //Picklist (Multi-Select)
		i.Hallucination__c  = WSUtilities.getPickValues('Hallucination__c')[0]; //Picklist
		i.History_Domestic_Violence__c  = WSUtilities.getPickValues('History_Domestic_Violence__c')[0]; //Picklist
		i.History_of_Abuse__c  = WSUtilities.getPickValues('History_of_Abuse__c')[0]; //Picklist
		i.Hobbies__c  = WSUtilities.getPickValues('Hobbies__c')[0]; //Picklist (Multi-Select)
		i.Household_Rules__c  = WSUtilities.getPickValues('Household_Rules__c')[0]; //Picklist
		i.Housing__c  = WSUtilities.getPickValues('Housing__c')[0]; //Picklist
		i.Income_Source__c  = WSUtilities.getPickValues('Income_Source__c')[0]; //Picklist
		i.Insight__c  = WSUtilities.getPickValues('Insight__c')[0]; //Picklist
		i.Intelligence__c  = WSUtilities.getPickValues('Intelligence__c')[0]; //Picklist
		i.Interest_Areas__c  = WSUtilities.getPickValues('Interest_Areas__c')[0]; //Picklist (Multi-Select)
		i.Judgment__c  = WSUtilities.getPickValues('Judgment__c')[0]; //Picklist
		i.Life_Skills__c  = WSUtilities.getPickValues('Life_Skills__c')[0]; //Picklist (Multi-Select)
		i.Mailing_Address_Type__c  = WSUtilities.getPickValues('Mailing_Address_Type__c')[0]; //Picklist
		i.Mailing_State__c  = WSUtilities.getPickValues('Mailing_State__c')[0]; //Picklist
		i.Mailing_State__c  = WSUtilities.getPickValues('Mailing_State__c')[0]; //Picklist
		i.Math__c  = WSUtilities.getPickValues('Math__c')[0]; //Picklist
		i.Medication_Compliance__c  = WSUtilities.getPickValues('Medication_Compliance__c')[0]; //Picklist
		i.Mental_Health_History__c  = WSUtilities.getPickValues('Mental_Health_History__c')[0]; //Picklist
		i.Mood__c  = WSUtilities.getPickValues('Mood__c')[0]; //Picklist
		i.Motor_Activity__c  = WSUtilities.getPickValues('Motor_Activity__c')[0]; //Picklist
		i.Organization__c  = WSUtilities.getPickValues('Organization__c')[0]; //Picklist
		i.Orientation__c  = WSUtilities.getPickValues('Orientation__c')[0]; //Picklist
		i.Other_Address_Type__c  = WSUtilities.getPickValues('Other_Address_Type__c')[0]; //Picklist
		i.Other_Address_Type__c  = WSUtilities.getPickValues('Other_Address_Type__c')[0]; //Picklist
		i.Other_Guardian_Relationship__c  = WSUtilities.getPickValues('Other_Guardian_Relationship__c')[0]; //Picklist
		i.Other_State__c  = WSUtilities.getPickValues('Other_State__c')[0]; //Picklist
		i.Other_State__c  = WSUtilities.getPickValues('Other_State__c')[0]; //Picklist
		i.Permanency_Goal__c  = WSUtilities.getPickValues('Permanency_Goal__c')[0]; //Picklist
		i.Posture__c  = WSUtilities.getPickValues('Posture__c')[0]; //Picklist
		i.Pre_Natal_Issues__c  = WSUtilities.getPickValues('Pre_Natal_Issues__c')[0]; //Picklist
		i.Preferred_Email__c  = WSUtilities.getPickValues('Preferred_Email__c')[0]; //Picklist
		i.Preferred_Email__c  = WSUtilities.getPickValues('Preferred_Email__c')[0]; //Picklist
		i.PreferredPhone__c  = WSUtilities.getPickValues('PreferredPhone__c')[0]; //Picklist
		i.PreferredPhone__c  = WSUtilities.getPickValues('PreferredPhone__c')[0]; //Picklist
		i.Preoccupation__c  = WSUtilities.getPickValues('Preoccupation__c')[0]; //Picklist
		i.Primary_Guardian_Relationship__c  = WSUtilities.getPickValues('Primary_Guardian_Relationship__c')[0]; //Picklist
		i.PSSA_Keystone__c  = WSUtilities.getPickValues('PSSA_Keystone__c')[0]; //Picklist
		i.Race__c  = WSUtilities.getPickValues('Race__c')[0]; //Picklist
		i.Race__c  = WSUtilities.getPickValues('Race__c')[0]; //Picklist
		i.Reading__c  = WSUtilities.getPickValues('Reading__c')[0]; //Picklist
		i.Reality_Testing__c  = WSUtilities.getPickValues('Reality_Testing__c')[0]; //Picklist
		i.Recall__c  = WSUtilities.getPickValues('Recall__c')[0]; //Picklist
		i.Recent_Grades__c  = WSUtilities.getPickValues('Recent_Grades__c')[0]; //Picklist
		i.Recommendation__c  = WSUtilities.getPickValues('Recommendation__c')[0]; //Picklist
		i.Referal_Completed__c  = WSUtilities.getPickValues('Referal_Completed__c')[0]; //Picklist
		i.Referral_Source_Type__c  = WSUtilities.getPickValues('Referral_Source_Type__c')[0]; //Picklist
		i.Referral_Type__c  = WSUtilities.getPickValues('Referral_Type__c')[0]; //Picklist
		i.Reward__c  = WSUtilities.getPickValues('Reward__c')[0]; //Picklist
		i.Service_Level__c  = WSUtilities.getPickValues('Service_Level__c')[0]; //Picklist
		i.SES_Program__c  = WSUtilities.getPickValues('SES_Program__c')[0]; //Picklist
		i.Sexual_Preference__c  = WSUtilities.getPickValues('Sexual_Preference__c')[0]; //Picklist
		i.Skill_Deficits__c  = WSUtilities.getPickValues('Skill_Deficits__c')[0]; //Picklist
		i.Social_Judgment__c  = WSUtilities.getPickValues('Social_Judgment__c')[0]; //Picklist
		i.Social_Maturity__c  = WSUtilities.getPickValues('Social_Maturity__c')[0]; //Picklist
		i.Speech__c  = WSUtilities.getPickValues('Speech__c')[0]; //Picklist
		i.Stature__c  = WSUtilities.getPickValues('Stature__c')[0]; //Picklist
		i.Stressors__c  = WSUtilities.getPickValues('Stressors__c')[0]; //Picklist
		// i.Supports__c  = WSUtilities.getPickValues('Supports__c')[0]; //Picklist
		// i.Target_Neighborhood__c  = WSUtilities.getPickValues('Target_Neighborhood__c')[0]; //Picklist
		// i.Thoughts__c  = WSUtilities.getPickValues('Thoughts__c')[0]; //Picklist
		i.Weight__c  = WSUtilities.getPickValues('Weight__c')[0]; //Picklist


		//Booleans

		Boolean TheBox;

		TheBox = TRUE;

		i.Court_Active__c  = TheBox; //Checkbox
		i.CYF_Active__C  = TheBox; //Checkbox
		i.Acne__c  = TheBox; //Checkbox
		i.Alt_Transportation__c  = TheBox; //Checkbox
		i.Awake_Alert__c  = TheBox; //Checkbox
		i.Behavior_Problems__c  = TheBox; //Checkbox
		i.Birthmarks__c  = TheBox; //Checkbox
		i.Bruises__c  = TheBox; //Checkbox
		i.Bullying_Perpetrator__c  = TheBox; //Checkbox
		i.Bullying_Victim__c  = TheBox; //Checkbox
		i.Campus_Visit__c  = TheBox; //Checkbox
		i.Career_Fair__c  = TheBox; //Checkbox
		i.Chores__c  = TheBox; //Checkbox
		i.Close_Friends__c  = TheBox; //Checkbox
		i.College_Board__c  = TheBox; //Checkbox
		i.Common_Application__c  = TheBox; //Checkbox
		i.Community_Activities__c  = TheBox; //Checkbox
		i.Community_Collaborative__c  = TheBox; //Checkbox
		i.Community_Service__c  = TheBox; //Checkbox
		i.Confidentiality_Statement__c  = TheBox; //Checkbox
		i.Conflicts_wParents__c  = TheBox; //Checkbox
		i.ConsentReturn_Unsupervised__c  = TheBox; //Checkbox
		i.Counseling__c  = TheBox; //Checkbox
		i.Curfew__c  = TheBox; //Checkbox
		i.Current_Schedule_Submittted__c  = TheBox; //Checkbox
		i.CYF_Advocate__c  = TheBox; //Checkbox
		i.December__c  = TheBox; //Checkbox
		i.Deformities__c  = TheBox; //Checkbox
		i.Detention__c  = TheBox; //Checkbox
		i.Disruptive__c  = TheBox; //Checkbox
		i.Dressed_Appropriate__c  = TheBox; //Checkbox
		i.Drug_Withdrawal__c  = TheBox; //Checkbox
		i.Expectations__c  = TheBox; //Checkbox
		i.Expulsions__c  = TheBox; //Checkbox
		i.Family_Handbook_Acceptance__c  = TheBox; //Checkbox
		i.February__c  = TheBox; //Checkbox
		i.Good_Hygiene__c  = TheBox; //Checkbox
		i.Graduated__c  = TheBox; //Checkbox
		i.Group_Expectations__c  = TheBox; //Checkbox
		i.Group_Rules_Agreement__c  = TheBox; //Checkbox
		i.Hyperactive__c  = TheBox; //Checkbox
		i.IEP__c  = TheBox; //Checkbox
		i.IL_Worker__c  = TheBox; //Checkbox
		i.In_School__c  = TheBox; //Checkbox
		i.Infestations__c  = TheBox; //Checkbox
		i.Initial__c  = TheBox; //Checkbox
		i.Interests_Specialty_Group__c  = TheBox; //Checkbox
		i.Interview_Skills__c  = TheBox; //Checkbox
		i.Inventory_35__c  = TheBox; //Checkbox
		i.Inventory_68__c  = TheBox; //Checkbox
		i.Inventory_912__c  = TheBox; //Checkbox
		i.Irritability__c  = TheBox; //Checkbox
		i.Issuesw_Parents_Friends__c  = TheBox; //Checkbox
		i.Issuesw_Siblings__c  = TheBox; //Checkbox
		i.JA_Biztown__c  = TheBox; //Checkbox
		i.January__c  = TheBox; //Checkbox
		i.Job_Application__c  = TheBox; //Checkbox
		i.Learning_Disability__c  = TheBox; //Checkbox
		i.Lesions__c  = TheBox; //Checkbox
		i.March__c  = TheBox; //Checkbox
		i.Medical_Collaborative__c  = TheBox; //Checkbox
		i.Medical_Release__c  = TheBox; //Checkbox
		i.Mentor_Program__c  = TheBox; //Checkbox
		i.Movements_Coordinated__c  = TheBox; //Checkbox
		i.Navience_Account__c  = TheBox; //Checkbox
		i.Needlemarks__c  = TheBox; //Checkbox
		i.No_Problems__c  = TheBox; //Checkbox
		i.November__c  = TheBox; //Checkbox
		i.October__c  = TheBox; //Checkbox
		i.Out_of_C_S__c  = TheBox; //Checkbox
		i.Permission_to_Photogragh__c  = TheBox; //Checkbox
		i.Personal_Wellness__c  = TheBox; //Checkbox
		i.Piercings__c  = TheBox; //Checkbox
		i.Pregnant_Parenting__c  = TheBox; //Checkbox
		i.PreGroup_Assessment__c  = TheBox; //Checkbox
		i.Problems_at_Work__c  = TheBox; //Checkbox
		i.Problems_in_School__c  = TheBox; //Checkbox
		i.Problems_wGuardian__c  = TheBox; //Checkbox
		i.PSAT_ACT__c  = TheBox; //Checkbox
		i.Quiet__c  = TheBox; //Checkbox
		i.Rash__c  = TheBox; //Checkbox
		i.Received_Rewards__c  = TheBox; //Checkbox
		i.Recommendation_Letter__c  = TheBox; //Checkbox
		i.Relationship__c  = TheBox; //Checkbox
		i.Release_Info_Consent__c  = TheBox; //Checkbox
		i.Religion_Importance__c  = TheBox; //Checkbox
		i.Resume__c  = TheBox; //Checkbox
		i.Rewards_Points_Policy__c  = TheBox; //Checkbox
		i.Runs_Away__c  = TheBox; //Checkbox
		i.Sad__c  = TheBox; //Checkbox
		i.SAT_Prep_Course__c  = TheBox; //Checkbox
		i.Scars__c  = TheBox; //Checkbox
		i.Secondary__c  = TheBox; //Checkbox
		i.Securing_Housing__c  = TheBox; //Checkbox
		i.Self_Advocacy__c  = TheBox; //Checkbox
		i.Serious_Relationship__c  = TheBox; //Checkbox
		i.Speech_Difficulties__c  = TheBox; //Checkbox
		// i.Suspension__c  = TheBox; //Checkbox
		// i.Tattoos__c  = TheBox; //Checkbox
		// i.Teacher_Peer_Interaction__c  = TheBox; //Checkbox
		i.Television_R_V__c  = TheBox; //Checkbox
		i.Transportation_Consent__c  = TheBox; //Checkbox
		// i.Traumatic_Marks__c  = TheBox; //Checkbox
		// i.Truancy__c  = TheBox; //Checkbox
		// i.Utilizing_Community__c  = TheBox; //Checkbox
		// i.Works__c  = TheBox; //Checkbox
		// i.X10th_Transcript_Review__c  = TheBox; //Checkbox
		// i.X11th_Transcript_Review__c  = TheBox; //Checkbox
		// i.Yellowish_Tent__c  = TheBox; //Checkbox

		//Date

		Date TheDate;

		TheDate = Date.newInstance(2016, 1, 1);

		i.Birthdate__c  = TheDate; //Date
		i.Date_of_Placement__c  = TheDate; //Date
		i.Casey_Assessment__c  = TheDate; //Date
		i.Clothing_Inventory__c  = TheDate; //Date
		i.D_O_B__c  = TheDate; //Date
		i.Dental_Visit__c  = TheDate; //Date
		i.Emergency_Information__c  = TheDate; //Date
		i.FACE_Sheet__c  = TheDate; //Date
		i.FERPA__c  = TheDate; //Date
		i.Financial_Literacy__c  = TheDate; //Date
		i.Form_Completion_Date__c  = TheDate; //Date
		i.Graduation_Date__c  = TheDate; //Date
		i.IEP_Review__c  = TheDate; //Date
		i.Intake_Checklist__c  = TheDate; //Date
		i.Job_Readiness__c  = TheDate; //Date
		i.Job_Shadowing__c  = TheDate; //Date
		i.Keys_Work__c  = TheDate; //Date
		i.Last_Physical__c  = TheDate; //Date
		i.Placement__c  = TheDate; //Date
		i.Recent_IEP__c  = TheDate; //Date
		i.Screening_Completed__c  = TheDate; //Date
		// i.Transition_Activities__c  = TheDate; //Date
		// i.Transition_Activity__c  = TheDate; //Date

		//DateTime

		DateTime TheDateTime;

		TheDateTime = DateTime.now();

		i.Referral_Received__c  = TheDateTime; //Date/Time

		//Currency

		Integer TheDollars;

		TheDollars = 1000;

		i.Restitution__c  = TheDollars; //Currency(18, 0)

		//Email

		String TheEmail;

		TheEmail = 'support@gwensgirls.org';

		i.Alternate_Email__c  = TheEmail; //Email
		i.Personal_Email__c  = TheEmail; //Email
		i.Work_Email__c  = TheEmail; //Email
		i.Alternate_Email__c  = TheEmail; //Email
		i.Personal_Email__c  = TheEmail; //Email
		i.Work_Email__c  = TheEmail; //Email

		//Number

		Integer  TheNumber;

		TheNumber = 1;

		i.Height_feet__c  = TheNumber; //Number(18, 0)
		i.Height_inches__c  = TheNumber; //Number(18, 0)
		i.Weight_NUM__c  = TheNumber; //Number(18, 0)
		i.Caregivers_Disciplinary_Practices__c  = TheNumber; //Number(18, 0)
		i.Caregivers_Expectations__c  = TheNumber; //Number(18, 0)
		i.Caregivers_Parents_DA__c  = TheNumber; //Number(18, 0)
		i.Caregivers_Parents_MH__c  = TheNumber; //Number(18, 0)
		i.Caregivers_Parents_PH__c  = TheNumber; //Number(18, 0)
		i.Child_Behavior__c  = TheNumber; //Number(18, 0)
		i.Child_Caregivers_Parents_Relationship__c  = TheNumber; //Number(18, 0)
		i.Child_Drug_Alcohol__c  = TheNumber; //Number(18, 0)
		i.Child_MH__c  = TheNumber; //Number(18, 0)
		i.Child_Peer_Relationship__c  = TheNumber; //Number(18, 0)
		i.Child_School_Performance__c  = TheNumber; //Number(18, 0)
		i.Detentions__c  = TheNumber; //Number(18, 0)
		i.Environment_Housing__c  = TheNumber; //Number(18, 0)
		i.Environment_Income_Employment__c  = TheNumber; //Number(18, 0)
		i.Family_Caregivers_Parents_Relationship__c  = TheNumber; //Number(18, 0)
		i.Family_Community_Support__c  = TheNumber; //Number(18, 0)
		i.Family_Interactions__c  = TheNumber; //Number(18, 0)
		i.Family_Safety__c  = TheNumber; //Number(18, 0)
		i.Grade__c  = TheNumber; //Number(18, 0)
		i.Hats__c  = TheNumber; //Number(18, 0)
		i.Hearing_Left__c  = TheNumber; //Number(18, 0)
		i.Hearing_Right__c  = TheNumber; //Number(18, 0)
		i.Missed_School__c  = TheNumber; //Number(18, 0)
		i.Pajamas__c  = TheNumber; //Number(18, 0)
		i.Pants__c  = TheNumber; //Number(18, 0)
		i.Shirts__c  = TheNumber; //Number(18, 0)
		i.Shoes__c  = TheNumber; //Number(18, 0)
		i.Socks__c  = TheNumber; //Number(18, 0)
		// i.Suspensions__c  = TheNumber; //Number(18, 0)
		// i.Undergarments__c  = TheNumber; //Number(18, 0)
		// i.Vision_Left__c  = TheNumber; //Number(18, 0)
		// i.Vision_Right__c  = TheNumber; //Number(18, 0)
		// i.Winter_Boots__c  = TheNumber; //Number(18, 0)
		// i.Winter_Coats__c  = TheNumber; //Number(18, 0)

		//Phone

		String ThePhone;

		ThePhone = '4123251565';

		i.Mobile_Phone__c  = ThePhone; //Phone
		i.Work_Phone__c  = ThePhone; //Phone
		i.Home_Phone__c  = ThePhone; //Phone
		i.Other_Phone__c  = ThePhone; //Phone
		i.Mobile_Phone__c  = ThePhone; //Phone
		i.Work_Phone__c  = ThePhone; //Phone
		i.Home_Phone__c  = ThePhone; //Phone
		i.Other_Phone__c  = ThePhone; //Phone
		i.Emergency_Contact_Phone__c  = ThePhone; //Phone
		i.Emergency_Contact_Cell_Phone__c  = ThePhone; //Phone
		i.Emergency_Contact_2_Phone__c  = ThePhone; //Phone
		i.Emergency_Contact_2_Cell_Phone__c  = ThePhone; //Phone
		i.Case_Worker__c  = ThePhone; //Phone
		i.Physician_Phone__c  = ThePhone; //Phone
		i.Probation_Officers__c  = ThePhone; //Phone

		//Text

		String TheText;

		TheText = 'Test';

		i.About_You__c  = TheText; //Long Text Area(32768)
		i.Guardian_Issues_Detailed__c  = TheText; //Long Text Area(32768)
		i.Health_Safety__c  = TheText; //Long Text Area(32768)
		i.Important_to_You__c  = TheText; //Long Text Area(32768)
		i.Interviewer_Assessment__c  = TheText; //Long Text Area(32768)
		i.Issues_Detail_other__c  = TheText; //Long Text Area(32768)
		i.Makes_You_Happy__c  = TheText; //Long Text Area(32768)
		i.Medications__c  = TheText; //Long Text Area(32768)
		i.Notes__c  = TheText; //Long Text Area(32768)
		i.Operations_Injuries__c  = TheText; //Long Text Area(32768)
		i.Parent_Guardians_Relationship__c  = TheText; //Long Text Area(32768)
		i.Physical_Mental_History__c  = TheText; //Long Text Area(32768)
		i.Physicians_Advice__c  = TheText; //Long Text Area(32768)
		i.School_Problems_Detailed__c  = TheText; //Long Text Area(32768)
		i.Sibling_Issues_Detailed__c  = TheText; //Long Text Area(32768)
		i.Why_are_you_here__c  = TheText; //Long Text Area(32768)
		// i.Work_Issues__c  = TheText; //Long Text Area(32768)
		i.Worries_Upsets_You__c  = TheText; //Long Text Area(32768)
		i.Mailing_City__c  = TheText; //Text Area(255)
		i.Mailing_Street__c  = TheText; //Text Area(255)
		i.Other_City__c  = TheText; //Text Area(255)
		i.Other_Street__c  = TheText; //Text Area(255)
		i.Comments__c  = TheText; //Text Area(255)
		i.Mailing_City__c  = TheText; //Text Area(255)
		i.Mailing_Street__c  = TheText; //Text Area(255)
		i.Other_Street__c  = TheText; //Text Area(255)
		i.Allergies_Detailed__c  = TheText; //Text Area(255)
		i.Behavior_Exhibited__c  = TheText; //Text Area(255)
		i.Comments__c  = TheText; //Text Area(255)
		i.Counseling_Detailed__c  = TheText; //Text Area(255)
		i.Counseling_Detailed2__c  = TheText; //Text Area(255)
		i.DA_Concerns_Detailed__c  = TheText; //Text Area(255)
		i.Education_Concerns__c  = TheText; //Text Area(255)
		i.Education_Summary__c  = TheText; //Text Area(255)
		i.Explain__c  = TheText; //Text Area(255)
		i.Friends_Detailed__c  = TheText; //Text Area(255)
		i.Fun__c  = TheText; //Text Area(255)
		i.Goal_Summary__c  = TheText; //Text Area(255)
		i.Group_Summary__c  = TheText; //Text Area(255)
		i.Health_Summary__c  = TheText; //Text Area(255)
		i.Home_Summary__c  = TheText; //Text Area(255)
		i.How_are_your_Grades__c  = TheText; //Text Area(255)
		i.illness_Detailed__c  = TheText; //Text Area(255)
		i.Limitations__c  = TheText; //Text Area(255)
		i.Medical_Issues_other__c  = TheText; //Text Area(255)
		i.MH_History_Detailed__c  = TheText; //Text Area(255)
		i.Placements_Dates__c  = TheText; //Text Area(255)
		i.Referral_Reason__c  = TheText; //Text Area(255)
		i.Religion_Importance_Detailed__c  = TheText; //Text Area(255)
		i.Self_Views__c  = TheText; //Text Area(255)
		i.Special_Needs__c  = TheText; //Text Area(255)
		i.Strengths__c  = TheText; //Text Area(255)
		i.Whom_do_you_live_with__c  = TheText; //Text Area(255)
		i.Eye_Color__c  = TheText; //Text(100)
		i.Hair_Color__c  = TheText; //Text(100)
		i.Mailing_Zip_Code__c  = TheText; //Text(20)
		i.Other_Zip_Code__c  = TheText; //Text(20)
		i.Guardian_Zip__c  = TheText; //Text(20)
		i.Mailing_Zip_Code__c  = TheText; //Text(20)
		i.Other_Zip_Code__c  = TheText; //Text(20)
		i.Identifying_Marks__c  = TheText; //Text(200)
		i.Place_of_Employment__c  = TheText; //Text(200)
		i.Guardian_Street__c  = TheText; //Text(255)
		i.Guardian_City__c  = TheText; //Text(255)
		i.Academic_Goals__c  = TheText; //Text(255)
		i.Activity_Invovlement__c  = TheText; //Text(255)
		i.Additional_Information__c  = TheText; //Text(255)
		i.Behavioral_Issues_other__c  = TheText; //Text(255)
		i.Care_Manager__c  = TheText; //Text(255)
		i.Career_Goal__c  = TheText; //Text(255)
		i.Clothing_Summary__c  = TheText; //Text(255)
		i.Community_Suppports__c  = TheText; //Text(255)
		i.Counseling_When__c  = TheText; //Text(255)
		i.Counseling_When2__c  = TheText; //Text(255)
		i.Counselor__c  = TheText; //Text(255)
		i.Counselor_2__c  = TheText; //Text(255)
		i.Custodianship__c  = TheText; //Text(255)
		i.CYF_Case_Worker__c  = TheText; //Text(255)
		i.DA_Pregnancy__c  = TheText; //Text(255)
		i.Diagnosis__c  = TheText; //Text(255)
		i.Dismissal__c  = TheText; //Text(255)
		i.Family_Supports__c  = TheText; //Text(255)
		i.Gynecological_Exam__c  = TheText; //Text(255)
		i.Insurance_Carrier__c  = TheText; //Text(255)
		i.Issues_Concerns__c  = TheText; //Text(255)
		i.Juvenile_Probation__c  = TheText; //Text(255)
		i.Other_Items__c  = TheText; //Text(255)
		i.Parenting__c  = TheText; //Text(255)
		i.Physician_Facility__c  = TheText; //Text(255)
		i.Physician_Name__c  = TheText; //Text(255)
		i.Pregnancy_Term__c  = TheText; //Text(255)
		i.Referral_Source_Relationship__c  = TheText; //Text(255)
		i.Religion__c  = TheText; //Text(255)
		i.Repeated_Grade__c  = TheText; //Text(255)
		i.Sexual_Abuse__c  = TheText; //Text(255)
		i.Subject_Excelling__c  = TheText; //Text(255)
		i.Subject_Needs_Help__c  = TheText; //Text(255)
		i.Supervisor__c  = TheText; //Text(255)
		// i.Talents_Skills__c  = TheText; //Text(255)
		// i.Voluntary_Service__c  = TheText; //Text(255)
		// i.Talents_Skills__c  = TheText; //Text(255)
		// i.Voluntary_Service__c  = TheText; //Text(255)

		i.First_Name__c  = 'TheTextFN'; //Text(50)
		i.Last_Name__c  = 'TheText'; //Text(50)

		i.Primary_Guardian_First__c  = TheText+'pg'; //Text(50)
		i.Primary_Guardian_Last__c  = TheText; //Text(50)
		i.Other_Caregiver_First__c  = TheText+'CF'; //Text(50)
		i.Other_Caregiver_Last__c  = TheText; //Text(50)
		i.Emergency_Contact_First__c  = TheText+'ECF'; //Text(50)
		i.Emergency_Contact_Last__c  = TheText; //Text(50)
		i.Emergency_Contact_2_First__c  = TheText+'EC2F'; //Text(50)
		i.Emergency_Contact_2_Last__c  = TheText; //Text(50)

		Test.startTest();
		
		insert i;

		theIntake = i;

		String iid = i.Id;

		//Create Contact
		Contact c = new Contact();

				//c.OwnerId = i.OwnerId;
				c.YDS_or_CM_c__c = i.YDS_or_CM_c__c;

				c.RecordTypeId = '012410000019yoqAAA'; //ClientRecordType;

				c.Intake__c = i.Id;

				c.FirstName = i.First_Name__c;
				c.LastName = i.Last_Name__c;

				c.npe01__Primary_Address_Type__c = i.Mailing_Address_Type__c;
				c.npe01__Secondary_Address_Type__c = i.Other_Address_Type__c;

				c.MailingCity = i.Mailing_City__c;
				c.MailingState = i.Mailing_State__c;
				c.MailingStreet = i.Mailing_Street__c;
				c.MailingPostalCode = i.Mailing_Zip_Code__c;
				c.MobilePhone = i.Mobile_Phone__c;

				c.OtherCity = i.Other_City__c;
				c.OtherState = i.Other_State__c;
				c.OtherStreet = i.Other_Street__c;
				c.OtherPostalCode = i.Other_Zip_Code__c;

				c.npe01__Preferred_Email__c = i.Preferred_Email__c;
				c.npe01__AlternateEmail__c = i.Alternate_Email__c;
				c.npe01__HomeEmail__c = i.Personal_Email__c;
				c.npe01__WorkEmail__c = i.Work_Email__c;

				//c.Email = i.Email

				c.npe01__PreferredPhone__c = i.PreferredPhone__c;
				c.npe01__WorkPhone__c = i.Work_Phone__c;
				c.HomePhone = i.Home_Phone__c;
				c.OtherPhone = i.Other_Phone__c;
		 	
				c.Birthdate = i.Birthdate__c;

				//Additional field
				c.Child_will_Attend_Afterschool__c = i.Child_will_Attend_Afterschool__c;				
				c.Comments__c = i.Comments__c;

				//c.Community_Service__c = i.Community_Service__c;
				c.Court_Active__c = i.Court_Active__c;
				c.Current_Placement__c = i.Current_Placement__c;
				c.CYF_Active__C = i.CYF_Active__C;
				c.Date_of_Placement__c = i.Date_of_Placement__c;

				c.Eye_Color__c = i.Eye_Color__c;
				c.Gender__c = i.Gender__c;
				c.Grade__c = String.valueOf(i.Grade__c);
				c.Hair_Color__c = i.Hair_Color__c;
				c.Height_feet__c = i.Height_feet__c;
				c.Height_inches__c = i.Height_inches__c;
				
				if(i.Household__c != NULL){
					c.AccountId = i.Household__c;
				}

				c.Identifying_Marks__c = i.Identifying_Marks__c;
				c.Interest_Areas__c = i.Interest_Areas__c;

				c.KIDS_ID__c = String.valueOf(i.KIDS_ID__c);

				c.Place_of_Employment__c = i.Place_of_Employment__c;
				c.Race__c = i.Race__c;
				c.Recommendation__c = i.Recommendation__c;

				if(i.Referral_Source__c != NULL){
					c.Referral_Source__c = i.Referral_Source__c;
				}

				c.Restitution__c = i.Restitution__c;

				if(i.School__c != NULL){
					c.School__c = i.School__c;
				}
				
				c.Weight__c = i.Weight_NUM__c;

				//New Mappings as of 3.13.2019
				c.Appropriate_Age__c = i.Appropriate_Age__c;
				c.Approved_Pick_Up_1__c = i.Approved_Pick_Up_1__c;
				c.Approved_Pick_Up_1_Phone__c = i.Approved_Pick_Up_1_Phone__c;
				c.Approved_Pick_Up_1_Relationship__c = i.Approved_Pick_Up_1_Relationship__c;
				c.Approved_Pick_Up_2__c = i.Approved_Pick_Up_2__c;
				c.Approved_Pick_Up_2_Phone__c = i.Approved_Pick_Up_2_Phone__c;
				c.Approved_Pick_Up_2_Relationship__c = i.Approved_Pick_Up_2_Relationship__c;
				c.Approved_Pick_Up_3__c = i.Approved_Pick_Up_3__c;
				c.Approved_Pick_Up_3_Phone__c = i.Approved_Pick_Up_3_Phone__c;
				c.Approved_Pick_Up_3_Relationship__c = i.Approved_Pick_Up_3_Relationship__c;
				c.Approved_Pick_Up_4__c = i.Approved_Pick_Up_4__c;
				c.Approved_Pick_Up_4_Phone__c = i.Approved_Pick_Up_4_Phone__c;
				c.Approved_Pick_Up_4_Relationship__c = i.Approved_Pick_Up_4_Relationship__c;
				c.Community_Service__c = i.Community_Serv_Hrs__c;
				c.Emergency_Contact__c = i.Emergency_Contact__c;
				c.Emergency_Contact_2__c = i.Emergency_Contact_2__c;
				c.Emergency_Contact_2_Cell_Phone__c = i.Emergency_Contact_2_Cell_Phone__c;
				c.Emergency_Contact_2_First__c = i.Emergency_Contact_2_First__c;
				c.Emergency_Contact_2_Last__c = i.Emergency_Contact_2_Last__c;
				c.Emergency_Contact_2_Phone__c = i.Emergency_Contact_2_Phone__c;
				c.Emergency_Contact_Cell_Phone__c = i.Emergency_Contact_Cell_Phone__c;
				c.Emergency_Contact_First__c = i.Emergency_Contact_First__c;
				c.Emergency_Contact_Last__c = i.Emergency_Contact_Last__c;
				c.Emergency_Contact_Phone__c = i.Emergency_Contact_Phone__c;
				c.Guardian_City__c = i.Guardian_City__c;
				c.Guardian_State__c = i.Guardian_State__c;
				c.Guardian_Street__c = i.Guardian_Street__c;
				c.Guardian_Zip__c = i.Guardian_Zip__c;
				c.Household_Monthly_Income__c = i.Household_Monthly_Income__c;
				c.Intake_Status__c = i.Intake_Status__c;
				c.KIDS_ID__c = String.ValueOf(i.Kids_ID__c);
				c.KIDS_Service_Episode_Id__c = i.KIDS_Service_Episode_Id__c;
				c.Last_Physical_MM_YYYY__c = i.Last_Physical_MM_YYYY__c;
				c.Name_of_Primary_Parent_Guardian__c = i.Name_of_Primary_Parent_Guardian__c;
				c.Other_Caregiver_First__c = i.Other_Caregiver_First__c;
				c.Other_Caregiver_Last__c = i.Other_Caregiver_Last__c;
				c.Other_Guardian_Relationship__c = i.Other_Guardian_Relationship__c;
				c.Primary_Guardian_First__c = i.Primary_Guardian_First__c;
				c.Primary_Guardian_Last__c = i.Primary_Guardian_Last__c;
				c.Primary_Guardian_Relationship__c = i.Primary_Guardian_Relationship__c;
				c.Race__c = i.Race_TXT__c;
				c.Reason_for_Deferment__c = i.Reason_for_Deferment__c;
				c.Referral_Source_First__c = i.Referral_Source_First__c;
				c.Referral_Source_Last__c = i.Referral_Source_Last__c;
				c.SSN__c = i.SSN__c;
				c.Status__c = i.Status__c;
				// c.Volunteer_Organization__c = i.Volunteer_Organization__c;
				c.Weeks_Enrollment_Deferred__c = i.Weeks_Enrollment_Deferred__c;

				insert c;

		Intake__c uic = new Intake__c();
		uic = [SELECT Id, Client__c from Intake__c where Id =: iid];

		uic.Client__c = c.Id;
		update uic;

		//theIntake = i;

		Intake__c thei = new Intake__C();

		//Contact myc = [SELECT Id, FirstName, LastName, Intake__c FROM Contact Where Intake__c =: iid];

		//system.debug('********* myc.id *********'+ myc.Id);

		//Set<Id> ccid = new Set<Id>();

		//ccid.add(i.Id);

		//WSIntakeTools.createContactfromIntake(ccid);

		system.debug('******** iid **********'+iid);

		//Create A Query String for Intake
        SObjectType summarytype = Schema.getGlobalDescribe().get('Intake__c');
        Map<String,Schema.SObjectField> summaryfields = summarytype.getDescribe().fields.getMap(); //A Map of Fields

        string summaryselect = 'Select ';

        for(string pd : summaryfields.keyset()){
            summaryselect = summaryselect + summaryfields.get(pd) + ', ';
        }
        summaryselect = summaryselect.substring(0,summaryselect.length()-2);
        summaryselect = summaryselect + '';
        summaryselect = summaryselect + ' FROM Intake__c WHERE Id =: iid';

        system.debug('***** Query String****'+summaryselect);

        try{
            //thei = (Intake__c)Database.query(summaryselect); //The list of Contact Summaries
        }catch(Exception esums){
            system.debug('***********************ERROR Querying Contact Summaries ***********************' + esums.getMessage());
        }

        if(thei == NULL){

        	system.debug('********* NULL thei *************');

        }else{

        	if(thei.Client__c != NULL){

        		system.debug('*************Client Id*********'+ thei.Client__c);
        	}

		}

		thei = theIntake;

		thei.Abstraction__c  = WSUtilities.getPickValues('Abstraction__c')[1]; //Picklist
		thei.Abuse__c  = WSUtilities.getPickValues('Abuse__c')[1]; //Picklist (Multi-Select)
		thei.Activities__c  = WSUtilities.getPickValues('Activities__c')[1]; //Picklist (Multi-Select)
		thei.Affect__c  = WSUtilities.getPickValues('Affect__c')[1]; //Picklist
		thei.Allergies__c  = WSUtilities.getPickValues('Allergies__c')[1]; //Picklist (Multi-Select)
		thei.Attendance__c  = WSUtilities.getPickValues('Attendance__c')[1]; //Picklist
		thei.Attention__c  = WSUtilities.getPickValues('Attention__c')[1]; //Picklist
		thei.Attitude__c  = WSUtilities.getPickValues('Attitude__c')[1]; //Picklist
		thei.Behavioral_Issues__c  = WSUtilities.getPickValues('Behavioral_Issues__c')[1]; //Picklist (Multi-Select)
		thei.Boundaries__c  = WSUtilities.getPickValues('Boundaries__c')[1]; //Picklist
		thei.Child_will_Attend_Afterschool__c  = WSUtilities.getPickValues('Child_will_Attend_Afterschool__c')[1]; //Picklist (Multi-Select)
		thei.Clothing__c  = WSUtilities.getPickValues('Clothing__c')[1]; //Picklist
		thei.Community_Resources__c  = WSUtilities.getPickValues('Community_Resources__c')[1]; //Picklist
		thei.Concentration__c  = WSUtilities.getPickValues('Concentration__c')[1]; //Picklist
		thei.Coping_Ability__c  = WSUtilities.getPickValues('Coping_Ability__c')[1]; //Picklist
		thei.Cosmetic_use__c  = WSUtilities.getPickValues('Cosmetic_use__c')[1]; //Picklist
		thei.Course_Description__c  = WSUtilities.getPickValues('Course_Description__c')[1]; //Picklist
		thei.Current_DA_Concerns__c  = WSUtilities.getPickValues('Current_DA_Concerns__c')[1]; //Picklist
		thei.Current_Living_Situation__c  = WSUtilities.getPickValues('Current_Living_Situation__c')[1]; //Picklist
		thei.DA_History__c  = WSUtilities.getPickValues('DA_History__c')[1]; //Picklist
		thei.Decision_Making__c  = WSUtilities.getPickValues('Decision_Making__c')[1]; //Picklist
		thei.Defective_Memory__c  = WSUtilities.getPickValues('Defective_Memory__c')[1]; //Picklist
		thei.Developmental_Delay__c  = WSUtilities.getPickValues('Developmental_Delay__c')[1]; //Picklist
		thei.Education_Program__c  = WSUtilities.getPickValues('Education_Program__c')[1]; //Picklist
		thei.Education_Type__c  = WSUtilities.getPickValues('Education_Type__c')[1]; //Picklist
		thei.Educational_Support__c  = WSUtilities.getPickValues('Educational_Support__c')[1]; //Picklist
		thei.Eye_Contact__c  = WSUtilities.getPickValues('Eye_Contact__c')[1]; //Picklist
		thei.Facial_Expresion__c  = WSUtilities.getPickValues('Facial_Expresion__c')[1]; //Picklist
		thei.Family_Discussion__c  = WSUtilities.getPickValues('Family_Discussion__c')[1]; //Picklist
		thei.Family_Functioning_Level__c  = WSUtilities.getPickValues('Family_Functioning_Level__c')[1]; //Picklist (Multi-Select)
		thei.Fund_Knowledge__c  = WSUtilities.getPickValues('Fund_Knowledge__c')[1]; //Picklist
		thei.Gender__c  = WSUtilities.getPickValues('Gender__c')[1]; //Picklist
		thei.GPA__c  = WSUtilities.getPickValues('GPA__c')[1]; //Picklist
		thei.Grade_History__c  = WSUtilities.getPickValues('Grade_History__c')[1]; //Picklist
		thei.Graduation_Type__c  = WSUtilities.getPickValues('Graduation_Type__c')[1]; //Picklist
		thei.Grooming__c  = WSUtilities.getPickValues('Grooming__c')[1]; //Picklist
		thei.Guardian_State__c  = WSUtilities.getPickValues('Guardian_State__c')[1]; //Picklist
		thei.Had_illness__c  = WSUtilities.getPickValues('Had_illness__c')[1]; //Picklist (Multi-Select)
		thei.Hallucination__c  = WSUtilities.getPickValues('Hallucination__c')[1]; //Picklist
		thei.History_Domestic_Violence__c  = WSUtilities.getPickValues('History_Domestic_Violence__c')[1]; //Picklist
		thei.History_of_Abuse__c  = WSUtilities.getPickValues('History_of_Abuse__c')[1]; //Picklist
		thei.Hobbies__c  = WSUtilities.getPickValues('Hobbies__c')[1]; //Picklist (Multi-Select)
		thei.Household_Rules__c  = WSUtilities.getPickValues('Household_Rules__c')[1]; //Picklist
		thei.Housing__c  = WSUtilities.getPickValues('Housing__c')[1]; //Picklist
		thei.Income_Source__c  = WSUtilities.getPickValues('Income_Source__c')[1]; //Picklist
		thei.Insight__c  = WSUtilities.getPickValues('Insight__c')[1]; //Picklist
		thei.Intelligence__c  = WSUtilities.getPickValues('Intelligence__c')[1]; //Picklist
		thei.Interest_Areas__c  = WSUtilities.getPickValues('Interest_Areas__c')[1]; //Picklist (Multi-Select)
		thei.Judgment__c  = WSUtilities.getPickValues('Judgment__c')[1]; //Picklist
		thei.Life_Skills__c  = WSUtilities.getPickValues('Life_Skills__c')[1]; //Picklist (Multi-Select)
		thei.Mailing_Address_Type__c  = WSUtilities.getPickValues('Mailing_Address_Type__c')[1]; //Picklist
		thei.Mailing_State__c  = WSUtilities.getPickValues('Mailing_State__c')[1]; //Picklist
		thei.Mailing_State__c  = WSUtilities.getPickValues('Mailing_State__c')[1]; //Picklist
		thei.Math__c  = WSUtilities.getPickValues('Math__c')[1]; //Picklist
		thei.Medication_Compliance__c  = WSUtilities.getPickValues('Medication_Compliance__c')[1]; //Picklist
		thei.Mental_Health_History__c  = WSUtilities.getPickValues('Mental_Health_History__c')[1]; //Picklist
		thei.Mood__c  = WSUtilities.getPickValues('Mood__c')[1]; //Picklist
		thei.Motor_Activity__c  = WSUtilities.getPickValues('Motor_Activity__c')[1]; //Picklist
		thei.Organization__c  = WSUtilities.getPickValues('Organization__c')[1]; //Picklist
		thei.Orientation__c  = WSUtilities.getPickValues('Orientation__c')[1]; //Picklist
		thei.Other_Address_Type__c  = WSUtilities.getPickValues('Other_Address_Type__c')[1]; //Picklist
		thei.Other_Address_Type__c  = WSUtilities.getPickValues('Other_Address_Type__c')[1]; //Picklist
		thei.Other_Guardian_Relationship__c  = WSUtilities.getPickValues('Other_Guardian_Relationship__c')[1]; //Picklist
		thei.Other_State__c  = WSUtilities.getPickValues('Other_State__c')[1]; //Picklist
		thei.Other_State__c  = WSUtilities.getPickValues('Other_State__c')[1]; //Picklist
		thei.Permanency_Goal__c  = WSUtilities.getPickValues('Permanency_Goal__c')[1]; //Picklist
		thei.Posture__c  = WSUtilities.getPickValues('Posture__c')[1]; //Picklist
		thei.Pre_Natal_Issues__c  = WSUtilities.getPickValues('Pre_Natal_Issues__c')[1]; //Picklist
		thei.Preferred_Email__c  = WSUtilities.getPickValues('Preferred_Email__c')[1]; //Picklist
		thei.Preferred_Email__c  = WSUtilities.getPickValues('Preferred_Email__c')[1]; //Picklist
		thei.PreferredPhone__c  = WSUtilities.getPickValues('PreferredPhone__c')[1]; //Picklist
		thei.PreferredPhone__c  = WSUtilities.getPickValues('PreferredPhone__c')[1]; //Picklist
		thei.Preoccupation__c  = WSUtilities.getPickValues('Preoccupation__c')[1]; //Picklist
		thei.Primary_Guardian_Relationship__c  = WSUtilities.getPickValues('Primary_Guardian_Relationship__c')[1]; //Picklist
		thei.PSSA_Keystone__c  = WSUtilities.getPickValues('PSSA_Keystone__c')[1]; //Picklist
		thei.Race__c  = WSUtilities.getPickValues('Race__c')[1]; //Picklist
		thei.Race__c  = WSUtilities.getPickValues('Race__c')[1]; //Picklist
		thei.Reading__c  = WSUtilities.getPickValues('Reading__c')[1]; //Picklist
		thei.Reality_Testing__c  = WSUtilities.getPickValues('Reality_Testing__c')[1]; //Picklist
		thei.Recall__c  = WSUtilities.getPickValues('Recall__c')[1]; //Picklist
		thei.Recent_Grades__c  = WSUtilities.getPickValues('Recent_Grades__c')[1]; //Picklist
		thei.Recommendation__c  = WSUtilities.getPickValues('Recommendation__c')[1]; //Picklist
		thei.Referal_Completed__c  = WSUtilities.getPickValues('Referal_Completed__c')[1]; //Picklist
		thei.Referral_Source_Type__c  = WSUtilities.getPickValues('Referral_Source_Type__c')[1]; //Picklist
		thei.Referral_Type__c  = WSUtilities.getPickValues('Referral_Type__c')[1]; //Picklist
		thei.Reward__c  = WSUtilities.getPickValues('Reward__c')[1]; //Picklist
		thei.Service_Level__c  = WSUtilities.getPickValues('Service_Level__c')[1]; //Picklist
		thei.SES_Program__c  = WSUtilities.getPickValues('SES_Program__c')[1]; //Picklist
		thei.Sexual_Preference__c  = WSUtilities.getPickValues('Sexual_Preference__c')[1]; //Picklist
		thei.Skill_Deficits__c  = WSUtilities.getPickValues('Skill_Deficits__c')[1]; //Picklist
		thei.Social_Judgment__c  = WSUtilities.getPickValues('Social_Judgment__c')[1]; //Picklist
		thei.Social_Maturity__c  = WSUtilities.getPickValues('Social_Maturity__c')[1]; //Picklist
		thei.Speech__c  = WSUtilities.getPickValues('Speech__c')[1]; //Picklist
		thei.Stature__c  = WSUtilities.getPickValues('Stature__c')[1]; //Picklist
		thei.Stressors__c  = WSUtilities.getPickValues('Stressors__c')[1]; //Picklist
		// thei.Supports__c  = WSUtilities.getPickValues('Supports__c')[1]; //Picklist
		// thei.Target_Neighborhood__c  = WSUtilities.getPickValues('Target_Neighborhood__c')[1]; //Picklist
		// thei.Thoughts__c  = WSUtilities.getPickValues('Thoughts__c')[1]; //Picklist
		thei.Weight__c  = WSUtilities.getPickValues('Weight__c')[1]; //Picklist


		//Booleans

		TheBox = FALSE;

		thei.Court_Active__c  = TheBox; //Checkbox
		thei.CYF_Active__C  = TheBox; //Checkbox
		thei.Acne__c  = TheBox; //Checkbox
		thei.Alt_Transportation__c  = TheBox; //Checkbox
		thei.Awake_Alert__c  = TheBox; //Checkbox
		thei.Behavior_Problems__c  = TheBox; //Checkbox
		thei.Birthmarks__c  = TheBox; //Checkbox
		thei.Bruises__c  = TheBox; //Checkbox
		thei.Bullying_Perpetrator__c  = TheBox; //Checkbox
		thei.Bullying_Victim__c  = TheBox; //Checkbox
		thei.Campus_Visit__c  = TheBox; //Checkbox
		thei.Career_Fair__c  = TheBox; //Checkbox
		thei.Chores__c  = TheBox; //Checkbox
		thei.Close_Friends__c  = TheBox; //Checkbox
		thei.College_Board__c  = TheBox; //Checkbox
		thei.Common_Application__c  = TheBox; //Checkbox
		thei.Community_Activities__c  = TheBox; //Checkbox
		thei.Community_Collaborative__c  = TheBox; //Checkbox
		thei.Community_Service__c  = TheBox; //Checkbox
		thei.Confidentiality_Statement__c  = TheBox; //Checkbox
		thei.Conflicts_wParents__c  = TheBox; //Checkbox
		thei.ConsentReturn_Unsupervised__c  = TheBox; //Checkbox
		thei.Counseling__c  = TheBox; //Checkbox
		thei.Curfew__c  = TheBox; //Checkbox
		thei.Current_Schedule_Submittted__c  = TheBox; //Checkbox
		thei.CYF_Advocate__c  = TheBox; //Checkbox
		thei.December__c  = TheBox; //Checkbox
		thei.Deformities__c  = TheBox; //Checkbox
		thei.Detention__c  = TheBox; //Checkbox
		thei.Disruptive__c  = TheBox; //Checkbox
		thei.Dressed_Appropriate__c  = TheBox; //Checkbox
		thei.Drug_Withdrawal__c  = TheBox; //Checkbox
		thei.Expectations__c  = TheBox; //Checkbox
		thei.Expulsions__c  = TheBox; //Checkbox
		thei.Family_Handbook_Acceptance__c  = TheBox; //Checkbox
		thei.February__c  = TheBox; //Checkbox
		thei.Good_Hygiene__c  = TheBox; //Checkbox
		thei.Graduated__c  = TheBox; //Checkbox
		thei.Group_Expectations__c  = TheBox; //Checkbox
		thei.Group_Rules_Agreement__c  = TheBox; //Checkbox
		thei.Hyperactive__c  = TheBox; //Checkbox
		thei.IEP__c  = TheBox; //Checkbox
		thei.IL_Worker__c  = TheBox; //Checkbox
		thei.In_School__c  = TheBox; //Checkbox
		thei.Infestations__c  = TheBox; //Checkbox
		thei.Initial__c  = TheBox; //Checkbox
		thei.Interests_Specialty_Group__c  = TheBox; //Checkbox
		thei.Interview_Skills__c  = TheBox; //Checkbox
		thei.Inventory_35__c  = TheBox; //Checkbox
		thei.Inventory_68__c  = TheBox; //Checkbox
		thei.Inventory_912__c  = TheBox; //Checkbox
		thei.Irritability__c  = TheBox; //Checkbox
		thei.Issuesw_Parents_Friends__c  = TheBox; //Checkbox
		thei.Issuesw_Siblings__c  = TheBox; //Checkbox
		thei.JA_Biztown__c  = TheBox; //Checkbox
		thei.January__c  = TheBox; //Checkbox
		thei.Job_Application__c  = TheBox; //Checkbox
		thei.Learning_Disability__c  = TheBox; //Checkbox
		thei.Lesions__c  = TheBox; //Checkbox
		thei.March__c  = TheBox; //Checkbox
		thei.Medical_Collaborative__c  = TheBox; //Checkbox
		thei.Medical_Release__c  = TheBox; //Checkbox
		thei.Mentor_Program__c  = TheBox; //Checkbox
		thei.Movements_Coordinated__c  = TheBox; //Checkbox
		thei.Navience_Account__c  = TheBox; //Checkbox
		thei.Needlemarks__c  = TheBox; //Checkbox
		thei.No_Problems__c  = TheBox; //Checkbox
		thei.November__c  = TheBox; //Checkbox
		thei.October__c  = TheBox; //Checkbox
		thei.Out_of_C_S__c  = TheBox; //Checkbox
		thei.Permission_to_Photogragh__c  = TheBox; //Checkbox
		thei.Personal_Wellness__c  = TheBox; //Checkbox
		thei.Piercings__c  = TheBox; //Checkbox
		thei.Pregnant_Parenting__c  = TheBox; //Checkbox
		thei.PreGroup_Assessment__c  = TheBox; //Checkbox
		thei.Problems_at_Work__c  = TheBox; //Checkbox
		thei.Problems_in_School__c  = TheBox; //Checkbox
		thei.Problems_wGuardian__c  = TheBox; //Checkbox
		thei.PSAT_ACT__c  = TheBox; //Checkbox
		thei.Quiet__c  = TheBox; //Checkbox
		thei.Rash__c  = TheBox; //Checkbox
		thei.Received_Rewards__c  = TheBox; //Checkbox
		thei.Recommendation_Letter__c  = TheBox; //Checkbox
		thei.Relationship__c  = TheBox; //Checkbox
		thei.Release_Info_Consent__c  = TheBox; //Checkbox
		thei.Religion_Importance__c  = TheBox; //Checkbox
		thei.Resume__c  = TheBox; //Checkbox
		thei.Rewards_Points_Policy__c  = TheBox; //Checkbox
		thei.Runs_Away__c  = TheBox; //Checkbox
		thei.Sad__c  = TheBox; //Checkbox
		thei.SAT_Prep_Course__c  = TheBox; //Checkbox
		thei.Scars__c  = TheBox; //Checkbox
		thei.Secondary__c  = TheBox; //Checkbox
		thei.Securing_Housing__c  = TheBox; //Checkbox
		thei.Self_Advocacy__c  = TheBox; //Checkbox
		thei.Serious_Relationship__c  = TheBox; //Checkbox
		thei.Speech_Difficulties__c  = TheBox; //Checkbox
		// thei.Suspension__c  = TheBox; //Checkbox
		// thei.Tattoos__c  = TheBox; //Checkbox
		// thei.Teacher_Peer_Interaction__c  = TheBox; //Checkbox
		thei.Television_R_V__c  = TheBox; //Checkbox
		thei.Transportation_Consent__c  = TheBox; //Checkbox
		// thei.Traumatic_Marks__c  = TheBox; //Checkbox
		// thei.Truancy__c  = TheBox; //Checkbox
		// thei.Utilizing_Community__c  = TheBox; //Checkbox
		// thei.Works__c  = TheBox; //Checkbox
		// thei.X10th_Transcript_Review__c  = TheBox; //Checkbox
		// thei.X11th_Transcript_Review__c  = TheBox; //Checkbox
		// thei.Yellowish_Tent__c  = TheBox; //Checkbox

		//Date

		TheDate = Date.newInstance(2016, 2, 1);

		thei.Birthdate__c  = TheDate; //Date
		thei.Date_of_Placement__c  = TheDate; //Date
		thei.Casey_Assessment__c  = TheDate; //Date
		thei.Clothing_Inventory__c  = TheDate; //Date
		thei.D_O_B__c  = TheDate; //Date
		thei.Dental_Visit__c  = TheDate; //Date
		thei.Emergency_Information__c  = TheDate; //Date
		thei.FACE_Sheet__c  = TheDate; //Date
		thei.FERPA__c  = TheDate; //Date
		thei.Financial_Literacy__c  = TheDate; //Date
		thei.Form_Completion_Date__c  = TheDate; //Date
		thei.Graduation_Date__c  = TheDate; //Date
		thei.IEP_Review__c  = TheDate; //Date
		thei.Intake_Checklist__c  = TheDate; //Date
		thei.Job_Readiness__c  = TheDate; //Date
		thei.Job_Shadowing__c  = TheDate; //Date
		thei.Keys_Work__c  = TheDate; //Date
		thei.Last_Physical__c  = TheDate; //Date
		thei.Placement__c  = TheDate; //Date
		thei.Recent_IEP__c  = TheDate; //Date
		// thei.Screening_Completed__c  = TheDate; //Date
		// thei.Transition_Activities__c  = TheDate; //Date
		// thei.Transition_Activity__c  = TheDate; //Date

		//DateTime

		TheDateTime = DateTime.now();

		thei.Referral_Received__c  = TheDateTime; //Date/Time

		//Currency

		TheDollars = 2000;

		thei.Restitution__c  = TheDollars; //Currency(18, 0)

		//Email

		TheEmail = 'support2@gwensgirls.org';

		thei.Alternate_Email__c  = TheEmail; //Email
		thei.Personal_Email__c  = TheEmail; //Email
		thei.Work_Email__c  = TheEmail; //Email
		thei.Alternate_Email__c  = TheEmail; //Email
		thei.Personal_Email__c  = TheEmail; //Email
		thei.Work_Email__c  = TheEmail; //Email

		//Number

		TheNumber = 2;

		thei.Height_feet__c  = TheNumber; //Number(18, 0)
		thei.Height_inches__c  = TheNumber; //Number(18, 0)
		thei.Weight_NUM__c  = TheNumber; //Number(18, 0)
		thei.Caregivers_Disciplinary_Practices__c  = TheNumber; //Number(18, 0)
		thei.Caregivers_Expectations__c  = TheNumber; //Number(18, 0)
		thei.Caregivers_Parents_DA__c  = TheNumber; //Number(18, 0)
		thei.Caregivers_Parents_MH__c  = TheNumber; //Number(18, 0)
		thei.Caregivers_Parents_PH__c  = TheNumber; //Number(18, 0)
		thei.Child_Behavior__c  = TheNumber; //Number(18, 0)
		thei.Child_Caregivers_Parents_Relationship__c  = TheNumber; //Number(18, 0)
		thei.Child_Drug_Alcohol__c  = TheNumber; //Number(18, 0)
		thei.Child_MH__c  = TheNumber; //Number(18, 0)
		thei.Child_Peer_Relationship__c  = TheNumber; //Number(18, 0)
		thei.Child_School_Performance__c  = TheNumber; //Number(18, 0)
		thei.Detentions__c  = TheNumber; //Number(18, 0)
		thei.Environment_Housing__c  = TheNumber; //Number(18, 0)
		thei.Environment_Income_Employment__c  = TheNumber; //Number(18, 0)
		thei.Family_Caregivers_Parents_Relationship__c  = TheNumber; //Number(18, 0)
		thei.Family_Community_Support__c  = TheNumber; //Number(18, 0)
		thei.Family_Interactions__c  = TheNumber; //Number(18, 0)
		thei.Family_Safety__c  = TheNumber; //Number(18, 0)
		thei.Grade__c  = TheNumber; //Number(18, 0)
		thei.Hats__c  = TheNumber; //Number(18, 0)
		thei.Hearing_Left__c  = TheNumber; //Number(18, 0)
		thei.Hearing_Right__c  = TheNumber; //Number(18, 0)
		thei.Missed_School__c  = TheNumber; //Number(18, 0)
		thei.Pajamas__c  = TheNumber; //Number(18, 0)
		thei.Pants__c  = TheNumber; //Number(18, 0)
		thei.Shirts__c  = TheNumber; //Number(18, 0)
		thei.Shoes__c  = TheNumber; //Number(18, 0)
		thei.Socks__c  = TheNumber; //Number(18, 0)
		// thei.Suspensions__c  = TheNumber; //Number(18, 0)
		// thei.Undergarments__c  = TheNumber; //Number(18, 0)
		// thei.Vision_Left__c  = TheNumber; //Number(18, 0)
		// thei.Vision_Right__c  = TheNumber; //Number(18, 0)
		// thei.Winter_Boots__c  = TheNumber; //Number(18, 0)
		// thei.Winter_Coats__c  = TheNumber; //Number(18, 0)

		//Phone

		ThePhone = '4123251566';

		thei.Mobile_Phone__c  = ThePhone; //Phone
		thei.Work_Phone__c  = ThePhone; //Phone
		thei.Home_Phone__c  = ThePhone; //Phone
		thei.Other_Phone__c  = ThePhone; //Phone
		thei.Mobile_Phone__c  = ThePhone; //Phone
		thei.Work_Phone__c  = ThePhone; //Phone
		thei.Home_Phone__c  = ThePhone; //Phone
		thei.Other_Phone__c  = ThePhone; //Phone
		thei.Emergency_Contact_Phone__c  = ThePhone; //Phone
		thei.Emergency_Contact_Cell_Phone__c  = ThePhone; //Phone
		thei.Emergency_Contact_2_Phone__c  = ThePhone; //Phone
		thei.Emergency_Contact_2_Cell_Phone__c  = ThePhone; //Phone
		thei.Case_Worker__c  = ThePhone; //Phone
		thei.Physician_Phone__c  = ThePhone; //Phone
		thei.Probation_Officers__c  = ThePhone; //Phone

		//Text

		TheText = 'Test2';

		thei.About_You__c  = TheText; //Long Text Area(32768)
		thei.Guardian_Issues_Detailed__c  = TheText; //Long Text Area(32768)
		thei.Health_Safety__c  = TheText; //Long Text Area(32768)
		thei.Important_to_You__c  = TheText; //Long Text Area(32768)
		thei.Interviewer_Assessment__c  = TheText; //Long Text Area(32768)
		thei.Issues_Detail_other__c  = TheText; //Long Text Area(32768)
		thei.Makes_You_Happy__c  = TheText; //Long Text Area(32768)
		thei.Medications__c  = TheText; //Long Text Area(32768)
		thei.Notes__c  = TheText; //Long Text Area(32768)
		thei.Operations_Injuries__c  = TheText; //Long Text Area(32768)
		thei.Parent_Guardians_Relationship__c  = TheText; //Long Text Area(32768)
		thei.Physical_Mental_History__c  = TheText; //Long Text Area(32768)
		thei.Physicians_Advice__c  = TheText; //Long Text Area(32768)
		thei.School_Problems_Detailed__c  = TheText; //Long Text Area(32768)
		thei.Sibling_Issues_Detailed__c  = TheText; //Long Text Area(32768)
		thei.Why_are_you_here__c  = TheText; //Long Text Area(32768)
		// thei.Work_Issues__c  = TheText; //Long Text Area(32768)
		thei.Worries_Upsets_You__c  = TheText; //Long Text Area(32768)
		thei.Mailing_City__c  = TheText; //Text Area(255)
		thei.Mailing_Street__c  = TheText; //Text Area(255)
		thei.Other_City__c  = TheText; //Text Area(255)
		thei.Other_Street__c  = TheText; //Text Area(255)
		thei.Comments__c  = TheText; //Text Area(255)
		thei.Mailing_City__c  = TheText; //Text Area(255)
		thei.Mailing_Street__c  = TheText; //Text Area(255)
		thei.Other_Street__c  = TheText; //Text Area(255)
		thei.Allergies_Detailed__c  = TheText; //Text Area(255)
		thei.Behavior_Exhibited__c  = TheText; //Text Area(255)
		thei.Comments__c  = TheText; //Text Area(255)
		thei.Counseling_Detailed__c  = TheText; //Text Area(255)
		thei.Counseling_Detailed2__c  = TheText; //Text Area(255)
		thei.DA_Concerns_Detailed__c  = TheText; //Text Area(255)
		thei.Education_Concerns__c  = TheText; //Text Area(255)
		thei.Education_Summary__c  = TheText; //Text Area(255)
		thei.Explain__c  = TheText; //Text Area(255)
		thei.Friends_Detailed__c  = TheText; //Text Area(255)
		thei.Fun__c  = TheText; //Text Area(255)
		thei.Goal_Summary__c  = TheText; //Text Area(255)
		thei.Group_Summary__c  = TheText; //Text Area(255)
		thei.Health_Summary__c  = TheText; //Text Area(255)
		thei.Home_Summary__c  = TheText; //Text Area(255)
		thei.How_are_your_Grades__c  = TheText; //Text Area(255)
		thei.illness_Detailed__c  = TheText; //Text Area(255)
		thei.Limitations__c  = TheText; //Text Area(255)
		thei.Medical_Issues_other__c  = TheText; //Text Area(255)
		thei.MH_History_Detailed__c  = TheText; //Text Area(255)
		thei.Placements_Dates__c  = TheText; //Text Area(255)
		thei.Referral_Reason__c  = TheText; //Text Area(255)
		thei.Religion_Importance_Detailed__c  = TheText; //Text Area(255)
		thei.Self_Views__c  = TheText; //Text Area(255)
		thei.Special_Needs__c  = TheText; //Text Area(255)
		thei.Strengths__c  = TheText; //Text Area(255)
		thei.Whom_do_you_live_with__c  = TheText; //Text Area(255)
		thei.Eye_Color__c  = TheText; //Text(100)
		thei.Hair_Color__c  = TheText; //Text(100)
		thei.Mailing_Zip_Code__c  = TheText; //Text(20)
		thei.Other_Zip_Code__c  = TheText; //Text(20)
		thei.Guardian_Zip__c  = TheText; //Text(20)
		thei.Mailing_Zip_Code__c  = TheText; //Text(20)
		thei.Other_Zip_Code__c  = TheText; //Text(20)
		thei.Identifying_Marks__c  = TheText; //Text(200)
		thei.Place_of_Employment__c  = TheText; //Text(200)
		thei.Guardian_Street__c  = TheText; //Text(255)
		thei.Guardian_City__c  = TheText; //Text(255)
		thei.Academic_Goals__c  = TheText; //Text(255)
		thei.Activity_Invovlement__c  = TheText; //Text(255)
		thei.Additional_Information__c  = TheText; //Text(255)
		thei.Behavioral_Issues_other__c  = TheText; //Text(255)
		thei.Care_Manager__c  = TheText; //Text(255)
		thei.Career_Goal__c  = TheText; //Text(255)
		thei.Clothing_Summary__c  = TheText; //Text(255)
		thei.Community_Suppports__c  = TheText; //Text(255)
		thei.Counseling_When__c  = TheText; //Text(255)
		thei.Counseling_When2__c  = TheText; //Text(255)
		thei.Counselor__c  = TheText; //Text(255)
		thei.Counselor_2__c  = TheText; //Text(255)
		thei.Custodianship__c  = TheText; //Text(255)
		thei.CYF_Case_Worker__c  = TheText; //Text(255)
		thei.DA_Pregnancy__c  = TheText; //Text(255)
		thei.Diagnosis__c  = TheText; //Text(255)
		thei.Dismissal__c  = TheText; //Text(255)
		thei.Family_Supports__c  = TheText; //Text(255)
		thei.Gynecological_Exam__c  = TheText; //Text(255)
		thei.Insurance_Carrier__c  = TheText; //Text(255)
		thei.Issues_Concerns__c  = TheText; //Text(255)
		thei.Juvenile_Probation__c  = TheText; //Text(255)
		thei.Other_Items__c  = TheText; //Text(255)
		thei.Parenting__c  = TheText; //Text(255)
		thei.Physician_Facility__c  = TheText; //Text(255)
		thei.Physician_Name__c  = TheText; //Text(255)
		thei.Pregnancy_Term__c  = TheText; //Text(255)
		thei.Referral_Source_Relationship__c  = TheText; //Text(255)
		thei.Religion__c  = TheText; //Text(255)
		thei.Repeated_Grade__c  = TheText; //Text(255)
		thei.Sexual_Abuse__c  = TheText; //Text(255)
		thei.Subject_Excelling__c  = TheText; //Text(255)
		thei.Subject_Needs_Help__c  = TheText; //Text(255)
		thei.Supervisor__c  = TheText; //Text(255)
		// thei.Talents_Skills__c  = TheText; //Text(255)
		// thei.Voluntary_Service__c  = TheText; //Text(255)
		// thei.Talents_Skills__c  = TheText; //Text(255)
		// thei.Voluntary_Service__c  = TheText; //Text(255)
		//thei.First_Name__c  = TheText; //Text(50)
		//thei.Last_Name__c  = TheText; //Text(50)
		thei.Primary_Guardian_First__c  = TheText; //Text(50)
		thei.Primary_Guardian_Last__c  = TheText; //Text(50)
		thei.Other_Caregiver_First__c  = TheText; //Text(50)
		thei.Other_Caregiver_Last__c  = TheText; //Text(50)
		thei.Emergency_Contact_First__c  = TheText; //Text(50)
		thei.Emergency_Contact_Last__c  = TheText; //Text(50)
		thei.Emergency_Contact_2_First__c  = TheText; //Text(50)
		thei.Emergency_Contact_2_Last__c  = TheText; //Text(50)

		Set<id> tids = new Set<id>();
		tids.add(thei.Id);

		//WSIntakeUpdateTools.updateRelatedRecords(tids);

		update thei;

		WSIntakeUpdateTools.updateRelatedRecords(tids);

		Test.stopTest();
		*/
		
	}

	static testMethod void unitTest2(){ //Insert Intake
		/*
		Intake__c i = new Intake__c ();

		i.Intake_Status__c = 'Complete';

		//Picklists

		i.Abstraction__c  = WSUtilities.getPickValues('Abstraction__c')[0]; //Picklist
		i.Abuse__c  = WSUtilities.getPickValues('Abuse__c')[0]; //Picklist (Multi-Select)
		i.Activities__c  = WSUtilities.getPickValues('Activities__c')[0]; //Picklist (Multi-Select)
		i.Affect__c  = WSUtilities.getPickValues('Affect__c')[0]; //Picklist
		i.Allergies__c  = WSUtilities.getPickValues('Allergies__c')[0]; //Picklist (Multi-Select)
		i.Attendance__c  = WSUtilities.getPickValues('Attendance__c')[0]; //Picklist
		i.Attention__c  = WSUtilities.getPickValues('Attention__c')[0]; //Picklist
		i.Attitude__c  = WSUtilities.getPickValues('Attitude__c')[0]; //Picklist
		i.Behavioral_Issues__c  = WSUtilities.getPickValues('Behavioral_Issues__c')[0]; //Picklist (Multi-Select)
		i.Boundaries__c  = WSUtilities.getPickValues('Boundaries__c')[0]; //Picklist
		i.Child_will_Attend_Afterschool__c  = WSUtilities.getPickValues('Child_will_Attend_Afterschool__c')[0]; //Picklist (Multi-Select)
		i.Clothing__c  = WSUtilities.getPickValues('Clothing__c')[0]; //Picklist
		i.Community_Resources__c  = WSUtilities.getPickValues('Community_Resources__c')[0]; //Picklist
		i.Concentration__c  = WSUtilities.getPickValues('Concentration__c')[0]; //Picklist
		i.Coping_Ability__c  = WSUtilities.getPickValues('Coping_Ability__c')[0]; //Picklist
		i.Cosmetic_use__c  = WSUtilities.getPickValues('Cosmetic_use__c')[0]; //Picklist
		i.Course_Description__c  = WSUtilities.getPickValues('Course_Description__c')[0]; //Picklist
		i.Current_DA_Concerns__c  = WSUtilities.getPickValues('Current_DA_Concerns__c')[0]; //Picklist
		i.Current_Living_Situation__c  = WSUtilities.getPickValues('Current_Living_Situation__c')[0]; //Picklist
		i.DA_History__c  = WSUtilities.getPickValues('DA_History__c')[0]; //Picklist
		i.Decision_Making__c  = WSUtilities.getPickValues('Decision_Making__c')[0]; //Picklist
		i.Defective_Memory__c  = WSUtilities.getPickValues('Defective_Memory__c')[0]; //Picklist
		i.Developmental_Delay__c  = WSUtilities.getPickValues('Developmental_Delay__c')[0]; //Picklist
		i.Education_Program__c  = WSUtilities.getPickValues('Education_Program__c')[0]; //Picklist
		i.Education_Type__c  = WSUtilities.getPickValues('Education_Type__c')[0]; //Picklist
		i.Educational_Support__c  = WSUtilities.getPickValues('Educational_Support__c')[0]; //Picklist
		i.Eye_Contact__c  = WSUtilities.getPickValues('Eye_Contact__c')[0]; //Picklist
		i.Facial_Expresion__c  = WSUtilities.getPickValues('Facial_Expresion__c')[0]; //Picklist
		i.Family_Discussion__c  = WSUtilities.getPickValues('Family_Discussion__c')[0]; //Picklist
		i.Family_Functioning_Level__c  = WSUtilities.getPickValues('Family_Functioning_Level__c')[0]; //Picklist (Multi-Select)
		i.Fund_Knowledge__c  = WSUtilities.getPickValues('Fund_Knowledge__c')[0]; //Picklist
		i.Gender__c  = WSUtilities.getPickValues('Gender__c')[0]; //Picklist
		i.GPA__c  = WSUtilities.getPickValues('GPA__c')[0]; //Picklist
		i.Grade_History__c  = WSUtilities.getPickValues('Grade_History__c')[0]; //Picklist
		i.Graduation_Type__c  = WSUtilities.getPickValues('Graduation_Type__c')[0]; //Picklist
		i.Grooming__c  = WSUtilities.getPickValues('Grooming__c')[0]; //Picklist
		i.Guardian_State__c  = WSUtilities.getPickValues('Guardian_State__c')[0]; //Picklist
		i.Had_illness__c  = WSUtilities.getPickValues('Had_illness__c')[0]; //Picklist (Multi-Select)
		i.Hallucination__c  = WSUtilities.getPickValues('Hallucination__c')[0]; //Picklist
		i.History_Domestic_Violence__c  = WSUtilities.getPickValues('History_Domestic_Violence__c')[0]; //Picklist
		i.History_of_Abuse__c  = WSUtilities.getPickValues('History_of_Abuse__c')[0]; //Picklist
		i.Hobbies__c  = WSUtilities.getPickValues('Hobbies__c')[0]; //Picklist (Multi-Select)
		i.Household_Rules__c  = WSUtilities.getPickValues('Household_Rules__c')[0]; //Picklist
		i.Housing__c  = WSUtilities.getPickValues('Housing__c')[0]; //Picklist
		i.Income_Source__c  = WSUtilities.getPickValues('Income_Source__c')[0]; //Picklist
		i.Insight__c  = WSUtilities.getPickValues('Insight__c')[0]; //Picklist
		i.Intelligence__c  = WSUtilities.getPickValues('Intelligence__c')[0]; //Picklist
		i.Interest_Areas__c  = WSUtilities.getPickValues('Interest_Areas__c')[0]; //Picklist (Multi-Select)
		i.Judgment__c  = WSUtilities.getPickValues('Judgment__c')[0]; //Picklist
		i.Life_Skills__c  = WSUtilities.getPickValues('Life_Skills__c')[0]; //Picklist (Multi-Select)
		i.Mailing_Address_Type__c  = WSUtilities.getPickValues('Mailing_Address_Type__c')[0]; //Picklist
		i.Mailing_State__c  = WSUtilities.getPickValues('Mailing_State__c')[0]; //Picklist
		i.Mailing_State__c  = WSUtilities.getPickValues('Mailing_State__c')[0]; //Picklist
		i.Math__c  = WSUtilities.getPickValues('Math__c')[0]; //Picklist
		i.Medication_Compliance__c  = WSUtilities.getPickValues('Medication_Compliance__c')[0]; //Picklist
		i.Mental_Health_History__c  = WSUtilities.getPickValues('Mental_Health_History__c')[0]; //Picklist
		i.Mood__c  = WSUtilities.getPickValues('Mood__c')[0]; //Picklist
		i.Motor_Activity__c  = WSUtilities.getPickValues('Motor_Activity__c')[0]; //Picklist
		i.Organization__c  = WSUtilities.getPickValues('Organization__c')[0]; //Picklist
		i.Orientation__c  = WSUtilities.getPickValues('Orientation__c')[0]; //Picklist
		i.Other_Address_Type__c  = WSUtilities.getPickValues('Other_Address_Type__c')[0]; //Picklist
		i.Other_Address_Type__c  = WSUtilities.getPickValues('Other_Address_Type__c')[0]; //Picklist
		i.Other_Guardian_Relationship__c  = WSUtilities.getPickValues('Other_Guardian_Relationship__c')[0]; //Picklist
		i.Other_State__c  = WSUtilities.getPickValues('Other_State__c')[0]; //Picklist
		i.Other_State__c  = WSUtilities.getPickValues('Other_State__c')[0]; //Picklist
		i.Permanency_Goal__c  = WSUtilities.getPickValues('Permanency_Goal__c')[0]; //Picklist
		i.Posture__c  = WSUtilities.getPickValues('Posture__c')[0]; //Picklist
		i.Pre_Natal_Issues__c  = WSUtilities.getPickValues('Pre_Natal_Issues__c')[0]; //Picklist
		i.Preferred_Email__c  = WSUtilities.getPickValues('Preferred_Email__c')[0]; //Picklist
		i.Preferred_Email__c  = WSUtilities.getPickValues('Preferred_Email__c')[0]; //Picklist
		i.PreferredPhone__c  = WSUtilities.getPickValues('PreferredPhone__c')[0]; //Picklist
		i.PreferredPhone__c  = WSUtilities.getPickValues('PreferredPhone__c')[0]; //Picklist
		i.Preoccupation__c  = WSUtilities.getPickValues('Preoccupation__c')[0]; //Picklist
		i.Primary_Guardian_Relationship__c  = WSUtilities.getPickValues('Primary_Guardian_Relationship__c')[0]; //Picklist
		i.PSSA_Keystone__c  = WSUtilities.getPickValues('PSSA_Keystone__c')[0]; //Picklist
		i.Race__c  = WSUtilities.getPickValues('Race__c')[0]; //Picklist
		i.Race__c  = WSUtilities.getPickValues('Race__c')[0]; //Picklist
		i.Reading__c  = WSUtilities.getPickValues('Reading__c')[0]; //Picklist
		i.Reality_Testing__c  = WSUtilities.getPickValues('Reality_Testing__c')[0]; //Picklist
		i.Recall__c  = WSUtilities.getPickValues('Recall__c')[0]; //Picklist
		i.Recent_Grades__c  = WSUtilities.getPickValues('Recent_Grades__c')[0]; //Picklist
		i.Recommendation__c  = WSUtilities.getPickValues('Recommendation__c')[0]; //Picklist
		i.Referal_Completed__c  = WSUtilities.getPickValues('Referal_Completed__c')[0]; //Picklist
		i.Referral_Source_Type__c  = WSUtilities.getPickValues('Referral_Source_Type__c')[0]; //Picklist
		i.Referral_Type__c  = WSUtilities.getPickValues('Referral_Type__c')[0]; //Picklist
		i.Reward__c  = WSUtilities.getPickValues('Reward__c')[0]; //Picklist
		i.Service_Level__c  = WSUtilities.getPickValues('Service_Level__c')[0]; //Picklist
		i.SES_Program__c  = WSUtilities.getPickValues('SES_Program__c')[0]; //Picklist
		i.Sexual_Preference__c  = WSUtilities.getPickValues('Sexual_Preference__c')[0]; //Picklist
		i.Skill_Deficits__c  = WSUtilities.getPickValues('Skill_Deficits__c')[0]; //Picklist
		i.Social_Judgment__c  = WSUtilities.getPickValues('Social_Judgment__c')[0]; //Picklist
		i.Social_Maturity__c  = WSUtilities.getPickValues('Social_Maturity__c')[0]; //Picklist
		i.Speech__c  = WSUtilities.getPickValues('Speech__c')[0]; //Picklist
		i.Stature__c  = WSUtilities.getPickValues('Stature__c')[0]; //Picklist
		i.Stressors__c  = WSUtilities.getPickValues('Stressors__c')[0]; //Picklist
		// i.Supports__c  = WSUtilities.getPickValues('Supports__c')[0]; //Picklist
		// i.Target_Neighborhood__c  = WSUtilities.getPickValues('Target_Neighborhood__c')[0]; //Picklist
		// i.Thoughts__c  = WSUtilities.getPickValues('Thoughts__c')[0]; //Picklist
		i.Weight__c  = WSUtilities.getPickValues('Weight__c')[0]; //Picklist


		//Booleans

		Boolean TheBox;

		TheBox = TRUE;

		i.Court_Active__c  = TheBox; //Checkbox
		i.CYF_Active__C  = TheBox; //Checkbox
		i.Acne__c  = TheBox; //Checkbox
		i.Alt_Transportation__c  = TheBox; //Checkbox
		i.Awake_Alert__c  = TheBox; //Checkbox
		i.Behavior_Problems__c  = TheBox; //Checkbox
		i.Birthmarks__c  = TheBox; //Checkbox
		i.Bruises__c  = TheBox; //Checkbox
		i.Bullying_Perpetrator__c  = TheBox; //Checkbox
		i.Bullying_Victim__c  = TheBox; //Checkbox
		i.Campus_Visit__c  = TheBox; //Checkbox
		i.Career_Fair__c  = TheBox; //Checkbox
		i.Chores__c  = TheBox; //Checkbox
		i.Close_Friends__c  = TheBox; //Checkbox
		i.College_Board__c  = TheBox; //Checkbox
		i.Common_Application__c  = TheBox; //Checkbox
		i.Community_Activities__c  = TheBox; //Checkbox
		i.Community_Collaborative__c  = TheBox; //Checkbox
		i.Community_Service__c  = TheBox; //Checkbox
		i.Confidentiality_Statement__c  = TheBox; //Checkbox
		i.Conflicts_wParents__c  = TheBox; //Checkbox
		i.ConsentReturn_Unsupervised__c  = TheBox; //Checkbox
		i.Counseling__c  = TheBox; //Checkbox
		i.Curfew__c  = TheBox; //Checkbox
		i.Current_Schedule_Submittted__c  = TheBox; //Checkbox
		i.CYF_Advocate__c  = TheBox; //Checkbox
		i.December__c  = TheBox; //Checkbox
		i.Deformities__c  = TheBox; //Checkbox
		i.Detention__c  = TheBox; //Checkbox
		i.Disruptive__c  = TheBox; //Checkbox
		i.Dressed_Appropriate__c  = TheBox; //Checkbox
		i.Drug_Withdrawal__c  = TheBox; //Checkbox
		i.Expectations__c  = TheBox; //Checkbox
		i.Expulsions__c  = TheBox; //Checkbox
		i.Family_Handbook_Acceptance__c  = TheBox; //Checkbox
		i.February__c  = TheBox; //Checkbox
		i.Good_Hygiene__c  = TheBox; //Checkbox
		i.Graduated__c  = TheBox; //Checkbox
		i.Group_Expectations__c  = TheBox; //Checkbox
		i.Group_Rules_Agreement__c  = TheBox; //Checkbox
		i.Hyperactive__c  = TheBox; //Checkbox
		i.IEP__c  = TheBox; //Checkbox
		i.IL_Worker__c  = TheBox; //Checkbox
		i.In_School__c  = TheBox; //Checkbox
		i.Infestations__c  = TheBox; //Checkbox
		i.Initial__c  = TheBox; //Checkbox
		i.Interests_Specialty_Group__c  = TheBox; //Checkbox
		i.Interview_Skills__c  = TheBox; //Checkbox
		i.Inventory_35__c  = TheBox; //Checkbox
		i.Inventory_68__c  = TheBox; //Checkbox
		i.Inventory_912__c  = TheBox; //Checkbox
		i.Irritability__c  = TheBox; //Checkbox
		i.Issuesw_Parents_Friends__c  = TheBox; //Checkbox
		i.Issuesw_Siblings__c  = TheBox; //Checkbox
		i.JA_Biztown__c  = TheBox; //Checkbox
		i.January__c  = TheBox; //Checkbox
		i.Job_Application__c  = TheBox; //Checkbox
		i.Learning_Disability__c  = TheBox; //Checkbox
		i.Lesions__c  = TheBox; //Checkbox
		i.March__c  = TheBox; //Checkbox
		i.Medical_Collaborative__c  = TheBox; //Checkbox
		i.Medical_Release__c  = TheBox; //Checkbox
		i.Mentor_Program__c  = TheBox; //Checkbox
		i.Movements_Coordinated__c  = TheBox; //Checkbox
		i.Navience_Account__c  = TheBox; //Checkbox
		i.Needlemarks__c  = TheBox; //Checkbox
		i.No_Problems__c  = TheBox; //Checkbox
		i.November__c  = TheBox; //Checkbox
		i.October__c  = TheBox; //Checkbox
		i.Out_of_C_S__c  = TheBox; //Checkbox
		i.Permission_to_Photogragh__c  = TheBox; //Checkbox
		i.Personal_Wellness__c  = TheBox; //Checkbox
		i.Piercings__c  = TheBox; //Checkbox
		i.Pregnant_Parenting__c  = TheBox; //Checkbox
		i.PreGroup_Assessment__c  = TheBox; //Checkbox
		i.Problems_at_Work__c  = TheBox; //Checkbox
		i.Problems_in_School__c  = TheBox; //Checkbox
		i.Problems_wGuardian__c  = TheBox; //Checkbox
		i.PSAT_ACT__c  = TheBox; //Checkbox
		i.Quiet__c  = TheBox; //Checkbox
		i.Rash__c  = TheBox; //Checkbox
		i.Received_Rewards__c  = TheBox; //Checkbox
		i.Recommendation_Letter__c  = TheBox; //Checkbox
		i.Relationship__c  = TheBox; //Checkbox
		i.Release_Info_Consent__c  = TheBox; //Checkbox
		i.Religion_Importance__c  = TheBox; //Checkbox
		i.Resume__c  = TheBox; //Checkbox
		i.Rewards_Points_Policy__c  = TheBox; //Checkbox
		i.Runs_Away__c  = TheBox; //Checkbox
		i.Sad__c  = TheBox; //Checkbox
		i.SAT_Prep_Course__c  = TheBox; //Checkbox
		i.Scars__c  = TheBox; //Checkbox
		i.Secondary__c  = TheBox; //Checkbox
		i.Securing_Housing__c  = TheBox; //Checkbox
		i.Self_Advocacy__c  = TheBox; //Checkbox
		i.Serious_Relationship__c  = TheBox; //Checkbox
		i.Speech_Difficulties__c  = TheBox; //Checkbox
		// i.Suspension__c  = TheBox; //Checkbox
		// i.Tattoos__c  = TheBox; //Checkbox
		// i.Teacher_Peer_Interaction__c  = TheBox; //Checkbox
		i.Television_R_V__c  = TheBox; //Checkbox
		i.Transportation_Consent__c  = TheBox; //Checkbox
		// i.Traumatic_Marks__c  = TheBox; //Checkbox
		// i.Truancy__c  = TheBox; //Checkbox
		// i.Utilizing_Community__c  = TheBox; //Checkbox
		// i.Works__c  = TheBox; //Checkbox
		// i.X10th_Transcript_Review__c  = TheBox; //Checkbox
		// i.X11th_Transcript_Review__c  = TheBox; //Checkbox
		// i.Yellowish_Tent__c  = TheBox; //Checkbox

		//Date

		Date TheDate;

		TheDate = Date.newInstance(2016, 1, 1);

		i.Birthdate__c  = TheDate; //Date
		i.Date_of_Placement__c  = TheDate; //Date
		i.Casey_Assessment__c  = TheDate; //Date
		i.Clothing_Inventory__c  = TheDate; //Date
		i.D_O_B__c  = TheDate; //Date
		i.Dental_Visit__c  = TheDate; //Date
		i.Emergency_Information__c  = TheDate; //Date
		i.FACE_Sheet__c  = TheDate; //Date
		i.FERPA__c  = TheDate; //Date
		i.Financial_Literacy__c  = TheDate; //Date
		i.Form_Completion_Date__c  = TheDate; //Date
		i.Graduation_Date__c  = TheDate; //Date
		i.IEP_Review__c  = TheDate; //Date
		i.Intake_Checklist__c  = TheDate; //Date
		i.Job_Readiness__c  = TheDate; //Date
		i.Job_Shadowing__c  = TheDate; //Date
		i.Keys_Work__c  = TheDate; //Date
		i.Last_Physical__c  = TheDate; //Date
		i.Placement__c  = TheDate; //Date
		i.Recent_IEP__c  = TheDate; //Date
		i.Screening_Completed__c  = TheDate; //Date
		// i.Transition_Activities__c  = TheDate; //Date
		// i.Transition_Activity__c  = TheDate; //Date

		//DateTime

		DateTime TheDateTime;

		TheDateTime = DateTime.now();

		i.Referral_Received__c  = TheDateTime; //Date/Time

		//Currency

		Integer TheDollars;

		TheDollars = 1000;

		i.Restitution__c  = TheDollars; //Currency(18, 0)

		//Email

		String TheEmail;

		TheEmail = 'support@gwensgirls.org';

		i.Alternate_Email__c  = TheEmail; //Email
		i.Personal_Email__c  = TheEmail; //Email
		i.Work_Email__c  = TheEmail; //Email
		i.Alternate_Email__c  = TheEmail; //Email
		i.Personal_Email__c  = TheEmail; //Email
		i.Work_Email__c  = TheEmail; //Email

		//Number

		Integer  TheNumber;

		TheNumber = 1;

		i.Height_feet__c  = TheNumber; //Number(18, 0)
		i.Height_inches__c  = TheNumber; //Number(18, 0)
		i.Weight_NUM__c  = TheNumber; //Number(18, 0)
		i.Caregivers_Disciplinary_Practices__c  = TheNumber; //Number(18, 0)
		i.Caregivers_Expectations__c  = TheNumber; //Number(18, 0)
		i.Caregivers_Parents_DA__c  = TheNumber; //Number(18, 0)
		i.Caregivers_Parents_MH__c  = TheNumber; //Number(18, 0)
		i.Caregivers_Parents_PH__c  = TheNumber; //Number(18, 0)
		i.Child_Behavior__c  = TheNumber; //Number(18, 0)
		i.Child_Caregivers_Parents_Relationship__c  = TheNumber; //Number(18, 0)
		i.Child_Drug_Alcohol__c  = TheNumber; //Number(18, 0)
		i.Child_MH__c  = TheNumber; //Number(18, 0)
		i.Child_Peer_Relationship__c  = TheNumber; //Number(18, 0)
		i.Child_School_Performance__c  = TheNumber; //Number(18, 0)
		i.Detentions__c  = TheNumber; //Number(18, 0)
		i.Environment_Housing__c  = TheNumber; //Number(18, 0)
		i.Environment_Income_Employment__c  = TheNumber; //Number(18, 0)
		i.Family_Caregivers_Parents_Relationship__c  = TheNumber; //Number(18, 0)
		i.Family_Community_Support__c  = TheNumber; //Number(18, 0)
		i.Family_Interactions__c  = TheNumber; //Number(18, 0)
		i.Family_Safety__c  = TheNumber; //Number(18, 0)
		i.Grade__c  = TheNumber; //Number(18, 0)
		i.Hats__c  = TheNumber; //Number(18, 0)
		i.Hearing_Left__c  = TheNumber; //Number(18, 0)
		i.Hearing_Right__c  = TheNumber; //Number(18, 0)
		i.Missed_School__c  = TheNumber; //Number(18, 0)
		i.Pajamas__c  = TheNumber; //Number(18, 0)
		i.Pants__c  = TheNumber; //Number(18, 0)
		i.Shirts__c  = TheNumber; //Number(18, 0)
		i.Shoes__c  = TheNumber; //Number(18, 0)
		i.Socks__c  = TheNumber; //Number(18, 0)
		// i.Suspensions__c  = TheNumber; //Number(18, 0)
		// i.Undergarments__c  = TheNumber; //Number(18, 0)
		// i.Vision_Left__c  = TheNumber; //Number(18, 0)
		// i.Vision_Right__c  = TheNumber; //Number(18, 0)
		// i.Winter_Boots__c  = TheNumber; //Number(18, 0)
		// i.Winter_Coats__c  = TheNumber; //Number(18, 0)

		//Phone

		String ThePhone;

		ThePhone = '4123251565';

		i.Mobile_Phone__c  = ThePhone; //Phone
		i.Work_Phone__c  = ThePhone; //Phone
		i.Home_Phone__c  = ThePhone; //Phone
		i.Other_Phone__c  = ThePhone; //Phone
		i.Mobile_Phone__c  = ThePhone; //Phone
		i.Work_Phone__c  = ThePhone; //Phone
		i.Home_Phone__c  = ThePhone; //Phone
		i.Other_Phone__c  = ThePhone; //Phone
		i.Emergency_Contact_Phone__c  = ThePhone; //Phone
		i.Emergency_Contact_Cell_Phone__c  = ThePhone; //Phone
		i.Emergency_Contact_2_Phone__c  = ThePhone; //Phone
		i.Emergency_Contact_2_Cell_Phone__c  = ThePhone; //Phone
		i.Case_Worker__c  = ThePhone; //Phone
		i.Physician_Phone__c  = ThePhone; //Phone
		i.Probation_Officers__c  = ThePhone; //Phone

		//Text

		String TheText;

		TheText = 'Test';

		i.About_You__c  = TheText; //Long Text Area(32768)
		i.Guardian_Issues_Detailed__c  = TheText; //Long Text Area(32768)
		i.Health_Safety__c  = TheText; //Long Text Area(32768)
		i.Important_to_You__c  = TheText; //Long Text Area(32768)
		i.Interviewer_Assessment__c  = TheText; //Long Text Area(32768)
		i.Issues_Detail_other__c  = TheText; //Long Text Area(32768)
		i.Makes_You_Happy__c  = TheText; //Long Text Area(32768)
		i.Medications__c  = TheText; //Long Text Area(32768)
		i.Notes__c  = TheText; //Long Text Area(32768)
		i.Operations_Injuries__c  = TheText; //Long Text Area(32768)
		i.Parent_Guardians_Relationship__c  = TheText; //Long Text Area(32768)
		i.Physical_Mental_History__c  = TheText; //Long Text Area(32768)
		i.Physicians_Advice__c  = TheText; //Long Text Area(32768)
		i.School_Problems_Detailed__c  = TheText; //Long Text Area(32768)
		i.Sibling_Issues_Detailed__c  = TheText; //Long Text Area(32768)
		i.Why_are_you_here__c  = TheText; //Long Text Area(32768)
		// i.Work_Issues__c  = TheText; //Long Text Area(32768)
		i.Worries_Upsets_You__c  = TheText; //Long Text Area(32768)
		i.Mailing_City__c  = TheText; //Text Area(255)
		i.Mailing_Street__c  = TheText; //Text Area(255)
		i.Other_City__c  = TheText; //Text Area(255)
		i.Other_Street__c  = TheText; //Text Area(255)
		i.Comments__c  = TheText; //Text Area(255)
		i.Mailing_City__c  = TheText; //Text Area(255)
		i.Mailing_Street__c  = TheText; //Text Area(255)
		i.Other_Street__c  = TheText; //Text Area(255)
		i.Allergies_Detailed__c  = TheText; //Text Area(255)
		i.Behavior_Exhibited__c  = TheText; //Text Area(255)
		i.Comments__c  = TheText; //Text Area(255)
		i.Counseling_Detailed__c  = TheText; //Text Area(255)
		i.Counseling_Detailed2__c  = TheText; //Text Area(255)
		i.DA_Concerns_Detailed__c  = TheText; //Text Area(255)
		i.Education_Concerns__c  = TheText; //Text Area(255)
		i.Education_Summary__c  = TheText; //Text Area(255)
		i.Explain__c  = TheText; //Text Area(255)
		i.Friends_Detailed__c  = TheText; //Text Area(255)
		i.Fun__c  = TheText; //Text Area(255)
		i.Goal_Summary__c  = TheText; //Text Area(255)
		i.Group_Summary__c  = TheText; //Text Area(255)
		i.Health_Summary__c  = TheText; //Text Area(255)
		i.Home_Summary__c  = TheText; //Text Area(255)
		i.How_are_your_Grades__c  = TheText; //Text Area(255)
		i.illness_Detailed__c  = TheText; //Text Area(255)
		i.Limitations__c  = TheText; //Text Area(255)
		i.Medical_Issues_other__c  = TheText; //Text Area(255)
		i.MH_History_Detailed__c  = TheText; //Text Area(255)
		i.Placements_Dates__c  = TheText; //Text Area(255)
		i.Referral_Reason__c  = TheText; //Text Area(255)
		i.Religion_Importance_Detailed__c  = TheText; //Text Area(255)
		i.Self_Views__c  = TheText; //Text Area(255)
		i.Special_Needs__c  = TheText; //Text Area(255)
		i.Strengths__c  = TheText; //Text Area(255)
		i.Whom_do_you_live_with__c  = TheText; //Text Area(255)
		i.Eye_Color__c  = TheText; //Text(100)
		i.Hair_Color__c  = TheText; //Text(100)
		i.Mailing_Zip_Code__c  = TheText; //Text(20)
		i.Other_Zip_Code__c  = TheText; //Text(20)
		i.Guardian_Zip__c  = TheText; //Text(20)
		i.Mailing_Zip_Code__c  = TheText; //Text(20)
		i.Other_Zip_Code__c  = TheText; //Text(20)
		i.Identifying_Marks__c  = TheText; //Text(200)
		i.Place_of_Employment__c  = TheText; //Text(200)
		i.Guardian_Street__c  = TheText; //Text(255)
		i.Guardian_City__c  = TheText; //Text(255)
		i.Academic_Goals__c  = TheText; //Text(255)
		i.Activity_Invovlement__c  = TheText; //Text(255)
		i.Additional_Information__c  = TheText; //Text(255)
		i.Behavioral_Issues_other__c  = TheText; //Text(255)
		i.Care_Manager__c  = TheText; //Text(255)
		i.Career_Goal__c  = TheText; //Text(255)
		i.Clothing_Summary__c  = TheText; //Text(255)
		i.Community_Suppports__c  = TheText; //Text(255)
		i.Counseling_When__c  = TheText; //Text(255)
		i.Counseling_When2__c  = TheText; //Text(255)
		i.Counselor__c  = TheText; //Text(255)
		i.Counselor_2__c  = TheText; //Text(255)
		i.Custodianship__c  = TheText; //Text(255)
		i.CYF_Case_Worker__c  = TheText; //Text(255)
		i.DA_Pregnancy__c  = TheText; //Text(255)
		i.Diagnosis__c  = TheText; //Text(255)
		i.Dismissal__c  = TheText; //Text(255)
		i.Family_Supports__c  = TheText; //Text(255)
		i.Gynecological_Exam__c  = TheText; //Text(255)
		i.Insurance_Carrier__c  = TheText; //Text(255)
		i.Issues_Concerns__c  = TheText; //Text(255)
		i.Juvenile_Probation__c  = TheText; //Text(255)
		i.Other_Items__c  = TheText; //Text(255)
		i.Parenting__c  = TheText; //Text(255)
		i.Physician_Facility__c  = TheText; //Text(255)
		i.Physician_Name__c  = TheText; //Text(255)
		i.Pregnancy_Term__c  = TheText; //Text(255)
		i.Referral_Source_Relationship__c  = TheText; //Text(255)
		i.Religion__c  = TheText; //Text(255)
		i.Repeated_Grade__c  = TheText; //Text(255)
		i.Sexual_Abuse__c  = TheText; //Text(255)
		i.Subject_Excelling__c  = TheText; //Text(255)
		i.Subject_Needs_Help__c  = TheText; //Text(255)
		i.Supervisor__c  = TheText; //Text(255)
		// i.Talents_Skills__c  = TheText; //Text(255)
		// i.Voluntary_Service__c  = TheText; //Text(255)
		// i.Talents_Skills__c  = TheText; //Text(255)
		// i.Voluntary_Service__c  = TheText; //Text(255)

		i.First_Name__c  = 'TheTextFN'; //Text(50)
		i.Last_Name__c  = 'TheText'; //Text(50)

		i.Primary_Guardian_First__c  = TheText+'pg'; //Text(50)
		i.Primary_Guardian_Last__c  = TheText; //Text(50)
		i.Other_Caregiver_First__c  = TheText+'CF'; //Text(50)
		i.Other_Caregiver_Last__c  = TheText; //Text(50)
		i.Emergency_Contact_First__c  = TheText+'ECF'; //Text(50)
		i.Emergency_Contact_Last__c  = TheText; //Text(50)
		i.Emergency_Contact_2_First__c  = TheText+'EC2F'; //Text(50)
		i.Emergency_Contact_2_Last__c  = TheText; //Text(50)
		
		insert i;

		//theIntake = i;

		Intake__c thei = new Intake__C();

		String iid = i.Id;

		//Set<Id> ccid = new Set<Id>();

		//ccid.add(i.Id);

		//WSIntakeTools.createContactfromIntake(ccid);

		system.debug('******** iid **********'+iid);

		//Create A Query String for Intake
        SObjectType summarytype = Schema.getGlobalDescribe().get('Intake__c');
        Map<String,Schema.SObjectField> summaryfields = summarytype.getDescribe().fields.getMap(); //A Map of Fields

        string summaryselect = 'Select ';

        for(string pd : summaryfields.keyset()){
            summaryselect = summaryselect + summaryfields.get(pd) + ', ';
        }
        summaryselect = summaryselect.substring(0,summaryselect.length()-2);
        summaryselect = summaryselect + '';
        summaryselect = summaryselect + ' FROM Intake__c WHERE Id =: iid';

        system.debug('***** Query String****'+summaryselect);

        try{
            thei = (Intake__c)Database.query(summaryselect); //The list of Contact Summaries
        }catch(Exception esums){
            system.debug('***********************ERROR Querying Contact Summaries ***********************' + esums.getMessage());
        }

        if(thei == NULL){

        	system.debug('********* NULL thei *************');

        }else{

        	if(thei.Client__c != NULL){

        		system.debug('*************Client Id*********'+ thei.Client__c);
        	}

		}

		thei.Abstraction__c  = WSUtilities.getPickValues('Abstraction__c')[1]; //Picklist
		thei.Abuse__c  = WSUtilities.getPickValues('Abuse__c')[1]; //Picklist (Multi-Select)
		thei.Activities__c  = WSUtilities.getPickValues('Activities__c')[1]; //Picklist (Multi-Select)
		thei.Affect__c  = WSUtilities.getPickValues('Affect__c')[1]; //Picklist
		thei.Allergies__c  = WSUtilities.getPickValues('Allergies__c')[1]; //Picklist (Multi-Select)
		thei.Attendance__c  = WSUtilities.getPickValues('Attendance__c')[1]; //Picklist
		thei.Attention__c  = WSUtilities.getPickValues('Attention__c')[1]; //Picklist
		thei.Attitude__c  = WSUtilities.getPickValues('Attitude__c')[1]; //Picklist
		thei.Behavioral_Issues__c  = WSUtilities.getPickValues('Behavioral_Issues__c')[1]; //Picklist (Multi-Select)
		thei.Boundaries__c  = WSUtilities.getPickValues('Boundaries__c')[1]; //Picklist
		thei.Child_will_Attend_Afterschool__c  = WSUtilities.getPickValues('Child_will_Attend_Afterschool__c')[1]; //Picklist (Multi-Select)
		thei.Clothing__c  = WSUtilities.getPickValues('Clothing__c')[1]; //Picklist
		thei.Community_Resources__c  = WSUtilities.getPickValues('Community_Resources__c')[1]; //Picklist
		thei.Concentration__c  = WSUtilities.getPickValues('Concentration__c')[1]; //Picklist
		thei.Coping_Ability__c  = WSUtilities.getPickValues('Coping_Ability__c')[1]; //Picklist
		thei.Cosmetic_use__c  = WSUtilities.getPickValues('Cosmetic_use__c')[1]; //Picklist
		thei.Course_Description__c  = WSUtilities.getPickValues('Course_Description__c')[1]; //Picklist
		thei.Current_DA_Concerns__c  = WSUtilities.getPickValues('Current_DA_Concerns__c')[1]; //Picklist
		thei.Current_Living_Situation__c  = WSUtilities.getPickValues('Current_Living_Situation__c')[1]; //Picklist
		thei.DA_History__c  = WSUtilities.getPickValues('DA_History__c')[1]; //Picklist
		thei.Decision_Making__c  = WSUtilities.getPickValues('Decision_Making__c')[1]; //Picklist
		thei.Defective_Memory__c  = WSUtilities.getPickValues('Defective_Memory__c')[1]; //Picklist
		thei.Developmental_Delay__c  = WSUtilities.getPickValues('Developmental_Delay__c')[1]; //Picklist
		thei.Education_Program__c  = WSUtilities.getPickValues('Education_Program__c')[1]; //Picklist
		thei.Education_Type__c  = WSUtilities.getPickValues('Education_Type__c')[1]; //Picklist
		thei.Educational_Support__c  = WSUtilities.getPickValues('Educational_Support__c')[1]; //Picklist
		thei.Eye_Contact__c  = WSUtilities.getPickValues('Eye_Contact__c')[1]; //Picklist
		thei.Facial_Expresion__c  = WSUtilities.getPickValues('Facial_Expresion__c')[1]; //Picklist
		thei.Family_Discussion__c  = WSUtilities.getPickValues('Family_Discussion__c')[1]; //Picklist
		thei.Family_Functioning_Level__c  = WSUtilities.getPickValues('Family_Functioning_Level__c')[1]; //Picklist (Multi-Select)
		thei.Fund_Knowledge__c  = WSUtilities.getPickValues('Fund_Knowledge__c')[1]; //Picklist
		thei.Gender__c  = WSUtilities.getPickValues('Gender__c')[1]; //Picklist
		thei.GPA__c  = WSUtilities.getPickValues('GPA__c')[1]; //Picklist
		thei.Grade_History__c  = WSUtilities.getPickValues('Grade_History__c')[1]; //Picklist
		thei.Graduation_Type__c  = WSUtilities.getPickValues('Graduation_Type__c')[1]; //Picklist
		thei.Grooming__c  = WSUtilities.getPickValues('Grooming__c')[1]; //Picklist
		thei.Guardian_State__c  = WSUtilities.getPickValues('Guardian_State__c')[1]; //Picklist
		thei.Had_illness__c  = WSUtilities.getPickValues('Had_illness__c')[1]; //Picklist (Multi-Select)
		thei.Hallucination__c  = WSUtilities.getPickValues('Hallucination__c')[1]; //Picklist
		thei.History_Domestic_Violence__c  = WSUtilities.getPickValues('History_Domestic_Violence__c')[1]; //Picklist
		thei.History_of_Abuse__c  = WSUtilities.getPickValues('History_of_Abuse__c')[1]; //Picklist
		thei.Hobbies__c  = WSUtilities.getPickValues('Hobbies__c')[1]; //Picklist (Multi-Select)
		thei.Household_Rules__c  = WSUtilities.getPickValues('Household_Rules__c')[1]; //Picklist
		thei.Housing__c  = WSUtilities.getPickValues('Housing__c')[1]; //Picklist
		thei.Income_Source__c  = WSUtilities.getPickValues('Income_Source__c')[1]; //Picklist
		thei.Insight__c  = WSUtilities.getPickValues('Insight__c')[1]; //Picklist
		thei.Intelligence__c  = WSUtilities.getPickValues('Intelligence__c')[1]; //Picklist
		thei.Interest_Areas__c  = WSUtilities.getPickValues('Interest_Areas__c')[1]; //Picklist (Multi-Select)
		thei.Judgment__c  = WSUtilities.getPickValues('Judgment__c')[1]; //Picklist
		thei.Life_Skills__c  = WSUtilities.getPickValues('Life_Skills__c')[1]; //Picklist (Multi-Select)
		thei.Mailing_Address_Type__c  = WSUtilities.getPickValues('Mailing_Address_Type__c')[1]; //Picklist
		thei.Mailing_State__c  = WSUtilities.getPickValues('Mailing_State__c')[1]; //Picklist
		thei.Mailing_State__c  = WSUtilities.getPickValues('Mailing_State__c')[1]; //Picklist
		thei.Math__c  = WSUtilities.getPickValues('Math__c')[1]; //Picklist
		thei.Medication_Compliance__c  = WSUtilities.getPickValues('Medication_Compliance__c')[1]; //Picklist
		thei.Mental_Health_History__c  = WSUtilities.getPickValues('Mental_Health_History__c')[1]; //Picklist
		thei.Mood__c  = WSUtilities.getPickValues('Mood__c')[1]; //Picklist
		thei.Motor_Activity__c  = WSUtilities.getPickValues('Motor_Activity__c')[1]; //Picklist
		thei.Organization__c  = WSUtilities.getPickValues('Organization__c')[1]; //Picklist
		thei.Orientation__c  = WSUtilities.getPickValues('Orientation__c')[1]; //Picklist
		thei.Other_Address_Type__c  = WSUtilities.getPickValues('Other_Address_Type__c')[1]; //Picklist
		thei.Other_Address_Type__c  = WSUtilities.getPickValues('Other_Address_Type__c')[1]; //Picklist
		thei.Other_Guardian_Relationship__c  = WSUtilities.getPickValues('Other_Guardian_Relationship__c')[1]; //Picklist
		thei.Other_State__c  = WSUtilities.getPickValues('Other_State__c')[1]; //Picklist
		thei.Other_State__c  = WSUtilities.getPickValues('Other_State__c')[1]; //Picklist
		thei.Permanency_Goal__c  = WSUtilities.getPickValues('Permanency_Goal__c')[1]; //Picklist
		thei.Posture__c  = WSUtilities.getPickValues('Posture__c')[1]; //Picklist
		thei.Pre_Natal_Issues__c  = WSUtilities.getPickValues('Pre_Natal_Issues__c')[1]; //Picklist
		thei.Preferred_Email__c  = WSUtilities.getPickValues('Preferred_Email__c')[1]; //Picklist
		thei.Preferred_Email__c  = WSUtilities.getPickValues('Preferred_Email__c')[1]; //Picklist
		thei.PreferredPhone__c  = WSUtilities.getPickValues('PreferredPhone__c')[1]; //Picklist
		thei.PreferredPhone__c  = WSUtilities.getPickValues('PreferredPhone__c')[1]; //Picklist
		thei.Preoccupation__c  = WSUtilities.getPickValues('Preoccupation__c')[1]; //Picklist
		thei.Primary_Guardian_Relationship__c  = WSUtilities.getPickValues('Primary_Guardian_Relationship__c')[1]; //Picklist
		thei.PSSA_Keystone__c  = WSUtilities.getPickValues('PSSA_Keystone__c')[1]; //Picklist
		thei.Race__c  = WSUtilities.getPickValues('Race__c')[1]; //Picklist
		thei.Race__c  = WSUtilities.getPickValues('Race__c')[1]; //Picklist
		thei.Reading__c  = WSUtilities.getPickValues('Reading__c')[1]; //Picklist
		thei.Reality_Testing__c  = WSUtilities.getPickValues('Reality_Testing__c')[1]; //Picklist
		thei.Recall__c  = WSUtilities.getPickValues('Recall__c')[1]; //Picklist
		thei.Recent_Grades__c  = WSUtilities.getPickValues('Recent_Grades__c')[1]; //Picklist
		thei.Recommendation__c  = WSUtilities.getPickValues('Recommendation__c')[1]; //Picklist
		thei.Referal_Completed__c  = WSUtilities.getPickValues('Referal_Completed__c')[1]; //Picklist
		thei.Referral_Source_Type__c  = WSUtilities.getPickValues('Referral_Source_Type__c')[1]; //Picklist
		thei.Referral_Type__c  = WSUtilities.getPickValues('Referral_Type__c')[1]; //Picklist
		thei.Reward__c  = WSUtilities.getPickValues('Reward__c')[1]; //Picklist
		thei.Service_Level__c  = WSUtilities.getPickValues('Service_Level__c')[1]; //Picklist
		thei.SES_Program__c  = WSUtilities.getPickValues('SES_Program__c')[1]; //Picklist
		thei.Sexual_Preference__c  = WSUtilities.getPickValues('Sexual_Preference__c')[1]; //Picklist
		thei.Skill_Deficits__c  = WSUtilities.getPickValues('Skill_Deficits__c')[1]; //Picklist
		thei.Social_Judgment__c  = WSUtilities.getPickValues('Social_Judgment__c')[1]; //Picklist
		thei.Social_Maturity__c  = WSUtilities.getPickValues('Social_Maturity__c')[1]; //Picklist
		thei.Speech__c  = WSUtilities.getPickValues('Speech__c')[1]; //Picklist
		thei.Stature__c  = WSUtilities.getPickValues('Stature__c')[1]; //Picklist
		thei.Stressors__c  = WSUtilities.getPickValues('Stressors__c')[1]; //Picklist
		// thei.Supports__c  = WSUtilities.getPickValues('Supports__c')[1]; //Picklist
		// thei.Target_Neighborhood__c  = WSUtilities.getPickValues('Target_Neighborhood__c')[1]; //Picklist
		// thei.Thoughts__c  = WSUtilities.getPickValues('Thoughts__c')[1]; //Picklist
		thei.Weight__c  = WSUtilities.getPickValues('Weight__c')[1]; //Picklist


		//Booleans

		TheBox = FALSE;

		thei.Court_Active__c  = TheBox; //Checkbox
		thei.CYF_Active__C  = TheBox; //Checkbox
		thei.Acne__c  = TheBox; //Checkbox
		thei.Alt_Transportation__c  = TheBox; //Checkbox
		thei.Awake_Alert__c  = TheBox; //Checkbox
		thei.Behavior_Problems__c  = TheBox; //Checkbox
		thei.Birthmarks__c  = TheBox; //Checkbox
		thei.Bruises__c  = TheBox; //Checkbox
		thei.Bullying_Perpetrator__c  = TheBox; //Checkbox
		thei.Bullying_Victim__c  = TheBox; //Checkbox
		thei.Campus_Visit__c  = TheBox; //Checkbox
		thei.Career_Fair__c  = TheBox; //Checkbox
		thei.Chores__c  = TheBox; //Checkbox
		thei.Close_Friends__c  = TheBox; //Checkbox
		thei.College_Board__c  = TheBox; //Checkbox
		thei.Common_Application__c  = TheBox; //Checkbox
		thei.Community_Activities__c  = TheBox; //Checkbox
		thei.Community_Collaborative__c  = TheBox; //Checkbox
		thei.Community_Service__c  = TheBox; //Checkbox
		thei.Confidentiality_Statement__c  = TheBox; //Checkbox
		thei.Conflicts_wParents__c  = TheBox; //Checkbox
		thei.ConsentReturn_Unsupervised__c  = TheBox; //Checkbox
		thei.Counseling__c  = TheBox; //Checkbox
		thei.Curfew__c  = TheBox; //Checkbox
		thei.Current_Schedule_Submittted__c  = TheBox; //Checkbox
		thei.CYF_Advocate__c  = TheBox; //Checkbox
		thei.December__c  = TheBox; //Checkbox
		thei.Deformities__c  = TheBox; //Checkbox
		thei.Detention__c  = TheBox; //Checkbox
		thei.Disruptive__c  = TheBox; //Checkbox
		thei.Dressed_Appropriate__c  = TheBox; //Checkbox
		thei.Drug_Withdrawal__c  = TheBox; //Checkbox
		thei.Expectations__c  = TheBox; //Checkbox
		thei.Expulsions__c  = TheBox; //Checkbox
		thei.Family_Handbook_Acceptance__c  = TheBox; //Checkbox
		thei.February__c  = TheBox; //Checkbox
		thei.Good_Hygiene__c  = TheBox; //Checkbox
		thei.Graduated__c  = TheBox; //Checkbox
		thei.Group_Expectations__c  = TheBox; //Checkbox
		thei.Group_Rules_Agreement__c  = TheBox; //Checkbox
		thei.Hyperactive__c  = TheBox; //Checkbox
		thei.IEP__c  = TheBox; //Checkbox
		thei.IL_Worker__c  = TheBox; //Checkbox
		thei.In_School__c  = TheBox; //Checkbox
		thei.Infestations__c  = TheBox; //Checkbox
		thei.Initial__c  = TheBox; //Checkbox
		thei.Interests_Specialty_Group__c  = TheBox; //Checkbox
		thei.Interview_Skills__c  = TheBox; //Checkbox
		thei.Inventory_35__c  = TheBox; //Checkbox
		thei.Inventory_68__c  = TheBox; //Checkbox
		thei.Inventory_912__c  = TheBox; //Checkbox
		thei.Irritability__c  = TheBox; //Checkbox
		thei.Issuesw_Parents_Friends__c  = TheBox; //Checkbox
		thei.Issuesw_Siblings__c  = TheBox; //Checkbox
		thei.JA_Biztown__c  = TheBox; //Checkbox
		thei.January__c  = TheBox; //Checkbox
		thei.Job_Application__c  = TheBox; //Checkbox
		thei.Learning_Disability__c  = TheBox; //Checkbox
		thei.Lesions__c  = TheBox; //Checkbox
		thei.March__c  = TheBox; //Checkbox
		thei.Medical_Collaborative__c  = TheBox; //Checkbox
		thei.Medical_Release__c  = TheBox; //Checkbox
		thei.Mentor_Program__c  = TheBox; //Checkbox
		thei.Movements_Coordinated__c  = TheBox; //Checkbox
		thei.Navience_Account__c  = TheBox; //Checkbox
		thei.Needlemarks__c  = TheBox; //Checkbox
		thei.No_Problems__c  = TheBox; //Checkbox
		thei.November__c  = TheBox; //Checkbox
		thei.October__c  = TheBox; //Checkbox
		thei.Out_of_C_S__c  = TheBox; //Checkbox
		thei.Permission_to_Photogragh__c  = TheBox; //Checkbox
		thei.Personal_Wellness__c  = TheBox; //Checkbox
		thei.Piercings__c  = TheBox; //Checkbox
		thei.Pregnant_Parenting__c  = TheBox; //Checkbox
		thei.PreGroup_Assessment__c  = TheBox; //Checkbox
		thei.Problems_at_Work__c  = TheBox; //Checkbox
		thei.Problems_in_School__c  = TheBox; //Checkbox
		thei.Problems_wGuardian__c  = TheBox; //Checkbox
		thei.PSAT_ACT__c  = TheBox; //Checkbox
		thei.Quiet__c  = TheBox; //Checkbox
		thei.Rash__c  = TheBox; //Checkbox
		thei.Received_Rewards__c  = TheBox; //Checkbox
		thei.Recommendation_Letter__c  = TheBox; //Checkbox
		thei.Relationship__c  = TheBox; //Checkbox
		thei.Release_Info_Consent__c  = TheBox; //Checkbox
		thei.Religion_Importance__c  = TheBox; //Checkbox
		thei.Resume__c  = TheBox; //Checkbox
		thei.Rewards_Points_Policy__c  = TheBox; //Checkbox
		thei.Runs_Away__c  = TheBox; //Checkbox
		thei.Sad__c  = TheBox; //Checkbox
		thei.SAT_Prep_Course__c  = TheBox; //Checkbox
		thei.Scars__c  = TheBox; //Checkbox
		thei.Secondary__c  = TheBox; //Checkbox
		thei.Securing_Housing__c  = TheBox; //Checkbox
		thei.Self_Advocacy__c  = TheBox; //Checkbox
		thei.Serious_Relationship__c  = TheBox; //Checkbox
		thei.Speech_Difficulties__c  = TheBox; //Checkbox
		// thei.Suspension__c  = TheBox; //Checkbox
		// thei.Tattoos__c  = TheBox; //Checkbox
		// thei.Teacher_Peer_Interaction__c  = TheBox; //Checkbox
		thei.Television_R_V__c  = TheBox; //Checkbox
		thei.Transportation_Consent__c  = TheBox; //Checkbox
		// thei.Traumatic_Marks__c  = TheBox; //Checkbox
		// thei.Truancy__c  = TheBox; //Checkbox
		// thei.Utilizing_Community__c  = TheBox; //Checkbox
		// thei.Works__c  = TheBox; //Checkbox
		// thei.X10th_Transcript_Review__c  = TheBox; //Checkbox
		// thei.X11th_Transcript_Review__c  = TheBox; //Checkbox
		// thei.Yellowish_Tent__c  = TheBox; //Checkbox

		//Date

		TheDate = Date.newInstance(2016, 2, 1);

		thei.Birthdate__c  = TheDate; //Date
		thei.Date_of_Placement__c  = TheDate; //Date
		thei.Casey_Assessment__c  = TheDate; //Date
		thei.Clothing_Inventory__c  = TheDate; //Date
		thei.D_O_B__c  = TheDate; //Date
		thei.Dental_Visit__c  = TheDate; //Date
		thei.Emergency_Information__c  = TheDate; //Date
		thei.FACE_Sheet__c  = TheDate; //Date
		thei.FERPA__c  = TheDate; //Date
		thei.Financial_Literacy__c  = TheDate; //Date
		thei.Form_Completion_Date__c  = TheDate; //Date
		thei.Graduation_Date__c  = TheDate; //Date
		thei.IEP_Review__c  = TheDate; //Date
		thei.Intake_Checklist__c  = TheDate; //Date
		thei.Job_Readiness__c  = TheDate; //Date
		thei.Job_Shadowing__c  = TheDate; //Date
		thei.Keys_Work__c  = TheDate; //Date
		thei.Last_Physical__c  = TheDate; //Date
		thei.Placement__c  = TheDate; //Date
		thei.Recent_IEP__c  = TheDate; //Date
		thei.Screening_Completed__c  = TheDate; //Date
		// thei.Transition_Activities__c  = TheDate; //Date
		// thei.Transition_Activity__c  = TheDate; //Date

		//DateTime

		TheDateTime = DateTime.now();

		thei.Referral_Received__c  = TheDateTime; //Date/Time

		//Currency

		TheDollars = 2000;

		thei.Restitution__c  = TheDollars; //Currency(18, 0)

		//Email

		TheEmail = 'support2@gwensgirls.org';

		thei.Alternate_Email__c  = TheEmail; //Email
		thei.Personal_Email__c  = TheEmail; //Email
		thei.Work_Email__c  = TheEmail; //Email
		thei.Alternate_Email__c  = TheEmail; //Email
		thei.Personal_Email__c  = TheEmail; //Email
		thei.Work_Email__c  = TheEmail; //Email

		//Number

		TheNumber = 2;

		thei.Height_feet__c  = TheNumber; //Number(18, 0)
		thei.Height_inches__c  = TheNumber; //Number(18, 0)
		thei.Weight_NUM__c  = TheNumber; //Number(18, 0)
		thei.Caregivers_Disciplinary_Practices__c  = TheNumber; //Number(18, 0)
		thei.Caregivers_Expectations__c  = TheNumber; //Number(18, 0)
		thei.Caregivers_Parents_DA__c  = TheNumber; //Number(18, 0)
		thei.Caregivers_Parents_MH__c  = TheNumber; //Number(18, 0)
		thei.Caregivers_Parents_PH__c  = TheNumber; //Number(18, 0)
		thei.Child_Behavior__c  = TheNumber; //Number(18, 0)
		thei.Child_Caregivers_Parents_Relationship__c  = TheNumber; //Number(18, 0)
		thei.Child_Drug_Alcohol__c  = TheNumber; //Number(18, 0)
		thei.Child_MH__c  = TheNumber; //Number(18, 0)
		thei.Child_Peer_Relationship__c  = TheNumber; //Number(18, 0)
		thei.Child_School_Performance__c  = TheNumber; //Number(18, 0)
		thei.Detentions__c  = TheNumber; //Number(18, 0)
		thei.Environment_Housing__c  = TheNumber; //Number(18, 0)
		thei.Environment_Income_Employment__c  = TheNumber; //Number(18, 0)
		thei.Family_Caregivers_Parents_Relationship__c  = TheNumber; //Number(18, 0)
		thei.Family_Community_Support__c  = TheNumber; //Number(18, 0)
		thei.Family_Interactions__c  = TheNumber; //Number(18, 0)
		thei.Family_Safety__c  = TheNumber; //Number(18, 0)
		thei.Grade__c  = TheNumber; //Number(18, 0)
		thei.Hats__c  = TheNumber; //Number(18, 0)
		thei.Hearing_Left__c  = TheNumber; //Number(18, 0)
		thei.Hearing_Right__c  = TheNumber; //Number(18, 0)
		thei.Missed_School__c  = TheNumber; //Number(18, 0)
		thei.Pajamas__c  = TheNumber; //Number(18, 0)
		thei.Pants__c  = TheNumber; //Number(18, 0)
		thei.Shirts__c  = TheNumber; //Number(18, 0)
		thei.Shoes__c  = TheNumber; //Number(18, 0)
		thei.Socks__c  = TheNumber; //Number(18, 0)
		// thei.Suspensions__c  = TheNumber; //Number(18, 0)
		// thei.Undergarments__c  = TheNumber; //Number(18, 0)
		// thei.Vision_Left__c  = TheNumber; //Number(18, 0)
		// thei.Vision_Right__c  = TheNumber; //Number(18, 0)
		// thei.Winter_Boots__c  = TheNumber; //Number(18, 0)
		// thei.Winter_Coats__c  = TheNumber; //Number(18, 0)

		//Phone

		ThePhone = '4123251566';

		thei.Mobile_Phone__c  = ThePhone; //Phone
		thei.Work_Phone__c  = ThePhone; //Phone
		thei.Home_Phone__c  = ThePhone; //Phone
		thei.Other_Phone__c  = ThePhone; //Phone
		thei.Mobile_Phone__c  = ThePhone; //Phone
		thei.Work_Phone__c  = ThePhone; //Phone
		thei.Home_Phone__c  = ThePhone; //Phone
		thei.Other_Phone__c  = ThePhone; //Phone
		thei.Emergency_Contact_Phone__c  = ThePhone; //Phone
		thei.Emergency_Contact_Cell_Phone__c  = ThePhone; //Phone
		thei.Emergency_Contact_2_Phone__c  = ThePhone; //Phone
		thei.Emergency_Contact_2_Cell_Phone__c  = ThePhone; //Phone
		thei.Case_Worker__c  = ThePhone; //Phone
		thei.Physician_Phone__c  = ThePhone; //Phone
		thei.Probation_Officers__c  = ThePhone; //Phone

		//Text

		TheText = 'Test2';

		thei.About_You__c  = TheText; //Long Text Area(32768)
		thei.Guardian_Issues_Detailed__c  = TheText; //Long Text Area(32768)
		thei.Health_Safety__c  = TheText; //Long Text Area(32768)
		thei.Important_to_You__c  = TheText; //Long Text Area(32768)
		thei.Interviewer_Assessment__c  = TheText; //Long Text Area(32768)
		thei.Issues_Detail_other__c  = TheText; //Long Text Area(32768)
		thei.Makes_You_Happy__c  = TheText; //Long Text Area(32768)
		thei.Medications__c  = TheText; //Long Text Area(32768)
		thei.Notes__c  = TheText; //Long Text Area(32768)
		thei.Operations_Injuries__c  = TheText; //Long Text Area(32768)
		thei.Parent_Guardians_Relationship__c  = TheText; //Long Text Area(32768)
		thei.Physical_Mental_History__c  = TheText; //Long Text Area(32768)
		thei.Physicians_Advice__c  = TheText; //Long Text Area(32768)
		thei.School_Problems_Detailed__c  = TheText; //Long Text Area(32768)
		thei.Sibling_Issues_Detailed__c  = TheText; //Long Text Area(32768)
		thei.Why_are_you_here__c  = TheText; //Long Text Area(32768)
		// thei.Work_Issues__c  = TheText; //Long Text Area(32768)
		thei.Worries_Upsets_You__c  = TheText; //Long Text Area(32768)
		thei.Mailing_City__c  = TheText; //Text Area(255)
		thei.Mailing_Street__c  = TheText; //Text Area(255)
		thei.Other_City__c  = TheText; //Text Area(255)
		thei.Other_Street__c  = TheText; //Text Area(255)
		thei.Comments__c  = TheText; //Text Area(255)
		thei.Mailing_City__c  = TheText; //Text Area(255)
		thei.Mailing_Street__c  = TheText; //Text Area(255)
		thei.Other_Street__c  = TheText; //Text Area(255)
		thei.Allergies_Detailed__c  = TheText; //Text Area(255)
		thei.Behavior_Exhibited__c  = TheText; //Text Area(255)
		thei.Comments__c  = TheText; //Text Area(255)
		thei.Counseling_Detailed__c  = TheText; //Text Area(255)
		thei.Counseling_Detailed2__c  = TheText; //Text Area(255)
		thei.DA_Concerns_Detailed__c  = TheText; //Text Area(255)
		thei.Education_Concerns__c  = TheText; //Text Area(255)
		thei.Education_Summary__c  = TheText; //Text Area(255)
		thei.Explain__c  = TheText; //Text Area(255)
		thei.Friends_Detailed__c  = TheText; //Text Area(255)
		thei.Fun__c  = TheText; //Text Area(255)
		thei.Goal_Summary__c  = TheText; //Text Area(255)
		thei.Group_Summary__c  = TheText; //Text Area(255)
		thei.Health_Summary__c  = TheText; //Text Area(255)
		thei.Home_Summary__c  = TheText; //Text Area(255)
		thei.How_are_your_Grades__c  = TheText; //Text Area(255)
		thei.illness_Detailed__c  = TheText; //Text Area(255)
		thei.Limitations__c  = TheText; //Text Area(255)
		thei.Medical_Issues_other__c  = TheText; //Text Area(255)
		thei.MH_History_Detailed__c  = TheText; //Text Area(255)
		thei.Placements_Dates__c  = TheText; //Text Area(255)
		thei.Referral_Reason__c  = TheText; //Text Area(255)
		thei.Religion_Importance_Detailed__c  = TheText; //Text Area(255)
		thei.Self_Views__c  = TheText; //Text Area(255)
		thei.Special_Needs__c  = TheText; //Text Area(255)
		thei.Strengths__c  = TheText; //Text Area(255)
		thei.Whom_do_you_live_with__c  = TheText; //Text Area(255)
		thei.Eye_Color__c  = TheText; //Text(100)
		thei.Hair_Color__c  = TheText; //Text(100)
		thei.Mailing_Zip_Code__c  = TheText; //Text(20)
		thei.Other_Zip_Code__c  = TheText; //Text(20)
		thei.Guardian_Zip__c  = TheText; //Text(20)
		thei.Mailing_Zip_Code__c  = TheText; //Text(20)
		thei.Other_Zip_Code__c  = TheText; //Text(20)
		thei.Identifying_Marks__c  = TheText; //Text(200)
		thei.Place_of_Employment__c  = TheText; //Text(200)
		thei.Guardian_Street__c  = TheText; //Text(255)
		thei.Guardian_City__c  = TheText; //Text(255)
		thei.Academic_Goals__c  = TheText; //Text(255)
		thei.Activity_Invovlement__c  = TheText; //Text(255)
		thei.Additional_Information__c  = TheText; //Text(255)
		thei.Behavioral_Issues_other__c  = TheText; //Text(255)
		thei.Care_Manager__c  = TheText; //Text(255)
		thei.Career_Goal__c  = TheText; //Text(255)
		thei.Clothing_Summary__c  = TheText; //Text(255)
		thei.Community_Suppports__c  = TheText; //Text(255)
		thei.Counseling_When__c  = TheText; //Text(255)
		thei.Counseling_When2__c  = TheText; //Text(255)
		thei.Counselor__c  = TheText; //Text(255)
		thei.Counselor_2__c  = TheText; //Text(255)
		thei.Custodianship__c  = TheText; //Text(255)
		thei.CYF_Case_Worker__c  = TheText; //Text(255)
		thei.DA_Pregnancy__c  = TheText; //Text(255)
		thei.Diagnosis__c  = TheText; //Text(255)
		thei.Dismissal__c  = TheText; //Text(255)
		thei.Family_Supports__c  = TheText; //Text(255)
		thei.Gynecological_Exam__c  = TheText; //Text(255)
		thei.Insurance_Carrier__c  = TheText; //Text(255)
		thei.Issues_Concerns__c  = TheText; //Text(255)
		thei.Juvenile_Probation__c  = TheText; //Text(255)
		thei.Other_Items__c  = TheText; //Text(255)
		thei.Parenting__c  = TheText; //Text(255)
		thei.Physician_Facility__c  = TheText; //Text(255)
		thei.Physician_Name__c  = TheText; //Text(255)
		thei.Pregnancy_Term__c  = TheText; //Text(255)
		thei.Referral_Source_Relationship__c  = TheText; //Text(255)
		thei.Religion__c  = TheText; //Text(255)
		thei.Repeated_Grade__c  = TheText; //Text(255)
		thei.Sexual_Abuse__c  = TheText; //Text(255)
		thei.Subject_Excelling__c  = TheText; //Text(255)
		thei.Subject_Needs_Help__c  = TheText; //Text(255)
		thei.Supervisor__c  = TheText; //Text(255)
		// thei.Talents_Skills__c  = TheText; //Text(255)
		// thei.Voluntary_Service__c  = TheText; //Text(255)
		// thei.Talents_Skills__c  = TheText; //Text(255)
		// thei.Voluntary_Service__c  = TheText; //Text(255)
		//thei.First_Name__c  = TheText; //Text(50)
		//thei.Last_Name__c  = TheText; //Text(50)
		thei.Primary_Guardian_First__c  = TheText; //Text(50)
		thei.Primary_Guardian_Last__c  = TheText; //Text(50)
		thei.Other_Caregiver_First__c  = TheText; //Text(50)
		thei.Other_Caregiver_Last__c  = TheText; //Text(50)
		thei.Emergency_Contact_First__c  = TheText; //Text(50)
		thei.Emergency_Contact_Last__c  = TheText; //Text(50)
		thei.Emergency_Contact_2_First__c  = TheText; //Text(50)
		thei.Emergency_Contact_2_Last__c  = TheText; //Text(50)

		Set<id> tids = new Set<id>();
		tids.add(thei.Id);

		//WSIntakeUpdateTools.updateRelatedRecords(tids);

		Test.startTest();

		update thei;

		WSIntakeUpdateTools.updateRelatedRecords(tids);

		Test.stopTest();
		*/
		
	}
}