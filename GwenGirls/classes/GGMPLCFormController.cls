public without sharing class GGMPLCFormController {
    public static String childId {get;set;}
    public static List<Intake__c> newRecList {get;set;}
    public static List<Account> accountRecList {get;set;}
    public static String intakeRecordId {get;set;} 
    public static String parentRecordId {get;set;}
    public static List<Contact> getChildRecList {get;set;}
    public static List<Contact> getParentRecList {get;set;}
    public static List<Contact> updateParentRecList {get;set;}
    public static date dateOfSignature{get;set;}
    
    
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getSchoolPicklistVal(){
         accountRecList= [Select Id,Type,Name From Account Where Type='School' Limit 5];
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();  
      
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);

      if(accountRecList!=Null && accountRecList.size()>0){
        for(Account accObj: accountRecList){
            
            
            WrapperAllValues  wprAccObj= new WrapperAllValues();
         if(accObj.name!=null){ // && usr.FirstName!=''
         wprAccObj.label= accObj.name;
         }

         if(accObj.Id!=null){
            wprAccObj.value= accObj.id;
         }
         pickListValues.add(wprAccObj);

        }
    }
            System.debug('##pickListValues----> '+pickListValues);
   
        return pickListValues;
    }
    




   /*
    @AuraEnabled(cacheable=true)
    public static List<WrapperAllValues> getSchoolPicklistVal(){
        // accountRecList= [Select Id,Type,Name From Account Where Type='School' Limit 2];
        List<WrapperAllValues> pickListValues= new List<WrapperAllValues>();  
      
        WrapperAllValues wprdefVal= new WrapperAllValues();   
        wprdefVal.label= '--Select--';
        wprdefVal.value=  '--Select--';
        pickListValues.add(wprdefVal);

    
            
            WrapperAllValues  wprAccObj= new WrapperAllValues();
            wprAccObj.label= 'Saint Benedict the Moor School';        
            wprAccObj.value='0012M0000254yxgQAA';     
           pickListValues.add(wprAccObj);

        
     return pickListValues;
        }
   */
    


   
  

    @AuraEnabled(cacheable=true)
    public static List<wrapperList> returnChildRecList(string parentRecId){
        dateOfSignature= System.today();
        List<WrapperAllValues> lstSchoolPick = getSchoolPicklistVal();
        System.debug('lstSchoolPick===> '+lstSchoolPick);

       
        
        List<wrapperList> wprList= new List<wrapperList>();
        if(parentRecId!=NULL){
            getChildRecList= [Select FirstName,Grade__c,LastName,Name_of_Primary_Parent_Guardian__r.FirstName
                              ,Name_of_Primary_Parent_Guardian__r.LastName,Name_of_Primary_Parent_Guardian__r.HomePhone,birthdate,School__c,case__c,Community_Activities__c  from Contact where
                              RecordType.Name='Client' and Name_of_Primary_Parent_Guardian__c=:parentRecId and Name_of_Primary_Parent_Guardian__c!=NULL]; 
            System.debug('##getChildRecList-----> '+getChildRecList); //Grade__c
            
            getParentRecList= [Select Id, FirstName,LastName,Name_of_Primary_Parent_Guardian__c from Contact where
                               RecordType.Name='Parent/Guardian' and Id=:parentRecId];
            System.debug('##getParentRecList-----> '+getParentRecList);
        }
        
        if(getChildRecList!=Null && getChildRecList.size()>0){
            for(Contact lct: getChildRecList){
                wrapperList wl= new wrapperList();

        
             if(lstSchoolPick!=null){
                wl.schoolColumn= lstSchoolPick;
                System.debug('wl.schoolColumn==>'+wl.schoolColumn);
            }
            
            if(lct.School__c!=null){
                wl.schoolSelectedColumn= lct.School__c;
                System.debug('***wl.schoolSelectedColumn==>'+lct.School__c);
            }else{
                 wl.schoolSelectedColumn= '--Select--';
            }
              
                wl.childRecordId= lct.Id;
                wl.firstName=lct.FirstName; 
                wl.lastName=lct.LastName;
                wl.Dob=lct.Birthdate; 
                //wl.Grade=lct.Birthdate; 
                wl.parentfName=lct.Name_of_Primary_Parent_Guardian__r.FirstName;
                wl.parentlName=lct.Name_of_Primary_Parent_Guardian__r.LastName;
                
                wl.parentPhnNumber=lct.Name_of_Primary_Parent_Guardian__r.HomePhone; 
                
                wl.currDateOfSignature=dateOfSignature;
                wl.caseId=lct.Case__c;
                wl.communityActivityFlag= lct.Community_Activities__c;
                wl.gradeSelectedColumn= lct.Grade__c;
                childId=  wl.childRecordId;
                wprList.add(wl);
                System.debug('##wl.caseId-----> '+wl.caseId);
                System.debug('##wl.communityActivityFlag-----> '+wl.communityActivityFlag);
                System.debug('##wprList1-----> '+wprList);
                System.debug('##childId-----> '+childId);
                System.debug('######wl.parentfName-----> '+wl.parentfName);
                System.debug('######wl.parentlName-----> '+wl.parentlName);
                System.debug('######wl.parentPhnNumber-----> '+wl.parentPhnNumber);
                System.debug('***wl.gradeSelectedColumn-----> '+wl.gradeSelectedColumn);
                System.debug('***wl.gradeSelectedColumn-----> '+wl.gradeSelectedColumn);
            }
        }else{
            wrapperList wprNewParent= new wrapperList();
           
          if(lstSchoolPick!=null){
               wprNewParent.schoolColumn= lstSchoolPick;
                System.debug('##wprNewParent.schoolColumn-----> '+wprNewParent.schoolColumn);
            }

         
            wprNewParent.firstName=null; 
            wprNewParent.Dob=null; 
            wprNewParent.lastName=null;
            wprNewParent.parentfName= null;
            wprNewParent.parentlName=null;
            wprNewParent.parentPhnNumber=null;
            wprNewParent.gradeSelectedColumn= null;
            wprNewParent.currDateOfSignature=dateOfSignature;
            wprList.add(wprNewParent);
            System.debug('##wprList2-----> '+wprList);
            System.debug('***wprNewParent.gradeSelectedColumn-----> '+wprNewParent.gradeSelectedColumn);
        }
        return wprList;
    }
    
    
    
    
    @AuraEnabled
    public static void saveIntakeRecord(string itemData, string mplcSign, string parentId, boolean communityActivities){ 
       //, string accId
       
        system.debug('###itemData==========> '+itemData);
        system.debug('###itemData==========> '+itemData);
        system.debug('###mplcSign==========> '+mplcSign);
        system.debug('###parentId==========> '+parentId);
        system.debug('***communityActivities==========> '+communityActivities);
        
        String newParentGuardianId;
        
        dateOfSignature= System.today();
        string parentRecdIdVar= parentId;
        system.debug('###parentRecdIdVar==========> '+parentRecdIdVar);
        
        string fname;
        string lname;
        string dob;
        String clientId;
        string parFName;
        string parLName;
        string gradeVal;
        string parPhnNumber;
        string csId;
        string schoolVal;
        System.debug('##schoolVal===> '+schoolVal);
        Map<String, Object> mapItem;
        system.debug('###itemData===========> '+itemData);
        
        List<Object> lstItemData = (List<Object>)JSON.deserializeUntyped(itemData);
        
        try{
            Id mplcRecTypeId = Schema.SObjectType.Intake__c.getRecordTypeInfosByName().get('MPLC').getRecordTypeId();
            Id parentGuardianRTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent/Guardian').getRecordTypeId(); 
            newRecList = new List<Intake__c>();
            List<wrapperList> wprListNew= new List<wrapperList>();
            List<Contact> newConList= new List<Contact>();
            
            // Created new Parent record to attached their Id in 'New Parent' case scenario.
            If(parentid!=null && parentid!='nullId'){
                
           /* Implemented Logic To Update the  Parent Contact In Case Of Existing RecId*/
                updateParentRecList= new List<Contact>();
               Contact conObj= [Select id,firstName,lastName,HomePhone from contact where Id=:parentid];
               system.debug('****conObj 1:===========> '+conObj);
         
               if(lstItemData!=Null && lstItemData.size()>0){
                mapItem = (Map<String, Object>) lstItemData[0];
               }
            parFName= string.valueOf(mapItem.get('parentfName')); 
            parLName= string.valueOf(mapItem.get('parentlName'));
            parPhnNumber=string.valueOf(mapItem.get('parentPhnNumber'));
            system.debug('****parPhnNumber:===========> '+parPhnNumber);
            system.debug('****parFName:===========> '+parFName);
            system.debug('****parLName:===========> '+parLName);
            
            conObj.firstName= parFName;
            conObj.lastName= parLName;
            conObj.HomePhone= parPhnNumber;
            updateParentRecList.add(conObj);
            system.debug('****conObj 2:===========> '+conObj);
            system.debug('****updateParentRecList:===========> '+updateParentRecList);

          if(updateParentRecList!=null && updateParentRecList.size()>0){
              update  updateParentRecList; 
              system.debug('######updateParentRecList:===========> '+updateParentRecList);
          }
            
                
            }else{
                if(lstItemData!=Null && lstItemData.size()>0){
                    mapItem = (Map<String, Object>) lstItemData[0];
                }
                parFName= string.valueOf(mapItem.get('parentfName')); 
                parLName= string.valueOf(mapItem.get('parentlName'));
                parPhnNumber=string.valueOf(mapItem.get('parentPhnNumber'));
                system.debug('######con.HomePhoneparPhnNumber:===========> '+parPhnNumber);
                
                
                // Creating Parent Record as per data collect from User during Intake form Submission
                Contact con= new Contact();
                con.firstName= parFName;
                con.lastName= parLName;
                con.HomePhone= parPhnNumber;
               // con.
                con.RecordTypeId=parentGuardianRTypeId;
                newConList.add(con);
                system.debug('######con.HomePhone:===========> '+con.HomePhone);
                
            }
            
            
            if(newConList!=null && newConList.size()>0){
                insert newConList[0];
                newParentGuardianId= newConList[0].id;
                system.debug('######newParentGuardianId:===========> '+newParentGuardianId);
                system.debug('######newRecList3:===========> '+newConList[0]);
                
            }
            
            if(lstItemData!=Null && lstItemData.size()>0){
                for(Object itemObj : lstItemData) {                        
                    mapItem = (Map<String, Object>) itemObj;
                    
                    
                    fname = string.valueof(mapItem.get('firstName'));
                    lname = string.valueOf(mapItem.get('lastName')); 
                    dob = string.valueOf(mapItem.get('Dob')); 
                    gradeVal=string.valueOf(mapItem.get('gradeSelectedColumn'));
                    schoolVal= string.valueOf(mapItem.get('schoolSelectedColumn'));
                    System.debug('****gradeVal===> '+gradeVal);
                    System.debug('****schoolVal===> '+schoolVal);

                    clientId= string.valueOf(mapItem.get('childRecordId')); 
                    parFName= string.valueOf(mapItem.get('parentfName')); 
                    parLName= string.valueOf(mapItem.get('parentlName'));
                    parPhnNumber=string.valueOf(mapItem.get('parentPhnNumber'));
                    csId= string.valueOf(mapItem.get('caseId'));
                    
                    // binds the itemData  list with wrapper list to pass clientId to existing child Lookup 
                    wrapperList wlNew= new wrapperList();
                    wlNew.childRecordId= clientId;
                    wlNew.firstName= fname;
                    wlNew.lastName= lname;
                    wlNew.Dob= date.valueOf(dob);
                    if(gradeVal!=null){
                        wlNew.gradeSelectedColumn= gradeVal;
                    }
                    if(schoolVal!=null){
                        wlNew.schoolSelectedColumn= schoolVal;
                    }
                   
                         
                    wlNew.parentfName=parFName;                           
                    wlNew.parentlName=parLName;           
                    wlNew.parentPhnNumber=parPhnNumber;
                       
                    wlNew.caseId=csId;
                    wprListNew.add(wlNew);
                    system.debug('#####wprListNew:===========> '+wprListNew);
                    system.debug('#####wprListNew:===========> '+wprListNew.size());
                    system.debug('#####wprListNew:===========> '+wlNew.parentfName);
                    system.debug('#####wprListNew:===========> '+wlNew.parentlName);
                    system.debug('########caseId:===========> '+wlNew.caseId);
                    system.debug('########wlNew.gradeSelectedColumn:===========> '+wlNew.gradeSelectedColumn);
                    system.debug('########wlNew.schoolSelectedColumn:===========> '+wlNew.schoolSelectedColumn);
                }
            }
            
            if(wprListNew!= Null && wprListNew.size()>0){
                for(wrapperList wprRec: wprListNew){
                    system.debug('****wprRec:===========> '+wprRec); 
                    system.debug('****wprListNew:===========> '+wprListNew); 
                    
                    If(parentid!=null && parentid!='nullId'){
                        string clientIdNew= wprRec.childRecordId;
                        If(clientIdNew!=null && clientIdNew!='newRecFlag'){
                            // Existing client record;
                            
                            system.debug('***wprRec.gradeSelectedColumn:===========> '+wprRec.gradeSelectedColumn); 
                                      
                            Intake__c inkRec= new Intake__c();
                            inkRec.Name= wprRec.firstName+ '_' +wprRec.lastName + '_' +'MPLC';
                            inkRec.First_Name__c=wprRec.firstName;
                            inkRec.Last_Name__c= wprRec.lastName;
                            inkRec.Birthdate__c= date.valueOf(wprRec.Dob);
                            if(wprListNew[0].parentPhnNumber!=null){
                                inkRec.Home_Phone__c= wprListNew[0].parentPhnNumber;
                            }
                            inkRec.Grade__c=decimal.valueOf(wprRec.gradeSelectedColumn);

                      /*  if(accId!=null){
                            inkRec.School__c	=accId; 
                            system.debug('#####Existing Parent New:===========> '+accId);
                            }*/
                        
                            if(wprRec.schoolSelectedColumn!=null && wprRec.schoolSelectedColumn!= '--Select--'){
                                inkRec.School__c= wprRec.schoolSelectedColumn;
                                system.debug('#####Existing Parent New:===========> '+wprRec.schoolSelectedColumn);
                            }
                            

                            inkRec.DateOfSignature__c= dateOfSignature;
                            inkRec.Name_of_Primary_Parent_Guardian__c= parentRecdIdVar;
                            inkRec.Client__c= wprRec.childRecordId;
                            inkRec.case__c= wprRec.caseId;
                            inkRec.Community_Activities__c = communityActivities;
                            inkRec.mplc_Signature__c= mplcSign;
                            inkRec.RecordTypeId = mplcRecTypeId;
                            system.debug('****inkRec:===========> '+inkRec);
                            newRecList.add(inkRec);
                            system.debug('#####newRecList2:===========> '+newRecList);
                            system.debug('#####inkRec.Client__c:===========> '+wprRec.childRecordId);
                            system.debug('#####wprRec.caseId:===========> '+wprRec.caseId);
                            system.debug('#####inkRec.case__c:===========> '+inkRec.case__c);
                            system.debug('######inkRec.Community_Activities__c:===========> '+inkRec.Community_Activities__c);
                            system.debug('######inkRec.Grade__c:===========> '+inkRec.Grade__c);
                        }
                        else{
                            //  Existing parent new client;
                            system.debug('***wprRec.gradeSelectedColumn1:===========> '+wprRec.gradeSelectedColumn); 
                            Intake__c inkRec= new Intake__c();
                            inkRec.Name= wprRec.firstName+ '_' +wprRec.lastName + '_' +'MPLC';
                            inkRec.First_Name__c=  wprRec.firstName;
                            inkRec.Last_Name__c= wprRec.lastName;
                            if(wprListNew[0].parentPhnNumber!=null){
                                inkRec.Home_Phone__c= wprListNew[0].parentPhnNumber;
                            }
                            inkRec.Birthdate__c= date.valueOf(wprRec.Dob);
                            inkRec.DateOfSignature__c= dateOfSignature;
                            inkRec.Name_of_Primary_Parent_Guardian__c= parentRecdIdVar;
                            inkRec.Community_Activities__c = communityActivities;
                            inkRec.Grade__c=decimal.valueOf(wprRec.gradeSelectedColumn);
                            if(wprRec.schoolSelectedColumn!=null && wprRec.schoolSelectedColumn!= '--Select--'){
                                inkRec.School__c= wprRec.schoolSelectedColumn;
                                system.debug('#####Existing Parent New:===========> '+wprRec.schoolSelectedColumn);
                            }

                          
                  /*   if(accId!=null){
                        inkRec.School__c=accId; //accId;
                        }*/

                            inkRec.mplc_Signature__c= mplcSign;
                            inkRec.RecordTypeId = mplcRecTypeId;

                            newRecList.add(inkRec);
                            system.debug('#####newRecList1:===========> '+newRecList);
                            system.debug('######inkRec.Community_Activities__c:===========> '+inkRec.Community_Activities__c);
                            system.debug('######inkRec.Grade__c:===========> '+inkRec.Grade__c);
                        //    system.debug('######inkRec.School__c:===========> '+inkRec.School__c);
                        }
                    }
                    else{
                        
                        //  New parent case recod;
                        system.debug('***wprRec.gradeSelectedColumn2:===========> '+wprRec.gradeSelectedColumn); 
                        Intake__c inkRec= new Intake__c();
                        inkRec.Name= wprRec.firstName+ '_' +wprRec.lastName + '_' +'MPLC';
                        inkRec.First_Name__c=  wprRec.firstName;
                        inkRec.Last_Name__c= wprRec.lastName;
                        if(wprListNew[0].parentPhnNumber!=null){
                            inkRec.Home_Phone__c= wprListNew[0].parentPhnNumber;
                        }
                       
                        inkRec.Birthdate__c= date.valueOf(wprRec.Dob);
                        inkRec.DateOfSignature__c= dateOfSignature;
                        inkRec.Grade__c= decimal.valueOf(wprRec.gradeSelectedColumn);

                        if(wprRec.schoolSelectedColumn!=null && wprRec.schoolSelectedColumn!= '--Select--'){
                            inkRec.School__c= wprRec.schoolSelectedColumn;
                            system.debug('#####New Parent Case:===========> '+wprRec.schoolSelectedColumn);
                        }
                     
                      /* if(accId!=null){
                       system.debug('****accId3:===========> '+accId);
                       inkRec.School__c	=accId; //accId;
                       }*/

                        inkRec.Name_of_Primary_Parent_Guardian__c= newParentGuardianId; 
                        inkRec.Community_Activities__c = communityActivities;
                        inkRec.mplc_Signature__c= mplcSign;
                        inkRec.RecordTypeId = mplcRecTypeId;
                        system.debug('****inkRec:===========> '+inkRec);
                        newRecList.add(inkRec);
                        system.debug('######newRecList3:===========> '+newRecList);
                        system.debug('######inkRec.Community_Activities__c:===========> '+inkRec.Community_Activities__c);
                        system.debug('######newParentGuardianId:===========> '+newParentGuardianId);
                        system.debug('######inkRec.Grade__c:===========> '+inkRec.Grade__c);
                     
                    }
                    
                }
            }
            
            system.debug('###fname==========> '+fname);
            system.debug('###lname==========> '+lname);
            system.debug('###dob==========> '+dob);
            system.debug('###dob==========> '+parFName);
            system.debug('###dob==========> '+parLName);
            
            if(newRecList!=Null && newRecList.size()>0){
                insert newRecList;
                system.debug('###Intake Record List New===========> '+newRecList);  
                system.debug('###Intake Record List Size===========> '+newRecList.size()); 
            }                      
        }catch(Exception ex){
            System.debug('Error Msg:====> '+ ex.getMessage()+ 'Error Line No:====> '+ex.getLineNumber());
        }
    }
    
    
    public class wrapperList{
        @AuraEnabled
        public string childRecordId{get;set;}
        @AuraEnabled
        public string firstName{get;set;}
        @AuraEnabled
        public string lastName{get;set;}
        @AuraEnabled
        public date Dob{get;set;}
       
        @AuraEnabled
        public string parentfName{get;set;} 
        @AuraEnabled
        public string parentlName{get;set;} 
        @AuraEnabled
        public string parentPhnNumber{get;set;}
        @AuraEnabled
        public string parentSign{get;set;}   
        @AuraEnabled
        public date currDateOfSignature{get;set;} 
        @AuraEnabled
        public string caseId{get;set;}  
        
        @AuraEnabled
        public boolean communityActivityFlag{get;set;} 
        
        @AuraEnabled
        public List<WrapperAllValues> schoolColumn{get;set;}
        @AuraEnabled
        public string schoolSelectedColumn{get;set;}
       

        @AuraEnabled
        public List<WrapperAllValues> gradeColumn{get;set;}
        @AuraEnabled
        public string gradeSelectedColumn{get;set;}

        /*    Testing    */
        @AuraEnabled
        public List<WrapperAllValues> genIdentityColumn{get;set;}
        @AuraEnabled
        public string genIdentitySelectedColumn{get;set;}


        
        /*  Acc Details */
        @AuraEnabled
        public string accName{get;set;}
        @AuraEnabled
        public string accId{get;set;}
    }
    
    public class WrapperAllValues {
        @AuraEnabled
        public string label{get;set;}
        @AuraEnabled
        public string value{get;set;}
        
    }

    public static WrapperAllValues getWrapperValues(string label, string val) {
        WrapperAllValues api = new WrapperAllValues();
        api.label = label;
        api.value = val;
        
        return api;
    }
    
}