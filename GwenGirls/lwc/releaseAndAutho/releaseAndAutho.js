import { LightningElement,api } from 'lwc';
//import ggYouthFormLogo from "@salesforce/resourceUrl/ggYouthDevelopmentHeaderImg";
export default class ReleaseAndAutho extends LightningElement {
   //  youthIntakeHeader = ggYouthFormLogo;
     @api progressGradeValue;
		
		handleInputGradeChange(event){
				this.progressGradeValue = event.target.value;
    const gradeSelectedEvt= new CustomEvent("progressgradevaluechange",
        {
            detail: this.progressGradeValue
        }
    );
      // Dispatches the event.
      this.dispatchEvent(gradeSelectedEvt);
		}
		
	
		
}