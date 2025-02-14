/**********************************************************************
* Name:     KIDSTestClass
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     22 Feb 2017
* ======================================================
* ======================================================
* Purpose:                                                           
* Test Class for KIDS related triggers
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       22 Feb 2017     TGM         Development
***********************************************************************/
@isTest
private class KIDSTestClass {

    static testMethod void unitTest1(){ //Insert Contact Summary

		Set<Id> csids = new Set<Id>();
		List<KIDS_Service_Log_Entry__c> lksle = new List<KIDS_Service_Log_Entry__c>();

	Test.startTest();


    	Account hacc = new Account();
			hacc.Name = 'HouseHold';
			hacc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();
			hacc.npe01__SYSTEMIsIndividual__c = TRUE;
			hacc.npe01__SYSTEM_AccountType__c = 'Household Account';

		insert hacc;
		String haccid = hacc.id;

		Account gg = new Account();
			gg.Name = 'GG';
			gg.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();

		insert gg;
		String ggid = gg.id;

		Contact child = new Contact();
			child.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child').getRecordTypeId();
			child.AccountId = haccid;
			child.KIDS_ID__c = '1034056789';
			child.KIDS_Active_Service_Episode_ID__c = '1034056789';
			child.LastName = 'Child';

		insert child;
		String childid = child.id;

		Contact rwk = new Contact();
			rwk.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
			rwk.AccountId = ggid;
			rwk.KIDS_ID__c = '1034056780';
			rwk.LastName = 'Requesting';

		insert rwk;
		String rwkid = rwk.id;

		Contact awk = new Contact();
			awk.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
			awk.AccountId = ggid;
			awk.KIDS_ID__c = '1034052789';
			awk.LastName = 'Approving';

		insert awk;
		String awkid = awk.id;

		Case cs = new Case();
			cs.RecordTypeId = Schema.sObjectType.Case.getRecordTypeInfosByName().get('Open').getRecordTypeId();
			cs.ContactId = childid;
			cs.Status = 'Open';

		insert cs;
		String csid = cs.id;

		Account fc = new Account();
			fc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();
			fc.KIDS_ID__c = '999';
			fc.Name = 'Facility';

		insert fc;
		String fcid = fc.id;

		Program__c pg = new Program__c();
			pg.RecordTypeId = Schema.sObjectType.Program__c.getRecordTypeInfosByName().get('After School').getRecordTypeId();
			pg.KIDS_ID__c = '999';
			pg.Name = 'Not Applicable';

		insert pg;
		String pgid = pg.id;

		Contact_Summary__c csum = new Contact_Summary__c();

			csum.Activity__c =  'Activity'; //Long Text Area(2000)
			csum.Approving_Worker_c__c =  awkid; //Lookup(Contact)
			csum.Case__c =  csid; //Master-Detail(Case) Required Filtered Lookup
			csum.Child__c =  childid; //Lookup(Contact)
			csum.Comments__c =  'Comments';//Long Text Area(2000)
			csum.ContactType__c = 'Direct';  //Picklist
			csum.Date__c =  date.Today();//Date
			csum.Date_Time_Ended__c =  dateTime.Now();//Date/Time
			csum.Facility__c =  fcid; //Lookup(Account)
			csum.HH_MM__c = '01:01:00';  //Text(8)
			csum.Program__c =  pgid; //Lookup(Program)
			csum.Requesting_Worker_c__c =  rwkid; //Lookup(Contact)
			csum.Service_Structure__c = 'AfterSchoolSummerAfterSchoolSummer'; //Picklist
			csum.Status__c =  'OpenNotYetSubmittedToKIDS'; //Picklist
			csum.Units_Completed__c =  1;//Number(10, 2)
			csum.Units_Type__c =  'Per Diem'; //Picklist


			//try{
				insert csum;
				delete csum;
				undelete csum;
			//}catch(Exception ei){
				//System.Debug('******* Error Inserting Contact Summary**********' + ei.getMessage());
			//}

			csum.Units_Completed__c = 2;

			update csum;

			String csumid;

			csumid = csum.id;

			csids.add(csumid);

			KIDSServiceLogEntryTools kslet = new KIDSServiceLogEntryTools();

        	kslet.createServiceLogEntry(csids); // Create KIDS Service Log Entries from Contact Summaries

		KIDS_Service_Log_Entry__c ksle = new KIDS_Service_Log_Entry__c();

		lksle = [SELECT Id, Status__c, KIDS_Service_Log__c, Contact_Summary__c FROM KIDS_Service_Log_Entry__c WHERE Contact_Summary__c =: csumid];

		if(!lksle.isEmpty()){

			ksle= lksle[1];

			KIDS_Service_Log__c ksl = new KIDS_Service_Log__c();

			ksl = [SELECT Id, Status__c FROM KIDS_Service_Log__c WHERE Id =: ksle.KIDS_Service_Log__c][0];

			String kslid = ksl.id;

			KIDSServiceLogTools.processLog(kslid);

			KIDS_Service_Log__c thelog = new KIDS_Service_Log__c();
			Id theId = ksl.id;
			KIDSServiceLogTools ktools = new KIDSServiceLogTools();
			thelog = ktools.getServiceLog(theId);
			KIDSServiceLogTools.updateParentLog(theId,'message','status',date.Today());
			Map<Integer,String> themap = new Map<Integer,String>();
			themap.put(1,'A String Value');
			/*Map<Integer,Blob> theblobmap = new Map<Integer,Blob>();
			theblobmap = KIDSServiceLogTools.generateBlobMap(themap);*/

			//ksl.Status__c = 'Generated';

			//update ksl;

		}


		Test.stopTest();

	}

