import { LightningElement,track } from 'lwc';
export default class GgCampPro extends LightningElement {

    value = [];

    get options() {
        return [
            { label: ' Cis-Girl/Woman', value: 'option1' },
            { label: 'Transgender Girl/Woman ', value: 'option2' },
            { label: 'Cis-Boy/Man ', value: 'option3' },
            { label: 'Transgender Boy/Man ', value: 'option4' },
            { label: 'Gender Queer/Non-Binary/Gender Fluid ', value: 'option5' },
            { label: 'other', value: 'option6' },
        ];
    }

    get selectedValues() {
        return this.value.join(',');
    }

    handleChange(e) {
        this.value = e.detail.value;
    }

    get radioOptions() {
        return [
            { label: 'Yes', value: 'yes' },
            { label: 'No', value: 'no' },
            { label: 'Prefer Not to Say', value: 'preferNotToSay' }
        ];
    }

    handleChange(event) {
        this.selectedValue = event.detail.value;
        // Handle the selected value as needed
    }
    handleChange(event) {
        // Handle checkbox changes if needed
    }
}