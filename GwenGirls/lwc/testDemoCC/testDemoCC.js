import { LightningElement, wire, track } from 'lwc';
import ggFormLogo from "@salesforce/resourceUrl/ggHeaderLogo";
import neighborpickListValue from '@salesforce/apex/testDemoCC.getNeighborPickListValue';
import getUserName from '@salesforce/apex/testDemoCC.getUserName';
import createRecord from '@salesforce/apex/testDemoCC.createContact';
import getRecord from '@salesforce/apex/testDemoCC.getChildRec';


export default class TestDemoCC extends LightningElement {

    mplcLogo = ggFormLogo;

    @track value1;
    @track value2;
    @track nameValue;
    @track nameValue1;
    @track nameValue2;
    @track nameValue3;
    @track nameValue4;
    @track nameValue5;
    @track optionsNeigborhood = [];
    @track optionsUser = [];
    @track data = [];

    ggFamilyParentRecId;


    constructor() {
        super();
        var url = window.location.href;
        var urlParams = {};
        var params = url.split("?")[1];
        if (params) {
            params = params.split("&");
            for (var i = 0; i < params.length; i++) {
                var pair = params[i].split("=");
                urlParams[pair[0]] = pair[1];
            }
        }
        this.ggFamilyParentRecId = pair[1];

        console.log('Parent Rec Id==> ' + this.ggFamilyParentRecId);
    }

    @wire(getRecord,{parentRecId:'$ggFamilyParentRecId'})
    getRecordCon({data,error}){
        if(data){
            this.data = data;
            console.log('Data==> '+JSON.stringify(data));
        }
        else if(error){
            console.log('error in else==> '+JSON.stringify.apply(error));
        }
    }

    name1(event) {
        this.nameValue = event.target.value;
        console.log('Value of name==> ' + this.nameValue);
    }
    name2(event) {
        this.nameValue1 = event.target.value;
        console.log('Value of name1==> ' + this.nameValue1);
    }
    dateChange(event) {
        this.nameValue2 = event.target.value;
        console.log('Value of Date2==> ' + this.nameValue2);
    }
    name3(event) {
        this.nameValue3 = event.target.value;
        console.log('Value of name3==> ' + this.nameValue3);
    }
    name4(event) {
        this.nameValue4 = event.target.value;
        console.log('Value of name4==> ' + this.nameValue4);
    }
    numberChange(event) {
        this.nameValue5 = event.target.value;
        console.log('Value of number5==> ' + this.nameValue5);
    }

    @wire(neighborpickListValue)
    getPickValue({ data, error }) {
        if (data) {
            console.log('Data neighbor ==> ' + JSON.stringify(data));
            this.optionsNeigborhood = data.map(option => ({ label: option, value: option }));
            console.log('PicklIst value==> ' + JSON.stringify(this.optionsNeigborhood));
        }
        else if (error) {
            console.log('Error in Picklist neighbor==>' + JSON.stringify(error));
        }
    }

    changeNeigborhood(event) {
        this.value1 = event.target.value;
        console.log('# value1==> ' + this.value1);
    }

    @wire(getUserName)
    allUserName({ data, error }) {
        if (data) {
            console.log('UserName ==> ' + JSON.stringify(data));
            this.optionsUser = data.map(user => ({
                label: user.FirstName ? `${user.FirstName} ${user.LastName}` : user.LastName,
                value: user.Id

            }))
            console.log('this.optionsUser ==> ' + JSON.stringify(this.optionsUser));
        }
        else {
            console.log('Error in  user List==>' + JSON.stringify(error));
        }
    }

    changeUser(event) {
        this.value2 = event.target.value;
        console.log('# value2==> ' + this.value2);
    }

    handleClick() {
        createRecord({ childFirst: this.nameValue, childLast: this.nameValue1, birthDate: this.nameValue2, parentFirst: this.nameValue3, parentLast: this.nameValue4, numberParent: this.nameValue5 })
         .then((result) =>{
            console.log('Data=>'+result);
         })
         .catch((error) =>{
            console.log('error=>'+JSON.stringify(error));
         })
  
    }


}