import { LightningElement, track, api, wire } from "lwc";
import relatedProducts from "@salesforce/apex/QuoteDataProcessing.relatedProducts";

const columns = [
  { label: "Product name", fieldName: "Name" },
  { label: "Price", fieldName: "Price__c", type: "currency" },
  { label: "Amount", fieldName: "Amount__c", type: "number" }
];

export default class RelatedProductsDatatable extends LightningElement {
  @api quoteId;
  @track columns = columns;
  @track data;

  @wire(relatedProducts, { quoteId: "$quoteId" })
  wiredProduct({ error, data }) {
    if (data) {
    // Creating currentData object with same data but another fields for the datatable
      let currentData = [];

      data.forEach((row) => {
        let rowData = {};
        rowData.Name = row.Product__r.Name;
        rowData.Price__c = row.Product__r.Price__c;
        rowData.Amount__c = row.Amount__c;

        currentData.push(rowData);
      });

      this.data = currentData;
    } else if (error) {
      console.log(JSON.stringify(error));
    }
  }
}
