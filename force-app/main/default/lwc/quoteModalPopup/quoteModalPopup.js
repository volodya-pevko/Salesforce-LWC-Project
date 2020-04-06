import { LightningElement, api, wire, track } from "lwc";
import countTotalPrice from "@salesforce/apex/QuoteDataProcessing.countTotalPrice";

export default class QuoteModalPopup extends LightningElement {
  @api showModal = false;
  @api modalHeading = "Quote";
  @api quoteId;

  @wire(countTotalPrice, { quoteId: "$quoteId" })
  totalPrice;

  @api
  openModal() {
    this.showModal = true;
  }

  @api
  closeModal() {
    this.showModal = false;
  }
}
