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

public with sharing class WSContactTriggerHandler {
	private boolean m_isExecuting = false;
	private integer BatchSize = 0;
	
	public WSContactTriggerHandler(boolean isExecuting, integer size){
		m_isExecuting = isExecuting;
		BatchSize = size;
	}
	
	public void OnBeforeInsert(Contact[] newRecords){
	}
	
	public void OnAfterInsert(Contact[] newRecords){
	}
	
	@future public static void OnAfterInsertAsync(Set<ID> newRecordIDs){
	}
	
	public void OnBeforeUpdate(Contact[] oldRecords, Contact[] updatedRecords, Map<ID, Contact> recordMap){
	}
	
	public void OnAfterUpdate(Contact[] oldRecords, Contact[] updatedRecords, Map<ID, Contact> oldRecordMap,  Map<ID, Contact> newRecordMap){
		WSAdvancedFieldHistoryAction.RecordFieldChanges(oldRecordMap, newRecordMap);
	}
	
	@future public static void OnAfterUpdateAsync(Set<ID> updatedRecordIDs){
	}
	
	public void OnBeforeDelete(Contact[] recordsToDelete, Map<ID, Contact> recordMap){
	}
	
	public void OnAfterDelete(Contact[] deletedRecords, Map<ID, Contact> recordMap){
	}
	
	@future public static void OnAfterDeleteAsync(Set<ID> deletedRecordIDs){
	}
	
	public void OnUndelete(Contact[] restoredRecords){
	}
	
	public boolean IsTriggerContext{
		get{ return m_isExecuting;}
	}
	
	public boolean IsVisualforcePageContext{
		get{ return !IsTriggerContext;}
	}
	
	public boolean IsWebServiceContext{
		get{ return !IsTriggerContext;}
	}
	
	public boolean IsExecuteAnonymousContext{
		get{ return !IsTriggerContext;}
	}
}