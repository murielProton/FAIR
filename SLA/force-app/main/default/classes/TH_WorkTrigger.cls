public class TH_WorkTrigger {
    public void run(){
        if(Trigger.isInsert && Trigger.isBefore){
            beforeInsert();
        }
        if(Trigger.isUpdate && Trigger.isBefore){
            beforeUpdate();
        }
    }
    public void beforeInsert() {
        List<agf__ADM_Work__c> workToCreate = new List<agf__ADM_Work__c>();
        for (agf__ADM_Work__c thisWork : (List<agf__ADM_Work__c>)Trigger.New){
                thisWork.Status_New_Assigned_on__c = Datetime.now();      
        }
    }
    public void beforeUpdate() {
        System.debug('bedfore Update inside');
         

            for (Id workID :  trigger.newMap.Keyset()) {

                agf__ADM_Work__c oldWork = (agf__ADM_Work__c)trigger.OldMap.get(workID);
                
                agf__ADM_Work__c newWork = (agf__ADM_Work__c)trigger.NewMap.get(workID);
                
                if (oldWork.agf__Status__c == 'New' && newWork.agf__Status__c != 'New') {
                    System.debug('old Work'+ oldWork.agf__Status__c);
                    System.debug('old Work'+ newWork.agf__Status__c);
                    newWork.Status_New_Changed_on__c =Datetime.now();
                }
   
        }

    }
}
