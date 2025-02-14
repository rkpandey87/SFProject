import { LightningElement,track } from 'lwc';
import insertIntake from '@salesforce/apex/ggFormMainController.saveIntakeData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class GgButtonForm extends LightningElement {
    @track openModal = false;
    @track openInsertFormModal= false;
		fName;
		lName;
    showModalOfYouthForm(){
        this.openModal=true;  
    }

    InsertRecordForm(){
        this.openInsertFormModal= true;
            }

    closeModal() {
        this.openModal = false;
        
    }

    cancelModal(){
        this.openInsertFormModal= false;
    }
/*
    searchExistingRecord(){

    }
*/
		handleInputfNameChange(event){
				this.fName= event.detail.value;
		}
		
		handleInputlNameChange(event){
					this.lName= event.detail.value;
		}

handleForSave() {
    insertIntake({firstName : this.fName,lastName: this.lName  })
    .then(result=>{
        this.message = result;
            this.error = undefined;
            this.showSuccessToast();
          console.log(JSON.stringify(result));
    })
    .catch(error =>{
       this.errorMsg=error.message;
       return this.showErrorToast();
      
    });
}


showSuccessToast() {
    const evt = new ShowToastEvent({
        title: 'Toast Success',
        message: 'Youth Development Intake record created successfully !',
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