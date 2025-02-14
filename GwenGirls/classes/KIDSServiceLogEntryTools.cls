/**********************************************************************
* Name:     KIDSServiceLogEntryTools
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     19 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* KIDSServiceLog Tools - class with related methods for operating on KIDS Service Logs
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       19 Dec 2016     TGM         Initial Development
***********************************************************************/
public class KIDSServiceLogEntryTools{

	public Map<String,Double> getContactType(){

		Map<String,Double> themap = new Map<String,Double>();
		List<KIDS_Contact_Type_meta__mdt> l = new List<KIDS_Contact_Type_meta__mdt>();

		l = [SELECT Id__c, Value__c FROM KIDS_Contact_Type_meta__mdt];

		for(KIDS_Contact_Type_meta__mdt md : l){

			themap.put(md.Value__c,md.Id__c);
		}

		return themap;

	}
	/*
	public Map<Integer,String> getErrorMessages(){

		Map<Integer,String> themap = new Map<Integer,String>();
		List<KIDS_Error_Messages__mdt> l = new List<KIDS_Error_Messages__mdt>();

		l = [SELECT Error_Code__c, Error_Code_Description__c FROM KIDS_Error_Messages__mdt];

		for(KIDS_Error_Messages__mdt md : l){

			themap.put(Integer.valueOf(md.Error_Code__c),md.Error_Code_Description__c);
		}

		return themap;

	}
	*/

	public Map<String,Double> getUnitType(){

		Map<String,Double> themap = new Map<String,Double>();
		List<KIDS_Unit_Type_meta__mdt> l = new List<KIDS_Unit_Type_meta__mdt>();

		l = [SELECT Id__c, Value__c FROM KIDS_Unit_Type_meta__mdt];

		for(KIDS_Unit_Type_meta__mdt md : l){

			themap.put(md.Value__c,md.Id__c);
		}

		return themap;

	}

	public Map<String,Double> getServiceStructure(){

		Map<String,Double> themap = new Map<String,Double>();
		List<KIDS_Service_Structure_meta__mdt> l = new List<KIDS_Service_Structure_meta__mdt>();

		l = [SELECT Id__c, Value__c FROM KIDS_Service_Structure_meta__mdt];

		for(KIDS_Service_Structure_meta__mdt md : l){

			themap.put(md.Value__c,md.Id__c);
		}

		return themap;

	}

	public Id getCurrentServiceLog(String thetype){

		RecordType RecType = [Select Id From RecordType  Where SobjectType = 'KIDS_Service_Log__c' and DeveloperName =: thetype];

		String thetypeid = RecType.Id;

		KIDS_Service_Log__c todayslog = new KIDS_Service_Log__c();

		LIST<KIDS_Service_Log__c> todayslogs = [SELECT Id, RecordTypeName__c, Report_Date__c, Status__c FROM KIDS_Service_Log__c WHERE Report_Date__c = TODAY AND Status__c = 'Open' AND RecordTypeName__c =: thetype];

		if(!todayslogs.isEmpty()){

			todayslog = todayslogs[0];
		}

		if(todayslogs.isEmpty()){

			KIDS_Service_Log__c newlog = new KIDS_Service_Log__c();

			newlog.Report_Date__c = date.Today();
			newlog.Status__c = 'Open';
			newlog.Name = string.ValueOf(date.Today());
			newlog.RecordTypeId = thetypeid;

			insert newlog;

			todayslog = newlog;

		}

		return todayslog.Id;

	}

