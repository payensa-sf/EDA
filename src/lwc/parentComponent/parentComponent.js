import { LightningElement } from 'lwc';
import parentObjectCustomLabel from '@salesforce/label/c.parentObjectCustomLabel';

export default class ParentComponent extends LightningElement {
    parentLabel = 'The Drop Down name from Parent';
    parentPlaceHolder = 'The Place Holder From Parent';
    parentObject = parentObjectCustomLabel;
    parentField = 'type';
}