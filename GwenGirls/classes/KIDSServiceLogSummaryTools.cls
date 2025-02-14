/**********************************************************************
* Name:     KIDSServiceLogSummaryTools
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     05 May 2017
* ======================================================
* ======================================================
* Purpose:                                                            
* KIDSServiceLogSummary Tools - class with related methods for operating on KIDS Service Log Summaries
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       05 May 2017     TGM         Initial Development
***********************************************************************/
public class KIDSServiceLogSummaryTools{

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

	public Id getCurrentServiceLog(){

		KIDS_Service_Log__c todayslog = new KIDS_Service_Log__c();

		LIST<KIDS_Service_Log__c> todayslogs = [SELECT Id, Report_Date__c, Status__c FROM KIDS_Service_Log__c WHERE Report_Date__c = TODAY AND Status__c = 'Open'];

		if(!todayslogs.isEmpty()){

			todayslog = todayslogs[0];
		}

		if(todayslogs.isEmpty()){

			KIDS_Service_Log__c newlog = new KIDS_Service_Log__c();

			newlog.Report_Date__c = date.Today();
			newlog.Status__c = 'Open';
			newlog.Name = string.ValueOf(date.Today());

			insert newlog;

			todayslog = newlog;

		}

		return todayslog.Id;

	}

	public static KIDSSettings__c thesettings;

    public KIDSSettings__c getSettings(){

        KIDSSettings__c settings = KIDSSettings__c.getInstance();

        if(thesettings == NULL){
            
            thesettings = settings;
            return thesettings;

        }else{
            return thesettings;
        }

    }

    public void attachtoLog(List<KIDS_Service_Log_Summaries__c> thesums){

    	System.Debug('******* attachtoLog thesums.size() = ' + thesums.size() + ' ********');

        KIDSSettings__c kidssettings = new KIDSSettings__c();
        kidssettings = getSettings(); //Get the KIDS Default Settings

    	String logid;

    	logid = NULL;

    	Date maxdate  = date.today();
    	Date mindate = date.today();

    	Integer imaxdate;
    	Integer imindate;

		Date basedate;
		basedate = Date.newInstance(1970,1,1);

		Integer offset = Integer.valueOf(kidssettings.Date_Calculation_Offset__c);

		if(offset == NULL){
			offset = 25569;
		}

    	for(KIDS_Service_Log_Summaries__c sum : thesums){

    		if(sum.SRVC_DT__c != NULL && sum.SRVC_DT__c != ''){

				String sdays;
				sdays  = sum.SRVC_DT__c.left(6).trim();

				Integer days;
				days = Integer.valueOf(sdays);

				System.Debug('******* SDAYS: ' + sdays + ' *******');
				System.Debug('******* DAYS: ' + days + ' *******');

				//Set the Max Date
				if(imaxdate == NULL || imaxdate<days){
					if(days == NULL){
						days = 0;
					}

					imaxdate = days;
					maxdate = Date.newInstance(1970,1,1).addDays(imaxdate-offset+1462);
				}

				//Set the Min Date
				if(imindate == NULL || imindate>days){
					if(days == NULL){
						days = 0;
					}

					imindate = days;
					mindate = Date.newInstance(1970,1,1).addDays(imindate-offset+1462);
		    	}

    		}

    	}

    	KIDS_Service_Log__c thelog = new KIDS_Service_Log__c(); //A New Log To Attach The Summaries To

    	thelog.name = 'From Log Summaries: ' + 
    	String.valueOf(mindate.month()) + '/' + String.valueOf(mindate.day()) + '/' + String.valueOf(mindate.year()) + ' to ' +
    	String.valueOf(maxdate.month()) + '/' + String.valueOf(maxdate.day()) + '/' + String.valueOf(maxdate.year());

    	thelog.Report_Date__c = maxdate;
    	thelog.Status__c = 'Open'; //Intially Set To Open - Updated After All Records Are Processed

    	try{
    		insert thelog;
    		logid = thelog.id;
    	}catch(Exception le){
    		System.Debug('******** Error Inserting New Log for Service Log Summaries *******' + le.getMessage());
    	}

    	if(logid != NULL){//Update the Service Log Summaries with the Log Id if the log was created successfully

    		for(KIDS_Service_Log_Summaries__c s : thesums){

    			s.KIDS_Service_Log__c = logid;
    		}

    	}

    }

