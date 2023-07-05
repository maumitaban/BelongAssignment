
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
import { getRecord,getFieldValue } from "lightning/uiRecordApi";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ACCOUNT_ID from "@salesforce/schema/Account.Id";

const FIELDS = [ACCOUNT_ID];

export default class CreateOrder extends NavigationMixin(LightningElement) {
    @api recordId;
    @api programContract;
    @api recordType;
    @api retURL;
    @api recordTypeId;
    @api serviceProvider;

    @wire(getRecord, { recordId: "$recordId", fields: FIELDS })
    accfield;

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
                    title: 'Error loading order',
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
        let accId = getFieldValue(this.accfield.data, ACCOUNT_ID);
        const defaultValues = encodeDefaultFieldValues({
           AccountId: accId
        });
        this[NavigationMixin.Navigate]({
            type: "standard__objectPage",
            attributes: {
                objectApiName: "Order",
                actionName: "new",
            },
            state: {
                defaultFieldValues: defaultValues,
            },
        }, true);
    }
}