	static testMethod void unitTest2(){ //Insert Contact Summary & Service Log Summary

		Set<Id> csids = new Set<Id>();
		List<KIDS_Service_Log_Entry__c> lksle = new List<KIDS_Service_Log_Entry__c>();

	Test.startTest();

    	Account hacc = new Account();
			hacc.Name = 'HouseHold';
			hacc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();
			hacc.npe01__SYSTEMIsIndividual__c = TRUE;
			hacc.npe01__SYSTEM_AccountType__c = 'Household Account';

		insert hacc;
		String haccid = hacc.id;

		Account gg = new Account();
			gg.Name = 'GG';
			gg.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();

		insert gg;
		String ggid = gg.id;

		Contact child = new Contact();
			child.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child').getRecordTypeId();
			child.AccountId = haccid;
			child.KIDS_ID__c = '1034056789';
			child.LastName = 'Child';
			child.KIDS_Active_Service_Episode_ID__c = '1034056789';

		insert child;
		String childid = child.id;

		Contact rwk = new Contact();
			rwk.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
			rwk.AccountId = ggid;
			rwk.KIDS_ID__c = '1034056780';
			rwk.LastName = 'Requesting';

		insert rwk;
		String rwkid = rwk.id;

		Contact awk = new Contact();
			awk.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
			awk.AccountId = ggid;
			awk.KIDS_ID__c = '1034052789';
			awk.LastName = 'Approving';

		insert awk;
		String awkid = awk.id;

		Case cs = new Case();
			cs.RecordTypeId = Schema.sObjectType.Case.getRecordTypeInfosByName().get('Open').getRecordTypeId();
			cs.ContactId = childid;
			cs.Status = 'Open';

		insert cs;
		String csid = cs.id;

		Account fc = new Account();
			fc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();
			fc.KIDS_ID__c = '999';
			fc.Name = 'Facility';

		insert fc;
		String fcid = fc.id;

		Program__c pg = new Program__c();
			pg.RecordTypeId = Schema.sObjectType.Program__c.getRecordTypeInfosByName().get('After School').getRecordTypeId();
			pg.KIDS_ID__c = '999';
			pg.Name = 'Not Applicable';

		insert pg;
		String pgid = pg.id;

		Contact_Summary__c csum = new Contact_Summary__c();

			csum.Activity__c =  'Activity'; //Long Text Area(2000)
			csum.Approving_Worker_c__c =  awkid; //Lookup(Contact)
			csum.Case__c =  csid; //Master-Detail(Case) Required Filtered Lookup
			csum.Child__c =  childid; //Lookup(Contact)
			csum.Comments__c =  'Comments';//Long Text Area(2000)
			csum.ContactType__c = 'Direct';  //Picklist
			csum.Date__c =  date.Today();//Date
			csum.Date_Time_Ended__c =  dateTime.Now();//Date/Time
			csum.Facility__c =  fcid; //Lookup(Account)
			csum.HH_MM__c = '01:01:00';  //Text(8)
			csum.Program__c =  pgid; //Lookup(Program)
			csum.Requesting_Worker_c__c =  rwkid; //Lookup(Contact)
			csum.Service_Structure__c = 'AfterSchoolSummerAfterSchoolSummer'; //Picklist
			csum.Status__c =  'OpenNotYetSubmittedToKIDS'; //Picklist
			csum.Units_Completed__c =  1;//Number(10, 2)
			csum.Units_Type__c =  'Per Diem'; //Picklist

		KIDS_Service_Log_Summaries__c slsum = new KIDS_Service_Log_Summaries__c();

			slsum.CL_ID__c = '1034052789';
			slsum.CMNT_TXT__c = 'Test Comment';
			slsum.LST_UPDT_DT__c = '41073.789895833';
			slsum.PD_SRVC_LOG_ID__c = '0123456789';
			slsum.PROV_SSN_NBR__c = '1234567890';
			slsum.SRVC_DT__c = '41073.7898958333';
			slsum.UNT_TYPE_DESC__c = 'Per Diem';
			slsum.UNT_VALUE_NBR__c = 1.00;

		//try{
			insert csum;
		//}catch(Exception ei){
			//System.Debug('******* Error Inserting Contact Summary**********' + ei.getMessage());
		//}

		//try{
			insert slsum;
			delete slsum;
			undelete slsum;
		//}catch(Exception eis){
			//System.Debug('******* Error Inserting Service Log Summary**********' + eis.getMessage());
		//}

		//Update the Contact Summary
		csum.Units_Completed__c = 2;
		update csum;
		String csumid;
		csumid = csum.id;
		csids.add(csumid);

		//Create A Service Log Entry from the Summary
		KIDSServiceLogEntryTools kslet = new KIDSServiceLogEntryTools();
    	kslet.createServiceLogEntry(csids); // Create KIDS Service Log Entries from Contact Summaries
		KIDS_Service_Log_Entry__c ksle = new KIDS_Service_Log_Entry__c();
		lksle = [SELECT Id, Status__c, KIDS_Service_Log__c, Contact_Summary__c FROM KIDS_Service_Log_Entry__c WHERE Contact_Summary__c =: csumid];

		if(!lksle.isEmpty()){//Do something if the Service Log Entry List is not Empty

			ksle= lksle[1]; //Get the Service Log Entry

			//Get the Service Log
			KIDS_Service_Log__c ksl = new KIDS_Service_Log__c();
			ksl = [SELECT Id, Status__c FROM KIDS_Service_Log__c WHERE Id =: ksle.KIDS_Service_Log__c][0];
			String kslid = ksl.id;

			//Update, Delete, Undelete the ServiceLog
			ksl.Status__c = 'Generated';
			update ksl; //Update the Service Log
			delete ksl; //Delete the Service Log
			undelete ksl; //Undelete the Service Log

			//Test KIDS ServiceLogController
	        PageReference pageRef = new PageReference('/' + kslid);
	        Test.setCurrentPage(pageRef);
	        ApexPages.currentPage().getParameters().put('id',ksl.id);
	        // Instantiate a new controller with all parameters in the page
	        ApexPages.StandardController sc = new ApexPages.standardController(ksl);
  			KIDSServiceLogController  controller = new KIDSServiceLogController(sc);
  			PageReference newRef = controller.autoRun();

			Test.stopTest();

		}//Test.stopTest();

	}