	public void createContactSummaries(Set<Id> sumids){//Uses the set of Summary Ids

		KIDSSettings__c kidssettings = new KIDSSettings__c();
		kidssettings = getSettings(); //Get the KIDS Default Settings

		Map<String,Double> ContactTypeMap = new Map<String,Double>();
		Map<String,Double> UnitTypeMap = new Map<String,Double>();
		Map<String,Double> ServiceStructureMap = new Map<String,Double>();

		ContactTypeMap = getContactType();
		UnitTypeMap = getUnitType();
		ServiceStructureMap = getServiceStructure();
		
		List<KIDS_Service_Log_Summaries__c> allsums = new List<KIDS_Service_Log_Summaries__c>();
		List<KIDS_Service_Log_Summaries__c> slsums = new List<KIDS_Service_Log_Summaries__c>(); //A List of Service Log Summaries
		List<Contact> clients = new List<Contact>(); //A List of Clients
		Set<String> clientids = new Set<String>(); //A Set of Client Ids as Strings
		Map<String,Contact> clientmap = new Map<String,Contact>(); //A Map of Client Id as String to the Contact object
		List<Contact_Summary__c> ctsums = new List<Contact_Summary__c>(); //A List of Contact Summaries
		List<KIDS_Service_Log_Summaries__c> slsups = new List<KIDS_Service_Log_Summaries__c>(); //A List of Service Log Summaries to Update

		Set<Id> newids = new Set<Id>(); //A Set of newly created Contact Summary Ids
		Map<Id,Id> summap = new Map<Id,Id>(); //A Map of Service Log Summary to Contact Summary Id

		Boolean hasfailures; //Indicates if the SaveResults set has failures
		Boolean hassuccesses; //Indicates if the SaveResults set has successes

		Set<Id> failids = new Set<Id>(); //A set of failed KIDS Service Log Summary Ids
		Map<Id,String> failmap = new Map<Id,String>(); //A Map of KSLS Ids and Failure Text

		List<KIDS_Service_Log_Summaries__c> fdsums = new List<KIDS_Service_Log_Summaries__c>(); //A List of KSLS which failed to process and must be updated
		List<KIDS_Service_Log_Summaries__c> upsums = new List<KIDS_Service_Log_Summaries__c>(); //A List of KSLS which must be updated with processing status

		//Create A Query String for KIDS Service Log Summaries
		SObjectType entrytype = Schema.getGlobalDescribe().get('KIDS_Service_Log_Summaries__c');
        Map<String,Schema.SObjectField> entryfields = entrytype.getDescribe().fields.getMap(); //A Map of Fields

        string entryselect = 'Select ';

        for(string pd : entryfields.keyset()){
            entryselect = entryselect + entryfields.get(pd) + ', ';
        }
        entryselect = entryselect.substring(0,entryselect.length()-2);
        entryselect = entryselect + '';
        entryselect = entryselect + ' FROM KIDS_Service_Log_Summaries__c WHERE Id IN: sumids ORDER BY PD_SRVC_LOG_ID__c ASC';

        //Query the Service Log Summaries
        try{
            allsums = (KIDS_Service_Log_Summaries__c[])Database.query(entryselect); //The list of Log Summaries
        }catch(Exception esums){
            system.debug('***********************ERROR Querying Service Log Summaries ***********************' + esums.getMessage());
        }

        System.Debug('********** Size of allsumslist' + allsums.size() + ' *******');

        for(KIDS_Service_Log_Summaries__c asl : allsums){

        	if(asl.isDeleted == FALSE){
        		slsums.add(asl);
        	}
        }

        System.Debug('********** Size of slsums' + slsums.size() + ' *******');


        if(!slsums.isEmpty()){

			//Add the client ID string to the set of Client Ids
        	for(KIDS_Service_Log_Summaries__c sum : slsums){
        		clientids.add(sum.CL_ID__c);
        	}

        	//Do something if the set of clientids is not empty
        	if(!clientids.isEmpty()){

        		clients = [SELECT Id, KIDS_ID__c, SSN__c, RecordTypeId, AccountId, Role__c, Neighborhood__c, Intake__c, Case__c, FirstName, LastName FROM Contact WHERE KIDS_ID__c IN: clientids ];

        		//Do Something if clients is not empty
        		if(!clients.isEmpty()){

        			//Add the Contacts to the Client Map
        			for(Contact c : clients){
        				clientmap.put(c.KIDS_ID__c,c);
        				System.Debug('******* Client KIDS ID: ' + c.KIDS_ID__c + ' ********');
        			}//End for Contact c : clients

        		}//End if clients is not empty

        	}//End if clientids is not empty


        	//Create A Contact Summary from the Service Log Summaries
        	for(KIDS_Service_Log_Summaries__c thesum : slsums){

        		//Only do something if the Client Id of the Log Summary has an Key Value in the Client Map
        		if(clientmap.get(thesum.CL_ID__c) != NULL){

        			String thekey = thesum.CL_ID__c;

        			Contact_Summary__c cs = new Contact_Summary__c(); //A New Contact Summary

        			cs.Status__c = 'AcceptedImportedfromKIDSSummary';
        			cs.Processing_Date__c = Date.Today();

        			if(clientmap != NULL && clientmap.get(thekey) != NULL){
        				cs.Case__c = clientmap.get(thekey).Case__c; //The Related Case
        				cs.Child__c = clientmap.get(thekey).Id; //The Related Child / Client
        			}

        			cs.KIDS_Service_Log_Summaries__c = thesum.Id; //The Related Service Log Summary
        			
        			cs.Facility__c = thesettings.Default_Facility_Record_Id__c;
        			cs.Program__c = thesettings.Default_Program_Record_Id__c;
        			cs.Requesting_Worker_c__c = thesettings.Default_Requesting_Worker_Record_Id__c;
        			cs.Approving_Worker_c__c = thesettings.Default_Approving_Worker_Record_Id__c;

		    			//Handle the Dates on Contact Summary
		    			Date basedate;
						basedate = Date.newInstance(1970,1,1);
						Integer offset = Integer.valueOf(kidssettings.Date_Calculation_Offset__c);

						if(offset == NULL){
							offset = 25569;
						}//End if offset == NULL

		  				String shortdays = thesum.SRVC_DT__c.left(6).trim();
		  				Integer days = Integer.valueOf(shortdays);

		    			cs.Date__c = basedate.addDays(days-offset+1462);
		    			cs.Date_Time_Ended__c = datetime.newInstance(basedate.addDays(days-offset+1462).year(), basedate.addDays(days-offset+1462).month(),basedate.addDays(days-offset+1462).day());
		    			//cs.HH_MM__c = thesum.SRVC_DT__c;

        			cs.Units_Completed__c = thesum.UNT_VALUE_NBR__c;
        			cs.Units_Type__c = 'Per Diem';

        			cs.ContactType__c = 'Direct';
        			cs.Service_Structure__c = 'AfterSchoolSummerAfterSchoolSummer';
        			cs.Comments__c = thesum.CMNT_TXT__c;

        			ctsums.add(cs); //Add the new Contact Summary to the list to be inserted

        		}

    			if(clientmap.get(thesum.CL_ID__c) == NULL){
    				hasfailures = TRUE;
    				failids.add(thesum.Id);
    				failmap.put(thesum.Id,'No Client Match Could be Found in Salesforce'); //Add the KSLS Id and Error Message to the failmap	
    			}

        	}//End for KIDS_Service_Log_Summaries__c thesum : slsums


        }//End if !slsums.isEmpty()

        if(!ctsums.isEmpty()){

        	//insert ctsums;

        	//try{

        		hassuccesses = FALSE;
        		hasfailures = TRUE;

				Database.SaveResult[] sres = Database.Insert(ctsums,false); //Try  to insert the new contact summaries

				for(Database.SaveResult sre : sres){ //Cycle through the Save Results
					if(sre.isSuccess() == TRUE){ 
						//Do something if the result is a success
						newids.add(sre.getId());
						hassuccesses = TRUE;
					}else if(sre.isSuccess() == FALSE){
						//Do somethign if the result is not a success
						System.Debug('*******' + sre.getErrors() + ' ********'); //DEBUG
						hasfailures = TRUE;
					}//End else if
				}//End for Database.SaveResult
			//}catch(Exception e){
				//System.Debug('------------Error Inserting New Contact Summaries from Service Log Summaries ------------'+e.getMessage());
			//}

			//A SAVE RESULT MAY HAVE BOTH SUCCESSES AND FAILURES TO BE PROCESSED BELOW

			//Process the Successes by Looping Through Results when has successes == TRUE and the set of success ids is not empty
			if(hassuccesses == TRUE && !newids.isEmpty()){


			}//End hassuccesses == TRUE

			//Process the Failures by Looping Through Results when hasfailures == TRUE
			if(hasfailures == TRUE){

				for(Integer i=0;i<sres.size();i++){
					if(!sres[i].isSuccess()){//only look at failures, or NOT Successes
						failids.add(ctsums[i].KIDS_Service_Log_Summaries__c);//Add the KIDS Service Log Summary Id to the set of failed Ids
						//Process The Error Messages
						String errors = 'ERRORS: ';
						List<Database.Error> dberrors = sres[i].getErrors();
						for(Database.Error er : dberrors){
							errors = errors + ';' + er.getMessage();
						}
						failmap.put(ctsums[i].KIDS_Service_Log_Summaries__c,errors); //Add the KSLS Id and Error Message to the failmap
					}//End if !sre[i].isSuccess
				}//End for Integer i ..

			}//End hasfailures == TRUE

		}//End !ctsums.isEmpty()

		if(hasfailures == TRUE){

				//Create A Query String for KIDS Service Log Summaries
				entryselect = 'Select '; //Reuse the entryselect variable

				for(string pd : entryfields.keyset()){
				entryselect = entryselect + entryfields.get(pd) + ', ';
				}
				entryselect = entryselect.substring(0,entryselect.length()-2);
				entryselect = entryselect + '';
				entryselect = entryselect + ' FROM KIDS_Service_Log_Summaries__c WHERE Id IN: failids';

				//Query the Service Log Summaries
				//try{
					fdsums = (KIDS_Service_Log_Summaries__c[])Database.query(entryselect); //The list of Log Summaries
				//}catch(Exception esums){
					//system.debug('***********************ERROR Querying Service Log Summaries ***********************' + esums.getMessage());
				//}//End catch

				//Update the Failures
				if(!fdsums.isEmpty()){

					for(KIDS_Service_Log_Summaries__c ksls : fdsums){

						ksls.Processing_Date__c = date.Today();
						ksls.Processing_Message__c = failmap.get(ksls.id);
						ksls.Processing_Status__C = 'Error';

						upsums.add(ksls);

					}//End for KIDS_Service_Log_Summaries ksls : fdsums

					if(!upsums.isEmpty()){//Update the parent KIDS Service Log Summary Records with the Error Information

						Database.SaveResult[] ures = Database.Update(upsums,false); //Try  to insert the new contact summaries

						for(Database.SaveResult ure : ures){ //Cycle through the Save Results
							if(ure.isSuccess() == TRUE){ 
								//Do something if the result is a success
							}else if(ure.isSuccess() == FALSE){
								//Do somethign if the result is not a success
							}//End else if ure.isSuccess() == FALSE
						}//End for Database.SaveResult sre

					}//End !upsums.isEmpty

				}//End !fdsums.isEmpty()

			}//End hasfailures == TRUE

	}//End createServiceLogEntry

