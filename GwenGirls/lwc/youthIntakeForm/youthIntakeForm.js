import { LightningElement, track, wire } from 'lwc';
import ggFormLogo from "@salesforce/resourceUrl/ggHeaderLogo";
import pic1 from "@salesforce/resourceUrl/companyLogo1";
import pic2 from "@salesforce/resourceUrl/companyLogo2";
import pic3 from "@salesforce/resourceUrl/companyLogo3";
import pic4 from "@salesforce/resourceUrl/companyLogo4";
import pic5 from "@salesforce/resourceUrl/companyLogo5";
import pic6 from "@salesforce/resourceUrl/companyLogo6";
import pic7 from "@salesforce/resourceUrl/companyLogo7";
import pic8 from "@salesforce/resourceUrl/companyLogo8";
import pic9 from "@salesforce/resourceUrl/companyLogo9";
import { CurrentPageReference } from 'lightning/navigation';
import LightningConfirm from 'lightning/confirm';
 import { ShowToastEvent } from 'lightning/platformShowToastEvent';
 import getFieldsValues from '@salesforce/apex/YouthDevelopmentFormController.getFieldsValues';
 import upsertParentContact from '@salesforce/apex/YouthDevelopmentFormController.upsertParentContact1';
 import getExistingRecord from '@salesforce/apex/YouthDevelopmentFormController.getExistingRecord';
 import createIntake from '@salesforce/apex/GGFormController.createIntake';
 import { getObjectInfo } from "lightning/uiObjectInfoApi";
import Intake_OBJECT from "@salesforce/schema/Intake__c";
import { NavigationMixin } from 'lightning/navigation';
export default class YouthIntakeForm extends NavigationMixin(LightningElement) {
    formLogo = ggFormLogo;
   
    @track systemFieldOption = {};
    @track isModalOpen = false;
    @track isConsentModalOpen = false;
    @track showOtherGradeLevel = false;
    @track childData ={};
    @track GuidelineImages = {
        Image1: pic1, Image2: pic2,Image3: pic3,Image4: pic4,Image5: pic5,Image6: pic6,
        Image7: pic7,Image8: pic8,Image9: pic9
    };
    @track systemVar1 = {
        isLoading: false, contactId: '', sContactId: '', isFieldEmpty: false, familyCaseCourt: [{ label: 'Yes', value: 'true' }, { label: 'No', value: 'false' }], childNodes: [], isDeleteRowButtonVisible: false, youthDevelopmentRecordId: '',
        picklistValuesName: [ 'ReferralSource','guardianState','youthrelationship','OtherGaurgian','ReceivePublicAssistance','IncomeSource','MedicationCompliance','HousingType','HousingOwnership','genderIdentity',
        'School','Grade','Race','InterestAreas','ApprovedPickUp1','ApprovedPickUp2','HadIllness','MentalHealthDiagnosis','Allergies','ChildAttendProgram'],
        requiredChild: ['First_Name', 'Last_Name', 'Birthdate']
    };
    @track parentValues = {
        neighborhoodValue: '',  Name_of_Primary_Parent_Guardian__c:'',GuardianPhone__c:'',p_ReferralReason:'',
        p_FirstName: '', p_LastName: '', p_PhoneNumber: '', p_MPhoneNumber: '', p_WPhoneNumber: '', p_email: '', p_Mailingstreet: '', p_relation: '', p_PlaceOfEmployment: '',
        p_MonthlyIncome: '', p_IncomeSource: '',p_ReceivePublicAssistance:'', p_Housing: '', p_HousingStatus: '',p_LenghtofTimeinCR: '',
        p_MailingCity: '', p_MailingState: '', p_MailingPostalCode: '', p_signature: '',p_signatureAAP: '',p_signatureCRRI: '',p_signatureFHAA: '',p_signatureGGBP: '', 
        p_signaturePCS: '',p_signatureRAFFERPA: '',p_signatureTC: '',p_signatureCPIU: '',p_signDate: new Date().toISOString().slice(0, 10)
    };
    @track secondaryParentValues = {
        p_FirstName: '', p_LastName: '', p_PhoneNumber: '', p_MPhoneNumber: '', p_WPhoneNumber: '', p_email: '', p_Mailingstreet: '', p_relation: '', p_PlaceOfEmployment: '',
        p_MonthlyIncome: '', p_IncomeSource: '', p_Housing: '', p_HousingStatus: '',p_LenghtofTimeinCR: '',
        p_MailingCity: '', p_MailingState: '', p_MailingPostalCode: '', p_signature: '', p_signDate: new Date().toISOString().slice(0, 10)
    };
    // @track childValue = {
    //     childIndex: 1, isChildOpen: true, c_FirstName: '', c_LastName: '', c_Birthdate: '', c_GenderIdentity: '', c_PreferredName: '', c_GenderPronouns: '', c_RacialEthnicIdentity: '', c_IdentityExpansion: '', c_Phone: '', c_PrimaryConcern: '',
    //     c_secondaryConcern: '', c_thirdConcern: '', c_NeedsCategory: '', c_ImmediateSafetyConcerns: '', c_Comment: '', c_ClientHasaSafetyPlan: '', c_SafetyPlanExplanation: '', c_YouthSystemInvolvement: '', c_SystemInvolvementBrief: '',
    //     c_CYFCaseNumber: '', c_CYFCaseworker: '', c_CYFPhone: '', c_CYFRegional: '', c_Signature: '', c_FamilyCaseCourt: 'false',
    // };
    @track childValue = {
        childIndex: 1, isChildOpen: true, clientId: '',caseId: '', c_FirstName: '', c_LastName: '', c_Birthdate: '', c_GenderIdentity: '', c_SSN: '', c_Race: '',c_Weight: '', c_HeightFeet: '', c_HeightInches: '',c_IdentifyingMarks: '', c_HairColor: '', c_EyeColor: '',
        c_SelectSchool: '',c_Grade: '',c_OtherGrade: '',c_YouthEducationConcern: '', c_PlaceofEmployment: '', c_DurationatEmployment: '', c_ProblemsAtWork: '', c_IdentifyAreasofinterest: '',c_FirstName1: '',c_LastName1: '',c_Phone1: '', c_EmergencyContact: '', c_EmergencyContact2: '',
        c_FirstName2: '',c_LastName2: '',c_Phone2: '', c_Relationship1: '',c_Relationship2: '',c_ApprovedPickUp1Name: '', c_PickUp1Relationship: '',c_ApprovedPickUp1Phone: '',c_ApprovedPickUp2Name: '', c_PickUp2Relationship: '',c_ApprovedPickUp2Phone: '',c_PickTransport: '',
        c_AlternateCity: '',c_AlternateState: '',c_AlternateZipCode : '', c_PhysicianName: '',c_PhysicianPhone: '',c_InsuranceCarrier : '',c_InsuranceNumber: '',c_LastPhysical: '',c_DentalVisit: '',c_RecentVision: '',c_RecentHearing: '', c_OperationsInjuries : '',c_PhysicalMentalHistory: '',c_Medications: '',c_MedicationCompliance : '',
        c_Limitations: '',c_HadIllness: '', c_MentalHealthDiagnosis: '',c_AdditionalMentalHealthInformation: '',c_Covid19Symptoms: '',c_Allergies: '', c_AllergyDetails: '',c_ChildAttend: '', c_currentlyEnrollInSchool:false, c_Iep:false
    };

 @wire(getObjectInfo, { objectApiName: Intake_OBJECT })
    wireAccountData(objectInfo, error) {
        if (objectInfo) {
            let recordTypeInfo = objectInfo?.data?.recordTypeInfos;
            if (recordTypeInfo) { this.systemVar1.youthDevelopmentRecordId = Object.keys(recordTypeInfo).find(rtype => (recordTypeInfo[rtype].name === 'Youth Development')); }
        }
        else if (error) { console.log('error 010', error); }
    }
@wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) { if (currentPageReference.state?.ContactId) { this.systemVar1.contactId = currentPageReference.state?.ContactId; } }
    }
