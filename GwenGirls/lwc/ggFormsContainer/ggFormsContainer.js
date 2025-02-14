import { LightningElement,wire,track } from 'lwc';
//import { refreshApex } from '@salesforce/apex';
//import insertIntake from '@salesforce/apex/GGMainFormController.saveIntakeData';
import getfetchParentRecList from '@salesforce/apex/GGMainFormController.filterContactRecAsPerRecType';
import { NavigationMixin } from 'lightning/navigation';
import ggFormLogo from "@salesforce/resourceUrl/ggHeaderLogo";
//import insertContact from '@salesforce/apex/GGMainFormController.saveContactData';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class GgFormsContainer extends NavigationMixin(LightningElement) {
		mplcLogo= ggFormLogo;
    @track openModal = false;
    @track openModalForMPLC = false; 
		
    @track ExistingParentModalPopup= false;
    @track ExistingParentModalMPLCForm= false; 
    @track NewParentModalPopup= false;
    @track openClientInfoSection= false;
		
		/* caring connections  */
		
		 @track openModalForCaringConnections = false;
		 @track ExistingParentModalCaringConnections= false;
		@track NewParentModalCaringConnections= false;
		
   // @track conParentlstObjData;
   conParentlstObjData;
   getParentRecId;
   getParentEmail;

    propertyToTransfer = 'Hello from Sender!';

   // @track disableBtn = false;
		fName;
		lName;
        pin;

      
       
     
        
       /*    Youth Form           */ 


    showModalOfYouthForm(){
        this.openModal=true;  
    }

    // New Parent Case In Youth Development Intake Form    
    InsertRecordForm(){
       // this.NewParentModalPopup= true;
       var recId='nullId';
           console.log('contact Record Id=====> '+recId);
				
             this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url:'/youthpage/?ContactId=' +recId  
                },
              
            });
    }

   

		   /*    MPLC Form         */ 
    showModalOfMPLCForm(){
        this.openModalForMPLC=true;  
    }
  

    closeModalOfMPLCForm(){
        this.openModalForMPLC = false;
    }


   searchExistingRecForMPLC(){
    this.ExistingParentModalMPLCForm= true;
}


		closeModal() {
				this.openModal = false;

		}

    cancelModal(){
        this.ExistingParentModalPopup= false;
        this.NewParentModalPopup= false;
        this.openClientInfoSection=false;
        this.ExistingParentModalMPLCForm= false;
    }

    searchExistingRecord(){
        this.ExistingParentModalPopup= true;
    }
		
		 /*    Caring Connections Form   */
		showModalOfCaringConnectionForm(){
				this.openModalForCaringConnections=true;
		}
		 closeModalOCaringConnections(){
        this.openModalForCaringConnections = false;
    }
		
		InsertNewRecordForCaringConnections(){
				var recId='nullId';
           console.log('contact Record Id=====> '+recId);
				
          //   alert(JSON.stringify(this.conParentlstObjData));
             this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    // url:'/caringconnectionsintake/?ContactId=' +recId 
                    url:'/caringconnectionform/?ContactId=' +recId 

                },
              
            });
		}
		
		searchExistingRecForCaringConnections(){
				 this.ExistingParentModalCaringConnections= true;
		}
		
 cancelModalForCaringConnections(){
		 this.ExistingParentModalCaringConnections= false;
 }
		
		
		redirectToCaringConnectionForm(){
				  var recId= this.getParentRecId;
         //  alert(JSON.stringify(this.conParentlstObjData));
         if(this.conParentlstObjData.length === 0){
                        const evt = new ShowToastEvent({
                            title: 'Parent Not Found',
                            message: 'Parent Not Found',
                            variant: 'Error',
                        });
                        this.dispatchEvent(evt);
        }else{
            //alert(JSON.stringify(this.conParentlstObjData));
           
            this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                   // url: 'https://gwensgirls--partial.sandbox.my.site.com/mainForm/s/mplc-form'
                    url: '/caringconnectionform/?ContactId=' +recId 
                },
            
            });
        }
		}
		
		

		handleInputfNameChange(event){
				this.fName= event.detail.value;
                //alert(this.fName);
		}
		
		handleInputlNameChange(event){
					this.lName= event.detail.value;
                   // alert(this.lName);
		}

        handleInputPinChange(event){
            this.pin= event.detail.value;
        }