	public void createServiceLogEntry(Set<Id> csids){

		// Grab your Custom Setting values
		KIDSSettings__c settings = KIDSSettings__c.getInstance();
		String appworker = settings.Default_Approving_Worker_Record_Id__c;
		String reqworker = settings.Default_Requesting_Worker_Record_Id__c;

		//KIDS_Service_Log_Entry__c
		RecordType ASRecType = [Select Id From RecordType  Where SobjectType = 'KIDS_Service_Log_Entry__c' and DeveloperName = 'After_School'];
		RecordType GHRecType = [Select Id From RecordType  Where SobjectType = 'KIDS_Service_Log_Entry__c' and DeveloperName = 'Group_Home'];
		String astypeid = ASRecType.Id;
		String ghtypeid = GHRecType.Id;


		Integer asi = 1; //Integer index to specify row number
		Integer ghi = 1;
		
		//Get the Current Service Log ID and Size NEED THIS FOR GROUP HOME AND AFTER SCHOOL AS MAPS?
		Integer ASlogsize;
		Integer GHLogsize;

		Id ASservicelogId = getCurrentServiceLog('After_School');
		Id GHServicelogId = getCurrentServiceLog('Group_Home');

		List<KIDS_Service_Log_Entry__c> ASlents = [SELECT Id, Row_ID__c, KIDS_Service_Log__c FROM KIDS_Service_Log_Entry__c WHERE KIDS_Service_Log__c =: ASservicelogId];
		List<KIDS_Service_Log_Entry__c> GHlents = [SELECT Id, Row_ID__c, KIDS_Service_Log__c FROM KIDS_Service_Log_Entry__c WHERE KIDS_Service_Log__c =: GHServicelogId];

		if(!ASlents.isEmpty()){
			ASlogsize = ASlents.size();
		}else{
			ASlogsize = 0;
		}

		if(!GHlents.isEmpty()){
			GHlogsize = GHlents.size();
		}else{
			GHlogsize = 0;
		}

		Map<Id,Integer> GHrowmap = new Map<Id,Integer>(); //Map of Contact Summary Id to its Row Id
		Map<Id,Integer> ASrowmap = new Map<Id,Integer>(); //Map of Contact Summary Id to its Row Id

		Map<String,Double> ContactTypeMap = new Map<String,Double>();
		Map<String,Double> UnitTypeMap = new Map<String,Double>();
		Map<String,Double> ServiceStructureMap = new Map<String,Double>();

		ContactTypeMap = getContactType();
		UnitTypeMap = getUnitType();
		ServiceStructureMap = getServiceStructure();

		List<Contact_Summary__c> sums = new List<Contact_Summary__c>(); //A List of Contact Summaries

		List<KIDS_Service_Log_Entry__c> entries = new List<KIDS_Service_Log_Entry__c>(); //A List of Service Log Entries
		List<KIDS_Service_Log_Entry__c> newentries = new List<KIDS_Service_Log_Entry__c>(); //A List of Service Log Entries

		Set<Id> eids = new Set<Id>(); //A Set of Service Log Entry Ids

		//Create A Query String for KIDS Service Log Entries
		SObjectType entrytype = Schema.getGlobalDescribe().get('KIDS_Service_Log_Entry__c');
        Map<String,Schema.SObjectField> entryfields = entrytype.getDescribe().fields.getMap(); //A Map of Fields

        string entryselect = 'Select ';

        for(string pd : entryfields.keyset()){
            entryselect = entryselect + entryfields.get(pd) + ', ';
        }
        entryselect = entryselect.substring(0,entryselect.length()-2);
        entryselect = entryselect + '';
        entryselect = entryselect + ' FROM KIDS_Service_Log_Entry__c WHERE Id IN: eids ORDER BY Row_ID__c ASC';

        //Create A Query String for Contact Summaries
        SObjectType summarytype = Schema.getGlobalDescribe().get('Contact_Summary__c');
        Map<String,Schema.SObjectField> summaryfields = summarytype.getDescribe().fields.getMap(); //A Map of Fields

        string summaryselect = 'Select ';

        for(string pd : summaryfields.keyset()){
            summaryselect = summaryselect + summaryfields.get(pd) + ', ';
        }
        summaryselect = summaryselect.substring(0,summaryselect.length()-2);
        summaryselect = summaryselect + '';
        summaryselect = summaryselect + ' FROM Contact_Summary__c WHERE Id IN: csids ORDER BY Date_Time_Started_NEW__c ASC';

        //Query the Contact Summaries
        //try{
            sums = (Contact_Summary__c[])Database.query(summaryselect); //The list of Contact Summaries
        //}catch(Exception esums){
            //system.debug('***********************ERROR Querying Contact Summaries ***********************' + esums.getMessage());
        //}

        if(!sums.isEmpty()){

        	for(Contact_Summary__c si : sums){

        		if(si.RecordTypeName__c == 'After_School'){
						ASrowmap.put(si.Id,asi);
						asi++;
        		}else if(si.RecordTypeName__c == 'Group_Home'){
        				GHrowmap.put(si.Id,ghi);
        				ghi++;
        		}
        		
        	}

        	for(Contact_Summary__c sum : sums){

        		if(sum.KIDS_Service_Log_Summaries__c == NULL){ //Only do something with the Contact Summary if it is NOT from a Log Summary

	        		
	        		KIDS_Service_Log_Entry__c entry = new KIDS_Service_Log_Entry__c();

	        		
	        		if(sum.RecordTypeName__c == 'Group_Home'){
	        			
	        			entry.KIDS_Service_Log__c = GHservicelogId; //Use the Current Group Home Log
						entry.Row_ID__c = GHrowmap.get(sum.Id)+GHlogsize; //Set Row Id To Next Row in Log using the relative row map and current log size
						entry.RecordTypeId =ghtypeid;

	        		}else if(sum.RecordTypeName__c == 'After_School'){

	        			entry.KIDS_Service_Log__c = ASservicelogId; //Use the Current After School Log
						entry.Row_ID__c = ASrowmap.get(sum.Id)+ASlogsize; //Set Row Id To Next Row in Log using the relative row map and current log size
						entry.RecordTypeId = astypeid;

	        		}


					if(sum.Id != NULL){entry.Contact_Summary__c = sum.Id;}//Set the reference to the Parent Contact Summary
					
					if(sum.Active_Service_Episode_ID__c != NULL){entry.Service_Episode_ID__c = Integer.valueOf(sum.Active_Service_Episode_ID__c);}//The Active Service Episode ID for the Client

					if(sum.Name != NULL){entry.Name = sum.Name;} //Calculate Name

					String sso = String.valueOf(sum.Service_Structure__c);
	        		String ss = ((sso.remove(' ')).remove('/')).remove('|'); //.remove.('/').remove('|');

					if(sum.Client_ID__c != NULL){entry.Target_Client_ID__c = Integer.valueof(sum.Client_ID__c.trim());} //Double.valueOf(sum.Client_ID__c).longValue(); //Get Client Id from Child Record on Contact Summary
					if(sum.Program_ID__c != NULL){entry.Program_ID__c = Integer.valueof(sum.Program_ID__c.trim());} //DHS will provide an extract which will include the list of programs which are unique for a particular provider.
					if(sum.Facility_ID__c != NULL){entry.Facility_ID__c = Integer.valueof(sum.Facility_ID__c.trim());} //Double.valueOf(sum.Facility_ID__c).longValue(); //Get Facility Id from Facility Record
					
					if(sum.Requesting_Worker_ID__c != NULL){entry.Requesting_Worker__c = sum.Requesting_Worker_ID__c;} //Get Worker Id from Contact Summary
					if(sum.Approving_Worker_ID__c != NULL){entry.Approving_Worker__c = sum.Approving_Worker_ID__c;} //Get Worker Id from Contact Summary

					if(sum.Date__c != NULL){entry.Service_Rendered_Date__c = sum.Date__c;} //Set date from Contact Summary Date
					if(sum.Date_Time_Started_NEW__c != NULL){entry.Service_Start_Time__c = sum.Date_Time_Started_NEW__c;} //Set Start Time from Contact Summary
					if(sum.Date_Time_Ended__c != NULL){entry.Service_End_Time__c = sum.Date_Time_Ended__c;} //Set End Time from Contact Summary

					//entry.Service_Episode_ID__c = 1; //All Active non placement service episode ID's are available in the <Active Service Episodes> extract

					if(sum.Units_Completed__c != NULL){entry.Unit__c = sum.Units_Completed__c;} //Set Unit from Contact Summary
					
					if(sum.Units_Type__c != NULL){entry.Unit_Type__c = UnitTypeMap.get(sum.Units_Type__c);} //Get Unit Type from Map
					if(ServiceStructureMap.get(ss) != NULL){entry.Service_Structure_ID__c = ServiceStructureMap.get(ss);} //Get Service Structure from Map
					if(sum.ContactType__c != NULL){entry.Contact_Type__c = ContactTypeMap.get(sum.ContactType__c);} //Get Contact Type from Map

					if(sum.Activity__c != NULL){entry.Activity__c = sum.Activity__c;} //Get the Activity Text from the Contact Summary
					if(sum.Comments__c != NULL){entry.Comments__c = sum.Comments__c;} //Get the Comments Text from the Contact Summary

					entries.add(entry);

				}//END if sum.KIDS_Service_Log_Summaries__c == NULL

        	}//End for Contact_Summary__c sum :sums

        }//End if !sums.isEmpty()

        if(!entries.isEmpty()){

        	insert entries;

        	//try{
				//Database.SaveResult[] sres = Database.Insert(entries,false); //Try  to insert the new contacts
				//for(Database.SaveResult sre : sres){ //Cycle through the Save Results
					//if(sre.isSuccess() == TRUE){ //Do something if the result is a success
						//eids.add(sre.getId()); //Add the new Ids to a set of Ids
					//}
				//}
			//}catch(Exception e){
			//	System.Debug('------------Error Inserting New Contacts from Intakes ------------'+e.getMessage());
			//}

        }//End !entries.isEmpty()

        if(!eids.isEmpty()){
		    //Query the KIDS Service Log Entries
		    //try{
		        newentries = (KIDS_Service_Log_Entry__c[])Database.query(entryselect); //The list of KIDS Service Log Entries
		    //}catch(Exception eks){
		        //system.debug('***********************ERROR Querying KIDS Service Log Entries ***********************' + eks.getMessage());
		    //}
        }

	}//End createServiceLogEntry

