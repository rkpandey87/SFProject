import { LightningElement } from 'lwc';

export default class CcefConsentToTreatment extends LightningElement {

    get rowOptions1() {
        return [
            { label: 'Yes', value: 'Yes' }
        ];
    }
    get rowOptions2() {
        return [
            { label: 'No', value: 'No' }
        ];
    }
}