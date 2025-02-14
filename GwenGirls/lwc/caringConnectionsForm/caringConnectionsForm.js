import { LightningElement, track, wire } from 'lwc';
import ggFormLogo from "@salesforce/resourceUrl/caringconnectionLog";
import { CurrentPageReference } from 'lightning/navigation';
import LightningConfirm from 'lightning/confirm';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getFieldsValues from '@salesforce/apex/CaringConnectionsFormController.getFieldsValues';
import upsertParentContact from '@salesforce/apex/CaringConnectionsFormController.upsertParentContact';
import getExistingRecord from '@salesforce/apex/CaringConnectionsFormController.getExistingRecord';
import createIntake from '@salesforce/apex/GGFormController.createIntake';
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import Intake_OBJECT from "@salesforce/schema/Intake__c";
import { NavigationMixin } from 'lightning/navigation';




export default class CaringConnectionsForm extends NavigationMixin(LightningElement) {

    //  https://gwensgirls--partial.sandbox.my.site.com/mainForm/s/caringconnectionsintake?ContactId=nullId
    //  https://gwensgirls--partial.sandbox.my.site.com/mainForm/s/caringconnectionform?ContactId=nullId
    @track formLogo = ggFormLogo;
    @track systemFieldOption = {};
    @track systemVar1 = {
        isLoading: true, contactId: '', isFieldEmpty: false, familyCaseCourt: [{ label: 'Yes', value: 'true' }, { label: 'No', value: 'false' }], childNodes: [], isDeleteRowButtonVisible: false, caringConectionRecordId: '',
        picklistValuesName: ['neighborhood', 'staffCompletingIntake', 'genderIdentity', 'genderPronouns', 'racialEthnicIdentity', 'youthrelationship', 'primaryConcern', 'primaryConcernExpanded', 'secondaryConcern', 'secondaryConcernExpanded', 'thirdConcern',
            'thirdConcernExpanded', 'needsCategory', 'immediateSafetyConcerns', 'clientHasaSafetyPlan', 'previousSystemInvolvement', 'guardianConsentReceived', 'clientConsentReceived14YOA', 'guardianState', 'referralType', 'referralTypeExpanded', 'reasonForReferral'],
        requiredChild: ['First_Name', 'Last_Name', 'Birthdate', 'Signature']
    };
    @track parentValues = {
        neighborhoodValue: '', nameOfStaffCompletingIntake: '', otherNeighborhood: '', p_FirstName: '', p_LastName: '', p_PhoneNumber: '', p_email: '', p_Mailingstreet: '', p_relation: '', p_ReferralFirstName: '', p_ReferralLastName: '', p_ReferralTitle: '',
        p_ReferralPhone: '', p_ReferralType: '', p_ReferralTypeExpanded: '', p_ReferralTypeOther: '', p_ReferralReason: '',
        p_MailingCity: '', p_MailingState: '', p_MailingPostalCode: '', p_bestTime: '', p_guardianConsentReceived: '', p_clientConsentReceived14YOA: '', p_AdditionalComments: '', p_signature: '', p_signDate: new Date().toISOString().slice(0, 10)
    };
    @track childValue = {
        childIndex: 1, isChildOpen: true, c_FirstName: '', c_LastName: '', c_Birthdate: '', c_GenderIdentity: '', c_PreferredName: '', c_GenderPronouns: '', c_RacialEthnicIdentity: '', c_IdentityExpansion: '', c_Phone: '', c_PrimaryConcern: '',
        c_secondaryConcern: '', c_thirdConcern: '', c_NeedsCategory: '', c_ImmediateSafetyConcerns: '', c_Comment: '', c_ClientHasaSafetyPlan: '', c_SafetyPlanExplanation: '', c_YouthSystemInvolvement: '', c_SystemInvolvementBrief: '',
        c_CYFCaseNumber: '', c_CYFCaseworker: '', c_CYFPhone: '', c_CYFRegional: '', c_Signature: '', c_FamilyCaseCourt: 'false',
    };


