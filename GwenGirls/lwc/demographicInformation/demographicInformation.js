import { LightningElement,track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class DemographicInformation extends LightningElement {
     @track rc = '';

     handleInputChange(event) {
        // Update the tracked variable with the input value
        this.rc = event.target.value;
    }
    handleButtonClick(event) {
    // Handle button click here
}


    handleButtonClick(event) {
        // Navigate to the new child component
        this[NavigationMixin.Navigate]({
            type: 'standard__component',
            attributes: {
                componentName: 'Child2'  // Replace with the actual name of your child component
            }
        });
    }
}