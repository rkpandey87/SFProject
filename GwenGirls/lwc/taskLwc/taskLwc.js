import { LightningElement, track , wire} from 'lwc';

import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import Task_object_field from '@salesforce/schema/Task__c.Completed__c';

import saveTask from '@salesforce/apex/TaskController.saveTask';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class TaskLwc extends LightningElement {

    @wire(getObjectInfo, { objectApiName: 'Task__c' })
    objectInfo;
    @track title = '';
    @track ischecked = false;
    @track priority = '';
    //@track tags = '';
    @track DueDate = null;
    @track tags = [];

   // set completed(newValue){
 //       this.completed = newValue;
   //     this.template.querySelector('lightning-input.cb').checked = newValue;
 //   }
  //  get completed(){
 //       return  this.completed;
 //   }
    

  

    @track options = [
        {label: 'In progress' , value: 'In progress'},
        {label: 'About to complete', value: 'About to complete'},
        {label: 'going to next stage' , value: 'going to next stage'},
        {label:'Done' , value: 'Done'},
        {label: 'planning for deployement' , value: 'planning for deployement'}

    ];

    

    priorityoptions = [
        { label: 'High' , value: 'High' },
        { label:'Medium' , value: 'Medium'},
        { label: 'Low' , value: 'Low'}
    ];


    handletitlechange(event){
        this.title = event.target.value;
    }

    handlecompletedchange(event){

       this.ischecked = event.target.checked;
       console.log('Chcekbox value ' , this.ischecked);
   }
     
    handleprioritychange(event){
        this.priority = event.detail.value;
    }
   //handleTagsChange(event){
    //    this.tags = event.target.value;
  // }
    handleDueDateChange(event){
        this.DueDate = event.target.value;
    }
    handleSelectionChange(event) {
        this.tags = event.target.value;
    }

    @wire(saveTask, { title: '$title', ischecked: '$ischecked', priority: '$priority', tags: '$tags', dueDate: '$DueDate' , selectedValues: '$selectedValues' })
    wiredSaveTask({ error, data }) {
        if (data) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Record saved successfully',
                    variant: 'success'
                })
            );
            this.resetForm();
        } else if (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Error saving record',
                    variant: 'error'
                })
            );
            
            console.error('Error saving record:', error);
        }
    }

    handlesave() {
        console.log('handleSave method called');
        
        // Validate if required fields are filled before attempting to save
        if (!this.title || !this.priority || !this.DueDate) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Please fill in all required fields (Title, Priority, Due Date)',
                    variant: 'error',
                })
            );
            //code new
            
            return;
        }
        console.log( 'Checkbox value ' ,this.ischecked);
        // Call the wired method to save data
        saveTask({ title: this.title, Completed: this.ischecked , priority: this.priority, Duedate: this.DueDate , tags: this.tags ,selectedValues: this.selectedValues , });
        if (saveTask) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Record saved successfully',
                    variant: 'success'
                })
            );
        this.resetForm();
        }
    }
    
   /* handlesave(){

        console.log('handleSave method called');
        const taskData = {

            title: this.title,
           // completed: this.completed,
            priority: this.priority,
           // tags: this.tags.split(',').map(tag => tag.trim) ,
            Duedate: this.DueDate,
             selectedValues: this.selectedValues
        };
        console.log('Task Data:', taskData);
        saveTask({ taskData: taskData }).then (result => {
            // Handle success
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Record saved successfully',
                    variant: 'success'
                })
            );
            this.resetForm();
        })
        .catch(error => {
            // Handle error
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Error saving record',
                    variant: 'error'
                })
            );
            console.error('Error saving record:', error);
        });
    }
    */


    resetForm() {
        this.title = '';
        //this.completed = false;
        this.ischecked= false;
        this.priority = '';
        this.tags = '';
        this.dueDate = null;

    }
}