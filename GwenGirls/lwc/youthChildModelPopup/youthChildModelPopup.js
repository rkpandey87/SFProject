import { LightningElement,track } from 'lwc';

export default class YouthChildModelPopup extends LightningElement {
  @track isShowModal = false;

    showModalBox() {  
        this.isShowModal = true;
    }

    hideModalBox() {  
        this.isShowModal = false;
    }
}