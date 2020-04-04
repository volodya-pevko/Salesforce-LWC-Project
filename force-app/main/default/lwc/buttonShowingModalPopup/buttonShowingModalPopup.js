import { LightningElement } from 'lwc';

export default class ButtonShowingModalPopup extends LightningElement {

    //Button click opens modal window
    handleClick() {
        this.template.querySelector("c-quote-modal-popup").openModal();
    }
}