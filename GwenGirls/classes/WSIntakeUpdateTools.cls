global class WSIntakeUpdateTools {
	
public static void updateRelatedRecords(Set<id> iids){

		List<Intake__c> iList = new List<Intake__c>(); //A List of Intakes

		List<Contact> ctList = new List<Contact>(); //A List of Contacts
		List<Contact> ctups = new List<Contact>(); //A List of Contacts to Update
		Map<Id,Contact> cntcmap = new Map<Id,Contact>(); //A Map of Intake Ids to Contact
		Set<Id> ctids = new Set<Id>(); //A Set of Contact Ids

		List<Case> csList = new List<Case>(); //A List of Cases

		List<Case> csups = new List<Case>(); //A List of Cases to Update
		Map<Id,Case> casemap = new Map<Id,Case>(); //A Map of Intake Id to Case
		Set<Id> csids = new Set<Id>(); //A Set of Case Ids

        //FIND THE INTAKES

		SObjectType intaketype = Schema.getGlobalDescribe().get('Intake__c');
        Map<String,Schema.SObjectField> intakeFields = intaketype.getDescribe().fields.getMap(); //A Map of Fields on Payment

		string intakeselect = 'Select ';

        for(string pd : intakeFields.keyset()){
            intakeselect = intakeselect + intakeFields.get(pd) + ', ';
        }
        intakeselect = intakeselect.substring(0,intakeselect.length()-2);
        intakeselect = intakeselect + '';
        intakeselect = intakeselect + ' FROM Intake__c WHERE Id IN: iids';

       // try{
            iList = (Intake__c[])Database.query(intakeselect); //The list of Intakes
        //}catch(Exception epr){
            //system.debug('***********************ERROR Querying Intakes ***********************' + epr.getMessage());
        //}

        //Populate the ID Sets for Contact, Form and Case

        system.debug('***********************iList ***********************' + iList.size());

        if(!iList.isEmpty()){

        	for(Intake__c ii : iList){

        		if(ii.Client__c != NULL){

				ctids.add(ii.Client__c);
	        	csids.add(ii.Case__c);

        		}

        	}

    	}

        system.debug('***********************clids ***********************' + ctids.size());
        system.debug('***********************csids ***********************' + csids.size());
        
        //FIND THE CONTACTS

        SObjectType contacttype = Schema.getGlobalDescribe().get('Contact');
        Map<String,Schema.SObjectField> contactFields = contacttype.getDescribe().fields.getMap(); //A Map of Fields on Contact

		string contactselect = 'Select ';

        for(string cf : contactFields.keyset()){
            contactselect = contactselect + contactFields.get(cf) + ', ';
        }
        contactselect = contactselect.substring(0,contactselect.length()-2);
        contactselect = contactselect + '';
        contactselect = contactselect + ' FROM Contact WHERE Id IN: ctids';

        try{
            ctList = (Contact[])Database.query(contactselect); //The list of Contacts
        }catch(Exception ect){
            system.debug('***********************ERROR Querying Contacts ***********************' + ect.getMessage());
        }

        if(!ctList.isEmpty()){

        	for(Contact tc : ctList){

        		cntcmap.put(tc.Intake__c,tc);
        	}
        }

        //FIND THE CASES

		SObjectType casetype = Schema.getGlobalDescribe().get('Case');
        Map<String,Schema.SObjectField> caseFields = casetype.getDescribe().fields.getMap(); //A Map of Fields on Case

		string caseselect = 'Select ';

        for(string csf : caseFields.keyset()){
            caseselect = caseselect + caseFields.get(csf) + ', ';
        }
        caseselect = caseselect.substring(0,caseselect.length()-2);
        caseselect = caseselect + '';
        caseselect = caseselect + ' FROM Case WHERE Id IN: csids';

        try{
            csList = (Case[])Database.query(caseselect); //The list of Cases
        }catch(Exception ecs){
            system.debug('***********************ERROR Querying Cases ***********************' + ecs.getMessage());
        }

        if(!csList.isEmpty()){

        	for(Case tcs : csList){

        		casemap.put(tcs.Intake__c,tcs);
        	}
        }


        //Compare the Intake to Contact, Case and Form and Update Each if Necessary

        for(Intake__c i : iList){


	        Boolean UpdateCT = FALSE; //Update the Contact
	        Boolean UpdateC = FALSE; //Update the Case

	        //Compare Contact c to Intake i

	        if(cntcmap.get(i.id) != NULL){

		        Contact c = cntcmap.get(i.id);

		        if(c.OwnerId != i.OwnerId){c.OwnerId = i.OwnerId;UpdateCT = TRUE;}
		        if(c.YDS_or_CM_c__c != i.YDS_or_CM_c__c){c.YDS_or_CM_c__c = i.YDS_or_CM_c__c;UpdateCT =TRUE;}

				if(c.FirstName != i.First_Name__c){c.FirstName = i.First_Name__c;UpdateCT = TRUE;}
				if(c.LastName != i.Last_Name__c){c.LastName = i.Last_Name__c;UpdateCT = TRUE;}
				if(c.npe01__Primary_Address_Type__c != i.Mailing_Address_Type__c){c.npe01__Primary_Address_Type__c = i.Mailing_Address_Type__c;UpdateCT = TRUE;}
				if(c.npe01__Secondary_Address_Type__c != i.Other_Address_Type__c){c.npe01__Secondary_Address_Type__c = i.Other_Address_Type__c;UpdateCT = TRUE;}
				if(c.MailingCity != i.Mailing_City__c){c.MailingCity = i.Mailing_City__c;UpdateCT = TRUE;}
				if(c.MailingState != i.Mailing_State__c){c.MailingState = i.Mailing_State__c;UpdateCT = TRUE;}
				if(c.MailingStreet != i.Mailing_Street__c){c.MailingStreet = i.Mailing_Street__c;UpdateCT = TRUE;}
				if(c.MailingPostalCode != i.Mailing_Zip_Code__c){c.MailingPostalCode = i.Mailing_Zip_Code__c;UpdateCT = TRUE;}
				if(c.MobilePhone != i.Mobile_Phone__c){c.MobilePhone = i.Mobile_Phone__c;UpdateCT = TRUE;}
				if(c.OtherCity != i.Other_City__c){c.OtherCity = i.Other_City__c;UpdateCT = TRUE;}
				if(c.OtherState != i.Other_State__c){c.OtherState = i.Other_State__c;UpdateCT = TRUE;}
				if(c.OtherStreet != i.Other_Street__c){c.OtherStreet = i.Other_Street__c;UpdateCT = TRUE;}
				if(c.OtherPostalCode != i.Other_Zip_Code__c){c.OtherPostalCode = i.Other_Zip_Code__c;UpdateCT = TRUE;}
				if(c.npe01__Preferred_Email__c != i.Preferred_Email__c){c.npe01__Preferred_Email__c = i.Preferred_Email__c;UpdateCT = TRUE;}
				if(c.npe01__AlternateEmail__c != i.Alternate_Email__c){c.npe01__AlternateEmail__c = i.Alternate_Email__c;UpdateCT = TRUE;}
				if(c.npe01__HomeEmail__c != i.Personal_Email__c){c.npe01__HomeEmail__c = i.Personal_Email__c;UpdateCT = TRUE;}
				if(c.npe01__WorkEmail__c != i.Work_Email__c){c.npe01__WorkEmail__c = i.Work_Email__c;UpdateCT = TRUE;}
				if(c.npe01__PreferredPhone__c != i.PreferredPhone__c){c.npe01__PreferredPhone__c = i.PreferredPhone__c;UpdateCT = TRUE;}
				if(c.npe01__WorkPhone__c != i.Work_Phone__c){c.npe01__WorkPhone__c = i.Work_Phone__c;UpdateCT = TRUE;}
				if(c.HomePhone != i.Home_Phone__c){c.HomePhone = i.Home_Phone__c;UpdateCT = TRUE;}
				if(c.OtherPhone != i.Other_Phone__c){c.OtherPhone = i.Other_Phone__c;UpdateCT = TRUE;}
				if(c.Birthdate != i.Birthdate__c){c.Birthdate = i.Birthdate__c;UpdateCT = TRUE;}
				if(c.Child_will_Attend_Afterschool__c != i.Child_will_Attend_Afterschool__c){c.Child_will_Attend_Afterschool__c = i.Child_will_Attend_Afterschool__c;UpdateCT = TRUE;}
				if(c.Comments__c != i.Comments__c){c.Comments__c = i.Comments__c;UpdateCT = TRUE;}
				if(c.Court_Active__c != i.Court_Active__c){c.Court_Active__c = i.Court_Active__c;UpdateCT = TRUE;}
				if(c.Current_Placement__c != i.Current_Placement__c){c.Current_Placement__c = i.Current_Placement__c;UpdateCT = TRUE;}
				if(c.CYF_Active__C != i.CYF_Active__C){c.CYF_Active__C = i.CYF_Active__C;UpdateCT = TRUE;}
				if(c.Date_of_Placement__c != i.Date_of_Placement__c){c.Date_of_Placement__c = i.Date_of_Placement__c;UpdateCT = TRUE;}
				if(c.Eye_Color__c != i.Eye_Color__c){c.Eye_Color__c = i.Eye_Color__c;UpdateCT = TRUE;}
				if(c.Gender__c != i.Gender__c){c.Gender__c = i.Gender__c;UpdateCT = TRUE;}
				if(c.Grade__c != String.valueOf(i.Grade__c)){c.Grade__c = String.valueOf(i.Grade__c);UpdateCT = TRUE;}
				if(c.Hair_Color__c != i.Hair_Color__c){c.Hair_Color__c = i.Hair_Color__c;UpdateCT = TRUE;}
				if(c.Height_feet__c != i.Height_feet__c){c.Height_feet__c = i.Height_feet__c;UpdateCT = TRUE;}
				if(c.Height_inches__c != i.Height_inches__c){c.Height_inches__c = i.Height_inches__c;UpdateCT = TRUE;}
				if(i.Household__c != NULL && c.AccountId != i.Household__c){c.AccountId = i.Household__c;UpdateCT = TRUE;}
				if(c.Identifying_Marks__c != i.Identifying_Marks__c){c.Identifying_Marks__c = i.Identifying_Marks__c;UpdateCT = TRUE;}
				if(c.Interest_Areas__c != i.Interest_Areas__c){c.Interest_Areas__c = i.Interest_Areas__c;UpdateCT = TRUE;}
				if(c.KIDS_ID__c != String.valueOf(i.KIDS_ID__c)){c.KIDS_ID__c = String.valueOf(i.KIDS_ID__c);UpdateCT = TRUE;}
				if(c.Place_of_Employment__c != i.Place_of_Employment__c){c.Place_of_Employment__c = i.Place_of_Employment__c;UpdateCT = TRUE;}
				if(c.Race__c != i.Race__c){c.Race__c = i.Race__c;UpdateCT = TRUE;}
				if(c.Recommendation__c != i.Recommendation__c){c.Recommendation__c = i.Recommendation__c;UpdateCT = TRUE;}
				if(c.Referral_Source__c != NULL && c.Referral_Source__c != i.Referral_Source__c){c.Referral_Source__c = i.Referral_Source__c;UpdateCT = TRUE;}
				if(c.Restitution__c != i.Restitution__c){c.Restitution__c = i.Restitution__c;UpdateCT = TRUE;}
				if(i.School__c != NULL && c.School__c != i.School__c){c.School__c = i.School__c;UpdateCT = TRUE;}
				if(c.Weight__c != i.Weight_NUM__c){c.Weight__c = i.Weight_NUM__c;UpdateCT = TRUE;}

				//New Mappings as of 3.13.2019
				if(c.Appropriate_Age__c != i.Appropriate_Age__c){c.Appropriate_Age__c = i.Appropriate_Age__c;UpdateCT = TRUE;}
				if(	c.Approved_Pick_Up_1__c != i.Approved_Pick_Up_1__c){	c.Approved_Pick_Up_1__c = i.Approved_Pick_Up_1__c;UpdateCT = TRUE;}
				if(	c.Approved_Pick_Up_1_Phone__c != i.Approved_Pick_Up_1_Phone__c){	c.Approved_Pick_Up_1_Phone__c = i.Approved_Pick_Up_1_Phone__c;UpdateCT = TRUE;}
				if(	c.Approved_Pick_Up_1_Relationship__c != i.Approved_Pick_Up_1_Relationship__c){	c.Approved_Pick_Up_1_Relationship__c = i.Approved_Pick_Up_1_Relationship__c;UpdateCT = TRUE;}
				if(	c.Approved_Pick_Up_2__c != i.Approved_Pick_Up_2__c){	c.Approved_Pick_Up_2__c = i.Approved_Pick_Up_2__c;UpdateCT = TRUE;}
				if(	c.Approved_Pick_Up_2_Phone__c != i.Approved_Pick_Up_2_Phone__c){	c.Approved_Pick_Up_2_Phone__c = i.Approved_Pick_Up_2_Phone__c;UpdateCT = TRUE;}
				if(	c.Approved_Pick_Up_2_Relationship__c != i.Approved_Pick_Up_2_Relationship__c){	c.Approved_Pick_Up_2_Relationship__c = i.Approved_Pick_Up_2_Relationship__c;UpdateCT = TRUE;}
				if(	c.Approved_Pick_Up_3__c != i.Approved_Pick_Up_3__c){	c.Approved_Pick_Up_3__c = i.Approved_Pick_Up_3__c;UpdateCT = TRUE;}
				if(	c.Approved_Pick_Up_3_Phone__c != i.Approved_Pick_Up_3_Phone__c){	c.Approved_Pick_Up_3_Phone__c = i.Approved_Pick_Up_3_Phone__c;UpdateCT = TRUE;}
				if(	c.Approved_Pick_Up_3_Relationship__c != i.Approved_Pick_Up_3_Relationship__c){	c.Approved_Pick_Up_3_Relationship__c = i.Approved_Pick_Up_3_Relationship__c;UpdateCT = TRUE;}
				if(	c.Approved_Pick_Up_4__c != i.Approved_Pick_Up_4__c){	c.Approved_Pick_Up_4__c = i.Approved_Pick_Up_4__c;UpdateCT = TRUE;}
				if(	c.Approved_Pick_Up_4_Phone__c != i.Approved_Pick_Up_4_Phone__c){	c.Approved_Pick_Up_4_Phone__c = i.Approved_Pick_Up_4_Phone__c;UpdateCT = TRUE;}
				if(	c.Approved_Pick_Up_4_Relationship__c != i.Approved_Pick_Up_4_Relationship__c){	c.Approved_Pick_Up_4_Relationship__c = i.Approved_Pick_Up_4_Relationship__c;UpdateCT = TRUE;}
				if(	c.Community_Service__c != i.Community_Serv_Hrs__c){	c.Community_Service__c = i.Community_Serv_Hrs__c;UpdateCT = TRUE;}
				if(	c.Emergency_Contact__c != i.Emergency_Contact__c){	c.Emergency_Contact__c = i.Emergency_Contact__c;UpdateCT = TRUE;}
				if(	c.Emergency_Contact_2__c != i.Emergency_Contact_2__c){	c.Emergency_Contact_2__c = i.Emergency_Contact_2__c;UpdateCT = TRUE;}
				if(	c.Emergency_Contact_2_Cell_Phone__c != i.Emergency_Contact_2_Cell_Phone__c){	c.Emergency_Contact_2_Cell_Phone__c = i.Emergency_Contact_2_Cell_Phone__c;UpdateCT = TRUE;}
				if(	c.Emergency_Contact_2_First__c != i.Emergency_Contact_2_First__c){	c.Emergency_Contact_2_First__c = i.Emergency_Contact_2_First__c;UpdateCT = TRUE;}
				if(	c.Emergency_Contact_2_Last__c != i.Emergency_Contact_2_Last__c){	c.Emergency_Contact_2_Last__c = i.Emergency_Contact_2_Last__c;UpdateCT = TRUE;}
				if(	c.Emergency_Contact_2_Phone__c != i.Emergency_Contact_2_Phone__c){	c.Emergency_Contact_2_Phone__c = i.Emergency_Contact_2_Phone__c;UpdateCT = TRUE;}
				if(	c.Emergency_Contact_Cell_Phone__c != i.Emergency_Contact_Cell_Phone__c){	c.Emergency_Contact_Cell_Phone__c = i.Emergency_Contact_Cell_Phone__c;UpdateCT = TRUE;}
				if(	c.Emergency_Contact_First__c != i.Emergency_Contact_First__c){	c.Emergency_Contact_First__c = i.Emergency_Contact_First__c;UpdateCT = TRUE;}
				if(	c.Emergency_Contact_Last__c != i.Emergency_Contact_Last__c){	c.Emergency_Contact_Last__c = i.Emergency_Contact_Last__c;UpdateCT = TRUE;}
				if(	c.Emergency_Contact_Phone__c != i.Emergency_Contact_Phone__c){	c.Emergency_Contact_Phone__c = i.Emergency_Contact_Phone__c;UpdateCT = TRUE;}
				if(	c.Guardian_City__c != i.Guardian_City__c){	c.Guardian_City__c = i.Guardian_City__c;UpdateCT = TRUE;}
				if(	c.Guardian_State__c != i.Guardian_State__c){	c.Guardian_State__c = i.Guardian_State__c;UpdateCT = TRUE;}
				if(	c.Guardian_Street__c != i.Guardian_Street__c){	c.Guardian_Street__c = i.Guardian_Street__c;UpdateCT = TRUE;}
				if(	c.Guardian_Zip__c != i.Guardian_Zip__c){	c.Guardian_Zip__c = i.Guardian_Zip__c;UpdateCT = TRUE;}
				if(	c.Household_Monthly_Income__c != i.Household_Monthly_Income__c){	c.Household_Monthly_Income__c = i.Household_Monthly_Income__c;UpdateCT = TRUE;}
				if(	c.Intake_Status__c != i.Intake_Status__c){	c.Intake_Status__c = i.Intake_Status__c;UpdateCT = TRUE;}
				if(	c.KIDS_ID__c != String.ValueOf(i.Kids_ID__c)){	c.KIDS_ID__c = String.ValueOf(i.Kids_ID__c);UpdateCT = TRUE;}
				if(	c.KIDS_Service_Episode_Id__c != i.KIDS_Service_Episode_Id__c){	c.KIDS_Service_Episode_Id__c = i.KIDS_Service_Episode_Id__c;UpdateCT = TRUE;}
				if(	c.Last_Physical_MM_YYYY__c != i.Last_Physical_MM_YYYY__c){	c.Last_Physical_MM_YYYY__c = i.Last_Physical_MM_YYYY__c;UpdateCT = TRUE;}
				if(	c.Name_of_Primary_Parent_Guardian__c != i.Name_of_Primary_Parent_Guardian__c){	c.Name_of_Primary_Parent_Guardian__c = i.Name_of_Primary_Parent_Guardian__c;UpdateCT = TRUE;}
				if(	c.Other_Caregiver_First__c != i.Other_Caregiver_First__c){	c.Other_Caregiver_First__c = i.Other_Caregiver_First__c;UpdateCT = TRUE;}
				if(	c.Other_Caregiver_Last__c != i.Other_Caregiver_Last__c){	c.Other_Caregiver_Last__c = i.Other_Caregiver_Last__c;UpdateCT = TRUE;}
				if(	c.Other_Guardian_Relationship__c != i.Other_Guardian_Relationship__c){	c.Other_Guardian_Relationship__c = i.Other_Guardian_Relationship__c;UpdateCT = TRUE;}
				if(	c.Primary_Guardian_First__c != i.Primary_Guardian_First__c){	c.Primary_Guardian_First__c = i.Primary_Guardian_First__c;UpdateCT = TRUE;}
				if(	c.Primary_Guardian_Last__c != i.Primary_Guardian_Last__c){	c.Primary_Guardian_Last__c = i.Primary_Guardian_Last__c;UpdateCT = TRUE;}
				if(	c.Primary_Guardian_Relationship__c != i.Primary_Guardian_Relationship__c){	c.Primary_Guardian_Relationship__c = i.Primary_Guardian_Relationship__c;UpdateCT = TRUE;}
				if(	c.Race__c != i.Race_TXT__c){	c.Race__c = i.Race_TXT__c;UpdateCT = TRUE;}
				if(	c.Reason_for_Deferment__c != i.Reason_for_Deferment__c){	c.Reason_for_Deferment__c = i.Reason_for_Deferment__c;UpdateCT = TRUE;}
				if(	c.Referral_Source_First__c != i.Referral_Source_First__c){	c.Referral_Source_First__c = i.Referral_Source_First__c;UpdateCT = TRUE;}
				if(	c.Referral_Source_Last__c != i.Referral_Source_Last__c){	c.Referral_Source_Last__c = i.Referral_Source_Last__c;UpdateCT = TRUE;}
				if(	c.SSN__c != i.SSN__c){	c.SSN__c = i.SSN__c;UpdateCT = TRUE;}
				if(	c.Status__c != i.Status__c){	c.Status__c = i.Status__c;UpdateCT = TRUE;}
				if(	c.Volunteer_Organization__c != i.Volunteer_Organization__c){	c.Volunteer_Organization__c = i.Volunteer_Organization__c;UpdateCT = TRUE;}
				if(	c.Weeks_Enrollment_Deferred__c != i.Weeks_Enrollment_Deferred__c){	c.Weeks_Enrollment_Deferred__c = i.Weeks_Enrollment_Deferred__c;UpdateCT = TRUE;}

				if(UpdateCT == TRUE){
					ctups.add(c);
				}

			}//End if cntcmap.get(i.id) != NULL

	        //Compare Case cs to Intake i

	        if(casemap.get(i.id) != NULL){

	        	Case csc = casemap.get(i.id);

	        	if(csc.YD_Specialist__c != i.YDS_or_CM_c__c){csc.YD_Specialist__c = i.YDS_or_CM_c__c;UpdateC = TRUE;}
	        	if(csc.OwnerId != i.OwnerId){csc.OwnerId = i.OwnerId;UpdateC = TRUE;}

	        	if(csc.ContactId != i.Client__c){csc.ContactId = i.Client__c;UpdateC = TRUE;}
				if(csc.AccountId != i.Household__c){csc.AccountId = i.Household__c;UpdateC = TRUE;}
				if(csc.Intake__c != i.id){csc.Intake__c = i.id;UpdateC = TRUE;}

				if(UpdateC == TRUE){
					csups.add(csc);
				}
	    	}

		}//End for Intake i : iList

		if(!ctups.isEmpty()){

			//upsert ctups;

			try{
			Database.UpsertResult[] srct = Database.Upsert(ctups,false); //Try and update the contacts
			}catch(Exception ectu){
				System.Debug('-------------- Error Updating Contacts ----------------'+ectu.getMessage());
			}

		}

		if(!csups.isEmpty()){

			//upsert csups;

			try{
			Database.UpsertResult[] srcs = Database.Upsert(csups,false); //Try and update the cases
			}catch(Exception ecsu){
				System.Debug('-------------- Error Updating Cases ----------------'+ecsu.getMessage());
			}

		}

		WSIntakeUpdateFormTools.updateRelatedRecords(iids);

	}

}