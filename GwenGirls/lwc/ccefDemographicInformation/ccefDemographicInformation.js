import { LightningElement } from 'lwc';

export default class CcefDemographicInformation extends LightningElement {

    value = 'inProgress';

    get options() {
        return [
            { label: 'united states', value: 'united states' },
            { label: 'CA', value: 'CA' },
            
        ];
    }

    handleChange(event) {
        this.value = event.detail.value;
    }

     activeSections = ['A', 'C'];
    activeSectionsMessage = '';

    handleSectionToggle(event) {
        const openSections = event.detail.openSections;

        if (openSections.length === 0) {
            this.activeSectionsMessage = 'All sections are closed';
        } else {
            this.activeSectionsMessage =
                'Open sections: ' + openSections.join(', ');
        }
    }
}