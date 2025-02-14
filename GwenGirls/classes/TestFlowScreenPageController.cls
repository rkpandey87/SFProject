/**
 * @description       : 
 * @author            : WINSupport
 * @group             : 
 * @last modified on  : 10-01-2021
 * @last modified by  : WINSupport
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   06-12-2021   WINSupport   Initial Version
**/
global class TestFlowScreenPageController {
    global String conId = '0030100000AbEDTAA3';
    global void callFlow(){
        WSCustomAdminSettings__c settings = WSCustomAdminSettings__c.getInstance();
        String  thisconId = settings.DefaultProviderContactId__c;

        Map<String, String> myMap = new Map<String, String>();
        myMap.put('recordId', thisconId);

        Flow.Interview.ContactAvailabilityScreen flow1 = new Flow.Interview.ContactAvailabilityScreen(myMap);
        if(!Test.isRunningTest()){
            flow1.start();
        }
        
    }
    global Contact contactEdit {
        get;
        set;
    }
    global Id contactId {
        get;
        set;
    }
    global String strLanguage {
        get;
        set;
    }
    global Provider_Availability__c ProviderId {
         get;
        set;
    }
    global Program_Participant__c ProgramId {
        get;
        set;
    }
}