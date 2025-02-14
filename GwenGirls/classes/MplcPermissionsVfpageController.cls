public without sharing class MplcPermissionsVfpageController {
    public date DateOfSignature{get;set;}
    public Boolean isParticipate{get;set;}
    public Boolean isPdfMode { get; set; }
    
    public List<SelectOption> options = new List<SelectOption>();
    public Intake__c Intake{get;set;}
    
    public MplcPermissionsVfpageController() {
        DateOfSignature = system.today();
        isParticipate = null;
        isPdfMode = true;
        if(ApexPages.currentPage().getParameters().containsKey('id') ) {
            string recordId = ApexPages.currentPage().getParameters().get('id');
            getData(recordId);
        }
    }
    
    public List<SelectOption> getOptions() {        
        options.add(new SelectOption('true','My daughter may participate in the Gwen’s Girls program. Please contact me for social security information.'));
        options.add(new SelectOption('false','My daughter may not participate in the Gwen’s Girls program.'));
        return options; 
    } 
    
    public void getData(string recordId) {
        Intake = [Select First_Name__c
                  , Birthdate__c
                  , Home_Phone__c
                  , mplc_Signature__c
                  ,Last_Name__c
                  ,Primary_Guardian_First__c
                  , Community_Activities__c
                  , DateOfSignature__c
                  from Intake__c where Id=:recordId];
        system.debug('Intake Record ==> '+Intake);
        if(Intake!= null) {
            isParticipate = Intake.Community_Activities__c;
        }
    }
}