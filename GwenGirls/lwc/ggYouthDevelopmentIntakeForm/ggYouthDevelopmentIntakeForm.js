import { LightningElement,track,wire } from 'lwc';
import ggFormLogo from "@salesforce/resourceUrl/ggHeaderLogo";
import { NavigationMixin } from 'lightning/navigation';
import getchildRecList from '@salesforce/apex/GGYouthDevelopmentIntakeFormController.returnChildRecList';
import insertIntake from '@salesforce/apex/GGYouthDevelopmentIntakeFormController.saveIntakeRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import hearAboutUsPicklistValue from '@salesforce/apex/GGYouthDevelopmentIntakeFormController.getNeighborhoodPicklistVal';
export default class GgYouthDevelopmentIntakeForm extends  NavigationMixin(LightningElement) {
mplcLogo = ggFormLogo;

/*
@track options = [];
      @track picklistVal;
      selectedValue;
      showPickList = false;
*/

      @track enrollInSpecialEducation = false;
      @track youthWorks = false;
      @track recievePublicAssistance = false;

      @track HighlightedLineAfterEachChild= false;

      @track ischecked = false;
      @track isError = false;
	  @track errorMsg= '';
      @track isLoading = false;


ggFamilyParentRecId;
contactChildReclstData;
contactParentReclstData;
currentDate;
@track parentGuardianFNm = [];
@track testContactChildItemArr=[];
@track testContactChildItemArrClone=[];


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
    this.ggFamilyParentRecId= pair[1];
    console.log('Parent/Guardian Name===> '+JSON.stringify(this.ggFamilyParentRecId));
    this.HighlightedLineAfterEachChild=true;
}



 @wire(getchildRecList,{parentRecId: "$ggFamilyParentRecId"})
   wiredContactWrappers({ error, data }) {
       if (data) {
         
           // Data is available, perform validation
           this.contactChildReclstData = data;
           this.testContactChildItemArr = JSON.parse(JSON.stringify(data));

           this.parentGuardianFNm= this.testContactChildItemArr[0];
					
          console.log('Parent/Guardian Name===> '+JSON.stringify(this.parentGuardianFNm));
   
           this.currentDate = data.map(wrapperList => wrapperList.currDateOfSignature);
           console.log(this.currentDate);
         
           return;
       } else if (error) {
           // Handle the error
          // this.handleError(error.body.message);
       }
   }




  addRow() {
      /* These flag are used to show highlighted line after add each new child */
        this.HighlightedLineAfterEachChild=true;

        this.testContactChildItemArrClone= this.testContactChildItemArr;
        console.log('##this.testContactChildItemArrClone==> '+this.testContactChildItemArrClone);

        var mainList= this.testContactChildItemArrClone[0].genIdentityColumn;
        console.log('##mainList==> '+mainList);
    
        var mainList1= this.testContactChildItemArrClone[0].schoolColumn;
        console.log('##mainList1==> '+mainList1);
    
        var mainList2= this.testContactChildItemArrClone[0].gradeColumn;
        console.log('##mainList2==> '+mainList2);
    
        var mainList3= this.testContactChildItemArrClone[0].areaOfInterestMultiPickColumn;
        console.log('##mainList3==> '+mainList3);

        var mainList4= this.testContactChildItemArrClone[0].housingColumn;
        console.log('##mainList4==> '+mainList4);

        var mainList5= this.testContactChildItemArrClone[0].approvedPickupRelationshipColumn;
        console.log('##mainList5==> '+mainList5);

        var mainList6= this.testContactChildItemArrClone[0].approvedPickupRelationshipColumn2;
        console.log('##mainList6==> '+mainList6);

        var mainList7= this.testContactChildItemArrClone[0].hadIllnessMultiPickColumn;
        console.log('##mainList7==> '+mainList7);

        var mainList8= this.testContactChildItemArrClone[0].mentalHealthHistoryColumn;
        console.log('##mainList8==> '+mainList8);

        var mainList9= this.testContactChildItemArrClone[0].allergiesMultiPickColumn;
        console.log('##mainList9==> '+mainList9);

        var mainList10= this.testContactChildItemArrClone[0].childAttendAfterSchoolMultiPickColumn;
        console.log('##mainList10==> '+mainList10);
        
        var newItem = [{ 
           // index: this.keyIndex,
            childRecordId: 'newRecFlag',      
            firstName: '',
            lastName:  '',
            Dob:  '',
            ssn: '',
            race: '',
            weight: '',
            htfeet: '',
            htInches: '',
            IdentifyMarks: '',
            hairColor: '',
            eyeColor: '',
            placeOfEmployment: '',
			genIdentityColumn: mainList,
            schoolColumn: mainList1, 
            gradeColumn:mainList2,
            areaOfInterestMultiPickColumn:mainList3,
            housingColumn: mainList4,
            approvedPickupRelationshipColumn:mainList5,
            approvedPickupRelationshipColumn2:mainList6,
            hadIllnessMultiPickColumn:mainList7,
            mentalHealthHistoryColumn:mainList8,
            allergiesMultiPickColumn:mainList9,
            childAttendAfterSchoolMultiPickColumn:mainList10

        }];
				console.log(JSON.stringify(this.testContactChildItemArr));
        this.testContactChildItemArr = this.testContactChildItemArr.concat(newItem);
				console.log(JSON.stringify(this.testContactChildItemArr));
		
    }


  handleDeleteRow(event) {
      
      const lst= this.testContactChildItemArr;
	
				const ind=event.currentTarget.dataset.index;
				console.log(ind);
				console.log(JSON.stringify(this.testContactChildItemArr[ind]));
        lst.splice(ind, 1);
				console.log(lst);
				this.testContactChildItemArr= lst;
				console.log(JSON.stringify(this.testContactChildItemArr));
    } 

