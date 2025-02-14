import { LightningElement,track,api} from 'lwc';
import ggYouthFormLogo from "@salesforce/resourceUrl/ggYouthDevelopmentHeaderImg";


export default class GgDemo extends LightningElement {
    youthIntakeHeader = ggYouthFormLogo;
    @api progressHtValue;
    @api progressWtValue;
    @api progressRaceValue;
		@api progressDobValue;
		@api progressSsnValue;

    @track selectedAreasOfInterest = [];
		
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
		
handleInputDobChange(event){
		  this.progressDobValue = event.target.value;
        const dobSelectedEvt= new CustomEvent("progressdobvaluechange",
            {
                detail: this.progressDobValue
            }
        );
         // Dispatches the event.
         this.dispatchEvent(dobSelectedEvt);
}
		
		handleInputSsnChange(event){
		  this.progressSsnValue = event.target.value;
        const ssnSelectedEvt= new CustomEvent("ssnprogressvaluechange",
            {
                detail: this.progressSsnValue
            }
        );
         // Dispatches the event.
         this.dispatchEvent(ssnSelectedEvt);
}
		
    // Define the checkbox options
    checkboxOptions = [
        { label: 'Locating an apartment', value: 'locatingApartment' },
        { label: 'Driver’s Education', value: 'driversEducation' },
        { label: 'Job Readiness', value: 'jobReadiness' },
        { label: 'College Applications/Preparation', value: 'collegeApplications' },
        { label: 'GED Preparation', value: 'gedPreparation' },
        { label: 'Other', value: 'other' }
    ];

    // Handle changes in checkbox selection
    handleCheckboxChange(event) {
        this.selectedAreasOfInterest = event.detail.value;
    }

    @track selectedSourcesOfIncome1 = [];

    // Define the checkbox options for Source of Income
    checkboxOptions1 = [
        { label: 'Employment', value: 'employment' },
        { label: 'Unemployment', value: 'unemployment' },
        { label: 'Disability', value: 'disability' },
        { label: 'SSI', value: 'ssi' },
        { label: 'Social Security', value: 'socialSecurity' },
        { label: 'Retirement', value: 'retirement' },
        { label: 'Public Assistance', value: 'publicAssistance' },
        { label: 'Other', value: 'other' }
    ];

    // Handle changes in checkbox selection
    handleCheckboxChange1(event) {
        this.selectedSourcesOfIncome1 = event.detail.value;
    }

    @track isReceivingAssistance = false;
    @track isNotReceivingAssistance = false;

    handleCheckboxChange(event) {
        const checkboxValue = event.target.value;
        
        if (checkboxValue === 'Yes') {
            this.isReceivingAssistance = event.target.checked;
            this.isNotReceivingAssistance = !event.target.checked;
        } else if (checkboxValue === 'No') {
            this.isNotReceivingAssistance = event.target.checked;
            this.isReceivingAssistance = !event.target.checked;
        }
    }

    @track selectedSourcesOfIncome2 = [];

    // Define the checkbox options for Source of Income
    checkboxOptions2 = [
        { label: 'single family', value: 'single family' },
        { label: 'apartment', value: 'apartment' },
        { label: 'other:', value: 'other:' },
        
    ];

    // Handle changes in checkbox selection
    handleCheckboxChange2(event) {
        this.selectedSourcesOfIncome2 = event.detail.value;
    }
    @track selectedSourcesOfIncome3 = [];

    // Define the checkbox options for Source of Income
    checkboxOptions3 = [
        { label: ' rent family', value: ' rent' },
        { label: 'own', value: 'own' },
        
    ];

    // Handle changes in checkbox selection
    handleCheckboxChange3(event) {
        this.selectedSourcesOfIncome4 = event.detail.value;
    }
    @track selectedSourcesOfIncome4 = [];

    // Define the checkbox options for Source of Income
    checkboxOptions4 = [
        { label: 'Public Transportation', value: 'Public Transportation' },
        { label: 'Parent/Guardian Drop Off/Pick Up', value: 'Parent/Guardian Drop Off/Pick Up' },
        { label: 'Gwen’s Girls pick up from school', value: 'Gwen’s Girls pick up from school' },
        { label: 'Gwen’s Girls pick up from home', value: 'Gwen’s Girls pick up from home' },
        { label: 'Gwen’s Girls pick up from alternate address Security', value: 'Gwen’s Girls pick up from alternate address' },

    ];

