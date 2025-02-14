import { LightningElement,track } from 'lwc';
import ggYouthFormLogo from "@salesforce/resourceUrl/ggYouthDevelopmentHeaderImg";


export default class ConsetReleaseReIm extends LightningElement {
    youthIntakeHeader = ggYouthFormLogo;

    value = '';

    get options() {
        return [
            { label: 'Releasing information to', value: 'Releasing information to' },
            { label: 'Requesting information from', value: 'Requesting information from' },
            { label: 'Verbal only', value: 'Verbal only' },
            { label: 'Records Only', value: 'Records Only' },
            { label: 'Verbal and Records', value: 'Verbal and Records' },
        ];
    }
    @track selectedValues = [];

    checkboxOptions = [
        { label: 'Academic/School Records (include attendance)', value: 'academicSchoolRecords' },
        { label: 'Achievement Tests', value: 'achievementTests' },
        { label: 'Educational Assessments/IEP’s/ISP’s/Behav. Report', value: 'educationalAssessments' },
        { label: 'Medical History', value: 'medicalHistory' },
        { label: 'Immunizations', value: 'immunizations' },
        { label: 'Medications', value: 'medications' },
        { label: 'Dental Records', value: 'dentalRecords' },
        { label: 'Psychiatric Evaluations', value: 'psychiatricEvaluations' }
    ];

    handleCheckboxChange(event) {
        this.selectedValues = event.detail.value;
        // You can perform additional logic based on the selected values
    }
    @track selectedValues1 = [];

    checkboxOptions1 = [
        { label: 'HIV', value: 'HIV' },
        { label: 'Behavioral Health – Psychiatric', value: 'Behavioral Health – Psychiatric' },
        { label: 'Educational Assessments/IEP’s/ISP’s/Behav. Report', value: 'educationalAssessments' },
        { label: 'Drug & Alcohol', value: 'Drug & Alcohol' },
    ];

    handleCheckboxChange1(event) {
        this.selectedValues1 = event.detail.value;
        // You can perform additional logic based on the selected values
    }
}