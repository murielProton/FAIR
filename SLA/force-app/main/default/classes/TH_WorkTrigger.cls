public class TH_WorkTrigger {
    public void run(){
        if(Trigger.isInsert && Trigger.isAfter){
            afterInsert();
        }
        if(Trigger.isUpdate && Trigger.isBefore){
            beforeUpdate();
        }
    }
    public void afterInsert() {
        List<agf__ADM_Work__c> workToCreate = new List<agf__ADM_Work__c>();
        for (agf__ADM_Work__c thisWork : [SELECT Id FROM agf__ADM_Work__c WHERE Id IN :Trigger.New]){
                thisWork.Status_New_Assigned_on__c = Datetime.now();
                workToCreate.add(thisWork);       
        }
        update workToCreate;
    }
    public void beforeUpdate() {
        List<agf__ADM_Work__c> workToCreate = new List<agf__ADM_Work__c>();
        for (agf__ADM_Work__c thisWork : [SELECT Id FROM agf__ADM_Work__c WHERE Id IN :Trigger.New]){
                thisWork.Status_New_Assigned_on__c = Datetime.now();
                workToCreate.add(thisWork);       
        }
        update workToCreate;
    }
}
