public without sharing class LwcLookupController {
  
    @AuraEnabled(cacheable=true) 
    public static List<sobject> findRecords(String searchKey, String objectName) {  
        string searchText = '\'' + String.escapeSingleQuotes(searchKey) + '%\'';  
        return Database.query('SELECT Id, Name FROM ' +objectName+ ' WHERE Type=\'School\' and Name LIKE '+searchText+'');  
    } 
    
}