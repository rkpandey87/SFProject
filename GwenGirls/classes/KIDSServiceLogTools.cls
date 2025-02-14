/**********************************************************************
* Name:     KIDSServiceLogTools
* Author:   World-Class Industrial Network, LLC (www.winnets.com)
* Date:     19 Dec 2016
* ======================================================
* ======================================================
* Purpose:                                                            
* KIDSServiceLog Tools - class with related methods for operating on KIDS Service Logs
*                                                            
* ======================================================
* ======================================================
* History:                                                            
* VERSION   DATE            INITIALS    DESCRIPTION/FEATURES ADDED
* 1.0       19 Dec 2016     TGM         Initial Development
* 2.0       01 Jan 2018     TGM         P&D Revisions Testing
* 3.0       14 Feb 2018     TGM         Finalization PD and NonPD Methods
***********************************************************************/
public class KIDSServiceLogTools{

    public static Map<Integer,KIDS_Service_Log_Entry__c> theentrymap;
    public static Map<Integer,Blob> theblobmap;
    public static Map<Integer,String> thestringmap;
    public static KIDS_Service_Log__c thelog;
    public static List<String> strings;
    public static String thetype;

    /*webservice static Integer serviceProcessLog(String theid){

    }*/

    public static void processLog(Id theid){

        //theentrymap = generateEntryMap(theid); //Generate the Entry Map
        //thestringmap = generateStringMap(theentrymap); //Generate the String Map
        //theblobmap = generateBlobMap(thestringmap); //Generate the Blob Map
        
        //generateAttachments(generateBlobMap(generateStringMap(generateEntryMap(theid))),theid); //Generate the final attachements

        generateAttachments(generateStringMap(generateEntryMap(theid)),theid);
        
        //updateParentLog(theid,'Message','Status',date.today()); //Update the parent log after processing

    }

    public KIDS_Service_Log__c getServiceLog(Id theid){

        KIDS_Service_Log__c thislog = new KIDS_Service_Log__c(); //A Service Log

        SObjectType logType = Schema.getGlobalDescribe().get('KIDS_Service_Log__c'); //Describe the KIDS Service Log Object
        Map<String,Schema.SObjectField> logFields = logType.getDescribe().fields.getMap(); //A Map of Fields on KIDS Service Log

        //Create the select string
        string logselect = 'Select ';

        for(string l : logFields.keyset()){
            logselect = logselect + logFields.get(l) + ', ';
        }

        logselect = logselect.substring(0,logselect.length()-2);
        logselect = logselect + '';
        logselect = logselect + ' FROM KIDS_Service_Log__c WHERE Id =: theid';

        try{
            thislog  = (KIDS_Service_Log__c)Database.query(logselect); //Query for the log
        }catch(Exception e){
            system.debug('***********************ERROR Querying KIDS Service Log ***********************' + e.getMessage());
        }

        if(thislog !=NULL){

            return thislog;
            
        }else{

            return NULL;
        }


    }

    public static void updateParentLog(Id theid, String theMessage, String theStatus, Date thedate){

        // Create a savepoint
        Savepoint sp = Database.setSavepoint();

        // Rollback to the previous database point
        Database.rollback(sp);
    }

