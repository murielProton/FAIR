/** *******************************************************************************
 * @Author : Muriel Proton
 * @Company : Modis
 * This class handles all the fonctional logic of the trigger.
 * This class is used in class : WorkTrigger
 * @Interface : I_TriggerHandler
 * @Constructor : None
 * @Parametters : None
 ******************************************************************************* */
public class TH_WorkTrigger extends I_TriggerHandler {
    /**This method acts before insert on sObject agf__ADM_Work__c.
     * It overides beforeInsert() of interface I_TriggerHandler
     * Called by : I_TriggerHandler.run()
     * @Parametters : None
     * @Returns : Void
     */
    public override void beforeInsert() {
        List<agf__ADM_Work__c> workToCreate = new List<agf__ADM_Work__c>();
        for (agf__ADM_Work__c thisWork : (List<agf__ADM_Work__c>)Trigger.New){
                thisWork.Date_Status_New_Starts__c = Datetime.now();      
        }
    }
    /**This method acts before update on sObject agf__ADM_Work__c.
     * It overides beforeUpdate() of interface I_TriggerHandler
     * Called by : I_TriggerHandler.run()
     * @Parametters : None
     * @Returns : Void
     */
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
