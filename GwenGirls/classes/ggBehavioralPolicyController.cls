public class ggBehavioralPolicyController {
    
     public String Value {get;set;}
    Public List<Intake__c> intakeList{get;set;}
    
     public ggBehavioralPolicyController(ApexPages.StandardController intake){
        Value = '&';

          intakeList = [SELECT Id, SSN__c, D_O_B__c, Height_feet__c,Weight_NUM__c,Race_TXT__c,Grade__c,Name_of_Clinet__c FROM Intake__c];
                        //where id =:currentRecordId];
                                                                                    
    }
}