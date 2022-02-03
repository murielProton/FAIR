trigger WorkTrigger on agf__ADM_Work__c (after insert) {
    List<agf__ADM_Work__c> workToCreate = new List<agf__ADM_Work__c>();
    for (agf__ADM_Work__c thisWork : [SELECT Id FROM agf__ADM_Work__c WHERE Id IN :Trigger.New]){
            thisWork.Status_New_Assigned_on__c = Datetime.now();
            workToCreate.add(thisWork);       
    }
    update workToCreate;
}