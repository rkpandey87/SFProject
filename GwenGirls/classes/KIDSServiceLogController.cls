public class KIDSServiceLogController {
 
    // Constructor - this only really matters if the autoRun function doesn't work right
    private final KIDS_Service_Log__c l;

    public KIDS_Service_Log__c currentRecord{get; set;}
    
    public KIDSServiceLogController(ApexPages.StandardController stdController) {
        currentRecord = [SELECT Id, Name FROM KIDS_Service_Log__c WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
    }
     
    // Code we will invoke on page load.
    public PageReference autoRun() {
 
        String theId = currentRecord.Id;
 
        //if (theId == null) {
            // Display the Visualforce page's content if no Id is passed over
            //return null;
        //}else{

            KIDSServiceLogTools.processLog(theId);
        //}
 
        // Redirect the user back to the original page
        PageReference pageRef = new PageReference('/' + theId);
        pageRef.setRedirect(true);
        return pageRef;
 
    }
 
}