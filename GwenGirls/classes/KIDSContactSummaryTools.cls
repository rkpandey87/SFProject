/**********************************************************************
* Name:     KIDSServiceLogTools
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
public class KIDSContactSummaryTools{


	public void checkContactSummary(List<Contact_Summary__c> lcsums){

		Set<Id> cids = new Set<Id>(); //A Set of Contact Ids
		Set<Id> csids = new Set<Id>(); //A Set of Case Ids
		List<Case> lcs = new List<Case>(); //A List of Cases
		List<Contact> lcnts = new List<Contact>(); //A List of Contacts
		Map<Id,Id> csmap = new Map<Id,Id>(); //A Map of Contact Id to Case Id
		Map<Id,Id> ctmap = new Map<Id,Id>(); //A Map of Case Id to Contact Id


		KIDSSettings__c settings = KIDSSettings__c.getInstance();
		String appworker; appworker = settings.Default_Approving_Worker_Record_Id__c;
		String reqworker; reqworker = settings.Default_Requesting_Worker_Record_Id__c;

		for(Contact_Summary__c cs : lcsums){



			//if(cs.Case__c == NULL && cs.Child__c != NULL){
				//cids.add(cs.Child__c);
			//}

			if(cs.Case__c != NULL && cs.Child__c == NULL){
				csids.add(cs.Case__c);
			}

		}

		if(!cids.isEmpty()){
			lcnts = [SELECT Id, Case__c FROM Contact WHERE Id IN: cids];
		}

		if(!lcnts.isEmpty()){
			for(Contact cl : lcnts){
				if(cl.Case__c != NULL){
					csmap.put(cl.Id,cl.Case__c);
				}
			}
		}

		if(!csids.isEmpty()){
			lcs = [SELECT Id, ContactId FROM Case WHERE Id IN: csids];
		}

		if(!lcs.isEmpty()){
			for(Case csl : lcs){
				if(csl.ContactId != NULL){
					ctmap.put(csl.Id,csl.ContactId);
				}
			}
		}

		for(Contact_Summary__c csu : lcsums){

			if(csu.Requesting_Worker_c__c == NULL){
				csu.Requesting_Worker_c__c = reqworker;
			}

			if(csu.Case__c == NULL && csu.Child__c!= NULL && csmap.get(csu.Child__c) != NULL){
				csu.Case__c = csmap.get(csu.Child__c);
			}

			if(csu.Case__c != NULL & csu.Child__c == NULL && ctmap.get(csu.Case__c) != NULL){
				csu.Child__c = ctmap.get(csu.Case__c);
			}
		}

	}
}