	static testMethod void unitTest3(){ //Insert Contact Summary

		Set<Id> csids = new Set<Id>();
		List<KIDS_Service_Log_Entry__c> lksle = new List<KIDS_Service_Log_Entry__c>();

	Test.startTest();

    	Account hacc = new Account();
			hacc.Name = 'HouseHold';
			hacc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();
			hacc.npe01__SYSTEMIsIndividual__c = TRUE;
			hacc.npe01__SYSTEM_AccountType__c = 'Household Account';

		insert hacc;
		String haccid = hacc.id;

		Account gg = new Account();
			gg.Name = 'GG';
			gg.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();

		insert gg;
		String ggid = gg.id;

		Contact child = new Contact();
			child.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child').getRecordTypeId();
			child.AccountId = haccid;
			child.KIDS_ID__c = '1034056789';
			child.LastName = 'Child';
			child.KIDS_Active_Service_Episode_ID__c = '1034056789';

		insert child;
		String childid = child.id;

		Contact rwk = new Contact();
			rwk.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
			rwk.AccountId = ggid;
			rwk.KIDS_ID__c = '1034056780';
			rwk.LastName = 'Requesting';

		insert rwk;
		String rwkid = rwk.id;

		Contact awk = new Contact();
			awk.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
			awk.AccountId = ggid;
			awk.KIDS_ID__c = '1034052789';
			awk.LastName = 'Approving';

		insert awk;
		String awkid = awk.id;

		Case cs = new Case();
			cs.RecordTypeId = Schema.sObjectType.Case.getRecordTypeInfosByName().get('Open').getRecordTypeId();
			cs.ContactId = childid;
			cs.Status = 'Open';

		insert cs;
		String csid = cs.id;

		Account fc = new Account();
			fc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();
			fc.KIDS_ID__c = '999';
			fc.Name = 'Facility';

		insert fc;
		String fcid = fc.id;

		Program__c pg = new Program__c();
			pg.RecordTypeId = Schema.sObjectType.Program__c.getRecordTypeInfosByName().get('After School').getRecordTypeId();
			pg.KIDS_ID__c = '999';
			pg.Name = 'Not Applicable';

		insert pg;
		String pgid = pg.id;

		Contact_Summary__c csum = new Contact_Summary__c();

			csum.Activity__c =  'Activity'; //Long Text Area(2000)
			csum.Approving_Worker_c__c =  awkid; //Lookup(Contact)
			csum.Case__c =  csid; //Master-Detail(Case) Required Filtered Lookup
			//csum.Child__c =  childid; //Lookup(Contact)
			csum.Comments__c =  'Comments';//Long Text Area(2000)
			csum.ContactType__c = 'Direct';  //Picklist
			csum.Date__c =  date.Today();//Date
			csum.Date_Time_Ended__c =  dateTime.Now();//Date/Time
			csum.Facility__c =  fcid; //Lookup(Account)
			csum.HH_MM__c = '01:01:00';  //Text(8)
			csum.Program__c =  pgid; //Lookup(Program)
			csum.Requesting_Worker_c__c =  rwkid; //Lookup(Contact)
			csum.Service_Structure__c = 'AfterSchoolSummerAfterSchoolSummer'; //Picklist
			csum.Status__c =  'OpenNotYetSubmittedToKIDS'; //Picklist
			csum.Units_Completed__c =  1;//Number(10, 2)
			csum.Units_Type__c =  'Per Diem'; //Picklist

			//try{
				insert csum;
			//}catch(Exception ei){
				//System.Debug('******* Error Inserting Contact Summary**********' + ei.getMessage());
			//}

			csum.Units_Completed__c = 2;

			update csum;

			String csumid;

			csumid = csum.id;

			csids.add(csumid);

			KIDSServiceLogEntryTools kslet = new KIDSServiceLogEntryTools();

        	kslet.createServiceLogEntry(csids); // Create KIDS Service Log Entries from Contact Summaries

		KIDS_Service_Log_Entry__c ksle = new KIDS_Service_Log_Entry__c();

		lksle = [SELECT Id, Status__c, KIDS_Service_Log__c, Contact_Summary__c FROM KIDS_Service_Log_Entry__c WHERE Contact_Summary__c =: csumid];

		if(!lksle.isEmpty()){

			ksle= lksle[1];

			KIDS_Service_Log__c ksl = new KIDS_Service_Log__c();

			ksl = [SELECT Id, Status__c FROM KIDS_Service_Log__c WHERE Id =: ksle.KIDS_Service_Log__c][0];

			String kslid = ksl.id;

			ksl.Status__c = 'Generated';

			update ksl;

			delete ksl;

			undelete ksl;

			delete ksle;

			undelete ksle;

			Test.stopTest();

		}

		//Test.stopTest();

	}

