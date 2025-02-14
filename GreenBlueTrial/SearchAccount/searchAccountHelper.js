({      
    getAccountList: function(component) {
        var action = component.get('c.getAccounts');
        var self = this;
        action.setCallback(this, function(actionResult) {
            component.set('v.accounts', actionResult.getReturnValue());
        });
        $A.enqueueAction(action);
    },
     reloadData : function(component, event, helper)
 {
  var action=component.get("c.getDisplayData");
        action.setParams({
            'searchKeyWord':event.getParam("picklistValue")
        });
        action.setCallback(this,function(response){
       
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS")
   {
              component.set("v.recordCount", response.getReturnValue());
                component.set("v.accounts", response.getReturnValue());
            }   
            else
   {
                alert('Error in fetching the result from data base');           
            }

        });
        $A.enqueueAction(action);
 }
    
})