@wire(getfetchParentRecList,{firstName: "$fName", lastName:"$lName", Pin:"$pin"})
wiredContactWrappers({ error, data }) {
    if (data) {
      //  alert(JSON.stringify(data));
        // Data is available, perform validation
        this.conParentlstObjData = data;

        // fetched parentRecordId from Wrapper list and binds into a user define variable.
        this.getParentRecId = data.map(wrapperList => wrapperList.ggParentRecId);
       // alert(this.getParentRecId);
     

    } else if (error) {
        // Handle the error
        this.handleError(error.body.message);
    }
}

//Existing Parent Case in youth Devvelopment form
filterParentAsPerRecTypeInYouth() {
    var recId= this.getParentRecId;
         //  alert(JSON.stringify(this.conParentlstObjData));
         if(this.conParentlstObjData.length === 0){
                        const evt = new ShowToastEvent({
                            title: 'Parent Not Found',
                            message: 'Parent Not Found',
                            variant: 'Error',
                        });
                        this.dispatchEvent(evt);
        }else{
            //alert(JSON.stringify(this.conParentlstObjData));
           
            this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                   // url: 'https://gwensgirls--partial.sandbox.my.site.com/mainForm/s/mplc-form'
                    url: '/youthpage/?ContactId=' +recId 
                },
            
            });
        }
        }

//Existing Parent Case in MPLC form
getParentRecordAsPerRecType() {
    var recId= this.getParentRecId;
         //  alert(JSON.stringify(this.conParentlstObjData));
         if(this.conParentlstObjData.length === 0){
                        const evt = new ShowToastEvent({
                            title: 'Parent Not Found',
                            message: 'Parent Not Found',
                            variant: 'Error',
                        });
                        this.dispatchEvent(evt);
        }else{
       //     alert(JSON.stringify(this.conParentlstObjData));
           
            this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                   // url: 'https://gwensgirls--partial.sandbox.my.site.com/mainForm/s/mplc-form'
                    // url: '/mplc-form/?ContactId=' +recId 
                     url: '/forms/?type=MPLC&ContactId=' +recId 
                },
            
            });

             


        }
        }



        InsertRecordFormForMPLC(){
          //  var recId= this.getParentRecId;
        
           var recId='nullId';
           console.log(recId);  
          //   alert(JSON.stringify(this.conParentlstObjData));
             this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                //    url:'/mplc-form/?ContactId=' +recId  
                   url: '/forms/?type=MPLC&ContactId=' +recId 
                },
              
            });
           //this.dispatchEvent(new CustomEvent('forcerefreshview'));
           // location.reload();
         }

/*
editClientInfoSection(){
    this.openClientInfoSection=true;
}
*/

showContactSuccessToast() {
    const evt = new ShowToastEvent({
        title: 'Toast Success',
        message: 'GG Family Member(Contact) record created successfully!',
        variant: 'success',
        mode: 'dismissable'
    });
    this.dispatchEvent(evt);
}

showIntakeSuccessToast() {
    const evt = new ShowToastEvent({
        title: 'Toast Success',
        message: 'Youth Development Intake record created successfully!',
        variant: 'success',
        mode: 'dismissable'
    });
    this.dispatchEvent(evt);
}

showErrorToast() {
    const evt = new ShowToastEvent({
        title: 'Toast Error',
        message: 'Some unexpected error',
        variant: 'error',
        mode: 'dismissable'
    });
    this.dispatchEvent(evt);
}

}