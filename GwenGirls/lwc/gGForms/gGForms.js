import { LightningElement, track, wire } from 'lwc';
import ggFormLogo from "@salesforce/resourceUrl/ggHeaderLogo";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CurrentPageReference } from 'lightning/navigation';
import { NavigationMixin } from 'lightning/navigation';
import LightningConfirm from 'lightning/confirm';
import getSchoolPicklist from '@salesforce/apex/GGFormController.getSchoolPicklist';
import upsertParentContact from '@salesforce/apex/GGFormController.upsertParentContact';
import getExistingRecords from '@salesforce/apex/GGFormController.getExistingRecords';
import createIntake from '@salesforce/apex/GGFormController.createIntake';
import getSiteUsers from '@salesforce/apex/GGFormController.getSiteUsers';
import { getObjectInfo } from "lightning/uiObjectInfoApi";
import Intake_OBJECT from "@salesforce/schema/Intake__c";



export default class GGForms extends NavigationMixin(LightningElement) {

    @track formLogo = ggFormLogo;
    @track systemVar1 = {
        mainHeading: '', subParagraph: '', isUserdforMPLC: false, isUsedForCarring: false, isUsedForYouth: false, isFieldEmpty: false, contactId: '', schoolOptions: [], isDeleteRowVisible: false,
        parentInputData: { id: '', firstName: '', lastName: '', phoneNo: '', email: '', signature: '', dateOfSign: '', pleaseContactCheckBox: false, siteValue: '' },
        childInputDataId: ['FirstName', 'LastName', 'BirthDate', 'Grade', 'School'], isLoading: false, mplcRecordId: '',
        sitOptions: []
    }
    @track mplc_ChildFields = [];
    @track visibleFields = {
        mplc_plsContactCheckBox: false, mplc_manageYouthHeadig: undefined, mplc_manageSubHeading: undefined
    };

    @wire(getObjectInfo, { objectApiName: Intake_OBJECT })
    wireAccountData(objectInfo, error) {
        if (objectInfo) {
            let recordTypeInfo = objectInfo?.data?.recordTypeInfos;
            if (recordTypeInfo) { this.systemVar1.mplcRecordId = Object.keys(recordTypeInfo).find(rtype => (recordTypeInfo[rtype].name === 'MPLC')); 
            console.log('this.systemVar1.mplcRecordId: ',this.systemVar1.mplcRecordId)}
        }
        else if (error) { console.log('error 010', error); }
    }

