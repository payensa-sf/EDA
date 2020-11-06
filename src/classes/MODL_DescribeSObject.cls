public with sharing class MODL_DescribeSObject {

    
    public Schema.DescribeSObjectResult sObjectDescribeResult { get; private set; }
    public Map<String, Schema.SObjectField> sObjectFieldByApiName { get; private set; }
    public Map<String, Schema.SObjectField> sObjectFieldByLabel { get; private set; }
    public Map<Schema.SObjectField, MODL_fieldDescribe> fieldDescribeModelBySObjectField { get; private set; }
    
    public MODL_DescribeSObject(Schema.DescribeSObjectResult sObjectDescribeResult) {
        this.sObjectDescribeResult = sObjectDescribeResult;
        this.fieldDescribeModelBySObjectField = new Map<Schema.SObjectField, MODL_fieldDescribe>();
        this.sObjectFieldByApiName = sObjectDescribeResult.fields.getMap();
        this.sObjectFieldByLabel = new Map<String, Schema.SObjectField>();
        for (Schema.SObjectField token: sObjectFieldByApiName.values()) {
             sObjectFieldByLabel.put(token.getDescribe().getLabel(), token);
        }
    }


    public String label {
        get {
            return sObjectDescribeResult.getLabel();
        }
    }

    public String apiName {
        get {
            return sObjectDescribeResult.getName();
        }
    }

    public String localApiName {
        get {
            return sObjectDescribeResult.getLocalName();
        }
    }
    
  
    public void addFieldDescribeModelToMap(Schema.SObjectField sObjectField, MODL_fieldDescribe fieldDescribeModel) {
        this.fieldDescribeModelBySObjectField.put(sObjectField, fieldDescribeModel);
    }
}