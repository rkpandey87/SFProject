global class WSIntakeUpdateFormTools {

public static void updateRelatedRecords(Set<id> iids){
		/*
		List<Intake__c> iList = new List<Intake__c>(); //A List of Intakes
		
		List<Form__c> fList = new List<Form__c>(); //A List of Forms
		List<Form__c> fups = new List<Form__c>(); //A List of Forms to Update
		Map<Id,Form__c> formmap = new Map<Id,Form__c>(); //A Map of Intake Ids to Form
		Set<Id> fids = new Set<Id>(); //A Set of Form Ids

        //FIND THE INTAKES

		SObjectType intaketype = Schema.getGlobalDescribe().get('Intake__c');
        Map<String,Schema.SObjectField> intakeFields = intakeType.getDescribe().fields.getMap(); //A Map of Fields on Payment

		string intakeselect = 'Select ';

        for(string pd : intakeFields.keyset()){
            intakeselect = intakeselect + intakeFields.get(pd) + ', ';
        }
        intakeselect = intakeselect.substring(0,intakeselect.length()-2);
        intakeselect = intakeselect + '';
        intakeselect = intakeselect + ' FROM Intake__c WHERE Id IN: iids';

        try{
            iList = (Intake__c[])Database.query(intakeselect); //The list of Intakes
        }catch(Exception epr){
            system.debug('***********************ERROR Querying Intakes ***********************' + epr.getMessage());
        }

        //Populate the ID Sets for Contact, Form and Case

        for(Intake__c ii : iList){

        	fids.add(ii.Source_Registration_Form__c);
        }

        //FIND THE FORMS

		SObjectType formtype = Schema.getGlobalDescribe().get('Form__c');
        Map<String,Schema.SObjectField> formFields = formType.getDescribe().fields.getMap(); //A Map of Fields on Payment

		string formselect = 'Select ';

        for(string cf : formFields.keyset()){
            formselect = formselect + formFields.get(cf) + ', ';
        }
        formselect = formselect.substring(0,formselect.length()-2);
        formselect = formselect + '';
        formselect = formselect + ' FROM Form__c WHERE Id IN: fids';

        try{
            fList = (Form__c[])Database.query(formselect); //The list of Forms
        }catch(Exception ef){
            system.debug('***********************ERROR Querying Forms ***********************' + ef.getMessage());
        }

        if(!fList.isEmpty()){

        	for(Form__c tf : fList){

        		formmap.put(tf.Source_Intake__c,tf);
        	}
        }

        //Compare the Intake to Form and Update Each if Necessary

        for(Intake__c i : iList){

	        Boolean UpdateF = FALSE; //Update the Form

	        //Compare Form f to Intake i

	        if(formmap.get(i.id) != NULL){

	        Form__c f = formmap.get(i.id);

	        if(f.YDS_or_CM_c__c != i.YDS_or_CM_c__c){f.YDS_or_CM_c__c = i.YDS_or_CM_c__c; UpdateF = TRUE;}
	        if(f.OwnerId != i.OwnerId){f.OwnerId = i.OwnerId; UpdateF = TRUE;}

			if(f.Referral_Source_Org__c != i.Referral_Source_Org__c  ){f.Referral_Source_Org__c = i.Referral_Source_Org__c  ;UpdateF = TRUE;}
			if(f.School__c != i.School__c  ){f.School__c = i.School__c  ;UpdateF = TRUE;}
			if(f.Caregiver_Parent__c != i.Caregiver_Parent__c  ){f.Caregiver_Parent__c = i.Caregiver_Parent__c  ;UpdateF = TRUE;}
			if(f.Client__c != i.Client__c  ){f.Client__c = i.Client__c  ;UpdateF = TRUE;}
			if(f.Referral_Source__c != i.Referral_Source__c  ){f.Referral_Source__c = i.Referral_Source__c  ;UpdateF = TRUE;}
			if(f.Neighborhood__c != i.Neighborhood__c  ){f.Neighborhood__c = i.Neighborhood__c  ;UpdateF = TRUE;}
			if(f.Source_Intake__c != i.Id ){f.Source_Intake__c = i.Id ;UpdateF = TRUE;}
			if(f.Case__c != i.Case__c ){f.Case__c = i.Case__c ;UpdateF = TRUE;}

			if(f.Youth_Development_Specialist__c != i.Youth_Development_Specialist__c  ){f.Youth_Development_Specialist__c = i.Youth_Development_Specialist__c  ;UpdateF = TRUE;}

			if(f.Acne__c != i.Acne__c  ){f.Acne__c = i.Acne__c  ;UpdateF = TRUE;}
			if(f.Alt_Transportation__c != i.Alt_Transportation__c  ){f.Alt_Transportation__c = i.Alt_Transportation__c  ;UpdateF = TRUE;}
			if(f.Awake_Alert__c != i.Awake_Alert__c  ){f.Awake_Alert__c = i.Awake_Alert__c  ;UpdateF = TRUE;}
			if(f.Behavior_Problems__c != i.Behavior_Problems__c  ){f.Behavior_Problems__c = i.Behavior_Problems__c  ;UpdateF = TRUE;}
			if(f.Birthmarks__c != i.Birthmarks__c  ){f.Birthmarks__c = i.Birthmarks__c  ;UpdateF = TRUE;}
			if(f.Bruises__c != i.Bruises__c  ){f.Bruises__c = i.Bruises__c  ;UpdateF = TRUE;}
			if(f.Bullying_Perpetrator__c != i.Bullying_Perpetrator__c  ){f.Bullying_Perpetrator__c = i.Bullying_Perpetrator__c  ;UpdateF = TRUE;}
			if(f.Bullying_Victim__c != i.Bullying_Victim__c  ){f.Bullying_Victim__c = i.Bullying_Victim__c  ;UpdateF = TRUE;}
			if(f.Campus_Visit__c != i.Campus_Visit__c  ){f.Campus_Visit__c = i.Campus_Visit__c  ;UpdateF = TRUE;}
			if(f.Career_Fair__c != i.Career_Fair__c  ){f.Career_Fair__c = i.Career_Fair__c  ;UpdateF = TRUE;}
			if(f.Chores__c != i.Chores__c  ){f.Chores__c = i.Chores__c  ;UpdateF = TRUE;}
			if(f.Close_Friends__c != i.Close_Friends__c  ){f.Close_Friends__c = i.Close_Friends__c  ;UpdateF = TRUE;}
			if(f.College_Board__c != i.College_Board__c  ){f.College_Board__c = i.College_Board__c  ;UpdateF = TRUE;}
			if(f.Common_Application__c != i.Common_Application__c  ){f.Common_Application__c = i.Common_Application__c  ;UpdateF = TRUE;}
			if(f.Community_Activities__c != i.Community_Activities__c  ){f.Community_Activities__c = i.Community_Activities__c  ;UpdateF = TRUE;}
			if(f.Community_Collaborative__c != i.Community_Collaborative__c  ){f.Community_Collaborative__c = i.Community_Collaborative__c  ;UpdateF = TRUE;}
			if(f.Community_Service__c != i.Community_Service__c  ){f.Community_Service__c = i.Community_Service__c  ;UpdateF = TRUE;}
			if(f.Confidentiality_Statement__c != i.Confidentiality_Statement__c  ){f.Confidentiality_Statement__c = i.Confidentiality_Statement__c  ;UpdateF = TRUE;}
			if(f.Conflicts_wParents__c != i.Conflicts_wParents__c  ){f.Conflicts_wParents__c = i.Conflicts_wParents__c  ;UpdateF = TRUE;}
			if(f.ConsentReturn_Unsupervised__c != i.ConsentReturn_Unsupervised__c  ){f.ConsentReturn_Unsupervised__c = i.ConsentReturn_Unsupervised__c  ;UpdateF = TRUE;}
			if(f.Counseling__c != i.Counseling__c  ){f.Counseling__c = i.Counseling__c  ;UpdateF = TRUE;}
			if(f.Curfew__c != i.Curfew__c  ){f.Curfew__c = i.Curfew__c  ;UpdateF = TRUE;}
			if(f.Current_Schedule_Submittted__c != i.Current_Schedule_Submittted__c  ){f.Current_Schedule_Submittted__c = i.Current_Schedule_Submittted__c  ;UpdateF = TRUE;}
			if(f.CYF_Advocate__c != i.CYF_Advocate__c  ){f.CYF_Advocate__c = i.CYF_Advocate__c  ;UpdateF = TRUE;}
			if(f.December__c != i.December__c  ){f.December__c = i.December__c  ;UpdateF = TRUE;}
			if(f.Deformities__c != i.Deformities__c  ){f.Deformities__c = i.Deformities__c  ;UpdateF = TRUE;}
			if(f.Detention__c != i.Detention__c  ){f.Detention__c = i.Detention__c  ;UpdateF = TRUE;}
			if(f.Disruptive__c != i.Disruptive__c  ){f.Disruptive__c = i.Disruptive__c  ;UpdateF = TRUE;}
			if(f.Dressed_Appropriate__c != i.Dressed_Appropriate__c  ){f.Dressed_Appropriate__c = i.Dressed_Appropriate__c  ;UpdateF = TRUE;}
			if(f.Drug_Withdrawal__c != i.Drug_Withdrawal__c  ){f.Drug_Withdrawal__c = i.Drug_Withdrawal__c  ;UpdateF = TRUE;}
			if(f.Expectations__c != i.Expectations__c  ){f.Expectations__c = i.Expectations__c  ;UpdateF = TRUE;}
			if(f.Expulsions__c != i.Expulsions__c  ){f.Expulsions__c = i.Expulsions__c  ;UpdateF = TRUE;}
			if(f.Family_Handbook_Acceptance__c != i.Family_Handbook_Acceptance__c  ){f.Family_Handbook_Acceptance__c = i.Family_Handbook_Acceptance__c  ;UpdateF = TRUE;}
			if(f.February__c != i.February__c  ){f.February__c = i.February__c  ;UpdateF = TRUE;}
			if(f.Good_Hygiene__c != i.Good_Hygiene__c  ){f.Good_Hygiene__c = i.Good_Hygiene__c  ;UpdateF = TRUE;}
			if(f.Graduated__c != i.Graduated__c  ){f.Graduated__c = i.Graduated__c  ;UpdateF = TRUE;}
			if(f.Group_Expectations__c != i.Group_Expectations__c  ){f.Group_Expectations__c = i.Group_Expectations__c  ;UpdateF = TRUE;}
			if(f.Group_Rules_Agreement__c != i.Group_Rules_Agreement__c  ){f.Group_Rules_Agreement__c = i.Group_Rules_Agreement__c  ;UpdateF = TRUE;}
			if(f.Hyperactive__c != i.Hyperactive__c  ){f.Hyperactive__c = i.Hyperactive__c  ;UpdateF = TRUE;}
			if(f.IEP__c != i.IEP__c  ){f.IEP__c = i.IEP__c  ;UpdateF = TRUE;}
			if(f.IL_Worker__c != i.IL_Worker__c  ){f.IL_Worker__c = i.IL_Worker__c  ;UpdateF = TRUE;}
			if(f.In_School__c != i.In_School__c  ){f.In_School__c = i.In_School__c  ;UpdateF = TRUE;}
			if(f.Infestations__c != i.Infestations__c  ){f.Infestations__c = i.Infestations__c  ;UpdateF = TRUE;}
			if(f.Initial__c != i.Initial__c  ){f.Initial__c = i.Initial__c  ;UpdateF = TRUE;}
			if(f.Interests_Specialty_Group__c != i.Interests_Specialty_Group__c  ){f.Interests_Specialty_Group__c = i.Interests_Specialty_Group__c  ;UpdateF = TRUE;}
			if(f.Interview_Skills__c != i.Interview_Skills__c  ){f.Interview_Skills__c = i.Interview_Skills__c  ;UpdateF = TRUE;}
			if(f.Inventory_35__c != i.Inventory_35__c  ){f.Inventory_35__c = i.Inventory_35__c  ;UpdateF = TRUE;}
			if(f.Inventory_68__c != i.Inventory_68__c  ){f.Inventory_68__c = i.Inventory_68__c  ;UpdateF = TRUE;}
			if(f.Inventory_912__c != i.Inventory_912__c  ){f.Inventory_912__c = i.Inventory_912__c  ;UpdateF = TRUE;}
			if(f.Irritability__c != i.Irritability__c  ){f.Irritability__c = i.Irritability__c  ;UpdateF = TRUE;}
			if(f.Issuesw_Parents_Friends__c != i.Issuesw_Parents_Friends__c  ){f.Issuesw_Parents_Friends__c = i.Issuesw_Parents_Friends__c  ;UpdateF = TRUE;}
			if(f.Issuesw_Siblings__c != i.Issuesw_Siblings__c  ){f.Issuesw_Siblings__c = i.Issuesw_Siblings__c  ;UpdateF = TRUE;}
			if(f.JA_Biztown__c != i.JA_Biztown__c  ){f.JA_Biztown__c = i.JA_Biztown__c  ;UpdateF = TRUE;}
			if(f.January__c != i.January__c  ){f.January__c = i.January__c  ;UpdateF = TRUE;}
			if(f.Job_Application__c != i.Job_Application__c  ){f.Job_Application__c = i.Job_Application__c  ;UpdateF = TRUE;}
			if(f.Learning_Disability__c != i.Learning_Disability__c  ){f.Learning_Disability__c = i.Learning_Disability__c  ;UpdateF = TRUE;}
			if(f.Lesions__c != i.Lesions__c  ){f.Lesions__c = i.Lesions__c  ;UpdateF = TRUE;}
			if(f.March__c != i.March__c  ){f.March__c = i.March__c  ;UpdateF = TRUE;}
			if(f.Medical_Collaborative__c != i.Medical_Collaborative__c  ){f.Medical_Collaborative__c = i.Medical_Collaborative__c  ;UpdateF = TRUE;}
			if(f.Medical_Release__c != i.Medical_Release__c  ){f.Medical_Release__c = i.Medical_Release__c  ;UpdateF = TRUE;}
			if(f.Mentor_Program__c != i.Mentor_Program__c  ){f.Mentor_Program__c = i.Mentor_Program__c  ;UpdateF = TRUE;}
			if(f.Movements_Coordinated__c != i.Movements_Coordinated__c  ){f.Movements_Coordinated__c = i.Movements_Coordinated__c  ;UpdateF = TRUE;}
			if(f.Navience_Account__c != i.Navience_Account__c  ){f.Navience_Account__c = i.Navience_Account__c  ;UpdateF = TRUE;}
			if(f.Needlemarks__c != i.Needlemarks__c  ){f.Needlemarks__c = i.Needlemarks__c  ;UpdateF = TRUE;}
			if(f.No_Problems__c != i.No_Problems__c  ){f.No_Problems__c = i.No_Problems__c  ;UpdateF = TRUE;}
			if(f.November__c != i.November__c  ){f.November__c = i.November__c  ;UpdateF = TRUE;}
			if(f.October__c != i.October__c  ){f.October__c = i.October__c  ;UpdateF = TRUE;}
			if(f.Out_of_C_S__c != i.Out_of_C_S__c  ){f.Out_of_C_S__c = i.Out_of_C_S__c  ;UpdateF = TRUE;}
			if(f.Permission_to_Photogragh__c != i.Permission_to_Photogragh__c  ){f.Permission_to_Photogragh__c = i.Permission_to_Photogragh__c  ;UpdateF = TRUE;}
			if(f.Personal_Wellness__c != i.Personal_Wellness__c  ){f.Personal_Wellness__c = i.Personal_Wellness__c  ;UpdateF = TRUE;}
			if(f.Piercings__c != i.Piercings__c  ){f.Piercings__c = i.Piercings__c  ;UpdateF = TRUE;}
			if(f.Pregnant_Parenting__c != i.Pregnant_Parenting__c  ){f.Pregnant_Parenting__c = i.Pregnant_Parenting__c  ;UpdateF = TRUE;}
			if(f.PreGroup_Assessment__c != i.PreGroup_Assessment__c  ){f.PreGroup_Assessment__c = i.PreGroup_Assessment__c  ;UpdateF = TRUE;}
			if(f.Problems_at_Work__c != i.Problems_at_Work__c  ){f.Problems_at_Work__c = i.Problems_at_Work__c  ;UpdateF = TRUE;}
			if(f.Problems_in_School__c != i.Problems_in_School__c  ){f.Problems_in_School__c = i.Problems_in_School__c  ;UpdateF = TRUE;}
			if(f.Problems_wGuardian__c != i.Problems_wGuardian__c  ){f.Problems_wGuardian__c = i.Problems_wGuardian__c  ;UpdateF = TRUE;}
			if(f.PSAT_ACT__c != i.PSAT_ACT__c  ){f.PSAT_ACT__c = i.PSAT_ACT__c  ;UpdateF = TRUE;}
			if(f.Quiet__c != i.Quiet__c  ){f.Quiet__c = i.Quiet__c  ;UpdateF = TRUE;}
			if(f.Rash__c != i.Rash__c  ){f.Rash__c = i.Rash__c  ;UpdateF = TRUE;}
			if(f.Received_Rewards__c != i.Received_Rewards__c  ){f.Received_Rewards__c = i.Received_Rewards__c  ;UpdateF = TRUE;}
			if(f.Recommendation_Letter__c != i.Recommendation_Letter__c  ){f.Recommendation_Letter__c = i.Recommendation_Letter__c  ;UpdateF = TRUE;}
			if(f.Relationship__c != i.Relationship__c  ){f.Relationship__c = i.Relationship__c  ;UpdateF = TRUE;}
			if(f.Release_Info_Consent__c != i.Release_Info_Consent__c  ){f.Release_Info_Consent__c = i.Release_Info_Consent__c  ;UpdateF = TRUE;}
			if(f.Religion_Importance__c != i.Religion_Importance__c  ){f.Religion_Importance__c = i.Religion_Importance__c  ;UpdateF = TRUE;}
			if(f.Resume__c != i.Resume__c  ){f.Resume__c = i.Resume__c  ;UpdateF = TRUE;}
			if(f.Rewards_Points_Policy__c != i.Rewards_Points_Policy__c  ){f.Rewards_Points_Policy__c = i.Rewards_Points_Policy__c  ;UpdateF = TRUE;}
			if(f.Runs_Away__c != i.Runs_Away__c  ){f.Runs_Away__c = i.Runs_Away__c  ;UpdateF = TRUE;}
			if(f.Sad__c != i.Sad__c  ){f.Sad__c = i.Sad__c  ;UpdateF = TRUE;}
			if(f.SAT_Prep_Course__c != i.SAT_Prep_Course__c  ){f.SAT_Prep_Course__c = i.SAT_Prep_Course__c  ;UpdateF = TRUE;}
			if(f.Scars__c != i.Scars__c  ){f.Scars__c = i.Scars__c  ;UpdateF = TRUE;}
			if(f.Secondary__c != i.Secondary__c  ){f.Secondary__c = i.Secondary__c  ;UpdateF = TRUE;}
			if(f.Securing_Housing__c != i.Securing_Housing__c  ){f.Securing_Housing__c = i.Securing_Housing__c  ;UpdateF = TRUE;}
			if(f.Self_Advocacy__c != i.Self_Advocacy__c  ){f.Self_Advocacy__c = i.Self_Advocacy__c  ;UpdateF = TRUE;}
			if(f.Serious_Relationship__c != i.Serious_Relationship__c  ){f.Serious_Relationship__c = i.Serious_Relationship__c  ;UpdateF = TRUE;}
			if(f.Speech_Difficulties__c != i.Speech_Difficulties__c  ){f.Speech_Difficulties__c = i.Speech_Difficulties__c  ;UpdateF = TRUE;}
			// if(f.Suspension__c != i.Suspension__c  ){f.Suspension__c = i.Suspension__c  ;UpdateF = TRUE;}
			// if(f.Tattoos__c != i.Tattoos__c  ){f.Tattoos__c = i.Tattoos__c  ;UpdateF = TRUE;}
			// if(f.Teacher_Peer_Interaction__c != i.Teacher_Peer_Interaction__c  ){f.Teacher_Peer_Interaction__c = i.Teacher_Peer_Interaction__c  ;UpdateF = TRUE;}
			if(f.Television_R_V__c != i.Television_R_V__c  ){f.Television_R_V__c = i.Television_R_V__c  ;UpdateF = TRUE;}
			if(f.Transportation_Consent__c != i.Transportation_Consent__c  ){f.Transportation_Consent__c = i.Transportation_Consent__c  ;UpdateF = TRUE;}
			// if(f.Traumatic_Marks__c != i.Traumatic_Marks__c  ){f.Traumatic_Marks__c = i.Traumatic_Marks__c  ;UpdateF = TRUE;}
			// if(f.Truancy__c != i.Truancy__c  ){f.Truancy__c = i.Truancy__c  ;UpdateF = TRUE;}
			// if(f.Utilizing_Community__c != i.Utilizing_Community__c  ){f.Utilizing_Community__c = i.Utilizing_Community__c  ;UpdateF = TRUE;}
			// if(f.Works__c != i.Works__c  ){f.Works__c = i.Works__c  ;UpdateF = TRUE;}
			// if(f.X10th_Transcript_Review__c != i.X10th_Transcript_Review__c  ){f.X10th_Transcript_Review__c = i.X10th_Transcript_Review__c  ;UpdateF = TRUE;}
			// if(f.X11th_Transcript_Review__c != i.X11th_Transcript_Review__c  ){f.X11th_Transcript_Review__c = i.X11th_Transcript_Review__c  ;UpdateF = TRUE;}
			// if(f.Yellowish_Tent__c != i.Yellowish_Tent__c  ){f.Yellowish_Tent__c = i.Yellowish_Tent__c  ;UpdateF = TRUE;}

			if(f.Casey_Assessment__c != i.Casey_Assessment__c  ){f.Casey_Assessment__c = i.Casey_Assessment__c  ;UpdateF = TRUE;}
			if(f.Clothing_Inventory__c != i.Clothing_Inventory__c  ){f.Clothing_Inventory__c = i.Clothing_Inventory__c  ;UpdateF = TRUE;}
			if(f.D_O_B__c != i.D_O_B__c  ){f.D_O_B__c = i.D_O_B__c  ;UpdateF = TRUE;}
			if(f.Dental_Visit__c != i.Dental_Visit__c  ){f.Dental_Visit__c = i.Dental_Visit__c  ;UpdateF = TRUE;}
			if(f.Emergency_Information__c != i.Emergency_Information__c  ){f.Emergency_Information__c = i.Emergency_Information__c  ;UpdateF = TRUE;}
			if(f.FACE_Sheet__c != i.FACE_Sheet__c  ){f.FACE_Sheet__c = i.FACE_Sheet__c  ;UpdateF = TRUE;}
			if(f.FERPA__c != i.FERPA__c  ){f.FERPA__c = i.FERPA__c  ;UpdateF = TRUE;}
			if(f.Financial_Literacy__c != i.Financial_Literacy__c  ){f.Financial_Literacy__c = i.Financial_Literacy__c  ;UpdateF = TRUE;}
			if(f.Form_Completion_Date__c != i.Form_Completion_Date__c  ){f.Form_Completion_Date__c = i.Form_Completion_Date__c  ;UpdateF = TRUE;}
			if(f.Graduation_Date__c != i.Graduation_Date__c  ){f.Graduation_Date__c = i.Graduation_Date__c  ;UpdateF = TRUE;}
			if(f.IEP_Review__c != i.IEP_Review__c  ){f.IEP_Review__c = i.IEP_Review__c  ;UpdateF = TRUE;}
			if(f.Intake_Checklist__c != i.Intake_Checklist__c  ){f.Intake_Checklist__c = i.Intake_Checklist__c  ;UpdateF = TRUE;}
			if(f.Job_Readiness__c != i.Job_Readiness__c  ){f.Job_Readiness__c = i.Job_Readiness__c  ;UpdateF = TRUE;}
			if(f.Job_Shadowing__c != i.Job_Shadowing__c  ){f.Job_Shadowing__c = i.Job_Shadowing__c  ;UpdateF = TRUE;}
			if(f.Keys_Work__c != i.Keys_Work__c  ){f.Keys_Work__c = i.Keys_Work__c  ;UpdateF = TRUE;}
			if(f.Last_Physical__c != i.Last_Physical__c  ){f.Last_Physical__c = i.Last_Physical__c  ;UpdateF = TRUE;}
			if(f.Placement__c != i.Placement__c  ){f.Placement__c = i.Placement__c  ;UpdateF = TRUE;}
			if(f.Recent_IEP__c != i.Recent_IEP__c  ){f.Recent_IEP__c = i.Recent_IEP__c  ;UpdateF = TRUE;}
			if(f.Screening_Completed__c != i.Screening_Completed__c  ){f.Screening_Completed__c = i.Screening_Completed__c  ;UpdateF = TRUE;}
			// if(f.Transition_Activities__c != i.Transition_Activities__c  ){f.Transition_Activities__c = i.Transition_Activities__c  ;UpdateF = TRUE;}
			// if(f.Transition_Activity__c != i.Transition_Activity__c  ){f.Transition_Activity__c = i.Transition_Activity__c  ;UpdateF = TRUE;}

			if(f.Referral_Received__c != i.Referral_Received__c  ){f.Referral_Received__c = i.Referral_Received__c  ;UpdateF = TRUE;}

			if(f.About_You__c != i.About_You__c  ){f.About_You__c = i.About_You__c  ;UpdateF = TRUE;}
			if(f.Guardian_Issues_Detailed__c != i.Guardian_Issues_Detailed__c  ){f.Guardian_Issues_Detailed__c = i.Guardian_Issues_Detailed__c  ;UpdateF = TRUE;}
			if(f.Health_Safety__c != i.Health_Safety__c  ){f.Health_Safety__c = i.Health_Safety__c  ;UpdateF = TRUE;}
			if(f.Important_to_You__c != i.Important_to_You__c  ){f.Important_to_You__c = i.Important_to_You__c  ;UpdateF = TRUE;}
			if(f.Interviewer_Assessment__c != i.Interviewer_Assessment__c  ){f.Interviewer_Assessment__c = i.Interviewer_Assessment__c  ;UpdateF = TRUE;}
			if(f.Issues_Detail_other__c != i.Issues_Detail_other__c  ){f.Issues_Detail_other__c = i.Issues_Detail_other__c  ;UpdateF = TRUE;}
			if(f.Makes_You_Happy__c != i.Makes_You_Happy__c  ){f.Makes_You_Happy__c = i.Makes_You_Happy__c  ;UpdateF = TRUE;}
			if(f.Medications__c != i.Medications__c  ){f.Medications__c = i.Medications__c  ;UpdateF = TRUE;}
			if(f.Notes__c != i.Notes__c  ){f.Notes__c = i.Notes__c  ;UpdateF = TRUE;}
			if(f.Operations_Injuries__c != i.Operations_Injuries__c  ){f.Operations_Injuries__c = i.Operations_Injuries__c  ;UpdateF = TRUE;}
			if(f.Parent_Guardians_Relationship__c != i.Parent_Guardians_Relationship__c  ){f.Parent_Guardians_Relationship__c = i.Parent_Guardians_Relationship__c  ;UpdateF = TRUE;}
			if(f.Physical_Mental_History__c != i.Physical_Mental_History__c  ){f.Physical_Mental_History__c = i.Physical_Mental_History__c  ;UpdateF = TRUE;}
			if(f.Physicians_Advice__c != i.Physicians_Advice__c  ){f.Physicians_Advice__c = i.Physicians_Advice__c  ;UpdateF = TRUE;}
			if(f.School_Problems_Detailed__c != i.School_Problems_Detailed__c  ){f.School_Problems_Detailed__c = i.School_Problems_Detailed__c  ;UpdateF = TRUE;}
			if(f.Sibling_Issues_Detailed__c != i.Sibling_Issues_Detailed__c  ){f.Sibling_Issues_Detailed__c = i.Sibling_Issues_Detailed__c  ;UpdateF = TRUE;}
			if(f.Why_are_you_here__c != i.Why_are_you_here__c  ){f.Why_are_you_here__c = i.Why_are_you_here__c  ;UpdateF = TRUE;}
			// if(f.Work_Issues__c != i.Work_Issues__c  ){f.Work_Issues__c = i.Work_Issues__c  ;UpdateF = TRUE;}
			if(f.Worries_Upsets_You__c != i.Worries_Upsets_You__c  ){f.Worries_Upsets_You__c = i.Worries_Upsets_You__c  ;UpdateF = TRUE;}

			if(f.Caregivers_Disciplinary_Practices__c != i.Caregivers_Disciplinary_Practices__c  ){f.Caregivers_Disciplinary_Practices__c = i.Caregivers_Disciplinary_Practices__c  ;UpdateF = TRUE;}
			if(f.Caregivers_Expectations__c != i.Caregivers_Expectations__c  ){f.Caregivers_Expectations__c = i.Caregivers_Expectations__c  ;UpdateF = TRUE;}
			if(f.Caregivers_Parents_DA__c != i.Caregivers_Parents_DA__c  ){f.Caregivers_Parents_DA__c = i.Caregivers_Parents_DA__c  ;UpdateF = TRUE;}
			if(f.Caregivers_Parents_MH__c != i.Caregivers_Parents_MH__c  ){f.Caregivers_Parents_MH__c = i.Caregivers_Parents_MH__c  ;UpdateF = TRUE;}
			if(f.Caregivers_Parents_PH__c != i.Caregivers_Parents_PH__c  ){f.Caregivers_Parents_PH__c = i.Caregivers_Parents_PH__c  ;UpdateF = TRUE;}
			if(f.Child_Behavior__c != i.Child_Behavior__c  ){f.Child_Behavior__c = i.Child_Behavior__c  ;UpdateF = TRUE;}
			if(f.Child_Caregivers_Parents_Relationship__c != i.Child_Caregivers_Parents_Relationship__c  ){f.Child_Caregivers_Parents_Relationship__c = i.Child_Caregivers_Parents_Relationship__c  ;UpdateF = TRUE;}
			if(f.Child_Drug_Alcohol__c != i.Child_Drug_Alcohol__c  ){f.Child_Drug_Alcohol__c = i.Child_Drug_Alcohol__c  ;UpdateF = TRUE;}
			if(f.Child_MH__c != i.Child_MH__c  ){f.Child_MH__c = i.Child_MH__c  ;UpdateF = TRUE;}
			if(f.Child_Peer_Relationship__c != i.Child_Peer_Relationship__c  ){f.Child_Peer_Relationship__c = i.Child_Peer_Relationship__c  ;UpdateF = TRUE;}
			if(f.Child_School_Performance__c != i.Child_School_Performance__c  ){f.Child_School_Performance__c = i.Child_School_Performance__c  ;UpdateF = TRUE;}
			if(f.Detentions__c != i.Detentions__c  ){f.Detentions__c = i.Detentions__c  ;UpdateF = TRUE;}
			if(f.Environment_Housing__c != i.Environment_Housing__c  ){f.Environment_Housing__c = i.Environment_Housing__c  ;UpdateF = TRUE;}
			if(f.Environment_Income_Employment__c != i.Environment_Income_Employment__c  ){f.Environment_Income_Employment__c = i.Environment_Income_Employment__c  ;UpdateF = TRUE;}
			if(f.Family_Caregivers_Parents_Relationship__c != i.Family_Caregivers_Parents_Relationship__c  ){f.Family_Caregivers_Parents_Relationship__c = i.Family_Caregivers_Parents_Relationship__c  ;UpdateF = TRUE;}
			if(f.Family_Community_Support__c != i.Family_Community_Support__c  ){f.Family_Community_Support__c = i.Family_Community_Support__c  ;UpdateF = TRUE;}
			if(f.Family_Interactions__c != i.Family_Interactions__c  ){f.Family_Interactions__c = i.Family_Interactions__c  ;UpdateF = TRUE;}
			if(f.Family_Safety__c != i.Family_Safety__c  ){f.Family_Safety__c = i.Family_Safety__c  ;UpdateF = TRUE;}
			if(f.Grade__c != i.Grade__c  ){f.Grade__c = i.Grade__c  ;UpdateF = TRUE;}
			if(f.Hats__c != i.Hats__c  ){f.Hats__c = i.Hats__c  ;UpdateF = TRUE;}
			if(f.Hearing_Left__c != i.Hearing_Left__c  ){f.Hearing_Left__c = i.Hearing_Left__c  ;UpdateF = TRUE;}
			if(f.Hearing_Right__c != i.Hearing_Right__c  ){f.Hearing_Right__c = i.Hearing_Right__c  ;UpdateF = TRUE;}
			if(f.Missed_School__c != i.Missed_School__c  ){f.Missed_School__c = i.Missed_School__c  ;UpdateF = TRUE;}
			if(f.Pajamas__c != i.Pajamas__c  ){f.Pajamas__c = i.Pajamas__c  ;UpdateF = TRUE;}
			if(f.Pants__c != i.Pants__c  ){f.Pants__c = i.Pants__c  ;UpdateF = TRUE;}
			if(f.Shirts__c != i.Shirts__c  ){f.Shirts__c = i.Shirts__c  ;UpdateF = TRUE;}
			if(f.Shoes__c != i.Shoes__c  ){f.Shoes__c = i.Shoes__c  ;UpdateF = TRUE;}
			if(f.Socks__c != i.Socks__c  ){f.Socks__c = i.Socks__c  ;UpdateF = TRUE;}
			// if(f.Suspensions__c != i.Suspensions__c  ){f.Suspensions__c = i.Suspensions__c  ;UpdateF = TRUE;}
			// if(f.Undergarments__c != i.Undergarments__c  ){f.Undergarments__c = i.Undergarments__c  ;UpdateF = TRUE;}
			// if(f.Vision_Left__c != i.Vision_Left__c  ){f.Vision_Left__c = i.Vision_Left__c  ;UpdateF = TRUE;}
			// if(f.Vision_Right__c != i.Vision_Right__c  ){f.Vision_Right__c = i.Vision_Right__c  ;UpdateF = TRUE;}
			// if(f.Winter_Boots__c != i.Winter_Boots__c  ){f.Winter_Boots__c = i.Winter_Boots__c  ;UpdateF = TRUE;}
			// if(f.Winter_Coats__c != i.Winter_Coats__c  ){f.Winter_Coats__c = i.Winter_Coats__c  ;UpdateF = TRUE;}
			if(f.Insurance_Number__c != i.Insurance_Number__c  ){f.Insurance_Number__c = i.Insurance_Number__c  ;UpdateF = TRUE;}
			if(f.Medical_Recipient_Number__c != i.Medical_Recipient_Number__c  ){f.Medical_Recipient_Number__c = i.Medical_Recipient_Number__c  ;UpdateF = TRUE;}

			if(f.Case_Worker__c != i.Case_Worker__c  ){f.Case_Worker__c = i.Case_Worker__c  ;UpdateF = TRUE;}
			if(f.Physician_Phone__c != i.Physician_Phone__c  ){f.Physician_Phone__c = i.Physician_Phone__c  ;UpdateF = TRUE;}
			if(f.Probation_Officers__c != i.Probation_Officers__c  ){f.Probation_Officers__c = i.Probation_Officers__c  ;UpdateF = TRUE;}

			if(f.Abstraction__c != i.Abstraction__c  ){f.Abstraction__c = i.Abstraction__c  ;UpdateF = TRUE;}
			if(f.Affect__c != i.Affect__c  ){f.Affect__c = i.Affect__c  ;UpdateF = TRUE;}
			if(f.Attendance__c != i.Attendance__c  ){f.Attendance__c = i.Attendance__c  ;UpdateF = TRUE;}
			if(f.Attention__c != i.Attention__c  ){f.Attention__c = i.Attention__c  ;UpdateF = TRUE;}
			if(f.Attitude__c != i.Attitude__c  ){f.Attitude__c = i.Attitude__c  ;UpdateF = TRUE;}
			if(f.Boundaries__c != i.Boundaries__c  ){f.Boundaries__c = i.Boundaries__c  ;UpdateF = TRUE;}
			if(f.Clothing__c != i.Clothing__c  ){f.Clothing__c = i.Clothing__c  ;UpdateF = TRUE;}
			if(f.Community_Resources__c != i.Community_Resources__c  ){f.Community_Resources__c = i.Community_Resources__c  ;UpdateF = TRUE;}
			if(f.Concentration__c != i.Concentration__c  ){f.Concentration__c = i.Concentration__c  ;UpdateF = TRUE;}
			if(f.Coping_Ability__c != i.Coping_Ability__c  ){f.Coping_Ability__c = i.Coping_Ability__c  ;UpdateF = TRUE;}
			if(f.Cosmetic_use__c != i.Cosmetic_use__c  ){f.Cosmetic_use__c = i.Cosmetic_use__c  ;UpdateF = TRUE;}
			if(f.Course_Description__c != i.Course_Description__c  ){f.Course_Description__c = i.Course_Description__c  ;UpdateF = TRUE;}
			if(f.Current_DA_Concerns__c != i.Current_DA_Concerns__c  ){f.Current_DA_Concerns__c = i.Current_DA_Concerns__c  ;UpdateF = TRUE;}
			if(f.Current_Living_Situation__c != i.Current_Living_Situation__c  ){f.Current_Living_Situation__c = i.Current_Living_Situation__c  ;UpdateF = TRUE;}
			if(f.DA_History__c != i.DA_History__c  ){f.DA_History__c = i.DA_History__c  ;UpdateF = TRUE;}
			if(f.Decision_Making__c != i.Decision_Making__c  ){f.Decision_Making__c = i.Decision_Making__c  ;UpdateF = TRUE;}
			if(f.Defective_Memory__c != i.Defective_Memory__c  ){f.Defective_Memory__c = i.Defective_Memory__c  ;UpdateF = TRUE;}
			if(f.Developmental_Delay__c != i.Developmental_Delay__c  ){f.Developmental_Delay__c = i.Developmental_Delay__c  ;UpdateF = TRUE;}
			if(f.Education_Program__c != i.Education_Program__c  ){f.Education_Program__c = i.Education_Program__c  ;UpdateF = TRUE;}
			if(f.Education_Type__c != i.Education_Type__c  ){f.Education_Type__c = i.Education_Type__c  ;UpdateF = TRUE;}
			if(f.Educational_Support__c != i.Educational_Support__c  ){f.Educational_Support__c = i.Educational_Support__c  ;UpdateF = TRUE;}
			if(f.Eye_Contact__c != i.Eye_Contact__c  ){f.Eye_Contact__c = i.Eye_Contact__c  ;UpdateF = TRUE;}
			if(f.Facial_Expresion__c != i.Facial_Expresion__c  ){f.Facial_Expresion__c = i.Facial_Expresion__c  ;UpdateF = TRUE;}
			if(f.Family_Discussion__c != i.Family_Discussion__c  ){f.Family_Discussion__c = i.Family_Discussion__c  ;UpdateF = TRUE;}
			if(f.Fund_Knowledge__c != i.Fund_Knowledge__c  ){f.Fund_Knowledge__c = i.Fund_Knowledge__c  ;UpdateF = TRUE;}
			if(f.GPA__c != i.GPA__c  ){f.GPA__c = i.GPA__c  ;UpdateF = TRUE;}
			if(f.Grade_History__c != i.Grade_History__c  ){f.Grade_History__c = i.Grade_History__c  ;UpdateF = TRUE;}
			if(f.Graduation_Type__c != i.Graduation_Type__c  ){f.Graduation_Type__c = i.Graduation_Type__c  ;UpdateF = TRUE;}
			if(f.Grooming__c != i.Grooming__c  ){f.Grooming__c = i.Grooming__c  ;UpdateF = TRUE;}
			if(f.Hallucination__c != i.Hallucination__c  ){f.Hallucination__c = i.Hallucination__c  ;UpdateF = TRUE;}
			if(f.History_Domestic_Violence__c != i.History_Domestic_Violence__c  ){f.History_Domestic_Violence__c = i.History_Domestic_Violence__c  ;UpdateF = TRUE;}
			if(f.History_of_Abuse__c != i.History_of_Abuse__c  ){f.History_of_Abuse__c = i.History_of_Abuse__c  ;UpdateF = TRUE;}
			if(f.Household_Rules__c != i.Household_Rules__c  ){f.Household_Rules__c = i.Household_Rules__c  ;UpdateF = TRUE;}
			if(f.Housing__c != i.Housing__c  ){f.Housing__c = i.Housing__c  ;UpdateF = TRUE;}
			if(f.Income_Source__c != i.Income_Source__c  ){f.Income_Source__c = i.Income_Source__c  ;UpdateF = TRUE;}
			if(f.Insight__c != i.Insight__c  ){f.Insight__c = i.Insight__c  ;UpdateF = TRUE;}
			if(f.Intelligence__c != i.Intelligence__c  ){f.Intelligence__c = i.Intelligence__c  ;UpdateF = TRUE;}
			if(f.Judgment__c != i.Judgment__c  ){f.Judgment__c = i.Judgment__c  ;UpdateF = TRUE;}
			if(f.Math__c != i.Math__c  ){f.Math__c = i.Math__c  ;UpdateF = TRUE;}
			if(f.Medication_Compliance__c != i.Medication_Compliance__c  ){f.Medication_Compliance__c = i.Medication_Compliance__c  ;UpdateF = TRUE;}
			if(f.Mental_Health_History__c != i.Mental_Health_History__c  ){f.Mental_Health_History__c = i.Mental_Health_History__c  ;UpdateF = TRUE;}
			if(f.Mood__c != i.Mood__c  ){f.Mood__c = i.Mood__c  ;UpdateF = TRUE;}
			if(f.Motor_Activity__c != i.Motor_Activity__c  ){f.Motor_Activity__c = i.Motor_Activity__c  ;UpdateF = TRUE;}
			if(f.Organization__c != i.Organization__c  ){f.Organization__c = i.Organization__c  ;UpdateF = TRUE;}
			if(f.Orientation__c != i.Orientation__c  ){f.Orientation__c = i.Orientation__c  ;UpdateF = TRUE;}
			if(f.Permanency_Goal__c != i.Permanency_Goal__c  ){f.Permanency_Goal__c = i.Permanency_Goal__c  ;UpdateF = TRUE;}
			if(f.Posture__c != i.Posture__c  ){f.Posture__c = i.Posture__c  ;UpdateF = TRUE;}
			if(f.Pre_Natal_Issues__c != i.Pre_Natal_Issues__c  ){f.Pre_Natal_Issues__c = i.Pre_Natal_Issues__c  ;UpdateF = TRUE;}
			if(f.Preoccupation__c != i.Preoccupation__c  ){f.Preoccupation__c = i.Preoccupation__c  ;UpdateF = TRUE;}
			if(f.PSSA_Keystone__c != i.PSSA_Keystone__c  ){f.PSSA_Keystone__c = i.PSSA_Keystone__c  ;UpdateF = TRUE;}
			if(f.Race__c != i.Race__c  ){f.Race__c = i.Race__c  ;UpdateF = TRUE;}
			if(f.Reading__c != i.Reading__c  ){f.Reading__c = i.Reading__c  ;UpdateF = TRUE;}
			if(f.Reality_Testing__c != i.Reality_Testing__c  ){f.Reality_Testing__c = i.Reality_Testing__c  ;UpdateF = TRUE;}
			if(f.Recall__c != i.Recall__c  ){f.Recall__c = i.Recall__c  ;UpdateF = TRUE;}
			if(f.Recent_Grades__c != i.Recent_Grades__c  ){f.Recent_Grades__c = i.Recent_Grades__c  ;UpdateF = TRUE;}
			if(f.Referal_Completed__c != i.Referal_Completed__c  ){f.Referal_Completed__c = i.Referal_Completed__c  ;UpdateF = TRUE;}
			if(f.Referral_Source_Type__c != i.Referral_Source_Type__c  ){f.Referral_Source_Type__c = i.Referral_Source_Type__c  ;UpdateF = TRUE;}
			if(f.Referral_Type__c != i.Referral_Type__c  ){f.Referral_Type__c = i.Referral_Type__c  ;UpdateF = TRUE;}
			if(f.Reward__c != i.Reward__c  ){f.Reward__c = i.Reward__c  ;UpdateF = TRUE;}
			if(f.Service_Level__c != i.Service_Level__c  ){f.Service_Level__c = i.Service_Level__c  ;UpdateF = TRUE;}
			if(f.SES_Program__c != i.SES_Program__c  ){f.SES_Program__c = i.SES_Program__c  ;UpdateF = TRUE;}
			if(f.Sexual_Preference__c != i.Sexual_Preference__c  ){f.Sexual_Preference__c = i.Sexual_Preference__c  ;UpdateF = TRUE;}
			if(f.Skill_Deficits__c != i.Skill_Deficits__c  ){f.Skill_Deficits__c = i.Skill_Deficits__c  ;UpdateF = TRUE;}
			if(f.Social_Judgment__c != i.Social_Judgment__c  ){f.Social_Judgment__c = i.Social_Judgment__c  ;UpdateF = TRUE;}
			if(f.Social_Maturity__c != i.Social_Maturity__c  ){f.Social_Maturity__c = i.Social_Maturity__c  ;UpdateF = TRUE;}
			if(f.Speech__c != i.Speech__c  ){f.Speech__c = i.Speech__c  ;UpdateF = TRUE;}
			if(f.Stature__c != i.Stature__c  ){f.Stature__c = i.Stature__c  ;UpdateF = TRUE;}
			if(f.Stressors__c != i.Stressors__c  ){f.Stressors__c = i.Stressors__c  ;UpdateF = TRUE;}
			// if(f.Supports__c != i.Supports__c  ){f.Supports__c = i.Supports__c  ;UpdateF = TRUE;}
			// if(f.Target_Neighborhood__c != i.Target_Neighborhood__c  ){f.Target_Neighborhood__c = i.Target_Neighborhood__c  ;UpdateF = TRUE;}
			// if(f.Thoughts__c != i.Thoughts__c  ){f.Thoughts__c = i.Thoughts__c  ;UpdateF = TRUE;}
			if(f.Weight__c != i.Weight__c  ){f.Weight__c = i.Weight__c  ;UpdateF = TRUE;}

			if(f.Abuse__c != i.Abuse__c  ){f.Abuse__c = i.Abuse__c  ;UpdateF = TRUE;}
			if(f.Activities__c != i.Activities__c  ){f.Activities__c = i.Activities__c  ;UpdateF = TRUE;}
			if(f.Allergies__c != i.Allergies__c  ){f.Allergies__c = i.Allergies__c  ;UpdateF = TRUE;}
			if(f.Behavioral_Issues__c != i.Behavioral_Issues__c  ){f.Behavioral_Issues__c = i.Behavioral_Issues__c  ;UpdateF = TRUE;}
			if(f.Family_Functioning_Level__c != i.Family_Functioning_Level__c  ){f.Family_Functioning_Level__c = i.Family_Functioning_Level__c  ;UpdateF = TRUE;}
			if(f.Had_illness__c != i.Had_illness__c  ){f.Had_illness__c = i.Had_illness__c  ;UpdateF = TRUE;}
			if(f.Hobbies__c != i.Hobbies__c  ){f.Hobbies__c = i.Hobbies__c  ;UpdateF = TRUE;}
			if(f.Life_Skills__c != i.Life_Skills__c  ){f.Life_Skills__c = i.Life_Skills__c  ;UpdateF = TRUE;}

			if(f.Allergies_Detailed__c != i.Allergies_Detailed__c  ){f.Allergies_Detailed__c = i.Allergies_Detailed__c  ;UpdateF = TRUE;}
			if(f.Behavior_Exhibited__c != i.Behavior_Exhibited__c  ){f.Behavior_Exhibited__c = i.Behavior_Exhibited__c  ;UpdateF = TRUE;}
			if(f.Comments__c != i.Comments__c  ){f.Comments__c = i.Comments__c  ;UpdateF = TRUE;}
			if(f.Counseling_Detailed__c != i.Counseling_Detailed__c  ){f.Counseling_Detailed__c = i.Counseling_Detailed__c  ;UpdateF = TRUE;}
			if(f.Counseling_Detailed2__c != i.Counseling_Detailed2__c  ){f.Counseling_Detailed2__c = i.Counseling_Detailed2__c  ;UpdateF = TRUE;}
			if(f.DA_Concerns_Detailed__c != i.DA_Concerns_Detailed__c  ){f.DA_Concerns_Detailed__c = i.DA_Concerns_Detailed__c  ;UpdateF = TRUE;}
			if(f.Education_Concerns__c != i.Education_Concerns__c  ){f.Education_Concerns__c = i.Education_Concerns__c  ;UpdateF = TRUE;}
			if(f.Education_Summary__c != i.Education_Summary__c  ){f.Education_Summary__c = i.Education_Summary__c  ;UpdateF = TRUE;}
			if(f.Explain__c != i.Explain__c  ){f.Explain__c = i.Explain__c  ;UpdateF = TRUE;}
			if(f.Friends_Detailed__c != i.Friends_Detailed__c  ){f.Friends_Detailed__c = i.Friends_Detailed__c  ;UpdateF = TRUE;}
			if(f.Fun__c != i.Fun__c  ){f.Fun__c = i.Fun__c  ;UpdateF = TRUE;}
			if(f.Goal_Summary__c != i.Goal_Summary__c  ){f.Goal_Summary__c = i.Goal_Summary__c  ;UpdateF = TRUE;}
			if(f.Group_Summary__c != i.Group_Summary__c  ){f.Group_Summary__c = i.Group_Summary__c  ;UpdateF = TRUE;}
			if(f.Health_Summary__c != i.Health_Summary__c  ){f.Health_Summary__c = i.Health_Summary__c  ;UpdateF = TRUE;}
			if(f.Home_Summary__c != i.Home_Summary__c  ){f.Home_Summary__c = i.Home_Summary__c  ;UpdateF = TRUE;}
			if(f.How_are_your_Grades__c != i.How_are_your_Grades__c  ){f.How_are_your_Grades__c = i.How_are_your_Grades__c  ;UpdateF = TRUE;}
			if(f.illness_Detailed__c != i.illness_Detailed__c  ){f.illness_Detailed__c = i.illness_Detailed__c  ;UpdateF = TRUE;}
			if(f.Limitations__c != i.Limitations__c  ){f.Limitations__c = i.Limitations__c  ;UpdateF = TRUE;}
			if(f.Medical_Issues_other__c != i.Medical_Issues_other__c  ){f.Medical_Issues_other__c = i.Medical_Issues_other__c  ;UpdateF = TRUE;}
			if(f.MH_History_Detailed__c != i.MH_History_Detailed__c  ){f.MH_History_Detailed__c = i.MH_History_Detailed__c  ;UpdateF = TRUE;}
			if(f.Placements_Dates__c != i.Placements_Dates__c  ){f.Placements_Dates__c = i.Placements_Dates__c  ;UpdateF = TRUE;}
			if(f.Referral_Reason__c != i.Referral_Reason__c  ){f.Referral_Reason__c = i.Referral_Reason__c  ;UpdateF = TRUE;}
			if(f.Religion_Importance_Detailed__c != i.Religion_Importance_Detailed__c  ){f.Religion_Importance_Detailed__c = i.Religion_Importance_Detailed__c  ;UpdateF = TRUE;}
			if(f.Self_Views__c != i.Self_Views__c  ){f.Self_Views__c = i.Self_Views__c  ;UpdateF = TRUE;}
			if(f.Special_Needs__c != i.Special_Needs__c  ){f.Special_Needs__c = i.Special_Needs__c  ;UpdateF = TRUE;}
			if(f.Strengths__c != i.Strengths__c  ){f.Strengths__c = i.Strengths__c  ;UpdateF = TRUE;}
			if(f.Whom_do_you_live_with__c != i.Whom_do_you_live_with__c  ){f.Whom_do_you_live_with__c = i.Whom_do_you_live_with__c  ;UpdateF = TRUE;}
			if(f.Academic_Goals__c != i.Academic_Goals__c  ){f.Academic_Goals__c = i.Academic_Goals__c  ;UpdateF = TRUE;}
			if(f.Activity_Invovlement__c != i.Activity_Invovlement__c  ){f.Activity_Invovlement__c = i.Activity_Invovlement__c  ;UpdateF = TRUE;}
			if(f.Additional_Information__c != i.Additional_Information__c  ){f.Additional_Information__c = i.Additional_Information__c  ;UpdateF = TRUE;}
			if(f.Behavioral_Issues_other__c != i.Behavioral_Issues_other__c  ){f.Behavioral_Issues_other__c = i.Behavioral_Issues_other__c  ;UpdateF = TRUE;}
			if(f.Care_Manager__c != i.Care_Manager__c  ){f.Care_Manager__c = i.Care_Manager__c  ;UpdateF = TRUE;}
			if(f.Career_Goal__c != i.Career_Goal__c  ){f.Career_Goal__c = i.Career_Goal__c  ;UpdateF = TRUE;}
			if(f.Clothing_Summary__c != i.Clothing_Summary__c  ){f.Clothing_Summary__c = i.Clothing_Summary__c  ;UpdateF = TRUE;}
			if(f.Community_Suppports__c != i.Community_Suppports__c  ){f.Community_Suppports__c = i.Community_Suppports__c  ;UpdateF = TRUE;}
			if(f.Counseling_When__c != i.Counseling_When__c  ){f.Counseling_When__c = i.Counseling_When__c  ;UpdateF = TRUE;}
			if(f.Counseling_When2__c != i.Counseling_When2__c  ){f.Counseling_When2__c = i.Counseling_When2__c  ;UpdateF = TRUE;}
			if(f.Counselor__c != i.Counselor__c  ){f.Counselor__c = i.Counselor__c  ;UpdateF = TRUE;}
			if(f.Counselor_2__c != i.Counselor_2__c  ){f.Counselor_2__c = i.Counselor_2__c  ;UpdateF = TRUE;}
			if(f.Custodianship__c != i.Custodianship__c  ){f.Custodianship__c = i.Custodianship__c  ;UpdateF = TRUE;}
			if(f.CYF_Case_Worker__c != i.CYF_Case_Worker__c  ){f.CYF_Case_Worker__c = i.CYF_Case_Worker__c  ;UpdateF = TRUE;}
			if(f.DA_Pregnancy__c != i.DA_Pregnancy__c  ){f.DA_Pregnancy__c = i.DA_Pregnancy__c  ;UpdateF = TRUE;}
			if(f.Diagnosis__c != i.Diagnosis__c  ){f.Diagnosis__c = i.Diagnosis__c  ;UpdateF = TRUE;}
			if(f.Dismissal__c != i.Dismissal__c  ){f.Dismissal__c = i.Dismissal__c  ;UpdateF = TRUE;}
			if(f.Family_Supports__c != i.Family_Supports__c  ){f.Family_Supports__c = i.Family_Supports__c  ;UpdateF = TRUE;}
			if(f.Gynecological_Exam__c != i.Gynecological_Exam__c  ){f.Gynecological_Exam__c = i.Gynecological_Exam__c  ;UpdateF = TRUE;}
			if(f.Insurance_Carrier__c != i.Insurance_Carrier__c  ){f.Insurance_Carrier__c = i.Insurance_Carrier__c  ;UpdateF = TRUE;}
			if(f.Issues_Concerns__c != i.Issues_Concerns__c  ){f.Issues_Concerns__c = i.Issues_Concerns__c  ;UpdateF = TRUE;}
			if(f.Juvenile_Probation__c != i.Juvenile_Probation__c  ){f.Juvenile_Probation__c = i.Juvenile_Probation__c  ;UpdateF = TRUE;}
			if(f.Other_Items__c != i.Other_Items__c  ){f.Other_Items__c = i.Other_Items__c  ;UpdateF = TRUE;}
			if(f.Parenting__c != i.Parenting__c  ){f.Parenting__c = i.Parenting__c  ;UpdateF = TRUE;}
			if(f.Physician_Facility__c != i.Physician_Facility__c  ){f.Physician_Facility__c = i.Physician_Facility__c  ;UpdateF = TRUE;}
			if(f.Physician_Name__c != i.Physician_Name__c  ){f.Physician_Name__c = i.Physician_Name__c  ;UpdateF = TRUE;}
			if(f.Pregnancy_Term__c != i.Pregnancy_Term__c  ){f.Pregnancy_Term__c = i.Pregnancy_Term__c  ;UpdateF = TRUE;}
			if(f.Referral_Source_Relationship__c != i.Referral_Source_Relationship__c  ){f.Referral_Source_Relationship__c = i.Referral_Source_Relationship__c  ;UpdateF = TRUE;}
			if(f.Religion__c != i.Religion__c  ){f.Religion__c = i.Religion__c  ;UpdateF = TRUE;}
			if(f.Repeated_Grade__c != i.Repeated_Grade__c  ){f.Repeated_Grade__c = i.Repeated_Grade__c  ;UpdateF = TRUE;}
			if(f.Sexual_Abuse__c != i.Sexual_Abuse__c  ){f.Sexual_Abuse__c = i.Sexual_Abuse__c  ;UpdateF = TRUE;}
			if(f.Subject_Excelling__c != i.Subject_Excelling__c  ){f.Subject_Excelling__c = i.Subject_Excelling__c  ;UpdateF = TRUE;}
			if(f.Subject_Needs_Help__c != i.Subject_Needs_Help__c  ){f.Subject_Needs_Help__c = i.Subject_Needs_Help__c  ;UpdateF = TRUE;}
			if(f.Supervisor__c != i.Supervisor__c  ){f.Supervisor__c = i.Supervisor__c  ;UpdateF = TRUE;}
			// if(f.Talents_Skills__c != i.Talents_Skills__c  ){f.Talents_Skills__c = i.Talents_Skills__c  ;UpdateF = TRUE;}
			// if(f.Voluntary_Service__c != i.Voluntary_Service__c  ){f.Voluntary_Service__c = i.Voluntary_Service__c  ;UpdateF = TRUE;}

			if(UpdateF == TRUE){
				fups.add(f);
			}

			}//End If fmap.get(i.id) != NULL

		}//End for Intake i : iList

		if(!fups.isEmpty()){

			//upsert fups;

			try{
			Database.UpsertResult[] srf = Database.Upsert(fups,false); //Try and update the forms
			}catch(Exception efu){
				System.Debug('-------------- Error Updating Forms ----------------'+efu.getMessage());
			}

		}
		*/
	}
}