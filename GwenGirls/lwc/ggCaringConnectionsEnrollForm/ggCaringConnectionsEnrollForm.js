import { LightningElement, wire, track, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import LightningConfirm from 'lightning/confirm';
import ggFormLogo from "@salesforce/resourceUrl/ggHeaderLogo";
import getchildRecList from '@salesforce/apex/GGCaringConnectionsFormController.returnChildRecList';
import neighborhoodPicklistValue from '@salesforce/apex/GGCaringConnectionsFormController.getNeighborhoodPicklistVal';

import getAllUsers from '@salesforce/apex/GGCaringConnectionsFormController.getAllUsers';

import insertIntake from '@salesforce/apex/GGCaringConnectionsFormController.saveIntakeRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class GgCaringConnectionsEnrollForm extends NavigationMixin(LightningElement) {

    defaultOptions = ['Food Assistance', 'Utilities'];
    @track selectedConcernExpanded = [];
    @track defaultOptions;

    @track defaultmultiOptions = ['Childcare/Out of School Time', 'Clothing/Household Goods/Furniture', 'Food Assistance', 'Housing/Shelter Assistance', 'Utilities', 'Transportation'];
    @track parentRecord={Id:'',firstName:'',lastName:'',HomePhone:'',mailingStreet:'',mailingCity:'',mailingState:'',mailingPostalCode:'',npe01__HomeEmail__c:'',BestTimetoContactGuardian__c:''};
    /*            Testing For Fetching list Of User         */

    selectedUserId;
    userOptions = [];

    get getFamilyOption() {
        return [
            { label: 'Yes', value: 'true' },
            { label: 'No', value: 'false' },
        ];
    }


    /* These are the checkbox Properties */
    checkboxValue1 = false;
    @track ischecked = false;

    @track isError = false;
    @track errorMsg = '';
    @track isLoading = false ;
    //checkboxValue2 = false;

    mplcLogo = ggFormLogo;
    @track options = [];
    @track picklistVal;
    selectedValue;
    showPickList = false;
    @track otherNeighborhood='';


    /* MultiPicklist Values Variables  */



    receivedPropertyValue;
    ggFamilyParentRecId;
    contactChildReclstData;
    contactParentReclstData;
    fNameValue;
    lNameValue;
    birthdateValue;
    parentGuardianfName;
    parentGuardianlName;
    parentGuardianSign;
    @track currentDate = '';
    @track youthSign = '';
    @track printYouthSign = '';

    /* tested variables  */
    @track genderPronounsTest = '';
    genderPronounsTestPrevious;
    @track selectedIndustry;
    @track testValueGenderPron = 'they/their';
    @track parentGuardianFNm = '[]';
    @track populateExtraChildInput = false;
    @track testContactChildItemArr = [];
    @track testContactChildItemArrClone = '[]';

    @track userInput = '';
    @track childSignature = '';
    @track signature = '';

    @api id;
    @api label;
    @track demoRefAccord = false;


    deomInfomAccordinMethod() {
        this.demoRefAccord = this.demoRefAccord ? false : true;
    }
    constructor() {
        super();
        var url = window.location.href;
        var urlParams = {};
        var params = url.split("?")[1];
        if (params) {
            params = params.split("&");
            for (var i = 0; i < params.length; i++) {
                var pair = params[i].split("=");
                urlParams[pair[0]] = pair[1];
            }
        }
        this.ggFamilyParentRecId = pair[1];

        // console.log('Parent Rec Id==> ' + this.ggFamilyParentRecId);
    }


    




    @wire(getchildRecList, { parentRecId: "$ggFamilyParentRecId" })
    wiredContactWrappers({ error, data }) {
        if (data) {

            // Data is available, perform validation
            this.contactChildReclstData = data;
            this.testContactChildItemArr = JSON.parse(JSON.stringify(data));
           // console.log('testContactChildItemArr104===> ' + JSON.stringify(this.testContactChildItemArr));
            this.testContactChildItemArr.forEach(ele => {
            });
            for (let i = 0; i < this.testContactChildItemArr.length; i++) {
                this.testContactChildItemArr[i]['cyfFamilyCaseString'] = this.testContactChildItemArr[i]['cyfFamilyCase'] ? 'true' : 'false';
                this.testContactChildItemArr[i]['isChildSectionOpen'] = true;
            }

            this.parentGuardianFNm = this.testContactChildItemArr[0];

            
            // this.parentRecord.Id=this.ggFamilyParentRecId;
            // this.parentRecord.firstName=this.testContactChildItemArr[0].Name_of_Primary_Parent_Guardian__r.FirstName;
            // this.parentRecord.lastName=this.testContactChildItemArr[0].Name_of_Primary_Parent_Guardian__r.LastName;
            // this.parentRecord.HomePhone=this.testContactChildItemArr[0].Name_of_Primary_Parent_Guardian__r.HomePhone;
            // this.parentRecord.mailingStreet=this.testContactChildItemArr[0].Name_of_Primary_Parent_Guardian__r.MailingStreet;
            // this.parentRecord.mailingCity=this.testContactChildItemArr[0].Name_of_Primary_Parent_Guardian__r.FirstName;
            // this.parentRecord.mailingState=this.testContactChildItemArr[0].Name_of_Primary_Parent_Guardian__r.FirstName;
            // this.parentRecord.mailingPostalCode=this.testContactChildItemArr[0].Name_of_Primary_Parent_Guardian__r.FirstName;
            // this.parentRecord.npe01__HomeEmail__c=this.testContactChildItemArr[0].Name_of_Primary_Parent_Guardian__r.FirstName;
            // this.parentRecord.BestTimetoContactGuardian__c=this.testContactChildItemArr[0].Name_of_Primary_Parent_Guardian__r.BestTimetoContactGuardian__c;


            // console.log('Parent/Guardian Name===> ' + JSON.stringify(this.parentGuardianFNm));

            this.currentDate = data.map(wrapperList => wrapperList.currDateOfSignature);
            // console.log('this.currentDate----> ' + this.currentDate);

            /*   Youth Signature    */
            this.youthSign = data.map(wrapperList => wrapperList.youthSignature);
            // console.log('this.youthSignature----> ' + this.youthSignature);

            this.printYouthSign = data.map(wrapperList => wrapperList.printYouthSignature);
            // console.log('this.printYouthSign----> ' + this.printYouthSign);


            // Selected value of Picklist field Fetched from Wrapper List
            //  alert('checkbox Value Testing--> '+this.ischecked);


            const uniqueIndustries = [...new Set(data.map(wrapperList => wrapperList.childRecordId))];
            // console.log('uniqueIndustries===> ' + JSON.stringify(uniqueIndustries));

            const checkbox1 = [...new Set(data.map(wrapperList => wrapperList.cyfFamilyCase))];
            // console.log('checkbox1===> ' + JSON.stringify(checkbox1));

            const priConcernMultiPick = [...new Set(data.map(wrapperList => wrapperList.primaryConcrnMultiPickSelectedColumn))];
            // console.log('priConcernMultiPick===> ' + JSON.stringify(priConcernMultiPick));

            this.selectedConcernExpanded = [priConcernMultiPick];

            // console.log('this.selectedConcernExpanded===> ' + this.selectedConcernExpanded);

            //  this.defaultOptions=[JSON.stringify(priConcernMultiPick)];
            // console.log('this.defaultOptions===> '+this.defaultOptions);
            return;
        } else if (error) {
            // Handle the error
            this.handleError(error.body.message);
        }
    }



    @wire(neighborhoodPicklistValue) neighborPickListValues({ data, error }) {
        if (data) {
            this.showPickList = true;
            data.forEach(i => {
                //this.options.push({label:i,value:i});
                this.options.push({ label: i, value: i });
            });
            // console.log(this.options);
        } else if (error) {
            // Handle the error
            this.handleError(error.body.message);
        }
    };


    handleNeighborChange(event) {
        this.picklistVal = event.target.value;
        // console.log(this.picklistVal);
    }


    /*          fetching List Of User            */

    /*
    @wire(getAllUsers)
        wiredUsers({ error, data }) {
            if (data) {
                // Transform user data into options for the dropdown
                this.userOptions = data.map(user => ({
                   
                    label: `${user.FirstName} ${user.LastName}`,
                    //label: `${user.Name}`,
                    value: user.Id
                }));
            } else if (error) {
                console.error('Error fetching users', error);
            }
        }
    */

    //Fetching User details using Wrapper List:

    @wire(getAllUsers)
    wiredUsers({ error, data }) {
        if (data) {
            // Transform user data into options for the dropdown
            this.userOptions = data.map(wrapperList => ({

                label: this.getLabel(wrapperList),
                value: wrapperList.usrId
            }));
        } else if (error) {
            console.error('Error fetching users', error);
        }
    }

      handlelogo(){
                location. replace('https://gwensgirls--partial.sandbox.my.site.com/mainForm/s/');
        }

    getLabel(wrapperList) {
        const firstName = wrapperList.usrFirstNm || '';
        // console.log('***1==> ' + firstName);
        const lastName = wrapperList.usrLastNm || '';
        // console.log('***2==> ' + lastName);
        // Check if both firstName and lastName are non-empty before creating the label
        if (firstName.trim() !== '' || lastName.trim() !== '') {
            return `${firstName} ${lastName}`;
        } else {
            // Provide a default label if both firstName and lastName are empty or null
            return 'No Name';
        }
    }

    handleUserSelection(event) {
        this.selectedUserId = event.detail.value;
        // console.log('***Selected User:==> ' + this.selectedUserId);
        // Handle user selection if needed
    }




    /*     Implemented Logic For Add Row Functionality           */

    addRow() {


     this.showToastMethod('A new Child added','','success');
        this.testContactChildItemArrClone = this.testContactChildItemArr;
        // console.log('##this.testContactChildItemArrClone==> ' + this.testContactChildItemArrClone);



        var mainList = this.testContactChildItemArrClone[0].genIdentityColumn;
        // console.log('##mainList==> ' + mainList);

        var mainList1 = this.testContactChildItemArrClone[0].genPronounColumn;
        // console.log('##mainList==> ' + mainList);

        var mainList2 = this.testContactChildItemArrClone[0].primaryConcernColumn;
        // console.log('##mainList==> ' + mainList);

        var mainList3 = this.testContactChildItemArrClone[0].secondaryConcernColumn;
        // console.log('##mainList==> ' + mainList);

        var mainList4 = this.testContactChildItemArrClone[0].thirdConcernColumn;
        // console.log('##mainList==> ' + mainList);

        var mainList5 = this.testContactChildItemArrClone[0].immSafetyConcernColumn;
        // console.log('##mainList==> ' + mainList);

        var mainList6 = this.testContactChildItemArrClone[0].safetyPlanColumn;
        // console.log('##mainList==> ' + mainList);

        var mainList7 = this.testContactChildItemArrClone[0].relationshipToChildColumn;
        // console.log('##mainList==> ' + mainList);

        var mainList8 = this.testContactChildItemArrClone[0].participateInCC4YouthColumn;
        // console.log('##mainList==> ' + mainList);

        var mainList9 = this.testContactChildItemArrClone[0].youth14Column;
        // console.log('##mainList==> ' + mainList);

        var mainList10 = this.testContactChildItemArrClone[0].primaryConcernMultiPickColumn;
        // console.log('##mainList10==> ' + mainList10);

        var mainList11 = this.testContactChildItemArrClone[0].secondaryConcernMultiPickColumn;
        // console.log('##mainList11==> ' + mainList11);

        var mainList12 = this.testContactChildItemArrClone[0].thirdConcernMultiPickColumn;
        // console.log('##mainList12==> ' + mainList12);

        var mainList13 = this.testContactChildItemArrClone[0].reasonForReferralMultiPickColumn;
        // console.log('##mainList13==> ' + mainList13);

        var mainList14 = this.testContactChildItemArrClone[0].previousSystemInvolveMultiPickColumn;
        // console.log('##mainList14==> ' + mainList14);


        var mainList15 = this.testContactChildItemArrClone[0].racialEthnicIdentityColumn;
        // console.log('##mainList15==> ' + mainList15);

        /* These Var are used to pass hardcoded value-newRecFlag in 'childRecordId' to identify that new row are added. */
        var newItem = [{
            // index: this.keyIndex,
            childRecordId: 'newRecFlag',
            firstName: '',
            lastName: '',
            Dob: '',
            parentfName: '',
            parentlName: '',
            genIdentityColumn: mainList,
            genPronounColumn: mainList1,
            primaryConcernColumn: mainList2,
            secondaryConcernColumn: mainList3,
            thirdConcernColumn: mainList4,
            immSafetyConcernColumn: mainList5,
            safetyPlanColumn: mainList6,
            relationshipToChildColumn: mainList7,
            participateInCC4YouthColumn: mainList8,
            youth14Column: mainList9,
            primaryConcernMultiPickColumn: mainList10,
            cyfFamilyCase: false,
            secondaryConcernMultiPickColumn: mainList11,
            thirdConcernMultiPickColumn: mainList12,
            reasonForReferralMultiPickColumn: mainList13,
            previousSystemInvolveMultiPickColumn: mainList14,
            racialEthnicIdentityColumn: mainList15,
            isChildSectionOpen: true,
            cyfFamilyCaseString: 'false',
            comment: '',
            SafetyPlanExplaination: '',
            briefExplaination: ''

        }];

        //  console.log(JSON.stringify(this.testContactChildItemArr));
        this.testContactChildItemArr = this.testContactChildItemArr.concat(newItem);
        // console.log(JSON.stringify(this.testContactChildItemArr));

    }

    async  handleDeleteRow(event) {


        if (this.testContactChildItemArr.length > 1) {
            const ind = event.currentTarget.dataset.index;
            const result = await LightningConfirm.open({
                message: 'Are you sure you want to delete the child?',
                variant: 'header',
                theme: 'inverse',
                label: 'Delete Child Record',

            });
            if (result) {
                const lst = this.testContactChildItemArr;
                lst.splice(ind, 1);
                this.testContactChildItemArr = lst;
            }

            // const lst = this.testContactChildItemArr;
            // const ind = event.currentTarget.dataset.index;
            // lst.splice(ind, 1);
            // this.testContactChildItemArr = lst;
        }
        else {
            this.showToastMethod('Can not delete this child.', 'Caring Connections Intake must have at least one child in your application.', 'error');
        }
    }

    handleChildVisiblity(event) {
        const ind = event.currentTarget.dataset.index;
        this.testContactChildItemArr[ind].isChildSectionOpen = this.testContactChildItemArr[ind].isChildSectionOpen ? false : true;

    }


    handleChange(event) {
    
        const { value, dataset } = event.target;
        const { index, field } = dataset;
        this.testContactChildItemArr[index][field] = value;
        console.log('test',index,field);


        // this.testContactChildItemArr[index].cyfFamilyCase= this.ischecked;

        //  this.ischecked = event.target.checked;
        //  console.log('Chcekbox value1 ' , this.ischecked);
        //  this.testContactChildItemArr[index].cyfFamilyCase= this.ischecked;
        //   console.log('checkbox Main==> '+this.testContactChildItemArr[index].cyfFamilyCase);

    }

    /*
    handlePriConcernPickValChange(event){
        const { value, dataset } = event.target;
        const { index, field } = dataset;
        this.testContactChildItemArr[index][field] = value;
        this.defaultmultiOptions;
        if(event.target.value== 'Basic Needs'){
         //   this.testContactChildItemArr[index].primaryConcernMultiPickColumn= this.defaultmultiOptions;
         this.defaultmultiOptions;
            console.log('**this.testContactChildItemArr[index].primaryConcernMultiPickColumn'+this.testContactChildItemArr[index].primaryConcernMultiPickColumn);
        }
      //  if( this.testContactChildItemArr[index].primaryConcernSelectedColumn== 'Basic Needs'){
        //    this.testContactChildItemArr[index][field] = value;
    //}
    }
    */



    handleCheckboxChange(event) {

        const { value, dataset } = event.target;
        const { index, field } = dataset;
        // console.log('Chcekbox value1 ',event.target.value,'rex value: ', this.testContactChildItemArr[index].cyfFamilyCase );
        this.testContactChildItemArr[index][field] = value;
        this.ischecked = JSON.parse(event.target.value);
        this.testContactChildItemArr[index].cyfFamilyCaseString = event.target.value;
        this.testContactChildItemArr[index].cyfFamilyCase = JSON.parse(event.target.value);
    }



    /* Handle User Change Value for 'Parent/Guardian' Section   */

    handleFNameChange(event) {
        this.parentGuardianFNm.parentfName = event.target.value;
        // console.log(this.parentGuardianFNm.parentfName);
    }

    handleLNameChange(event) {
        this.parentGuardianFNm.parentlName = event.target.value;
        // console.log(this.parentGuardianFNm.parentlName);
    }


    handlePhnNumberChange(event) {
        this.parentGuardianFNm.parentPhnNumber = event.target.value;
        // console.log('Parent Phone On Val Change===> ' + this.parentGuardianFNm.parentPhnNumber);
    }

    handleEmailChange(event) {
        this.parentGuardianFNm.parentEmail = event.target.value;
        // console.log('Parent Email On Val Change===> ' + this.parentGuardianFNm.parentEmail);
    }

    
    handleRelationshipToChildPickChange(event){
    this.parentGuardianFNm.relationshipToChildSelectedColumn= event.target.value;
    console.log('Parent relationship On Val Change===> '+this.parentGuardianFNm.relationshipToChildSelectedColumn);	
    }
    

    handleMailingStreetChange(event) {
        this.parentGuardianFNm.parentMailingStreet = event.target.value;
        // console.log('Parent mailing street On Val Change===> ' + this.parentGuardianFNm.parentMailingStreet);
    }

    handleMailingCityChange(event) {
        this.parentGuardianFNm.parentMailingCity = event.target.value;
        // console.log('Parent mailing city On Val Change===> ' + this.parentGuardianFNm.parentMailingCity);
    }

    handleMailingStateChange(event) {
        this.parentGuardianFNm.guardianMailingStateSelectedColumn = event.target.value;
        // console.log('Parent mailing state On Val Change===> ' + this.parentGuardianFNm.guardianMailingStateSelectedColumn);
    }

    handleMailingPostalCodeChange(event) {
        this.parentGuardianFNm.parentMailingPostalCode = event.target.value;
        // console.log('Parent postal On Val Change===> ' + this.parentGuardianFNm.parentMailingPostalCode);
    }

    handleBestTimeToContactParentChange(event) {
        this.parentGuardianFNm.bestTimeToContactParent = event.target.value;
        // console.log('Parent best time  Val Change===> ' + this.parentGuardianFNm.bestTimeToContactParent);
    }

    handleParticipateInCC4YouthChange(event) {
        this.parentGuardianFNm.participateInCC4YouthSelectedColumn = event.target.value;
        // console.log('Parent participate in youth Val Change===> ' + this.parentGuardianFNm.participateInCC4YouthSelectedColumn);
    }

    handleYouth14Change(event) {
        this.parentGuardianFNm.youth14SelectedColumn = event.target.value;
        // console.log('Parent youth14 Val Change===> ' + this.parentGuardianFNm.youth14SelectedColumn);
    }

    handleWhyConsentNotReceivedChange(event) {
        this.parentGuardianFNm.whyConsentNotReceived = event.target.value;
        // console.log('Parent consent not rec On Val Change===> ' + this.parentGuardianFNm.whyConsentNotReceived);
    }

    handleAdditionalInfoRegardingChange(event) {
        this.parentGuardianFNm.additionalInfoRegardingConsent = event.target.value;
        // console.log('Parent addInfo On Val Change===> ' + this.parentGuardianFNm.additionalInfoRegardingConsent);
    }



    handleChildSignChange(event) {
        this.printYouthSign = event.target.value;
        this.childSignature = `${this.printYouthSign}`;//Signature:
        // console.log(this.childSignature);
        // console.log(this.childUserInput);
    }


    handleSignChange(event) {
        // this.parentGuardianSign = event.target.value;  
        // console.log(this.parentGuardianSign);
        this.userInput = event.target.value;
        this.signature = `${this.userInput}`;//Signature:
        // console.log(this.signature);
        // console.log(this.userInput);
    }




    handleSubmit() {
        
        let isErr = false;
        var currlist = this.testContactChildItemArr;
        var lstLength = currlist.length;

          for (var i = 0; i < lstLength; i++) {
                    this.testContactChildItemArr[i].parentfName= this.parentGuardianFNm.parentfName;
                    this.testContactChildItemArr[i].parentlName= this.parentGuardianFNm.parentlName;
                    this.testContactChildItemArr[i].parentPhnNumber= this.parentGuardianFNm.parentPhnNumber;
                    this.testContactChildItemArr[i].currDateOfSignature= this.parentGuardianFNm.currDateOfSignature;

                    this.testContactChildItemArr[i].parentEmail= this.parentGuardianFNm.parentEmail;
                    this.testContactChildItemArr[i].parentMailingStreet= this.parentGuardianFNm.parentMailingStreet;
                    this.testContactChildItemArr[i].parentMailingCity= this.parentGuardianFNm.parentMailingCity;
                    this.testContactChildItemArr[i].guardianMailingStateSelectedColumn= this.parentGuardianFNm.guardianMailingStateSelectedColumn;
                    this.testContactChildItemArr[i].parentMailingPostalCode= this.parentGuardianFNm.parentMailingPostalCode;
                    this.testContactChildItemArr[i].bestTimeToContactParent= this.parentGuardianFNm.bestTimeToContactParent;

          }


        console.log('lstLength',lstLength);
        for (var i = 0; i < lstLength; i++) {
            // console.log('FirstName when Value are null===> ' + this.testContactChildItemArr[i].firstName);
            // console.log('Parent Phone Number On Submit===> ' + this.testContactChildItemArr[i].parentPhnNumber);
            //  console.log('this.testContactChildItemArr[i].firstName==> ' + this.testContactChildItemArr[i].firstName);
            //  console.log('this.testContactChildItemArr[i].lastName==> ' + this.testContactChildItemArr[i].lastName);
            //  console.log('this.testContactChildItemArr[i].Dob==> ' + this.testContactChildItemArr[i].Dob);
            //  console.log('this.testContactChildItemArr[i].parentfName==> ' + this.testContactChildItemArr[i].parentfName);
            //  console.log('User Input==> ' + this.userInput);
            //  console.log('this.testContactChildItemArr[i].parentlName==> ' + this.testContactChildItemArr[i].parentlName);
            //  console.log('this.testContactChildItemArr[i].parentPhnNumber==> ' + this.testContactChildItemArr[i].parentPhnNumber);

            if (this.testContactChildItemArr[i].firstName === undefined || this.testContactChildItemArr[i].lastName === undefined || this.testContactChildItemArr[i].Dob === undefined || this.testContactChildItemArr[i].parentfName === undefined || this.testContactChildItemArr[i].parentlName === undefined || this.userInput === '' || this.testContactChildItemArr[i].parentPhnNumber === undefined) {
                isErr = true;
                this.isError = isErr;

                // console.log(isErr);


            } else {
                this.isError = false;
                console.log(this.isError);
                //const lst= this.testContactChildItemArr;this.testContactChildItemArr[i].parentlName
                //	this.testContactChildItemArr=lst;
            }
            break;
        }



        if (this.isError == true) {
            this.errorMsg = this.showReqFieldMissingToast();
            console.log(this.errorMsg);

        }


        else {


            this.isLoading = true;
            var pConRecId = this.ggFamilyParentRecId;
            // console.log('Test Parent1 :' + parentSignatureTest);

            var parentSignatureTest = this.userInput;
            // console.log(parentSignatureTest);

            var recDataLst = JSON.stringify(this.testContactChildItemArr);
           //  console.log(recDataLst);

            var neighborPicklist = this.picklistVal;
            // console.log('neighborPicklist===> ' + neighborPicklist);

            var ownerId = this.selectedUserId;
            // console.log('ownerId===> ' + ownerId);

            var currlistNew = this.testContactChildItemArr;
            // console.log(JSON.stringify(currlistNew));
            var lstLengthNew = currlistNew.length;

            for (var i = 0; i < lstLengthNew; i++) {
                // console.log('FirstName when Value are null===> ' + this.testContactChildItemArr[i].firstName);
                // console.log('Parent Phone Number On Submit===> ' + this.testContactChildItemArr[i].cyfFamilyCase);

                if (this.testContactChildItemArr[i].cyfFamilyCase === undefined || this.testContactChildItemArr[i].cyfFamilyCase === '') {
                    this.testContactChildItemArr[i].cyfFamilyCase = false;

                    // console.log('case flag test===> ' + this.testContactChildItemArr[i].cyfFamilyCase);
                }
            }

            console.log('recDataLst: ',recDataLst);
            insertIntake({ itemData: recDataLst, mplcSign: parentSignatureTest, parentId: pConRecId, neighborhoodPickVal: neighborPicklist, usrId: ownerId, otherNeighborhood: this.otherNeighborhood })
                .then(result => {
                    this.message = result;
                    this.error = undefined;
                    this.showSuccessToast();
                    this.isLoading = false;
                    this[NavigationMixin.Navigate]({
                        type: 'standard__webPage',
                        attributes: {
                            // url: 'https://gwensgirls--partial.sandbox.my.site.com/mainForm/s/mplc-form'
                            url: '/caringintakethankyoupage'
                        },

                    });
                })
                .catch(error => {
                    this.isLoading = false;
                    this.errorMsg = error.message;
                    console.log('Error Msg: ' + this.errorMsg);

                    // alert(this.errorMsg);
                    return this.showErrorToast();

                    window.console.log(this.error);
                    //
                });
        }
    }


    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'Toast Success',
            message: 'Intake record created successfully!',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
    showErrorToast() {
        const evt = new ShowToastEvent({
            title: 'Toast Error',
            message: 'Bad value for restricted picklist field',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }



    showReqFieldMissingToast() {
        const evt = new ShowToastEvent({
            title: 'Toast Error',
            message: 'Please Fill all the required blank fields!',
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }


    showToastMethod(title, messege, vari) {
        const evt = new ShowToastEvent({
            title: title,
            message: messege,
            variant: vari,
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }

    handleComment(event) {
        this.testContactChildItemArr[event.currentTarget.dataset.index].comment = event.target.value;
    }

    handleSafteyPlanExplaination(event) {
        this.testContactChildItemArr[event.currentTarget.dataset.index].SafetyPlanExplaination = event.target.value;
    }

    handleBriefExplaination(event) {
        this.testContactChildItemArr[event.currentTarget.dataset.index].briefExplaination = event.target.value;

    }

    handleOtherNeighborhood(event){
            this.otherNeighborhood=event.target.value;
    }
}