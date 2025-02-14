@isTest
public class demoControllerTest {
@isTest
    static void testDemoController() {
        // Create a test Intake record
        Intake__c testIntake = new Intake__c(
            First_Name__c = 'TestFirstName',
            Birthdate__c = Date.today(),
            Home_Phone__c = '1234567890',
            mplc_Signature__c = 'TestSignature',
            Community_Activities__c = true,
            DateOfSignature__c = Date.today()
        );
        insert testIntake;

        PageReference pageRef = Page.ggsiteVfForm; 
        Test.setCurrentPage(pageRef);

        Test.startTest();
        ApexPages.currentPage().getParameters().put('id', testIntake.Id);

        ApexPages.StandardController standardController = new ApexPages.StandardController(testIntake);

        demoController controllerInstance = new demoController(standardController);
      /*   controllerInstance.signName ='Test';
         controllerInstance.signName1 ='Test1';
         controllerInstance.signName2 ='Test2';
         controllerInstance.signName3 ='Test3';
         controllerInstance.signName4 ='Test4';
         controllerInstance.signName5 ='Test5';
         controllerInstance.signName6 ='Test6';
         controllerInstance.signName7 ='Test7';  */

        Test.stopTest();

        
        // Test setSignature methods
     /*   controllerInstance.setSignature();
        controllerInstance.setSignature1();
        controllerInstance.setSignature2();
        controllerInstance.setSignature3();
        controllerInstance.setSignature4();
        controllerInstance.setSignature5();
        controllerInstance.setSignature6();
        controllerInstance.setSignature7();  */
        


    }
}