@wire(getFieldsValues)
    getFieldsData({ error, data }) {
        if (data) {
            this.systemVar1.picklistValuesName.forEach(item => { if (data[item]) { this.systemFieldOption[item] = JSON.parse(JSON.stringify(data[item])); } });
            if (this.systemVar1.contactId == 'nullId') {
                this.systemVar1.isLoading = false;
                this.systemVar1.childNodes.push(JSON.parse(JSON.stringify(this.childValue)));
            }
        }
        if (error) { console.log('error 002', error); }
    }
     
     @wire(getExistingRecord, { parentId: '$systemVar1.contactId' })
    getExisingContact({ error, data }) {
        if (data) {
            if (data.parentContact) {
                // Assing primary parent record 
                this.parentValues.p_FirstName = data.parentContact.FirstName;
                this.parentValues.p_LastName = data.parentContact.LastName;
                this.parentValues.p_Mailingstreet = data.parentContact.MailingStreet;
                this.parentValues.p_MailingState = data.parentContact.MailingState;
                this.parentValues.p_MailingCity = data.parentContact.MailingCity;
                this.parentValues.p_MailingPostalCode = data.parentContact.MailingPostalCode;
                this.parentValues.p_PhoneNumber = data.parentContact.HomePhone;
                this.parentValues.p_MPhoneNumber = data.parentContact.Mobile_Phone__c;
                this.parentValues.p_WPhoneNumber = data.parentContact.npe01__WorkPhone__c;
                this.parentValues.p_email = data.parentContact.npe01__HomeEmail__c;
                this.parentValues.p_relation = data.parentContact.Primary_Guardian_Relationship__c;
                this.parentValues.p_PlaceOfEmployment = data.parentContact.Place_of_Employment__c;
                this.parentValues.p_MonthlyIncome = data.parentContact.Household_Monthly_Income__c;
                this.parentValues.p_IncomeSource = data.parentContact.Income_Source__c;
                this.parentValues.p_ReceivePublicAssistance = data.parentContact.Receive_Public_Assistance__c;
                this.parentValues.p_Housing = data.parentContact.Housing_Type__c;
                this.parentValues.p_HousingStatus = data.parentContact.Housing_Ownership__c;
                // this.parentValues.p_LenghtofTimeinCR = data.parentContact.Place_of_Employment__c;
           
               
            
                // Assing Secondary parent record 
            this.secondaryParentValues.p_FirstName = data.parentContact.Other_Caregiver_First__c;
            this.secondaryParentValues.p_LastName = data.parentContact.Other_Caregiver_Last__c;
           // this.secondaryParentValues.p_PhoneNumber = data.parentContact.HomePhone;
           // this.secondaryParentValues.p_MPhoneNumber = data.parentContact.Mobile_Phone__c;
          //  this.secondaryParentValues.p_WPhoneNumber = data.parentContact.npe01__WorkPhone__c;
            this.secondaryParentValues.p_relation = data.parentContact.Other_Guardian_Relationship__c;
            this.secondaryParentValues.p_PlaceOfEmployment = data.parentContact.Place_of_Employment__c;
            this.secondaryParentValues.p_Mailingstreet = data.parentContact.OtherStreet;
            this.secondaryParentValues.p_MailingState = data.parentContact.OtherState;
            this.secondaryParentValues.p_MailingCity = data.parentContact.OtherCity;
            this.secondaryParentValues.p_MailingPostalCode = data.parentContact.OtherPostalCode;
            
            // Assing Childs record 
            if (data.childContact) { this.assignExistingContactRecord(data.childContact) }
            
            }


            this.systemVar1.isLoading = false;
            console.log('data', data);
            console.log('data.parentContact', data.parentContact);
            
            console.log('data.childContact', data.childContact);
        }
        else if (error) { console.log('error 011', error); }
    }

