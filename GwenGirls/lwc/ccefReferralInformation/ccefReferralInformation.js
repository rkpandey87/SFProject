import { LightningElement } from 'lwc';
import ggYouthFormLogo from "@salesforce/resourceUrl/ggYouthDevelopmentHeaderImg";
export default class CcefReferralInformation extends LightningElement {
    get rowOptions1() {
        return [
            { label: 'City of Pittsburgh East', value: 'City of Pittsburgh East' }
        ];
    }
    get rowOptions2() {
        return [
            { label: 'City of Pittsburgh North', value: 'City of Pittsburgh North' }
        ];
    }

    get rowOptions3() {
        return [
            { label: 'City of Pittsburgh South', value: 'City of Pittsburgh South' }
        ];
    }

    get rowOptions4() {
        return [
            { label: 'City of Pittsburgh West', value: 'City of Pittsburgh West' }
        ];
    }

    get rowOptions5() {
        return [
            { label: 'Braddock', value: 'Braddock' }
        ];
    }

    get rowOptions6() {
        return [
            { label: 'East Pittsburgh', value: 'East Pittsburgh' }
        ];
    }

    get rowOptions7() {
        return [
            { label: 'Mon-Valley', value: 'Mon-Valley' }
        ];
    }

    get rowOptions8() {
        return [
            { label: 'Penn Hills', value: 'Penn Hills' }
        ];
    }

    get rowOptions9() {
        return [
            { label: 'Other:', value: 'Other:' }
        ];
    }

 
    handleCheckboxChange(event) {
        this.selectedValues = event.detail.value;
        // You can perform additional logic based on the selected values
    }

}