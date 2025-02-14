/**
 * @description       : 
 * @author            : WINSupport
 * @group             : 
 * @last modified on  : 09-18-2020
 * @last modified by  : WINSupport
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   09-18-2020   WINSupport   Initial Version
**/
@isTest (seeAllData=false)
public class WSAdvancedFieldHistoryAction_TC {
	
	public static testMethod void myTest(){
		//create Contact records to test
		Map<ID,Contact> oldMap = new Map<ID,Contact>();
        Map<ID,Contact> newMap = new Map<ID,Contact>();
        Account acct = new Account (Name='Home');
        insert acct;
		Contact acc = new Contact(AccountId=acct.id,LastName = 'TestOld',npe01__Preferred_Email__c='Home',npe01__PreferredPhone__c ='Home');
		insert acc;
		oldMap.put(acc.id, acc);
		acc.LastName = 'TestNew';
		acc.phone = '408-555-1212';
		update acc;
		newMap.put(acc.id, acc);
		WSAdvancedFieldHistoryAction.RecordFieldChanges(oldMap, newMap);
		Advanced_Field_History__c afh = [SELECT id
										, Field_Name__c
										, Old_Value__c
										, New_Value__c
										FROM Advanced_Field_History__c
										WHERE Field_Name__c = 'Last Name'
										LIMIT 1];
		system.debug('afh: '+ afh);

		system.assertEquals(afh.Old_Value__c, 'TestOld');
		system.assertEquals(afh.New_Value__c, 'TestNew');
		
        }
        
        public static testMethod void myTest2(){
            //create Contact records to test
            Map<ID,Contact> oldMap = new Map<ID,Contact>();
            Map<ID,Contact> newMap = new Map<ID,Contact>();

            Account acct = new Account (Name='Home');
            insert acct;

            Contact acc = new Contact(AccountId=acct.Id,LastName = 'TestOld',npe01__Preferred_Email__c='Home',npe01__PreferredPhone__c ='Home');
            insert acc;

            WSContactTriggerHandler handler = new WSContactTriggerHandler(TRUE,1);

            Boolean ExecutingContext  = handler.IsTriggerContext;
            Boolean PageContext  = handler.IsVisualforcePageContext;
            Boolean WebContext  = handler.IsWebServiceContext;
            Boolean AnonymousContext  =  handler.IsExecuteAnonymousContext;

            delete acc;

            }
}