	public void syncSummaryStatus(Set<Id> eids){

		List<KIDS_Service_Log_Entry__c> entries = new List<KIDS_Service_Log_Entry__c>(); //A List of Entries
		List<Contact_Summary__c> summaries = new List<Contact_Summary__c>(); //A List of Contact Summaries
		List<Contact_Summary__c> sumups = new List<Contact_Summary__c>(); //A List of Contact Summaries

		Map<Id,String> valuemap = new Map<Id,String>(); //A Map of Id to String

		Set<Id> csids = new Set<Id>(); //A Set of Contact Summary Ids
		Set<Id> usids = new Set<Id>(); //A Set of Updated Contact Summary Ids

		//Create A Query String for KIDS Service Log Entries
        SObjectType entrytype = Schema.getGlobalDescribe().get('KIDS_Service_Log_Entry__c');
        Map<String,Schema.SObjectField> entryfields = entrytype.getDescribe().fields.getMap(); //A Map of Fields

        string entryselect = 'Select ';

        for(string pd : entryfields.keyset()){
            entryselect = entryselect + entryfields.get(pd) + ', ';
        }
        entryselect = entryselect.substring(0,entryselect.length()-2);
        entryselect = entryselect + '';
        entryselect = entryselect + ' FROM KIDS_Service_Log_Entry__c WHERE Id IN: eids ORDER BY Row_ID__c ASC';

        try{
            entries = (KIDS_Service_Log_Entry__c[])Database.query(entryselect); //The list of KIDS Service Log Entries
        }catch(Exception eks){
            system.debug('***********************ERROR Querying KIDS Service Log Entries ***********************' + eks.getMessage());
        }

        if(!entries.isEmpty()){

        	for(KIDS_Service_Log_Entry__c ksle : entries){
        		csids.add(ksle.Contact_Summary__c);
        		valuemap.put(ksle.Contact_Summary__c,ksle.Status__c);
        	}

        }

		//Create A Query String for Contact Summaries
        SObjectType summarytype = Schema.getGlobalDescribe().get('Contact_Summary__c');
        Map<String,Schema.SObjectField> summaryfields = summarytype.getDescribe().fields.getMap(); //A Map of Fields

        string summaryselect = 'Select ';

        for(string pd : summaryfields.keyset()){
            summaryselect = summaryselect + summaryfields.get(pd) + ', ';
        }
        summaryselect = summaryselect.substring(0,summaryselect.length()-2);
        summaryselect = summaryselect + '';
        summaryselect = summaryselect + ' FROM Contact_Summary__c WHERE Id IN: csids ORDER BY Date_Time_Started_NEW__c ASC';

        //Query the Contact Summaries
        try{
            summaries = (Contact_Summary__c[])Database.query(summaryselect); //The list of Contact Summaries
        }catch(Exception esums){
            //system.debug('***********************ERROR Querying Contact Summaries ***********************' + esums.getMessage());
        }

        for(Contact_Summary__c sum : summaries){
        	sum.Status__c = valuemap.get(sum.Id);
        	sumups.add(sum);
        }

        if(!sumups.isEmpty()){

        	try{
				Database.UpsertResult[] ures = Database.Upsert(sumups,false); //Try  to insert the new contacts
				for(Database.UpsertResult ure : ures){ //Cycle through the Save Results
					if(ure.isSuccess() == TRUE){ //Do something if the result is a success
						usids.add(ure.getId()); //Add the new Ids to a set of Ids
					}
				}
			}catch(Exception e){
				System.Debug('------------Error Inserting New Contacts from Intakes ------------'+e.getMessage());
			}

        }

	}

