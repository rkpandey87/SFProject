import { LightningElement,track,api } from 'lwc';
//import ggYouthFormLogo from "@salesforce/resourceUrl/ggYouthDevelopmentHeaderImg";
export default class ConsentToReleaseRequestInfo extends LightningElement {

//youthIntakeHeader = ggYouthFormLogo;
@api progressConsignDtValue;
value = '';

get options() {
    return [
        { label: 'Releasing information to', value: 'Releasing information to' },
        { label: 'Requesting information from', value: 'Requesting information from' },
        { label: 'Verbal only', value: 'Verbal only' },
        { label: 'Records Only', value: 'Records Only' },
        { label: 'Verbal and Records', value: 'Verbal and Records' }
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
    { label: 'Psychiatric Evaluations', value: 'psychiatricEvaluations' },
    { label: 'Psychological Evaluations', value: 'PsychologicalEvaluations' },
    { label: 'Psychosocial Assessments/Tests', value: 'PsychosocialAssessments/Tests' },
    { label: 'Social History', value: 'SocialHistory' },
    { label: 'Discharge Summaries', value: 'DischargeSummaries' },
    { label: 'Treatment Recommendations', value: 'TreatmentRecommendations' },
    { label: 'OTHER:', value: 'OTHER' }
];

handleInputConsignDateChange(event){
    this.progressConsignDtValue = event.target.value;
    const consnDtSelectedEvt= new CustomEvent("progressconsgndtvaluechange",
        {
            detail: this.progressConsignDtValue
        }
    );
      // Dispatches the event.
      this.dispatchEvent(consnDtSelectedEvt);
}


handleCheckboxChange(event) {
    this.selectedValues = event.detail.value;
    // You can perform additional logic based on the selected values
}
@track selectedValues1 = [];

checkboxOptions1 = [
    { label: 'HIV', value: 'HIV' },
    { label: 'Behavioral Health – Psychiatric', value: 'Behavioral Health – Psychiatric' },
    { label: 'Drug & Alcohol', value: 'Drug & Alcohol' }
];

handleCheckboxChange1(event) {
    this.selectedValues1 = event.detail.value;
    // You can perform additional logic based on the selected values
}
}