    @wire(getSiteUsers)
    siteUsers({ error, data }) {
        if (data) {
            this.systemVar1.sitOptions = data;
            console.log('site data ', data);
        }
        else if (error) {
            console.log('error 013', error);
        }
    }



    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            if (currentPageReference.state?.type == 'MPLC') {
                if (currentPageReference.state?.ContactId) { this.systemVar1.contactId = currentPageReference.state?.ContactId; }
                this.mplcSetup();
                if (this.systemVar1.contactId != 'nullId') {
                    this.getExisingRecords();
                }
            }
            if (currentPageReference.state?.type == 'CarringConnection') { }
            if (currentPageReference.state?.type == 'YouthIntake') { }
        }
    }

    @wire(getSchoolPicklist)
    getAccountPiclist({ error, data }) {
        if (data) {
            let tempVar1 = [];
            data.forEach(currentItem => { tempVar1.push({ label: currentItem.Name, value: currentItem.Id }); });
            this.systemVar1.schoolOptions = tempVar1;
        }
        else if (error) {
            console.log('error 003', error);
            this.showToast('Error!!!!', JSON.stringify(error), 'error');
        }
    }



    mplcSetup() {
        this.systemVar1.isUserdforMPLC = true;
        this.systemVar1.mainHeading = 'MPLC Intake';
        this.systemVar1.subParagraph = '<p>Dear Parent(s)/Guardian(s):<br/><br/> Gwen\'s Girls is thrilled to bring ' +
            'our Making Positive Life Choices Program (MPLC) to your school district this academic year and we\'re especially delighted to welcome your ' +
            'daughter to our community. Thanks to the funding provided from Allegheny County Children Youth and Families, we are able to offer this program at ' +
            'no cost.<br/><br/> As part of our agreement with the county, we are required to submit funding documentation via the county\'s (KIDS) database system. ' +
            'To start the enrollment process, we kindly ask you to fill out the information below. Please be assured that your information will be kept confidential' +
            'and used exclusively for securing MPLC program funding for this academic year.<br/><br/> The MPLC program focuses on empowering girls through various topics' +
            'such as Life Skills, Building Self-Esteem, Identifying Healthy vs. Unhealthy Relationships, Addressing Bullying, Conflict Resolution & Communication Skills, ' +
            'and Health & Hygiene, including body changes.<br/><br/>If you require further information about the MPLC program at your school or have any questions or ' +
            'concerns, do not hesitate to contact Tamera Stafford directly at (412) 608-2309.<br/><br/>We are eager to contribute to a year of growth and positive change' +
            'for your daughter!<br/><br/> Warm regards,<br/> <br/>Tamera Stafford <br/>Program Director</p>';
        this.visibleFields.mplc_plsContactCheckBox = true;
        this.visibleFields.mplc_manageYouthHeadig = 'Manage Youth Participants you want to include';
        this.visibleFieldsmplc_manageSubHeading = 'Please add or remove youth that will be participating in this program';
        this.systemVar1.parentInputData.dateOfSign = new Date().toISOString().slice(0, 10);
        if (this.systemVar1.contactId == 'nullId') {
            this.mplc_ChildFields = [{ id: '', ch_FirstName: '', ch_LastName: '', ch_birtDate: '', ch_grade: '', ch_school: '', ch_index: 1 }];
            setTimeout(() => {
                this.template.querySelector('.setSchoolOption').options = this.systemVar1.schoolOptions;
                console.log('school', this.systemVar1.schoolOptions);
            }, 1000)
        }
    }

    carringConnectionSetup() { }

    youthIntake() { }


    getExisingRecords() {
        getExistingRecords({ contactId: this.systemVar1.contactId })
            .then(data => {
                this.systemVar1.parentInputData.firstName = data.parentContact.FirstName;
                this.systemVar1.parentInputData.lastName = data.parentContact.LastName;
                this.systemVar1.parentInputData.phoneNo = data.parentContact.HomePhone;
                this.systemVar1.parentInputData.email = data.parentContact.Email;
                //  this.systemVar1.parentInputData.siteValue = data.parentContact.OwnerId;
                this.systemVar1.parentInputData.id = data.parentContact.Id;
                //this.systemVar1.parentInputData.pleaseContactCheckBox = true;
                let tempChildContactList = [];
                data.childContact.forEach((item, index) => {
                    let tempChild = {};
                    tempChild['ch_index'] = index + 1;
                    tempChild['ch_FirstName'] = item.FirstName;
                    tempChild['ch_LastName'] = item.LastName;
                    tempChild['ch_birtDate'] = item.Birthdate;
                    tempChild['ch_grade'] = item.Grade__c;
                    tempChild['ch_school'] = item.School__c;
                    tempChild['clientId'] = item.Id;
                    tempChild['caseId'] = item.Case__c;
                    tempChildContactList.push(tempChild);
                });
                this.mplc_ChildFields = tempChildContactList;
                this.systemVar1.isDeleteRowVisible = this.mplc_ChildFields.length > 1;
            })
            .catch(error => {
                console.log('error 003', error);
                this.showToast('Error!!!!', JSON.stringify(error), 'error');
            });
    }


    /* Parent input Section Start*/
    handlePleaseContactMethod(event) {
        this.systemVar1.parentInputData.pleaseContactCheckBox = event.target.checked;
        if (event.target.checked) { this.setNonErrorField('.checkPleaseContact'); }
    }
    handleParentFirstName(event) {
        this.systemVar1.parentInputData.firstName = event.target.value.trim();
        if (event.target.value && event.target.value.trim().length > 0) { this.setNonErrorField('.checkInputFN'); }
    }
    handleParentLastName(event) {
        this.systemVar1.parentInputData.lastName = event.target.value.trim();
        if (event.target.value && event.target.value.trim().length > 0) { this.setNonErrorField('.checkInputLN'); }
    }
    handleParentEmail(event) { this.systemVar1.parentInputData.email = event.target.value.trim(); }
    handleParentPhoneNo(event) {
        this.systemVar1.parentInputData.phoneNo = event.target.value.trim();
        if (event.target.value && event.target.value.trim().length > 0) { this.setNonErrorField('.checkPhone'); }
    }
    handleParentSign(event) {
        this.systemVar1.parentInputData.signature = event.target.value.trim();
        if (event.target.value && event.target.value.trim().length > 0) { this.setNonErrorField('.checkSign'); }
    }
    handleSite(event) {
        this.systemVar1.parentInputData.siteValue = event.detail.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setNonErrorField('.setSiteOptions'); }

    }
    /* Parent input Section End */


    /* Child Input Section Start */

    handleChildFirstName(event) {
        this.mplc_ChildFields[event.currentTarget.dataset.id].ch_FirstName = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setNonErrorChildField(event.currentTarget.dataset.id, event.currentTarget.dataset.name); }
    }

    handleChildLastName(event) {
        this.mplc_ChildFields[event.currentTarget.dataset.id].ch_LastName = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setNonErrorChildField(event.currentTarget.dataset.id, event.currentTarget.dataset.name); }
    }

    handleChildBirthdate(event) {
        this.mplc_ChildFields[event.currentTarget.dataset.id].ch_birtDate = event.target.value;
        if (event.target.value) { this.setNonErrorChildField(event.currentTarget.dataset.id, event.currentTarget.dataset.name); }
    }
    handleChildGrade(event) {
        this.mplc_ChildFields[event.currentTarget.dataset.id].ch_grade = event.target.value;
        if (event.target.value && event.target.value.trim().length > 0) { this.setNonErrorChildField(event.currentTarget.dataset.id, event.currentTarget.dataset.name); }

    }
    handleChildSchool(event) {
        this.mplc_ChildFields[event.currentTarget.dataset.id].ch_school = event.detail.value;
        if (event.detail.value && event.detail.value.trim().length > 0) { this.setNonErrorChildField(event.currentTarget.dataset.id, event.currentTarget.dataset.name); }
    }


    /* Child Input Section End */



    handleSubmit() {
        if (this.systemVar1.isUserdforMPLC) {
            this.mplc_checkRequiedFields();
            if (!this.systemVar1.isFieldEmpty) {
                this.upsertParentAndIntake();
            }
        }
    }

    upsertParentAndIntake() {
        this.systemVar1.isLoading = true;
        let contact = { FirstName: this.systemVar1.parentInputData.firstName, LastName: this.systemVar1.parentInputData.lastName, HomePhone: this.systemVar1.parentInputData.phoneNo, Email: this.systemVar1.parentInputData.email, OwnerId: this.systemVar1.parentInputData.siteValue };
        if (this.systemVar1.contactId != 'nullId') { contact['Id'] = this.systemVar1.contactId; }
        console.log('parent', JSON.stringify(contact));
        upsertParentContact({ parentContactString: JSON.stringify(contact) })
            .then(data => {
                 console.log('data: ', data);
                let listOfIntake = [];
                this.mplc_ChildFields.forEach(item => {
                    let intake = { Name_of_Primary_Parent_Guardian__c: data.Id, OwnerId: this.systemVar1.parentInputData.siteValue, Community_Activities__c: true, mplc_Signature__c: this.systemVar1.parentInputData.signature, RecordTypeId: this.systemVar1.mplcRecordId };
                    intake['Name'] = item.ch_FirstName + '_' + item.ch_LastName + '_MPLC';
                    intake['First_Name__c'] = item.ch_FirstName;
                    intake['Last_Name__c'] = item.ch_LastName;
                    intake['Home_Phone__c'] = this.systemVar1.parentInputData.phoneNo;
                    intake['Birthdate__c'] = item.ch_birtDate;
                    intake['DateOfSignature__c'] = new Date().toISOString().slice(0, 10);
                    intake['Grade__c'] = item.ch_grade;
                    intake['School__c'] = item.ch_school;
                    if (item.clientId) { intake['Client__c'] = item.clientId; }
                    if (item.caseId) { intake['case__c'] = item.caseId; }
                    listOfIntake.push(intake)
                });
                createIntake({ listOfIntakeString: JSON.stringify(listOfIntake) })
                    .then(result => {
                        this.showToast('Success!!!!', 'MPLC Intake record created successfully!', 'success');
                        this.systemVar1.isLoading = false;
                        this[NavigationMixin.Navigate]({ type: 'standard__webPage', attributes: { url: '/intakethankyoupage' }, });
                    })
                    .catch(error => {
                        this.showToast('Error!!!!', JSON.stringify(error), 'error');
                        this.systemVar1.isLoading = false;
                        console.log('error 006', error);
                    })


            })
            .catch(error => {
                console.log('error 002', error);
                this.systemVar1.isLoading = false;
                console.log('message',this.exectError(error));
                this.showToast(this.exectError(error), '', 'error');

            })




    }

    mplc_checkRequiedFields() {
        this.systemVar1.isFieldEmpty = false;
        if (!this.systemVar1.parentInputData.firstName.trim().length > 0) { this.setErrorField('.checkInputFN', 'Please Enter the Parent / Guardian First Name') }
        if (!this.systemVar1.parentInputData.lastName.trim().length > 0) { this.setErrorField('.checkInputLN', 'Please Enter the Parent / Guardian Last Name') }
        if (!this.systemVar1.parentInputData.phoneNo.trim().length > 0) { this.setErrorField('.checkPhone', 'Please Enter the Parent / Guardian Phone Number') }
        if (!this.systemVar1.parentInputData.signature.trim().length > 0) { this.setErrorField('.checkSign', 'Please Enter the Parent / Guardian Signature') }
        if (!this.systemVar1.parentInputData.pleaseContactCheckBox) { this.setErrorField('.checkPleaseContact', 'Please checked the required fields.') }
        if (!this.systemVar1.parentInputData.siteValue || !this.systemVar1.parentInputData.siteValue.length > 0) { this.setErrorField('.setSiteOptions', 'Please Select the Site.') }
        this.mplc_checkRequiredmplc_ChildFields();
    }

    addChild() {
        this.mplc_ChildFields.push({ ch_FirstName: '', ch_LastName: '', ch_birtDate: '', ch_grade: '', ch_schoool: '', ch_index: this.mplc_ChildFields.length + 1 });
        setTimeout(() => {
            this.template.querySelectorAll('.setSchoolOption')[this.mplc_ChildFields.length - 1].options = this.systemVar1.schoolOptions;
        }, 100)
        this.systemVar1.isDeleteRowVisible = this.mplc_ChildFields.length > 1;
    }

    mplc_checkRequiredmplc_ChildFields() {
        for (let i = 0; i < this.mplc_ChildFields.length; i++) {
            this.systemVar1.childInputDataId.forEach(item => { this.setErrorChildField(i, item); });
        }
    }

    async handleChildDeletedRow(event) {

        const ind = event.currentTarget.dataset.index;
        if (this.mplc_ChildFields.length > 1) {
            const result = await LightningConfirm.open({
                message: 'Are you sure you want to delete the child?',
                variant: 'header',
                theme: 'inverse',
                label: 'Delete Child Record',
            });
            console.log('result: ', result);
            if (result) {
                this.systemVar1.isDeleteRowVisible = true;

                var tempVar = JSON.parse(JSON.stringify(this.mplc_ChildFields));
                tempVar.splice(ind, 1);
                this.mplc_ChildFields = JSON.parse(JSON.stringify(tempVar));
            }
            this.systemVar1.isDeleteRowVisible = this.mplc_ChildFields.length > 1;
            this.mplc_ChildFields = JSON.parse(JSON.stringify(this.mplc_ChildFields.map((item, index) => { return { ...item, ch_index: index + 1 }; })));

        }

    }


    setNonErrorChildField(id, name) {
        let errorInput = this.template.querySelector('[data-id="' + id + '"][data-name="' + name + '"]');
        errorInput.setCustomValidity('');
        errorInput.reportValidity();
    }
    setErrorChildField(id, name) {
        let errorInput = this.template.querySelector('[data-id="' + id + '"][data-name="' + name + '"]');
        // console.log(name,'---',errorInput.value.trim(),errorInput.value.trim().length);
        if (!errorInput.value || !errorInput.value.trim().length > 0) {
            errorInput.setCustomValidity(name + ' is required.');
            errorInput.reportValidity();
            this.systemVar1.isFieldEmpty = true;
        }

    }
    setNonErrorField(className) {
        let errorInput = this.template.querySelector(className);
        errorInput.setCustomValidity('');
        errorInput.reportValidity();
    }
    setErrorField(className, customError) {
        let errorInput = this.template.querySelector(className);
        errorInput.setCustomValidity(customError);
        errorInput.reportValidity();
        this.systemVar1.isFieldEmpty = true;
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


    exectError(error){
        let message = 'Unknown error';
        if (error.body && error.body.fieldErrors) {
            const fieldErrors = error.body.fieldErrors;
            message = Object.keys(fieldErrors).map(field => {
                return fieldErrors[field].map(err => `${field}: ${err.message}`).join(', ');
            }).join(', ');
        }
        if (message === 'Unknown error' && error.body && error.body.pageErrors.length > 0) {
            message = error.body.pageErrors.map(err => err.message).join(', ');
        }
        if (message === 'Unknown error' && error.body && typeof error.body.message === 'string') {
            message = error.body.message;
        } else if (message === 'Unknown error' && typeof error.message === 'string') {
            message = error.message;
        }
        return message;
    }
}