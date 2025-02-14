global class WSIntakeTools {

	// public static Set<Id> EngagementIds;

	public static void beforeInsertIntake(List<Intake__c> ins){

		/*
		for(Intake__c i : ins){

			String tempname;

			tempname='';

			if(i.First_Name__c != NULL && i.Last_Name__c != NULL){

				tempname = 'I - ' + i.Last_Name__c  + ', ' + i.First_Name__c; //I - [Last Name], [First Name]

			}else if(i.First_Name__c == NULL && i.Last_Name__c != NULL){

				tempname = 'I - ' + i.Last_Name__c;

			}else if(i.First_Name__c != NULL && i.Last_Name__c == NULL){

				tempname = 'I - ' + i.First_Name__c;

			}else if(i.First_Name__c == NULL && i.Last_Name__c == NULL){

				tempname = 'Unknown Intake by ' + UserInfo.getName();
			}

			if(i.Name == NULL || i.Name == '' || i.Name == 'Default' || i.Name == String.valueOf(i.Id)){

				i.Name = tempname;

			}else if(i.Name != NULL && i.Name !='' && i.Name != tempname){

				i.Name = tempname;
			}
		}
		*/
	}

	public static void createContactfromIntake(Set<Id> iids){

		// Grab your Custom Setting values
		/*
		WSCustomAdminSettings__c settings = WSCustomAdminSettings__c.getInstance();
		String ParentRecordType = settings.Parent_Contact_Record_Type__c;
		String ClientRecordType = settings.Client_Contact_Default_Record_Type__c;
		String OtherRecordType = settings.Other_Contact_Record_Type__c;

		List<Intake__c> ins = new List<Intake__c>(); //A List of Intakes
		List<Intake__c> iups = new List<Intake__c>(); //A List of Intakes to Update

		List<Contact> newcontacts = new List<Contact>(); //A List of New Contacts To Create
		List<Contact> contacts = new List<Contact>(); //A List of Newly Created Contacts
		List<Contact> othercts = new List<Contact>(); //A List of Other Related Contacts to Create
		List<Contact> othercontacts = new List<Contact>(); //A List of Other Contacts

		List<npe4__Relationship__c> newrs = new List<npe4__Relationship__c>(); //A List of New relationships

		Set<Id> newids = new Set<Id>(); //A Set of ids for newly inserted contacts
		Set<Id> octids = new Set<Id>(); //A Set of ids for newly inserted related / other contacts
		Set<Id> newrlids = new Set<Id>(); //A Set of ids for newly inserted relationships

		Map<Id,Contact> intakemap = new Map<Id,Contact>(); //A Map of Intake Ids to Contact Object
		Map<Id,Id> intakeidmap = new Map<Id,Id>(); //A Map of Intake Id to Contact Id
		Map<Id,Id> householdmap = new Map<Id,Id>(); //A Map of Intake Id to HouseHold Id

		Map<Id,Intake__c> iObjectMap = new Map<Id,Intake__c>(); //A Map of Intake Id to the Intake Object

		Map<Id,Id> contactmap = new Map<Id,Id>(); //A Map of Contact Id to Intake Id
        Map<Id,Id> metmap = new Map<Id,Id>(); //A map of contact Id to metric Id

        Map<String,Id> rmap = new Map<String,Id>(); //A map of newly created related contacts ...  Parent, Caregiver, Emergency Contact 1, Emergency Contact 2

		SObjectType intaketype = Schema.getGlobalDescribe().get('Intake__c');
        Map<String,Schema.SObjectField> intakeFields = intaketype.getDescribe().fields.getMap(); //A Map of Fields on Payment

        string intakeselect = 'Select ';

        for(string pd : intakeFields.keyset()){
            intakeselect = intakeselect + intakeFields.get(pd) + ', ';
        }
        intakeselect = intakeselect.substring(0,intakeselect.length()-2);
        intakeselect = intakeselect + '';
        intakeselect = intakeselect + ' FROM Intake__c WHERE Id IN: iids';

        try{
            ins = (Intake__c[])Database.query(intakeselect); //The list of Intakes
        }catch(Exception epr){
			ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', epr.getMessage(),'ERROR');
            system.debug('***********************ERROR Querying Intakes ***********************' + epr.getMessage());
        }

        system.debug('************ ins Size **********'+ins.size());

		for(Intake__c i : ins){

			iObjectMap.put(i.id,i);

			if(i.Client__c == NULL){

				system.debug('******** CREATE NEW CLIENT FROM INTAKE ***********');

				Contact c = new Contact();

				c.OwnerId = i.OwnerId;
				c.YDS_or_CM_c__c = i.YDS_or_CM_c__c;

				c.RecordTypeId = ClientRecordType; //'012V00000008r8PIAQ'; //ClientRecordType;

				c.Intake__c = i.Id; //Set The Intake Reference

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


				//// come back
				if(i.Household__c != NULL){
					c.AccountId = i.Household__c;
				}

				c.Identifying_Marks__c = i.Identifying_Marks__c;
				c.Interest_Areas__c = i.Interest_Areas__c;

				c.KIDS_ID__c = String.valueOf(i.KIDS_ID__c);

				c.Place_of_Employment__c = i.Place_of_Employment__c;
				c.Race__c = i.Race__c;
				c.Recommendation__c = i.Recommendation__c;

				//// come back
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
				// c.KIDS_ID__c = String.ValueOf(i.Kids_ID__c); already set
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
				c.SSN__c = i.SSN__c; // come back
				c.Status__c = i.Status__c;
				// c.Volunteer_Organization__c = i.Volunteer_Organization__c;
				c.Weeks_Enrollment_Deferred__c = i.Weeks_Enrollment_Deferred__c;


				newcontacts.add(c);

			}//End if i.Contact__c == NULL

		}//End for Intake__c i: ins

		if(!newcontacts.isEmpty()){ //Only do something if the list of new contacts is not empty
			
			//insert newcontacts;

			try{

				Database.DMLOptions dml = new Database.DMLOptions();
				dml.DuplicateRuleHeader.AllowSave = true; 

				Database.SaveResult[] srs = Database.Insert(newcontacts,dml); //Try  to insert the new contacts
				for(Database.SaveResult sr : srs){ //Cycle through the Save Results
					if(sr.isSuccess() == TRUE){ //Do something if the result is a success
						newids.add(sr.getId()); //Add the new Ids to a set of Ids
					}
					else {
						// Operation failed, so get all errors                
						for(Database.Error err : sr.getErrors()) {
							System.debug('The following error has occurred.');                    
							System.debug(err.getStatusCode() + ': ' + err.getMessage());
							System.debug('Fields that affected this error: ' + err.getFields());
							ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', err.getMessage(),'ERROR');
						}
					}
				}
			}catch(Exception e){
				System.Debug('------------Error Inserting New Contacts from Intakes ------------'+e.getMessage());
				ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', e.getMessage(),'ERROR');
			}
		}

		System.Debug('NEWIDS SIZE' + newids.size());

		if(!newids.isEmpty()){

			contacts = [SELECT Id, Intake__c, AccountId FROM Contact WHERE Id IN: newids];

		}

		System.Debug('CONTACTS SIZE'+ contacts.size());

		if(!contacts.isEmpty()){

			for(Contact cm : contacts){
				intakemap.put(cm.Intake__c,cm); //Populate the Intake to Contact ID Map
				intakeidmap.put(cm.Intake__c,cm.Id);
				householdmap.put(cm.Intake__c,cm.AccountId);
				contactmap.put(cm.id,cm.Intake__c);
			}

			for(Contact c : contacts){

				if(contactmap.get(c.id)!=NULL){

					Intake__c i = iObjectMap.get(contactmap.get(c.id)); //Get the Intake

					if(i.Primary_Guardian_Last__c != NULL){ //The Primary Guardian
					Contact pg = new Contact();

						pg.Role__c = 'Parent';

						pg.YDS_or_CM_c__c = i.YDS_or_CM_c__c;
						pg.OwnerId = i.OwnerId;

						pg.RecordTypeId = ParentRecordType;
						pg.FirstName = i.Primary_Guardian_First__c;
						pg.Lastname = i.Primary_Guardian_Last__c;
						pg.AccountId = c.AccountId; //Assign the Parent to the Client Household
						pg.Intake__c = i.Id;

						pg.npe01__Secondary_Address_Type__c = i.Other_Address_Type__c;

						if(i.Guardian_Street__c != NULL || i.Guardian_City__c != NULL || i.Guardian_State__c != NULL || i.Guardian_Zip__c != NULL){
						
							pg.MailingStreet  = i.Guardian_Street__c;
							pg.MailingCity = i.Guardian_City__c;
							pg.MailingState = i.Guardian_State__c;
							pg.MailingPostalCode = i.Guardian_Zip__c;

						}else{

							pg.MailingCity = i.Mailing_City__c;
							pg.MailingState = i.Mailing_State__c;
							pg.MailingStreet = i.Mailing_Street__c;
							pg.MailingPostalCode = i.Mailing_Zip_Code__c;
							pg.MobilePhone = i.Mobile_Phone__c;

						}

						pg.npe01__Preferred_Email__c = i.Preferred_Email__c;
						pg.npe01__AlternateEmail__c = i.Alternate_Email__c;
						pg.npe01__HomeEmail__c = i.Personal_Email__c;
						pg.npe01__WorkEmail__c = i.Work_Email__c;

						pg.npe01__PreferredPhone__c = i.PreferredPhone__c;
						pg.npe01__WorkPhone__c = i.Work_Phone__c;
						pg.HomePhone = i.Home_Phone__c;
						pg.OtherPhone = i.Other_Phone__c;

						pg.Intake_Relationship_Type__c = i.Primary_Guardian_Relationship__c;

						othercts.add(pg);
					}

					if(i.Other_Caregiver_Last__c != NULL){ //The Other Caregiver
					Contact ocg = new Contact();
						ocg.Role__c = 'Caregiver';

						ocg.YDS_or_CM_c__c = i.YDS_or_CM_c__c;
						ocg.OWnerId = i.OwnerId;

						ocg.RecordTypeId = ParentRecordType;
						ocg.FirstName = i.Other_Caregiver_First__c;
						ocg.LastName = i.Other_Caregiver_Last__c;
						ocg.AccountId = c.AccountId; //Assign the Caregiver to the Client Household
						ocg.Intake__c = i.Id;

						ocg.Intake_Relationship_Type__c = i.Other_Guardian_Relationship__c;

						othercts.add(ocg);
					}

					if(i.Emergency_Contact_Last__c != NULL){ //Emergency Contact 1
					Contact ec1 = new Contact();
						ec1.Role__c = 'Emergency Contact 1';

						ec1.YDS_or_CM_c__c = i.YDS_or_CM_c__c;
						ec1.OwnerId = i.OwnerId;

						ec1.RecordTypeId = OtherRecordType;
						ec1.FirstName = i.Emergency_Contact_First__c;
						ec1.LastName = i.Emergency_Contact_Last__c;
						ec1.AccountId = c.AccountId; //Assign the Contact to the Client Household
						ec1.Phone = i.Emergency_Contact_Phone__c;	
 						ec1.MobilePhone = i.Emergency_Contact_Cell_Phone__c;
 						ec1.Intake__c = i.Id;

						othercts.add(ec1);
					}

					if(i.Emergency_Contact_2_Last__c != NULL){ //Emergency Contact 2
					Contact ec2 = new Contact();
						ec2.Role__c = 'Emergency Contact 2';

						ec2.YDS_or_CM_c__c = i.YDS_or_CM_c__c;
						ec2.OwnerId = i.OwnerId;

						ec2.RecordTypeId = OtherRecordType;
						ec2.FirstName = i.Emergency_Contact_2_First__c;
						ec2.LastName = i.Emergency_Contact_2_Last__c;
						ec2.AccountId = c.AccountId; //Assign the Contact to the Client Household
						ec2.Phone = i.Emergency_Contact_2_Phone__c;	
 						ec2.MobilePhone = i.Emergency_Contact_2_Cell_Phone__c;
 						ec2.Intake__c = i.Id;

						othercts.add(ec2);
					}

				}//End if contactmap.get(c.id) != NULL

			}//End Contact c: contacts

		}//End if !contacts.isEmpty()

		//Generate Other Contacts

		if(!othercts.isEmpty()){

			//insert othercts;

			try{

				Database.DMLOptions dml2 = new Database.DMLOptions();
				dml2.DuplicateRuleHeader.AllowSave = true; 

				Database.SaveResult[] srocts = Database.Insert(othercts,dml2); //Try  to insert the new contacts
				for(Database.SaveResult srct : srocts){ //Cycle through the Save Results
					if(srct.isSuccess() == TRUE){ //Do something if the result is a success
						octids.add(srct.getId()); //Add the new Ids to a set of Ids
					}
					else {
						// Operation failed, so get all errors                
						for(Database.Error err2 : srct.getErrors()) {
							System.debug('The following error has occurred.');                    
							System.debug(err2.getStatusCode() + ': ' + err2.getMessage());
							System.debug('Fields that affected this error: ' + err2.getFields());
							ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', err2.getMessage(),'ERROR');
						}
					}
				}
			}catch(Exception eoct){
				System.Debug('------------Error Inserting New Related Contacts from Intakes ------------'+eoct.getMessage());
				ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', eoct.getMessage(),'ERROR');
			}

			if(!octids.isEmpty()){
				othercontacts = [SELECT Id, Intake__c, Role__c, Intake_Relationship_Type__c, AccountId FROM Contact WHERE Id IN: octids];
			}

			//Generate Relationship Records
			if(!othercontacts.isEmpty()){

				for(Contact oct : othercontacts){

					rmap.put(oct.Role__c+oct.Intake__c,oct.Id);

					npe4__Relationship__c r = new npe4__Relationship__c();

						r.npe4__Contact__c =  intakemap.get(oct.Intake__c).Id; //Master-Detail(Contact)
						r.npe4__RelatedContact__c = oct.id; //Lookup(Contact)
						r.npe4__Status__c = 'Current'; //Picklist

						if(oct.Intake_Relationship_Type__c != NULL){
							r.npe4__Type__c = oct.Intake_Relationship_Type__c;
						}else{
							r.npe4__Type__c =  oct.Role__c; //Picklist - Parent, Emergency Contact, Caregiver
						}

					newrs.add(r);

				}
			}

			if(!newrs.isEmpty()){
				
				//insert newrs;

				try{

					Database.DMLOptions dml3 = new Database.DMLOptions();
					dml3.DuplicateRuleHeader.AllowSave = true; 

					Database.SaveResult[] srls = Database.Insert(newrs,dml3); //Try  to insert the new contacts
					for(Database.SaveResult srl : srls){ //Cycle through the Save Results
						if(srl.isSuccess() == TRUE){ //Do something if the result is a success
							newrlids.add(srl.getId()); //Add the new Ids to a set of Ids
						}
						else {
							// Operation failed, so get all errors                
							for(Database.Error err3 : srl.getErrors()) {
								System.debug('The following error has occurred.');                    
								System.debug(err3.getStatusCode() + ': ' + err3.getMessage());
								System.debug('Fields that affected this error: ' + err3.getFields());
								ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', err3.getMessage(),'ERROR');
							}
						}
					}
				}catch(Exception erls){
					System.Debug('------------Error Inserting New Realtionships ------------'+erls.getMessage());
					ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', erls.getMessage(),'ERROR');
				}
			}

		}

		//Update Intakes
		for(Intake__c iu : ins){

			if(intakemap != NULL && intakemap.get(iu.id) != NULL){
				iu.Client__c = intakemap.get(iu.id).id; //intakeidmap.get(iu.id); 
				iu.Household__c = intakemap.get(iu.id).AccountId; //householdmap.get(iu.id); 
			}
			
			// rmap.put(oct.Role__c+oct.Intake__c,oct.Id);
			if(rmap.get('Parent'+iu.id) != NULL){
				iu.Name_of_Primary_Parent_Guardian__c = rmap.get('Parent'+iu.id);
			}

			if(rmap.get('Caregiver'+iu.id) != NULL){
				iu.Caregiver_Parent__c = rmap.get('Caregiver'+iu.id);
			}

			if(rmap.get('Emergency Contact 1'+iu.id) != NULL){
				iu.Emergency_Contact__c = rmap.get('Emergency Contact 1'+iu.id);
			}

			if(rmap.get('Emergency Contact 2'+iu.id) != NULL){
				iu.Emergency_Contact_2__c = rmap.get('Emergency Contact 2'+iu.id);
			}

			iups.add(iu);
		}

		if(!iups.isEmpty()){ //Only do something if the list of intakes to update is not empty
			
			//upsert iups;

			try{

				Database.UpsertResult[] srs = Database.Upsert(iups,false); //Try  to upsert the Intakes
				for(Database.UpsertResult srl2 : srs){ //Cycle through the Save Results
					if(srl2.isSuccess() == TRUE){ //Do something if the result is a success
						//newrlids.add(srl.getId()); //Add the new Ids to a set of Ids
					}
					else {
						// Operation failed, so get all errors                
						for(Database.Error err4 : srl2.getErrors()) {
							System.debug('The following error has occurred.');                    
							System.debug(err4.getStatusCode() + ': ' + err4.getMessage());
							System.debug('Fields that affected this error: ' + err4.getFields());
							ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', err4.getMessage(),'ERROR');
						}
					}
				}
			}catch(Exception e){
				System.Debug('------------Error Upserting Intakes with Contact Ids ------------'+e.getMessage());
				ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', e.getMessage(),'ERROR');
			}

		}

		createCaseFromIntake(iids); //Create Cases from Intakes
		*/
	}


	//////////////// start here


	public static void createCaseFromIntake(Set<id> iids){
		/*

		List<Intake__c> iList = new List<Intake__c>(); //A List of Intakes
		List<Intake__c> iups = new List<Intake__c>(); //A List of Intakes to Update
		List<Case> cList = new List<Case>(); //A List of Cases to Create

		Map<Id,Id> casemap = new Map<Id,Id>(); //A Map of Intake Id to Case Id

		Set<Id> newcids = new Set<Id>(); //A Set of New Case Ids

		SObjectType intaketype = Schema.getGlobalDescribe().get('Intake__c');
        Map<String,Schema.SObjectField> intakeFields = intakeType.getDescribe().fields.getMap(); //A Map of Fields on Payment

        Map<Id,Id> metmap = new Map<Id,Id>(); //A map of contact Id to metric Id

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
			ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', epr.getMessage(),'ERROR');
        }


        //Create The Forms from the List of Instakes
		for(Intake__c i : iList){

				Case c = new Case(); //Create a new case

				c.ContactId = i.Client__c;
				c.AccountId = i.Household__c;
				c.Intake__c = i.id;
				c.Origin = 'Intake';
				c.Status = 'New';
				c.Priority = 'Medium';

				c.OwnerId = i.OwnerId;
				c.YD_Specialist__c = i.YDS_or_CM_c__c;

				cList.add(c); //Add the case to the list of cases to be created

		} //End for Intake__c i : ins

		if(!cList.isEmpty()){ //Only do something if the list of new cases is not empty
			
			//insert cList;

			try{
				Database.SaveResult[] srs = Database.Insert(cList,false); //Try  to insert the new cases
				for(Database.SaveResult sr : srs){ //Cycle through the Save Results
					if(sr.isSuccess() == TRUE){ //Do something if the result is a success
						newcids.add(sr.getId()); //Add the new Ids to a set of Ids
					}
					else {
						// Operation failed, so get all errors                
						for(Database.Error err2 : sr.getErrors()) {
							System.debug('The following error has occurred.');                    
							System.debug(err2.getStatusCode() + ': ' + err2.getMessage());
							System.debug('Fields that affected this error: ' + err2.getFields());
							ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', err2.getMessage(),'ERROR');
						}
					}
				}
			}catch(Exception e){
				System.Debug('------------Error Inserting Case from Intake------------'+e.getMessage());
				ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', e.getMessage(),'ERROR');
			}

		}

		
		List<Case> cases = [SELECT Id, Intake__c FROM Case WHERE Id IN: newcids]; //Select the list of newly created Cases

		if(!cases.isEmpty()){
			for(Case cs : cases){
				casemap.put(cs.Intake__c, cs.id); //Populate the map of Intake Ids to Case Ids
			}
		}

		for(Intake__c i : iList){
			i.Case__c = casemap.get(i.id); //Retrive the Case Id and set the reference on Intake
			iups.add(i);
		}

		if(!iups.isEmpty()){

			//upsert iups;

			try{
			Database.UpsertResult[] sri = Database.Upsert(iups,false); //Try and update the intakes
			}catch(Exception eiu){
				System.Debug('-------------- Error Updating Intakes ----------------'+eiu.getMessage());
				ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', eiu.getMessage(),'ERROR');
			}

		}

		createFormfromIntake(iids); //Move to Creating Forms
		*/

	}

	public static void createFormfromIntake(Set<id> iids){
		/*

		// Grab your Custom Setting values
		WSCustomAdminSettings__c settings = WSCustomAdminSettings__c.getInstance();
		String FormRecordType = settings.Form_Default_Record_Type__c;

		List<Intake__c> iList = new List<Intake__c>(); //A List of Intakes
		List<Intake__c> iups = new List<Intake__C>(); //A List of Intakes to Update
		List<Form__c> fList = new List<Form__c>(); //A List of Forms to Create

		Map<Id,Id> formmap = new Map<Id,Id>(); //A Map of Form Ids to Intake Ids

		Set<Id> newfids = new Set<Id>(); //A Set of New Form Ids

		SObjectType intaketype = Schema.getGlobalDescribe().get('Intake__c');
        Map<String,Schema.SObjectField> intakeFields = intakeType.getDescribe().fields.getMap(); //A Map of Fields on Payment

        Map<Id,Id> metmap = new Map<Id,Id>(); //A map of contact Id to metric Id

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
			ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', epr.getMessage(),'ERROR');
        }


        //Create The Forms from the List of Instakes
		for(Intake__c i : iList){

			Form__c f = new Form__c(); //Create A new Form

			f.OwnerId = i.OwnerId;
			f.YDS_or_CM_c__c = i.YDS_or_CM_c__c;


			f.Name = 'RF - '+i.Last_Name__c+', '+i.First_Name__c; //RF - [Last Name], [First Name]
			//f.RecordTypeId = FormRecordType;

			//Set Reference Field Values
			f.Referral_Source_Org__c = i.Referral_Source_Org__c;  //Lookup(Account)
			f.School__c = i.School__c;  //Lookup(Account)
			f.Caregiver_Parent__c = i.Caregiver_Parent__c;  //Lookup(Contact)
			f.Client__c = i.Client__c;  //Lookup(Contact)
			f.Referral_Source__c = i.Referral_Source__c;  //Lookup(Contact)
			f.Neighborhood__c = i.Neighborhood__c;  //Lookup(Neighborhood)
			f.Source_Intake__c = i.Id; //Lookup(Intake)
			f.Case__c = i.Case__c; //Lookup(Case)

			f.Youth_Development_Specialist__c = i.Youth_Development_Specialist__c;  //Lookup(User)

			//Set Checkbox Values
			f.Acne__c = i.Acne__c;  //Checkbox
			f.Alt_Transportation__c = i.Alt_Transportation__c;  //Checkbox
			f.Awake_Alert__c = i.Awake_Alert__c;  //Checkbox
			f.Behavior_Problems__c = i.Behavior_Problems__c;  //Checkbox
			f.Birthmarks__c = i.Birthmarks__c;  //Checkbox
			f.Bruises__c = i.Bruises__c;  //Checkbox
			f.Bullying_Perpetrator__c = i.Bullying_Perpetrator__c;  //Checkbox
			f.Bullying_Victim__c = i.Bullying_Victim__c;  //Checkbox
			f.Campus_Visit__c = i.Campus_Visit__c;  //Checkbox
			f.Career_Fair__c = i.Career_Fair__c;  //Checkbox
			f.Chores__c = i.Chores__c;  //Checkbox
			f.Close_Friends__c = i.Close_Friends__c;  //Checkbox
			f.College_Board__c = i.College_Board__c;  //Checkbox
			f.Common_Application__c = i.Common_Application__c;  //Checkbox
			f.Community_Activities__c = i.Community_Activities__c;  //Checkbox
			f.Community_Collaborative__c = i.Community_Collaborative__c;  //Checkbox
			f.Community_Service__c = i.Community_Service__c;  //Checkbox
			f.Confidentiality_Statement__c = i.Confidentiality_Statement__c;  //Checkbox
			f.Conflicts_wParents__c = i.Conflicts_wParents__c;  //Checkbox
			f.ConsentReturn_Unsupervised__c = i.ConsentReturn_Unsupervised__c;  //Checkbox
			f.Counseling__c = i.Counseling__c;  //Checkbox
			f.Curfew__c = i.Curfew__c;  //Checkbox
			f.Current_Schedule_Submittted__c = i.Current_Schedule_Submittted__c;  //Checkbox
			f.CYF_Advocate__c = i.CYF_Advocate__c;  //Checkbox
			f.December__c = i.December__c;  //Checkbox
			f.Deformities__c = i.Deformities__c;  //Checkbox
			f.Detention__c = i.Detention__c;  //Checkbox
			f.Disruptive__c = i.Disruptive__c;  //Checkbox
			f.Dressed_Appropriate__c = i.Dressed_Appropriate__c;  //Checkbox
			f.Drug_Withdrawal__c = i.Drug_Withdrawal__c;  //Checkbox
			f.Expectations__c = i.Expectations__c;  //Checkbox
			f.Expulsions__c = i.Expulsions__c;  //Checkbox
			f.Family_Handbook_Acceptance__c = i.Family_Handbook_Acceptance__c;  //Checkbox
			f.February__c = i.February__c;  //Checkbox
			f.Good_Hygiene__c = i.Good_Hygiene__c;  //Checkbox
			f.Graduated__c = i.Graduated__c;  //Checkbox
			f.Group_Expectations__c = i.Group_Expectations__c;  //Checkbox
			f.Group_Rules_Agreement__c = i.Group_Rules_Agreement__c;  //Checkbox
			f.Hyperactive__c = i.Hyperactive__c;  //Checkbox
			f.IEP__c = i.IEP__c;  //Checkbox
			f.IL_Worker__c = i.IL_Worker__c;  //Checkbox
			f.In_School__c = i.In_School__c;  //Checkbox
			f.Infestations__c = i.Infestations__c;  //Checkbox
			f.Initial__c = i.Initial__c;  //Checkbox
			f.Interests_Specialty_Group__c = i.Interests_Specialty_Group__c;  //Checkbox
			f.Interview_Skills__c = i.Interview_Skills__c;  //Checkbox
			f.Inventory_35__c = i.Inventory_35__c;  //Checkbox
			f.Inventory_68__c = i.Inventory_68__c;  //Checkbox
			f.Inventory_912__c = i.Inventory_912__c;  //Checkbox
			f.Irritability__c = i.Irritability__c;  //Checkbox
			f.Issuesw_Parents_Friends__c = i.Issuesw_Parents_Friends__c;  //Checkbox
			f.Issuesw_Siblings__c = i.Issuesw_Siblings__c;  //Checkbox
			f.JA_Biztown__c = i.JA_Biztown__c;  //Checkbox
			f.January__c = i.January__c;  //Checkbox
			f.Job_Application__c = i.Job_Application__c;  //Checkbox
			f.Learning_Disability__c = i.Learning_Disability__c;  //Checkbox
			f.Lesions__c = i.Lesions__c;  //Checkbox
			f.March__c = i.March__c;  //Checkbox
			f.Medical_Collaborative__c = i.Medical_Collaborative__c;  //Checkbox
			f.Medical_Release__c = i.Medical_Release__c;  //Checkbox
			f.Mentor_Program__c = i.Mentor_Program__c;  //Checkbox
			f.Movements_Coordinated__c = i.Movements_Coordinated__c;  //Checkbox
			f.Navience_Account__c = i.Navience_Account__c;  //Checkbox
			f.Needlemarks__c = i.Needlemarks__c;  //Checkbox
			f.No_Problems__c = i.No_Problems__c;  //Checkbox
			f.November__c = i.November__c;  //Checkbox
			f.October__c = i.October__c;  //Checkbox
			f.Out_of_C_S__c = i.Out_of_C_S__c;  //Checkbox
			f.Permission_to_Photogragh__c = i.Permission_to_Photogragh__c;  //Checkbox
			f.Personal_Wellness__c = i.Personal_Wellness__c;  //Checkbox
			f.Piercings__c = i.Piercings__c;  //Checkbox
			f.Pregnant_Parenting__c = i.Pregnant_Parenting__c;  //Checkbox
			f.PreGroup_Assessment__c = i.PreGroup_Assessment__c;  //Checkbox
			f.Problems_at_Work__c = i.Problems_at_Work__c;  //Checkbox
			f.Problems_in_School__c = i.Problems_in_School__c;  //Checkbox
			f.Problems_wGuardian__c = i.Problems_wGuardian__c;  //Checkbox
			f.PSAT_ACT__c = i.PSAT_ACT__c;  //Checkbox
			f.Quiet__c = i.Quiet__c;  //Checkbox
			f.Rash__c = i.Rash__c;  //Checkbox
			f.Received_Rewards__c = i.Received_Rewards__c;  //Checkbox
			f.Recommendation_Letter__c = i.Recommendation_Letter__c;  //Checkbox
			f.Relationship__c = i.Relationship__c;  //Checkbox
			f.Release_Info_Consent__c = i.Release_Info_Consent__c;  //Checkbox
			f.Religion_Importance__c = i.Religion_Importance__c;  //Checkbox
			f.Resume__c = i.Resume__c;  //Checkbox
			f.Rewards_Points_Policy__c = i.Rewards_Points_Policy__c;  //Checkbox
			f.Runs_Away__c = i.Runs_Away__c;  //Checkbox
			f.Sad__c = i.Sad__c;  //Checkbox
			f.SAT_Prep_Course__c = i.SAT_Prep_Course__c;  //Checkbox
			f.Scars__c = i.Scars__c;  //Checkbox
			f.Secondary__c = i.Secondary__c;  //Checkbox
			f.Securing_Housing__c = i.Securing_Housing__c;  //Checkbox
			f.Self_Advocacy__c = i.Self_Advocacy__c;  //Checkbox
			f.Serious_Relationship__c = i.Serious_Relationship__c;  //Checkbox
			f.Speech_Difficulties__c = i.Speech_Difficulties__c;  //Checkbox
			// f.Suspension__c = i.Suspension__c;  //Checkbox
			// f.Tattoos__c = i.Tattoos__c;  //Checkbox
			// f.Teacher_Peer_Interaction__c = i.Teacher_Peer_Interaction__c;  //Checkbox
			f.Television_R_V__c = i.Television_R_V__c;  //Checkbox
			f.Transportation_Consent__c = i.Transportation_Consent__c;  //Checkbox
			// f.Traumatic_Marks__c = i.Traumatic_Marks__c;  //Checkbox
			// f.Truancy__c = i.Truancy__c;  //Checkbox
			// f.Utilizing_Community__c = i.Utilizing_Community__c;  //Checkbox
			// f.Works__c = i.Works__c;  //Checkbox
			// f.X10th_Transcript_Review__c = i.X10th_Transcript_Review__c;  //Checkbox
			// f.X11th_Transcript_Review__c = i.X11th_Transcript_Review__c;  //Checkbox
			// f.Yellowish_Tent__c = i.Yellowish_Tent__c;  //Checkbox

			//Set Date Values
			f.Casey_Assessment__c = i.Casey_Assessment__c;  //Date
			f.Clothing_Inventory__c = i.Clothing_Inventory__c;  //Date
			f.D_O_B__c = i.D_O_B__c;  //Date
			f.Dental_Visit__c = i.Dental_Visit__c;  //Date
			f.Emergency_Information__c = i.Emergency_Information__c;  //Date
			f.FACE_Sheet__c = i.FACE_Sheet__c;  //Date
			f.FERPA__c = i.FERPA__c;  //Date
			f.Financial_Literacy__c = i.Financial_Literacy__c;  //Date
			f.Form_Completion_Date__c = i.Form_Completion_Date__c;  //Date
			f.Graduation_Date__c = i.Graduation_Date__c;  //Date
			f.IEP_Review__c = i.IEP_Review__c;  //Date
			f.Intake_Checklist__c = i.Intake_Checklist__c;  //Date
			f.Job_Readiness__c = i.Job_Readiness__c;  //Date
			f.Job_Shadowing__c = i.Job_Shadowing__c;  //Date
			f.Keys_Work__c = i.Keys_Work__c;  //Date
			f.Last_Physical__c = i.Last_Physical__c;  //Date
			f.Placement__c = i.Placement__c;  //Date
			f.Recent_IEP__c = i.Recent_IEP__c;  //Date
			f.Screening_Completed__c = i.Screening_Completed__c;  //Date
			// f.Transition_Activities__c = i.Transition_Activities__c;  //Date
			// f.Transition_Activity__c = i.Transition_Activity__c;  //Date

			//Set Date Time Values 
			f.Referral_Received__c = i.Referral_Received__c;  //Date/Time

			//Set Long Text Area Values
			f.About_You__c = i.About_You__c;  //Long Text Area(32768)
			f.Guardian_Issues_Detailed__c = i.Guardian_Issues_Detailed__c;  //Long Text Area(32768)
			f.Health_Safety__c = i.Health_Safety__c;  //Long Text Area(32768)
			f.Important_to_You__c = i.Important_to_You__c;  //Long Text Area(32768)
			f.Interviewer_Assessment__c = i.Interviewer_Assessment__c;  //Long Text Area(32768)
			f.Issues_Detail_other__c = i.Issues_Detail_other__c;  //Long Text Area(32768)
			f.Makes_You_Happy__c = i.Makes_You_Happy__c;  //Long Text Area(32768)
			f.Medications__c = i.Medications__c;  //Long Text Area(32768)
			f.Notes__c = i.Notes__c;  //Long Text Area(32768)
			f.Operations_Injuries__c = i.Operations_Injuries__c;  //Long Text Area(32768)
			f.Parent_Guardians_Relationship__c = i.Parent_Guardians_Relationship__c;  //Long Text Area(32768)
			f.Physical_Mental_History__c = i.Physical_Mental_History__c;  //Long Text Area(32768)
			f.Physicians_Advice__c = i.Physicians_Advice__c;  //Long Text Area(32768)
			f.School_Problems_Detailed__c = i.School_Problems_Detailed__c;  //Long Text Area(32768)
			f.Sibling_Issues_Detailed__c = i.Sibling_Issues_Detailed__c;  //Long Text Area(32768)
			f.Why_are_you_here__c = i.Why_are_you_here__c;  //Long Text Area(32768)
			// f.Work_Issues__c = i.Work_Issues__c;  //Long Text Area(32768)
			f.Worries_Upsets_You__c = i.Worries_Upsets_You__c;  //Long Text Area(32768)
			
			//Set Reference Numeric Values
			f.Caregivers_Disciplinary_Practices__c = i.Caregivers_Disciplinary_Practices__c;  //Number(18, 0)
			f.Caregivers_Expectations__c = i.Caregivers_Expectations__c;  //Number(18, 0)
			f.Caregivers_Parents_DA__c = i.Caregivers_Parents_DA__c;  //Number(18, 0)
			f.Caregivers_Parents_MH__c = i.Caregivers_Parents_MH__c;  //Number(18, 0)
			f.Caregivers_Parents_PH__c = i.Caregivers_Parents_PH__c;  //Number(18, 0)
			f.Child_Behavior__c = i.Child_Behavior__c;  //Number(18, 0)
			f.Child_Caregivers_Parents_Relationship__c = i.Child_Caregivers_Parents_Relationship__c;  //Number(18, 0)
			f.Child_Drug_Alcohol__c = i.Child_Drug_Alcohol__c;  //Number(18, 0)
			f.Child_MH__c = i.Child_MH__c;  //Number(18, 0)
			f.Child_Peer_Relationship__c = i.Child_Peer_Relationship__c;  //Number(18, 0)
			f.Child_School_Performance__c = i.Child_School_Performance__c;  //Number(18, 0)
			f.Detentions__c = i.Detentions__c;  //Number(18, 0)
			f.Environment_Housing__c = i.Environment_Housing__c;  //Number(18, 0)
			f.Environment_Income_Employment__c = i.Environment_Income_Employment__c;  //Number(18, 0)
			f.Family_Caregivers_Parents_Relationship__c = i.Family_Caregivers_Parents_Relationship__c;  //Number(18, 0)
			f.Family_Community_Support__c = i.Family_Community_Support__c;  //Number(18, 0)
			f.Family_Interactions__c = i.Family_Interactions__c;  //Number(18, 0)
			f.Family_Safety__c = i.Family_Safety__c;  //Number(18, 0)
			f.Grade__c = i.Grade__c;  //Number(18, 0)
			f.Hats__c = i.Hats__c;  //Number(18, 0)
			f.Hearing_Left__c = i.Hearing_Left__c;  //Number(18, 0)
			f.Hearing_Right__c = i.Hearing_Right__c;  //Number(18, 0)
			f.Missed_School__c = i.Missed_School__c;  //Number(18, 0)
			f.Pajamas__c = i.Pajamas__c;  //Number(18, 0)
			f.Pants__c = i.Pants__c;  //Number(18, 0)
			f.Shirts__c = i.Shirts__c;  //Number(18, 0)
			f.Shoes__c = i.Shoes__c;  //Number(18, 0)
			f.Socks__c = i.Socks__c;  //Number(18, 0)
			// f.Suspensions__c = i.Suspensions__c;  //Number(18, 0)
			// f.Undergarments__c = i.Undergarments__c;  //Number(18, 0)
			// f.Vision_Left__c = i.Vision_Left__c;  //Number(18, 0)
			// f.Vision_Right__c = i.Vision_Right__c;  //Number(18, 0)
			// f.Winter_Boots__c = i.Winter_Boots__c;  //Number(18, 0)
			// f.Winter_Coats__c = i.Winter_Coats__c;  //Number(18, 0)
			f.Insurance_Number__c = i.Insurance_Number__c;  //Number(18, 0) (Unique)
			f.Medical_Recipient_Number__c = i.Medical_Recipient_Number__c;  //Number(18, 0) (Unique)

			//Set Phone
			f.Case_Worker__c = i.Case_Worker__c;  //Phone
			f.Physician_Phone__c = i.Physician_Phone__c;  //Phone
			f.Probation_Officers__c = i.Probation_Officers__c;  //Phone

			//Set Picklist
			f.Abstraction__c = i.Abstraction__c;  //Picklist
			f.Affect__c = i.Affect__c;  //Picklist
			f.Attendance__c = i.Attendance__c;  //Picklist
			f.Attention__c = i.Attention__c;  //Picklist
			f.Attitude__c = i.Attitude__c;  //Picklist
			f.Boundaries__c = i.Boundaries__c;  //Picklist
			f.Clothing__c = i.Clothing__c;  //Picklist
			f.Community_Resources__c = i.Community_Resources__c;  //Picklist
			f.Concentration__c = i.Concentration__c;  //Picklist
			f.Coping_Ability__c = i.Coping_Ability__c;  //Picklist
			f.Cosmetic_use__c = i.Cosmetic_use__c;  //Picklist
			f.Course_Description__c = i.Course_Description__c;  //Picklist
			f.Current_DA_Concerns__c = i.Current_DA_Concerns__c;  //Picklist
			f.Current_Living_Situation__c = i.Current_Living_Situation__c;  //Picklist
			f.DA_History__c = i.DA_History__c;  //Picklist
			f.Decision_Making__c = i.Decision_Making__c;  //Picklist
			f.Defective_Memory__c = i.Defective_Memory__c;  //Picklist
			f.Developmental_Delay__c = i.Developmental_Delay__c;  //Picklist
			f.Education_Program__c = i.Education_Program__c;  //Picklist
			f.Education_Type__c = i.Education_Type__c;  //Picklist
			f.Educational_Support__c = i.Educational_Support__c;  //Picklist
			f.Eye_Contact__c = i.Eye_Contact__c;  //Picklist
			f.Facial_Expresion__c = i.Facial_Expresion__c;  //Picklist
			f.Family_Discussion__c = i.Family_Discussion__c;  //Picklist
			f.Fund_Knowledge__c = i.Fund_Knowledge__c;  //Picklist
			f.GPA__c = i.GPA__c;  //Picklist
			f.Grade_History__c = i.Grade_History__c;  //Picklist
			f.Graduation_Type__c = i.Graduation_Type__c;  //Picklist
			f.Grooming__c = i.Grooming__c;  //Picklist
			f.Hallucination__c = i.Hallucination__c;  //Picklist
			f.History_Domestic_Violence__c = i.History_Domestic_Violence__c;  //Picklist
			f.History_of_Abuse__c = i.History_of_Abuse__c;  //Picklist
			f.Household_Rules__c = i.Household_Rules__c;  //Picklist
			f.Housing__c = i.Housing__c;  //Picklist
			f.Income_Source__c = i.Income_Source__c;  //Picklist
			f.Insight__c = i.Insight__c;  //Picklist
			f.Intelligence__c = i.Intelligence__c;  //Picklist
			f.Judgment__c = i.Judgment__c;  //Picklist
			f.Math__c = i.Math__c;  //Picklist
			f.Medication_Compliance__c = i.Medication_Compliance__c;  //Picklist
			f.Mental_Health_History__c = i.Mental_Health_History__c;  //Picklist
			f.Mood__c = i.Mood__c;  //Picklist
			f.Motor_Activity__c = i.Motor_Activity__c;  //Picklist
			f.Organization__c = i.Organization__c;  //Picklist
			f.Orientation__c = i.Orientation__c;  //Picklist
			f.Permanency_Goal__c = i.Permanency_Goal__c;  //Picklist
			f.Posture__c = i.Posture__c;  //Picklist
			f.Pre_Natal_Issues__c = i.Pre_Natal_Issues__c;  //Picklist
			f.Preoccupation__c = i.Preoccupation__c;  //Picklist
			f.PSSA_Keystone__c = i.PSSA_Keystone__c;  //Picklist
			f.Race__c = i.Race__c;  //Picklist
			f.Reading__c = i.Reading__c;  //Picklist
			f.Reality_Testing__c = i.Reality_Testing__c;  //Picklist
			f.Recall__c = i.Recall__c;  //Picklist
			f.Recent_Grades__c = i.Recent_Grades__c;  //Picklist
			f.Referal_Completed__c = i.Referal_Completed__c;  //Picklist
			f.Referral_Source_Type__c = i.Referral_Source_Type__c;  //Picklist
			f.Referral_Type__c = i.Referral_Type__c;  //Picklist
			f.Reward__c = i.Reward__c;  //Picklist
			f.Service_Level__c = i.Service_Level__c;  //Picklist
			f.SES_Program__c = i.SES_Program__c;  //Picklist
			f.Sexual_Preference__c = i.Sexual_Preference__c;  //Picklist
			f.Skill_Deficits__c = i.Skill_Deficits__c;  //Picklist
			f.Social_Judgment__c = i.Social_Judgment__c;  //Picklist
			f.Social_Maturity__c = i.Social_Maturity__c;  //Picklist
			f.Speech__c = i.Speech__c;  //Picklist
			f.Stature__c = i.Stature__c;  //Picklist
			f.Stressors__c = i.Stressors__c;  //Picklist
			// f.Supports__c = i.Supports__c;  //Picklist
			// f.Target_Neighborhood__c = i.Target_Neighborhood__c;  //Picklist
			// f.Thoughts__c = i.Thoughts__c;  //Picklist
			f.Weight__c = i.Weight__c;  //Picklist
			
			//Start here
			//Set MultiSelect Picklist
			f.Abuse__c = i.Abuse__c;  //Picklist (Multi-Select)
			f.Activities__c = i.Activities__c;  //Picklist (Multi-Select)
			f.Allergies__c = i.Allergies__c;  //Picklist (Multi-Select)
			f.Behavioral_Issues__c = i.Behavioral_Issues__c;  //Picklist (Multi-Select)
			f.Family_Functioning_Level__c = i.Family_Functioning_Level__c;  //Picklist (Multi-Select)
			f.Had_illness__c = i.Had_illness__c;  //Picklist (Multi-Select)
			f.Hobbies__c = i.Hobbies__c;  //Picklist (Multi-Select)
			f.Life_Skills__c = i.Life_Skills__c;  //Picklist (Multi-Select)

			//Set Text Area
			f.Allergies_Detailed__c = i.Allergies_Detailed__c;  //Text Area(255)
			f.Behavior_Exhibited__c = i.Behavior_Exhibited__c;  //Text Area(255)
			f.Comments__c = i.Comments__c;  //Text Area(255)
			f.Counseling_Detailed__c = i.Counseling_Detailed__c;  //Text Area(255)
			f.Counseling_Detailed2__c = i.Counseling_Detailed2__c;  //Text Area(255)
			f.DA_Concerns_Detailed__c = i.DA_Concerns_Detailed__c;  //Text Area(255)
			f.Education_Concerns__c = i.Education_Concerns__c;  //Text Area(255)
			f.Education_Summary__c = i.Education_Summary__c;  //Text Area(255)
			f.Explain__c = i.Explain__c;  //Text Area(255)
			f.Friends_Detailed__c = i.Friends_Detailed__c;  //Text Area(255)
			f.Fun__c = i.Fun__c;  //Text Area(255)
			f.Goal_Summary__c = i.Goal_Summary__c;  //Text Area(255)
			f.Group_Summary__c = i.Group_Summary__c;  //Text Area(255)
			f.Health_Summary__c = i.Health_Summary__c;  //Text Area(255)
			f.Home_Summary__c = i.Home_Summary__c;  //Text Area(255)
			f.How_are_your_Grades__c = i.How_are_your_Grades__c;  //Text Area(255)
			f.illness_Detailed__c = i.illness_Detailed__c;  //Text Area(255)
			f.Limitations__c = i.Limitations__c;  //Text Area(255)
			f.Medical_Issues_other__c = i.Medical_Issues_other__c;  //Text Area(255)
			f.MH_History_Detailed__c = i.MH_History_Detailed__c;  //Text Area(255)
			f.Placements_Dates__c = i.Placements_Dates__c;  //Text Area(255)
			f.Referral_Reason__c = i.Referral_Reason__c;  //Text Area(255)
			f.Religion_Importance_Detailed__c = i.Religion_Importance_Detailed__c;  //Text Area(255)
			f.Self_Views__c = i.Self_Views__c;  //Text Area(255)
			f.Special_Needs__c = i.Special_Needs__c;  //Text Area(255)
			f.Strengths__c = i.Strengths__c;  //Text Area(255)
			f.Whom_do_you_live_with__c = i.Whom_do_you_live_with__c;  //Text Area(255)
			f.Academic_Goals__c = i.Academic_Goals__c;  //Text(255)
			f.Activity_Invovlement__c = i.Activity_Invovlement__c;  //Text(255)
			f.Additional_Information__c = i.Additional_Information__c;  //Text(255)
			f.Behavioral_Issues_other__c = i.Behavioral_Issues_other__c;  //Text(255)
			f.Care_Manager__c = i.Care_Manager__c;  //Text(255)
			f.Career_Goal__c = i.Career_Goal__c;  //Text(255)
			f.Clothing_Summary__c = i.Clothing_Summary__c;  //Text(255)
			f.Community_Suppports__c = i.Community_Suppports__c;  //Text(255)
			f.Counseling_When__c = i.Counseling_When__c;  //Text(255)
			f.Counseling_When2__c = i.Counseling_When2__c;  //Text(255)
			f.Counselor__c = i.Counselor__c;  //Text(255)
			f.Counselor_2__c = i.Counselor_2__c;  //Text(255)
			f.Custodianship__c = i.Custodianship__c;  //Text(255)
			f.CYF_Case_Worker__c = i.CYF_Case_Worker__c;  //Text(255)
			f.DA_Pregnancy__c = i.DA_Pregnancy__c;  //Text(255)
			f.Diagnosis__c = i.Diagnosis__c;  //Text(255)
			f.Dismissal__c = i.Dismissal__c;  //Text(255)
			f.Family_Supports__c = i.Family_Supports__c;  //Text(255)
			f.Gynecological_Exam__c = i.Gynecological_Exam__c;  //Text(255)
			f.Insurance_Carrier__c = i.Insurance_Carrier__c;  //Text(255)
			f.Issues_Concerns__c = i.Issues_Concerns__c;  //Text(255)
			f.Juvenile_Probation__c = i.Juvenile_Probation__c;  //Text(255)
			f.Other_Items__c = i.Other_Items__c;  //Text(255)
			f.Parenting__c = i.Parenting__c;  //Text(255)
			f.Physician_Facility__c = i.Physician_Facility__c;  //Text(255)
			f.Physician_Name__c = i.Physician_Name__c;  //Text(255)
			f.Pregnancy_Term__c = i.Pregnancy_Term__c;  //Text(255)
			f.Referral_Source_Relationship__c = i.Referral_Source_Relationship__c;  //Text(255)
			f.Religion__c = i.Religion__c;  //Text(255)
			f.Repeated_Grade__c = i.Repeated_Grade__c;  //Text(255)
			f.Sexual_Abuse__c = i.Sexual_Abuse__c;  //Text(255)
			f.Subject_Excelling__c = i.Subject_Excelling__c;  //Text(255)
			f.Subject_Needs_Help__c = i.Subject_Needs_Help__c;  //Text(255)
			f.Supervisor__c = i.Supervisor__c;  //Text(255)
			// f.Talents_Skills__c = i.Talents_Skills__c;  //Text(255)
			// f.Voluntary_Service__c = i.Voluntary_Service__c;  //Text(255)

			flist.add(f);

		}//End For Intake i : iList

		if(!flist.isEmpty()){

			//insert flist;

			try{

				Database.SaveResult[] srs = Database.Insert(flist,false); //Try  to insert the new Forms
				for(Database.SaveResult sr : srs){ //Cycle through the Save Results
					if(sr.isSuccess() == TRUE){ //Do something if the result is a success
						newfids.add(sr.getId()); //Add the new Ids to a set of Ids
					}
					else {
						// Operation failed, so get all errors                
						for(Database.Error err2 : sr.getErrors()) {
							System.debug('The following error has occurred.');                    
							System.debug(err2.getStatusCode() + ': ' + err2.getMessage());
							System.debug('Fields that affected this error: ' + err2.getFields());
							ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', err2.getMessage(),'ERROR');
						}
					}
				}
			}catch(Exception efi){
				system.debug('************************ Error Inserting New Forms ************************' + efi.getMessage());
				ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', efi.getMessage(),'ERROR');
			}


		}//End !flist.isEmpty()

		List<Form__c> forms = [SELECT Id, Source_Intake__c FROM Form__c WHERE Id IN: newfids]; //Select the list of newly created Cases

		if(!forms.isEmpty()){
			for(Form__c fr : forms){
				formmap.put(fr.Source_Intake__c, fr.id); //Populate the map of Form Ids to Intake Ids
			}
		}

		for(Intake__c i : iList){
			i.Source_Registration_Form__c = formmap.get(i.id); //Retrive the Case Id and set the reference on Intake
			iups.add(i);
		}

		if(!iups.isEmpty()){

			//upsert iups;

			try{
			Database.UpsertResult[] sri = Database.Upsert(iups,false); //Try and update the intakes
			}catch(Exception eiu){
				System.Debug('-------------- Error Updating Intakes ----------------'+eiu.getMessage());
				ProcessLogHandler.insertLog('N/A', 'N/A','WSIntakeTools.createContactfromIntake', eiu.getMessage(),'ERROR');
			}
			*/
		}
		

	}