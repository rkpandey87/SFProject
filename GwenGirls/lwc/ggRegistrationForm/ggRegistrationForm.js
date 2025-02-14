/**
 * @description       : 
 * @author            : WINSupport
 * @group             : 
 * @last modified on  : 03-22-2021
 * @last modified by  : WINSupport
 * Modifications Log 
 * Ver   Date         Author       Modification
 * 1.0   03-22-2021   WINSupport   Initial Version
**/
import { LightningElement,track,api,wire } from 'lwc';
import gwenGirlsLogo from '@salesforce/resourceUrl/gwenGirlsLogo';
import getPageLoadData from '@salesforce/apex/RegistrationFormController.getPageLoadData';
import saveForm from '@salesforce/apex/RegistrationFormController.saveForm';
export default class GgRegistrationForm extends LightningElement {
    @track isSubmitDisable=false;

    GwenGirlLogo = gwenGirlsLogo+'/gglogo/GWENlogo.jpg';
    @track imguri = ''; @track Today =''; @track CampaignId='';
    @track ProgramName='';@track ProgramId='';
    @api isLoaded = false;
    @track HowDoYouHearAboutUs='';
    @track Child1RecordId=''; @track Child2RecordId=''; @track Child3RecordId='';
    @track Parent1RecordId=''; @track Parent2RecordId='';
    @track Parent1AccountId=''; @track CampaignMemberId='';
    @track showChild1Info=false; @track showChild2Info=false; @track showChild3Info=false;
    @track showParent1Info=false; @track showParent2Info=false;
    @track showEmergencyContactInfo=false;
    @track Child1FirstName=''; @track Child1LastName=''; @track Child1Birthday=''; @track Child1Age='';
    @track Child1SSN=''; @track school1name=''; @track Child1School=''; @track Child1Grade='';
    @track Child1PhysicianName=''; @track Child1PhysicianPhone=''; @track Child1PhysicianInsuranceNumber='';
    @track Child1LastPhysical=''; @track Child1LastVisionTest=''; @track Child1LastHearingExam=''; @track Child1Dental='';
    @track Child1OperationInjuries1=''; @track Child1CurrentMedications=''; @track Child1TakeMedication='';
    @track Child1SpecialNeeds=''; @track Child1PhysiciansAdvice=''; @track Child1HaveHad='';
    @track Child1PhysicianDetails=''; @track Child1Allergies=''; @track Child1AllergiesDetails='';
    @track Child1AttendAfterSchool='';

    @track Child2FirstName=''; @track Child2LastName=''; @track Child2Name=''; @track Child2Birthday='';
    @track Child2Age=''; @track Child2SSN=''; @track school2name=''; @track Child2School=''; @track Child2Grade='';
    @track Child2PhysicianName=''; @track Child2PhysicianPhone=''; @track Child2PhysicianInsuranceNumber='';
    @track Child2LastPhysical=''; @track Child2LastVisionTest=''; @track Child2LastHearingExam='';
    @track Child2Dental=''; @track Child2OperationInjuries1=''; @track Child2CurrentMedications='';
    @track Child2TakeMedication=''; @track Child2SpecialNeeds='';
    @track Child2PhysiciansAdvice=''; @track Child2HaveHad=''; @track Child2PhysicianDetails='';
    @track Child2Allergies=''; @track Child2AllergiesDetails=''; @track Child2AttendAfterSchool='';


    @track Child3FirstName=''; @track Child3LastName=''; @track Child3Name=''; @track Child3Birthday=''; 
    @track Child3Age=''; @track Child3SSN=''; @track school3name=''; @track Child3School=''; @track Child3Grade='';
    @track Child3PhysicianName=''; @track Child3PhysicianPhone=''; @track Child3PhysicianInsuranceNumber='';
    @track Child3LastPhysical=''; @track Child3LastVisionTest=''; @track Child3LastHearingExam='';
    @track Child3Dental=''; @track Child3OperationInjuries1=''; @track Child3CurrentMedications='';
    @track Child3TakeMedication=''; @track Child3SpecialNeeds=''; @track Child3PhysiciansAdvice='';
    @track Child3HaveHad=''; @track Child3PhysicianDetails=''; @track Child3Allergies='';
    @track Child3AllergiesDetails=''; @track Child3AttendAfterSchool='';

    @track EmergencyContactFirst=''; @track EmergencyContactLast=''; @track EmergencyContactRelationShip='';
    @track EmergencyPhone=''; @track EmergencyCellPhone=''; @track ApprovedPickUp1='';
    @track ApprovedPickup1Relationship=''; @track ApprovedPickUp1Phone=''; @track ApprovedPickUp2='';
    @track ApprovedPickup2Relationship=''; @track ApprovedPickUp2Phone=''; 

    @api GradesList= []; @api Parent1RelationshipList=[]; @api Parent2RelationshipList=[];
    @api PublicAssistancePickList=[]; @api HousingTypePickList=[]; @api HousingOwnerShipPickList=[];
    @api EmergencyContactRelationShipPickList=[]; @api ApprovedPickup1RelationshipPickList=[];
    @api ApprovedPickup2RelationshipPickList=[]; @api Child1TakesMedicationPickList=[];
    @api Child2TakesMedicationPickList=[]; @api Child3TakesMedicationPickList=[];
    @api Parent1SourceOfIncomeMultiPicklist=[]; @api Parent2SourceOfIncomeMultiPicklist=[];
    @api Child1HaveHadIllnessMultiPicklist=[]; @api Child2HaveHadIllnessMultiPicklist=[];
    @api Child3HaveHadIllnessMultiPicklist=[]; @api Child1AllergiesMultiPicklist=[];
    @api Child2AllergiesMultiPicklist=[]; @api Child3AllergiesMultiPicklist=[];
    @api Child1DaysAttendAfterSchoolMultiPicklist=[]; @api Child2DaysAttendAfterSchoolMultiPicklist=[];
    @api Child3DaysAttendAfterSchoolMultiPicklist=[];

    @track Parent1FirstName=''; @track Parent1LastName=''; @track Parent1Relationship='';
    @track Parent1Address=''; @track Parent1City=''; @track Parent1State=''; @track Parent1ZipCode='';
    @track Parent1PlaceOfEmp=''; @track Parent1HomePhone=''; @track Parent1CellPhone='';
    @track Parent1WorkPhone=''; @track Parent1emailAddress=''; @track Parent1MonthlyIncome='';
    @track Parent1SourceIncome=''; @track Parent1PublicAssistance='';  @track Parent1HousingType=''; 
    @track Parent1HousingOwnerShip=''; @track Parent1TimeInResidence=''; @track Parent2FirstName='';
    @track Parent2LastName=''; @track Parent2Relationship=''; @track Parent2Address='';
    @track Parent2City=''; @track Parent2State=''; @track Parent2ZipCode=''; @track Parent2PlaceOfEmp='';
    @track Parent2HomePhone=''; @track Parent2CellPhone=''; @track Parent2WorkPhone='';
    @track Parent2emailAddress=''; @track Parent2MonthlyIncome=''; @track Parent2SourceIncome='';  
    @track Parent2PublicAssistance=''; @track Parent2HousingType=''; @track Parent2HousingOwnerShip='';  
    @track Parent2TimeInResidence='';     @track ParentRecordPin=''; @track PIN=''; @track RegisterForm=false; 
    @track alertMessage=''; @track successMessage=false; @track successMessage1 = false; 
    @track errorMessage=false; @track errorMessage1=false;    @track error;    @track ParentFirstLastName='';
    @track allChild1IllnessMultiPicklistValues=[];
    @track Child1IllnessValues=[];
    @track isChild1Entered=false;

    MultipicklistOnChangeHelper(picklistValues,selectedValue){
        var multiPicklistValues = picklistValues;
        console.log('picklistValues--->'+picklistValues);
        if(selectedValue!='None'){
            if(!multiPicklistValues.includes('None')){
                if(!multiPicklistValues.includes(selectedValue)){
                    multiPicklistValues.push(selectedValue);
                }	
            }
        }
        else{
            multiPicklistValues=[];
            multiPicklistValues.push(selectedValue);
        }
        console.log('picklistValues--->'+multiPicklistValues);
        return multiPicklistValues;
    }


    handleChild1HadIllnessMultiPicklistValueChange(event){
        this.refreshMessages();
        this.allChild1IllnessMultiPicklistValues = this.MultipicklistOnChangeHelper(this.allChild1IllnessMultiPicklistValues,event.target.value);
    }

    handleRemoveChild1HadIllnessMultiPicklistValue(event){
        const valueRemoved = event.target.name;
        this.allChild1IllnessMultiPicklistValues.splice(this.allChild1IllnessMultiPicklistValues.indexOf(valueRemoved), 1);
    } 

    @track allChild1AllergiesMultiPicklistValues=[];
    @track Child1AllergiesValues=[];
    handleChild1AllergiesMultiPicklistValueChange(event){
        this.refreshMessages();
        this.allChild1AllergiesMultiPicklistValues = this.MultipicklistOnChangeHelper(this.allChild1AllergiesMultiPicklistValues,event.target.value);
    }
    handleRemoveChild1AllergiesMultiPicklistValue(event){
        const valueRemoved = event.target.name;
        this.allChild1AllergiesMultiPicklistValues.splice(this.allChild1AllergiesMultiPicklistValues.indexOf(valueRemoved), 1);
    } 


    @track allChild1AttendSchoolMultiPicklistValues = [];    @track Child1AttendSchoolValues=[];
    handleChild1AttendSchoolMultiPicklistValueChange(event){
        this.refreshMessages();
        this.allChild1AttendSchoolMultiPicklistValues = this.MultipicklistOnChangeHelper(this.allChild1AttendSchoolMultiPicklistValues,event.target.value);
    }

    handleRemoveChild1AttendSchoolMultiPicklistValue(event){
        const valueRemoved = event.target.name;
        this.allChild1AttendSchoolMultiPicklistValues.splice(this.allChild1AttendSchoolMultiPicklistValues.indexOf(valueRemoved), 1);
    } 

    @track allChild2IllnessMultiPicklistValues=[];    @track Child2IllnessValues=[];
    handleChild2HadIllnessMultiPicklistValueChange(event){
        this.refreshMessages();
        this.allChild2IllnessMultiPicklistValues = this.MultipicklistOnChangeHelper(this.allChild2IllnessMultiPicklistValues,event.target.value);                
    }
    handleRemoveChild2HadIllnessMultiPicklistValue(event){
        const valueRemoved = event.target.name;
        this.allChild2IllnessMultiPicklistValues.splice(this.allChild2IllnessMultiPicklistValues.indexOf(valueRemoved), 1);
    } 

    @track allChild2AllergiesMultiPicklistValues=[];    @track Child2AllergiesValues=[];
    handleChild2AllergiesMultiPicklistValueChange(event){
        this.refreshMessages();
        this.allChild2AllergiesMultiPicklistValues = this.MultipicklistOnChangeHelper(this.allChild2AllergiesMultiPicklistValues,event.target.value);                 
    }
    handleRemoveChild2AllergiesMultiPicklistValue(event){
        const valueRemoved = event.target.name;
        this.allChild2AllergiesMultiPicklistValues.splice(this.allChild2AllergiesMultiPicklistValues.indexOf(valueRemoved), 1);
    } 

    @track allChild2AttendSchoolMultiPicklistValues = [];    @track Child2AttendSchoolValues=[];
    handleChild2AttendSchoolMultiPicklistValueChange(event){
        this.allChild2AttendSchoolMultiPicklistValues = this.MultipicklistOnChangeHelper(this.allChild2AttendSchoolMultiPicklistValues,event.target.value);        
    }
    handleRemoveChild2AttendSchoolMultiPicklistValue(event){
        const valueRemoved = event.target.name;
        this.allChild2AttendSchoolMultiPicklistValues.splice(this.allChild2AttendSchoolMultiPicklistValues.indexOf(valueRemoved), 1);
    } 


    @track allChild3IllnessMultiPicklistValues=[];    @track Child3IllnessValues=[];
    handleChild3HadIllnessMultiPicklistValueChange(event){
        this.refreshMessages();
        this.allChild3IllnessMultiPicklistValues = this.MultipicklistOnChangeHelper(this.allChild3IllnessMultiPicklistValues,event.target.value);                
    }
    handleRemoveChild3HadIllnessMultiPicklistValue(event){
        const valueRemoved = event.target.name;
        this.allChild3IllnessMultiPicklistValues.splice(this.allChild3IllnessMultiPicklistValues.indexOf(valueRemoved), 1);
    } 

    @track allChild3AllergiesMultiPicklistValues=[];    @track Child3AllergiesValues=[];
    handleChild3AllergiesMultiPicklistValueChange(event){
        this.refreshMessages();
        this.allChild3AllergiesMultiPicklistValues = this.MultipicklistOnChangeHelper(this.allChild3AllergiesMultiPicklistValues,event.target.value);        
    }
    handleRemoveChild3AllergiesMultiPicklistValue(event){
        const valueRemoved = event.target.name;
        this.allChild3AllergiesMultiPicklistValues.splice(this.allChild3AllergiesMultiPicklistValues.indexOf(valueRemoved), 1);
    } 


    @track allChild3AttendSchoolMultiPicklistValues = [];    @track Child3AttendSchoolValues=[];
    handleChild3AttendSchoolMultiPicklistValueChange(event){
        this.refreshMessages();
        this.allChild3AttendSchoolMultiPicklistValues = this.MultipicklistOnChangeHelper(this.allChild3AttendSchoolMultiPicklistValues,event.target.value);        
    }

    handleRemoveChild3AttendSchoolMultiPicklistValue(event){
        const valueRemoved = event.target.name;
        this.allChild3AttendSchoolMultiPicklistValues.splice(this.allChild3AttendSchoolMultiPicklistValues.indexOf(valueRemoved), 1);
    } 


    @track allParent1MultiPicklistValues=[];    @track Parent1SourceIncomeValues=[];
    handleParent1SourceOfIncomeMultiPicklist(event){
        this.refreshMessages();
        this.allParent1MultiPicklistValues = this.MultipicklistOnChangeHelper(this.allParent1MultiPicklistValues,event.target.value);               
    }

    handleRemoveParent1SourceOfIncomeMultiPicklistValue(event){
        const valueRemoved = event.target.name;
        this.allParent1MultiPicklistValues.splice(this.allParent1MultiPicklistValues.indexOf(valueRemoved), 1);
        console.log('***this.allParent1MultiPicklistValues***'+this.allParent1MultiPicklistValues);
    } 


    @track allParent2MultiPicklistValues=[];    @track Parent2SourceIncomeValues=[];
    handleParent2SourceOfIncomeMultiPicklist(event){
        this.refreshMessages();
        this.allParent2MultiPicklistValues = this.MultipicklistOnChangeHelper(this.allParent2MultiPicklistValues,event.target.value);               
    }

    handleRemoveParent2SourceOfIncomeMultiPicklistValue(event){
        const valueRemoved = event.target.name;
        this.allParent2MultiPicklistValues.splice(this.allParent2MultiPicklistValues.indexOf(valueRemoved), 1);
    } 

    @track Child1TabClickCount=0;
    handleChild1InfoOnclick(event){
        this.Child1TabClickCount=this.Child1TabClickCount+1;
        if(this.Child1TabClickCount%2==0){
            this.showChild1Info=true;
        }else{
            this.showChild1Info=false;
        }
        this.showChild2Info=false; this.showChild3Info=false;  this.showParent1Info=false;  this.showParent2Info=false; this.showEmergencyContactInfo = false; 
    }
    @track Child2TabClickCount=0;
    handleChild2InfoOnclick(event){
        this.Child2TabClickCount=this.Child2TabClickCount+1;
        if(this.Child2TabClickCount%2==0){
            this.showChild2Info=true;
        }else{
            this.showChild2Info=false;
        }        
        this.showChild1Info=false; this.showChild3Info=false;  this.showParent1Info=false;   this.showParent2Info=false;  this.showEmergencyContactInfo = false;
    }
    @track Child3TabClickCount=0;
    handleChild3InfoOnclick(event){
        this.Child3TabClickCount=this.Child3TabClickCount+1;
        if(this.Child3TabClickCount%2==0){
            this.showChild3Info=true;
        }else{
            this.showChild3Info=false;
        }          
        this.showChild1Info=false;        this.showChild2Info=false; this.showParent1Info=false; this.showParent2Info=false;  this.showEmergencyContactInfo = false;
    }
    @track Parent1TabClickCount=0;
    handleParent1InfoOnclick(event){
        this.Parent1TabClickCount=this.Parent1TabClickCount+1;
        if(this.Parent1TabClickCount%2==0){
            this.showParent1Info=true;
        }else{
            this.showParent1Info=false;
        }          
        this.showChild1Info=false;  this.showChild2Info=false; this.showChild3Info=false;this.showParent2Info=false;  this.showEmergencyContactInfo = false;    
    }
    @track Parent2TabClickCount=0;
    handleParent2InfoOnclick(event){
        this.Parent2TabClickCount=this.Parent2TabClickCount+1;
        if(this.Parent2TabClickCount%2==0){
            this.showParent2Info=true;
        }else{
            this.showParent2Info=false;
        }          
        this.showChild1Info=false; this.showChild2Info=false;  this.showChild3Info=false;  this.showParent1Info=false; this.showEmergencyContactInfo=false; 
    }

