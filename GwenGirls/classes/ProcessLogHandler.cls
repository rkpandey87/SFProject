public class ProcessLogHandler {
    @future
    public static void insertLog(String RelatedId,  String RelatedName, String Process, String Message, String Result)
    {   
        try{
            Processing_Log__c pl= new Processing_Log__c();
            pl.RelatedRecordId__c = RelatedId;
            pl.RelatedRecordName__c = RelatedName;
            pl.Process__c = Process;
            pl.Processing_Message__c = Message;
            pl.Processing_Result__c = Result;
            insert pl;
        }Catch(Exception e){
            System.Debug('Error Creating Process Log Entry: '+e.getMessage());
        }
    }
}