    public static void generateAttachments(List<String> thestrings, Id theid){

        //Attache each blob as a pipe delimited file to the parent record identifeid by theid

        // Create a savepoint
        //Savepoint sp = Database.setSavepoint();

        KIDS_Service_Log__c thislog = [SELECT Id, Generate_Error_Correction_Log_Only__c,  Status__c, Most_Recent_File_Result__c, Most_Recent_File_Id__c, 
        Date_Time_Most_Recent_File__c,  Most_Recent_File_Generated_By__c FROM KIDS_Service_Log__c WHERE Id =: theid];

        //Other Variables
        List<Attachment> theatts = new List<Attachment>(); //The List of Attachments
        List<KIDS_Service_Log_Entry__c> entries = new List<KIDS_Service_Log_Entry__c>(); //A List of Entries

        Integer i = 1;


        //Create A Query String for KIDS Service Log Entries
        SObjectType entrytype = Schema.getGlobalDescribe().get('KIDS_Service_Log_Entry__c');
        Map<String,Schema.SObjectField> entryfields = entrytype.getDescribe().fields.getMap(); //A Map of Fields

        string entryselect = 'Select ';

        for(string pd : entryfields.keyset()){
            entryselect = entryselect + entryfields.get(pd) + ', ';
        }
        entryselect = entryselect.substring(0,entryselect.length()-2);
        entryselect = entryselect + '';

        if(thislog.Generate_Error_Correction_Log_Only__c == TRUE){//Corrected - Submitted Revision To KIDS
            String thestatus = 'Corrected - Submitted Revision To KIDS';
            entryselect = entryselect + ' FROM KIDS_Service_Log_Entry__c WHERE Status__c =: thestatus AND KIDS_Service_Log__c =: theid ORDER BY Row_ID__c ASC';
        }else if(thislog.Generate_Error_Correction_Log_Only__c == FALSE){//Uncorrected Log
            entryselect = entryselect + ' FROM KIDS_Service_Log_Entry__c WHERE KIDS_Service_Log__c =: theid ORDER BY Row_ID__c ASC';
        }

        try{
            entries = (KIDS_Service_Log_Entry__c[])Database.query(entryselect); //The list of KIDS Service Log Entries
        }catch(Exception eks){
            system.debug('***********************ERROR Querying KIDS Service Log Entries ***********************' + eks.getMessage());
        }

        //for(Integer i = 1; i < blobmap.size(); i++){

            //if(blobmap.get(i) != NULL){

                //Blob theBlob = blobmap.get(i);

                for(String s : thestrings){

                Blob theblob = Blob.valueOf(s);
                //blobmap.put(i,theblob); //Populate the Blob Map
                
                String thename;
                thename = '567_GwensGirls_PDserviceLog_'+System.now().format('MM-dd-')+ '.psv';
                
                Attachment att = new Attachment(Body = theBlob, //Attache the Blob
                                      Name =  thename, //Name the file ... theid
                                      parentId = theid); //Set the Parent Id

                theAtts.add(att); //Add the attachment to the list of attachments to be created

                }

            //} //End if blobmap.get(i) != NULL

        //} //End for Integer i = 1; i < blobmap.size(); i++

        

        if(!theAtts.isEmpty()){

            Database.SaveResult[]  sr = Database.Insert(theAtts, false); //Insert the list of Attachments

            for(Database.SaveResult s : sr){ //Cycle through the save results


        
                if(s.isSuccess()){ //Do something if the insert is a success

                        String newattid = s.getId();

                        thislog.Status__c = 'Generated';
                        thislog.Most_Recent_File_Id__c = newattid;
                        thislog.Most_Recent_File_Result__c = 'Successfully Generated';
                        thislog.Date_Time_Most_Recent_File__c = DateTime.now();
                        thislog.Most_Recent_File_Generated_By__c = UserInfo.getUserId();

                        try{
                            update thislog;
                        }catch(Exception lge1){
                            System.Debug('************** Error Updating Log after Attachment *************'+lge1.getMessage());
                        }

                        if(!entries.isEmpty()){
                            for(KIDS_Service_Log_Entry__c ksle : entries){
                                ksle.Status__c = 'Pending - Service Log File Generated';
                            }
                        }

                        try{
                            update entries;
                        }catch(Exception eus){
                            System.Debug('***************** Error Updating KIDS Service Log Entries *************' + eus.getMessage());
                        }
            
                }else{ //Do something if the insert is not a success

                        thislog.Most_Recent_File_Result__c = 'Error Generating Attachment - Could Not Process Information';

                        try{
                            update thislog;
                        }catch(Exception lge2){
                            System.Debug('************** Error Updating Log after Attachment *************'+lge2.getMessage());
                        }

                }//End Else

            }//End for Database.SaveResult
            
        }//End !theAtts.isEmpty/()

        else{ //Do something if the list of Attachments is NULL

            thislog.Most_Recent_File_Result__c = 'Error Generating Attachment - No Attachement to Create';

            try{
                update thislog;
            }catch(Exception lge3){
                System.Debug('************** Error Updating Log after Attachment *************'+lge3.getMessage());
            }

        }

    }

    /*public static Map<Integer,Blob> generateBlobMap(Map<Integer,String> stringmap){

        //For each occurence in the stringmap generate a blob
        //Get the map size
        //Iterate through the map to the first 500 entries for the first batch then start the next batch

        Map<Integer,Blob> blobmap = new Map<Integer,Blob>(); //The blob map

        for(Integer i = 1; i < stringmap.size(); i++){

            String thestring = stringmap.get(i);

            if(thestring != NULL){
                Blob theblob = Blob.valueOf(thestring);
                blobmap.put(i,theblob); //Populate the Blob Map

            }else{
                Blob theblob = Blob.valueOf('No String To Convert');
                blobmap.put(i,theblob); //Populate the Blob Map
            }

        }

        if(blobmap.size()>0){
            return blobmap;
        }else{

            System.Debug('------------ ERROR BLOB MAP GENERATED -------------');

            Map<Integer,Blob> errormap = new Map<Integer,Blob>(); //The error map
            errormap.put(1, NULL);
            return errormap; // Return the error map
        }

    }*/