handleChange(event) {
    const { value, dataset } = event.target;
    const { index, field } = dataset;
    this.testContactChildItemArr[index][field] = value;
   // console.log(JSON.stringify(this.testContactChildItemArr));
}


handleCheckboxInSchoolChange(event){
    const { value, dataset } = event.target;
    const { index, field } = dataset;
    this.testContactChildItemArr[index][field] = value;

	this.ischecked = event.target.checked;
    console.log('Chcekbox value1 ' , this.ischecked);
    this.testContactChildItemArr[index].currentlyEnrollInSchool= this.ischecked;
    console.log('checkbox Main==> '+this.testContactChildItemArr[index].currentlyEnrollInSchool);

  
		
}


handleCheckboxIEPChange(event){
    const { value, dataset } = event.target;
    const { index, field } = dataset;
    this.testContactChildItemArr[index][field] = value;

    this.testContactChildItemArr[index].Iep= this.ischecked;
    console.log('checkbox Main==> '+this.testContactChildItemArr[index].Iep);  
}

/* Handle User Change Value for 'Parent/Guardian' Section   */
		
    handleFNameChange(event){
    this.parentGuardianFNm.primaryParentfName= event.target.value;
    console.log(this.parentGuardianFNm.primaryParentfName);
    }
    
    handleLNameChange(event){
    this.parentGuardianFNm.primaryParentlName= event.target.value;
    console.log(this.parentGuardianFNm.primaryParentlName);
    }
        
        
    handlePrimaryParentrelationshipChange(event){
        this.parentGuardianFNm.primaryParentRelationshipSelectedColumn= event.target.value;
        console.log(this.parentGuardianFNm.primaryParentRelationshipSelectedColumn);
    }
        handlePhnNumberChange(event){
                this.parentGuardianFNm.primaryParentPhnNumber= event.target.value;
    console.log('Parent Phone On Val Change===> '+this.parentGuardianFNm.primaryParentPhnNumber);	
        }
    /*
        handleEmailChange(event){
            this.parentGuardianFNm.primaryParentMailingStreet= event.target.value;
    console.log('Parent Email On Val Change===> '+this.parentGuardianFNm.primaryParentMailingStreet);	
        }
    */
        /*
        handleRelationshipToChildPickChange(event){
        this.parentGuardianFNm.relationshipToChildSelectedColumn= event.target.value;
        console.log('Parent relationship On Val Change===> '+this.parentGuardianFNm.relationshipToChildSelectedColumn);	
        }
        */
    
        handleMailingStreetChange(event){
        this.parentGuardianFNm.primaryParentMailingStreet= event.target.value;
        console.log('Parent mailing street On Val Change===> '+this.parentGuardianFNm.primaryParentMailingStreet);
        }
    
        handleMailingCityChange(event){
        this.parentGuardianFNm.primaryParentMailingCity= event.target.value;
        console.log('Parent mailing city On Val Change===> '+this.parentGuardianFNm.primaryParentMailingCity);
        }
    
        handleMailingStateChange(event){
        this.parentGuardianFNm.primaryParentMailingState= event.target.value;
        console.log('Parent mailing state On Val Change===> '+this.parentGuardianFNm.primaryParentMailingState);
        }
    
        handleMailingPostalCodeChange(event){
        this.parentGuardianFNm.primaryParentMailingPostalCode= event.target.value;
        console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.primaryParentMailingPostalCode);
        }

        handlePlaceOfEmploymentChange(event){
            this.parentGuardianFNm.primaryParentPlaceOfEmployment= event.target.value;
        console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.placeOfEmployment);
        }

        handleHomePhoneChange(event){
            this.parentGuardianFNm.homePhn= event.target.value;
            console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.homePhn);
        }

        handleMobilePhoneChange(event){
            this.parentGuardianFNm.mobilePhn= event.target.value;
            console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.mobilePhn);
        }

        handleWorkPhoneChange(event){
            this.parentGuardianFNm.workPhn= event.target.value;
            console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.workPhn);
        }

        handleEmailChange(event){
            this.parentGuardianFNm.email= event.target.value;
            console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.email);
        }

        handleMonthlyIncomeChange(event){
            this.parentGuardianFNm.monthlyIncome= event.target.value;
            console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.monthlyIncome);
        }

        handleHousingChange(event){
            this.parentGuardianFNm.housingSelectedColumn= event.target.value;
            console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.housingSelectedColumn);
        }

        handleSecondaryFNameChange(event){
            this.parentGuardianFNm.secondaryParentfName= event.target.value;
            console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.secondaryParentfName);
        }

        handleSecondaryLNameChange(event){
            this.parentGuardianFNm.secondaryParentlName= event.target.value;
            console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.secondaryParentlName);
        }

        handleSecondaryParentRelationshipChange(event){
            this.parentGuardianFNm.secondaryParentRelationshipSelectedColumn= event.target.value;
            console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.secondaryParentRelationshipSelectedColumn);
        }

        handleSecondaryMailingStreetChange(event){
            this.parentGuardianFNm.secondaryParentMailingStreet= event.target.value;
            console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.secondaryParentMailingStreet);
        }

        handleSecondaryMailingCityChange(event){
            this.parentGuardianFNm.secondaryParentMailingCity= event.target.value;
            console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.secondaryParentMailingCity); 
        }

        handleSecondaryMailingStateChange(event){
            this.parentGuardianFNm.secondaryParentMailingState= event.target.value;
            console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.secondaryParentMailingState); 
        }

        handleSecondaryMailingPostalCodeChange(event){
            this.parentGuardianFNm.secondaryParentMailingPostalCode= event.target.value;
            console.log('Parent postal On Val Change===> '+this.parentGuardianFNm.secondaryParentMailingPostalCode); 
        }

        handleSecondaryPlaceOfEmploymentChange(){

        }

        handleSecondaryHomePhoneChange(){

        }
        handleSecondaryMobilePhoneChange(){

        }

        handleSecondaryWorkPhoneChange(){

        }
        handleSecondaryEmailChange(){

        }