	    static testMethod void unitTest4(){ //Insert Contact Summary

		Set<Id> csids = new Set<Id>();
		List<KIDS_Service_Log_Entry__c> lksle = new List<KIDS_Service_Log_Entry__c>();

	Test.startTest();


    	Account hacc = new Account();
			hacc.Name = 'HouseHold';
			hacc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();
			hacc.npe01__SYSTEMIsIndividual__c = TRUE;
			hacc.npe01__SYSTEM_AccountType__c = 'Household Account';

		insert hacc;
		String haccid = hacc.id;

		Account gg = new Account();
			gg.Name = 'GG';
			gg.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();

		insert gg;
		String ggid = gg.id;

		Contact child = new Contact();
			child.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child').getRecordTypeId();
			child.AccountId = haccid;
			child.KIDS_ID__c = '1034056789';
			child.KIDS_Active_Service_Episode_ID__c = '1034056789';
			child.LastName = 'Child';

		insert child;
		String childid = child.id;

		Contact rwk = new Contact();
			rwk.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
			rwk.AccountId = ggid;
			rwk.KIDS_ID__c = '1034056780';
			rwk.LastName = 'Requesting';

		insert rwk;
		String rwkid = rwk.id;

		Contact awk = new Contact();
			awk.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
			awk.AccountId = ggid;
			awk.KIDS_ID__c = '1034052789';
			awk.LastName = 'Approving';

		insert awk;
		String awkid = awk.id;

		Case cs = new Case();
			cs.RecordTypeId = Schema.sObjectType.Case.getRecordTypeInfosByName().get('Open').getRecordTypeId();
			cs.ContactId = childid;
			cs.Status = 'Open';

		insert cs;
		String csid = cs.id;

		Account fc = new Account();
			fc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();
			fc.KIDS_ID__c = '999';
			fc.Name = 'Facility';

		insert fc;
		String fcid = fc.id;

		Program__c pg = new Program__c();
			pg.RecordTypeId = Schema.sObjectType.Program__c.getRecordTypeInfosByName().get('Group Home').getRecordTypeId();
			pg.KIDS_ID__c = '999';
			pg.Name = 'Not Applicable';

		insert pg;
		String pgid = pg.id;

		Contact_Summary__c csum = new Contact_Summary__c();

			csum.Activity__c =  'Activity'; //Long Text Area(2000)
			csum.Approving_Worker_c__c =  awkid; //Lookup(Contact)
			csum.Case__c =  csid; //Master-Detail(Case) Required Filtered Lookup
			csum.Child__c =  childid; //Lookup(Contact)
			csum.Comments__c =  'Comments';//Long Text Area(2000)
			csum.ContactType__c = 'Direct';  //Picklist
			csum.Date__c =  date.Today();//Date
			csum.Date_Time_Ended__c =  dateTime.Now();//Date/Time
			csum.Facility__c =  fcid; //Lookup(Account)
			csum.HH_MM__c = '01:01:00';  //Text(8)
			csum.Program__c =  pgid; //Lookup(Program)
			csum.Requesting_Worker_c__c =  rwkid; //Lookup(Contact)
			csum.Service_Structure__c = 'AfterSchoolSummerAfterSchoolSummer'; //Picklist
			csum.Status__c =  'OpenNotYetSubmittedToKIDS'; //Picklist
			csum.Units_Completed__c =  1;//Number(10, 2)
			csum.Units_Type__c =  'Per Diem'; //Picklist


			//try{
				insert csum;
				delete csum;
				undelete csum;
			//}catch(Exception ei){
				//System.Debug('******* Error Inserting Contact Summary**********' + ei.getMessage());
			//}

			csum.Units_Completed__c = 2;

			update csum;

			String csumid;

			csumid = csum.id;

			csids.add(csumid);

			KIDSServiceLogEntryTools kslet = new KIDSServiceLogEntryTools();

        	kslet.createServiceLogEntry(csids); // Create KIDS Service Log Entries from Contact Summaries

		KIDS_Service_Log_Entry__c ksle = new KIDS_Service_Log_Entry__c();

		lksle = [SELECT Id, Status__c, KIDS_Service_Log__c, Contact_Summary__c FROM KIDS_Service_Log_Entry__c WHERE Contact_Summary__c =: csumid];

		if(!lksle.isEmpty()){

			ksle= lksle[1];

			KIDS_Service_Log__c ksl = new KIDS_Service_Log__c();

			ksl = [SELECT Id, Status__c FROM KIDS_Service_Log__c WHERE Id =: ksle.KIDS_Service_Log__c][0];

			String kslid = ksl.id;

			KIDSServiceLogTools.processLog(kslid);

			KIDS_Service_Log__c thelog = new KIDS_Service_Log__c();
			Id theId = ksl.id;
			KIDSServiceLogTools ktools = new KIDSServiceLogTools();
			thelog = ktools.getServiceLog(theId);
			KIDSServiceLogTools.updateParentLog(theId,'message','status',date.Today());
			Map<Integer,String> themap = new Map<Integer,String>();
			themap.put(1,'A String Value');
			/*Map<Integer,Blob> theblobmap = new Map<Integer,Blob>();
			theblobmap = KIDSServiceLogTools.generateBlobMap(themap);*/

			//ksl.Status__c = 'Generated';

			//update ksl;

		}


		Test.stopTest();

	}