    public static List<String> generateStringMap(List<KIDS_Service_Log_Entry__c> entries) {

        //Take the Map of Service Log Entries and Generate a String for Each Batch of 500 Entries
        /*
        Row ID
        Service Episode ID 
        Service Structure ID 
        Service Rendered  -- Date Provide the date on which the service was rendered. Date format mmddyyyy
        Service Start Time -- Provide the service start time of the service in mmddyyyyhhmmss (24 hr format)
        Service End Time -- Provide the service end time of the service in mmddyyyyhhmmss (24 hr format)
        Target Client ID
        Program ID
        Facility ID
        Unit Type 
        Unit 
        Activity 
        Contact Type 
        Comments 
        Requesting Worker
        Approving Worker
        */

        //Map<Integer,String> stringmap = new Map<Integer,String>(); //The String Map
        List<String> somestrings = new List<String>();

        String s; // A String

        for(KIDS_Service_Log_Entry__c e : entries){ //FOR LOOP 1

            String thetype = e.RecordTypeName__c;

            String k;

            if(e.Comments__c != NULL){
                k = e.Comments__c + ',';
            }

             //s += line(new String[] { //Build a string from cells

            if(thetype == 'Group_Home'){

                        //NONPD Service Log Elements (GROUP HOME)
                        s += line(new String[] { //Build a string from cells

                        format(e.Row_ID__c),
                        format(e.Service_Episode_ID__c),
                        format(e.Service_Structure_ID__c),
                        format(e.Service_Rendered_Date__c),
                        format(e.Service_Start_Time__c),
                        format(e.Service_End_Time__c),
                        format(e.Target_Client_ID__c),
                        format(e.Program_ID__c),
                        format(e.Facility_ID__c),
                        format(e.Unit_Type__c),
                        format(e.Unit__c),
                        format(e.Activity__c),
                        format(e.Contact_Type__c),
                        format(k),
                        format(e.Requesting_Worker__c),
                        format(e.Approving_Worker__c)

                        }); //End create line for NON PD

            }else if(thetype == 'After_School'){
           
                        //PD Service Log Elements (AFTER SCHOOL)
                        s += line(new String[] { //Build a string from cells

                        format(e.Row_ID__c),
                        format(e.Service_Structure_ID__c),
                        format(e.Service_Rendered_Date__c),
                        format(e.Service_Start_Time__c),
                        format(e.Target_Client_ID__c),
                        format(e.Program_ID__c),
                        format(e.Facility_ID__c),
                        format(e.Unit_Type__c),
                        format(e.Unit__c),
                        format(k),
                        format(e.Requesting_Worker__c)

                        }); //End create line

            }//END ELSE IF TYPE = 'PD' 

            //});

            s = s.removeStartIgnoreCase('null'); //.remove('"');

            System.Debug('---------- The String ----------' + s);

            //stringmap.put(bcurrent,s); //Put the batch number and string in the map
            

        }//END FOR LOOP

        somestrings.add(s);

        return somestrings;

    }

