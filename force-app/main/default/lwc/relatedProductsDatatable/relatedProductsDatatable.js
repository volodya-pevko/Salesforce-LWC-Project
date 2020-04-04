import { LightningElement, track} from 'lwc';

const columns = [
    { label: 'Lead', fieldName: 'name' },
    { label: 'Owner', fieldName: 'website', type: 'url' },
    { label: 'Created by', fieldName: 'createdBy', type: 'phone' },
    { label: 'Last modified by', fieldName: 'lastModifiedBy', type: 'currency' },
];

export default class RelatedProductsDatatable extends LightningElement {
    @track columns = columns;
    @track data = [];
}