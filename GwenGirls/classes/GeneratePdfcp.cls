public class GeneratePdfcp {
    
    public String currentRecordId {get;set;}
    Public List<Opportunity> oppList{get;set;}
    public date currentDate {get;set;}
    public String dateVal {get;set;} 
    Public String salutation{get;set;}
    Public String fName{get;set;}  
    Public String lName{get;set;}
    Public String checkNum{get;set;} 
    Public Date checkDate{get;set;}
    Public DateTime createdDt{get;set;}
    Public String checkDateFormat{get;set;}  
    Public String createdDateFormat{get;set;}
    Public String changeVal{get;set;}  
    Public String mstreet{get;set;}
    Public String mcity{get;set;}
    Public String mstate{get;set;}
    Public String mpostalcode{get;set;}
    
    public GeneratePdfcp(ApexPages.StandardController opp){
        currentRecordId = ApexPages.CurrentPage().getparameters().get('id');
        System.debug('currentRecordId:==> '+currentRecordId);
        oppList = [Select Id
                   ,Name
                   ,Check_Date__c
                   ,Check_Number__c
                   ,Amount
                   ,CreatedDate
                   ,npsp__Primary_Contact__r.firstName
                   ,npsp__Primary_Contact__r.LastName
                   ,npsp__Primary_Contact__r.Salutation
                   ,npsp__Primary_Contact__r.MailingStreet
                   ,npsp__Primary_Contact__r.MailingCity
                   ,npsp__Primary_Contact__r.MailingState
                   ,npsp__Primary_Contact__r.MailingPostalCode
                   from Opportunity Where Id=:currentRecordId];
        System.debug('oppList:==> '+oppList);
        System.debug('Record Id:==> '+currentRecordId);
        
        if (oppList!= NUll && oppList.size()>0) {
            if(oppList[0].npsp__Primary_Contact__r.Salutation!=NULL){
                salutation= oppList[0].npsp__Primary_Contact__r.Salutation + ' ';
            }
            if(oppList[0].npsp__Primary_Contact__r.firstName!=NULL){
                fName= oppList[0].npsp__Primary_Contact__r.firstName + ' ';
            }
            if(oppList[0].npsp__Primary_Contact__r.lastName!=NULL){
                lName= oppList[0].npsp__Primary_Contact__r.lastName;     
            }
            if(oppList[0].npsp__Primary_Contact__r.MailingStreet!=NULL){
                mstreet = oppList[0].npsp__Primary_Contact__r.MailingStreet + ' ';
            }
            if(oppList[0].npsp__Primary_Contact__r.MailingCity!=NULL){
                mcity =  oppList[0].npsp__Primary_Contact__r.MailingCity + ' ';
            }
            if(oppList[0].npsp__Primary_Contact__r.MailingState!=NULL){
                mstate = oppList[0].npsp__Primary_Contact__r.MailingState + ' ';
            }
            
            if(oppList[0].npsp__Primary_Contact__r.MailingPostalCode!=NULL){
                mpostalcode = oppList[0].npsp__Primary_Contact__r.MailingPostalCode;
            }
            if(oppList[0].Check_Number__c!=Null){
                checkNum=oppList[0].Check_Number__c;    
            }
            if(oppList[0].Check_Date__c!=Null){
                checkDate=oppList[0].Check_Date__c;
            }
            if(oppList[0].CreatedDate!=Null){
                createdDt=oppList[0].CreatedDate;
            }
            
            if(checkDate!=NULL){
                DateTime dtConverted = Datetime.newInstance(checkDate.year(), checkDate.month(),checkDate.day(),0,0,0); 
                checkDateFormat = dtConverted.format('MM/dd/yy');
            }  
            System.debug('checkDateFormat----> '+checkDateFormat);
            
            if(createdDt!=NULL){
                createdDateFormat = createdDt.format('MM/dd/yyyy');
                System.debug('changeVal----> '+changeVal);
            }
            System.debug('createdDateFormat----> '+createdDateFormat);
            
            dateVal=  String.valueOf(Date.today()).removeEnd('00:00:00 GMT 2023');
            System.debug('dateVal==>'+dateVal);
            if(dateVal!=NULL){
                currentDate= Date.valueOf(dateVal);
            }
            System.debug('currentDate----> '+currentDate);
        }
    }

}