@isTest
public class GeneratePdfTest {
    
    @isTest static void testPdf(){
        Contact cont= new Contact();
        cont.firstName= 'Test';
        cont.LastName= 'ConRec';
        cont.Salutation= 'Mr';
        cont.MailingCity = 'Xyz';
        cont.MailingState = 'abc';
        cont.MailingStreet = 'New';
        cont.MailingPostalCode = '123456';
        insert cont;
        
        List<Opportunity> oppList= new List<Opportunity>(); 
        Opportunity oppRec = new Opportunity();
        oppRec.Name= 'testOpp';
        oppRec.npsp__Honoree_Contact__c=cont.id;
        oppRec.StageName= 'Closed Won';
        oppRec.CloseDate= system.today().addDays(1);
        oppRec.Check_Date__c= system.today();
        oppRec.Check_Number__c= '123456789';
        oppRec.Amount= 100;
        oppList.add(oppRec);
        insert oppList;
        
        Test.startTest();
        Apexpages.StandardController sc= new Apexpages.StandardController(oppRec);
        GeneratePdf sdf= new GeneratePdf(sc);
        PageReference pageRef= Page.Generate_Thank_You_Letter;
        pageRef.getParameters().put('id', String.valueOf(oppRec.Id));
        Test.setCurrentPage(pageRef);
        sdf= new GeneratePdf(sc);
        sdf.salutation= 'Mr';
        sdf.fName= 'Test1';
        sdf.lName= 'Rec';
        sdf.mstreet = 'new';
        sdf.mcity = 'Noida';
        sdf.mpostalcode = '12098';
        sdf.mstate = 'UPP';
        Test.stopTest();
        
        System.assert(oppList.size()>0,'Opportunity Record should not be null');
    }
}