    // Handle changes in checkbox selection
    handleCheckboxChange4(event) {
        this.selectedSourcesOfIncome4 = event.detail.value;
    }

    @track selectedSourcesOfIncome5 = [];

    // Define the checkbox options for Source of Income
    checkboxOptions5 = [
        { label: 'German Measles', value: 'German Measles' },
        { label: 'Mumps', value: 'Mumps' },
        { label: 'Chicken Pox', value: 'Chicken Pox' },
        { label: 'Hay Fever/Seasonal Allergies', value: 'Hay Fever/Seasonal Allergies' },

    ];
     // Handle changes in checkbox selection
     handleCheckboxChange5(event) {
        this.selectedSourcesOfIncome5 = event.detail.value;
    }

    @track selectedValue = ''; // Initialize with the default selected value, or leave it empty for no default selection

    // Define radio options
    radioOptions = [
        { label: 'Yes', value: 'Yes' },
        { label: 'No', value: 'No' },
        { label: 'Prefer Not to Say', value: 'Prefer Not to Say' }
    ];

    // Handle radio group value change
    handleChange(event) {
        this.selectedValue = event.detail.value;
        // You can add additional logic here based on the selected value
    }
  
    @track selectedValue1 = ''; // Initialize with the default selected value, or leave it empty for no default selection

    // Define radio options
    radioOptions1 = [
        { label: 'Yes', value: 'Yes' },
        { label: 'No', value: 'No' },
       
    ];

    // Handle radio group value change
    handleChange1(event) {
        this.selectedValue1 = event.detail.value;
        // You can add additional logic here based on the selected value
    } @track selectedValue2 = ''; // Initialize with the default selected value, or leave it empty for no default selection

    // Define radio options
    radioOptions2 = [
        { label: 'Yes', value: 'Yes' },
        { label: 'No', value: 'No' },
        
    ];

    // Handle radio group value change
    handleChange2(event) {
        this.selectedValue2 = event.detail.value;
        // You can add additional logic here based on the selected value
    } @track selectedValue3 = ''; // Initialize with the default selected value, or leave it empty for no default selection

    // Define radio options
    radioOptions3 = [
        { label: 'Yes', value: 'Yes' },
        { label: 'No', value: 'No' },
        
    ];

    // Handle radio group value change
    handleChange3(event) {
        this.selectedValue3 = event.detail.value;
        // You can add additional logic here based on the selected value
    } @track selectedValue4 = ''; // Initialize with the default selected value, or leave it empty for no default selection

    // Define radio options
    radioOptions4 = [
        { label: 'Yes', value: 'Yes' },
        { label: 'No', value: 'No' },
       
    ];

    // Handle radio group value change
    handleChange4(event) {
        this.selectedValue4 = event.detail.value;
        // You can add additional logic here based on the selected value
    }
    @track selectedSourcesOfIncome6 = [];

    // Define the checkbox options for Source of Income
    checkboxOptions6 = [
        { label: '  Food:', value: '  Food:' },
        { label: ' Medicine:', value: ' Medicine:' },
        { label: 'Insects:', value: 'Insects:' },
        { label: ' Other:', value: ' Other:' },

    ];
     // Handle changes in checkbox selection
     handleCheckboxChange6(event) {
        this.selectedSourcesOfIncome6 = event.detail.value;
    }

    @track selectedSourcesOfIncome7 = [];

    // Define the checkbox options for Source of Income
    checkboxOptions7 = [
        { label: ' Monday', value: '  Monday' },
        { label: ' Tuesday', value: 'Tuesday' },
        { label: 'Wednesday', value: 'Wednesday' },
        { label: ' Thursday', value: ' Thursday' },

    ];
     // Handle changes in checkbox selection
     handleCheckboxChange7(event) {
        this.selectedSourcesOfIncome7 = event.detail.value;
    }


   
}