handleSubmit(){
       
            console.log(JSON.stringify(currlist));
            var currlist=  this.testContactChildItemArr;
            var lstLength= currlist.length;
            console.log(lstLength);
            
            
            
        this.isLoading = true;
      var pConRecId= this.ggFamilyParentRecId;
      console.log('Test Parent1 :'+pConRecId);
    
     // var parentSignatureTest=  this.userInput;   
      //console.log(parentSignatureTest);
        
      var recDataLst= JSON.stringify(this.testContactChildItemArr);
      console.log(recDataLst); 
            
                var currlistNew=  this.testContactChildItemArr;
            console.log(JSON.stringify(currlistNew));
            var lstLengthNew= currlistNew.length;
            console.log(lstLengthNew);
            
                
                
                
      insertIntake({ itemData : recDataLst, parentId:pConRecId})
        
      .then(result=>{
              this.message = result;
              this.error = undefined;
              this.showSuccessToast();
              this.isLoading = false;
           this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                   // url: 'https://gwensgirls--partial.sandbox.my.site.com/mainForm/s/mplc-form'
                    url: '/youthdevelopmentintakethankyoupage'
                },
            
            });
      })
      .catch(error =>{
          this.isLoading = false;
         this.errorMsg=error.message;
         console.log('Error Msg: '+this.errorMsg);
        
        // alert(this.errorMsg);
         return this.showErrorToast();
        
         window.console.log(this.error);
          //
      });
         
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