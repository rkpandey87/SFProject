import { LightningElement,track } from 'lwc';
import ggYouthFormLogo from "@salesforce/resourceUrl/ggYouthDevelopmentHeaderImg";
import insertIntake from '@salesforce/apex/YouthDevelopmentIntakeFormController.saveIntakeData';
//import generatePDF from   '@salesforce/apex/YouthDevelopmentIntakeFormController.generatePDFMethod';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import weight from '@salesforce/schema/Intake__c.Weight_NUM__c';
import height from '@salesforce/schema/Intake__c.Height_feet__c';
export default class YouthDevelopmentIntakeForm extends LightningElement {

    youthIntakeHeader = ggYouthFormLogo;
   // VfPageMethod;

    @track progressHtValue;
    @track progressWtValue;
    @track progressRaceValue;
    @track progressDobValue;
    @track progressSsnValue;
    @track progressConsignDtValue;
    @track progressGradeValue;

    handleProgressWtValueChange(event) {
        this.progressWtValue = event.detail;
        alert(this.progressWtValue);
      }

      handleProgressHtValueChange(event) {
        this.progressHtValue = event.detail;
        alert(this.progressHtValue);
      }

      handleProgressRaceValueChange(event) {
        this.progressRaceValue = event.detail;
        alert(this.progressRaceValue);
      }

      handleProgressDobValueChange(event) {
        this.progressDobValue = event.detail;
        console.log(this.progressDobValue);
      }

      handleProgressSsnValueChange(event) {
        this.progressSsnValue = event.detail;
        console.log(this.progressSsnValue);
      }

      handleProgressConDtValueChange(event){
        this.progressConsignDtValue = event.detail;
        alert(this.progressConsignDtValue);
      }

      handleProgressGradeValueChange(event){
        this.progressGradeValue = event.detail;
        alert(this.progressGradeValue);
      }
     

    handleForSave() {
        insertIntake({ wt : this.progressWtValue,ht: this.progressHtValue, rc:this.progressRaceValue, dt:this.progressDobValue, ssn:this.progressSsnValue,grd:this.progressGradeValue,condt:this.progressConsignDtValue })
        .then(result=>{
            this.message = result;
                this.error = undefined;
                this.showSuccessToast();
              console.log(JSON.stringify(result));
        })
        .catch(error =>{
           this.errorMsg=error.message;
           return this.showErrorToast();
           window.console.log(this.error);
        });
    }

    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'Toast Success',
            message: 'Youth Development Intake Form Saved Successfully !',
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

    
    

}