	static testMethod void unitTest5(){ //Insert Contact Summary & Service Log Summary

		Set<Id> csids = new Set<Id>();
		List<KIDS_Service_Log_Entry__c> lksle = new List<KIDS_Service_Log_Entry__c>();

	Test.startTest();

    	Account hacc = new Account();
			hacc.Name = 'HouseHold';
			hacc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();
			hacc.npe01__SYSTEMIsIndividual__c = TRUE;
			hacc.npe01__SYSTEM_AccountType__c = 'Household Account';

		insert hacc;
		String haccid = hacc.id;

		Account gg = new Account();
			gg.Name = 'GG';
			gg.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();

		insert gg;
		String ggid = gg.id;

		Contact child = new Contact();
			child.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child').getRecordTypeId();
			child.AccountId = haccid;
			child.KIDS_ID__c = '1034056789';
			child.LastName = 'Child';
			child.KIDS_Active_Service_Episode_ID__c = '1034056789';

		insert child;
		String childid = child.id;

		Contact rwk = new Contact();
			rwk.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
			rwk.AccountId = ggid;
			rwk.KIDS_ID__c = '1034056780';
			rwk.LastName = 'Requesting';

		insert rwk;
		String rwkid = rwk.id;

		Contact awk = new Contact();
			awk.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
			awk.AccountId = ggid;
			awk.KIDS_ID__c = '1034052789';
			awk.LastName = 'Approving';

		insert awk;
		String awkid = awk.id;

		Case cs = new Case();
			cs.RecordTypeId = Schema.sObjectType.Case.getRecordTypeInfosByName().get('Open').getRecordTypeId();
			cs.ContactId = childid;
			cs.Status = 'Open';

		insert cs;
		String csid = cs.id;

		Account fc = new Account();
			fc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();
			fc.KIDS_ID__c = '999';
			fc.Name = 'Facility';

		insert fc;
		String fcid = fc.id;

		Program__c pg = new Program__c();
			pg.RecordTypeId = Schema.sObjectType.Program__c.getRecordTypeInfosByName().get('Group Home').getRecordTypeId();
			pg.KIDS_ID__c = '999';
			pg.Name = 'Not Applicable';

		insert pg;
		String pgid = pg.id;

		Contact_Summary__c csum = new Contact_Summary__c();

			csum.Activity__c =  'Activity'; //Long Text Area(2000)
			csum.Approving_Worker_c__c =  awkid; //Lookup(Contact)
			csum.Case__c =  csid; //Master-Detail(Case) Required Filtered Lookup
			csum.Child__c =  childid; //Lookup(Contact)
			csum.Comments__c =  'Comments';//Long Text Area(2000)
			csum.ContactType__c = 'Direct';  //Picklist
			csum.Date__c =  date.Today();//Date
			csum.Date_Time_Ended__c =  dateTime.Now();//Date/Time
			csum.Facility__c =  fcid; //Lookup(Account)
			csum.HH_MM__c = '01:01:00';  //Text(8)
			csum.Program__c =  pgid; //Lookup(Program)
			csum.Requesting_Worker_c__c =  rwkid; //Lookup(Contact)
			csum.Service_Structure__c = 'AfterSchoolSummerAfterSchoolSummer'; //Picklist
			csum.Status__c =  'OpenNotYetSubmittedToKIDS'; //Picklist
			csum.Units_Completed__c =  1;//Number(10, 2)
			csum.Units_Type__c =  'Per Diem'; //Picklist

		KIDS_Service_Log_Summaries__c slsum = new KIDS_Service_Log_Summaries__c();

			slsum.CL_ID__c = '1034052789';
			slsum.CMNT_TXT__c = 'Test Comment';
			slsum.LST_UPDT_DT__c = '41073.789895833';
			slsum.PD_SRVC_LOG_ID__c = '0123456789';
			slsum.PROV_SSN_NBR__c = '1234567890';
			slsum.SRVC_DT__c = '41073.7898958333';
			slsum.UNT_TYPE_DESC__c = 'Per Diem';
			slsum.UNT_VALUE_NBR__c = 1.00;

		//try{
			insert csum;
		//}catch(Exception ei){
			//System.Debug('******* Error Inserting Contact Summary**********' + ei.getMessage());
		//}

		//try{
			insert slsum;
			delete slsum;
			undelete slsum;
		//}catch(Exception eis){
			//System.Debug('******* Error Inserting Service Log Summary**********' + eis.getMessage());
		//}

		//Update the Contact Summary
		csum.Units_Completed__c = 2;
		update csum;
		String csumid;
		csumid = csum.id;
		csids.add(csumid);

		//Create A Service Log Entry from the Summary
		KIDSServiceLogEntryTools kslet = new KIDSServiceLogEntryTools();
    	kslet.createServiceLogEntry(csids); // Create KIDS Service Log Entries from Contact Summaries
		KIDS_Service_Log_Entry__c ksle = new KIDS_Service_Log_Entry__c();
		lksle = [SELECT Id, Status__c, KIDS_Service_Log__c, Contact_Summary__c FROM KIDS_Service_Log_Entry__c WHERE Contact_Summary__c =: csumid];

		if(!lksle.isEmpty()){//Do something if the Service Log Entry List is not Empty

			ksle= lksle[1]; //Get the Service Log Entry

			//Get the Service Log
			KIDS_Service_Log__c ksl = new KIDS_Service_Log__c();
			ksl = [SELECT Id, Status__c FROM KIDS_Service_Log__c WHERE Id =: ksle.KIDS_Service_Log__c][0];
			String kslid = ksl.id;

			//Update, Delete, Undelete the ServiceLog
			ksl.Status__c = 'Generated';
			update ksl; //Update the Service Log
			delete ksl; //Delete the Service Log
			undelete ksl; //Undelete the Service Log

			//Test KIDS ServiceLogController
	        PageReference pageRef = new PageReference('/' + kslid);
	        Test.setCurrentPage(pageRef);
	        ApexPages.currentPage().getParameters().put('id',ksl.id);
	        // Instantiate a new controller with all parameters in the page
	        ApexPages.StandardController sc = new ApexPages.standardController(ksl);
  			KIDSServiceLogController  controller = new KIDSServiceLogController(sc);
  			PageReference newRef = controller.autoRun();

			Test.stopTest();

		}//Test.stopTest();

	}

