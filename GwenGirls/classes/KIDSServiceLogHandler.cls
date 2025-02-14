/**********************************************************************
* Name:     KIDSServiceLogHandler
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     19 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* KIDS Service Log Trigger Handler - handles management of KIDS Service Log Trigger Logic
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       19 Dec 2016     TGM         Initial Development
***********************************************************************/
public class KIDSServiceLogHandler implements HandlerInterface{
    //Comes from trigger and trigger dispatcher TriggerDispatcher.Run(new LinvioPaymentTriggerHandler());

    //Public Instance of WSCustom Admin Settings
    //public static WS_Custom_Admin_Settings__c thesettings;

    /*public WS_Custom_Admin_Settings__c getSettings(){

        WS_Custom_Admin_Settings__c settings = WS_Custom_Admin_Settings__c.getInstance();

        if(thesettings == NULL){
            
            thesettings = settings;
            return thesettings;

        }else{
            return thesettings;
        }

    }*/

    // Allows unit tests (or other code) to disable this trigger for the transaction
    public static Boolean TriggerDisabled = false;
    
    // Checks to see if the trigger has been disabled either by custom setting or by running code
    public Boolean IsDisabled(){
    
    Boolean  AllTriggersOff = FALSE; //getSettings().Turn_Off_All_APEX_Triggers__c;

        if (AllTriggersOff == TRUE){

            return true;
        }

            return TriggerDisabled;
    }
    
    public void BeforeInsert(List<SObject> newItems) {} //Comes in as Trigger.new array of objects
 
    public void BeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {} //Comes in as Trigger new map and Trigger old map
 
    public void BeforeDelete(Map<Id, SObject> oldItems) {} //Comes in as Trigger old map
 
    public void AfterInsert(Map<Id, SObject> newItems) { //Comes in as Trigger new map

        Boolean  isOff = FALSE; //getSettings().Turn_Off_All_APEX_Triggers__c;

        if(isOff == FALSE){ //Only do something if this portion of the trigger is not off

    	}//End is Off

}//End After Insert
 
    public void AfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) { //Comes in as Trigger New Map Trigger Old Map
        
        Boolean  isOff = FALSE; //getSettings().Turn_Off_All_APEX_Triggers__c;

        if(isOff == FALSE){ //Only do something if this portion of the trigger is not off

        } //End isOff

    }//End After Update
 
    public void AfterDelete(Map<Id, SObject> oldItems) { //Comes in as Trigger Old Map

        Boolean  isOff = FALSE; //getSettings().Turn_Off_All_APEX_Triggers__c;

        if(isOff == FALSE){ //Only do something if this portion of the trigger is not off

        }//End isOff

    }//End After Delete
 
    public void AfterUndelete(Map<Id, SObject> oldItems) { //Comes in as Trigger Old Map

        Boolean  isOff = FALSE; //getSettings().Turn_Off_All_APEX_Triggers__c;

        if(isOff == FALSE){ //Only do something if this portion of the trigger is not off

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

    public void andFinally(Map<Id, SObject> newItems, Map<Id, SObject> oldItems){

        Boolean  isOff = FALSE; //getSettings().Turn_Off_All_APEX_Triggers__c;

        if(isOff == FALSE){ //Only do something if this portion of the trigger is not off

        }//End isOff

    }//End andFinall

}