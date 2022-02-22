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
        for (agf__ADM_Work__c thisWork : (List<agf__ADM_Work__c>)Trigger.new){
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
            for (agf__ADM_Work__c newWork :  (List<agf__ADM_Work__c>)Trigger.new) {
                agf__ADM_Work__c oldWork = (agf__ADM_Work__c)Trigger.oldMap.get(newWork.Id);
                // set field Date_Status_New_Ends__c to now   
                if (oldWork.agf__Status__c == 'New' && newWork.agf__Status__c != 'New') {
                    newWork.Date_Status_New_Ends__c = Datetime.now();
                    // set field Duration_MS_Status_New__c with a duration in Milliseconds (Decimal)
                    Util_Duration utilDuration = new Util_Duration(newWork.Date_Status_New_Starts__c, newWork.Date_Status_New_Ends__c);
                    Long timeInMS = utilDuration.calculateTimeInMS();
                    newWork.Duration_MS_Status_New__c = timeInMS;
                    // set field Duration_String_Status_New__c with a string expressing the duration
                    newWork.Duration_String_Status_New__c = Util_Duration.generateAStringFromMS(timeInMS);
                }
            }


    }
}
