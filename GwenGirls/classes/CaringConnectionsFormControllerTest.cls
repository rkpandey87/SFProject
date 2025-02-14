@isTest
public class CaringConnectionsFormControllerTest {
    
    @isTest
    public static void GGFormControllerDependentMethodTest(){
        CaringConnectionsFormController.getFieldsValues();
        CaringConnectionsFormController.getCompletingStaff();
        String parentContactString='{"FirstName":"PFN","LastName":"PLN","HomePhone":"555555555","npe01__HomeEmail__c":"test@gmai.com","BestTimetoContactGuardian__c":"Best time","MailingStreet":"Street","MailingState":"AL","MailingCity":"City","MailingPostalCode":"221"}';
        Contact con;
        try{ con=CaringConnectionsFormController.upsertParentContact(null);
        }catch(Exception e){
            System.debug(e);
        }
        con = CaringConnectionsFormController.upsertParentContact(parentContactString);
        GGFormController.contactIntakeWrapper conIntakeWrapper=CaringConnectionsFormController.getExistingRecord(con.Id);
      
    }

}