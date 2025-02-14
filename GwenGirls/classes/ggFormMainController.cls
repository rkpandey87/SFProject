global without sharing class ggFormMainController {
    public static String intakeRecordId {get;set;}

  /*               Working                   */
  @AuraEnabled
  public static void saveIntakeData(string firstName,string lastName){
      // decimal ht
      system.debug('##First Name===========> '+firstName);
      system.debug('##Last Name===========> '+lastName);
      try{
          Intake__c inkRec= new Intake__c();
          inkRec.Name= 'GGTestForm';
          inkRec.First_Name__c=  firstName;
          inkRec.Last_Name__c= lastName;
          //'Test Youth last';
          //'Test Youth first';
          insert inkRec;
          intakeRecordId=inkRec.id;
          system.debug('##Intake__c===========> '+inkRec);
          system.debug('##intakeRecordId===========> '+intakeRecordId);
         
      }catch(Exception ex){
          throw new AuraHandledException(ex.getMessage());
      }

  }
  
}