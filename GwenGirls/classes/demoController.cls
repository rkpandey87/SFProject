global without sharing class demoController {
    
    public demoController(ApexPages.StandardController Intake) {
        if(ApexPages.currentPage().getParameters().containsKey('id') ) {
            string recordId = ApexPages.currentPage().getParameters().get('id');
        }
    }    
}