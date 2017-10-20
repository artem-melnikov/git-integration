trigger LabelTrigger on Label__c (after insert, after delete, after update) {
    system.debug('triggers');
    new LabelTriggerHandler().run();
}