    @track EmergencyContact2TabClickCount=0;
    handleEmergencyContactInfoOnclick(event){
        this.EmergencyContact2TabClickCount=this.EmergencyContact2TabClickCount+1;
        if(this.EmergencyContact2TabClickCount%2==0){
            this.showEmergencyContactInfo=true;
        }else{
            this.showEmergencyContactInfo=false;
        }          
        this.showChild1Info=false;  this.showChild2Info=false;  this.showChild3Info=false;   this.showParent1Info=false;  this.showParent2Info=false;   
    }
    selectedRecordId; //store the record id of the selected 
    handleValueSelcted(event) {
        this.selectedRecordId = event.detail;        
    }
    validateLookupField() {
        this.template.querySelector('c-custom-lookup').isValid();
    }        
    handleDOBchange(event){
        this.refreshMessages();
        this.alertMessage='';
        var today = new Date();
        var birthDate = new Date(event.target.value);
        var age = today.getFullYear() - birthDate.getFullYear();
        var m = today.getMonth() - birthDate.getMonth();
        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }
        console.log('age is '+age);

        if(birthDate > today){
            if(event.target.name=='Child1Birthday'){
                alert('Please Enter Valid DOB for Child1 ');this.alertMessage = 'Please Enter Valid DOB for Child1';
                this.Child1Birthday=''; this.Child1Age = '';
            }
            if(event.target.name=='Child2Birthday'){
                alert('Please Enter Valid DOB for Child2');this.alertMessage = 'Please Enter Valid DOB for Child2';
                this.Child2Birthday=''; this.Child2Age = '';
            }
            if(event.target.name=='Child3Birthday'){
                alert('Please Enter Valid DOB for Child3');this.alertMessage = 'Please Enter Valid DOB for Child3';
                this.Child3Birthday=''; this.Child3Age = '';
            }
            this.successMessage = false; this.successMessage1 = false; this.isLoaded = false; this.errorMessage = true; this.errorMessage1 = true;     
        }
        if(this.alertMessage==''){
            if(event.target.name=='Child1Birthday'){
                this.Child1Age = age+' years'; this.Child1Birthday = event.target.value;
            }
            if(event.target.name=='Child2Birthday'){
                this.Child2Age = age+' years'; this.Child2Birthday = event.target.value;
            }
            if(event.target.name=='Child3Birthday'){
                this.Child3Age = age+' years'; this.Child3Birthday = event.target.value;
            }   
        }


    }
    handlePIN(event){
        if(event.target.name=='pin'){
        this.ParentRecordPin=event.target.value;
        console.log(this.ParentRecordPin);
        }
    }
    verifyPin(){
        if(this.PIN!=undefined && this.PIN!=''){
            if(this.PIN==this.ParentRecordPin){
                this.RegisterForm=true;  this.errorMessage = false;   this.errorMessage1 = false; 
            }
            else if(this.ParentRecordPin==''){
                this.alertMessage = 'Please Enter PIN'; this.successMessage = false;  
                this.successMessage1 = false;this.errorMessage = true; this.errorMessage1 = true;  this.RegisterForm=false;    
            }
            else if(this.PIN!=this.ParentRecordPin && this.ParentRecordPin!=''){
                this.alertMessage = 'Please Enter Correct PIN';    this.successMessage = false; this.successMessage1 = false;
                this.errorMessage = true;  this.errorMessage1 = true;   this.RegisterForm=false;    
            }    
        }else{
            this.RegisterForm=true;  this.errorMessage = false;  this.errorMessage1 = false;
        }
    }
   connectedCallback() {
    console.log('hiii');
    //alert('Hii');
    this.PageLoadHelper();
    }
  PageLoadHelper(){//this.errorMessage = false;
    //alert('hiii');
    this.showChild1Info=false; this.Child1TabClickCount=1; this.Child1TabClickCount=1; this.Child1TabClickCount=1;
    this.Child2TabClickCount=1;   this.showChild3Info=false; this.Child3TabClickCount=1; this.Parent1TabClickCount=0; this.Parent2TabClickCount=0;
    this.allParent1MultiPicklistValues=[];  this.allParent2MultiPicklistValues=[];
    this.allChild1IllnessMultiPicklistValues=[];this.allChild2IllnessMultiPicklistValues=[]; this.allChild3IllnessMultiPicklistValues=[];
    this.allChild1AllergiesMultiPicklistValues=[];  this.allChild2AllergiesMultiPicklistValues=[];  this.allChild3AllergiesMultiPicklistValues=[];
    let params = (new URL(document.location)).searchParams;
    let ParentId = params.get('ParentId'); 
    this.Parent1RecordId = ParentId;
    console.log('name--->'+ParentId);
    let CampaignId = params.get('CampaignId'); 
    this.CampaignId = CampaignId;    
    let CampaignMemberId = params.get('CampaignMemberId'); 
    this.CampaignMemberId = CampaignMemberId;
    let AccountId = params.get('AccountId'); 
    this.Parent1AccountId = AccountId;
    let today = new Date();
    let dd = String(today.getDate()).padStart(2, '0');
    let mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
    let yyyy = today.getFullYear();
    this.Today = mm + '/' + dd + '/' + yyyy;  console.log('todays dateeeeeee---->'+this.Today);
        getPageLoadData( {
            ParentId : this.Parent1RecordId,CampaignId:this.CampaignId
        })
        .then((result) => {
            if(result!==undefined && result!=''){
                //alert(this.Parent1RecordId+' '+this.CampaignId);
                console.log('result--hii -->'+JSON.stringify(result));
                if(result!=''){
                    this.GradesList = result.GradesList;   this.Parent1RelationshipList = result.ParentRelationshipList;
                    this.Parent2RelationshipList = result.ParentRelationshipList;   this.PublicAssistancePickList= result.PublicAssistancePickList;
                    this.Parent1HousingTypePickList= result.HousingTypePickList; this.Parent2HousingTypePickList= result.HousingTypePickList;
                    this.Parent1HousingOwnerShipPickList= result.HousingOwnerShipPickList;this.Parent2HousingOwnerShipPickList= result.HousingOwnerShipPickList;
                    this.EmergencyContactRelationShipPickList= result.EmergencyContactRelationShipPickList; this.ApprovedPickup1RelationshipPickList= result.ApprovedPickup1RelationshipPickList;
                    this.ApprovedPickup2RelationshipPickList= result.ApprovedPickup2RelationshipPickList; this.Child1TakesMedicationPickList= result.TakesMedicationPickList;
                    this.Child2TakesMedicationPickList= result.TakesMedicationPickList; this.Child3TakesMedicationPickList= result.TakesMedicationPickList;
                    this.Parent1SourceOfIncomeMultiPicklist = result.SourceOfIncomeMultiPicklist;  this.Parent2SourceOfIncomeMultiPicklist = result.SourceOfIncomeMultiPicklist;
                    this.Child1HaveHadIllnessMultiPicklist =result.HaveHadIllnessMultiPicklist;this.Child2HaveHadIllnessMultiPicklist =result.HaveHadIllnessMultiPicklist;
                    this.Child3HaveHadIllnessMultiPicklist =result.HaveHadIllnessMultiPicklist; this.Child1AllergiesMultiPicklist = result.AllergiesMultiPicklist;
                    this.Child2AllergiesMultiPicklist = result.AllergiesMultiPicklist; this.Child3AllergiesMultiPicklist = result.AllergiesMultiPicklist;
                    this.Child1DaysAttendAfterSchoolMultiPicklist = result.DaysAttendAfterSchoolMultiPicklist;  this.Child2DaysAttendAfterSchoolMultiPicklist = result.DaysAttendAfterSchoolMultiPicklist;
                    this.Child3DaysAttendAfterSchoolMultiPicklist = result.DaysAttendAfterSchoolMultiPicklist;
                    if(result.campaignRec.Program__c!=undefined){
                        this.ProgramName = result.campaignRec.Program__r.Name;   this.ProgramId = result.campaignRec.Program__c;
                    }
                    console.log('result.ChildRecord1--->'+result.ChildRecord1);
                    if(result.ChildRecord1!=undefined){                        
                        console.log('result.ChildRecord1 inner--->'+result.ChildRecord1);    
                        this.isChild1Entered = true;   this.Child1RecordId = result.ChildRecord1.Id;
                        this.Child1FirstName= result.ChildRecord1.FirstName;
                        if(this.Child1FirstName==undefined){   this.Child1FirstName = '';}
                        this.Child1LastName= result.ChildRecord1.LastName;
                        if(this.Child1LastName==undefined){this.Child1LastName = '';}
                        this.Child1Birthday=result.ChildRecord1.Birthdate;
                        if(this.Child1Birthday==undefined){this.Child1Birthday = '';}   console.log('1 '+result.ChildRecord1.Birthdate);
                        this.Child1Age=result.ChildRecord1.Age__c;
                        if(this.Child1Age==undefined){this.Child1Age = '';}
                        this.Child1SSN=result.ChildRecord1.SSN__c;
                        if(this.Child1SSN==undefined){this.Child1SSN = '';}
                        console.log('test--->'+result.ChildRecord1.School__c);
                        if(result.ChildRecord1.School__c!=undefined){console.log('asdf'+result.Child1SchoolName);
                            this.Child1School=result.ChildRecord1.School__c;    this.school1name = result.Child1SchoolName;}      
                        if(this.Child1School==undefined){this.Child1School = '';}                 
                        this.Child1Grade=result.ChildRecord1.Grade__c;
                        if(this.Child1Grade==undefined){this.Child1Grade = '';}  
                        this.EmergencyContactFirst=result.ChildRecord1.Emergency_Contact_First__c;
                        if(this.EmergencyContactFirst==undefined){this.EmergencyContactFirst = '';}
                        this.EmergencyContactLast=result.ChildRecord1.Emergency_Contact_Last__c;
                        if(this.EmergencyContactLast==undefined){this.EmergencyContactLast = '';}
                        this.EmergencyContactRelationShip=result.ChildRecord1.Emergency_Contact_Relationship__c;
                        if(this.EmergencyContactRelationShip==undefined){this.EmergencyContactRelationShip = '';}
                        this.EmergencyPhone=result.ChildRecord1.Emergency_Contact_Phone__c;
                        if(this.EmergencyPhone==undefined){this.EmergencyPhone = '';}
                        this.EmergencyCellPhone=result.ChildRecord1.Emergency_Contact_Cell_Phone__c;
                        if(this.EmergencyCellPhone==undefined){this.EmergencyCellPhone = '';}
                        this.ApprovedPickUp1=result.ChildRecord1.Approved_Pick_Up_1__c;
                        if(this.ApprovedPickUp1==undefined){this.ApprovedPickUp1 = '';}
                        this.ApprovedPickup1Relationship=result.ChildRecord1.Approved_Pick_Up_1_Relationship__c;
                        if(this.ApprovedPickup1Relationship==undefined){this.ApprovedPickup1Relationship = '';}
                        this.ApprovedPickUp1Phone=result.ChildRecord1.Approved_Pick_Up_1_Phone__c;
                        if(this.ApprovedPickUp1Phone==undefined){this.ApprovedPickUp1Phone = '';}
                        this.ApprovedPickUp2=result.ChildRecord1.Approved_Pick_Up_2__c;
                        if(this.ApprovedPickUp2==undefined){this.ApprovedPickUp2 = '';}
                        this.ApprovedPickup2Relationship=result.ChildRecord1.Approved_Pick_Up_2_Relationship__c;
                        if(this.ApprovedPickup2Relationship==undefined){this.ApprovedPickup2Relationship = '';}
                        this.ApprovedPickUp2Phone=result.ChildRecord1.Approved_Pick_Up_2_Phone__c;
                        if(this.ApprovedPickUp2Phone==undefined){this.ApprovedPickUp2Phone = '';}
                        this.Child1PhysicianName= result.ChildRecord1.Physician_Name__c;
                        if(this.Child1PhysicianName==undefined){this.Child1PhysicianName = '';}
                        this.Child1PhysicianPhone= result.ChildRecord1.Physician__c;
                        if(this.Child1PhysicianPhone==undefined){this.Child1PhysicianPhone = '';}
                        this.Child1PhysicianInsuranceNumber=result.ChildRecord1.Insurance_Provider__c;
                        if(this.Child1PhysicianInsuranceNumber==undefined){this.Child1PhysicianInsuranceNumber = '';}
                        this.Child1LastPhysical=result.ChildRecord1.Most_Recent_Physical__c;
                        if(this.Child1LastPhysical==undefined){this.Child1LastPhysical = '';}
                        this.Child1LastVisionTest=result.ChildRecord1.Most_Recent_Vision_Exam__c;
                        if(this.Child1LastVisionTest==undefined){this.Child1LastVisionTest = '';}
                        this.Child1LastHearingExam=result.ChildRecord1.Most_Recent_Hearing_Exam__c;
                        if(this.Child1LastHearingExam==undefined){this.Child1LastHearingExam = '';}
                        this.Child1Dental=result.ChildRecord1.Most_Recent_Dental_Exam__c;
                        if(this.Child1Dental==undefined){this.Child1Dental = '';}
                        this.Child1OperationInjuries1=result.ChildRecord1.Operations_Injuries__c;
                        if(this.Child1OperationInjuries1==undefined){this.Child1OperationInjuries1 = '';}
                        if(result.ChildRecord1.Medications__c!=undefined){this.Child1CurrentMedications= result.ChildRecord1.Medications__c;}    
                        if(this.Child1CurrentMedications==undefined){this.Child1CurrentMedications = '';}                  
                        this.Child1SpecialNeeds=result.ChildRecord1.Medical_Needs__c;
                        if(this.Child1SpecialNeeds==undefined){this.Child1SpecialNeeds = '';}  
                        this.Child1TakeMedication = result.ChildRecord1.Takes_Medication__c;
                        if(this.Child1TakeMedication==undefined){this.Child1TakeMedication = '';}
                        this.Child1PhysiciansAdvice=result.ChildRecord1.Physicians_Advice__c;
                        if(this.Child1PhysiciansAdvice==undefined){this.Child1PhysiciansAdvice = '';}
                        this.Child1HaveHad=result.ChildRecord1.Had_illness__c;
                        if(this.Child1HaveHad!=undefined){var ArrChild1HadIllness =this.Child1HaveHad.split(';');
                            if(this.Child1HaveHad!=undefined){var Child1HaveHadValuesTemp=[];
                                for(var i=0;i<ArrChild1HadIllness.length;i++){if(!Child1HaveHadValuesTemp.includes(ArrChild1HadIllness[i])){
                                        Child1HaveHadValuesTemp.push(ArrChild1HadIllness[i]);}
                                }this.Child1IllnessValues = Child1HaveHadValuesTemp;   this.allChild1IllnessMultiPicklistValues = this.Child1IllnessValues;
                            }
                        }
                        this.Child1Allergies = result.ChildRecord1.Allergies__c;
                        if(this.Child1Allergies!=undefined){var ArrChild1Allergies =this.Child1Allergies.split(';');   console.log('1 ArrChild1Allergies  *** '+ArrChild1Allergies);
                            if(this.Child1Allergies!=undefined){var Child1AllergiesValuesTemp=[];
                                for(var i=0;i<ArrChild1Allergies.length;i++){if(!Child1AllergiesValuesTemp.includes(ArrChild1Allergies[i])){
                                        Child1AllergiesValuesTemp.push(ArrChild1Allergies[i]);}
                                }this.Child1AllergiesValues = Child1AllergiesValuesTemp;   this.allChild1AllergiesMultiPicklistValues = this.Child1AllergiesValues;
                            }
                        }
                        this.Child1PhysicianDetails=result.ChildRecord1.MH_History_Detailed__c;
                        if(this.Child1PhysicianDetails==undefined){this.Child1PhysicianDetails = '';}
                        this.Child1AllergiesDetails=result.ChildRecord1.Allergies_Detailed__c;
                        if(this.Child1AllergiesDetails==undefined){this.Child1AllergiesDetails = '';}
                        if(result.ChildRecord1!=undefined){this.Child1AttendAfterSchool=result.ChildRecord1.Child_will_Attend_Afterschool__c;
                            if(this.Child1AttendAfterSchool!=undefined){var ArrChild1AttendSchool =this.Child1AttendAfterSchool.split(';');   console.log('1 ArrChild1AttendSchool  *** '+ArrChild1AttendSchool);
                                if(this.Child1AttendAfterSchool!=undefined){var Child1AttendSchoolValuesTemp=[];
                                    for(var i=0;i<ArrChild1AttendSchool.length;i++){if(!Child1AttendSchoolValuesTemp.includes(ArrChild1AttendSchool[i])){
                                            Child1AttendSchoolValuesTemp.push(ArrChild1AttendSchool[i]);}
                                    }this.Child1AttendSchoolValues=Child1AttendSchoolValuesTemp;
                                    this.allChild1AttendSchoolMultiPicklistValues = this.Child1AttendSchoolValues;}    }
                        }
                    }
                    if(result.ChildRecord2!=undefined){
                        this.isChild2Entered = true;this.Child2FirstName= result.ChildRecord2.FirstName;
                        if(this.Child2FirstName==undefined){this.Child2FirstName = '';}
                        this.Child2LastName= result.ChildRecord2.LastName;
                        if(this.Child2LastName==undefined){this.Child2LastName = '';}
                        this.Child2RecordId = result.ChildRecord2.Id;this.Child2Birthday=result.ChildRecord2.Birthdate;console.log('2 '+result.ChildRecord2.Birthdate);
                        if(this.Child2Birthday==undefined){this.Child2Birthday = '';}
                        this.Child2Age=result.ChildRecord2.Age__c;
                        if(this.Child2Age==undefined){this.Child2Age = '';}
                        this.Child2SSN=result.ChildRecord2.SSN__c;
                        if(this.Child2SSN==undefined){this.Child2SSN = '';}
                        if(result.ChildRecord2.School__c!=undefined){this.Child2School=result.ChildRecord2.School__c;
                            this.school2name = result.Child2SchoolName;console.log('this.Child2School--->'+this.Child2School);console.log('this.school2name--->'+result.Child2SchoolName);}  
                        if(this.Child2School==undefined){this.Child2School = '';}                    
                        this.Child2Grade=result.ChildRecord2.Grade__c;
                        if(this.Child2Grade==undefined){this.Child2Grade = '';}
                        this.Child2PhysicianName= result.ChildRecord2.Physician_Name__c;
                        if(this.Child2PhysicianName==undefined){this.Child2PhysicianName = '';}
                        this.Child2PhysicianPhone= result.ChildRecord2.Physician__c;
                        if(this.Child2PhysicianPhone==undefined){this.Child2PhysicianPhone = '';}
                        this.Child2PhysicianInsuranceNumber=result.ChildRecord2.Insurance_Provider__c;
                        if(this.Child2PhysicianInsuranceNumber==undefined){this.Child2PhysicianInsuranceNumber = '';}
                        this.Child2LastPhysical=result.ChildRecord2.Most_Recent_Physical__c;
                        if(this.Child2LastPhysical==undefined){this.Child2LastPhysical = '';}
                        this.Child2LastVisionTest=result.ChildRecord2.Most_Recent_Vision_Exam__c;
                        if(this.Child2LastVisionTest==undefined){this.Child2LastVisionTest = '';}
                        this.Child2LastHearingExam=result.ChildRecord2.Most_Recent_Hearing_Exam__c;
                        if(this.Child2LastHearingExam==undefined){this.Child2LastHearingExam = '';}
                        this.Child2Dental=result.ChildRecord2.Most_Recent_Dental_Exam__c;
                        if(this.Child2Dental==undefined){this.Child2Dental = '';}
                        this.Child2OperationInjuries1=result.ChildRecord2.Operations_Injuries__c;
                        if(this.Child2OperationInjuries1==undefined){this.Child2OperationInjuries1 = '';}
                        this.Child2CurrentMedications=result.ChildRecord2.Medications__c;
                        if(this.Child2CurrentMedications==undefined){this.Child2CurrentMedications = '';}
                        this.Child2SpecialNeeds=result.ChildRecord2.Medical_Needs__c;
                        if(this.Child2SpecialNeeds==undefined){this.Child2SpecialNeeds = '';}
                        this.Child2TakeMedication = result.ChildRecord2.Takes_Medication__c;
                        if(this.Child2TakeMedication==undefined){this.Child2TakeMedication = '';}
                        this.Child2PhysiciansAdvice=result.ChildRecord2.Physicians_Advice__c;
                        if(this.Child2PhysiciansAdvice==undefined){this.Child2PhysiciansAdvice = '';}
                        this.Child2HaveHad=result.ChildRecord2.Had_illness__c;
                        if(this.Child2HaveHad!=undefined){var ArrChild2HadIllness =this.Child2HaveHad.split(';');console.log('2 ArrChild2HadIllness  *** '+ArrChild2HadIllness);
                            if(this.Child2HaveHad!=undefined){var Child2HaveHadValuesTemp=[];
                                for(var i=0;i<ArrChild2HadIllness.length;i++){if(!Child2HaveHadValuesTemp.includes(ArrChild2HadIllness[i])){Child2HaveHadValuesTemp.push(ArrChild2HadIllness[i]);}}
                                this.Child2IllnessValues = Child2HaveHadValuesTemp;    this.allChild2IllnessMultiPicklistValues = this.Child2IllnessValues;
                            }    
                        }     this.Child2Allergies = result.ChildRecord2.Allergies__c;                
                        if(this.Child2Allergies!=undefined){var ArrChild2Allergies =this.Child2Allergies.split(';');console.log('2 ArrChild2Allergies  *** '+ArrChild2Allergies);
                            if(this.Child2Allergies!=undefined){var Child2AllergiesValuesTemp=[];
                                for(var i=0;i<ArrChild2Allergies.length;i++){if(!Child2AllergiesValuesTemp.includes(ArrChild2Allergies[i])){Child2AllergiesValuesTemp.push(ArrChild2Allergies[i]);}
                                }this.Child2AllergiesValues = Child2AllergiesValuesTemp;this.allChild2AllergiesMultiPicklistValues = this.Child2AllergiesValues;
                            }
                        }this.Child2PhysicianDetails=result.ChildRecord2.MH_History_Detailed__c;
                        if(this.Child2PhysicianDetails==undefined){this.Child2PhysicianDetails = '';}
                        this.Child2AllergiesDetails=result.ChildRecord2.Allergies_Detailed__c;
                        if(this.Child2AllergiesDetails==undefined){this.Child2AllergiesDetails = '';}
                        if(result.ChildRecord2!=undefined){this.Child2AttendAfterSchool=result.ChildRecord2.Child_will_Attend_Afterschool__c;
                            if(this.Child2AttendAfterSchool!=undefined){var ArrChild2AttendSchool =this.Child2AttendAfterSchool.split(';');console.log('1 ArrChild2AttendSchool  *** '+ArrChild2AttendSchool);
                                if(this.Child2AttendAfterSchool!=undefined){var Child2AttendSchoolValuesTemp=[];
                                    for(var i=0;i<ArrChild2AttendSchool.length;i++){if(!Child2AttendSchoolValuesTemp.includes(ArrChild2AttendSchool[i])){Child2AttendSchoolValuesTemp.push(ArrChild2AttendSchool[i]);}}
                                    this.Child2AttendSchoolValues=Child2AttendSchoolValuesTemp;this.allChild2AttendSchoolMultiPicklistValues = this.Child2AttendSchoolValues;
                                }    
                            } 
                        }
                    }
                    if(result.ChildRecord3!=undefined){this.isChild3Entered = true;this.Child3FirstName= result.ChildRecord3.FirstName;
                        if(this.Child3FirstName==undefined){this.Child3FirstName = '';}
                        this.Child3LastName= result.ChildRecord3.LastName;
                        if(this.Child3LastName==undefined){this.Child3LastName = '';}
                        this.Child3RecordId = result.ChildRecord3.Id;this.Child3Birthday=result.ChildRecord3.Birthdate;
                        if(this.Child3Birthday==undefined){this.Child3Birthday = '';}console.log('3 '+result.ChildRecord3.Birthdate);
                        this.Child3Age=result.ChildRecord3.Age__c;
                        if(this.Child3Age==undefined){this.Child3Age = '';}
                        this.Child3SSN=result.ChildRecord3.SSN__c;
                        if(this.Child3SSN==undefined){this.Child3SSN = '';}
                        if(result.ChildRecord3.School__c!=undefined){this.Child3School=result.ChildRecord3.School__c;this.school3name = result.Child3SchoolName;console.log('this.school3name--->'+this.school3name);} 
                        if(this.Child3School==undefined){this.Child3School = '';}                       
                        this.Child3Grade=result.ChildRecord3.Grade__c;
                        if(this.Child3Grade==undefined){this.Child3Grade = '';}  
                        this.Child3PhysicianName= result.ChildRecord3.Physician_Name__c;
                        if(this.Child3PhysicianName==undefined){this.Child3PhysicianName = '';} 
                        this.Child3PhysicianPhone= result.ChildRecord3.Physician__c;
                        if(this.Child3PhysicianPhone==undefined){this.Child3PhysicianPhone = '';} 
                        this.Child3PhysicianInsuranceNumber= result.ChildRecord3.Insurance_Provider__c;
                        if(this.Child3PhysicianInsuranceNumber==undefined){this.Child3PhysicianInsuranceNumber = '';} 
                        this.Child3LastPhysical=result.ChildRecord3.Most_Recent_Physical__c;
                        if(this.Child3LastPhysical==undefined){this.Child3LastPhysical = '';}
                        this.Child3LastVisionTest=result.ChildRecord3.Most_Recent_Vision_Exam__c;
                        if(this.Child3LastVisionTest==undefined){this.Child3LastVisionTest = '';}
                        this.Child3LastHearingExam=result.ChildRecord3.Most_Recent_Hearing_Exam__c;
                        if(this.Child3LastHearingExam==undefined){this.Child3LastHearingExam = '';}
                        this.Child3Dental=result.ChildRecord3.Most_Recent_Dental_Exam__c;
                        if(this.Child3Dental==undefined){this.Child3Dental = '';}
                        this.Child3OperationInjuries1=result.ChildRecord3.Operations_Injuries__c;
                        if(this.Child3OperationInjuries1==undefined){this.Child3OperationInjuries1 = '';}
                        this.Child3CurrentMedications=result.ChildRecord3.Medications__c;
                        if(this.Child3CurrentMedications==undefined){this.Child3CurrentMedications = '';}
                        this.Child3SpecialNeeds=result.ChildRecord3.Medical_Needs__c;
                        if(this.Child3SpecialNeeds==undefined){this.Child3SpecialNeeds = '';}
                        this.Child3PhysiciansAdvice=result.ChildRecord3.Physicians_Advice__c;
                        if(this.Child3PhysiciansAdvice==undefined){this.Child3PhysiciansAdvice = '';}
                        this.Child3TakeMedication = result.ChildRecord3.Takes_Medication__c;
                        if(this.Child3TakeMedication==undefined){this.Child3TakeMedication = '';}
                        this.Child3HaveHad=result.ChildRecord3.Had_illness__c;
                        if(this.Child3HaveHad!=undefined){var ArrChild3HadIllness =this.Child3HaveHad.split(';');console.log('3 ArrChild3HadIllness  *** '+ArrChild3HadIllness);
                            if(this.Child3HaveHad!=undefined){var Child3HaveHadValuesTemp=[];
                                for(var i=0;i<ArrChild3HadIllness.length;i++){if(!Child3HaveHadValuesTemp.includes(ArrChild3HadIllness[i])){Child3HaveHadValuesTemp.push(ArrChild3HadIllness[i]);}
                                }this.Child3IllnessValues = Child3HaveHadValuesTemp;this.allChild3IllnessMultiPicklistValues = this.Child3IllnessValues;
                            }    
                        }
                        this.Child3Allergies = result.ChildRecord3.Allergies__c;
                        if(this.Child3Allergies!=undefined){var ArrChild3Allergies =this.Child3Allergies.split(';');console.log('3 ArrChild3Allergies  *** '+ArrChild3Allergies);
                            if(this.Child3Allergies!=undefined){var Child3AllergiesValuesTemp=[];
                                for(var i=0;i<ArrChild3Allergies.length;i++){if(!Child3AllergiesValuesTemp.includes(ArrChild3Allergies[i])){Child3AllergiesValuesTemp.push(ArrChild3Allergies[i]);}}
                                this.Child3AllergiesValues = Child3AllergiesValuesTemp;this.allChild3AllergiesMultiPicklistValues = this.Child3AllergiesValues;
                            }                            
                        }this.Child3PhysicianDetails=result.ChildRecord3.MH_History_Detailed__c;
                        if(this.Child3PhysicianDetails==undefined){this.Child3PhysicianDetails = '';}
                        this.Child3AllergiesDetails=result.ChildRecord3.Allergies_Detailed__c;
                        if(this.Child3AllergiesDetails==undefined){this.Child3AllergiesDetails = '';}
                        if(result.ChildRecord3!=undefined){this.Child3AttendAfterSchool=result.ChildRecord3.Child_will_Attend_Afterschool__c;
                            if(this.Child3AttendAfterSchool!=undefined){var ArrChild3AttendSchool =this.Child3AttendAfterSchool.split(';');console.log('1 ArrChild3AttendSchool  *** '+ArrChild3AttendSchool);
                                if(this.Child3AttendAfterSchool!=undefined){var Child3AttendSchoolValuesTemp=[];
                                    for(var i=0;i<ArrChild3AttendSchool.length;i++){if(!Child3AttendSchoolValuesTemp.includes(ArrChild3AttendSchool[i])){Child3AttendSchoolValuesTemp.push(ArrChild3AttendSchool[i]);}}
                                    this.Child3AttendSchoolValues=Child3AttendSchoolValuesTemp;this.allChild3AttendSchoolMultiPicklistValues = this.Child3AttendSchoolValues;
                                }    
                            }   
                        } 
                    }
                    if(result.ParentRecord1!=undefined){this.isParent1Entered = true;/*this.Parent1AccountId = result.ParentRecord1.accountId;*/this.PIN = result.ParentRecord1.PIN__c;
                        this.HowDoYouHearAboutUs = result.ParentRecord1.How_do_you_hear_about_us__c;console.log('result.How_do_you_hear_about_us__c---->'+result.HowDoYouHearAboutUs);
                        if(this.HowDoYouHearAboutUs==undefined){this.HowDoYouHearAboutUs = '';}
                        this.Parent1FirstName= result.ParentRecord1.FirstName;
                        if(this.Parent1FirstName==undefined){this.Parent1FirstName = '';}
                        this.Parent1LastName= result.ParentRecord1.LastName;
                        if(this.Parent1LastName==undefined){this.Parent1LastName = '';}
                        this.ParentFirstLastName = this.Parent1FirstName+' '+this.Parent1LastName;//this.Parent1AccountId = result.ParentRecord1.accountId;//console.log('Parent1AccountId---->'+this.Parent1AccountId);
                        this.Parent1Relationship=result.ParentRecord1.Primary_Guardian_Relationship__c;
                        if(this.Parent1Relationship==undefined){this.Parent1Relationship = '';}
                        this.Parent1Address=result.ParentRecord1.MailingStreet;
                        if(this.Parent1Address==undefined){this.Parent1Address = '';}
                        this.Parent1City=result.ParentRecord1.MailingCity;
                        if(this.Parent1City==undefined){this.Parent1City = '';}
                        this.Parent1State=result.ParentRecord1.MailingState;
                        if(this.Parent1State==undefined){this.Parent1State = '';}
                        this.Parent1ZipCode=result.ParentRecord1.MailingPostalCode;
                        if(this.Parent1ZipCode==undefined){this.Parent1ZipCode = '';}
                        this.Parent1PlaceOfEmp=result.ParentRecord1.Place_of_Employment__c;
                        if(this.Parent1PlaceOfEmp==undefined){this.Parent1PlaceOfEmp = '';}
                        this.Parent1HomePhone=result.ParentRecord1.Phone;
                        if(this.Parent1HomePhone==undefined){this.Parent1HomePhone = '';}
                        this.Parent1CellPhone=result.ParentRecord1.MobilePhone;
                        if(this.Parent1CellPhone==undefined){this.Parent1CellPhone = '';}
                        this.Parent1WorkPhone=result.ParentRecord1.npe01__WorkPhone__c;
                        if(this.Parent1WorkPhone==undefined){this.Parent1WorkPhone = '';}
                        this.Parent1emailAddress=result.ParentRecord1.Email;
                        if(this.Parent1emailAddress==undefined){this.Parent1emailAddress = '';}
                        this.Parent1MonthlyIncome=result.ParentRecord1.Household_Monthly_Income__c;
                        if(this.Parent1MonthlyIncome==undefined){this.Parent1MonthlyIncome = '';}
                        this.Parent1SourceIncome=result.ParentRecord1.Source_of_Income__c;                         console.log('this.Parent1SourceIncome ***'+this.Parent1SourceIncome);
                        if(this.Parent1SourceIncome!=undefined){var ArrParent1SourceOfIncome =this.Parent1SourceIncome.split(';');console.log('ArrParent1SourceOfIncome 915  *** '+ArrParent1SourceOfIncome);
                            this.allParent1MultiPicklistValues =[];console.log( this.allParent1MultiPicklistValues+' *** allParent1MultiPicklistValues ***' );
                            if(this.Parent1SourceIncome!=undefined){var Parent1SourceIncomeValuesTemp=[];
                                for(var i=0;i<ArrParent1SourceOfIncome.length;i++){if(!Parent1SourceIncomeValuesTemp.includes(ArrParent1SourceOfIncome[i])){Parent1SourceIncomeValuesTemp.push(ArrParent1SourceOfIncome[i]);}
                                }this.Parent1SourceIncomeValues = Parent1SourceIncomeValuesTemp;this.allParent1MultiPicklistValues = this.Parent1SourceIncomeValues;
                            }
                        }this.Parent1PublicAssistance=result.ParentRecord1.Receive_Public_Assistance__c; 
                        if(this.Parent1PublicAssistance==undefined){this.Parent1PublicAssistance = '';}
                        this.Parent1HousingType=result.ParentRecord1.Housing_Type__c;
                        if(this.Parent1HousingType==undefined){this.Parent1HousingType = '';}
                        this.Parent1HousingOwnerShip=result.ParentRecord1.Housing_Ownership__c;
                        if(this.Parent1HousingOwnerShip==undefined){this.Parent1HousingOwnerShip = '';}
                        this.Parent1TimeInResidence=result.ParentRecord1.Time_In_Residence__c;
                        if(this.Parent1TimeInResidence==undefined){this.Parent1TimeInResidence = '';}
                    }
                   if(result.ParentRecord2!=undefined){this.isParent2Entered = true;this.Parent2RecordId = result.ParentRecord2.Id;this.Parent2LastName= result.ParentRecord2.LastName;
                        if(this.Parent2LastName==undefined){this.Parent2LastName = '';}
                        this.Parent2FirstName= result.ParentRecord2.FirstName;                      
                        if(this.Parent2FirstName==undefined){this.Parent2FirstName = '';}
                        this.Parent2Relationship=result.ParentRecord2.Primary_Guardian_Relationship__c;
                        if(this.Parent2Relationship==undefined){this.Parent2Relationship = '';}
                        this.Parent2Address=result.ParentRecord2.MailingStreet;
                        if(this.Parent2Address==undefined){this.Parent2Address = '';}
                        this.Parent2City=result.ParentRecord2.MailingCity;
                        if(this.Parent2City==undefined){this.Parent2City = '';}
                        this.Parent2State=result.ParentRecord2.MailingState;
                        if(this.Parent2State==undefined){this.Parent2State = '';}
                        this.Parent2ZipCode=result.ParentRecord2.MailingPostalCode;
                        if(this.Parent2ZipCode==undefined){this.Parent2ZipCode = '';}
                        this.Parent2PlaceOfEmp=result.ParentRecord2.Place_of_Employment__c;
                        if(this.Parent2PlaceOfEmp==undefined){this.Parent2PlaceOfEmp = '';}
                        this.Parent2HomePhone=result.ParentRecord2.Phone;
                        if(this.Parent2HomePhone==undefined){this.Parent2HomePhone = '';}
                        this.Parent2CellPhone=result.ParentRecord2.MobilePhone;
                        if(this.Parent2CellPhone==undefined){this.Parent2CellPhone = '';}
                        this.Parent2WorkPhone=result.ParentRecord2.npe01__WorkPhone__c;
                        if(this.Parent2WorkPhone==undefined){this.Parent2WorkPhone = '';}
                        this.Parent2emailAddress=result.ParentRecord2.Email;
                        if(this.Parent2emailAddress==undefined){this.Parent2emailAddress = '';}
                        this.Parent2MonthlyIncome=result.ParentRecord2.Household_Monthly_Income__c;
                        if(this.Parent2MonthlyIncome==undefined){this.Parent2MonthlyIncome = '';}
                        this.Parent2SourceIncome=result.ParentRecord2.Source_of_Income__c; console.log('this.Parent2SourceIncome ***'+this.Parent2SourceIncome);
                        if(this.Parent2SourceIncome!=undefined){var ArrParent2SourceOfIncome =this.Parent2SourceIncome.split(';');console.log('ArrParent1SourceOfIncome  *** '+ArrParent2SourceOfIncome);
                            this.allParent2MultiPicklistValues =[];console.log( this.allParent1MultiPicklistValues+' *** allParent1MultiPicklistValues ***' );
                            if(this.Parent2SourceIncome!=undefined){var Parent2SourceIncomeValuesTemp=[];
                                for(var i=0;i<ArrParent2SourceOfIncome.length;i++){if(!Parent2SourceIncomeValuesTemp.includes(ArrParent2SourceOfIncome[i])){Parent2SourceIncomeValuesTemp.push(ArrParent2SourceOfIncome[i]);}
                                }this.Parent2SourceIncomeValues = Parent2SourceIncomeValuesTemp;this.allParent2MultiPicklistValues = this.Parent2SourceIncomeValues;
                            }  
                        }this.Parent2PublicAssistance=result.ParentRecord2.Receive_Public_Assistance__c; 
                        if(this.Parent2PublicAssistance==undefined){this.Parent2PublicAssistance = '';}
                        this.Parent2HousingType=result.ParentRecord1.Housing_Type__c;
                        if(this.Parent2HousingType==undefined){this.Parent2HousingType = '';}
                        this.Parent2HousingOwnerShip=result.ParentRecord1.Housing_Ownership__c;
                        if(this.Parent2HousingOwnerShip==undefined){this.Parent2HousingOwnerShip = '';}
                        this.Parent2TimeInResidence=result.ParentRecord2.Time_In_Residence__c;
                        if(this.Parent2TimeInResidence==undefined){this.Parent2TimeInResidence = '';}
                   }
                }
            }
        })
        .catch(error => {
            this.message = undefined; this.error = error; console.log('error'+error);  this.successMessage = false;  this.successMessage1 = false;  this.errorMessage = true; 
        });
    }
    
    handleChild1OnChange(event){
        this.refreshMessages(); this.isChild1Entered = true;
        if(event.target.name=='Child1FirstName'){this.Child1FirstName = event.target.value;}
        else if(event.target.name=='Child1LastName'){this.Child1LastName = event.target.value;}
        else if(event.target.name=='Child1Birthday'){this.Child1Birthday = event.target.value;}
        else if(event.target.name=='Child1SSN'){this.Child1SSN = event.target.value;}
        else if(event.target.name=='Child1Grade'){this.Child1Grade = event.target.value;}
        else if(event.target.name=='Child1PhysicianName'){this.Child1PhysicianName = event.target.value;}
        else if(event.target.name=='Child1PhysicianPhone'){this.Child1PhysicianPhone = event.target.value;}
        else if(event.target.name=='Child1PhysicianInsuranceNumber'){this.Child1PhysicianInsuranceNumber = event.target.value;}
        else if(event.target.name=='Child1LastPhysical'){this.Child1LastPhysical = event.target.value;}
        else if(event.target.name=='Child1LastVisionTest'){this.Child1LastVisionTest = event.target.value;}
        else if(event.target.name=='Child1LastHearingExam'){this.Child1LastHearingExam = event.target.value;}
        else if(event.target.name=='Child1Dental'){this.Child1Dental = event.target.value;}
        else if(event.target.name=='Child1OperationInjuries1'){this.Child1OperationInjuries1 = event.target.value;}
        else if(event.target.name=='Child1SpecialNeeds'){this.Child1SpecialNeeds = event.target.value;}
        else if(event.target.name=='Child1CurrentMedications'){this.Child1CurrentMedications = event.target.value;}
        else if(event.target.name=='Child1TakeMedication'){this.Child1TakeMedication = event.target.value;}
        else if(event.target.name=='Child1PhysiciansAdvice'){this.Child1PhysiciansAdvice = event.target.value;}
        else if(event.target.name=='Child1PhysicianDetails'){this.Child1PhysicianDetails = event.target.value;}
        else if(event.target.name=='Child1AllergiesDetails'){this.Child1AllergiesDetails = event.target.value;}
    }
    @track isChild2Entered=false;
    handleChild2OnChange(event){
        this.refreshMessages();this.isChild2Entered = true;
        if(event.target.name=='Child2FirstName'){this.Child2FirstName = event.target.value;}
        else if(event.target.name=='Child2LastName'){this.Child2LastName = event.target.value;}
        else if(event.target.name=='Child2Birthday'){this.Child2Birthday = event.target.value;}
        else if(event.target.name=='Child2SSN'){this.Child2SSN = event.target.value;}
        else if(event.target.name=='Child2Grade'){this.Child2Grade = event.target.value;}
        else if(event.target.name=='Child2PhysicianName'){this.Child2PhysicianName = event.target.value;}
        else if(event.target.name=='Child2PhysicianPhone'){this.Child2PhysicianPhone = event.target.value;}
        else if(event.target.name=='Child2PhysicianInsuranceNumber'){this.Child2PhysicianInsuranceNumber = event.target.value;}
        else if(event.target.name=='Child2LastPhysical'){this.Child2LastPhysical = event.target.value;}
        else if(event.target.name=='Child2LastVisionTest'){this.Child2LastVisionTest = event.target.value;}
        else if(event.target.name=='Child2LastHearingExam'){this.Child2LastHearingExam = event.target.value;}
        else if(event.target.name=='Child2Dental'){this.Child2Dental = event.target.value;}
        else if(event.target.name=='Child2OperationInjuries1'){this.Child2OperationInjuries1 = event.target.value;}
        else if(event.target.name=='Child2SpecialNeeds'){this.Child2SpecialNeeds = event.target.value;}
        else if(event.target.name=='Child2CurrentMedications'){this.Child2CurrentMedications = event.target.value;}
        else if(event.target.name=='Child2TakeMedication'){this.Child2TakeMedication = event.target.value;}
        else if(event.target.name=='Child2PhysiciansAdvice'){this.Child2PhysiciansAdvice = event.target.value;}
        else if(event.target.name=='Child2PhysicianDetails'){this.Child2PhysicianDetails = event.target.value;}
        else if(event.target.name=='Child2AllergiesDetails'){this.Child2AllergiesDetails = event.target.value;}
    }
    @track isChild3Entered=false;
    handleChild3OnChange(event){
        this.refreshMessages();        this.isChild3Entered = true;
        if(event.target.name=='Child3FirstName'){this.Child3FirstName = event.target.value;}
        else if(event.target.name=='Child3LastName'){this.Child3LastName = event.target.value;  }
        else if(event.target.name=='Child3Birthday'){this.Child3Birthday = event.target.value;}
        else if(event.target.name=='Child3SSN'){this.Child3SSN = event.target.value;}
        else if(event.target.name=='Child3Grade'){this.Child3Grade = event.target.value;}
        else if(event.target.name=='Child3PhysicianName'){this.Child3PhysicianName = event.target.value;}
        else if(event.target.name=='Child3PhysicianPhone'){this.Child3PhysicianPhone = event.target.value;}
        else if(event.target.name=='Child3PhysicianInsuranceNumber'){this.Child3PhysicianInsuranceNumber = event.target.value;}
        else if(event.target.name=='Child3LastPhysical'){this.Child3LastPhysical = event.target.value;}
        else if(event.target.name=='Child3LastVisionTest'){this.Child3LastVisionTest = event.target.value;}
        else if(event.target.name=='Child3LastHearingExam'){this.Child3LastHearingExam = event.target.value;}
        else if(event.target.name=='Child3Dental'){this.Child3Dental = event.target.value;}
        else if(event.target.name=='Child3OperationInjuries1'){this.Child3OperationInjuries1 = event.target.value;}
        else if(event.target.name=='Child3SpecialNeeds'){this.Child3SpecialNeeds = event.target.value;}
        else if(event.target.name=='Child3CurrentMedications'){this.Child3CurrentMedications = event.target.value;}
        else if(event.target.name=='Child3TakeMedication'){this.Child3TakeMedication = event.target.value;}
        else if(event.target.name=='Child3PhysiciansAdvice'){this.Child3PhysiciansAdvice = event.target.value;}
        else if(event.target.name=='Child3PhysicianDetails'){this.Child3PhysicianDetails = event.target.value;}
        else if(event.target.name=='Child3AllergiesDetails'){this.Child3AllergiesDetails = event.target.value; }
    }
    @track isParent1Entered=false;
    handleParent1OnChange(event){
        this.refreshMessages();        this.isParent1Entered = true;
        if(event.target.name=='Parent1FirstName'){this.Parent1FirstName = event.target.value;}
        else if(event.target.name=='Parent1LastName'){this.Parent1LastName = event.target.value;}
        else if(event.target.name=='Parent1Relationship'){this.Parent1Relationship = event.target.value;}
        else if(event.target.name=='Parent1Address'){this.Parent1Address = event.target.value;}
        else if(event.target.name=='Parent1City'){this.Parent1City = event.target.value;}
        else if(event.target.name=='Parent1State'){this.Parent1State = event.target.value;}
        else if(event.target.name=='Parent1ZipCode'){this.Parent1ZipCode = event.target.value;}
        else if(event.target.name=='Parent1PlaceOfEmp'){this.Parent1PlaceOfEmp = event.target.value;}
        else if(event.target.name=='Parent1HomePhone'){this.Parent1HomePhone = event.target.value;}
        else if(event.target.name=='Parent1CellPhone'){this.Parent1CellPhone = event.target.value;}
        else if(event.target.name=='Parent1WorkPhone'){this.Parent1WorkPhone = event.target.value;}
        else if(event.target.name=='Parent1emailAddress'){this.Parent1emailAddress = event.target.value;}
        else if(event.target.name=='Parent1MonthlyIncome'){this.Parent1MonthlyIncome = event.target.value;}
        else if(event.target.name=='Parent1SourceIncome'){this.Parent1SourceIncome = event.target.value;}
        else if(event.target.name=='Parent1PublicAssistance'){this.Parent1PublicAssistance = event.target.value;}
        else if(event.target.name=='Parent1HousingType'){this.Parent1HousingType = event.target.value;}
        else if(event.target.name=='Parent1HousingOwnerShip'){this.Parent1HousingOwnerShip = event.target.value;}
        else if(event.target.name=='Parent1TimeInResidence'){this.Parent1TimeInResidence = event.target.value;}
    }
    @track isParent2Entered=false;
    handleParent2OnChange(event){
        this.refreshMessages();        this.isParent2Entered = true;
        if(event.target.name=='Parent2FirstName'){this.Parent2FirstName = event.target.value;}
        else if(event.target.name=='Parent2LastName'){this.Parent2LastName = event.target.value;}
        else if(event.target.name=='Parent2Relationship'){this.Parent2Relationship = event.target.value;}
        else if(event.target.name=='Parent2Address'){this.Parent2Address = event.target.value;}
        else if(event.target.name=='Parent2City'){this.Parent2City = event.target.value;}
        else if(event.target.name=='Parent2State'){this.Parent2State = event.target.value;}
        else if(event.target.name=='Parent2ZipCode'){this.Parent2ZipCode = event.target.value;}
        else if(event.target.name=='Parent2PlaceOfEmp'){this.Parent2PlaceOfEmp = event.target.value;}
        else if(event.target.name=='Parent2HomePhone'){this.Parent2HomePhone = event.target.value;}
        else if(event.target.name=='Parent2CellPhone'){this.Parent2CellPhone = event.target.value;}
        else if(event.target.name=='Parent2WorkPhone'){this.Parent2WorkPhone = event.target.value;}
        else if(event.target.name=='Parent2emailAddress'){this.Parent2emailAddress = event.target.value;}
        else if(event.target.name=='Parent2MonthlyIncome'){this.Parent2MonthlyIncome = event.target.value;}
        else if(event.target.name=='Parent2SourceIncome'){this.Parent2SourceIncome = event.target.value;}
        else if(event.target.name=='Parent2PublicAssistance'){this.Parent2PublicAssistance = event.target.value;}
        else if(event.target.name=='Parent2HousingType'){this.Parent2HousingType = event.target.value;}
        else if(event.target.name=='Parent2HousingOwnerShip'){this.Parent2HousingOwnerShip = event.target.value;}
        else if(event.target.name=='Parent2TimeInResidence'){this.Parent2TimeInResidence = event.target.value;}
    }
    handleEmergencyContactOnChange(event){
        this.refreshMessages(); if(event.target.name=='EmergencyContactFirst'){this.EmergencyContactFirst = event.target.value;}        
        else if(event.target.name=='EmergencyContactLast'){this.EmergencyContactLast = event.target.value;}        
        else if(event.target.name=='EmergencyContactRelationShip'){this.EmergencyContactRelationShip = event.target.value;}        
        else if(event.target.name=='EmergencyPhone'){this.EmergencyPhone = event.target.value;}        
        else if(event.target.name=='EmergencyCellPhone'){this.EmergencyCellPhone = event.target.value;}        
        else if(event.target.name=='ApprovedPickUp1'){this.ApprovedPickUp1 = event.target.value;}        
        else if(event.target.name=='ApprovedPickup1Relationship'){this.ApprovedPickup1Relationship = event.target.value;}        
        else if(event.target.name=='ApprovedPickUp1Phone'){this.ApprovedPickUp1Phone = event.target.value;}        
        else if(event.target.name=='ApprovedPickUp2'){this.ApprovedPickUp2 = event.target.value;}        
        else if(event.target.name=='ApprovedPickup2Relationship'){this.ApprovedPickup2Relationship = event.target.value;}        
        else if(event.target.name=='ApprovedPickUp2Phone'){this.ApprovedPickUp2Phone = event.target.value;}   
    }

    convertMultipicklistValueToStringSaveHelper(picklistValues){
        var multiPicklistValues='';
        for(var i=0;i<picklistValues.length;i++){
            if(multiPicklistValues ==''){ multiPicklistValues=picklistValues[i]; }
            else{ multiPicklistValues=multiPicklistValues+';'+picklistValues[i]; }
        }  
        console.log('multiPicklistValues--->'+multiPicklistValues);
        return multiPicklistValues;
    }

     
    handleSubmitForm(){
  

        this.isLoaded =true; this.successMessage = false; this.successMessage1 = false; this.errorMessage = false; this.errorMessage1 = false;this.alertMessage='';
        /*this.showChild1Info=true; this.Child1TabClickCount=0;  this.showChild2Info=true;  this.Child2TabClickCount=0; this.showChild3Info=true;  this.Child3TabClickCount=0;*/
        let Child1Record = { 'sobjectType': 'Contact' }; 
        Child1Record.FirstName = this.Child1FirstName;        console.log('Child1FirstName---->'+this.Child1FirstName);
        Child1Record.LastName = this.Child1LastName;        console.log('Child1LastName---->'+this.Child1LastName);
        Child1Record.Birthdate = this.Child1Birthday;        console.log('Child1Birthday---->'+this.Child1Birthday);
        Child1Record.SSN__c = this.Child1SSN;        console.log('SSN__c--->'+this.Child1SSN);
        Child1Record.School__c = this.Child1School;        console.log('Child1School--->'+this.Child1School);
        Child1Record.Grade__c = this.Child1Grade;        console.log('Grade__c--->'+this.Child1Grade);
        Child1Record.Physician_Name__c = this.Child1PhysicianName;        console.log('Physician_Name__c--->'+this.Child1PhysicianName);
        Child1Record.Physician__c = this.Child1PhysicianPhone;        console.log('Physician__c--->'+this.Child1PhysicianPhone);
        Child1Record.Insurance_Provider__c = this.Child1PhysicianInsuranceNumber;        console.log('Insurance_Provider__c--->'+this.Child1PhysicianInsuranceNumber);
        Child1Record.Most_Recent_Physical__c = this.Child1LastPhysical;        console.log('PhysicMost_Recent_Physical__cian_Name__c--->'+this.Child1LastPhysical);
        Child1Record.Most_Recent_Vision_Exam__c = this.Child1LastVisionTest;           console.log('Most_Recent_Vision_Exam__c--->'+this.Child1LastVisionTest);     
        Child1Record.Most_Recent_Hearing_Exam__c = this.Child1LastHearingExam;        console.log('Most_Recent_Hearing_Exam__c--->'+this.Child1LastHearingExam);
        Child1Record.Most_Recent_Dental_Exam__c = this.Child1Dental;        console.log('Most_Recent_Dental_Exam__c--->'+this.Child1Dental);
        Child1Record.Operations_Injuries__c = this.Child1OperationInjuries1;        console.log('Operations_Injuries__c--->'+this.Child1OperationInjuries1);
        Child1Record.Medical_Needs__c = this.Child1SpecialNeeds;        console.log('Medical_Needs__c--->'+this.Child1SpecialNeeds);
        Child1Record.Medications__c = this.Child1CurrentMedications;        console.log('Medications__c--->'+this.Child1CurrentMedications);        
        Child1Record.Takes_Medication__c = this.Child1TakeMedication;        console.log('Takes_Medication__c--->'+this.Child1TakeMedication);
        Child1Record.Physicians_Advice__c = this.Child1PhysiciansAdvice;        console.log('Physicians_Advice__c--->'+this.Child1PhysiciansAdvice);
        var Child1HaveHadIllness='';
        Child1HaveHadIllness = this.convertMultipicklistValueToStringSaveHelper(this.allChild1IllnessMultiPicklistValues);         
        Child1Record.Had_illness__c = Child1HaveHadIllness;        console.log('Had_illness__c--->'+Child1Record.Had_illness__c);
        Child1Record.MH_History_Detailed__c = this.Child1PhysicianDetails;        console.log('MH_History_Detailed__c--->'+this.Child1PhysicianDetails);
        var Child1Allergies='';
        Child1Allergies = this.convertMultipicklistValueToStringSaveHelper(this.allChild1AllergiesMultiPicklistValues);         
        Child1Record.Allergies__c = Child1Allergies;        console.log('Allergies__c--->'+Child1Record.Allergies__c);
        Child1Record.Allergies_Detailed__c = this.Child1AllergiesDetails;        console.log('Allergies_Detailed__c--->'+this.Child1AllergiesDetails);
        var Child1ChildWillAttendAfterSchool='';
        Child1ChildWillAttendAfterSchool = this.convertMultipicklistValueToStringSaveHelper(this.allChild1AttendSchoolMultiPicklistValues);         
        Child1Record.Child_will_Attend_Afterschool__c = Child1ChildWillAttendAfterSchool;        console.log('Child_will_Attend_Afterschool__c--->'+Child1Record.Child_will_Attend_Afterschool__c);
        Child1Record.Emergency_Contact_First__c = this.EmergencyContactFirst;        console.log('Emergency_Contact_Last__c--->'+this.EmergencyContactFirst);
        Child1Record.Emergency_Contact_Last__c = this.EmergencyContactLast;        console.log('Emergency_Contact_Last__c--->'+this.EmergencyContactLast);    
        Child1Record.Emergency_Contact_Relationship__c = this.EmergencyContactRelationShip;        console.log('Emergency_Contact_Relationship__c--->'+this.EmergencyContactRelationShip);       
        Child1Record.Emergency_Contact_Phone__c = this.EmergencyPhone;        console.log('Emergency_Contact_Phone__c--->'+this.EmergencyPhone);       
        Child1Record.Emergency_Contact_Cell_Phone__c = this.EmergencyCellPhone;        console.log('Emergency_Contact_Cell_Phone__c--->'+this.EmergencyCellPhone);       
        Child1Record.Approved_Pick_Up_1__c = this.ApprovedPickUp1;        console.log('Approved_Pick_Up_1__c--->'+this.ApprovedPickUp1);       
        Child1Record.Approved_Pick_Up_1_Relationship__c = this.ApprovedPickup1Relationship;        console.log('Approved_Pick_Up_1_Relationship__c--->'+this.ApprovedPickup1Relationship);       
        Child1Record.Approved_Pick_Up_1_Phone__c = this.ApprovedPickUp1Phone;        console.log('Approved_Pick_Up_1_Phone__c--->'+this.ApprovedPickUp1Phone);       
        Child1Record.Approved_Pick_Up_2__c = this.ApprovedPickUp2;        console.log('Approved_Pick_Up_2__c--->'+this.ApprovedPickUp2);       
        Child1Record.Approved_Pick_Up_2_Relationship__c = this.ApprovedPickup2Relationship;        console.log('Approved_Pick_Up_2_Relationship__c--->'+this.ApprovedPickup2Relationship);       
        Child1Record.Approved_Pick_Up_2_Phone__c = this.ApprovedPickUp2Phone;        console.log('Approved_Pick_Up_2_Phone__c--->'+this.ApprovedPickUp2Phone);               
        let Child2Record = { 'sobjectType': 'Contact' }; 
        Child2Record.FirstName = this.Child2FirstName;        console.log('Child2FirstName---->'+this.Child2FirstName);
        Child2Record.LastName = this.Child2LastName;        console.log('Child2LastName---->'+this.Child2LastName);
        Child2Record.Birthdate = this.Child2Birthday;        console.log('Child2Birthday---->'+this.Child2Birthday);
        Child2Record.SSN__c = this.Child2SSN;        console.log('SSN__c--->'+this.Child2SSN);
        Child2Record.School__c = this.Child2School;        console.log('Child2School--->'+this.Child2School);
        Child2Record.Grade__c = this.Child2Grade;        console.log('Grade__c--->'+this.Child2Grade);
        Child2Record.Physician_Name__c = this.Child2PhysicianName;        console.log('Physician_Name__c--->'+this.Child2PhysicianName);
        Child2Record.Physician__c = this.Child2PhysicianPhone;        console.log('Physician__c--->'+this.Child2PhysicianPhone);
        Child2Record.Insurance_Provider__c = this.Child2PhysicianInsuranceNumber;        console.log('Insurance_Provider__c--->'+this.Child2PhysicianInsuranceNumber);
        Child2Record.Most_Recent_Physical__c = this.Child2LastPhysical;        console.log('PhysicMost_Recent_Physical__cian_Name__c--->'+this.Child2LastPhysical);
        Child2Record.Most_Recent_Vision_Exam__c = this.Child2LastVisionTest;         console.log('Most_Recent_Vision_Exam__c--->'+this.Child2LastVisionTest);       
        Child2Record.Most_Recent_Hearing_Exam__c = this.Child2LastHearingExam;        console.log('Most_Recent_Hearing_Exam__c--->'+this.Child2LastHearingExam);
        Child2Record.Most_Recent_Dental_Exam__c = this.Child2Dental;        console.log('Most_Recent_Dental_Exam__c--->'+this.Child2Dental);
        Child2Record.Operations_Injuries__c = this.Child2OperationInjuries1;        console.log('Operations_Injuries__c--->'+this.Child2OperationInjuries1);
        Child2Record.Medical_Needs__c = this.Child2SpecialNeeds;        console.log('Medical_Needs__c--->'+this.Child2SpecialNeeds);
        Child2Record.Medications__c = this.Child2CurrentMedications;        console.log('Medications__c--->'+this.Child2CurrentMedications);        
        Child2Record.Takes_Medication__c = this.Child2TakeMedication;        console.log('Takes_Medication__c--->'+this.Child2TakeMedication);
        Child2Record.Physicians_Advice__c = this.Child2PhysiciansAdvice;        console.log('Physicians_Advice__c--->'+this.Child2PhysiciansAdvice);
        var Child2HaveHadIllness='';
        Child2HaveHadIllness = this.convertMultipicklistValueToStringSaveHelper(this.allChild2IllnessMultiPicklistValues);         
        Child2Record.Had_illness__c = Child2HaveHadIllness;        console.log('Had_illness__c--->'+Child2HaveHadIllness);
        Child2Record.MH_History_Detailed__c = this.Child2PhysicianDetails;        console.log('MH_History_Detailed__c--->'+this.Child2PhysicianDetails);
        var Child2Allergies='';
        Child2Allergies = this.convertMultipicklistValueToStringSaveHelper(this.allChild2AllergiesMultiPicklistValues);         
        Child2Record.Allergies__c = Child2Allergies;        console.log('Allergies__c--->'+Child2Allergies);        
        Child2Record.Allergies_Detailed__c = this.Child2AllergiesDetails;        console.log('Allergies_Detailed__c--->'+this.Child2AllergiesDetails);

        var Child2ChildWillAttendAfterSchool='';
        Child2ChildWillAttendAfterSchool = this.convertMultipicklistValueToStringSaveHelper(this.allChild2AttendSchoolMultiPicklistValues);         
        Child2Record.Child_will_Attend_Afterschool__c = Child2ChildWillAttendAfterSchool;        console.log('Child_will_Attend_Afterschool__c--->'+Child2Record.Child_will_Attend_Afterschool__c);
        Child2Record.Emergency_Contact_First__c = this.EmergencyContactFirst;        console.log('Emergency_Contact_Last__c--->'+this.EmergencyContactFirst);
        Child2Record.Emergency_Contact_Last__c = this.EmergencyContactLast;        console.log('Emergency_Contact_Last__c--->'+this.EmergencyContactLast);    
        Child2Record.Emergency_Contact_Relationship__c = this.EmergencyContactRelationShip;        console.log('Emergency_Contact_Relationship__c--->'+this.EmergencyContactRelationShip);       
        Child2Record.Emergency_Contact_Phone__c = this.EmergencyPhone;        console.log('Emergency_Contact_Phone__c--->'+this.EmergencyPhone);       
        Child2Record.Emergency_Contact_Cell_Phone__c = this.EmergencyCellPhone;        console.log('Emergency_Contact_Cell_Phone__c--->'+this.EmergencyCellPhone);       
        Child2Record.Approved_Pick_Up_1__c = this.ApprovedPickUp1;        console.log('Approved_Pick_Up_1__c--->'+this.ApprovedPickUp1);       
        Child2Record.Approved_Pick_Up_1_Relationship__c = this.ApprovedPickup1Relationship;        console.log('Approved_Pick_Up_1_Relationship__c--->'+this.ApprovedPickup1Relationship);       
        Child2Record.Approved_Pick_Up_1_Phone__c = this.ApprovedPickUp1Phone;        console.log('Approved_Pick_Up_1_Phone__c--->'+this.ApprovedPickUp1Phone);       
        Child2Record.Approved_Pick_Up_2__c = this.ApprovedPickUp2;        console.log('Approved_Pick_Up_2__c--->'+this.ApprovedPickUp2);       
        Child2Record.Approved_Pick_Up_2_Relationship__c = this.ApprovedPickup2Relationship;        console.log('Approved_Pick_Up_2_Relationship__c--->'+this.ApprovedPickup2Relationship);       
        Child2Record.Approved_Pick_Up_2_Phone__c = this.ApprovedPickUp2Phone;        console.log('Approved_Pick_Up_2_Phone__c--->'+this.ApprovedPickUp2Phone);       

        let Child3Record = { 'sobjectType': 'Contact' }; 
        Child3Record.FirstName = this.Child3FirstName;        console.log('Child3FirstName---->'+this.Child3FirstName);
        Child3Record.LastName = this.Child3LastName;        console.log('Child3LastName---->'+this.Child3LastName);
        Child3Record.Birthdate = this.Child3Birthday;        console.log('Child3Birthday---->'+this.Child3Birthday);
        Child3Record.SSN__c = this.Child3SSN;        console.log('SSN__c--->'+this.Child3SSN);
        Child3Record.School__c = this.Child3School;        console.log('Child3School--->'+this.Child3School);
        Child3Record.Grade__c = this.Child3Grade;        console.log('Grade__c--->'+this.Child3Grade);
        Child3Record.Physician_Name__c = this.Child3PhysicianName;        console.log('Physician_Name__c--->'+this.Child3PhysicianName);
        Child3Record.Physician__c = this.Child3PhysicianPhone;        console.log('Physician__c--->'+this.Child3PhysicianPhone);
        Child3Record.Insurance_Provider__c = this.Child3PhysicianInsuranceNumber;        console.log('Insurance_Provider__c--->'+this.Child3PhysicianInsuranceNumber);
        Child3Record.Most_Recent_Physical__c = this.Child3LastPhysical;        console.log('PhysicMost_Recent_Physical__cian_Name__c--->'+this.Child3LastPhysical);
        Child3Record.Most_Recent_Vision_Exam__c = this.Child3LastVisionTest;         console.log('Most_Recent_Vision_Exam__c--->'+this.Child3LastVisionTest);       
        Child3Record.Most_Recent_Hearing_Exam__c = this.Child3LastHearingExam;        console.log('Most_Recent_Hearing_Exam__c--->'+this.Child3LastHearingExam);
        Child3Record.Most_Recent_Dental_Exam__c = this.Child3Dental;        console.log('Most_Recent_Dental_Exam__c--->'+this.Child3Dental);
        Child3Record.Operations_Injuries__c = this.Child3OperationInjuries1;        console.log('Operations_Injuries__c--->'+this.Child3OperationInjuries1);
        Child3Record.Medical_Needs__c = this.Child3SpecialNeeds;        console.log('Medical_Needs__c--->'+this.Child3SpecialNeeds);
        Child3Record.Medications__c = this.Child3CurrentMedications;        console.log('Medications__c--->'+this.Child3CurrentMedications);        
        Child3Record.Takes_Medication__c = this.Child3TakeMedication;        console.log('Takes_Medication__c--->'+this.Child3TakeMedication);
        Child3Record.Physicians_Advice__c = this.Child3PhysiciansAdvice;        console.log('Physicians_Advice__c--->'+this.Child3PhysiciansAdvice);
        var Child3HaveHadIllness='';
        Child3HaveHadIllness = this.convertMultipicklistValueToStringSaveHelper(this.allChild3IllnessMultiPicklistValues);         
        Child3Record.Had_illness__c = Child3HaveHadIllness;        console.log('Had_illness__c--->'+Child3HaveHadIllness);
        Child3Record.MH_History_Detailed__c = this.Child3PhysicianDetails;        console.log('MH_History_Detailed__c--->'+this.Child3PhysicianDetails);

        var Child3Allergies='';
        Child3Allergies = this.convertMultipicklistValueToStringSaveHelper(this.allChild3AllergiesMultiPicklistValues);         
        Child3Record.Allergies__c = Child3Allergies;        console.log('Allergies__c--->'+Child3Allergies);        
        Child3Record.Allergies_Detailed__c = this.Child3AllergiesDetails;        console.log('Allergies_Detailed__c--->'+this.Child3AllergiesDetails);
        var Child3ChildWillAttendAfterSchool='';
        Child3ChildWillAttendAfterSchool = this.convertMultipicklistValueToStringSaveHelper(this.allChild3AttendSchoolMultiPicklistValues);         
        Child3Record.Child_will_Attend_Afterschool__c = Child3ChildWillAttendAfterSchool;        console.log('Child_will_Attend_Afterschool__c--->'+Child3Record.Child_will_Attend_Afterschool__c);

        Child3Record.Emergency_Contact_First__c = this.EmergencyContactFirst;        console.log('Emergency_Contact_Last__c--->'+this.EmergencyContactFirst);
        Child3Record.Emergency_Contact_Last__c = this.EmergencyContactLast;        console.log('Emergency_Contact_Last__c--->'+this.EmergencyContactLast);    
        Child3Record.Emergency_Contact_Relationship__c = this.EmergencyContactRelationShip;        console.log('Emergency_Contact_Relationship__c--->'+this.EmergencyContactRelationShip);       
        Child3Record.Emergency_Contact_Phone__c = this.EmergencyPhone;        console.log('Emergency_Contact_Phone__c--->'+this.EmergencyPhone);       
        Child3Record.Emergency_Contact_Cell_Phone__c = this.EmergencyCellPhone;        console.log('Emergency_Contact_Cell_Phone__c--->'+this.EmergencyCellPhone);       
        Child3Record.Approved_Pick_Up_1__c = this.ApprovedPickUp1;        console.log('Approved_Pick_Up_1__c--->'+this.ApprovedPickUp1);       
        Child3Record.Approved_Pick_Up_1_Relationship__c = this.ApprovedPickup1Relationship;        console.log('Approved_Pick_Up_1_Relationship__c--->'+this.ApprovedPickup1Relationship);       
        Child3Record.Approved_Pick_Up_1_Phone__c = this.ApprovedPickUp1Phone;        console.log('Approved_Pick_Up_1_Phone__c--->'+this.ApprovedPickUp1Phone);       
        Child3Record.Approved_Pick_Up_2__c = this.ApprovedPickUp2;        console.log('Approved_Pick_Up_2__c--->'+this.ApprovedPickUp2);       
        Child3Record.Approved_Pick_Up_2_Relationship__c = this.ApprovedPickup2Relationship;        console.log('Approved_Pick_Up_2_Relationship__c--->'+this.ApprovedPickup2Relationship);       
        Child3Record.Approved_Pick_Up_2_Phone__c = this.ApprovedPickUp2Phone;
        console.log('Approved_Pick_Up_2_Phone__c--->'+this.ApprovedPickUp2Phone); console.log('  Child3Record  '+JSON.stringify(Child3Record));
    
        let ParentRecord1 = { 'sobjectType': 'Contact' };
        ParentRecord1.How_do_you_hear_about_us__c = this.template.querySelector("[data-field='HowDoYouHearAboutUs']").value;
        console.log('How_do_you_hear_about_us__c--->'+ParentRecord1.How_do_you_hear_about_us__c);
        ParentRecord1.LastName = this.Parent1LastName;        console.log('LastName--->'+this.Parent1LastName);
        ParentRecord1.FirstName = this.Parent1FirstName;
        ParentRecord1.Primary_Guardian_Relationship__c = this.Parent1Relationship;        console.log('Primary_Guardian_Relationship__c--->'+this.Parent1Relationship);
        ParentRecord1.MailingStreet = this.Parent1Address;        console.log('MailingStreet--->'+this.Parent1Address);
        ParentRecord1.MailingCity = this.Parent1City;        console.log('MailingCity--->'+this.Parent1City);
        ParentRecord1.MailingState = this.Parent1State;        console.log('MailingState--->'+this.Parent1State);
        ParentRecord1.MailingPostalCode = this.Parent1ZipCode;        console.log('MailingPostalCode--->'+this.Parent1ZipCode);
        ParentRecord1.Place_of_Employment__c = this.Parent1PlaceOfEmp;        console.log('Place_of_Employment__c--->'+this.Parent1PlaceOfEmp);
        ParentRecord1.Phone = this.Parent1HomePhone;        console.log('Phone--->'+this.Parent1HomePhone);
        ParentRecord1.MobilePhone = this.Parent1CellPhone;        console.log('MobilePhone--->'+this.Parent1CellPhone);
        ParentRecord1.npe01__WorkPhone__c = this.Parent1WorkPhone;        console.log('npe01__WorkPhone__c--->'+this.Parent1WorkPhone);
        ParentRecord1.Email = this.Parent1emailAddress;        console.log('Email--->'+this.Parent1emailAddress);
        ParentRecord1.Household_Monthly_Income__c = this.Parent1MonthlyIncome;        console.log('Household_Monthly_Income__c--->'+this.Parent1MonthlyIncome);        
        var Parent1SourceOfIncome='';
        Parent1SourceOfIncome = this.convertMultipicklistValueToStringSaveHelper(this.allParent1MultiPicklistValues);         
        ParentRecord1.Source_of_Income__c = Parent1SourceOfIncome;        console.log('Source_of_Income__c--->'+Parent1SourceOfIncome);
        ParentRecord1.Receive_Public_Assistance__c = this.Parent1PublicAssistance;        console.log('Receive_Public_Assistance__c--->'+this.Parent1PublicAssistance);
        ParentRecord1.Housing_Type__c = this.Parent1HousingType;        console.log('Housing_Type__c--->'+this.Parent1HousingType);
        ParentRecord1.Housing_Ownership__c = this.Parent1HousingOwnerShip;        console.log('Housing_Ownership__c--->'+this.Parent1HousingOwnerShip);
        ParentRecord1.Time_In_Residence__c = this.Parent1TimeInResidence;        console.log('Time_In_Residence__c--->'+this.Parent1TimeInResidence);
        console.log('  ParentRecord1  '+JSON.stringify(ParentRecord1));
        
        let ParentRecord2 = { 'sobjectType': 'Contact' };
        ParentRecord2.LastName = this.Parent2LastName;        console.log('LastName--->'+this.Parent2LastName);
        ParentRecord2.FirstName = this.Parent2FirstName;
        ParentRecord2.Primary_Guardian_Relationship__c = this.Parent2Relationship;    console.log('Primary_Guardian_Relationship__c--->'+this.Parent2Relationship);
        ParentRecord2.MailingStreet = this.Parent2Address;        console.log('MailingStreet--->'+this.Parent2Address);
        ParentRecord2.MailingCity = this.Parent2City;        console.log('MailingCity--->'+this.Parent2City);
        ParentRecord2.MailingState = this.Parent2State;        console.log('MailingState--->'+this.Parent2State);
        ParentRecord2.MailingPostalCode = this.Parent2ZipCode;        console.log('MailingPostalCode--->'+this.Parent2ZipCode);
        ParentRecord2.Place_of_Employment__c = this.Parent2PlaceOfEmp;        console.log('Place_of_Employment__c--->'+this.Parent2PlaceOfEmp);
        ParentRecord2.Phone = this.Parent2HomePhone;        console.log('Phone--->'+this.Parent2HomePhone);
        ParentRecord2.MobilePhone = this.Parent2CellPhone;        console.log('MobilePhone--->'+this.Parent2CellPhone);
        ParentRecord2.npe01__WorkPhone__c = this.Parent2WorkPhone;        console.log('npe01__WorkPhone__c--->'+this.Parent2WorkPhone);
        ParentRecord2.Email = this.Parent2emailAddress;        console.log('Email--->'+this.Parent2emailAddress);
        ParentRecord2.Household_Monthly_Income__c = this.Parent2MonthlyIncome;        console.log('Household_Monthly_Income__c--->'+this.Parent2MonthlyIncome);        
        var Parent2SourceOfIncome='';
        Parent2SourceOfIncome = this.convertMultipicklistValueToStringSaveHelper(this.allParent2MultiPicklistValues);         
        ParentRecord2.Source_of_Income__c = Parent2SourceOfIncome;        console.log('Source_of_Income__c--->'+Parent2SourceOfIncome);
        ParentRecord2.Receive_Public_Assistance__c = this.Parent2PublicAssistance;        console.log('Receive_Public_Assistance__c--->'+this.Parent2PublicAssistance);
        ParentRecord2.Housing_Type__c = this.Parent2HousingType;        console.log('Housing_Type__c--->'+this.Parent2HousingType);
        ParentRecord2.Housing_Ownership__c = this.Parent2HousingOwnerShip;        console.log('Housing_Ownership__c--->'+this.Parent2HousingOwnerShip);
        ParentRecord2.Time_In_Residence__c = this.Parent2TimeInResidence;        console.log('Time_In_Residence__c--->'+this.Parent2TimeInResidence);        console.log('  ParentRecord2  '+JSON.stringify(ParentRecord2));
        var convertedDataURIData = this.template.querySelector("c-capture-signature").fetchUril();
        var signed = convertedDataURIData.split('~')[0]; var convertedDataURI = convertedDataURIData.split('~')[1];
        console.log('this.isChild1Entered---->'+this.isChild1Entered);
        console.log('this.Child1AllergiesDetails'+this.Child1AllergiesDetails.toString().replace(/\s/g, ''));



        if(  ( this.Child2FirstName.toString().replace(/\s/g, '')==''  && this.Child2LastName.toString().replace(/\s/g, '')=='' 
        && this.Child2Birthday.toString().replace(/\s/g, '')==''  && this.Child2School.toString().replace(/\s/g, '')==''
        && this.Child2Grade.toString().replace(/\s/g, '')==''  && this.Child2PhysicianName.toString().replace(/\s/g, '')==''
        && this.Child2PhysicianPhone.toString().replace(/\s/g, '')==''  && this.Child2PhysicianInsuranceNumber.toString().replace(/\s/g, '')==''
        && this.Child2LastPhysical==''  && this.Child2LastVisionTest=='' && this.Child2LastHearingExam=='' && this.Child2Dental==''
        && this.Child2OperationInjuries1.toString().replace(/\s/g, '')==''  && this.Child2SpecialNeeds.toString().replace(/\s/g, '')=='' 
        && this.Child2CurrentMedications.toString().replace(/\s/g, '')=='' && this.Child2TakeMedication.toString().replace(/\s/g, '')=='' 
        && this.Child2PhysiciansAdvice.toString().replace(/\s/g, '')=='' && Child2Record.Had_illness__c.toString().replace(/\s/g, '')=='' 
        && this.Child2PhysicianDetails.toString().replace(/\s/g, '')==''  && Child2Record.Allergies__c.toString().replace(/\s/g, '')=='' 
        && this.Child2AllergiesDetails.toString().replace(/\s/g, '')==''  && Child2ChildWillAttendAfterSchool.toString().replace(/\s/g, '')=='' 
        )                
        ){
            this.isChild2Entered = false;
        }    
    
        if(  ( this.Child3FirstName.toString().replace(/\s/g, '')==''  && this.Child3LastName.toString().replace(/\s/g, '')=='' 
		&& this.Child3Birthday=='' && this.Child3School.toString().replace(/\s/g, '')==''
		&& this.Child3Grade.toString().replace(/\s/g, '')==''  && this.Child3PhysicianName.toString().replace(/\s/g, '')==''
		&& this.Child3PhysicianPhone.toString().replace(/\s/g, '')==''  && this.Child3PhysicianInsuranceNumber.toString().replace(/\s/g, '')==''
		&& this.Child3LastPhysical=='' 
		&& this.Child3LastVisionTest=='' 
		&& this.Child3LastHearingExam=='' 
		&& this.Child3Dental==''
		&& this.Child3OperationInjuries1.toString().replace(/\s/g, '')==''  && this.Child3SpecialNeeds.toString().replace(/\s/g, '')=='' 
		&& this.Child3CurrentMedications.toString().replace(/\s/g, '')==''  && this.Child3TakeMedication.toString().replace(/\s/g, '')=='' 
		&& this.Child3PhysiciansAdvice.toString().replace(/\s/g, '')=='' && Child3Record.Had_illness__c.toString().replace(/\s/g, '')=='' 
		&& this.Child3PhysicianDetails.toString().replace(/\s/g, '')=='' && Child3Record.Allergies__c.toString().replace(/\s/g, '')=='' 
		&& this.Child3AllergiesDetails.toString().replace(/\s/g, '')=='' && Child3ChildWillAttendAfterSchool.toString().replace(/\s/g, '')==''  
        )                
        ){
            this.isChild3Entered = false;
        }



        if(this.alertMessage=='' && this.isChild1Entered==true 
            &&( this.Child1FirstName.toString().replace(/\s/g, '')!=''  && this.Child1LastName.toString().replace(/\s/g, '')!='' 
                && this.Child1Birthday!=''  && this.Child1School.toString().replace(/\s/g, '')!=''
                && this.Child1Grade.toString().replace(/\s/g, '')!=''  && this.Child1PhysicianName.toString().replace(/\s/g, '')!=''
                && this.Child1PhysicianPhone.toString().replace(/\s/g, '')!=''  && this.Child1PhysicianInsuranceNumber.toString().replace(/\s/g, '')!=''
                /*&& this.Child1LastPhysical!=''  && this.Child1LastVisionTest!=''  && this.Child1LastHearingExam!=''  && this.Child1Dental!=''*/
                && this.Child1OperationInjuries1.toString().replace(/\s/g, '')!=''  && this.Child1SpecialNeeds.toString().replace(/\s/g, '')!='' 
                && this.Child1CurrentMedications.toString().replace(/\s/g, '')!=''  && this.Child1TakeMedication.toString().replace(/\s/g, '')!='' 
                && this.Child1PhysiciansAdvice.toString().replace(/\s/g, '')!='' && Child1Record.Had_illness__c.toString().replace(/\s/g, '')!='' 
                && this.Child1PhysicianDetails.toString().replace(/\s/g, '')!=''  && Child1Record.Allergies__c.toString().replace(/\s/g, '')!='' 
                && this.Child1AllergiesDetails.toString().replace(/\s/g, '')!=''  && Child1ChildWillAttendAfterSchool.toString().replace(/\s/g, '')!=''                 
            )
        ){        
            this.alertMessage = ''; this.errorMessage = false; this.errorMessage1 = false;
        }else{
            this.alertMessage = 'Please Enter All Fields for Child1. "If you do not have the information or do not know the information for a required field please enter None or N/A for text fields, leave blank for Date & Number fields."';
            alert(this.alertMessage);
            this.successMessage = false; this.successMessage1 = false; this.isLoaded = false;  this.errorMessage = true;  this.errorMessage1 = true;
        }   
        
        var CurrentDate = new Date();        console.log('CurrentDate  '+CurrentDate);
        if(this.alertMessage=='' && new Date(this.Child1Birthday) > CurrentDate){
          this.alertMessage = 'Please Enter Valid DOB for Child1';
          alert(this.alertMessage);
           this.successMessage = false; this.successMessage1 = false; this.isLoaded = false; this.errorMessage = true; this.errorMessage1 = true;
        }
        if(this.alertMessage=='' && this.Child1PhysicianPhone.toString().replace(/\s/g, '')!=''){
            this.phoneValidation(this.Child1PhysicianPhone,'Child1','Physician Phone');
        }

        //if(this.alertMessage=='' && this.Child1PhysicianInsuranceNumber.toString().replace(/\s/g, '')!='' && isNaN(this.Child1PhysicianInsuranceNumber)==true){
            //this.alertMessage = 'Please Enter Child1 Insurance Number in Number format only';
            //alert(this.alertMessage);
            //this.successMessage = false; this.successMessage1 = false; this.isLoaded = false; this.errorMessage = true; this.errorMessage1 = true;
        //}
        //if(this.alertMessage==''){
            //this.insuranceNumberIncomeValidation(this.Child1PhysicianInsuranceNumber,'Child1','Insurance Number');           
        //}        

        if(this.alertMessage=='' && this.isChild2Entered==true){
            if(  ( this.Child2FirstName.toString().replace(/\s/g, '')!=''  && this.Child2LastName.toString().replace(/\s/g, '')!='' 
                    && this.Child2Birthday.toString().replace(/\s/g, '')!=''  && this.Child2School.toString().replace(/\s/g, '')!=''
                    && this.Child2Grade.toString().replace(/\s/g, '')!=''  && this.Child2PhysicianName.toString().replace(/\s/g, '')!=''
                    && this.Child2PhysicianPhone.toString().replace(/\s/g, '')!=''  && this.Child2PhysicianInsuranceNumber.toString().replace(/\s/g, '')!=''
                    /*&& this.Child2LastPhysical!=''  && this.Child2LastVisionTest!='' && this.Child2LastHearingExam!='' && this.Child2Dental!=''*/ 
                    && this.Child2OperationInjuries1.toString().replace(/\s/g, '')!=''  && this.Child2SpecialNeeds.toString().replace(/\s/g, '')!='' 
                    && this.Child2CurrentMedications.toString().replace(/\s/g, '')!='' && this.Child2TakeMedication.toString().replace(/\s/g, '')!='' 
                    && this.Child2PhysiciansAdvice.toString().replace(/\s/g, '')!='' && Child2Record.Had_illness__c.toString().replace(/\s/g, '')!='' 
                    && this.Child2PhysicianDetails.toString().replace(/\s/g, '')!=''  && Child2Record.Allergies__c.toString().replace(/\s/g, '')!='' 
                    && this.Child2AllergiesDetails.toString().replace(/\s/g, '')!=''  && Child2ChildWillAttendAfterSchool.toString().replace(/\s/g, '')!='' 
                )                
            ){        
                this.alertMessage = '';this.errorMessage = false;this.errorMessage1 = false;
            }else{ 
                this.alertMessage =  'Please Enter All Fields for Child2. "If you do not have the information or do not know the information for a required field please enter None or N/A for text fields, leave blank for Date & Number fields."';
                alert(this.alertMessage);
                this.successMessage = false;  this.successMessage1 = false;  this.isLoaded = false; this.errorMessage = true; this.errorMessage1 = true;
            }   
        }
        //if(this.alertMessage=='' && this.Child2PhysicianInsuranceNumber.toString().replace(/\s/g, '')!='' && isNaN(this.Child2PhysicianInsuranceNumber)==true){
            //this.alertMessage = 'Please Enter Child2 Insurance Number in Number format only';
            //alert(this.alertMessage);
            //this.successMessage = false; this.successMessage1 = false;
            //this.isLoaded = false; this.errorMessage = true; this.errorMessage1 = true;
        //}
        //if(this.alertMessage==''){
            //this.insuranceNumberIncomeValidation(this.Child2PhysicianInsuranceNumber,'Child2','Insurance Number');
        //}        


        if(this.alertMessage=='' && new Date(this.Child2Birthday) > CurrentDate){
          alert('Please Enter Valid DOB for Child2');this.alertMessage = 'Please Enter Valid DOB for Child2';
           this.successMessage = false; this.successMessage1 = false; this.isLoaded = false; this.errorMessage = true; this.errorMessage1 = true;
        }

        if(this.alertMessage=='' && this.Child2PhysicianPhone.toString().replace(/\s/g, '')!=''){
            this.phoneValidation(this.Child2PhysicianPhone,'Child2','Physician Phone');
        }
        if(this.alertMessage=='' && this.isChild3Entered==true){
            if(  ( this.Child3FirstName.toString().replace(/\s/g, '')!=''  && this.Child3LastName.toString().replace(/\s/g, '')!='' 
                    && this.Child3Birthday!='' && this.Child3School.toString().replace(/\s/g, '')!=''
                    && this.Child3Grade.toString().replace(/\s/g, '')!=''  && this.Child3PhysicianName.toString().replace(/\s/g, '')!=''
                    && this.Child3PhysicianPhone.toString().replace(/\s/g, '')!=''  && this.Child3PhysicianInsuranceNumber.toString().replace(/\s/g, '')!=''
                    /*&& this.Child3LastPhysical!='' 
                    && this.Child3LastVisionTest!='' 
                    && this.Child3LastHearingExam!='' 
                    && this.Child3Dental!=''*/
                    && this.Child3OperationInjuries1.toString().replace(/\s/g, '')!=''  && this.Child3SpecialNeeds.toString().replace(/\s/g, '')!='' 
                    && this.Child3CurrentMedications.toString().replace(/\s/g, '')!=''  && this.Child3TakeMedication.toString().replace(/\s/g, '')!='' 
                    && this.Child3PhysiciansAdvice.toString().replace(/\s/g, '')!='' && Child3Record.Had_illness__c.toString().replace(/\s/g, '')!='' 
                    && this.Child3PhysicianDetails.toString().replace(/\s/g, '')!='' && Child3Record.Allergies__c.toString().replace(/\s/g, '')!='' 
                    && this.Child3AllergiesDetails.toString().replace(/\s/g, '')!='' && Child3ChildWillAttendAfterSchool.toString().replace(/\s/g, '')!=''  
                )                
            ){        
                this.alertMessage = ''; this.errorMessage = false; this.errorMessage1 = false;
            }else{
            this.alertMessage =  'Please Enter All Fields for Child3. "If you do not have the information or do not know the information for a required field please enter None or N/A for text fields, leave blank for Date & Number fields."';
            alert(this.alertMessage);
            this.successMessage = false; this.successMessage1 = false;
            this.isLoaded = false;   this.errorMessage = true;  this.errorMessage1 = true;
        }    
        }
        if(this.alertMessage=='' && new Date(this.Child3Birthday) > CurrentDate){
            this.alertMessage = 'Please Enter Valid DOB for Child3';
            alert(this.alertMessage);
             this.successMessage = false; this.successMessage1 = false; this.isLoaded = false; this.errorMessage = true; this.errorMessage1 = true;
        }

        if(this.alertMessage=='' && this.Child3PhysicianPhone.toString().replace(/\s/g, '')!=''){
            this.phoneValidation(this.Child3PhysicianPhone,'Child3','Physician Phone');
        }

  
        //if(this.alertMessage=='' && this.Child3PhysicianInsuranceNumber.toString().replace(/\s/g, '')!='' && isNaN(this.Child3PhysicianInsuranceNumber)==true){
            //this.alertMessage = 'Please Enter Child3 Insurance Number in Number format only';
            //alert(this.alertMessage);
            //this.successMessage = false; this.successMessage1 = false;
            //this.isLoaded = false; this.errorMessage = true; this.errorMessage1 = true;
        //}
        //if(this.alertMessage==''){
            //this.insuranceNumberIncomeValidation(this.Child3PhysicianInsuranceNumber,'Child3','Insurance Number');
        //}        

        if(this.alertMessage=='' && this.isParent1Entered==true){                
            if( 
                this.Parent1FirstName.toString().replace(/\s/g, '')!='' 
                && this.Parent1LastName.toString().replace(/\s/g, '')!=''  && this.Parent1Relationship.toString().replace(/\s/g, '')!=''
                && this.Parent1Address.toString().replace(/\s/g, '')!=''  && this.Parent1City.toString().replace(/\s/g, '')!=''
                && this.Parent1State.toString().replace(/\s/g, '')!=''  && this.Parent1ZipCode.toString().replace(/\s/g, '')!=''
                && this.Parent1PlaceOfEmp.toString().replace(/\s/g, '')!=''  && this.Parent1HomePhone.toString().replace(/\s/g, '')!=''
                && this.Parent1CellPhone.toString().replace(/\s/g, '')!=''  && this.Parent1WorkPhone.toString().replace(/\s/g, '')!=''
                && this.Parent1MonthlyIncome.toString().replace(/\s/g, '')!=''  && Parent1SourceOfIncome.toString().replace(/\s/g, '')!=''
                && this.Parent1PublicAssistance.toString().replace(/\s/g, '')!=''  && this.Parent1HousingType.toString().replace(/\s/g, '')!=''
                && this.Parent1HousingOwnerShip.toString().replace(/\s/g, '')!=''  && this.Parent1TimeInResidence.toString().replace(/\s/g, '')!=''
            ){
                this.alertMessage = '';  this.errorMessage = false;  this.errorMessage1 = false;
            }else{
                console.log('parent1'); this.alertMessage =  'Please Enter All Fields for Parent1 (Email is not mandatory)  "If you do not have the information or do not know the information for a required field please enter None or N/A."';
                alert(this.alertMessage);
                this.successMessage = false;  this.successMessage1 = false;
                this.isLoaded = false;  this.errorMessage = true; this.errorMessage1 = true;
            }    
        }

        if(this.alertMessage==''){ this.lengthValidation(this.Parent1City,'Parent1','City');  }        
        if(this.alertMessage==''){ this.lengthValidation(this.Parent1State,'Parent1','State'); }
        if(this.alertMessage==''){ this.lengthValidation(this.Parent1ZipCode,'Parent1','Zip'); }

        if(this.alertMessage=='' && this.Parent1HomePhone.toString().replace(/\s/g, '')!=''){
            this.phoneValidation(this.Parent1HomePhone,'Parent1','Home Phone');
        }
         if(this.alertMessage=='' && this.Parent1CellPhone.toString().replace(/\s/g, '')!=''){
            this.phoneValidation(this.Parent1CellPhone,'Parent1','Cell Phone');
        }if(this.alertMessage=='' && this.Parent1WorkPhone.toString().replace(/\s/g, '')!=''){
            this.phoneValidation(this.Parent1WorkPhone,'Parent1','Work Phone');
        }
        if(this.alertMessage=='' && this.Parent1MonthlyIncome.toString().replace(/\s/g, '')!='' && isNaN(this.Parent1MonthlyIncome)==true){
            this.alertMessage = 'Please Enter Parent1 Monthly Income in Number format only (do not enter non-numeric characters) ';
            alert(this.alertMessage);
            this.successMessage = false; this.successMessage1 = false;
            this.isLoaded = false; this.errorMessage = true; this.errorMessage1 = true;
        }        
        if(this.alertMessage==''){
            this.insuranceNumberIncomeValidation(this.Parent1MonthlyIncome,'Parent1','Monthly Income');
        }
        if(this.alertMessage==''){
            this.lengthValidation(this.Parent1TimeInResidence,'Parent1','Length of time in current residence');
        }


        if(this.alertMessage=='' && this.isParent2Entered==true){                
            if( 
                this.Parent2FirstName.toString().replace(/\s/g, '')!='' 
                && this.Parent2LastName.toString().replace(/\s/g, '')!=''  && this.Parent2Relationship.toString().replace(/\s/g, '')!=''
                && this.Parent2Address.toString().replace(/\s/g, '')!=''  && this.Parent2City.toString().replace(/\s/g, '')!=''
                && this.Parent2State.toString().replace(/\s/g, '')!=''  && this.Parent2ZipCode.toString().replace(/\s/g, '')!=''
                && this.Parent2PlaceOfEmp.toString().replace(/\s/g, '')!=''  && this.Parent2HomePhone.toString().replace(/\s/g, '')!=''
                && this.Parent2CellPhone.toString().replace(/\s/g, '')!=''  && this.Parent2WorkPhone.toString().replace(/\s/g, '')!=''
                && this.Parent2MonthlyIncome.toString().replace(/\s/g, '')!=''  && Parent2SourceOfIncome.toString().replace(/\s/g, '')!=''
                && this.Parent2PublicAssistance.toString().replace(/\s/g, '')!=''  && this.Parent2HousingType.toString().replace(/\s/g, '')!=''
                && this.Parent2HousingOwnerShip.toString().replace(/\s/g, '')!=''  && this.Parent2TimeInResidence.toString().replace(/\s/g, '')!=''
            ){
                this.alertMessage = '';  this.errorMessage = false;  this.errorMessage1 = false;  
            }else{
                console.log('Parent2'); 
                this.alertMessage = 'Please Enter All Fields for Parent2 (Email is not mandatory)  "If you do not have the information or do not know the information for a required field please enter None or N/A."';this.successMessage = false; this.successMessage1 = false; this.isLoaded = false; this.errorMessage = true;  this.errorMessage1 = true;
                alert(this.alertMessage);
            }    
        }
        
        if(this.alertMessage=='' && this.Parent2HomePhone.toString().replace(/\s/g, '')!=''){this.phoneValidation(this.Parent2HomePhone,'Parent2','Home Phone');
        }
        if(this.alertMessage=='' && this.Parent2CellPhone.toString().replace(/\s/g, '')!=''){this.phoneValidation(this.Parent2CellPhone,'Parent2','Cell Phone');
        }
        if(this.alertMessage=='' && this.Parent2WorkPhone.toString().replace(/\s/g, '')!=''){this.phoneValidation(this.Parent2WorkPhone,'Parent2','Work Phone');
        }
        if(this.alertMessage=='' && this.Parent2MonthlyIncome.toString().replace(/\s/g, '')!='' && isNaN(this.Parent2MonthlyIncome)==true){
            this.alertMessage = 'Please Enter Parent2 Monthly Income in Number format only (do not enter non-numeric characters)';
            alert(this.alertMessage);
            this.successMessage = false; this.successMessage1 = false;this.isLoaded = false; this.errorMessage = true; this.errorMessage1 = true;
        }        
        if(this.alertMessage==''){
            this.insuranceNumberIncomeValidation(this.Parent2MonthlyIncome,'Parent2','Monthly Income');
        }

        if(this.alertMessage==''){
            this.lengthValidation(this.Parent2TimeInResidence,'Parent2','Length of time in current residence');
        }

 
        if(this.alertMessage==''){
            if(
                this.EmergencyContactFirst.toString().replace(/\s/g, '')!='' && this.EmergencyContactLast.toString().replace(/\s/g, '')!=''
                && this.EmergencyContactRelationShip.toString().replace(/\s/g, '')!='' && this.EmergencyPhone.toString().replace(/\s/g, '')!=''
                && this.EmergencyCellPhone.toString().replace(/\s/g, '')!='' && this.ApprovedPickUp1.toString().replace(/\s/g, '')!=''
                && this.ApprovedPickup1Relationship.toString().replace(/\s/g, '')!='' && this.ApprovedPickUp2.toString().replace(/\s/g, '')!=''
                && this.ApprovedPickup2Relationship.toString().replace(/\s/g, '')!='' && this.ApprovedPickUp1Phone.toString().replace(/\s/g, '')!='' && this.ApprovedPickUp2Phone.toString().replace(/\s/g, '')!=''
            ){
                this.alertMessage = ''; this.errorMessage = false;this.errorMessage1 = false;
            }else{
                this.alertMessage = 'Please Enter All Emergency Contact and Pickup Fields. "If you do not have the information or do not know the information for a required field please enter None or N/A."';this.successMessage = false; this.successMessage1 = false;this.isLoaded = false; this.errorMessage = true;   this.errorMessage1 = true;  
                alert(this.alertMessage);
            }
        }
        if(this.alertMessage=='' && this.EmergencyPhone.toString().replace(/\s/g, '')!=''){this.phoneValidation(this.EmergencyPhone,'Emergency','Emergency Phone');}
        if(this.alertMessage=='' && this.EmergencyCellPhone.toString().replace(/\s/g, '')!=''){this.phoneValidation(this.EmergencyCellPhone,'Emergency','Emergency Cell Phone');}
        if(this.alertMessage=='' && this.ApprovedPickUp1Phone.toString().replace(/\s/g, '')!=''){this.phoneValidation(this.ApprovedPickUp1Phone,'Emergency','Relationship1 Phone');}
        if(this.alertMessage=='' && this.ApprovedPickUp2Phone.toString().replace(/\s/g, '')!=''){this.phoneValidation(this.ApprovedPickUp2Phone,'Emergency','Relationship2 Phone');
        }console.log('signed--->'+signed); console.log('convertedDataURI--->'+convertedDataURI);
        if(this.alertMessage==''){
            if(signed=='false'){console.log('sign');alert('Please Sign and then submit the form! '); this.template.querySelector("c-capture-signature").handleChange();} 
        }
        
        var confirmSubmit=false;
        if(this.alertMessage=='' && signed=='true'){            this.errorMessage = false;console.log('error message****'+this.errorMessage); 
            this.errorMessage1 = false; console.log('error message1****'+this.errorMessage1); confirmSubmit = confirm('Are you sure to you want to submit the form?');
        }if(confirmSubmit==false){ this.isLoaded = false; }
        var child1JSON = {'child1FirstName':this.child1FirstName,child1LastName:this.child1LastName};
        //alert('ChildRecord1=='+JSON.stringify(Child1Record));
        //alert('Child2Record=='+JSON.stringify(Child2Record));
        //alert('Child3Record=='+JSON.stringify(Child3Record));
        //alert('Parent1RecordId=='+this.Parent1RecordId);
        //alert('Parent2RecordId=='+this.Parent2RecordId);
        if(this.alertMessage=='' && confirmSubmit==true){
            saveForm({ChildRecord1: JSON.stringify(Child1Record), ChildRecord2: JSON.stringify(Child2Record), ChildRecord3: JSON.stringify(Child3Record),
                    ParentRecord1: JSON.stringify(ParentRecord1), ParentRecord2: JSON.stringify(ParentRecord2),
                    Child1RecordId:this.Child1RecordId, Child2RecordId:this.Child2RecordId, Child3RecordId:this.Child3RecordId,
                    Parent1RecordId:this.Parent1RecordId, Parent2RecordId:this.Parent2RecordId,
                    Parent1AccountId:this.Parent1AccountId, CampaignId : this.CampaignId, CampaignMemberId : this.CampaignMemberId,
                    ProgramId:this.ProgramId, SignatureconvertedDataURI : convertedDataURI/*,child1FirstName:this.child1FirstName,child1LastName:this.child1LastName,child1Birthday:this.child1Birthday ,child1Age:this.child1Age ,
                    child1SSN:this.child1SSN ,
                    child1School:this.child1School,child1Grade:this.child1Grade,child1PhysicianName:this.child1PhysicianName,child1PhysicianPhone:this.child1PhysicianPhone,
                    child1PhysicianInsuranceNumber:this.child1PhysicianInsuranceNumber,child1LastPhysical:this.child1LastPhysical,child1LastVisionTest:this.child1LastVisionTest,
                    child1LastHearingExam:this.child1LastHearingExam,child1Dental:this.child1Dental,
                    child1OperationInjuries1:this.child1OperationInjuries1,child1CurrentMedications:this.child1CurrentMedications,child1TakeMedication:this.child1TakeMedication,
                    child1SpecialNeeds:this.child1SpecialNeeds,child1PhysiciansAdvice:this.child1PhysiciansAdvice,child1HaveHad:this.child1HaveHad,
                    child1PhysicianDetails:this.child1PhysicianDetails,child1Allergies:this.child1Allergies,child1AllergiesDetails:this.child1AllergiesDetails,
                    child1AttendAfterSchool:this.child1AttendAfterSchool,child2FirstName:this.child2FirstName,child2LastName:this.child2LastName,child2Birthday:this.child2Birthday ,child2Age:this.child2Age ,
                    child2SSN:this.child2SSN ,
                    child2School:this.child2School,child2Grade:this.child2Grade,child2PhysicianName:this.child2PhysicianName,child2PhysicianPhone:this.child2PhysicianPhone,
                    child2PhysicianInsuranceNumber:this.child2PhysicianInsuranceNumber,child2LastPhysical:this.child2LastPhysical,child2LastVisionTest:this.child2LastVisionTest,
                    child2LastHearingExam:this.child2LastHearingExam,child2Dental:this.child2Dental,
                    child2OperationInjuries1:this.child2OperationInjuries1,child2CurrentMedications:this.child2CurrentMedications,child2TakeMedication:this.child2TakeMedication,
                    child2SpecialNeeds:this.child2SpecialNeeds,child2PhysiciansAdvice:this.child2PhysiciansAdvice,child2HaveHad:this.child2HaveHad,
                    child2PhysicianDetails:this.child2PhysicianDetails,child2Allergies:this.child2Allergies,child2AllergiesDetails:this.child2AllergiesDetails,
                    child2AttendAfterSchool:this.child2AttendAfterSchool,child3FirstName:this.child3FirstName,child3LastName:this.child3LastName,child3Birthday:this.child3Birthday ,child3Age:this.child3Age ,
                    child3SSN:this.child3SSN ,
                    child3School:this.child3School,child3Grade:this.child3Grade,child3PhysicianName:this.child3PhysicianName,child3PhysicianPhone:this.child3PhysicianPhone,
                    child3PhysicianInsuranceNumber:this.child3PhysicianInsuranceNumber,child3LastPhysical:this.child3LastPhysical,child3LastVisionTest:this.child3LastVisionTest,
                    child3LastHearingExam:this.child3LastHearingExam,child3Dental:this.child3Dental,
                    child3OperationInjuries1:this.child3OperationInjuries1,child3CurrentMedications:this.child3CurrentMedications,child3TakeMedication:this.child3TakeMedication,
                    child3SpecialNeeds:this.child3SpecialNeeds,child3PhysiciansAdvice:this.child3PhysiciansAdvice,child3HaveHad:this.child3HaveHad,
                    child3PhysicianDetails:this.child3PhysicianDetails,child3Allergies:this.child3Allergies,child3AllergiesDetails:this.child3AllergiesDetails,
                    child3AttendAfterSchool:this.child3AttendAfterSchool,EmergencyContactFirst:this.EmergencyContactFirst ,EmergencyContactLast:this.EmergencyContactLast ,EmergencyContactRelationShip:this.EmergencyContactRelationShip ,
                    EmergencyPhone:this.EmergencyPhone ,EmergencyCellPhone:this.EmergencyCellPhone , ApprovedPickUp1:this.ApprovedPickUp1 ,
                    ApprovedPickup1Relationship:this.ApprovedPickup1Relationship ,  ApprovedPickUp1Phone:this.ApprovedPickUp1Phone ,  ApprovedPickUp2:this.ApprovedPickUp2 ,
                    ApprovedPickup2Relationship:this.ApprovedPickup2Relationship ,  ApprovedPickUp2Phone:this.ApprovedPickUp2Phone ,Parent1FirstName:this.Parent1FirstName,Parent1LastName:this.Parent1LastName, Parent1Relationship:this.Parent1Relationship,
                    Parent1Address:this.Parent1Address, Parent1City:this.Parent1City, Parent1State:this.Parent1State, Parent1ZipCode:this.Parent1ZipCode,
                    Parent1PlaceOfEmp:this.Parent1PlaceOfEmp, Parent1HomePhone:this.Parent1HomePhone, Parent1CellPhone:this.Parent1CellPhone,
                    Parent1WorkPhone:this.Parent1WorkPhone, Parent1emailAddress:this.Parent1emailAddress, Parent1MonthlyIncome:this.Parent1MonthlyIncome,
                    Parent1SourceIncome:this.Parent1SourceIncome, Parent1PublicAssistance:this.Parent1PublicAssistance,  Parent1HousingType:this.Parent1HousingType, 
                    Parent1HousingOwnerShip:this.Parent1HousingOwnerShip, Parent1TimeInResidence:this.Parent1TimeInResidence,Parent2FirstName:this.Parent2FirstName,Parent2LastName:this.Parent2LastName, Parent2Relationship:this.Parent2Relationship,
                    Parent2Address:this.Parent2Address, Parent2City:this.Parent2City, Parent2State:this.Parent2State, Parent2ZipCode:this.Parent2ZipCode,
                    Parent2PlaceOfEmp:this.Parent2PlaceOfEmp, Parent2HomePhone:this.Parent2HomePhone, Parent2CellPhone:this.Parent2CellPhone,
                    Parent2WorkPhone:this.Parent2WorkPhone, Parent2emailAddress:this.Parent2emailAddress, Parent2MonthlyIncome:this.Parent2MonthlyIncome,
                    Parent2SourceIncome:this.Parent2SourceIncome, Parent2PublicAssistance:this.Parent2PublicAssistance,  Parent2HousingType:this.Parent2HousingType, 
                    Parent2HousingOwnerShip:this.Parent2HousingOwnerShip, Parent2TimeInResidence:this.Parent2TimeInResidence,Parent3FirstName:this.Parent3FirstName,Parent3LastName:this.Parent3LastName, Parent3Relationship:this.Parent3Relationship,
                    Parent3Address:this.Parent3Address, Parent3City:this.Parent3City, Parent3State:this.Parent3State, Parent3ZipCode:this.Parent3ZipCode,
                    Parent3PlaceOfEmp:this.Parent3PlaceOfEmp, Parent3HomePhone:this.Parent3HomePhone, Parent3CellPhone:this.Parent3CellPhone,
                    Parent3WorkPhone:this.Parent3WorkPhone, Parent3emailAddress:this.Parent3emailAddress, Parent3MonthlyIncome:this.Parent3MonthlyIncome,
                    Parent3SourceIncome:this.Parent3SourceIncome, Parent3PublicAssistance:this.Parent3PublicAssistance,  Parent3HousingType:this.Parent3HousingType, 
                    Parent3HousingOwnerShip:this.Parent3HousingOwnerShip, Parent3TimeInResidence:this.Parent3TimeInResidence*/
                    ,child1JSON:child1JSON,HowDoYouHearAboutUs:this.HowDoYouHearAboutUs
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    })
            .then(result => {
                //this.recordId = result; //console.log(result); //alert('result--->'+result);
                if(result=='Form Submitted'){
                    alert('Your Form is Submitted Successfully!'); this.alertMessage = 'Your Form is Submitted Successfully!'; this.isSubmitDisable = true; this.successMessage = true; this.successMessage1 = true; this.errorMessage = false; this.errorMessage1 = false; this.isLoaded = false;
                    this.PageLoadHelper();
                }
                else{
                     if(result=='Please Check Duplicate Insurance Number'){
                        alert('Please Check Duplicate Insurance Number'); this.alertMessage = 'Please Check Duplicate Insurance Number'; this.successMessage = false; this.successMessage1 = false; this.errorMessage = true; this.errorMessage1 = true; this.isLoaded = false;    
                     }else if(result=='Please Enter Correct Email'){
                        alert('Please Enter Email in valid format!'); this.alertMessage = 'Please Enter Email in valid format!'; this.successMessage = false; this.successMessage1 = false; this.errorMessage = true;  this.errorMessage1 = true; this.isLoaded = false;
                     }
                     /*else if(result=='Insurance Number should be less than 18 digits'){
                        alert('Insurance Number should be less than 18 digits');
                        this.alertMessage = 'Insurance Number should be less than 18 digits';
                        this.successMessage = false; this.successMessage1 = false;this.errorMessage = true; this.errorMessage1 = true; this.isLoaded = false;
                     }*/
                    else if(result=='Household Monthly Income should be less than 18 digits'){
                        alert('Household Monthly Income should be less than 18 digits'); this.alertMessage = 'Household Monthly Income should be less than 18 digits';
                        this.successMessage = false; this.successMessage1 = false;this.errorMessage = true; this.errorMessage1 = true; this.isLoaded = false;
                     }
                     else{
                        this.alertMessage = 'Your Form Submition is Failed! Please try again with valid details!';
                        alert(this.alertMessage); 
                        alert(result);                        
                        console.log('handled exception----->'+result);
                        this.successMessage = false; this.successMessage1 = false; this.errorMessage = true; this.errorMessage1 = true; this.isLoaded = false;
                        this.PageLoadHelper(); 
                     }
                }
            })
            .catch(error => {
                console.log('error-->'+error);alert('error--->'+error);alert('error--->'+JSON.stringify(error));
                this.error = error;this.isLoaded = false; 
            });
        }      
    }
    handleClearClick() {
        this.template.querySelector("c-capture-signature").handleChange();
    }
    handlesignatureevent(event){
          this.imguri = event.detail.converteduri;          console.log('testurl--->'+testurl);
    }
    onSchool1Selection(event){
        if(event.detail.selectedRecordId!=null){this.Child1School = event.detail.selectedRecordId; this.school1name = event.detail.selectedValue;
        }else{this.Child1School = '';
        }console.log(this.Child1School);
    }
    onSchool2Selection(event){
        if(event.detail.selectedRecordId!=null){this.Child2School = event.detail.selectedRecordId; this.school2name = event.detail.selectedValue;
        }else{this.Child2School = '';
        } console.log(this.Child2School);
    }
    onSchool3Selection(event){
        if(event.detail.selectedRecordId!=null){this.Child3School = event.detail.selectedRecordId; this.school3name = event.detail.selectedValue;}
        else{this.Child3School = '';
        }console.log(this.Child3School);
    }
    refreshMessages(){
        this.alertMessage='';  this.successMessage=false;   this.successMessage1 = false; this.errorMessage=false; this.errorMessage1=false; 
    }
    phoneValidation(PhoneNumber,person,phoneType){
        if(isNaN(PhoneNumber)==true){ this.alertMessage='Please Enter '+person+' '+phoneType+'  number in number format only';
        alert(this.alertMessage);
        this.successMessage = false; this.successMessage1 = false;this.errorMessage = true; this.errorMessage1 = true; this.isLoaded = false;
        } if(this.alertMessage=='' && PhoneNumber.length>40){
            this.alertMessage='Please Enter valid '+' '+phoneType+'  number for '+person;
            alert(this.alertMessage);
            this.successMessage = false; this.successMessage1 = false;this.errorMessage = true; this.errorMessage1 = true; this.isLoaded = false;
          }
    }

    insuranceNumberIncomeValidation(givenNumber,person,numberType){
        if( givenNumber.length>18){
            this.alertMessage='Please Enter '+person+''+' '+numberType+' less than 18 digits';
            alert(this.alertMessage);
            this.successMessage = false; this.successMessage1 = false;this.errorMessage = true; this.errorMessage1 = true; this.isLoaded = false;
          }
    }

    lengthValidation(givenValue,person,fieldType){
        if(givenValue.toString().replace(/\s/g, '')!=''){
            if(fieldType=='State'){
                if(givenValue.length>80){
                    this.alertMessage='Please Enter '+person+''+' '+fieldType+' less than 80 characters';
                    alert(this.alertMessage);
                    this.successMessage = false; this.successMessage1 = false;this.errorMessage = true; this.errorMessage1 = true; this.isLoaded = false;    
                }
            }
            else if(fieldType=='City'){
                if(givenValue.length>40){
                    this.alertMessage='Please Enter '+person+''+' '+fieldType+' less than 40 characters';
                    alert(this.alertMessage);
                    this.successMessage = false; this.successMessage1 = false;this.errorMessage = true; this.errorMessage1 = true; this.isLoaded = false;    
                }
            }
            else if(fieldType=='Zip'){
                if(givenValue.length>20){
                    this.alertMessage='Please Enter '+person+''+' '+fieldType+' less than 20 characters';
                    alert(this.alertMessage);
                    this.successMessage = false; this.successMessage1 = false;this.errorMessage = true; this.errorMessage1 = true; this.isLoaded = false;    
                }
            }               
            else if(fieldType=='Length of time in current residence'){
                if(givenValue.length>255){
                    this.alertMessage='Please Enter '+person+''+' '+fieldType+' less than 255 characters';
                    alert(this.alertMessage);
                    this.successMessage = false; this.successMessage1 = false;this.errorMessage = true; this.errorMessage1 = true; this.isLoaded = false;    
                }
            }                
        }

    }    



}