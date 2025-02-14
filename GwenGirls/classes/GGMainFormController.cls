public without sharing class GGMainFormController {
  
        public static String intakeRecordId {get;set;}
        public static String conRecordId {get;set;}
        public static String parentId {get;set;}
    
      /*              
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


      @AuraEnabled
      public static void saveContactData(string firstName,string lastName, string Pin){
          // decimal ht
          system.debug('##First Name===========> '+firstName);
          system.debug('##Last Name===========> '+lastName);
          try{
            Contact conRec= new Contact();
              conRec.FirstName=  firstName;
              conRec.LastName= lastName;
              conRec.PIN__c	= Pin;
              insert conRec;
              conRecordId=conRec.id;
              system.debug('##Contact===========> '+conRec);
              system.debug('##conRecordId===========> '+conRecordId);
             
          }catch(Exception ex){
              throw new AuraHandledException(ex.getMessage());
          }
    
      }
              */

      @AuraEnabled(cacheable=true)
      public static List<wrapperList> filterContactRecAsPerRecType(string firstName,string lastName, string Pin){
        //Id recId
List<Contact> getParentList= [Select FirstName,LastName,PIN__c,email,birthdate from Contact where
                                  RecordType.Name='Parent/Guardian' and FirstName=:firstName and LastName=:lastName and PIN__c=:Pin];
                                  System.debug('##getParentList-----> '+getParentList);
         List<wrapperList> wprList= new List<wrapperList>();
         if(getParentList!=Null && getParentList.size()>0){
            for(Contact lct: getParentList){
                wrapperList wl= new wrapperList();
                wl.ggParentRecId= lct.Id;
                wl.email=lct.Email; 
                wl.birthdate=lct.Birthdate; 
                wl.LastName=lct.lastname; 
                parentId=  wl.ggParentRecId;
                wprList.add(wl);
                System.debug('##wprList-----> '+wprList);
                System.debug('##parentId-----> '+parentId);
            }
         }
        
         return wprList;
       }

      public class wrapperList{
        @AuraEnabled
        public string ggParentRecId{get;set;}
        @AuraEnabled
        public string email{get;set;}
        @AuraEnabled
        public string LastName{get;set;}
        @AuraEnabled
        public date birthdate{get;set;} 
        }
      
    }