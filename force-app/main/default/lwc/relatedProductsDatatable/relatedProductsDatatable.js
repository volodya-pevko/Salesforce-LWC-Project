import { LightningElement, track} from 'lwc';

const columns = [
    { label: 'Product name', fieldName: 'name' },
    { label: 'Amount', fieldName: 'website', type: 'url' },
    { label: 'Price', fieldName: 'createdBy', type: 'phone' },
    { label: 'Last modified by', fieldName: 'lastModifiedBy', type: 'currency' },
];

export default class RelatedProductsDatatable extends LightningElement {
    @track columns = columns;
    @track data = [];
}