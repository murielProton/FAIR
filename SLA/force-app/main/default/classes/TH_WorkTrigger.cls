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
            //  this if is more permissif for Batches and Tests classes
            if(thisWork.Date_Status_New_Starts__c == null){
                thisWork.Date_Status_New_Starts__c = Datetime.now();   
            }else{
                continue;
            }   
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
                /* TODO Get the reccord Type : is it a bug or a user story 
                NB apparently it is best to get the developpers name of the type, as the id can change depending on the org it is deployed on.*/
                String newWorkRecordType = Schema.SObjectType.agf__ADM_Work__c.getRecordTypeInfosById().get(newWork.recordTypeId).getDeveloperName();
                System.debug(newWorkRecordType);
                // set field Date_Status_New_Ends__c to now   
                if (oldWork.agf__Status__c == 'New' && newWork.agf__Status__c != 'New') {
                    newWork.Date_Status_New_Ends__c = Datetime.now();
                    // set environement of Util duration
                    Util_Duration duration = new Util_Duration(newWork.Date_Status_New_Starts__c, newWork.Date_Status_New_Ends__c);
                    // calulate and set field Duration_MS_Status_New__c with a duration in Milliseconds (Decimal)
                    Long timeInMS = duration.calculateDurationInfMS();
                    newWork.Duration_MS_Status_New__c = timeInMS;
                    // set field Duration_String_Status_New__c with a string expressing the duration
                    newWork.Duration_String_Status_New__c = Util_Duration.generateAStringFromMS(timeInMS);
                }
                //Conditions for User Story type of reccord
                if (newWorkRecordType == 'User_Story'){
                    if (oldWork.agf__Status__c != 'Workload DONE' && 
                        newWork.agf__Status__c == 'Workload DONE'){
                        // set field Date_Status_Workload_DONE_Starts__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_Workload_DONE_Starts__c = Datetime.now();
                        // stop timer on Duration_In_MS_To_Respond_To_A_US__c
                        newWork.Duration_In_MS_To_Respond_To_A_US__c = UTIL_ServiceLevelAgreement.calculateDurationInMSToRespondToAUS(newWork);
                    }
                    if (oldWork.agf__Status__c == 'Workload DONE' && newWork.agf__Status__c != 'Workload DONE'){
                        // set field newWork.Date_Status_Workload_DONE_Ends__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_Workload_DONE_Ends__c = Datetime.now();
                        // set environement of Util duration
                        // SOLUTION : NOT THE RIGHT DATE SET: LINE 54 and LINE 57 !! COMPARE
                        Util_Duration duration = new Util_Duration(newWork.Date_Status_Workload_DONE_Starts__c, newWork.Date_Status_Workload_DONE_Ends__c);
                        // calulate and set field Duration_MS_Status_Workload_DONE__c with a duration in Milliseconds (Decimal)
                        Long timeInMS = duration.calculateDurationInfMS();
                        newWork.Duration_MS_Status_Workload_DONE__c = timeInMS;
                        // set field Duration_String_Status_Workload_DONE__c with a string expressing the duration
                        newWork.Duration_String_Status_Workload_DONE__c = Util_Duration.generateAStringFromMS(timeInMS);
                    }
                    if (oldWork.agf__Status__c != 'OK For DEV' && newWork.agf__Status__c == 'OK For DEV'){
                        // set field Date_Status__Starts__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_OK_For_DEV_Starts__c = Datetime.now();
                    }//FROM THEN ON MY TESTS ARE FAILING ME WHY?
                    if (oldWork.agf__Status__c == 'OK For DEV' && newWork.agf__Status__c != 'OK For DEV'){
                        // set field newWork.Date_Status_OK_For_DEV_Ends__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_OK_For_DEV_Ends__c = Datetime.now();
                        // set environement of Util duration
                        Util_Duration duration = new Util_Duration(newWork.Date_Status_OK_For_DEV_Starts__c, newWork.Date_Status_OK_For_DEV_Ends__c);
                        // calulate and set field Duration_MS_Status_OK_For_DEV__c with a duration in Milliseconds (Decimal)
                        Long timeInMS = duration.calculateDurationInfMS();
                        newWork.Duration_MS_Status_OK_For_DEV__c = timeInMS;
                        // set field Duration_String_Status_OK_For_DEV__c with a string expressing the duration
                        newWork.Duration_String_Status_OK_For_DEV__c = Util_Duration.generateAStringFromMS(timeInMS);
                    }
                    if (oldWork.Duration_MS_Status_New__c != null || oldWork.Duration_MS_Status_OK_For_DEV__c != null ||
                        oldWork.Duration_MS_Status_Workload_DONE__c != null || newWork.Duration_MS_Status_New__c != null ||
                        newWork.Duration_MS_Status_OK_For_DEV__c != null || newWork.Duration_MS_Status_Workload_DONE__c != null){
                        // set field Duration_In_MS_To_Respond_To_A_US__c
                        newWork.Duration_In_MS_To_Respond_To_A_US__c = UTIL_ServiceLevelAgreement.calculateDurationInMSToRespondToAUS(newWork);
                    }
                    if(oldWork.Duration_In_MS_To_Respond_To_A_US__c == null && newWork.Duration_In_MS_To_Respond_To_A_US__c != null){
                        Long durationToRespondToBug = (Long)newWork.Duration_In_MS_To_Respond_To_A_US__c;
                        // set field Duration_In_String_To_Respond_To_A_US__c
                        newWork.Duration_In_String_To_Respond_To_A_US__c = UTIL_Duration.generateAStringFromMS(durationToRespondToBug);
                    }
                    //Conditions for Bug Type of records
                }else if (newWorkRecordType == 'Bug'){
                    if (oldWork.agf__Status__c != 'DEV - In Progress' && newWork.agf__Status__c == 'DEV - In Progress'){
                        // set field Date_Status_DEV_IP_Starts__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_DEV_IP_Starts__c = Datetime.now();
                    }
                    if (oldWork.agf__Status__c == 'DEV - In Progress' && newWork.agf__Status__c != 'DEV - In Progress'){
                        // set field Date_Status_DEV_IP_Ends__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_DEV_IP_Ends__c = Datetime.now();
                        // set environement of Util duration
                        Util_Duration duration = new Util_Duration(newWork.Date_Status_DEV_IP_Starts__c, newWork.Date_Status_DEV_IP_Ends__c);
                        // calulate and set field Duration_MS_Status_DEV_IP__c with a duration in Milliseconds (Decimal)
                        Long timeInMS = duration.calculateDurationInfMS();
                        newWork.Duration_MS_Status_DEV_IP__c = timeInMS;
                        // set field Duration_String_Status_DEV_IP__c with a string expressing the duration
                        newWork.Duration_String_Status_DEV_IP__c = Util_Duration.generateAStringFromMS(timeInMS);
                        // Stop Timer on Duration_In_MS_To_Respond_To_A_Bug__c
                        newWork.Duration_In_MS_To_Respond_To_A_Bug__c = UTIL_ServiceLevelAgreement.calculateDurationInMSToRespondToABug(newWork);
                    }
                    if (oldWork.agf__Status__c != 'DEV - To Be Tested' && newWork.agf__Status__c == 'DEV - To Be Tested'){
                        // set field Date_Status_DEV_TBT_Starts__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_DEV_TBT_Starts__c = Datetime.now();
                    }
                    if (oldWork.agf__Status__c == 'DEV - To Be Tested' && newWork.agf__Status__c != 'DEV - To Be Tested'){
                        // set field Date_Status_DEV_TBT_Ends__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_DEV_TBT_Ends__c = Datetime.now();
                        // set environement of Util duration
                        Util_Duration duration = new Util_Duration(newWork.Date_Status_DEV_TBT_Starts__c, newWork.Date_Status_DEV_TBT_Ends__c);
                        // calulate and set field Duration_MS_Status_DEV_TBT__c with a duration in Milliseconds (Decimal)
                        Long timeInMS = duration.calculateDurationInfMS();
                        newWork.Duration_MS_Status_DEV_TBT__c = timeInMS; 
                        // set field Duration_String_Status_DEV_TBT__c with a string expressing the duration
                        newWork.Duration_String_Status_DEV_TBT__c = Util_Duration.generateAStringFromMS(timeInMS);
                    }
                    if (oldWork.agf__Status__c != 'DEV - To Be Deployed in UAT' && newWork.agf__Status__c == 'DEV - To Be Deployed in UAT'){
                        // set field Date_Status_DEV_TBD_UAT_Starts__c	 for the records of agf__ADM_Work__c
                        newWork.Date_Status_DEV_TBD_UAT_Starts__c = Datetime.now();
                    }
                    if (oldWork.agf__Status__c == 'DEV - To Be Deployed in UAT' && newWork.agf__Status__c != 'DEV - To Be Deployed in UAT'){
                        // set field newWork.Date_Status_DEV_TBD_UAT_Ends__c	 for the records of agf__ADM_Work__c
                        newWork.Date_Status_DEV_TBD_UAT_Ends__c = Datetime.now();
                        // set environement of Util duration
                        Util_Duration duration = new Util_Duration(newWork.Date_Status_DEV_TBD_UAT_Starts__c, newWork.Date_Status_DEV_TBD_UAT_Ends__c);
                        // calulate and set field Duration_MS_Status_DEV_TBD_UAT__c with a duration in Milliseconds (Decimal)
                        Long timeInMS = duration.calculateDurationInfMS();
                        newWork.Duration_MS_Status_DEV_TBD_UAT__c = timeInMS;
                        // set field Duration_String_Status_DEV_TBD_UAT__c with a string expressing the duration
                        newWork.Duration_String_Status_DEV_TBD_UAT__c = Util_Duration.generateAStringFromMS(timeInMS);
                    }
                    if (oldWork.agf__Status__c != 'UAT - To Fix' && newWork.agf__Status__c == 'UAT - To Fix'){
                        // set field Date_Status_UAT_To_Fix_Starts__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_UAT_To_Fix_Starts__c = Datetime.now();
                    }
                    if (oldWork.agf__Status__c == 'UAT - To Fix' && newWork.agf__Status__c != 'UAT - To Fix'){
                        // set field newWork.Date_Status_UAT_To_Fix_Ends__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_UAT_To_Fix_Ends__c = Datetime.now();
                        // set environement of Util duration
                        Util_Duration duration = new Util_Duration(newWork.Date_Status_UAT_To_Fix_Starts__c, newWork.Date_Status_UAT_To_Fix_Ends__c);
                        // calulate and set field Duration_MS_Status_UAT_To_Fix__c with a duration in Milliseconds (Decimal)
                        Long timeInMS = duration.calculateDurationInfMS();
                        newWork.Duration_MS_Status_UAT_To_Fix__c = timeInMS;
                        // set field Duration_String_Status_UAT_To_Fix__c with a string expressing the duration
                        newWork.Duration_String_Status_UAT_To_Fix__c = Util_Duration.generateAStringFromMS(timeInMS);
                    }
                    if (oldWork.agf__Status__c != 'UAT - To Be Deployed in PROD' && newWork.agf__Status__c == 'UAT - To Be Deployed in PROD'){
                        // set field Date_Status_UAT_TBD_PROD_Starts__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_UAT_TBD_PROD_Starts__c = Datetime.now();
                    }
                    if (oldWork.agf__Status__c == 'UAT - To Be Deployed in PROD' && newWork.agf__Status__c != 'UAT - To Be Deployed in PROD'){
                        // set field newWork.Date_Status_UAT_TBD_PROD_Ends__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_UAT_TBD_PROD_Ends__c = Datetime.now();
                        // set environement of Util duration
                        Util_Duration duration = new Util_Duration(newWork.Date_Status_UAT_TBD_PROD_Starts__c, newWork.Date_Status_UAT_TBD_PROD_Ends__c);
                        // calulate and set field Duration_MS_Status_UAT_TBD_PROD__c with a duration in Milliseconds (Decimal)
                        Long timeInMS = duration.calculateDurationInfMS();
                        newWork.Duration_MS_Status_UAT_TBD_PROD__c = timeInMS;
                        // set field Duration_String_Status_UAT_TBD_PROD__c with a string expressing the duration
                        newWork.Duration_String_Status_UAT_TBD_PROD__c = Util_Duration.generateAStringFromMS(timeInMS);
                    }
                    if (oldWork.agf__Status__c != 'PROD - To Fix' && newWork.agf__Status__c == 'PROD - To Fix'){
                        // set field Date_Status_PROD_To_Fix_Starts__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_PROD_To_Fix_Starts__c = Datetime.now();
                    }
                    if (oldWork.agf__Status__c == 'PROD - To Fix' && newWork.agf__Status__c != 'PROD - To Fix'){
                        // set field newWork.Date_Status_PROD_To_Fix_Ends__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_PROD_To_Fix_Ends__c = Datetime.now();
                        // set environement of Util duration
                        Util_Duration duration = new Util_Duration(newWork.Date_Status_PROD_To_Fix_Starts__c, newWork.Date_Status_PROD_To_Fix_Ends__c);
                        // calulate and set field Duration_MS_Status_PROD_To_Fix__c with a duration in Milliseconds (Decimal)
                        Long timeInMS = duration.calculateDurationInfMS();
                        newWork.Duration_MS_Status_PROD_To_Fix__c = timeInMS;
                        // set field Duration_String_Status_PROD_To_Fix__c with a string expressing the duration
                        newWork.Duration_String_Status_PROD_To_Fix__c = Util_Duration.generateAStringFromMS(timeInMS);
                    }
                    if (oldWork.agf__Status__c != 'Validated - To Be Deployed' && newWork.agf__Status__c == 'Validated - To Be Deployed'){
                        // set field Date_Status_Validated_TBD_Starts__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_Validated_TBD_Starts__c = Datetime.now();
                        // stop timer on Duration_In_MS_To_Correct_A_Bug__c
                        newWork.Duration_In_MS_To_Correct_A_Bug__c = UTIL_ServiceLevelAgreement.calculateDurationInMSToCorrectABug(newWork);
                    }
                    if (oldWork.agf__Status__c == 'Validated - To Be Deployed' && newWork.agf__Status__c != 'Validated - To Be Deployed'){
                        // set field newWork.Date_Status_Validated_TBD_Ends__c for the records of agf__ADM_Work__c
                        newWork.Date_Status_Validated_TBD_Ends__c = Datetime.now();
                        // set environement of Util duration
                        Util_Duration duration = new Util_Duration(newWork.Date_Status_Validated_TBD_Starts__c, newWork.Date_Status_Validated_TBD_Ends__c);
                        // calulate and set field Duration_MS_Status_Validated_TBD__c with a duration in Milliseconds (Decimal)
                        Long timeInMS = duration.calculateDurationInfMS();
                        newWork.Duration_MS_Status_Validated_TBD__c = timeInMS;
                        // set field Duration_String_Status_Validated_TBD__c with a string expressing the duration
                        newWork.Duration_String_Status_Validated_TBD__c = Util_Duration.generateAStringFromMS(timeInMS);
                    }
                    if (newWork.Duration_MS_Status_New__c!=null || newWork.Duration_String_Status_DEV_IP__c!=null){
                        // set field Duration_In_MS_To_Respond_To_A_Bug__c
                        newWork.Duration_In_MS_To_Respond_To_A_Bug__c = UTIL_ServiceLevelAgreement.calculateDurationInMSToRespondToABug(newWork);
                    }
                    if(oldWork.Duration_In_MS_To_Respond_To_A_Bug__c == null && newWork.Duration_In_MS_To_Respond_To_A_Bug__c != null){
                        Long durationToRespondToBug = (Long)newWork.Duration_In_MS_To_Respond_To_A_Bug__c;
                        // set field Duration_In_String_To_Respond_To_A_Bug__c
                        newWork.Duration_In_String_To_Respond_To_A_Bug__c = UTIL_Duration.generateAStringFromMS(durationToRespondToBug);
                    }
                    if (newWork.Duration_MS_Status_DEV_TBT__c != null || newWork.Duration_String_Status_DEV_TBD_UAT__c != null ||
                        newWork.Duration_MS_Status_UAT_To_Fix__c != null || newWork.Duration_String_Status_UAT_TBD_PROD__c != null ||
                        newWork.Duration_String_Status_PROD_To_Fix__c != null|| newWork.Duration_String_Status_Validated_TBD__c != null){
                        // set field Duration_In_MS_To_Correct_A_Bug__c
                        System.debug('I AM in condition of filling Duration_In_MS_To_Correct_A_Bug__c');
                        newWork.Duration_In_MS_To_Correct_A_Bug__c = UTIL_ServiceLevelAgreement.calculateDurationInMSToCorrectABug(newWork);
                    }
                    if(oldWork.Duration_In_MS_To_Correct_A_Bug__c == null && newWork.Duration_In_MS_To_Correct_A_Bug__c != null){
                        Long durationToCorrectABug = (Long)newWork.Duration_In_MS_To_Correct_A_Bug__c;
                        // set field Duration_In_String_To_Correct_A_Bug__c
                        newWork.Duration_In_String_To_Correct_A_Bug__c = UTIL_Duration.generateAStringFromMS(durationToCorrectABug);
                        System.debug('I AM in condition of filling Duration_In_String_To_Correct_A_Bug__c');
                    }
                }

            }


    }
}