	public void updateServiceLogEntry(Set<Id> csids){

		Map<String,Double> ContactTypeMap = new Map<String,Double>();
		Map<String,Double> UnitTypeMap = new Map<String,Double>();
		Map<String,Double> ServiceStructureMap = new Map<String,Double>();

		ContactTypeMap = getContactType();
		UnitTypeMap = getUnitType();
		ServiceStructureMap = getServiceStructure();

		List<Contact_Summary__c> sums = new List<Contact_Summary__c>();
		List<KIDS_Service_Log_Entry__c> entries = new List<KIDS_Service_Log_Entry__c>();
		List<KIDS_Service_Log_Entry__c> eups = new List<KIDS_Service_Log_Entry__c>();

		Set<Id> eids = new Set<Id>();
		Map<Id,KIDS_Service_Log_Entry__c> emap = new Map<Id,KIDS_Service_Log_Entry__c>();

		//Create A Query String for KIDS Service Log Entries
		SObjectType entrytype = Schema.getGlobalDescribe().get('KIDS_Service_Log_Entry__c');
        Map<String,Schema.SObjectField> entryfields = entrytype.getDescribe().fields.getMap(); //A Map of Fields

        string entryselect = 'Select ';

        for(string pd : entryfields.keyset()){
            entryselect = entryselect + entryfields.get(pd) + ', ';
        }
        entryselect = entryselect.substring(0,entryselect.length()-2);
        entryselect = entryselect + '';
        entryselect = entryselect + ' FROM KIDS_Service_Log_Entry__c WHERE Contact_Summary__c IN: csids';

        //Query the KIDS Service Log Entries
        //try{
            entries = (KIDS_Service_Log_Entry__c[])Database.query(entryselect); //The list of Contact Summaries
        //}catch(Exception esums){
            //system.debug('***********************ERROR Querying Contact Summaries ***********************' + esums.getMessage());
        //}

        if(!entries.isEmpty()){

        	for(KIDS_Service_Log_Entry__c e : entries){

        		emap.put(e.Contact_Summary__c, e);

        	}//End e : entries

        }//End !entries.isEmpty()


        //Create A Query String for Contact Summaries
        SObjectType summarytype = Schema.getGlobalDescribe().get('Contact_Summary__c');
        Map<String,Schema.SObjectField> summaryfields = summarytype.getDescribe().fields.getMap(); //A Map of Fields

        string summaryselect = 'Select ';

        for(string pd : summaryfields.keyset()){
            summaryselect = summaryselect + summaryfields.get(pd) + ', ';
        }
        summaryselect = summaryselect.substring(0,summaryselect.length()-2);
        summaryselect = summaryselect + '';
        summaryselect = summaryselect + ' FROM Contact_Summary__c WHERE Id IN: csids ORDER BY Date_Time_Started_NEW__c ASC';

        //Query the Contact Summaries
       //try{
            sums = (Contact_Summary__c[])Database.query(summaryselect); //The list of Contact Summaries
        //}catch(Exception esums){
            //system.debug('***********************ERROR Querying Contact Summaries ***********************' + esums.getMessage());
        //}

        if(!sums.isEmpty()){

        	for(Contact_Summary__c sum : sums){

	        	Boolean U = FALSE;

	        	KIDS_Service_Log_Entry__c entry = new KIDS_Service_Log_Entry__c();
	        	entry = emap.get(sum.id);

	        	if(emap.get(sum.id) != NULL && entry.Status__c == 'OpenNotYetSubmittedToKIDS'){

	        		String sso = String.valueOf(sum.Service_Structure__c);
	        		String ss = ((sso.remove(' ')).remove('/')).remove('|'); //.remove.('/').remove('|');

					if(entry.Target_Client_ID__c != Integer.valueof(sum.Client_ID__c.trim()) ){ entry.Target_Client_ID__c = Integer.valueof(sum.Client_ID__c.trim()); U=TRUE;}
					if(entry.Program_ID__c != Integer.valueof(sum.Program_ID__c.trim()) ){ entry.Program_ID__c = Integer.valueof(sum.Program_ID__c.trim()); U=TRUE;}
					if(entry.Facility_ID__c != Integer.valueof(sum.Facility_ID__c.trim()) ){ entry.Facility_ID__c = Integer.valueof(sum.Facility_ID__c.trim()); U=TRUE;}

					if(entry.Requesting_Worker__c != sum.Requesting_Worker_ID__c ){ entry.Requesting_Worker__c = sum.Requesting_Worker_ID__c; U=TRUE;}
					if(entry.Approving_Worker__c != sum.Approving_Worker_ID__c ){ entry.Approving_Worker__c = sum.Approving_Worker_ID__c; U=TRUE;}

					if(entry.Service_Rendered_Date__c != sum.Date__c ){ entry.Service_Rendered_Date__c = sum.Date__c; U=TRUE;}
					if(entry.Service_Start_Time__c != sum.Date_Time_Started_NEW__c ){ entry.Service_Start_Time__c = sum.Date_Time_Started_NEW__c; U=TRUE;}
					if(entry.Service_End_Time__c != sum.Date_Time_Ended__c ){ entry.Service_End_Time__c = sum.Date_Time_Ended__c; U=TRUE;}

					if(entry.Unit__c != sum.Units_Completed__c ){ entry.Unit__c = sum.Units_Completed__c; U=TRUE;}

					if(entry.Unit_Type__c != UnitTypeMap.get(sum.Units_Type__c) ){ entry.Unit_Type__c = UnitTypeMap.get(sum.Units_Type__c); U=TRUE;}
					if(entry.Service_Structure_ID__c != ServiceStructureMap.get(ss) ){ entry.Service_Structure_ID__c = ServiceStructureMap.get(ss); U=TRUE;}
					if(entry.Contact_Type__c != ContactTypeMap.get(sum.ContactType__c) ){ entry.Contact_Type__c = ContactTypeMap.get(sum.ContactType__c); U=TRUE;}

					if(entry.Activity__c != sum.Activity__c ){ entry.Activity__c = sum.Activity__c; U=TRUE;}
					if(entry.Comments__c != sum.Comments__c ){ entry.Comments__c = sum.Comments__c; U=TRUE;}

					if(U == TRUE){
						eups.add(entry);
					}//End u == TRUE

				}//End if entry == NULL

        	}//End for Contact_Summary__c sum :sums

        }//End if !sums.isEmpty()

        if(!eups.isEmpty()){

        	update entries;

        	/*try{
				Database.UpsertResult[] urs = Database.Upsert(eups,false); //Try  to insert the new contacts
				for(Database.UpsertResult ur : urs){ //Cycle through the Save Results
					if(ur.isSuccess() == TRUE){ //Do something if the result is a success
						eids.add(ur.getId()); //Add the new Ids to a set of Ids
					}
				}
			}catch(Exception e){
				System.Debug('------------Error Updating KIDS Service Log Entires from Contact Summary Change ------------'+e.getMessage());
			}*/

        }//End !entries.isEmpty()
	}