assignExistingContactRecord(listOfContact) {
        if(listOfContact.length>0){
        let assignCommonFields = listOfContact[0];
        console.log('assignCommonFields====>',assignCommonFields);
        let intakeRec = assignCommonFields['Intake__r'];
        let caregiverParent =intakeRec['Caregiver_Parent__r.FirstName'];
        console.log('230 caregiverParent====>',caregiverParent);
        this.systemVar1.sContactId = intakeRec['Caregiver_Parent__c'];
        this.parentValues.p_ReferralReason = intakeRec['How_did_you_hear_about_us__c'];
        console.log('sContactId====>',this.systemVar1.sContactId);
        console.log('p_ReferralReason====>',this.parentValues.p_ReferralReason);
       
       // read signatures value from first child contact related Intake__r Record
        // this.parentValues.p_signature = intakeRec['Youth_Signature__c'];
        // this.parentValues.p_signatureCRRI = intakeRec['Signature_CRRI__c'];
        // this.parentValues.p_signatureFHAA = intakeRec['Signature_FHAA__c'];
        // this.parentValues.p_signatureGGBP = intakeRec['Signature_GGBP__c'];
        // this.parentValues.p_signaturePCS = intakeRec['Signature_PCS__c'];
        // this.parentValues.p_signatureTC = intakeRec['Signature_TC__c'];
        // this.parentValues.p_signatureRAFFERPA = intakeRec['Signature_RAFFERPA__c'];
        // this.parentValues.p_signatureCPIU = intakeRec['Signature__c'];
        console.log('parentValues====>',this.parentValues);
       // this.parentValues.EmergencyContactFirst = assignCommonFields['Intake__r.Emergency_Contact__c'];
       // this.parentValues.EmergencyContactSecond = assignCommonFields['Intake__r.Emergency_Contact_2__c'];
        
        // this.parentValues.neighborhoodValue =assignCommonFields['Neighborhood_CC__c'];
        // this.parentValues.otherNeighborhood = assignCommonFields['Other_Neighborhood_CC__c'] ? assignCommonFields['Other_Neighborhood_CC__c']: '';
        // this.parentValues.p_guardianConsentReceived = assignCommonFields['GuardianConsentReceived__c'] ? assignCommonFields['GuardianConsentReceived__c'] : '';
        // this.parentValues.p_clientConsentReceived14YOA = assignCommonFields['ClientConsentReceived14YOA__c'] ? assignCommonFields['ClientConsentReceived14YOA__c']:'';
        // this.parentValues.p_bestTime = assignCommonFields['BestTimetoContactGuardian__c']? assignCommonFields['BestTimetoContactGuardian__c']:'';
        // this.parentValues.p_AdditionalComments = assignCommonFields['AdditionalInformationRegardingConsent__c']? assignCommonFields['AdditionalInformationRegardingConsent__c']:'';
        // this.parentValues.p_ReferralFirstName = assignCommonFields['Referral_Source_First__c'];
        // this.parentValues.p_ReferralLastName = assignCommonFields['Referral_Source_Last__c'];
        // this.parentValues.p_ReferralTitle = assignCommonFields['Referrer_Title__c'];
        // this.parentValues.p_ReferralPhone = assignCommonFields['ReferralPhone__c'];
        // this.parentValues.p_ReferralType = assignCommonFields['Referral_Source_Type__c'];
        // this.parentValues.p_ReferralTypeOther = assignCommonFields['Referral_Source_Type_Other__c'];
         
        // this.parentValues.p_relation = assignCommonFields['Primary_Guardian_Relationship__c'];
        let tempListOfContact = [];
        listOfContact.forEach((item, index) => {
            console.log('listofContact Loop ==>');
            let contact = {};
            contact['childIndex'] = index + 1;
            contact['clientId'] = item.Id ? item.Id : '';
            contact['caseId'] = item.caseId ? item.caseId : '';
            contact['c_FirstName'] = item.FirstName;
            contact['c_LastName'] = item.LastName;
            contact['c_Birthdate'] = item.Birthdate;
            contact['c_GenderIdentity'] = item.GenderIdentity ? item.GenderIdentity : '';	
			contact['c_SSN'] = item.SSN__c ? item.SSN__c : '';	
			contact['c_Race'] = item.Race__c ? item.Race__c : '';	
			contact['c_Weight'] = item.Weight__c ? item.Weight__c : '';	
			contact['c_HeightFeet'] = item.Height_feet__c ? item.Height_feet__c : '';	
			contact['c_HeightInches'] = item.Height_inches__c ? item.Height_inches__c : '';	
			contact['c_IdentifyingMarks'] = item.Identifying_Marks__c ? item.Identifying_Marks__c : '';	
			contact['c_HairColor'] = item.Hair_Color__c ? item.Hair_Color__c : '';	
			contact['c_EyeColor'] = item.Eye_Color__c ? item.Eye_Color__c : '';	
			contact['c_SelectSchool'] = item.School__c ? item.School__c : '';	
			contact['c_Grade'] = item.Grade__c ? item.Grade__c : '';
            contact['c_currentlyEnrollInSchool'] = item.In_School__c ? item.In_School__c : false;
            contact['c_Iep'] = item.IEP__c ? item.IEP__c : false;	
		    contact['c_YouthEducationConcern'] = '';	
			contact['c_PlaceofEmployment'] = item.Place_of_Employment__c ? item.Place_of_Employment__c : '';	
			contact['c_DurationatEmployment'] = '';	
			contact['c_ProblemsAtWork'] = '';
			contact['c_IdentifyAreasofinterest'] = item.Interest_Areas__c ? item.Interest_Areas__c.split(';') : '';	
			contact['c_FirstName1'] = item.Emergency_Contact_First__c ? item.Emergency_Contact_First__c : '';	
			contact['c_LastName1'] = item.Emergency_Contact_Last__c ? item.Emergency_Contact_Last__c : '';	
			contact['c_Phone1'] = item.Emergency_Contact_Phone__c ? item.Emergency_Contact_Phone__c : '';	
			contact['c_FirstName2'] = item.Emergency_Contact_2_First__c ? item.Emergency_Contact_2_First__c : '';
            contact['c_LastName2'] = item.Emergency_Contact_2_Last__c ? item.Emergency_Contact_2_Last__c : '';				
			contact['c_Phone2'] = item.Emergency_Contact_2_Phone__c ? item.Emergency_Contact_2_Phone__c : '';
			contact['c_EmergencyContact'] =item.Emergency_Contact__c ? item.Emergency_Contact__c:'';
            contact['c_EmergencyContact2'] =item.Emergency_Contact_2__c ? item.Emergency_Contact_2__c:'';
            contact['c_Relationship1'] = item.Emergency_Contact_Relationship__c ? item.Emergency_Contact_Relationship__c : '';	
		    contact['c_Relationship2'] = '';	
			contact['c_ApprovedPickUp1Name'] = item.Approved_Pick_Up_1__c ? item.Approved_Pick_Up_1__c : '';	
			contact['c_PickUp1Relationship'] = item.Approved_Pick_Up_1_Relationship__c ? item.Approved_Pick_Up_1_Relationship__c : '';	
			contact['c_ApprovedPickUp1Phone'] = item.Approved_Pick_Up_1_Phone__c ? item.Approved_Pick_Up_1_Phone__c : '';	
			contact['c_ApprovedPickUp2Name'] = item.Approved_Pick_Up_2__c ? item.Approved_Pick_Up_2__c : '';	
			contact['c_PickUp2Relationship'] = item.Approved_Pick_Up_2_Relationship__c ? item.Approved_Pick_Up_2_Relationship__c : '';	
			contact['c_ApprovedPickUp2Phone'] = item.Approved_Pick_Up_2_Phone__c ? item.Approved_Pick_Up_2_Phone__c : '';	
			contact['c_AlternateCity'] = '';	
			contact['c_AlternateState'] = '';	
			contact['c_AlternateZipCode'] = '';	
			contact['c_PhysicianName'] = item.Physician_Name__c ? item.Physician_Name__c : '';	
			contact['c_PhysicianPhone'] = item.Physician__c ? item.Physician__c : '';
			contact['c_InsuranceCarrier'] = item.Insurance_Provider__c ? item.Insurance_Provider__c : '';
			contact['c_InsuranceNumber'] = item.Insurance_Number__c ? item.Insurance_Number__c : '';
			contact['c_LastPhysical'] = item.Last_Physical_MM_YYYY__c ? item.Last_Physical_MM_YYYY__c : '';
            contact['c_DentalVisit'] = item.Most_Recent_Dental_Exam__c  ? item.Most_Recent_Dental_Exam__c  : '';
            contact['c_RecentVision'] = item.Most_Recent_Vision_Exam__c  ? item.Most_Recent_Vision_Exam__c  : '';
            contact['c_RecentHearing'] = item.Most_Recent_Hearing_Exam__c  ? item.Most_Recent_Hearing_Exam__c  : '';
			contact['c_OperationsInjuries'] = item.Operations_Injuries__c ? item.Operations_Injuries__c : '';
	        contact['c_PhysicalMentalHistory'] = '';
			contact['c_Medications'] = item.Medications__c ? item.Medications__c : '';
			contact['c_MedicationCompliance'] =  '';
			contact['c_Limitations'] =  '';
			contact['c_HadIllness'] = item.Had_illness__c ? item.Had_illness__c.split(';') : '';
		//	contact['c_MentalHealthDiagnosis'] = item.Mental_Health_History__c ? item.Mental_Health_History__c : '';
			contact['c_AdditionalMentalHealthInformation'] = item.MH_History_Detailed__c ? item.MH_History_Detailed__c : '';
			contact['c_Covid19Symptoms'] =  '';
			contact['c_Allergies'] = item.Allergies__c ? item.Allergies__c.split(';') : '';
			contact['c_AllergyDetails'] = item.Allergies_Detailed__c ? item.Allergies_Detailed__c : '';
			contact['c_ChildAttend'] = item.Child_will_Attend_Afterschool__c ? item.Child_will_Attend_Afterschool__c.split(';') : '';
            
            tempListOfContact.push(contact);
        });

        this.systemVar1.childNodes = tempListOfContact;

    }
    // else{
      
    //   //  this.systemVar1.childNodes.push(JSON.parse(JSON.stringify(this.childValue)));
    // }
    
   
   
 }

 handleSubmit() {
     console.log('139inside handle submit');
        this.checkRequiedFields();
        if (!this.systemVar1.isFieldEmpty) {
            console.log('working', this.parentValues);
            this.systemVar1.isLoading = true;
            let parentContact=[];
            let primaryParentContact = {
                FirstName: this.parentValues.p_FirstName, LastName: this.parentValues.p_LastName, HomePhone: this.parentValues.p_PhoneNumber, Mobile_Phone__c: this.parentValues.p_MPhoneNumber, npe01__WorkPhone__c: this.parentValues.p_WPhoneNumber, npe01__HomeEmail__c: this.parentValues.p_email, 
                MailingStreet: this.parentValues.p_Mailingstreet, MailingState: this.parentValues.p_MailingState, MailingCity: this.parentValues.p_MailingCity, MailingPostalCode: this.parentValues.p_MailingPostalCode, Primary_Guardian_Relationship__c:this.parentValues.p_relation, Place_of_Employment__c:this.parentValues.p_PlaceOfEmployment,
                Household_Monthly_Income__c:this.parentValues.p_MonthlyIncome, Income_Source__c:this.parentValues.p_IncomeSource, Receive_Public_Assistance__c:this.parentValues.p_ReceivePublicAssistance, Housing_Type__c:this.parentValues.p_Housing, Housing_Ownership__c :this.parentValues.p_HousingStatus,
                
                Other_Caregiver_First__c: this.secondaryParentValues.p_FirstName, Other_Caregiver_Last__c: this.secondaryParentValues.p_LastName,
                OtherStreet: this.secondaryParentValues.p_Mailingstreet, OtherState: this.secondaryParentValues.p_MailingState, OtherCity: this.secondaryParentValues.p_MailingCity, OtherPostalCode: this.secondaryParentValues.p_MailingPostalCode, Other_Guardian_Relationship__c:this.secondaryParentValues.p_relation               

            }
            parentContact.push(primaryParentContact);
            console.log('Primary parentContact: ', JSON.stringify(parentContact));
            let SecondaryParentContact = {
                FirstName: this.secondaryParentValues.p_FirstName, LastName: this.secondaryParentValues.p_LastName, HomePhone: this.secondaryParentValues.p_PhoneNumber, Mobile_Phone__c: this.secondaryParentValues.p_MPhoneNumber, npe01__WorkPhone__c: this.secondaryParentValues.p_WPhoneNumber, npe01__HomeEmail__c: this.secondaryParentValues.p_email, 
                MailingStreet: this.secondaryParentValues.p_Mailingstreet, MailingState: this.secondaryParentValues.p_MailingState, MailingCity: this.secondaryParentValues.p_MailingCity, MailingPostalCode: this.secondaryParentValues.p_MailingPostalCode, Primary_Guardian_Relationship__c:this.secondaryParentValues.p_relation,Place_of_Employment__c:this.secondaryParentValues.p_PlaceOfEmployment,
               
            }
            parentContact.push(SecondaryParentContact);
            console.log('Secodary parentContact: ', JSON.stringify(SecondaryParentContact));
            
            if (this.systemVar1.contactId != 'nullId') {
                parentContact[0]['Id'] = this.systemVar1.contactId;
            }
            if (this.systemVar1.sContactId !='' ) {
                console.log('spId===>',this.systemVar1.sContactId);
                parentContact[1]['Id'] = this.systemVar1.sContactId;
                
            }
            console.log('parentContact: ', JSON.stringify(parentContact));
            upsertParentContact({ parentContactString: JSON.stringify(parentContact) })
                .then(result => {
                    if (result) {
                   this.systemVar1.contactId = result.PrimaryParent['Id'];
                   this.systemVar1.sContactId = result.SecondaryParent['Id'];
                    console.log('155 pp ',this.systemVar1.contactId);
                    console.log('155 sp ',this.systemVar1.sContactId);
                   
                  //  this.showToast('Success!!!!', 'Youth Intake Primary Parent record created successfully!', 'success');
                            }
                 // this.systemVar1.isLoading = false;
                           
                   
                    let listOfIntake = this.insertChildRecords(result.PrimaryParent);
                    console.log('240listOfIntake: ',JSON.stringify(listOfIntake));
                    createIntake({ listOfIntakeString: JSON.stringify(listOfIntake) })
                        .then(result => {
                            if (result) {
                                this.showToast('Success!!!!', 'Youth Development Intake record created successfully!', 'success');
                            }
                            this.systemVar1.isLoading = false;
                               this[NavigationMixin.Navigate]({ type: 'standard__webPage', attributes: { url: '/youthdevelopmentintakethankyoupage' }, });
                        })
                        .catch(error => {
                            this.showToast('Error!!!!', JSON.stringify(error), 'error');
                            this.systemVar1.isLoading = false;
                         //   this[NavigationMixin.Navigate]({ type: 'standard__webPage', attributes: { url: '/youthpage?ContactId=nullId' }, });
                            console.log('error 006', error);
                        })

                })
                .catch(error => { 
                    this.showToast('Error!!!!', JSON.stringify(error), 'error');
                    this.systemVar1.isLoading = false;
                  //  this[NavigationMixin.Navigate]({ type: 'standard__webPage', attributes: { url: '/youthpage?ContactId=nullId' }, });
                    console.log('error 005', error); 
                
                });

            // parentValues = {
            //     p_signature: '',
            //     p_signDate: new Date().toISOString().slice(0, 10)
            // };

        }
        else{
            console.log('Call Validate Input Method');
           this.validateInput();
        }
        
        
    }

    insertChildRecords(parentData) {
        // insert primary parent details in intake records
        let commonIntakeField = { DateOfSignature__c: new Date().toISOString().slice(0, 10), Name_of_Primary_Parent_Guardian__c: parentData['Id'], GuardianPhone__c: this.parentValues.p_PhoneNumber, RecordTypeId: this.systemVar1.youthDevelopmentRecordId, How_did_you_hear_about_us__c : this.parentValues.p_ReferralReason 
           , Caregiver_Parent__c:this.systemVar1.sContactId
        };
        if (parentData['FirstName']) { commonIntakeField['Primary_Guardian_First__c'] = parentData['FirstName']; }
        if (parentData['LastName']) { commonIntakeField['Primary_Guardian_Last__c'] = parentData['LastName']; }
        if (parentData['Primary_Guardian_Relationship__c']) { commonIntakeField['Primary_Guardian_Relationship__c'] = parentData['Primary_Guardian_Relationship__c']; }
        if (parentData['MailingStreet']) { commonIntakeField['Guardian_Street__c'] = parentData['MailingStreet']; }
        if (parentData['MailingCity']) { commonIntakeField['Guardian_City__c'] = parentData['MailingCity']; }
        if (parentData['MailingState']) { commonIntakeField['Guardian_State__c'] = parentData['MailingState']; }
        if (parentData['MailingPostalCode']) { commonIntakeField['Guardian_Zip__c'] = parentData['MailingPostalCode']; }
        if (parentData['Mobile_Phone__c']) { commonIntakeField['Mobile_Phone__c'] = parentData['Mobile_Phone__c']; }
        if (parentData['Work_Phone__c']) { commonIntakeField['Work_Phone__c'] = parentData['Work_Phone__c']; }
        if (parentData['Work_Email__c']) { commonIntakeField['Work_Email__c'] = parentData['Work_Email__c']; }
        if (parentData['Household_Monthly_Income__c']) { commonIntakeField['Household_Monthly_Income__c'] = parentData['Household_Monthly_Income__c']; }
         
        // insert secondary parent details in intake records
       if (parentData['Other_Caregiver_First__c']) { commonIntakeField['Other_Caregiver_First__c'] = parentData['Other_Caregiver_First__c']; }
       if (parentData['Other_Caregiver_Last__c']) { commonIntakeField['Other_Caregiver_Last__c'] = parentData['Other_Caregiver_Last__c']; }
       if (parentData['Other_Guardian_Relationship__c']) { commonIntakeField['Other_Guardian_Relationship__c'] = parentData['Other_Guardian_Relationship__c']; }
        if (parentData['Other_State__c']) { commonIntakeField['Other_State__c'] = parentData['Other_State__c']; }
        if (parentData['Other_Street__c']) { commonIntakeField['Other_Street__c'] = parentData['Other_Street__c']; }
        if (parentData['Other_City__c']) { commonIntakeField['Other_City__c'] = parentData['Other_City__c']; }
        if (parentData['Other_Zip_Code__c']) { commonIntakeField['Other_Zip_Code__c'] = parentData['Other_Zip_Code__c']; }
       
       // insert signature details in intake records
    //    if (this.parentValues.p_signature) { commonIntakeField['Youth_Signature__c'] = this.parentValues.p_signature; }
    //    if (this.parentValues.p_signatureAAP) { commonIntakeField['Signature_AAP__c'] = this.parentValues.p_signatureAAP; }
    //    if (this.parentValues.p_signatureCRRI) { commonIntakeField['Signature_CRRI__c'] = this.parentValues.p_signatureCRRI; }
    //    if (this.parentValues.p_signatureFHAA) { commonIntakeField['Signature_FHAA__c'] = this.parentValues.p_signatureFHAA; }
    //    if (this.parentValues.p_signatureGGBP) { commonIntakeField['Signature_GGBP__c'] = this.parentValues.p_signatureGGBP; }
    //    if (this.parentValues.p_signaturePCS) { commonIntakeField['Signature_PCS__c'] = this.parentValues.p_signaturePCS; }
    //    if (this.parentValues.p_signatureTC) { commonIntakeField['Signature_TC__c'] = this.parentValues.p_signatureTC; }
    //    if (this.parentValues.p_signatureRAFFERPA) { commonIntakeField['Signature_RAFFERPA__c'] = this.parentValues.p_signatureRAFFERPA; }
    //    if (this.parentValues.p_signatureCPIU) { commonIntakeField['Signature__c'] = this.parentValues.p_signatureCPIU; }


        let listOfIntake = [];
        this.systemVar1.childNodes.forEach(childItem => {
        let intake = {};
        intake['Name'] = childItem.c_FirstName + '_' + childItem.c_LastName + '_Youth Development';
        intake['First_Name__c'] = childItem.c_FirstName;
        intake['Last_Name__c'] = childItem.c_LastName;
        intake['Birthdate__c'] = childItem.c_Birthdate;
        if (childItem.clientId) { intake['Client__c'] = childItem.clientId; }
        if (childItem.caseId) { intake['Case__c'] = childItem.caseId; }
        if (childItem.c_GenderIdentity) { intake['Gender_Identity__c'] = childItem.c_GenderIdentity; }
        if (childItem.c_SSN){intake['SSN__c'] = childItem.c_SSN;}
        if (childItem.c_Race){intake['Race__c'] = childItem.c_Race;}
        if (childItem.c_Weight){intake['Weight_NUM__c'] = childItem.c_Weight;}
        if (childItem.c_HeightFeet){intake['Height_feet__c'] = childItem.c_HeightFeet;}
        if (childItem.c_HeightInches){intake['Height_inches__c'] = childItem.c_HeightInches;}
        if (childItem.c_IdentifyingMarks){intake['Identifying_Marks__c'] = childItem.c_IdentifyingMarks;}

        if (childItem.c_HairColor){intake['Hair_Color__c'] = childItem.c_HairColor;}
        if (childItem.c_EyeColor){intake['Eye_Color__c'] = childItem.c_EyeColor;}
        if (childItem.c_SelectSchool){intake['School__c'] = childItem.c_SelectSchool;}
        if (childItem.c_Grade){intake['Grade__c'] = childItem.c_Grade;}
        if (childItem.c_currentlyEnrollInSchool){intake['In_School__c'] = childItem.c_currentlyEnrollInSchool;}
        if (childItem.c_Iep){intake['IEP__c'] = childItem.c_Iep;}
    //  intake['YouthEducationConcern__c'] = childItem.c_YouthEducationConcern; 
        if (childItem.c_PlaceofEmployment){intake['Place_of_Employment__c'] = childItem.c_PlaceofEmployment;}
       // if (childItem.c_DurationatEmployment){intake['DurationatEmployment_c'] = childItem.c_DurationatEmployment;}   
        if (childItem.c_ProblemsAtWork){intake['ProblemsAtWork_c'] = childItem.c_ProblemsAtWork;}        
    if (childItem.c_EmergencyContact){intake['Emergency_Contact__c'] = childItem.c_EmergencyContact;}
    if (childItem.c_EmergencyContact2){intake['Emergency_Contact_2__c'] = childItem.c_EmergencyContact2;}
    if (childItem.c_IdentifyAreasofinterest) { intake['Interest_Areas__c'] = childItem.c_IdentifyAreasofinterest.join(';'); }
    if (childItem.c_FirstName1){intake['Emergency_Contact_First__c'] = childItem.c_FirstName1;}
    if (childItem.c_LastName1){intake['Emergency_Contact_Last__c'] = childItem.c_LastName1;}
    if (childItem.c_LastName1){intake['Emergency_Contact_Last__c'] = childItem.c_LastName1;}
    if (childItem.c_Phone1){intake['Emergency_Contact_Phone__c'] = childItem.c_Phone1;}
    //  intake['Emergency_Contact_Relationship__c'] = childItem.c_Relationship2;
    
    if (childItem.c_FirstName2){intake['Emergency_Contact_2_First__c'] = childItem.c_FirstName2;}
    if (childItem.c_FirstName2){intake['Emergency_Contact_2_Last__c'] = childItem.c_LastName2;}
        
    if (childItem.c_Phone2){intake['Emergency_Contact_2_Phone__c'] = childItem.c_Phone2};
    if (childItem.c_ApprovedPickUp1Name){intake['Approved_Pick_Up_1__c'] = childItem.c_ApprovedPickUp1Name;}
    if (childItem.c_PickUp1Relationship){intake['Approved_Pick_Up_1_Relationship__c'] = childItem.c_PickUp1Relationship;}
    if (childItem.c_PickUp1Relationship){intake['Approved_Pick_Up_1_Phone__c'] = childItem.c_ApprovedPickUp1Phone;} 

   if (childItem.c_ApprovedPickUp2Name){intake['Approved_Pick_Up_2__c'] = childItem.c_ApprovedPickUp2Name;}
   if (childItem.c_PickUp2Relationship){intake['Approved_Pick_Up_2_Relationship__c'] = childItem.c_PickUp2Relationship;} 
   if (childItem.c_ApprovedPickUp2Phone){intake['Approved_Pick_Up_2_Phone__c'] = childItem.c_ApprovedPickUp2Phone;} 

       //  intake['AlternateCity__c'] = childItem.c_AlternateCity;
       //  intake['AlternateState__c'] = childItem.c_AlternateState;
       //  intake['AlternateZipCode__c'] = childItem.c_AlternateZipCode;

    if(childItem.c_PhysicianName){intake['Physician_Name__c'] = childItem.c_PhysicianName;}
    if(childItem.c_PhysicianPhone){intake['Physician_Phone__c'] = childItem.c_PhysicianPhone;}
    if(childItem.c_InsuranceCarrier){intake['Insurance_Carrier__c'] = childItem.c_InsuranceCarrier;}
    if(childItem.c_InsuranceNumber){intake['Insurance_Number__c'] = childItem.c_InsuranceNumber;}
    if(childItem.c_LastPhysical){intake['Last_Physical_MM_YYYY__c'] = childItem.c_LastPhysical;}
    if(childItem.c_DentalVisit){intake['Dental_Visit__c'] = childItem.c_DentalVisit;}
   // if(childItem.c_RecentVision){intake['Most_Recent_Vision_Exam__c '] = childItem.c_RecentVision;}
   // if(childItem.c_RecentHearing){intake['Most_Recent_Hearing_Exam__c  '] = childItem.c_RecentHearing;}
    if(childItem.c_OperationsInjuries){intake['Operations_Injuries__c'] = childItem.c_OperationsInjuries};
     
    //  intake['PhysicalMentalHistory__c'] = childItem.c_PhysicalMentalHistory;
if(childItem.c_Medications){intake['Medications__c'] = childItem.c_Medications;}
if(childItem.c_MedicationCompliance){intake['Medication_Compliance__c'] = childItem.c_MedicationCompliance;}
if(childItem.c_Limitations){intake['Limitations__c'] = childItem.c_Limitations;}
//  intake['Medication_Compliance__c '] = childItem.c_MedicationCompliance;
//  intake['Limitations__c'] = childItem.c_Limitations;

if(childItem.c_HadIllness) { intake['Had_illness__c'] = childItem.c_HadIllness.join(';'); }
if(childItem.c_MentalHealthDiagnosis) {intake['Physical_Mental_History__c'] = childItem.c_MentalHealthDiagnosis;} 
if(childItem.c_AdditionalMentalHealthInformation) {intake['MH_History_Detailed__c'] = childItem.c_AdditionalMentalHealthInformation;} 
//  intake['Covid19Symptoms__c'] = childItem.c_Covid19Symptoms;
if (childItem.c_Allergies) { intake['Allergies__c'] = childItem.c_Allergies.join(';'); }
if( childItem.c_AllergyDetails) {intake['Allergies_Detailed__c'] = childItem.c_AllergyDetails;} 
if (childItem.c_ChildAttend) { intake['Child_will_Attend_Afterschool__c'] = childItem.c_ChildAttend.join(';'); }
   
    listOfIntake.push({ ...intake, ...commonIntakeField });
        });

        console.log('commonIntakeField: ', commonIntakeField);
        console.log('listOfIntake', listOfIntake);
        return listOfIntake;

    }
    checkRequiedFields() {
        this.systemVar1.isFieldEmpty = false;
        // check required fields for primary parent 
        if (!this.parentValues.p_FirstName.trim().length > 0) { this.setErrorField('.checkParentFirstName', 'Please Enter the Primary Parent First Name') }
        if (!this.parentValues.p_LastName.trim().length > 0) { this.setErrorField('.checkParentLastName', 'Please Enter the Primary Parent Last Name') }
        if (!this.parentValues.p_relation.trim().length > 0) { this.setErrorField('.checkParentRelationship', 'Please Enter Primary Parent Relationships') }
        if (!this.parentValues.p_Mailingstreet.trim().length > 0) { this.setErrorField('.checkParentStreet', 'Please Enter Primary Parent Mailing Street') }
        if (!this.parentValues.p_MailingCity.trim().length > 0) { this.setErrorField('.checkParentCity', 'Please Enter Primary Parent Mailing City') }
        if (!this.parentValues.p_MailingState.trim().length > 0) { this.setErrorField('.checkParentState', 'Please Enter Primary Parent Mailing State') }
        if (!this.parentValues.p_MailingPostalCode.trim().length > 0) { this.setErrorField('.checkParentZipCode', 'Please Enter Primary Parent Mailing Postal Code') }
      //  if (!this.parentValues.p_PhoneNumber.trim().length > 0) { this.setErrorField('.checkParentPhoneNo', 'Please Enter the Primary Parent Home Phone Number') }
        if (!this.parentValues.p_MPhoneNumber.trim().length > 0) { this.setErrorField('.checkParentMPhoneNo', 'Please Enter the Primary Parent Mobile Phone Number') }
        if (!this.parentValues.p_MPhoneNumber.trim().length > 0) { this.setErrorField('.checkParentEmail', 'Please Enter the Primary Parent E-Mail Address') }
        
        // check required fields for secondary parent 
        if (!this.secondaryParentValues.p_FirstName.trim().length > 0) { this.setErrorField('.checkSecondaryParentFirstName', 'Please Enter the Secondary Parent First Name') }
        if (!this.secondaryParentValues.p_LastName.trim().length > 0) { this.setErrorField('.checkSecondaryParentLastName', 'Please Enter the Secondary Parent Last Name') }
         if (!this.secondaryParentValues.p_MPhoneNumber.trim().length > 0) { this.setErrorField('.checkSParentMPhone', 'Please Enter the Secondary Parent Mobile Number') }
         if (!this.secondaryParentValues.p_Mailingstreet.trim().length > 0) { this.setErrorField('.checkSParentRelationship', 'Please Enter the Secondary Parent Relationship') }
        if (!this.secondaryParentValues.p_Mailingstreet.trim().length > 0) { this.setErrorField('.checkSParentStreet', 'Please Enter the Secondary Parent Mailing Street') }
        if (!this.secondaryParentValues.p_MailingCity.trim().length > 0) { this.setErrorField('.checkSParentCity', 'Please Enter the Secondary Parent Mailing City') }
        if (!this.secondaryParentValues.p_MailingState.trim().length > 0) { this.setErrorField('.checkSParentState', 'Please Enter the Secondary Parent Mailing State') }
       if (!this.secondaryParentValues.p_MailingPostalCode.trim().length > 0) { this.setErrorField('.checkSParentZipCode', 'Please Enter the Secondary Parent Mailing Postal Code') }
        if (!this.secondaryParentValues.p_email.trim().length > 0) { this.setErrorField('.checkSParentEmail', 'Please Enter the Secondary Parent E-Mail Address') }
         if (!this.parentValues.p_signature.trim().length > 0) { this.setErrorField('.checkParentSign', 'Please Enter the Parent / Guardian Signature') }
         
         //  Check Consent Form Singature details
        if(!this.parentValues.p_signatureFHAA.trim().length > 0) { this.setErrorField('.checkFHAASign', 'ParentSignatue1') }
       else if (!this.parentValues.p_signatureTC.trim().length > 0) { this.setErrorField('.checkTCSign', 'ParentSignatue2') }
       else if (!this.parentValues.p_signatureCPIU.trim().length > 0) { this.setErrorField('.checkCPIUSign', 'ParentSignatue3') } 
       else if(!this.parentValues.p_signaturePCS.trim().length > 0) { this.setErrorField('.checkPCSSign', 'ParentSignatue4') }
       else if(!this.parentValues.p_signatureRAFFERPA.trim().length > 0) { this.setErrorField('.checkRAFFERPASign', 'ParentSignatue5') }
       else if(!this.parentValues.p_signatureCRRI.trim().length > 0) { this.setErrorField('.checkCRRISign', 'ParentSignatue6') }
       else if(!this.parentValues.p_signatureGGBP.trim().length > 0) { this.setErrorField('.checkGGBPSign', 'ParentSignatue7') }
         
         // check required fields for Childs 
        for (let i = 0; i < this.systemVar1.childNodes.length; i++) {
            this.systemVar1.requiredChild.forEach(item => {
                this.setErrorChildField(i, item, item + ' is required.')
            })
        }


       
    }

    setErrorField(className, customError) {
        console.log('Im in setErrorField===>');
        console.log('className===>',className);
        console.log('customError===>',customError);
        let errorInput = this.template.querySelector(className);
        console.log('errorInput===>',errorInput);
        if(errorInput){
        errorInput.setCustomValidity(customError);
        errorInput.reportValidity();
       //  errorInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
        this.systemVar1.isFieldEmpty = true;
       //  this.validateInput();
        
        console.log('isFieldEmpty===>',this.systemVar1.isFieldEmpty);
    }
    
   validateInput() {
        console.log('Im in Validate Input');
        const errorMessagePara = this.template.querySelector('.error-message');
        console.log('errorMessagePara==>',errorMessagePara);
        // Example validation logic
      //  const isValid = false; // Replace this with actual validation logic
        
        if (this.systemVar1.isFieldEmpty) {
            errorMessagePara.textContent = 'Note: Signature missing in one or more sections! Please review the form again and complete the missing Signatures and Save again!';
            errorMessagePara.classList.add('visible');
        } else {
            errorMessagePara.textContent = '';
            errorMessagePara.classList.remove('visible');
        }
    }
    //Set Error in Childs
    setErrorFieldInChild(className, customError) {
        console.log('Im in setErrorField===>');
        console.log('className===>',className);
        console.log('customError===>',customError);
        let errorInput = this.template.querySelector(className);
        console.log('errorInput===>',errorInput);
        if(errorInput){
        errorInput.setCustomValidity(customError);
        errorInput.reportValidity();
        errorInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
        this.systemVar1.isFieldEmpty = true;
       //  this.validateInput();
        
        console.log('isFieldEmpty in child===>',this.systemVar1.isFieldEmpty);
    }

//Set Error in Consent Form

    setConsentErrorField(className, customError) {
        console.log('Im in setConsentErrorField===>');
        console.log('className===>',className);
        console.log('customError===>',customError);
        let errorInput = this.template.querySelector(className);
        if(errorInput){
            errorInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
        }
        console.log('errorInput===>',errorInput);
        errorInput.setCustomValidity(customError);
        errorInput.reportValidity();
        this.systemVar1.isFieldEmpty = true;

        
        console.log('isFieldEmpty in consent===>',this.systemVar1.isFieldEmpty);
    }

    setErrorChildField(index, fieldName, customError) {
        let errorInput = this.template.querySelector('[data-id="' + index + '"][data-name="' + fieldName + '"]');

        if (!errorInput.value || !errorInput.value.trim().length > 0) {
            errorInput.setCustomValidity(customError);
            this.systemVar1.isFieldEmpty = true;
        }
        if (!customError.length > 0) {
            errorInput.setCustomValidity('');
        }

        errorInput.reportValidity();
    }
    handleReferralSource(event) {
        this.parentValues.p_ReferralReason = event.target.value;
      //  if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentFirstName', ''); }
    }
//  handler for primary parent event handling
handleParentFirstName(event) {
        this.parentValues.p_FirstName = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentFirstName', ''); }
    }
    handleParentLastName(event) {
        this.parentValues.p_LastName = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentLastName', ''); }
    }
    handleParentPhoneNumber(event) {
        this.parentValues.p_PhoneNumber = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentPhoneNo', ''); }
    }
    handleParentMPhoneNumber(event) {
        this.parentValues.p_MPhoneNumber = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentMPhoneNo', ''); }
    }
    handleParentWPhoneNumber(event) {
        this.parentValues.p_WPhoneNumber = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentWPhoneNo', ''); }
    }
  
    handleParentEmail(event) { 
        this.parentValues.p_email = event.target.value; 
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentEmail', ''); }
        }
    handleParentMailingstreet(event) { 
        this.parentValues.p_Mailingstreet = event.target.value; 
         if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentStreet', ''); }
        }
    handleParentMailingCity(event) { 
        this.parentValues.p_MailingCity = event.target.value;
         if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentCity', ''); }
         }
    handleParentMailingState(event) { 
        this.parentValues.p_MailingState = event.detail.value; 
         if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentState', ''); }
        }
    handleParentMailingPostalCode(event) { 
        this.parentValues.p_MailingPostalCode = event.target.value; 
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentZipCode', ''); }
        }
    handleParentRelation(event) { 
        
        this.parentValues.p_relation = event.detail.value; 
    if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentRelationship', ''); }
    }
    handleParentSignature(event) {
        this.parentValues.p_signature = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentSign', ''); }
    }
    handleParentPlaceofEmployment(event) { this.parentValues.p_PlaceOfEmployment = event.detail.value; }
    handleIncomeSource(event) { this.parentValues.p_IncomeSource = event.detail.value; }
    handleMonthlyIncome(event) { this.parentValues.p_MonthlyIncome = event.detail.value; }
    handleHousingType(event) { this.parentValues.p_Housing = event.detail.value; }
    handleReceivePublicAssistance(event) { this.parentValues.p_ReceivePublicAssistance = event.detail.value; }
    handleHousingStatus(event) { this.parentValues.p_HousingStatus = event.detail.value; }
   
    //  handler for Secondary parent event handling

    handleSecondaryParentFirstName(event) {
        this.secondaryParentValues.p_FirstName = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkSecondaryParentFirstName', ''); }
    }
    handleSecondaryParentLastName(event) {
        this.secondaryParentValues.p_LastName = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkSecondaryParentLastName', ''); }
    }
    handleSecondaryParentPhoneNumber(event) {
        this.secondaryParentValues.p_PhoneNumber = event.target.value;
     //   if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkSecondaryParentPhoneNo', ''); }
    }
    handleSecondaryParentMPhoneNumber(event) {
        this.secondaryParentValues.p_MPhoneNumber = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkSParentMPhone', ''); }
    }
    handleSecondaryParentWPhoneNumber(event) {
        this.secondaryParentValues.p_WPhoneNumber = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkSecondaryParentWPhoneNo', ''); }
    }
 
    handleSecondaryParentEmail(event) { 
        this.secondaryParentValues.p_email = event.target.value;
          if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkSParentEmail', ''); }
         }
    handleSecondaryParentMailingstreet(event) { 
        this.secondaryParentValues.p_Mailingstreet = event.target.value; 
         if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkSParentStreet', ''); }
        }
    handleSecondaryParentMailingCity(event) { 
        this.secondaryParentValues.p_MailingCity = event.target.value;
         if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkSParentCity', ''); } 
        }
    handleSecondaryParentMailingState(event) { 
        this.secondaryParentValues.p_MailingState = event.detail.value; 
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkSParentState', ''); } 
        }
    handleSecondaryParentMailingPostalCode(event) { 
        this.secondaryParentValues.p_MailingPostalCode = event.target.value; 
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkSParentZipCode', ''); }
        }
    handleSecondaryParentRelation(event) { 
        this.secondaryParentValues.p_relation = event.detail.value; 
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkSParentRelationship', ''); }
        }
    handleSecondaryParentPlaceofEmployment(event) { this.secondaryParentValues.p_PlaceOfEmployment = event.detail.value; }
 

    
    addChild() {
        let childVal = JSON.parse(JSON.stringify(this.childValue));
        childVal.childIndex = this.systemVar1.childNodes.length + 1;
        this.systemVar1.childNodes.push(childVal);
        this.systemVar1.isDeleteRowButtonVisible = this.systemVar1.childNodes.length > 1;
        this.showToast('The Youth Development has added a new intake form.', '', 'success')
    }
    async handleDeleteRow(event) {
        const ind = event.currentTarget.dataset.index;
         
        if (this.systemVar1.childNodes.length > 1) {
            const result = await LightningConfirm.open({
                message: 'Are you sure you want to delete the child?',
                variant: 'header',
                theme: 'inverse',
                label: 'Delete Child Record',
            });
            if (result) {
                var tempVar = JSON.parse(JSON.stringify(this.systemVar1.childNodes));
                tempVar.splice(ind, 1);
                this.systemVar1.childNodes = JSON.parse(JSON.stringify(tempVar));
                this.showToast('The record of the child ' + (parseInt(ind) + 1) + ' intake form is deleted from the Youth Development form.', '', 'warning')
            }
            this.systemVar1.childNodes = JSON.parse(JSON.stringify(this.systemVar1.childNodes.map((item, index) => { return { ...item, childIndex: index + 1 }; })));
            this.systemVar1.isDeleteRowButtonVisible = this.systemVar1.childNodes.length > 1;

        }

    }
    handleChildFirstName(event) {
        this.systemVar1.childNodes[event.currentTarget.dataset.id].c_FirstName = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorChildField(event.currentTarget.dataset.id, 'First_Name', '') }
    }
    handleInvalid(event) {
        event.preventDefault(); // Prevent default "This field is required" message
        event.target.setCustomValidity(''); // Clear custom validity to avoid showing default message
    }
    handleChildLastName(event) {
        this.systemVar1.childNodes[event.currentTarget.dataset.id].c_LastName = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorChildField(event.currentTarget.dataset.id, 'Last_Name', '') }
    }
    handleChildBirthdate(event) {
        this.systemVar1.childNodes[event.currentTarget.dataset.id].c_Birthdate = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorChildField(event.currentTarget.dataset.id, 'Birthdate', '') }
    }

    setErrorChildField(index, fieldName, customError) {
        let errorInput = this.template.querySelector('[data-id="' + index + '"][data-name="' + fieldName + '"]');

        if (!errorInput.value || !errorInput.value.trim().length > 0) {
            errorInput.setCustomValidity(customError);
            this.systemVar1.isFieldEmpty = true;
        }
        if (!customError.length > 0) {
            errorInput.setCustomValidity('');
        }

        errorInput.reportValidity();
    }
showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }

handlelogo() {  location.replace(window.location.origin+'/mainForm/s/');    }
//  Handle Model pop functions 
openModal(event) {
    this.isModalOpen = true;
    const rowIndex = event.currentTarget.dataset.index;
    this.childData =this.systemVar1.childNodes[rowIndex];
    console.log('rowIndex===>',rowIndex);
    console.log('childData===>',this.childData);
}

closeModal() { this.isModalOpen = false;}

openConsentModal() {
    this.isConsentModalOpen = true;
   // const rowIndex = event.currentTarget.dataset.index;
  //  this.childData =this.systemVar1.childNodes[rowIndex];
   // console.log('rowIndex===>',rowIndex);
  // console.log('childData===>',this.childData);
}

closeConsentModal() { this.isConsentModalOpen = false;}

handleFieldChange(event) {
    const field = event.target.dataset.id;
    this.childData[field] = event.target.value;
   
    console.log(' value ==>'+event.target.value);
    console.log('childData[field] in Field Change===>',this.childData[field]);
    console.log('childData in Field Change===>',this.childData);
}
handleConsentFieldChange(event) {
    // const field = event.target.dataset.id;
    // this.childData[field] = event.target.value;
   
    // console.log(' value ==>'+event.target.value);
    // console.log('childData[field] in Field Change===>',this.childData[field]);
    // console.log('childData in Field Change===>',this.childData);
}
handleChildFN(event) {
    this.childData['c_FirstName'] =event.target.value;
    const currentIndex = this.childData['childIndex'];
    console.log('childIndex==>',currentIndex);
    
    if (event.target.value.trim().length > 0 ) { 
        this.setErrorField('.checkChildFirstName', ''); 
        this.setErrorField('.childFirst', ''); 
      //  this.systemVar1.childNodes[event.currentTarget.dataset.id].c_FirstName = event.target.value;
      //  if (event.target.value && event.target.value.trim().length > 0) { this.setErrorChildField(event.currentTarget.dataset.id, 'First_Name', '') }
    }
    
}
handleChildLN(event) {
    this.childData['c_LastName'] = event.target.value;
    if (event.target.value.trim().length > 0 ) { 
        this.setErrorField('.checkChildLastName', ''); 
        this.setErrorField('.childLast', '') ;
    }
}
handleChildBD(event) {
   this.childData['c_Birthdate'] = event.target.value;
   if (event.target.value.trim().length > 0 ) { 
    this.setErrorField('.checkChildBirthDate', '') ;
   // this.setErrorField('.childBD', ''); 
}
}
handleChildSchool(event) {

    this.childData['c_SelectSchool'] = event.target.value;
    if (event.target.value.trim().length > 0 ) { this.setErrorField('.checkSchool', '') }
}
handleChildGrade(event) {

    this.childData['c_Grade'] = event.target.value;
    this.showOtherGradeLevel = (event.target.value === 'Other');
    if (event.target.value.trim().length > 0 ) { this.setErrorField('.checkGrade', '') }
}
handleOtherGrade(event) {

    this.childData['c_OtherGrade'] = event.target.value;
   
    if (event.target.value.trim().length > 0 ) { this.setErrorField('.checkOtherGrade', '') }
}
handleFirstName1(event) {

    this.childData['c_FirstName1'] = event.target.value;
    if (event.target.value.trim().length > 0 ) { this.setErrorField('.checkFirstName1', '') }
}

