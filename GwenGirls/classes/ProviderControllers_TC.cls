/**
 * @description       : 
 * @author            : WINSupport
 * @group             : 
 * @last modified on  : 01-05-2022
 * @last modified by  : WINSupport
**/
@isTest(SeeAllData=true)
public class ProviderControllers_TC {

    @isTest
    static void providerinfotest(){

        ProviderInfoController cnt = new ProviderInfoController();
        //cnt.callFlow();

        Contact con = cnt.contactEdit;
        Id conid = cnt.contactId;
        String lng = cnt.strLanguage;
        Provider_Availability__c pav = cnt.ProviderId;
        Program_Participant__c pp = cnt.ProgramId;
        String recordId = cnt?.recordId;
        String sessionId = cnt?.sessionId;
        String language = cnt?.strLanguage;

    }

    @isTest
    static void providersubjectstest(){

        ProviderSubjectsController cnt = new ProviderSubjectsController();
        //cnt.callFlow();

        Contact con = cnt.contactEdit;
        Id conid = cnt.contactId;
        String lng = cnt.strLanguage;
        Provider_Availability__c pav = cnt.ProviderId;
        Program_Participant__c pp = cnt.ProgramId;
        String recordId = cnt?.recordId;
        String sessionId = cnt?.sessionId;
        String language = cnt?.strLanguage;


    }

    @isTest
    static void provideravailabilitytest(){

        ProviderAvailabilityController cnt = new ProviderAvailabilityController();
        //cnt.callFlow();

        Contact con = cnt.contactEdit;
        Id conid = cnt.contactId;
        String lng = cnt.strLanguage;
        Provider_Availability__c pav = cnt.ProviderId;
        Program_Participant__c pp = cnt.ProgramId;
        String recordId = cnt?.recordId;
        String sessionId = cnt?.sessionId;
        String language = cnt?.strLanguage;


    }

    @isTest
    static void providermenteestest(){

        ProviderMenteesController cnt = new ProviderMenteesController();
        //cnt.callFlow();

        Contact con = cnt.contactEdit;
        Id conid = cnt.contactId;
        String lng = cnt.strLanguage;
        Provider_Availability__c pav = cnt.ProviderId;
        Program_Participant__c pp = cnt.ProgramId;
        String recordId = cnt?.recordId;
        String sessionId = cnt?.sessionId;
        String language = cnt?.strLanguage;

        
    }

}