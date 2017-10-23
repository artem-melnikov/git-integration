public class LabelTriggerHandler extends TriggerHandler{
    public LabelTriggerHandler(){}

    protected override void afterInsert(){
        Label__c newLabel = (Label__c)Trigger.new.get(0);
        LabelGithubRestService.createLabel(newLabel.Name, newLabel.Color__c);
    }

    protected override void afterDelete(){
        Label__c oldLabel = (Label__c)Trigger.old.get(0);
        LabelGithubRestService.deleteLabel(oldLabel.Name);
    }

    protected override void afterUpdate(){
        Label__c oldLabel = (Label__c)Trigger.old.get(0);
        Label__c newLabel = (Label__c)Trigger.new.get(0);
        LabelGithubRestService.updateLabel(oldLabel.Name, newLabel.Name, newLabel.Color__c);
    }
}