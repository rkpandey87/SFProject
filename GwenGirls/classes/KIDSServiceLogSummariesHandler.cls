/**********************************************************************
* Name:     KIDSServiceLogSummariesHandler
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     05 May 2017
* ======================================================
* ======================================================
* Purpose:                                                            
* KIDS Service Log Summary Trigger Handler - handles management of KIDS Service Log Summaries Trigger Logic
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       05 May 2017     TGM         Initial Development
***********************************************************************/
public class KIDSServiceLogSummariesHandler implements HandlerInterface{
    //Comes from trigger and trigger dispatcher TriggerDispatcher.Run(new KIDSServiceLogSummariesHandler());

    //Public Instance of WSCustom Admin Settings
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

    // Allows unit tests (or other code) to disable this trigger for the transaction
    public static Boolean TriggerDisabled = false;
    
    // Checks to see if the trigger has been disabled either by custom setting or by running code
    public Boolean IsDisabled(){
    
    Boolean  TriggerOff = getSettings().Turn_Off_KIDS_Srv_Log_Summaries_Trigger__c; //getSettings().Turn_Off_All_APEX_Triggers__c;

        if (TriggerOff == TRUE){

            return true;
        }

            return TriggerDisabled;
    }
    
    //BEFORE INSERT
    public void BeforeInsert(List<SObject> newItems) {

        Boolean  isOff = IsDisabled(); //getSettings().Turn_Off_All_APEX_Triggers__c;

        if(isOff == FALSE){ //Only do something if this portion of the trigger is not off

            //Cast the sObject list of newItems to a List of Service Log Summaries
            Schema.SObjectType sObjectType = newItems.getSObjectType();
            if (sObjectType != null){
                String listType = 'List<' + sObjectType + '>';
                List<SObject> thesums = (List<SObject>)Type.forName(listType).newInstance();
                thesums.addAll(newItems);

                KIDSServiceLogSummaryTools kslt = new KIDSServiceLogSummaryTools();
                kslt.attachtoLog(thesums);
            }

        }//End isOff

    } //Comes in as Trigger.new array of objects
 
    //BEFORE UPDATE
    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) { //Comes in as Trigger new map and Trigger old map
        
        Boolean  isOff = IsDisabled(); //getSettings().Turn_Off_All_APEX_Triggers__c;

        if(isOff == FALSE){ //Only do something if this portion of the trigger is not off

        }//End isOff    

    } //Comes in as Trigger old map

    //BEFORE DELETE
    public void BeforeDelete(Map<Id, SObject> newItems) { //Comes in as Trigger new map

        Set<Id> theids = new Set<Id>();

        for(Id theid : newItems.keyset()){
            theids.add(theid);
        }
        
        Boolean  isOff = IsDisabled(); //getSettings().Turn_Off_All_APEX_Triggers__c;

        if(isOff == FALSE){ //Only do something if this portion of the trigger is not off

            KIDSServiceLogSummaryTools kslt = new KIDSServiceLogSummaryTools();
            kslt.deleteContactSummaries(theids);

        }//End isOff

    } //End Before Delete deleteContactSummaries 

 
    //AFTER INSERT
    public void AfterInsert(Map<Id, SObject> newItems) { //Comes in as Trigger new map

        Set<Id> theids = new Set<Id>();

        for(Id theid : newItems.keyset()){
            theids.add(theid);
        }
        
        Boolean  isOff = IsDisabled(); //getSettings().Turn_Off_All_APEX_Triggers__c;

        if(isOff == FALSE){ //Only do something if this portion of the trigger is not off

            KIDSServiceLogSummaryTools kslt = new KIDSServiceLogSummaryTools();
            kslt.createContactSummaries(theids);

        } //End isOff

    }//End After Insert
 
    //AFTER UPDATE
    public void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) { //Comes in as Trigger New Map Trigger Old Map

         Boolean  isOff = IsDisabled(); //getSettings().Turn_Off_All_APEX_Triggers__c;

        if(isOff == FALSE){ //Only do something if this portion of the trigger is not off

        }//End isOff

    }//End After Update
 
    //AFTER DELETE
    public void AfterDelete(Map<Id, SObject> oldItems) { //Comes in as Trigger Old Map

         Boolean  isOff = IsDisabled(); //getSettings().Turn_Off_All_APEX_Triggers__c;

        if(isOff == FALSE){ //Only do something if this portion of the trigger is not off

        }//End isOff

    }//End After Delete
 
    //AFTER UNDELETE
    public void AfterUndelete(Map<Id, SObject> oldItems) { //Comes in as Trigger Old Map

        Set<Id> theids = new Set<Id>();

        for(Id theid : oldItems.keyset()){
            theids.add(theid);
        }
        
        Boolean  isOff = IsDisabled(); //getSettings().Turn_Off_All_APEX_Triggers__c;

        if(isOff == FALSE){ //Only do something if this portion of the trigger is not off

            KIDSServiceLogSummaryTools kslt = new KIDSServiceLogSummaryTools();
            kslt.undeleteContactSummaries(theids);

        }//End isOff

    }//End After Undelete
    
    /**
     * and Finally Turn_Off_Payment_andFinally__c
     *
     * This method is called once all records have been processed by the trigger. Use this
     * method to accomplish any final operations such as creation or updates of other records.
     *
     * Payment Rollups on SO or Account for instance
     *
     **/

    //AND FINALLY
    public void andFinally(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){

         Boolean  isOff = IsDisabled(); //getSettings().Turn_Off_All_APEX_Triggers__c;

        if(isOff == FALSE){ //Only do something if this portion of the trigger is not off

        }//End isOff

    }//End andFinall

}