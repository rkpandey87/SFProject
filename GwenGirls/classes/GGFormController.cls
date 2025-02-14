public without sharing  class GGFormController {
    
    @AuraEnabled(cacheable=true )
    public static List<Account> getSchoolPicklist(){ 
       return [Select Id,Type,Name From Account Where Type='School' Limit 5] ; 
    }
    
    @AuraEnabled(cacheable=true )
    public static  List<CaringConnectionsFormController.fieldsWrapper> getSiteUsers(){ 
       List<CaringConnectionsFormController.fieldsWrapper> listOfFieldWrapper=new List<CaringConnectionsFormController.fieldsWrapper>();
        for(User us: [Select id,FirstName,LastName from user Where Name ='Black Girls Advocacy Leadership Alliance' OR Name='Prevention- Clairton' OR Name='Prevention- Northside' OR Name='Prevention- Wilkinsburg']){
            CaringConnectionsFormController.fieldsWrapper fieldWrapp=new CaringConnectionsFormController.fieldsWrapper();
            fieldWrapp.label=us.LastName;
            fieldWrapp.value=us.Id;
            listOfFieldWrapper.add(fieldWrapp);
        }
       return listOfFieldWrapper;
    }
    
    
    
    @AuraEnabled
    public static contact upsertParentContact(String parentContactString){
        Contact conObj=(Contact)JSON.deserialize(parentContactString,Contact.class);
        conObj.RecordTypeId=Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId(); 
       upsert conObj;
        return conObj;
    }
    
    @AuraEnabled
    public static Boolean createIntake(String listOfIntakeString){
        system.debug('##listOfIntakeString===>'+listOfIntakeString);
        if(listOfIntakeString!=null){
            List<Intake__c> listOfIntake=(List<Intake__c>)JSON.deserialize(listOfIntakeString, List<Intake__c>.class);
           insert listOfIntake;
            return true;
        }
         return false;    
    }
    
    @AuraEnabled
    public static contactIntakeWrapper getExistingRecords(String contactId){
        contactIntakeWrapper cIWrapper=new contactIntakeWrapper();
        cIWrapper.parentContact=[Select Id, FirstName,LastName,Name_of_Primary_Parent_Guardian__c,HomePhone,Email,OwnerId from Contact where RecordType.Name='Parent/Guardian' and Id=:contactId];
        cIWrapper.childContact= [Select FirstName,Grade__c,LastName,Name_of_Primary_Parent_Guardian__r.FirstName ,Name_of_Primary_Parent_Guardian__r.LastName,Name_of_Primary_Parent_Guardian__r.HomePhone,
                                 birthdate,School__c,case__c,Community_Activities__c  from Contact where RecordType.Name='Client' and Name_of_Primary_Parent_Guardian__c=:contactId and Name_of_Primary_Parent_Guardian__c!=NULL]; 
        return cIWrapper;
    }
    
    public class contactIntakeWrapper{
       @AuraEnabled
       public contact parentContact;
       @AuraEnabled
       public List<Contact> childContact ;
    }
}