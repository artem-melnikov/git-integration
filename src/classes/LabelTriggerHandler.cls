public class LabelTriggerHandler extends TriggerHandler{
    public LabelTriggerHandler(){}

    protected override void afterInsert(){
        Label__c newLabel = (Label__c)Trigger.new.get(0);
        Label.createLabel(newLabel.Name, newLabel.Color__c, newLabel.Id);
    }

    protected override void afterDelete(){
        Label__c oldLabel = (Label__c)Trigger.old.get(0);
        Label.deleteLabel(oldLabel.Name);
    }

    protected override void afterUpdate(){
        Label__c oldLabel = (Label__c)Trigger.old.get(0);
        Label__c newLabel = (Label__c)Trigger.new.get(0);
        Label.updateLabel(oldLabel.Name, newLabel.Name, newLabel.Color__c);
    }
}