import { LightningElement,track,api } from 'lwc';
import intakeListData from '@salesforce/apex/YouthDevelopmentIntakeFormController.getIntakeDetails';
import insertIntake from '@salesforce/apex/YouthDevelopmentIntakeFormController.saveIntakeRec';
import ggYouthFormLogo from "@salesforce/resourceUrl/ggYouthDevelopmentHeaderImg";
export default class EmergencyInfoFaceSheet extends LightningElement {
    youthIntakeHeader = ggYouthFormLogo;
   // @track Intake__c ={};
    @api progressHtValue;
    @api progressWtValue;
    @api progressRaceValue;

    //dob;
    //rc;
   // wt;
    //ht;
   // nm;

    handleInputHeightChange(event){
        this.progressHtValue = event.target.value;
        const htSelectedEvt= new CustomEvent("progresshtvaluechange",
            {
                detail: this.progressHtValue
            }
        );
          // Dispatches the event.
          this.dispatchEvent(htSelectedEvt);

    }
    handleInputWeightChange(event){
        this.progressWtValue = event.target.value;
        const wtSelectedEvt= new CustomEvent("progresswtvaluechange",
            {
                detail: this.progressWtValue
            }
        );
          // Dispatches the event.
          this.dispatchEvent(wtSelectedEvt);
    }


    handleInputRaceChange(event){
        this.progressRaceValue = event.target.value;
        const raceSelectedEvt= new CustomEvent("progressrcvaluechange",
            {
                detail: this.progressRaceValue
            }
        );
         // Dispatches the event.
         this.dispatchEvent(raceSelectedEvt);
    }
     
    /*
    handleChange(event) {
        this.progressValue = event.target.value;
        // Creates the event with the data.
        const selectedEvent = new CustomEvent("progressvaluechange", {
          detail: this.progressValue
        });
    
        // Dispatches the event.
        this.dispatchEvent(selectedEvent);
      }
      */

    /*
    handleForSave(){
       
        alert(JSON.stringify(this.Intake__c));
        insertIntake({ intk : this.Intake__c})
        .then(result =>{
            
            this.Name='Pritam Rai';
            this.D_O_B__c='10';
            this.Race_TXT__c='20';
            this.Weight_NUM__c='30';
            this.Height_feet__c='40';
            this.toastEventFire('Success','account Record is Saved','success')                      
        })
        .catch(error =>{
            this.error = error.message;
            alert(JSON.stringify(error))
        })
    }*/

}