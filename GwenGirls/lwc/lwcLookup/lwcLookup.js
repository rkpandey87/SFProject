import { LightningElement, track, wire, api } from "lwc";  
 import findRecords from "@salesforce/apex/LwcLookupController.findRecords";  
 export default class LwcLookup extends LightningElement {  
  @track recordsList;  
  @track searchKey = "";  
  @api selectedValue;  
  @api selectedRecordId;  
  @api objectApiName;  
  @api iconName;  
  @api lookupLabel;  
  @track message;  
  @api child1school='';

  connectedCallback() {
    console.log('test');
    /*if(this.child1school!=null && this.child1school!=''){
      this.selectedRecordId = this.child1school;
      this.selectedValue = 'School3';
    }*/
  }
    
  onLeave(event) {  
   setTimeout(() => {  
    this.searchKey = "";  
    this.recordsList = null;  
   }, 300);  
  }  
    
  onRecordSelection(event) {  
   this.selectedRecordId = event.target.dataset.key;  
   this.selectedValue = event.target.dataset.name;  
   this.searchKey = "";  
   this.onSeletedRecordUpdate();  
  }  

  onRecordSelectionHelper(recordId,Value){
    this.selectedRecordId = recordId;
    this.selectedValue = Value;
    this.searchKey = "";  
    this.onSeletedRecordUpdate(); 
  }


   
  handleKeyChange(event) {  
   const searchKey = event.target.value;  
   this.searchKey = searchKey;  
   this.getLookupResult();  
  }  
   
  removeRecordOnLookup(event) {  
   this.searchKey = "";  
   this.selectedValue = null;  
   this.selectedRecordId = null;  
   this.recordsList = null;  
   this.onSeletedRecordUpdate();  
 }  
 getLookupResult() {  
    findRecords({ searchKey: this.searchKey, objectName : this.objectApiName })  
     .then((result) => {  
      if (result.length===0) {  
        this.recordsList = [];  
        this.message = "No Records Found";  
       } else {  
        this.recordsList = result;  
        this.message = "";  
       }  
       this.error = undefined;  
     })  
     .catch((error) => {  
      this.error = error;  
      this.recordsList = undefined;  
     });  
   }  
    
   onSeletedRecordUpdate(){  
    const passEventr = new CustomEvent('recordselection', {  
      detail: { selectedRecordId: this.selectedRecordId, selectedValue: this.selectedValue }  
     });  
     this.dispatchEvent(passEventr);  
   }  
  }