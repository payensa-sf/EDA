import { LightningElement, api, wire, track } from 'lwc';
import getFieldSelectOptions from '@salesforce/apex/CTRL_PicklistSelectOption.getFieldSelectOptions';
export default class dropDown extends LightningElement {
    
    @api dropDownLabel;
    @api dropDownPlaceHolder;
    @api objectApiName;
    @api fieldApiName;
		@track options = [];
    @track value = '';
		@track label;

    @wire(getFieldSelectOptions, { objectName: '$objectApiName', fieldAPIName: '$fieldApiName' })wiredPicklistViewModel;
		get comboboxOptions() {
        if(!this.wiredPicklistViewModel.data) {
            return null;
        }

        return this.wiredPicklistViewModel.data.fieldSelectOptions;

    }
    handleChange(event) {
        this.value = event.detail.value;
    }
}