	public void deleteContactSummaries(Set<Id> slsids){//Delete the related Contact Summaries when the parent Service Log Summaries are Deleted

		List<Contact_Summary__c> csums = new List<Contact_Summary__c>(); //A List of Contact Summaries to Delete

		csums = [SELECT Id, KIDS_Service_Log_Summaries__c from Contact_Summary__c WHERE KIDS_Service_Log_Summaries__c IN: slsids];

		try{
			Database.DeleteResult[] dres = Database.Delete(csums,false); //Try  to insert the new contact summaries
				for(Database.DeleteResult dre : dres){ //Cycle through the Delete Results
					if(dre.isSuccess() == TRUE){ 
						//Do something if the result is a success
					}else if(dre.isSuccess() == FALSE){
						//Do somethign if the result is not a success
					}
				}
		}catch(Exception ed){
			System.debug('***************** ERROR Deleting Contact Summaries related to Log Summaries *****************' + ed.getMessage());
		}

	}//End deleteContactSummaries

	public void undeleteContactSummaries(Set<Id> slsids){//Delete the related Contact Summaries when the parent Service Log Summaries are Deleted

		List<Contact_Summary__c> csums = new List<Contact_Summary__c>(); //A List of Contact Summaries to Delete

		csums = [SELECT Id, KIDS_Service_Log_Summaries__c from Contact_Summary__c WHERE KIDS_Service_Log_Summaries__c IN: slsids ALL ROWS];

		if(!csums.isEmpty()){

			try{
				Database.UndeleteResult[] dres = Database.undelete(csums); //Try  to insert the new contact summaries
					for(Database.UnDeleteResult dre : dres){ //Cycle through the Delete Results
						if(dre.isSuccess() == TRUE){ 
							//Do something if the result is a success
						}else if(dre.isSuccess() == FALSE){
							//Do somethign if the result is not a success
						}
					}
			}catch(Exception ed){
				System.debug('***************** ERROR Deleting Contact Summaries related to Log Summaries *****************' + ed.getMessage());
			}

		}//End if !csums.isEmpty()

	}//End undeleteContactSummaries

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

	public class ImportError{
       public List<String> error_messages {get;set;}

       public ImportError(Database.SaveResult sr){
           this.error_messages = new List<String>(); 
           for(Database.Error err : sr.getErrors()){
               //TODO: use the getFields() method to use with highlighting issues fields, provide more info etc. 
               this.error_messages.add(err.getMessage());
           }
       }
   }
	
}