import { LightningElement, api } from "lwc";

export default class ButtonShowingModalPopup extends LightningElement {
  @api recordId;

  //Button click opens modal window
  handleClick() {
    this.template.querySelector("c-quote-modal-popup").openModal();
  }
}
