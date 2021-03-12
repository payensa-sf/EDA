import { LightningElement, api, track, wire } from "lwc";

import getAccountModelSettingsViewModel from "@salesforce/apex/AccountModelSettingsController.getAccountModelSettingsViewModel";

import stgAccountModelSettingsTitle from "@salesforce/label/c.stgAccountModelSettingsTitle";
import stgAccModelTitle from "@salesforce/label/c.stgAccModelTitle";
import stgHelpAccountModel from "@salesforce/label/c.stgHelpAccountModel";
import stgAdminAccountRecordType from "@salesforce/label/c.stgAdminAccountRecordType";
import stgHelpAdminRecType from "@salesforce/label/c.stgHelpAdminRecType";
import stgAccountRecordTypeSupportsHHAddress from "@salesforce/label/c.stgAccountRecordTypeSupportsHHAddress";
import stgHelpHouseholdRecType from "@salesforce/label/c.stgHelpHouseholdRecType";

export default class AccountModelSettings extends LightningElement {
    isEditMode = false;
    affordancesDisabledToggle = false;

    get affordancesDisabled() {
        if (!this.isEditMode || this.affordancesDisabledToggle === true) {
            return true;
        }
        return undefined;
    }

    labelReference = {
        stgAccountModelSettingsTitle,
        stgAccModelTitle,
        stgHelpAccountModel,
        stgAdminAccountRecordType,
        stgHelpAdminRecType,
        stgAccountRecordTypeSupportsHHAddress,
        stgHelpHouseholdRecType,
    };

    @wire(getAccountModelSettingsViewModel) accountModelSettingsViewModel;

    handleDefaultAccountModelChange(event) {
        console.log("Default Account model changed");
    }

    handleHouseholdAccountModelChange(event) {
        console.log("HH Account model changed");
    }

    handleAdministrativeAccountModelChange(event) {
        console.log("Admin Account model changed");
    }

    handleSettingsEditModeChange(event) {
        this.isEditMode = !event.detail;
        this.affordancesDisabledToggle = event.detail;

        this.refreshAllApex();
    }

    handleSettingsSaving(event) {
        this.affordancesDisabledToggle = true;
        this.template.querySelector("c-settings-save-canvas").updateHierarchySettings();
    }

    handleSettingsSaveCompleted(event) {
        this.affordancesDisabledToggle = false;
    }

    refreshAllApex() {}
}
