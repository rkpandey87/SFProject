public without sharing class MplcPermissionSlipForm {

     public String studentName { get; set; }
     public Boolean renderAsPDF { get; set; }
    public Boolean Newcomer{get;set;}
     public Boolean checkWired{get;set;}
    public boolean termsAndConditions {get;set;}
    public date studentbirthday { get; set; }
    public String  homephone { get; set; }
      public String selectedOption { get; set; }
      public String selectedOption1 { get; set; }
    public List<Intake__c> intakeList { get; set; }
    public Id intakeRecordId { get; set; }
      public boolean flag {get;set;}
       public String signatureinput522 { get; set; }
    public String signName522 { get;set;}
    
    Id MtMPLC = Schema.SObjectType.Intake__c.getRecordTypeInfosByName().get('MPLC').getRecordTypeId();

   public MplcPermissionSlipForm(ApexPages.StandardController intake) {
        // Constructor logic, if any
        flag = false;

      
       checkWired = false;
        renderAsPDF = false;

    }


    /*public List<SelectOption> getOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('My daughter may participate in the Gwen’s Girls program. Please contact me for', 'My daughter may participate in the Gwen’s Girls program. Please contact me for'));
        options.add(new SelectOption('My daughter may not participate in the Gwen’s Girls program.', 'My daughter may not participate in the Gwen’s Girls program.'));
        return options;
    }*/

    public void setSignature522() {
        signName522 = signName522;
    }

    public PageReference MPLCSave() {
        try {
            // Create a new Intake record
            Intake__c newIntake1 = new Intake__c();
             newIntake1.RecordTypeId = MtMPLC;
            newIntake1.Name = 'MPLC444';
            newIntake1.First_Name__c = studentName;
            newIntake1.Birthdate__c = studentbirthday;
            newIntake1.Home_Phone__c = homephone;
            newIntake1.mplc_Signature__c=signName522;

            // Insert the new Intake record
            insert newIntake1;
             if (renderAsPDF) {
                // Additional logic specific to PDF rendering
                // For example, set additional fields or perform actions
            }

            intakeRecordId = newIntake1.Id;

            intakeList = [SELECT Id, Name
                            ,mplc_Student_Name__c
                            ,Birthdate__c
                            ,Home_Phone__c
                            ,mplc_Signature__c FROM Intake__c where id =: newIntake1.Id];

            if (intakeList != NULL && intakeList.size() > 0) {
                signName522 = intakeList[0].mplc_Signature__c;
            }
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Intake record created successfully.'));
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error creating Intake record: ' + e.getMessage()));
        }

        // Redirect to the same page or any other page as needed
        return null;
    }
}