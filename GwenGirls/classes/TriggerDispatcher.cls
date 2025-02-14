/**********************************************************************
* Name:     TriggerDispatcher
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     06 Feb 2017
* ======================================================
* ======================================================
* Purpose:                                                            
* Trigger Handler Dispatcher for Dispatching of Trigger Handlers via the HandlerInterface
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       06 Feb 2017     TGM         Initial Development
***********************************************************************/
public class TriggerDispatcher 
{
    /*
        Call this method from your trigger, passing in an instance of a trigger handler which implements ITriggerHandler.
        This method will fire the appropriate methods on the handler depending on the trigger context.
    */
    public static void Run(HandlerInterface handler)
    {
        // Check to see if the trigger has been disabled. If it has, return
        // If I wanted to stop this trigger from firing while in a unit test, I could just add the following code to the test:
        // AccountTriggerHandler.TriggerDisabled = true;

        if (handler.IsDisabled())
            return;
        
        // Handle exceptions using TriggerException class .... throw new TriggerException('No Trigger Handler registered for Object Type: ' + soType);

        // Detect the current trigger context and fire the relevant methods on the trigger handler:
        
        
        // Before trigger logic
        if (Trigger.IsBefore )
        {
            if (Trigger.IsInsert)
                handler.BeforeInsert(trigger.new);
 
            if (Trigger.IsUpdate)
                handler.BeforeUpdate(trigger.newMap, trigger.oldMap);
 
            if (Trigger.IsDelete)
                handler.BeforeDelete(trigger.oldMap);
        }
        
         
        // After trigger logic
        if (Trigger.IsAfter)
        {
            if (Trigger.IsInsert)
                handler.AfterInsert(Trigger.newMap);
 
            if (Trigger.IsUpdate)
                handler.AfterUpdate(trigger.newMap, trigger.oldMap);
 
            if (trigger.IsDelete)
                handler.AfterDelete(trigger.oldMap);
 
            if (trigger.isUndelete)
                handler.AfterUndelete(trigger.newMap);

        }
        
        /**
        * and Finally
        *
        * This method is called once all records have been processed by the trigger. Use this
        * method to accomplish any final operations such as creation or updates of other records.
        */

        handler.andFinally(trigger.newMap, trigger.oldMap);

    }
}