handleLastName1(event) {

    this.childData['c_LastName1'] = event.target.value;
  if (event.target.value.trim().length > 0 ) { this.setErrorField('.checkLastName1', '') }
}
handlePhone1(event) {

    this.childData['c_Phone1'] = event.target.value;
   if (event.target.value.trim().length > 0 ) { this.setErrorField('.checkPhone1', '') }
}
handleRelationship1(event) {

    this.childData['c_Relationship1'] = event.target.value;
    if (event.target.value.trim().length > 0 ) { this.setErrorField('.checkRelationship1', '') }
}

handleEnrollInSchool(event) {

    console.log('EnrollInSchoolValue===>',this.childData);
    this.childData['c_currentlyEnrollInSchool'] = event.target.checked;
    console.log('childData in Field Change===>',this.childData);
}
handleIEPChange(event) {

    console.log('IEPValue===>',this.childData);
    this.childData['c_Iep'] = event.target.checked;
    console.log('childData in Field Change===>',this.childData);
}

handleSave() {
    // Handle save logic, e.g., calling an Apex method to save data
    const currentIndex = this.childData['childIndex'];
    
    console.log('currentIndex===>',currentIndex);
    this.systemVar1.childNodes[currentIndex-1] =this.childData;
    console.log('childData===>',this.childData);
    console.log('childNodes in index===>',this.systemVar1.childNodes[currentIndex-1]);
    console.log('childNodes===>',this.systemVar1.childNodes);
    this.systemVar1.isFieldEmpty =false;
    if (!this.systemVar1.childNodes[currentIndex-1].c_FirstName.trim().length > 0) { this.setErrorFieldInChild('.checkChildFirstName', 'Please Enter the First Name') }
    else if (!this.systemVar1.childNodes[currentIndex-1].c_LastName.trim().length > 0) { this.setErrorFieldInChild('.checkChildLastName', 'Please Enter Last Name') }
    else if (!this.systemVar1.childNodes[currentIndex-1].c_Birthdate.trim().length > 0) { this.setErrorFieldInChild('.checkChildBirthDate', 'Please Select the BirthDate') }
    else if (!this.systemVar1.childNodes[currentIndex-1].c_SelectSchool.trim().length > 0) { this.setErrorFieldInChild('.checkSchool', 'Please Select the School Name') }
    else if (!this.systemVar1.childNodes[currentIndex-1].c_Grade.trim().length > 0) { this.setErrorFieldInChild('.checkGrade', 'Please Enter the Grade') }
    else if (this.systemVar1.childNodes[currentIndex-1].c_Grade==='Other' && !this.systemVar1.childNodes[currentIndex-1].c_OtherGrade.trim().length > 0 ) { this.setErrorFieldInChild('.checkotherGrade', 'Please Enter the Other Grade') }
    else if (!this.systemVar1.childNodes[currentIndex-1].c_FirstName1.trim().length > 0) { this.setErrorFieldInChild('.checkFirstName1', 'Please Enter the Emergency First Name1') }
    else if (!this.systemVar1.childNodes[currentIndex-1].c_LastName1.trim().length > 0) { this.setErrorFieldInChild('.checkLastName1', 'Please Enter the Emergency Last Name1') }
    else if (!this.systemVar1.childNodes[currentIndex-1].c_Phone1.trim().length > 0) { this.setErrorFieldInChild('.checkPhone1', 'Please Enter the Emergency Phone1') }
   else if (!this.systemVar1.childNodes[currentIndex-1].c_Relationship1.trim().length > 0) { this.setErrorFieldInChild('.checkRelationship1', 'Please Enter the Relationship1') }
   

    
    
    
    // Add more fields as needed

    // Close the modal after saving
   // this.closeModal();
    if (!this.systemVar1.isFieldEmpty) {
        this.closeModal();
    }
   
} 
handleConsetSave() {
console.log('Im in handle Consent Save===>');
 console.log('parentValues===>',this.parentValues);
this.systemVar1.isFieldEmpty =false;
if(!this.parentValues.p_signatureFHAA.trim().length > 0) { this.setConsentErrorField('.checkFHAASign', 'Please Enter the Parent / Guardian Signature') }
else if (!this.parentValues.p_signatureTC.trim().length > 0) { this.setConsentErrorField('.checkTCSign', 'Please Enter the Parent / Guardian Signature') }
else if (!this.parentValues.p_signatureCPIU.trim().length > 0) { this.setConsentErrorField('.checkCPIUSign', 'Please Enter the Parent / Guardian Signature') } 
else if(!this.parentValues.p_signaturePCS.trim().length > 0) { this.setConsentErrorField('.checkPCSSign', 'Please Enter the Parent / Guardian Signature') }
else if(!this.parentValues.p_signatureRAFFERPA.trim().length > 0) { this.setConsentErrorField('.checkRAFFERPASign', 'Please Enter the Parent / Guardian Signature') }
else if(!this.parentValues.p_signatureCRRI.trim().length > 0) { this.setConsentErrorField('.checkCRRISign', 'Please Enter the Parent / Guardian Signature') }
else if(!this.parentValues.p_signatureGGBP.trim().length > 0) { this.setConsentErrorField('.checkGGBPSign', 'Please Enter the Parent / Guardian Signature') }





   
   // check if all signature is not black then close popup window 
   if (!this.systemVar1.isFieldEmpty) {
     console.log('parentValues2===>',this.parentValues);
        this.closeConsentModal();
    }
  // this.closeConsentModal(); 
} 

// handle consent form Signatures Fields 
handleAAPSignature(event) {
        this.parentValues.p_signatureAAP = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkAAPSign', ''); }
    }
	
handleCRRISignature(event) {
        this.parentValues.p_signatureCRRI = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkCRRISign', ''); }
    }
handleFHAASignature(event) {
        this.parentValues.p_signatureFHAA = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkFHAASign', ''); }
    }
handleGGBPSignature(event) {
        this.parentValues.p_signatureGGBP = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkGGBPSign', ''); }
    }
handlePCSSignature(event) {
        this.parentValues.p_signaturePCS = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkPCSSign', ''); }
    }
	
handleRAFFERPASignature(event) {
        this.parentValues.p_signatureRAFFERPA = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkRAFFERPASign', ''); }
    }
		
handleTCSignature(event) {
        this.parentValues.p_signatureTC = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkTCSign', ''); }
    }
handleCPIUSignature(event) {
        this.parentValues.p_signatureCPIU = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkCPIUSign', ''); }
    }


}