    @wire(getObjectInfo, { objectApiName: Intake_OBJECT })
    wireAccountData(objectInfo, error) {
        if (objectInfo) {
            let recordTypeInfo = objectInfo?.data?.recordTypeInfos;
            if (recordTypeInfo) { this.systemVar1.caringConectionRecordId = Object.keys(recordTypeInfo).find(rtype => (recordTypeInfo[rtype].name === 'Caring Connections')); }
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
                this.parentValues.p_FirstName = data.parentContact.FirstName;
                this.parentValues.p_LastName = data.parentContact.LastName;
                this.parentValues.p_PhoneNumber = data.parentContact.HomePhone;
                this.parentValues.p_email = data.parentContact.npe01__HomeEmail__c;
                this.parentValues.p_bestTime = data.parentContact.BestTimetoContactGuardian__c;
                this.parentValues.p_Mailingstreet = data.parentContact.MailingStreet;
                this.parentValues.p_MailingState = data.parentContact.MailingState;
                this.parentValues.p_MailingCity = data.parentContact.MailingCity;
                this.parentValues.p_MailingPostalCode = data.parentContact.MailingPostalCode;
                if (data.childContact) { this.assignExistingContactRecord(data.childContact) }
            }


            this.systemVar1.isLoading = false;
            console.log('data', data);

        }
        else if (error) { console.log('error 011', error); }
    }


    assignExistingContactRecord(listOfContact) {
        if(listOfContact.length>0){
        let assignCommonFields = listOfContact[0];
        this.parentValues.neighborhoodValue =assignCommonFields['Neighborhood_CC__c'];
        this.parentValues.otherNeighborhood = assignCommonFields['Other_Neighborhood_CC__c'] ? assignCommonFields['Other_Neighborhood_CC__c']: '';
        this.parentValues.p_guardianConsentReceived = assignCommonFields['GuardianConsentReceived__c'] ? assignCommonFields['GuardianConsentReceived__c'] : '';
        this.parentValues.p_clientConsentReceived14YOA = assignCommonFields['ClientConsentReceived14YOA__c'] ? assignCommonFields['ClientConsentReceived14YOA__c']:'';
        this.parentValues.p_bestTime = assignCommonFields['BestTimetoContactGuardian__c']? assignCommonFields['BestTimetoContactGuardian__c']:'';
        this.parentValues.p_AdditionalComments = assignCommonFields['AdditionalInformationRegardingConsent__c']? assignCommonFields['AdditionalInformationRegardingConsent__c']:'';
        this.parentValues.p_ReferralFirstName = assignCommonFields['Referral_Source_First__c'];
        this.parentValues.p_ReferralLastName = assignCommonFields['Referral_Source_Last__c'];
        this.parentValues.p_ReferralTitle = assignCommonFields['Referrer_Title__c'];
        this.parentValues.p_ReferralPhone = assignCommonFields['ReferralPhone__c'];
        this.parentValues.p_ReferralType = assignCommonFields['Referral_Source_Type__c'];
        this.parentValues.p_ReferralTypeOther = assignCommonFields['Referral_Source_Type_Other__c'];
        this.parentValues.p_ReferralReason = assignCommonFields['Reason_for_Referral_By_Referrer__c'];
        this.parentValues.p_relation = assignCommonFields['Primary_Guardian_Relationship__c'];
        let tempListOfContact = [];
        listOfContact.forEach((item, index) => {
            let contact = {};
            contact['childIndex'] = index + 1;
            contact['isChildOpen'] = true;
            contact['c_FirstName'] = item.FirstName;
            contact['c_LastName'] = item.LastName;
            contact['c_Birthdate'] = item.Birthdate;
            contact['c_GenderIdentity'] = item.GenderIdentity ? item.GenderIdentity : '';
            contact['c_PreferredName'] = item.PreferredName__c ? item.PreferredName__c : '';
            contact['c_GenderPronouns'] = item.GenderPronouns__c ? item.GenderPronouns__c : '';
            contact['c_RacialEthnicIdentity'] = item.Racial_Ethnic_Identity__c ? item.Racial_Ethnic_Identity__c : '';
            contact['c_IdentityExpansion'] = item.Race_Other_Identity_Expansion__c ? item.Race_Other_Identity_Expansion__c : '';
            contact['c_Phone'] = item.MobilePhone ? item.MobilePhone : '';
            contact['c_PrimaryConcern'] = item.Primary_Reason_for_Referral__c ? item.Primary_Reason_for_Referral__c : '';
            contact['c_secondaryConcern'] = item.Secondary_Reason_for_Referral__c ? item.Secondary_Reason_for_Referral__c : '';
            contact['c_thirdConcern'] = item.Additional_Reason_for_Referral__c ? item.Additional_Reason_for_Referral__c : '';
            contact['c_ImmediateSafetyConcerns'] = item.ImmediateSafetyConcerns__c ? item.ImmediateSafetyConcerns__c : '';
            contact['c_Comment'] = item.Comments__c ? item.Comments__c : '';
            contact['c_ClientHasaSafetyPlan'] = item.ClientHasaSafetyPlan__c ? item.ClientHasaSafetyPlan__c : '';
            contact['c_SafetyPlanExplanation'] = item.Safety_plan_explanation__c ? item.Safety_plan_explanation__c : '';
            contact['c_YouthSystemInvolvement'] = item.Previous_System_Involvement__c ? item.Previous_System_Involvement__c.split(';') : '';
            contact['c_SystemInvolvementBrief'] = item.Brief_Explanation__c ? item.Brief_Explanation__c : '';
            contact['c_CYFCaseNumber'] = item.CYFCaseNumber__c ? item.CYFCaseNumber__c : '';
            contact['c_CYFCaseworker'] = item.CYF_Case_Worker__c ? item.CYF_Case_Worker__c : '';
            contact['c_CYFPhone'] = item.Case_Worker__c ? item.Case_Worker__c : '';
            contact['c_CYFRegional'] = item.RegionalOfficeforCYFServices__c ? item.RegionalOfficeforCYFServices__c : '';
            contact['c_FamilyCaseCourt'] = item.CYF_Active__c.toString();
            contact['clientId'] = item.Id ? item.Id : '';
            contact['caseId'] = item.Case__c ? item.Case__c : '';
           contact['c_NeedsCategory'] = item.Needs_Category__c ? item.Needs_Category__c.split(';') : '';
            tempListOfContact.push(contact);
        });

        this.systemVar1.childNodes = tempListOfContact;

    }









    }



    handleSubmit() {
        this.checkRequiedFields();
        if (!this.systemVar1.isFieldEmpty) {
            console.log('working', this.parentValues);
            this.systemVar1.isLoading = true;
            let parentContact = {
                FirstName: this.parentValues.p_FirstName, LastName: this.parentValues.p_LastName, HomePhone: this.parentValues.p_PhoneNumber, npe01__HomeEmail__c: this.parentValues.p_email, BestTimetoContactGuardian__c: this.parentValues.p_bestTime,
                MailingStreet: this.parentValues.p_Mailingstreet, MailingState: this.parentValues.p_MailingState, MailingCity: this.parentValues.p_MailingCity, MailingPostalCode: this.parentValues.p_MailingPostalCode, OwnerId: this.parentValues.nameOfStaffCompletingIntake
            }
            if (this.systemVar1.contactId != 'nullId') {
                parentContact['Id'] = this.systemVar1.contactId;
            }
            console.log('parentContact: ', JSON.stringify(parentContact));
            upsertParentContact({ parentContactString: JSON.stringify(parentContact) })
                .then(result => {
                    this.systemVar1.contactId = result['Id'];
                    let listOfIntake = this.insertChildRecords(result);
                    console.log('listOfIntake: ',JSON.stringify(listOfIntake));
                    createIntake({ listOfIntakeString: JSON.stringify(listOfIntake) })
                        .then(result => {
                            if (result) {
                                this.showToast('Success!!!!', 'Caring connection Intake record created successfully!', 'success');
                            }
                            this.systemVar1.isLoading = false;
                               this[NavigationMixin.Navigate]({ type: 'standard__webPage', attributes: { url: '/caringintakethankyoupage' }, });
                        })
                        .catch(error => {
                            this.showToast('Error!!!!', JSON.stringify(error), 'error');
                            this.systemVar1.isLoading = false;
                            console.log('error 006', error);
                        })

                })
                .catch(error => { console.log('error 005', error); });

            // parentValues = {
            //     p_signature: '',
            //     p_signDate: new Date().toISOString().slice(0, 10)
            // };

        }
    }


    insertChildRecords(parentData) {

        let commonIntakeField = { OwnerId: this.parentValues.nameOfStaffCompletingIntake, DateOfSignature__c: new Date().toISOString().slice(0, 10), Name_of_Primary_Parent_Guardian__c: parentData['Id'], GuardianPhone__c: this.parentValues.p_PhoneNumber, RecordTypeId: this.systemVar1.caringConectionRecordId, Reason_for_Referral_By_Referrer__c: this.parentValues.p_ReferralReason };
        if (this.parentValues.neighborhoodValue) { commonIntakeField['Neighborhood_CC__c'] = this.parentValues.neighborhoodValue; }
        if (this.parentValues.otherNeighborhood) { commonIntakeField['Other_Neighborhood_CC__c'] = this.parentValues.otherNeighborhood; }
        if (this.parentValues.p_guardianConsentReceived) { commonIntakeField['GuardianConsentReceived__c'] = this.parentValues.p_guardianConsentReceived; }
        if (this.parentValues.p_clientConsentReceived14YOA) { commonIntakeField['ClientConsentReceived14YOA__c'] = this.parentValues.p_clientConsentReceived14YOA; }
        if (parentData['MailingStreet']) { commonIntakeField['Guardian_Street__c'] = parentData['MailingStreet']; }
        if (parentData['MailingCity']) { commonIntakeField['Guardian_City__c'] = parentData['MailingCity']; }
        if (parentData['MailingState']) { commonIntakeField['Guardian_State__c'] = parentData['MailingState']; }
        if (parentData['MailingPostalCode']) { commonIntakeField['Guardian_Zip__c'] = parentData['MailingPostalCode']; }
        if (this.parentValues.p_bestTime) { commonIntakeField['BestTimetoContactGuardian__c'] = this.parentValues.p_bestTime; }
        if (this.parentValues.p_AdditionalComments) { commonIntakeField['AdditionalInformationRegardingConsent__c'] = this.parentValues.p_AdditionalComments; }
        if (parentData['npe01__HomeEmail__c']) { commonIntakeField['Personal_Email__c'] = parentData['npe01__HomeEmail__c']; }
        if (this.parentValues.p_signature) { commonIntakeField['mplc_Signature__c'] = this.parentValues.p_signature; }
        if (this.parentValues.p_relation) { commonIntakeField['Primary_Guardian_Relationship__c'] = this.parentValues.p_relation; }
        if (this.parentValues.p_ReferralFirstName) { commonIntakeField['Referral_Source_First__c'] = this.parentValues.p_ReferralFirstName; }
        if (this.parentValues.p_ReferralLastName) { commonIntakeField['Referral_Source_Last__c'] = this.parentValues.p_ReferralLastName; }
        if (this.parentValues.p_ReferralTitle) { commonIntakeField['Referrer_Title__c'] = this.parentValues.p_ReferralTitle; }
        if (this.parentValues.p_ReferralPhone) { commonIntakeField['ReferralPhone__c'] = this.parentValues.p_ReferralPhone; }
        if (this.parentValues.p_ReferralType) { commonIntakeField['Referral_Source_Type__c'] = this.parentValues.p_ReferralType; }
        if (this.parentValues.p_ReferralTypeOther) { commonIntakeField['Referral_Source_Type_Other__c'] = this.parentValues.p_ReferralTypeOther; }
        if (this.parentValues.p_ReferralReason) { commonIntakeField['Reason_for_Referral_By_Referrer__c'] = this.parentValues.p_ReferralReason; }
        let listOfIntake = [];
        this.systemVar1.childNodes.forEach(childItem => {
            let intake = {};
            intake['Name'] = childItem.c_FirstName + '_' + childItem.c_LastName + '_Caring Connections';
            intake['First_Name__c'] = childItem.c_FirstName;
            intake['Last_Name__c'] = childItem.c_LastName;
            intake['Birthdate__c'] = childItem.c_Birthdate;
            intake['CYF_Active__c'] = JSON.parse(childItem.c_FamilyCaseCourt);
            if (childItem.c_Comment) { intake['Comments__c'] = childItem.c_Comment; }
            if (childItem.c_SafetyPlanExplanation) { intake['Safety_plan_explanation__c'] = childItem.c_SafetyPlanExplanation; }
            if (childItem.c_SystemInvolvementBrief) { intake['Brief_Explanation__c'] = childItem.c_SystemInvolvementBrief; }
            if (childItem.clientId) { intake['Client__c'] = childItem.clientId; }
            if (childItem.caseId) { intake['case__c'] = childItem.caseId; }
            if (childItem.c_Phone) { intake['Mobile_Phone__c'] = childItem.c_Phone; }
            if (childItem.c_PreferredName) { intake['PreferredName__c'] = childItem.c_PreferredName; }
            if (childItem.c_Phone) { intake['Home_Phone__c'] = childItem.c_Phone; }
            if (childItem.c_IdentityExpansion) { intake['Race_Other__c'] = childItem.c_IdentityExpansion; }
            if (childItem.c_RacialEthnicIdentity) { intake['Race__c'] = childItem.c_RacialEthnicIdentity; }
            if (childItem.c_GenderIdentity) { intake['Gender_Identity__c'] = childItem.c_GenderIdentity; }
            if (childItem.c_GenderPronouns) { intake['GenderPronouns__c'] = childItem.c_GenderPronouns; }
            if (childItem.c_PrimaryConcern) { intake['Primary_Reason_for_Referral__c'] = childItem.c_PrimaryConcern; }
            if (childItem.c_secondaryConcern) { intake['Secondary_Reason_for_Referral__c'] = childItem.c_secondaryConcern; }
            if (childItem.c_thirdConcern) { intake['Additional_Reason_for_Referral__c'] = childItem.c_thirdConcern; }
            if (childItem.c_ImmediateSafetyConcerns) { intake['ImmediateSafetyConcerns__c'] = childItem.c_ImmediateSafetyConcerns; }
            if (childItem.c_ClientHasaSafetyPlan) { intake['ClientHasaSafetyPlan__c'] = childItem.c_ClientHasaSafetyPlan; }
            if (childItem.c_NeedsCategory) { intake['Needs_Category__c'] = childItem.c_NeedsCategory.join(';'); }
            if (childItem.c_YouthSystemInvolvement) { intake['Previous_System_Involvement__c'] = childItem.c_YouthSystemInvolvement.join(';'); }
            if (childItem.c_CYFCaseNumber) { intake['CYFCaseNumber__c'] = childItem.c_CYFCaseNumber; }
            if (childItem.c_CYFCaseworker) { intake['CYF_Case_Worker__c'] = childItem.c_CYFCaseworker; }
            if (childItem.c_CYFRegional) { intake['RegionalOfficeforCYFServices__c'] = childItem.c_CYFRegional; }
            if (childItem.c_CYFPhone) { intake['Case_Worker__c'] = childItem.c_CYFPhone; }
            if (childItem.c_Signature) { intake['Youth_Signature__c'] = childItem.c_Signature; }
            listOfIntake.push({ ...intake, ...commonIntakeField });
        });

        console.log('commonIntakeField: ', commonIntakeField);
        console.log('listOfIntake', listOfIntake);
        return listOfIntake;

    }


    checkRequiedFields() {
        this.systemVar1.isFieldEmpty = false;
        if (!this.parentValues.p_FirstName.trim().length > 0) { this.setErrorField('.checkParentFirstName', 'Please Enter the Parent / Guardian First Name') }
        if (!this.parentValues.p_LastName.trim().length > 0) { this.setErrorField('.checkParentLastName', 'Please Enter the Parent / Guardian Last Name') }
        if (!this.parentValues.p_PhoneNumber.trim().length > 0) { this.setErrorField('.checkParentPhoneNo', 'Please Enter the Parent / Guardian Phone Number') }
        if (!this.parentValues.p_signature.trim().length > 0) { this.setErrorField('.checkParentSign', 'Please Enter the Parent / Guardian Signature') }
        if (!this.parentValues.nameOfStaffCompletingIntake.trim().length > 0) { this.setErrorField('.checkStaffError', 'Please Select the Staff.') }
        for (let i = 0; i < this.systemVar1.childNodes.length; i++) {
            this.systemVar1.requiredChild.forEach(item => {
                this.setErrorChildField(i, item, item + ' is required.')
            })
        }

    }

    setErrorField(className, customError) {
        let errorInput = this.template.querySelector(className);
        errorInput.setCustomValidity(customError);
        errorInput.reportValidity();
        this.systemVar1.isFieldEmpty = true;
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
    handleNeighborhood(event) { this.parentValues.neighborhoodValue = event.detail.value; }
    handleOtherNeighborhood(event) { this.parentValues.otherNeighborhood = event.target.value; }
    handleStaffCompletingIntake(event) {
        this.parentValues.nameOfStaffCompletingIntake = event.detail.value;
        if (event.detail.value && event.detail.value.trim().length > 0) { this.setErrorField('.checkStaffError', ''); }
    }

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

    handleParentReferralFirstName(event) { this.parentValues.p_ReferralFirstName = event.target.value; }
    handleParentReferralLastName(event) { this.parentValues.p_ReferralLastName = event.target.value; }
    handleParentReferralTitle(event) { this.parentValues.p_ReferralTitle = event.target.value; }
    handleParentReferralPhone(event) { this.parentValues.p_ReferralPhone = event.target.value; }
    handleParentReferralType(event) { this.parentValues.p_ReferralType = event.detail.value; }
    handleParentReferralTypeExpanded(event) { this.parentValues.p_ReferralTypeExpanded = event.detail.value; }
    handleParentReferralTypeOther(event) { this.parentValues.p_ReferralTypeOther = event.target.value; }
    handleParentReferralReason(event) { this.parentValues.p_ReferralReason = event.target.value; }
    handleParentEmail(event) { this.parentValues.p_email = event.target.value; }
    handleParentMailingstreet(event) { this.parentValues.p_Mailingstreet = event.target.value; }
    handleParentMailingCity(event) { this.parentValues.p_MailingCity = event.target.value; }
    handleParentMailingState(event) { this.parentValues.p_MailingState = event.detail.value; }
    handleParentMailingPostalCode(event) { this.parentValues.p_MailingPostalCode = event.target.value; }
    handleParentBestTime(event) { this.parentValues.p_bestTime = event.target.value; }
    handleGuardianConsentReceived(event) { this.parentValues.p_guardianConsentReceived = event.detail.value; }
    handleClientConsentReceived14YOA(event) { this.parentValues.p_clientConsentReceived14YOA = event.detail.value; }
    handleAdditionalComments(event) { this.parentValues.p_AdditionalComments = event.target.value; }
    handleParentRelation(event) { this.parentValues.p_relation = event.detail.value; }
    handleParentSignature(event) {
        this.parentValues.p_signature = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorField('.checkParentSign', ''); }
    }

    handleChildVisiblity(event) { this.systemVar1.childNodes[event.currentTarget.dataset.index].isChildOpen = !this.systemVar1.childNodes[event.currentTarget.dataset.index].isChildOpen; }

    addChild() {
        let childVal = JSON.parse(JSON.stringify(this.childValue));
        childVal.childIndex = this.systemVar1.childNodes.length + 1;
        this.systemVar1.childNodes.push(childVal);
        this.systemVar1.isDeleteRowButtonVisible = this.systemVar1.childNodes.length > 1;
        this.showToast('The Caring Connection has added a new intake form.', '', 'success')
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
                this.showToast('The record of the child ' + (parseInt(ind) + 1) + ' intake form is deleted from the caring connection form.', '', 'warning')
            }
            this.systemVar1.childNodes = JSON.parse(JSON.stringify(this.systemVar1.childNodes.map((item, index) => { return { ...item, childIndex: index + 1 }; })));
            this.systemVar1.isDeleteRowButtonVisible = this.systemVar1.childNodes.length > 1;

        }

    }

    handleChildFirstName(event) {
        this.systemVar1.childNodes[event.currentTarget.dataset.id].c_FirstName = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorChildField(event.currentTarget.dataset.id, 'First_Name', '') }
    }
    handleChildLastName(event) {
        this.systemVar1.childNodes[event.currentTarget.dataset.id].c_LastName = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorChildField(event.currentTarget.dataset.id, 'Last_Name', '') }
    }
    handleChildBirthdate(event) {
        this.systemVar1.childNodes[event.currentTarget.dataset.id].c_Birthdate = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorChildField(event.currentTarget.dataset.id, 'Birthdate', '') }
    }
    handleChildGenderIdentity(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_GenderIdentity = event.detail.value; }
    handleChildPreferredName(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_PreferredName = event.target.value; }
    handleChildGenderPronouns(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_GenderPronouns = event.detail.value; }
    handleChildRacialEthnicIdentity(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_RacialEthnicIdentity = event.detail.value; }
    handleChildIdentityExpansion(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_IdentityExpansion = event.target.value; }
    handleChildPhone(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_Phone = event.target.value; }
    handleChildPrimaryConcern(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_PrimaryConcern = event.detail.value; }
    handleChildSecondaryConcern(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_secondaryConcern = event.detail.value; }
    handleChildThirdConcern(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_thirdConcern = event.detail.value; }
    handleChildNeedsCategory(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_NeedsCategory = event.detail.value; }
    handleChildImmediateSafetyConcern(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_ImmediateSafetyConcerns = event.detail.value; }
    handleChildComment(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_Comment = event.target.value; }
    handleChildClientHasaSafetyPlan(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_ClientHasaSafetyPlan = event.detail.value; }
    handleChildSafetyPlanExplanation(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_SafetyPlanExplanation = event.target.value; }
    handleChildYouthSystemInvolvement(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_YouthSystemInvolvement = event.detail.value }
    handleChildSystemInvolvementBrief(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_SystemInvolvementBrief = event.target.value; }
    handleChildCYFCaseNumber(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_CYFCaseNumber = event.target.value; }
    handleChildCYFCaseworker(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_CYFCaseworker = event.target.value; }
    handleChildCYFPhone(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_CYFPhone = event.target.value; }
    handleChildCYFRegional(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_CYFRegional = event.target.value; }
    handleChildFamilyCaseCourt(event) { this.systemVar1.childNodes[event.currentTarget.dataset.id].c_FamilyCaseCourt = event.target.value; }
    handleChildSignature(event) {
        this.systemVar1.childNodes[event.currentTarget.dataset.id].c_Signature = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setErrorChildField(event.currentTarget.dataset.id, 'Signature', '') }
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
}