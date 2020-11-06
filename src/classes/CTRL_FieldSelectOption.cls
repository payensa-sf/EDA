/**
* @description Top-level controller class for LWC component
*/
public with sharing class CTRL_FieldSelectOption {

    /**
    * @description Aura enabled entry point that calls appropriate services to pass view models to LWC component
    */
    // @AuraEnabled(cacheable=true)
    // public static VMDL_Combobox getFieldSelectOptions(List<String> apiNameList) {
    //     return new VMDL_Combobox(SRVC_FieldSelectOption.getInstance().getViewModelsFromApiNameList(apiNameList));
    // }

    @AuraEnabled(cacheable=true)
    public static VMDL_Combobox getPickListOptions(String objectAPIName, String fieldAPIName){
        return new VMDL_Combobox(SRVC_FieldSelectOption.getInstance().getViewModelForPicklistFieldActiveEntriesOnObject(objectAPIName, fieldAPIName));
    }

    /**
    * @description Top-level view model for field select options
    */
    public with sharing class VMDL_Combobox {
        @AuraEnabled
        public List<SRVC_FieldSelectOption.VMDL_FieldSelectOption> fieldSelectOptions { get; private set; }

        public VMDL_Combobox(List<SRVC_FieldSelectOption.VMDL_FieldSelectOption> fieldSelectOptions){
            this.fieldSelectOptions = fieldSelectOptions;
        }
    }
}