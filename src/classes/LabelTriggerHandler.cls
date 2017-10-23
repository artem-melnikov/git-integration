public class LabelTriggerHandler extends TriggerHandler{
    public LabelTriggerHandler(){}

    protected override void afterInsert(){
        Label__c newLabel = (Label__c)Trigger.new.get(0);

        Map<String,String> paramsMap = new Map<String,String>();
        paramsMap.put('name',(String)newLabel.Name);
        paramsMap.put('color',(String)newLabel.Color__c);
        String paramsJSON = JSON.serialize(paramsMap);

        BaseProvider provider = new BaseProvider();
        provider.request('GitHubRestService', 'LabelGithubRestService', 'createLabel', paramsJSON);
    }


    protected override void afterDelete(){
        Label__c oldLabel = (Label__c)Trigger.old.get(0);

        Map<String,String> paramsMap = new Map<String,String>();
        paramsMap.put('name',(String)oldLabel.Name);
        String paramsJSON = JSON.serialize(paramsMap);

        BaseProvider provider = new BaseProvider();
        provider.request('GitHubRestService', 'LabelGithubRestService', 'deleteLabel', paramsJSON);
    }


    protected override void afterUpdate(){
        Label__c oldLabel = (Label__c)Trigger.old.get(0);
        Label__c newLabel = (Label__c)Trigger.new.get(0);

        Map<String,String> paramsMap = new Map<String,String>();
        paramsMap.put('name',(String)newLabel.Name);
        paramsMap.put('color',(String)newLabel.Color__c);
        paramsMap.put('oldName',(String)oldLabel.Name);
        String paramsJSON = JSON.serialize(paramsMap);

        BaseProvider provider = new BaseProvider();
        provider.request('GitHubRestService', 'LabelGithubRestService', 'updateLabel', paramsJSON);
    }
}