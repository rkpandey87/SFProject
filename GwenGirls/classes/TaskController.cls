/*public class TaskController {
    @AuraEnabled
    public static void saveTask(String title, Boolean completed, String priority, List<String> tags) {
        Task__c newTask = new Task__c(
            Title__c = title,
            Completed__c = completed,
            Priority__c = priority,
            Tags__c = String.join(tags, ';')  // Convert tags list to a semicolon-separated string
        );
        insert newTask;
    }
}
*/

public class TaskController {
        @AuraEnabled
    public static void saveTask(String title, Boolean Completed,  String priority, list<string> tags , Date Duedate) {
        System.debug('### saveTask method called ###');
         System.debug('### saveTask method called ###' + title);
         System.debug('Tags' + tags );
        System.debug('Completed => value' + completed);
        
        try {
            Task__c newTask = new Task__c();
                newTask.Title__c = title;
                newTask.Completed__c = Completed;
                newTask.Priority__c = priority;
               //newTask.Tags__c = tags;
              //newTask.Tags__c = String.join(tags, ',');
              newTask.Tags__c = String.join(tags, ';');


                newTask.Duedate__c = Duedate;
                
            
            
            /* if (tags != null && !tags.isEmpty()) {
                newTask.Tags__c = new List<String>();
                newTask.Tags__c.addAll(tags);
            }
*/
            insert newTask;
            
            System.debug('### Task record saved successfully ###');
        } catch (Exception ex) {
            System.debug('### Error saving Task record: ' + ex.getMessage() + ' ###');
            throw ex;
        }
    }
}