    public static List<KIDS_Service_Log_Entry__c> generateEntryMap(Id theid){

        //Use the Service Log Id to Set the the type of the Service Log PD or NONPD
        

        //Use the Service Log Id to Find All Related Entries
        //Return the Entries as a Map of the Row Id to the KIDS Service Log Entry Object

        List<KIDS_Service_Log_Entry__c> lstEntries = new List<KIDS_Service_Log_Entry__c>(); //A Map of KIDS Service Log Entries
        Map<Integer, KIDS_Service_Log_Entry__c> themap = new Map<Integer, KIDS_Service_Log_Entry__c>(); //A map of Kids Service Log Entries

        SObjectType logentryType = Schema.getGlobalDescribe().get('KIDS_Service_Log_Entry__c'); //Describe the KIDS Service Log Entry Object
        Map<String,Schema.SObjectField> entryFields = logentryType.getDescribe().fields.getMap(); //A Map of Fields on KIDS Service Log Entry

        KIDS_Service_Log__c thislog = [SELECT Id, Generate_Error_Correction_Log_Only__c,  Status__c, Most_Recent_File_Result__c, Most_Recent_File_Id__c, 
        Date_Time_Most_Recent_File__c,  Most_Recent_File_Generated_By__c FROM KIDS_Service_Log__c WHERE Id =: theid];

        //Create the select string
        string entryselect = 'Select ';

        for(string e : entryFields.keyset()){
            entryselect = entryselect + entryFields.get(e) + ', ';
        }

        entryselect = entryselect.substring(0,entryselect.length()-2);
        entryselect = entryselect + '';
        //entryselect = entryselect + ' FROM KIDS_Service_Log_Entry__c WHERE KIDS_Service_Log__c =: theid';

        if(thislog.Generate_Error_Correction_Log_Only__c == TRUE){//Corrected - Submitted Revision To KIDS
            String thestatus = 'Corrected - Submitted Revision To KIDS';
            entryselect = entryselect + ' FROM KIDS_Service_Log_Entry__c WHERE Status__c =: thestatus AND KIDS_Service_Log__c =: theid ORDER BY Row_ID__c ASC';
        }else if(thislog.Generate_Error_Correction_Log_Only__c == FALSE){//Uncorrected Log
            entryselect = entryselect + ' FROM KIDS_Service_Log_Entry__c WHERE KIDS_Service_Log__c =: theid ORDER BY Row_ID__c ASC';
        }

        System.Debug('------------ QUERY STRING SERVICE LOG ENTRY -------------' + entryselect);

        try{
            lstEntries = (KIDS_Service_Log_Entry__c[])Database.query(entryselect); //Query for the list of Log Entries
        }catch(Exception e){
            system.debug('***********************ERROR Querying KIDS Service Log Entries ***********************' + e.getMessage());
        }

        if(!lstEntries.isEmpty()){ //If the list of Entries is not empty do something

            Integer i;

            i = 1;

            for(KIDS_Service_Log_Entry__c le : lstEntries){

                themap.put(i,le); //Populate the map

                i = i + 1;

            }

        }

        if(!lstEntries.isEmpty()){ //Do something if the map contains something

            //return themap; //Return themap
            return lstEntries;

        }else{

            System.Debug('------------ ERROR ENTRY MAP GENERATED -------------');

            //Map<Integer,KIDS_Service_Log_Entry__c> errormap = new Map<Integer,KIDS_Service_Log_Entry__c>(); //An error map
            //errormap.put(1,NULL); //Populate the error map
            //return errormap;

            List<KIDS_Service_Log_Entry__c> errorlist = new List<KIDS_Service_Log_Entry__c>();
            errorlist.add(NULL);
            return errorlist;

        }

    }

    private static String line(String[] cells) {
        return String.join(cells, '|') + '\r\n'; //Join the cells with a pipe delimiter and add a return
    }

    private static String format(Date d)    { //Format a data as a string
        return d != null ? (String.valueOf(d.month()).leftpad(2) + String.valueOf(d.day()).leftpad(2) + String.valueOf(d.year()).leftpad(4)).replace(' ','0') : ''; //d.format().escapeCsv() 
    }

    private static String format(DateTime dt)    { //Format a date time as a string
        return dt != null ? (String.valueOf(dt.month()).leftpad(2) + String.valueOf(dt.day()).leftpad(2) + String.valueOf(dt.year()).leftpad(4) + String.valueOf(dt.hour()).leftpad(2) + String.valueOf(dt.minute()).leftpad(2) + String.valueOf(dt.second()).leftpad(2)).replace(' ','0') : ''; //dt.format().escapeCsv() 
    }

    private static String format(String s) { //Format a string as a string
        return s != null ? s.escapeCsv() : '';
        
        /*if(s != null && s.length() > 0){
        
        String k = s+',';
        
        return k.escapeCsv();
        
        }
        
        return '';*/
        
    }
    
    private static String format(Decimal d, Integer scale) { //Format a decimal as a string with scale
        return d != null ? String.valueOf(d.setScale(scale)) : '';
    }

    private static String format(Decimal d) { //Format a decimal with a default scale of 2
        return format(d, 0);
    }

    /*

    Service Rendered  -- Date Provide the date on which the service was rendered. Date format mmddyyyy
    Service Start Time -- Provide the service start time of the service in mmddyyyyhhmmss (24 hr format)
    Service End Time -- Provide the service end time of the service in mmddyyyyhhmmss (24 hr format)

    valueOf(dateToConvert)
    Returns a String that represents the specified Date in the standard “yyyy-MM-dd” format.

    valueOf(datetimeToConvert)
    Returns a String that represents the specified Datetime in the standard “yyyy-MM-dd HH:mm:ss” format for the local

    */

}