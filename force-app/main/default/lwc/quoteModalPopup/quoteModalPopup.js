import { LightningElement, api, track } from "lwc";

export default class QuoteModalPopup extends LightningElement {
  @api showModal = false;
  @api message;
  @api modalHeading;

  @track totalPrice;

  @api
  openModal() {
    this.showModal = true;
    //Add quote name
    this.modalHeading = "Quote";
  }

  @api
  closeModal() {
    this.showModal = false;
  }

  @api
  countTotalPrice() {
    this.totalPrice = 0;
  }
}
