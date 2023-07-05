/*------------------------------------------------------------
Author:        Maumita
Company:       Belong
Description:   This page will be called from New Contact button 
                on Account Object
Inputs:        
History
<Date>			<Authors Name>			<Brief Description of Change>
03-Jul-2023     Maumita                  Intial
------------------------------------------------------------*/
import { LightningElement, api, wire } from "lwc";
import { NavigationMixin } from "lightning/navigation";
import { encodeDefaultFieldValues } from "lightning/pageReferenceUtils";
import { getRecord } from "lightning/uiRecordApi";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import ID_FIELD from "@salesforce/schema/Program_Contract__c.Id";

export default class ContactCreation extends NavigationMixin(LightningElement) {
    @api recordId;
    @api programContract;
    @api recordType;
    @api retURL;
    @api recordTypeId;
    @api serviceProvider;

    /*
    @wire(getRecord, {
        recordId: "$recordId",
        fields: [ID_FIELD],
    })*/

    wiredRecord({ error, data }) {
        if (error) {
            let message = 'Unknown error';
            if (Array.isArray(error.body)) {
                message = error.body.map(e => e.message).join(', ');
            } else if (typeof error.body.message === 'string') {
                message = error.body.message;
            }
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error loading contact',
                    message,
                    variant: 'error',
                }),
            );
        } else if (data) {
            this.contractRole = data;
            this.invoke();
        }
    }

    @api
    invoke() {
       /* const defaultValues = encodeDefaultFieldValues({
            Program_Contract__c: this.contractRole.fields.Id.value,
            RecordTypeId : this.recordTypeId,
            Service_Provider__c : this.serviceProvider
        });*/
        this[NavigationMixin.Navigate]({
            type: "standard__objectPage",
            attributes: {
                objectApiName: "Contact",
                actionName: "new",
            },
            /*state: {
                defaultFieldValues: defaultValues,
            },*/
        }, true);
    }
}