/**
* @description Model to view model mapper service
* This ideally should return only view models
* This is should be called by controllers or other view model mapper services and call services necessary to get the models it requires.
*/
public virtual with sharing class SRVC_PicklistSelectOption {
    /**
    * @description Instance for Singleton Pattern
    */
    @TestVisible
    private static SRVC_PicklistSelectOption instance;

    /**
    * @description Empty constructor is not public for Singleton Pattern
    */
    protected SRVC_PicklistSelectOption(){}

    /**
    * @description Static method to get the current instance for Singleton pattern
    * @return The instance of MAPR_Schema.
    */
    public static SRVC_PicklistSelectOption getInstance() {
        if (instance == null) {
            instance = new SRVC_PicklistSelectOption();
        }

        return instance;
    }

    /**
    * @description Method to get view models specified by controller
    */
    public List<VMDL_PicklistSelectOption> getPicklistViewModelsFromObjectAndFieldAPI(String objectAPIName, String fieldAPIName) {

        MODL_PicklistFieldDescribe picklistModel =  SRVC_Schema.getInstance().getPicklistFieldDescribeModelsByObjectAndFieldApiNameList(objectAPIName, new List<String>{fieldAPIName})[0];

        List<VMDL_PicklistSelectOption> picklistViewModelList = new List<VMDL_PicklistSelectOption>();
        for (Schema.PicklistEntry eachEntry: picklistModel.activePicklistEntryByApiName.values()) {
             VMDL_PicklistSelectOption picklistViewModel = new VMDL_PicklistSelectOption(eachEntry.getLabel(),eachEntry.getValue());
             picklistViewModelList.add(picklistViewModel);
        }

        return picklistViewModelList;
    }

    /**
    * @description View model for field select options
    */
    public with sharing class VMDL_PicklistSelectOption {
        public VMDL_PicklistSelectOption(){}

        public VMDL_PicklistSelectOption(String value, String label) {
        this.value = value;
        this.label = label;
        this.disabled = false;
        this.escapeItem = false;
    }

    public VMDL_PicklistSelectOption(String value, String label, Boolean isDisabled) {
        this.value = value;
        this.label = label;
        this.disabled = isDisabled;
        this.escapeItem = false;
    }

    @AuraEnabled
    public String label { get;set; }
        
    @AuraEnabled
    public String value { get;set; }
        
    @AuraEnabled
    public Boolean disabled { get;set; }
        
    @AuraEnabled
    public Boolean escapeItem { get;set; }
    
    }
}