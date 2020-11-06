/**
* @description A mapper that retrieves schema information and creates models
* This should only be called by a service.
* This should only return models.
* Since the data is schema-based, we make the assumption that it does not change and cache it
* Note that if this dealt with data, it could be used to perform DML operations based on the models, converting back from the model to underlying data.
*/
public virtual with sharing class MAPR_Schema {

    /**
    * @description Instance for Singleton Pattern
    */
    @TestVisible
    private static MAPR_Schema instance;

    /**
    * @description Empty constructor is not public for Singleton Pattern
    */
    protected MAPR_Schema() {}

    /**
    * @description Static method to get the current instance for Singleton pattern
    * @return The instance of MAPR_Schema.
    */
    public static MAPR_Schema getInstance() {
        if (instance == null) {
            instance = new MAPR_Schema();
        }

        return instance;
    }

    /**
    * @description Lazy loading cache for global describes
    */
    private MODL_GlobalDescribe globalDescribeModel {
        get {
            if (this.globalDescribeModel != null) {
                return this.globalDescribeModel;
 
            }

            this.globalDescribeModel = new MODL_GlobalDescribe(Schema.getGlobalDescribe());
            return this.globalDescribeModel;
        }
        set;
    }

    /**
    * @description A simple method to retrive a model.
    */
    public MODL_GlobalDescribe getGlobalDescribeModel() {
        return this.globalDescribeModel;
    }

    /************************************ Retrieve MODL_DescribeSObject *********************************************************
	*****************************************************************************************************************************
	*****************************************************************************************************************************/
    /*
	* @description Gets an sObject model by its api name
	*/
    public MODL_DescribeSObject getSObjectDescribeModelByApiName(String apiName) {
        //get the value from global describe(parent) map, it uses sObjectType so convert api to sobject type
        Schema.SObjectType sObjectType = this.getSObjectTypeByApiName(apiName);
        MODL_DescribeSObject describeSObjectModel = this.globalDescribeModel.sObjectModelBySObjectType.get(sObjectType);

        // if value from parent exists then return
        if(describeSObjectModel != null) {
            return describeSObjectModel;
        }
        
        // if value is not found, populate the map and return
        return this.getAndCacheSObjectDescribeModel(sObjectType);
    }
    
    /**
	* @description Helper method that gets an sObject token by its api name
	*/
    private Schema.SObjectType getSObjectTypeByApiName(String apiName) {
        Schema.SObjectType sObjectType = this.globalDescribeModel.sObjectTypeByApiName.get(apiName);
        
        if(sObjectType != null) {
            return sObjectType;
        }
        
        //TODO: Labelify
        throw new InvalidParameterValueException('Object Name',apiName);
    }
    
    /**
	* @description Helper method that gets an SObject Describe and caches it
	*/
    public MODL_DescribeSObject getAndCacheSObjectDescribeModel(Schema.SObjectType sObjectType) {
        // create the model
        MODL_DescribeSObject describeSObjectModel = this.getDescribeSObjectModelBySObjectType(sObjectType);
        // add it to the parent map using parent method
        this.globalDescribeModel.addSObjectDescribeModelToMap(sObjectType, describeSObjectModel);
        
        return describeSObjectModel;
    }
    
    /**
	* @description A simple method to retrive a model based on a parameter.
	* Note that a method that returns a list might be used in the case of SObject data to bulkify SOQL queries
	*/
    private MODL_DescribeSObject getDescribeSObjectModelBySObjectType(Schema.SObjectType sObjectType) {
        return new MODL_DescribeSObject(sObjectType.getDescribe());
    }
    
    
    /*************************************** Retrieve MODL_FieldDescribe *********************************************************
	*****************************************************************************************************************************
	*****************************************************************************************************************************/
    
    /*
	* @description Gets an FieldDescribeModel by its api name and objectApiName
	*/
    public MODL_FieldDescribe getFieldDescribeModelByObjectandFieldApiName(String objectApiName, String apiName) {
        //get the value from Object Describe(parent) map, it uses sObjectField so convert fieldAPI to sObjectDescribeResult using its objectAPIName
        //// so first get the parent model using above method and objectApiName and then use it's map (which uses sObjectField)
        MODL_DescribeSObject describeSobjectModel = this.getSObjectDescribeModelByApiName(objectApiName);

        Schema.SObjectType sObjectType = this.getSObjectTypeByApiName(objectApiName);
        Schema.SObjectField sObjectField = sObjectType.getDescribe().fields.getMap().get(apiName);

        MODL_FieldDescribe describeSObjectField = describeSobjectModel.fieldDescribeModelBySObjectField.get(sObjectField);
        
        if (describeSObjectField != null) {
            System.debug('1111 inside not null');
            return describeSObjectField;
        }

        //else put it in the map and return
        System.debug('1111 before calling');
        return this.getAndCacheFieldDescribeModel(sObjectType, sObjectField);

    }
    
    
    /**
	* @description Helper method that gets an FieldDescribe and caches it
	*/
    public MODL_FieldDescribe getAndCacheFieldDescribeModel(Schema.SObjectType sObjectType,  Schema.SObjectField sObjectField) {
        //create the record using constructor
        MODL_FieldDescribe describefieldModel = this.getFieldDescribeModelBySObjectField(sObjectField);

        // use the parent method to add the above model record its map
        this.globalDescribeModel.sObjectModelBySObjectType.get(sObjectType).addFieldDescribeModelToMap(sObjectField, describefieldModel);

        return describefieldModel;
    }
    
    
    /**
	* @description A simple method to retrive FieldDescribeModel based on the parameter Schema.SObjectField
	*/
    private MODL_FieldDescribe getFieldDescribeModelBySObjectField(Schema.SObjectField sObjectField) {
        return new MODL_FieldDescribe(sObjectField.getDescribe());
    }
    
    
    
    /************************************ Retrieve MODL_PicklistFieldDescribe ***************************************************
	*****************************************************************************************************************************
	*****************************************************************************************************************************/
    /*
	* @description Gets an PicklistFieldDescribeModel by object and api name 
	*/
    public MODL_PicklistFieldDescribe getPicklistFieldDescribeModelByObjectAndFieldApiName(String objectApiName, String apiName) {
        //get the value from Field Describe(parent) map if the API Name is picklist, it uses sobjectField so convert fieldAPI to sObjectDescribeResult using its objectAPIName
        //// so first get the parent model using above method and objectApiName and then use it's map (which uses sObjectField)
        MODL_FieldDescribe describeSObjectField = this.getFieldDescribeModelByObjectandFieldApiName(objectApiName, apiName);
        if(describeSObjectField.describeFieldResult.getType().name() != 'PICKLIST') {
            throw new InvalidParameterValueException('Field Name',apiName);
        }
        
        Schema.SObjectType sObjectType = this.getSObjectTypeByApiName(objectApiName);
        Schema.SObjectField sObjectField = sObjectType.getDescribe().fields.getMap().get(apiName);
        if(describeSObjectField.picklistFieldDescribeModelByFieldApiName.get(sObjectField) != null) {
            return describeSObjectField.picklistFieldDescribeModelByFieldApiName.get(sObjectField);
        }
        
        return this.getAndCachePicklistFieldDescribeModel(sObjectType, sObjectField);
        
    }
    
    /**
	* @description Helper method that gets an FieldDescribe and caches it
	*/
    public MODL_PicklistFieldDescribe getAndCachePicklistFieldDescribeModel(Schema.SObjectType sObjectType, Schema.SObjectField sObjectField) {
        // create model using constructor
        MODL_PicklistFieldDescribe picklistFieldDescribeModel = this.getPicklistFieldDescribeModelBySObjectField(sObjectField);
        
        // use the parent method to add the above model record its map and return
        // MODL_FieldDescribe describeSObjectField = this.getFieldDescribeModelByObjectandFieldApiName(objectApiName, apiName);
        globalDescribeModel.sObjectModelBySObjectType.get(sObjectType).fieldDescribeModelBySObjectField.get(sObjectField).addPicklistFieldDescribeModelToMap(sObjectField, picklistFieldDescribeModel);
        return picklistFieldDescribeModel;
        
    }
    
    private MODL_PicklistFieldDescribe getPicklistFieldDescribeModelBySObjectField(Schema.SObjectField sObjectField) {
        return new MODL_PicklistFieldDescribe(sObjectField);
    }
    
}