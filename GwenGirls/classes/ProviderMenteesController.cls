/**
 * @description       : 
 * @author            : WINSupport
 * @group             : 
 * @last modified on  : 01-03-2022
 * @last modified by  : WINSupport
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   06-12-2021   WINSupport   Initial Version
**/
global class ProviderMenteesController {
    global Contact contactEdit {
        get;
        set;
    }
    global String contactId {
        get;
        set;
    }
    global String recordId {
        get;
        set;
    }
    global String sessionId {
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
        

        global ProviderMenteesController(){

            //sessionId = UserInfo.getOrganizationId()+''+UserInfo.getSessionId().SubString(15);
                Map<String,System.Cookie> cookies = ApexPages.currentPage().getCookies();
                if(Test.isRunningTest()){
                    WSCustomAdminSettings__c settings = WSCustomAdminSettings__c.getInstance();
                    String  defaultId = settings.DefaultProviderContactId__c;
                    Cookie cook = new Cookie('contactIdPersonalSite', defaultId, null, -1, false);
                    cookies.put('contactIdPersonalSite',cook);
                }
                if(!cookies.isEmpty() && cookies != NULL){
                    System.Debug('*** cookies ***'+cookies);
                    if(cookies.containsKey('contactIdPersonalSite')){
                        recordId = cookies?.get('contactIdPersonalSite')?.getValue();
                        contactId = cookies?.get('contactIdPersonalSite')?.getValue();
                        System.Debug('*** recordId  ***'+recordId);
                    }
                }

        }
}