import { LightningElement , wire , track , api} from 'lwc';
import {NavigationMixin} from 'lightning/navigation';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent} from "lightning/platformShowToastEvent";
import gettasklist from '@salesforce/apex/getRecordsTask.gettasklist';
import updatetaskdetails from '@salesforce/apex/getRecordsTask.updatetaskdetails';
import deleteTask from '@salesforce/apex/getRecordsTask.deleteTask';
const columns = [
    {label : "Task ID" , fieldName: "Id"},
    {label : "Task Name" , fieldName : "Name" , editable : false},
    {label :"Title" , fieldName: "Title__c" , editable : true},
    {label : "Priority" , fieldName: "Priority__c" , editable : true},
    {label : "Due Date" , fieldName: "Duedate__c" , editable : true},
    {label : "Completed" , fieldName : "Completed__c" , editable : true},
    {label : "Tags" , fieldName: "Tags__c" ,editable : true},
];

export default class FetchAllRecords extends NavigationMixin(LightningElement) {
     
    @track columns = columns;
    @track data = [];
    draftvalues = [];
    @track isTrue = false;

    @wire(gettasklist)
    wiredTaskRecords({data , error}){
        console.log("data: " + JSON.stringify(data))
        if(data){
            this.data = data;
            console.log("Data : "+ JSON.stringify(this.data))

        } else if(error){
            console.log("Error Occured");
        }
    }
    
    handlecreatenavigation(){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes:{
                    objectApiName: 'Task__c',
                    actionName: 'new'
            },
        })

    }
    handleeditnavigation(){
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes:{
                url: 'https://gwensgirls--partial.sandbox.lightning.force.com/lightning/o/Task__c/list?filterName=00BWH0000006tWT2AY'
            },
        })
    }
    handledelete(event){
        const recordId = event.detail.row.Id;

        deleteTask({recordId})
        .then(result=>{
            console.log("Apex " +JSON.stringify(recordId))
            return refreshApex(this.wiredTaskRecords);
        })
        .catch(error =>{
            console.error('Error Deleting Record' + error)
        })
    }

    handleSave(event){
        
        const updatedfield = event.detail.draftValues;
        console.log('Updated field '+ JSON.stringify(updatedfield))

        updatetaskdetails({Taskdata : updatedfield})
        .then(result =>{
            console.log("Apex result" + JSON.stringify(result))
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message : 'Updated Successfully',
                    variant : 'success',

                })            
            )
        })
         .catch(error=>{
            console.error("Error " + JSON.stringify(error));
        })
        
    }
  

}