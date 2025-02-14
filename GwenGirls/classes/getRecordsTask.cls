public class getRecordsTask {

    @AuraEnabled(cacheable=true)
    public static List<Task__c> gettasklist(){
        List<Task__c> getdetails = [Select Id , Name , title__c ,completed__c, priority__c ,Duedate__c ,Tags__c  from task__c ];
       // return getdetails;
        
        if(!getdetails.isEmpty()){
            System.debug('getTaskList' + getdetails);
            return getdetails;
        }else{
            return null;
        }
        
    }
    @Auraenabled
    Public static string updatetaskdetails(Object Taskdata){
        System.debug('Task Data : ' + Taskdata);
        List<Task__c> tasklist = (List<Task__c>)JSON.deserialize( 
            Json.serialize(Taskdata) , List<Task__c>.class
        );
        
        System.debug('Task Data : ' + tasklist);
        if(!tasklist.isEmpty()){
            update tasklist;
            return 'success';
        } else{
            return 'failed';
        }
    }
    
    @Auraenabled
    Public static void deleteTask(String recordId){
        try{
            system.debug('RecordId' + recordId);
            Task__c taskToDelete = [Select Id from Task__c WHERE Id =:recordId];
            delete taskToDelete;
        } catch(exception ex){
           throw new AuraHandledException('Error deleting task: ' + ex.getMessage());
        }
    }
    
}