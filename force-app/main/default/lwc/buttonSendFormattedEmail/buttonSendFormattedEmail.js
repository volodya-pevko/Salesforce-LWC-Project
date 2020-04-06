import { LightningElement, api, track, wire } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import sendEmail from "@salesforce/apex/EmailSender.sendEmail";

export default class ButtonSendFormattedEmail extends LightningElement {
  @api quoteId;
  @api title;
  @api message;

  // Calling Apex sendEmail function with @wire cause imperative way of calling 
  // returns 400 Bad Request response with empty body :(
  @wire(sendEmail, { quoteId: "$quoteId" })
  mailingResult({ error, data }) {
    if (data) {
      console.log(JSON.stringify(data));
      this.title = "Email";
      this.message = data;
    } else if (error) {
      this.title = "Error";
      this.message = error.message;
      console.log(JSON.stringify(error));
    }
  }

  // Button "Send" click only shows message
  handleClick() {
    const evt = new ShowToastEvent({
      title: this.title,
      message: this.message
    });
    this.dispatchEvent(evt);
  }
}