	static testMethod void unitTest6(){ //Insert Contact Summary

		Set<Id> csids = new Set<Id>();
		List<KIDS_Service_Log_Entry__c> lksle = new List<KIDS_Service_Log_Entry__c>();

	Test.startTest();

    	Account hacc = new Account();
			hacc.Name = 'HouseHold';
			hacc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Household Account').getRecordTypeId();
			hacc.npe01__SYSTEMIsIndividual__c = TRUE;
			hacc.npe01__SYSTEM_AccountType__c = 'Household Account';

		insert hacc;
		String haccid = hacc.id;

		Account gg = new Account();
			gg.Name = 'GG';
			gg.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();

		insert gg;
		String ggid = gg.id;

		Contact child = new Contact();
			child.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Child').getRecordTypeId();
			child.AccountId = haccid;
			child.KIDS_ID__c = '1034056789';
			child.LastName = 'Child';
			child.KIDS_Active_Service_Episode_ID__c = '1034056789';

		insert child;
		String childid = child.id;

		Contact rwk = new Contact();
			rwk.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
			rwk.AccountId = ggid;
			rwk.KIDS_ID__c = '1034056780';
			rwk.LastName = 'Requesting';

		insert rwk;
		String rwkid = rwk.id;

		Contact awk = new Contact();
			awk.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId();
			awk.AccountId = ggid;
			awk.KIDS_ID__c = '1034052789';
			awk.LastName = 'Approving';

		insert awk;
		String awkid = awk.id;

		Case cs = new Case();
			cs.RecordTypeId = Schema.sObjectType.Case.getRecordTypeInfosByName().get('Open').getRecordTypeId();
			cs.ContactId = childid;
			cs.Status = 'Open';

		insert cs;
		String csid = cs.id;

		Account fc = new Account();
			fc.RecordTypeId = Schema.sObjectType.Account.getRecordTypeInfosByName().get('Organization').getRecordTypeId();
			fc.KIDS_ID__c = '999';
			fc.Name = 'Facility';

		insert fc;
		String fcid = fc.id;

		Program__c pg = new Program__c();
			pg.RecordTypeId = Schema.sObjectType.Program__c.getRecordTypeInfosByName().get('Group Home').getRecordTypeId();
			pg.KIDS_ID__c = '999';
			pg.Name = 'Not Applicable';

		insert pg;
		String pgid = pg.id;

		Contact_Summary__c csum = new Contact_Summary__c();

			csum.Activity__c =  'Activity'; //Long Text Area(2000)
			csum.Approving_Worker_c__c =  awkid; //Lookup(Contact)
			csum.Case__c =  csid; //Master-Detail(Case) Required Filtered Lookup
			//csum.Child__c =  childid; //Lookup(Contact)
			csum.Comments__c =  'Comments';//Long Text Area(2000)
			csum.ContactType__c = 'Direct';  //Picklist
			csum.Date__c =  date.Today();//Date
			csum.Date_Time_Ended__c =  dateTime.Now();//Date/Time
			csum.Facility__c =  fcid; //Lookup(Account)
			csum.HH_MM__c = '01:01:00';  //Text(8)
			csum.Program__c =  pgid; //Lookup(Program)
			csum.Requesting_Worker_c__c =  rwkid; //Lookup(Contact)
			csum.Service_Structure__c = 'AfterSchoolSummerAfterSchoolSummer'; //Picklist
			csum.Status__c =  'OpenNotYetSubmittedToKIDS'; //Picklist
			csum.Units_Completed__c =  1;//Number(10, 2)
			csum.Units_Type__c =  'Per Diem'; //Picklist

			//try{
				insert csum;
			//}catch(Exception ei){
				//System.Debug('******* Error Inserting Contact Summary**********' + ei.getMessage());
			//}

			csum.Units_Completed__c = 2;

			update csum;

			String csumid;

			csumid = csum.id;

			csids.add(csumid);

			KIDSServiceLogEntryTools kslet = new KIDSServiceLogEntryTools();

        	kslet.createServiceLogEntry(csids); // Create KIDS Service Log Entries from Contact Summaries

		KIDS_Service_Log_Entry__c ksle = new KIDS_Service_Log_Entry__c();

		lksle = [SELECT Id, Status__c, KIDS_Service_Log__c, Contact_Summary__c FROM KIDS_Service_Log_Entry__c WHERE Contact_Summary__c =: csumid];

		if(!lksle.isEmpty()){

			ksle= lksle[1];

			KIDS_Service_Log__c ksl = new KIDS_Service_Log__c();

			ksl = [SELECT Id, Status__c FROM KIDS_Service_Log__c WHERE Id =: ksle.KIDS_Service_Log__c][0];

			String kslid = ksl.id;

			ksl.Status__c = 'Generated';

			update ksl;

			delete ksl;

			undelete ksl;

			delete ksle;

			undelete ksle;

			Test.stopTest();

		}

		//Test.stopTest();

	}

}