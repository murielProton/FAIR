public class TH_WorkTrigger extends I_TriggerHandler {
    public override void beforeInsert() {
        List<agf__ADM_Work__c> workToCreate = new List<agf__ADM_Work__c>();
        for (agf__ADM_Work__c thisWork : (List<agf__ADM_Work__c>)Trigger.New){
                thisWork.Date_Status_New_Starts__c = Datetime.now();      
        }
    }
    public override void beforeUpdate() {
            for (Id workID :  trigger.newMap.Keyset()) {
                agf__ADM_Work__c oldWork = (agf__ADM_Work__c)trigger.OldMap.get(workID);      
                agf__ADM_Work__c newWork = (agf__ADM_Work__c)trigger.NewMap.get(workID);               
                if (oldWork.agf__Status__c == 'New' && newWork.agf__Status__c != 'New') {
                    newWork.Date_Status_New_Ends__c =Datetime.now();
                    
                }
   
        }

    }
}