	/*
	public void processErrorMessages(Set<Id> eids){

		Map<Integer,String> errormap = new Map<Integer,String>();
		errormap = getErrorMessages();

		List<KIDS_Service_Log_Entry__c> entries = new List<KIDS_Service_Log_Entry__c>();
		List<KIDS_Service_Log_Entry__c> eups = new List<KIDS_Service_Log_Entry__c>();

		Set<Id> euids = new Set<Id>();

		entries = [SELECT Id, KIDS_Error_Code__c, KIDS_Error_Message__c, Status__c FROM KIDS_Service_Log_Entry__c WHERE Id IN: eids];

		for(KIDS_Service_Log_Entry__c e : entries){

				if(e.KIDS_Error_Code__c != NULL){

					String message;

					if(errormap.get(Integer.valueOf(e.KIDS_Error_Code__c)) != NULL){
						 message = errormap.get(Integer.valueOf(e.KIDS_Error_Code__c));
					}else{
						message = 'Error Code Not Recognized - Please Check Code or Contact KIDS';
					}

					if(e.KIDS_Error_Message__c !=  message){

						if(e.KIDS_Error_Code__c == '9999' ){
								e.Status__c = 'AcceptedKIDSServiceLogLocked';
						}

						if(e.KIDS_Error_Code__c != '9999' && e.KIDS_Error_Code__c != NULL){
								e.Status__c = 'Error - Rejected by KIDS';
						}
						
						e.KIDS_Error_Message__c = message;
						eups.add(e);
					}

				}

		}//End if Error Code != NULL

			if(!eups.isEmpty()){
				try{
					Database.UpsertResult[] urs = Database.Upsert(eups,false); //Try  to insert the new contacts
					for(Database.UpsertResult ur : urs){ //Cycle through the Save Results
						if(ur.isSuccess() == TRUE){ //Do something if the result is a success
							euids.add(ur.getId()); //Add the new Ids to a set of Ids
						}
					}
				}catch(Exception eup){
					System.Debug('------------Error Updating KIDS Service Log Entires with Error Messages ------------'+eup.getMessage());
				}
			}

			//syncSummaryStatus(eids);
	}
	*/
	
}