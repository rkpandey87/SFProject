import { LightningElement, track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import LightningConfirm from 'lightning/confirm';
//import { CurrentPageReference } from 'lightning/navigation';
import ggFormLogo from "@salesforce/resourceUrl/ggHeaderLogo";
import getchildRecList from '@salesforce/apex/GGMPLCFormController.returnChildRecList';
//import acctRecList from '@salesforce/apex/GGMPLCFormController.getAllAccounts';
import insertIntakeByMappedChildRec from '@salesforce/apex/GGMPLCFormController.saveIntakeRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent'





export default class GgMPLCForm1 extends NavigationMixin(LightningElement) {
    mplcLogo = ggFormLogo;
    @track isSaveDisabled = true;

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
    currentDate;
    parentFirstName;
    schoolListColumn;
    schoolSelectedColumn;
    parentLastName;
    parentPhoneNumber;

    @track parentGuardianFNm = '[]';

    @track isError = false;
    @track errorMsg = '';
    @track isLoading = false;

    /*  Acc Details    */
    selectedAcctId;
    acctOptions = [];

    /* These are the checkbox Properties */
    checkboxValue1 = false;
    checkboxValue2 = false;

    @track flagPassToController = false;





    @track userInput = '';
    @track signature = '';
    @track testContactChildItemArr = [];
    @track testContactChildItemArrClone = [];
    // @track testParentRecReturnItemArrB=[];

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

        //alert(this.parentFirstName);
    }


    /* checkbox handle change Method */
    handleCheckbox1Change(event) {

        this.checkboxValue2 = false;
        this.isSaveDisabled = !event.target.checked;
        this.checkboxValue1 = event.target.checked;

        console.log('this.checkboxValue1');
        this.flagPassToController = this.checkboxValue1;
    }

    handleCheckbox2Change(event) {
        this.checkboxValue1 = false;
        this.isSaveDisabled = !event.target.checked;
        this.checkboxValue2 = event.target.checked;
        console.log('this.checkboxValue2');
        this.flagPassToController = false;
    }


    @wire(getchildRecList, { parentRecId: "$ggFamilyParentRecId" })
    wiredContactWrappers({ error, data }) {
        if (data) {

            // Data is available, perform validation
            this.contactChildReclstData = data;
            this.testContactChildItemArr = JSON.parse(JSON.stringify(data));
           
            

            this.parentGuardianFNm = this.testContactChildItemArr[0];
            // this.parentGuardianFNm= this.testContactChildItemArr;
            //alert(JSON.stringify(this.parentGuardianFNm));
            console.log('Parent/Guardian ===> ' + JSON.stringify(this.parentGuardianFNm));

            this.currentDate = data.map(wrapperList => wrapperList.currDateOfSignature);
         //   console.log(this.currentDate);

            this.schoolListColumn = data.map(wrapperList => wrapperList.schoolColumn);
           // console.log('School column====> ' + this.schoolListColumn);

            this.schoolSelectedColumn = data.map(wrapperList => wrapperList.schoolSelectedColumn);
            //console.log('school selected column====> ' + this.schoolSelectedColumn);

            this.parentLastName = data.map(wrapperList => wrapperList.parentlName);
        //    console.log(this.parentLastName);
            return;
        } else if (error) {
            // Handle the error
            this.handleError(error.body.message);
        }
    }


        handlelogo(){
                location. replace('https://gwensgirls--partial.sandbox.my.site.com/mainForm/s/');
        }


    addRow() {
        this.showToastMethod('A new Child added', '', 'success');
        this.testContactChildItemArrClone = this.testContactChildItemArr;
        console.log('##this.testContactChildItemArrClone==> ' + this.testContactChildItemArrClone);
        var mainList1 = this.testContactChildItemArrClone[0].schoolColumn;
        console.log('##mainList1==> ' + mainList1);
        var newItem = [{
            // index: this.keyIndex,
            childRecordId: 'newRecFlag',
            firstName: '',
            lastName: '',
            Dob: '',
            parentfName: '',
            parentlName: '',
            gradeColumn: '',
            schoolColumn: mainList1,
            

        }];
        console.log(JSON.stringify(this.testContactChildItemArr));
        this.testContactChildItemArr = this.testContactChildItemArr.concat(newItem);
        console.log(JSON.stringify(this.testContactChildItemArr));
      

    }

    async handleDeleteRow(event) {
        const ind = event.currentTarget.dataset.index;
        if (this.testContactChildItemArr.length > 1) {

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
        }
        else {
            this.showToastMethod('Can not delete this child.', 'MPLC Intake must have at least one child in your application.', 'error');
        }
    }


    handleChange(event) {
        const { value, dataset } = event.target;
        const { index, field } = dataset;
        this.testContactChildItemArr[index][field] = value;
        // console.log(JSON.stringify(this.testContactChildItemArr));
    }

    handleFNameChange(event) {

        //const { value, dataset } = event.target;
        // const { index, field } = dataset;
        // this.parentGuardianFNm[index][field] = value;
        this.parentGuardianFNm.parentfName = event.target.value;
        console.log(this.parentGuardianFNm.parentfName);

    }

    handleLNameChange(event) {
        this.parentGuardianFNm.parentlName = event.target.value;
        console.log(this.parentGuardianFNm.parentlName);

        // Concatenate these change value with the testContactChildItemArr, becaue it is the main list which passes into the method-itemdata parameter
    }


    handlePhnNumberChange(event) {
        this.parentGuardianFNm.parentPhnNumber = event.target.value;
        console.log('Parent Phone On Val Change===> ' + this.parentGuardianFNm.parentPhnNumber);
    }

//    handleEmailChange(event) {
//         this.parentGuardianFNm.parentEmail = event.target.value;
//         console.log('Parent Phone On Val Change===> ' + this.parentGuardianFNm.parentEmail);
//     }

    handleSignChange(event) {
        // this.parentGuardianSign = event.target.value;  
        // console.log(this.parentGuardianSign);
        this.userInput = event.target.value;
        this.signature = `${this.userInput}`;//Signature:
        console.log(this.signature);
        console.log(this.userInput);
    }


    //Fetching User details using Wrapper List:
    /*
    @wire(acctRecList)
    wiredAccList({ error, data }) {
        if (data) {
            // Transform user data into options for the dropdown
            this.acctOptions = data.map(wrapperList => ({
                
                label: this.getLabel(wrapperList),
                value: wrapperList.accId
            }));
        } else if (error) {
            console.error('Error fetching users', error);
        }
    }
    
    getLabel(wrapperList) {
        const name = wrapperList.accName || '';
        console.log('***1==> '+name);
       
        // Check if name are non-empty before creating the label
        if (name.trim() !== '') {
            return `${name}`;
        } else {
            // Provide a default label if both firstName and lastName are empty or null
            return '--Select--';
        }
    }
    
    handleAcctSelection(event) {
        this.selectedAcctId = event.detail.value;
        console.log('***Selected User:==> '+this.selectedAcctId);
        // Handle user selection if needed
    }
    
    */



    handleSubmit() {

        var checkBoxVal = this.flagPassToController;
        console.log('Checked Value Pass In Field==> ' + checkBoxVal);

        var currlist = this.testContactChildItemArr;
        let isErr = false;
        console.log(JSON.stringify(currlist));
        var lstLength = currlist.length;

          for (var i = 0; i < lstLength; i++) {
                    this.testContactChildItemArr[i].parentfName= this.parentGuardianFNm.parentfName;
                    this.testContactChildItemArr[i].parentlName= this.parentGuardianFNm.parentlName;
                    this.testContactChildItemArr[i].parentPhnNumber= this.parentGuardianFNm.parentPhnNumber;
                    this.testContactChildItemArr[i].currDateOfSignature= this.parentGuardianFNm.currDateOfSignature;
          }


        console.log(lstLength);
        for (var i = 0; i < lstLength; i++) {
            console.log('FirstName when Value are null===> ' + this.testContactChildItemArr[i].firstName);
            console.log('Parent Phone Number On Submit===> ' + this.testContactChildItemArr[i].parentPhnNumber);
            console.log('User Input==> ' + this.userInput);
            if (this.testContactChildItemArr[i].firstName === undefined || this.testContactChildItemArr[i].lastName === undefined || this.testContactChildItemArr[i].Dob === undefined || this.testContactChildItemArr[i].parentfName === undefined || this.testContactChildItemArr[i].parentlName === undefined || this.userInput === '' || this.testContactChildItemArr[i].parentPhnNumber === undefined) {
                isErr = true;
                this.isError = isErr;

                console.log(isErr);


            } else {
                this.isError = false;
                console.log(this.isError);
                //const lst= this.testContactChildItemArr;
                //	this.testContactChildItemArr=lst;
            }
            break;
        }

        if (this.isError == true) {
            this.errorMsg = this.showReqFieldMissingToast();
            console.log(this.errorMsg);

        } else {
            this.isLoading = true;
            var recDataLst = JSON.stringify(this.testContactChildItemArr);
            console.log(recDataLst);


            var pConRecId = this.ggFamilyParentRecId;
            console.log('Test Parent1 :' + parentSignatureTest);

            var parentSignatureTest = this.userInput;
            console.log(parentSignatureTest);


            var checkBoxVal = this.flagPassToController;
            console.log('Checked Value Pass In Field Success Mode==> ' + checkBoxVal);

            // var selectedAccVal=this.selectedAcctId;
            // console.log('selectedAccVal==> '+selectedAccVal);
            //,accId: selectedAccVal

            /*
             
            // Implementing checkbox functionality 
            if(this.isOptionASelected=== true){
                    var commActivityChkBox=this.isOptionASelected;  
                    console.log(commActivityChkBox);
            }else{
                    var commActivityChkBox=this.isOptionASelected;  
                    console.log(commActivityChkBox);
            }
           //, commActivityFlag:commActivityChkBox
           //,accId:selectedAccVal
       	
*/

            insertIntakeByMappedChildRec({ itemData: recDataLst, mplcSign: parentSignatureTest, parentId: pConRecId, communityActivities: checkBoxVal })

                .then(result => {
                    this.message = result;
                    this.error = undefined;
                    this.showSuccessToast();
                    this.isLoading = false;
                    console.log(JSON.stringify(result));
                    this[NavigationMixin.Navigate]({
                        type: 'standard__webPage',
                        attributes: {
                            // url: 'https://gwensgirls--partial.sandbox.my.site.com/mainForm/s/mplc-form'
                            url: '/intakeThankyouPage'
                        },

                    });
                })
                .catch(error => {
                    this.isLoading = false;
                    this.errorMsg = error.message;

                    return this.showErrorToast();
                    window.console.log(this.error);
                    //
                });
        }
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
            message: 'Some unexpected error',
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

}