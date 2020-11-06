public virtual with sharing class MODL_FieldDescribe {

    public Schema.DescribeFieldResult describeFieldResult { get; private set; }
    public Map<Schema.SObjectField, MODL_PicklistFieldDescribe> picklistFieldDescribeModelByFieldApiName { get; private set; }

    public String label { 
        get { return describeFieldResult.getLabel(); }
    }

    public String apiName { 
        get { return describeFieldResult.getName(); }
    }

    public String localName { 
        get { return describeFieldResult.getLocalName(); }
    }

    public MODL_FieldDescribe(){}

    public MODL_FieldDescribe(Schema.DescribeFieldResult describeFieldResult) {
        this.describeFieldResult = describeFieldResult;
        this.picklistFieldDescribeModelByFieldApiName = new Map<Schema.SObjectField, MODL_PicklistFieldDescribe>();
    }


    public void addPicklistFieldDescribeModelToMap(Schema.SObjectField sObjectField, MODL_PicklistFieldDescribe pickListFieldDescribeModel) {
        this.picklistFieldDescribeModelByFieldApiName.put(sObjectField, pickListFieldDescribeModel);
    }
}