public without sharing class testDemoCC {
@AuraEnabled
public static void createContact(String childFirst, String childLast, Date birthDate,String parentFirst, String parentLast,String numberParent){

List<Contact> createList = new List<Contact>();
// Query the Record Type ID
Id recordTypeId = [Select RecordTypeId from contact where RecordType.name = 'Parent/Guardian' LIMIT 1].RecordTypeId;
Id recordTypeId2 = [Select RecordTypeId from contact where RecordType.name = 'Child (CC)' LIMIT 1].RecordTypeId;


Contact con = new Contact();
con.FirstName = parentFirst;
con.LastName = parentLast;
con.RecordTypeId = recordTypeId;
con.HomePhone = numberParent;
insert con;

Contact con1 = new Contact();
con1.FirstName = childFirst;
con1.LastName = childLast;
con1.Birthdate = birthDate;
con1.Name_of_Primary_Parent_Guardian__c = con.Id;
con1.RecordTypeId = recordTypeId2;
createList.add(con1);

if(createList.size()>0){
  insert createList;
}

} 

@auraEnabled(cacheable=true)
public static List<Wrapper> getChildRec(String parentRecId){
List<Wrapper> wrapList = new List<Wrapper>();

List<Contact> conList = [Select FirstName,LastName,Name_of_Primary_Parent_Guardian__r.FirstName
                        ,Name_of_Primary_Parent_Guardian__r.LastName,Name_of_Primary_Parent_Guardian__r.HomePhone,birthdate  
                        from Contact where RecordType.Name='Child (CC)' and 
                        Name_of_Primary_Parent_Guardian__c =:parentRecId];
                
   if(conList.size()>0){
    for(Contact con:conList){
      Wrapper wrap = new Wrapper();
      wrap.childFirst = con.FirstName;
      wrap.childLast = con.LastName;
      wrap.childDOB = con.birthdate;
      wrap.parentFirst = con.Name_of_Primary_Parent_Guardian__r.FirstName;
      wrap.parentLast = con.Name_of_Primary_Parent_Guardian__r.LastName;
      wrap.parentNumber = con.Name_of_Primary_Parent_Guardian__r.HomePhone;
      wrapList.add(wrap);
    }
   }
   else{
    Wrapper wrap1 = new Wrapper();
    wrap1.childFirst = null;
    wrap1.childLast = null;
    wrap1.childDOB = null;
    wrap1.parentFirst = null;
    wrap1.parentLast = null;
    wrap1.parentNumber = null;
    wrapList.add(wrap1);
   }
return wrapList;

}




@AuraEnabled(cacheable=true)
public static List<String> getNeighborPickListValue(){
try {
List<String> pickListValuesList= new List<String>();

Schema.DescribeFieldResult fieldResult = Contact.Neighborhood_CC__c.getDescribe();

List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();

for( Schema.PicklistEntry pickListVal : ple){

pickListValuesList.add(pickListVal.getValue());

}     

return pickListValuesList;

} catch (Exception e) {
throw new AuraHandledException(e.getMessage());
}
}


@AuraEnabled(cacheable=true)
public static List<User> getUserName(){
try {
List<User> userList = [SELECT Id,FirstName,LastName FROM User WHERE IsActive = true];
System.debug('UserList==> '+userList);
return userList;
} catch (Exception e) {
throw new AuraHandledException(e.getMessage());
}
}

public class Wrapper{
@AuraEnabled
public string childFirst{get;set;}
@AuraEnabled
public string childLast{get;set;}
@AuraEnabled
public Date childDOB{get;set;}
@AuraEnabled
public string parentFirst{get;set;}
@AuraEnabled
public string parentLast{get;set;}
@AuraEnabled
public string parentNumber{get;set;}

}

}