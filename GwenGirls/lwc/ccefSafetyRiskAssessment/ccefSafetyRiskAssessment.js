import { LightningElement } from 'lwc';
export default class CcefSafetyRiskAssessment extends LightningElement {

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
     get rowOptions11() {
        return [
            { label: 'Juvenile Justice', value: 'Juvenile Justice' }
        ];
    }
    get rowOptions22() {
        return [
            { label: 'Child Welfare', value: 'Child Welfare' }
        ];
    }

    get rowOptions33() {
        return [
            { label: 'Disability Services', value: 'Disability Services' }
        ];
    }
    get rowOptions111() {
        return [
            { label: 'Special Education (IEP/504)', value: 'Special Education (IEP/504)' }
        ];
    }
    get rowOptions222() {
        return [
            { label: 'Behavioral Health Services', value: 'Behavioral Health Services' }
        ];
    }

     get rowOptions11q() {
        return [
            { label: 'East', value: 'East' }
        ];
    }
    get rowOptions22q() {
        return [
            { label: 'Central', value: 'Central' }
        ];
    }

    get rowOptions33q() {
        return [
            { label: 'Intake/Child Protection', value: 'Intake/Child Protection' }
        ];
    }

     get rowOptions11qw() {
        return [
            { label: 'Mon Valley', value: 'Mon Valley' }
        ];
    }
    get rowOptions22qw() {
        return [
            { label: 'North', value: 'North' }
        ];
    }

    get rowOptions33qw() {
        return [
            { label: 'Permanency', value: 'Permanency' }
        ];
    }
    
    get rowOptions33qwe() {
        return [
            { label: 'South', value: 'South' }
        ];
    }

     get rowOptions11qwer() {
        return [
            { label: 'Court Active', value: 'Court Active' }
        ];
    }
    get rowOptions22qwer() {
        return [
            { label: 'Not Court Active', value: 'Not Court Active' }
        ];
    }


}