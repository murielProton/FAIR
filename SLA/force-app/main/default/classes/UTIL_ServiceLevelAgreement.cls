/** *******************************************************************************
 * @Author : Muriel Proton
 * @Company : Modis
 * This class includes every methodes computing SLA service level agreement.
 * This class is used in class : TH_WorkTrigger in method beforeUpdate()
 * @Interface : 
 * @Constructor : 
 * @Setup class and inner class : 
 * INDEX : GETER METHODS - METHODS WITH CONSTRUCTOR - STATIC METHODS - BOOLEAN STATIC METHODS
 ******************************************************************************* */
public with sharing class UTIL_ServiceLevelAgreement {
    public DateTime endDateTime =  Datetime.now();
    public UTIL_ServiceLevelAgreement() {

    }
    /** TODO fill theese 3 DateTime : Deadline_SLA_Response_Time_On_Bug__c,
     *                                Deadline SLA Corrective Maintenance On Bug
     *                                Deadline_SLA_Corrective_Maintenance_On_Bug__c
     *  
     * */
    /** 
     * Deadline_SLA_Response_Time_On_Bug__c
     * Description : When a record is created this date is calculated. This date is set according to the type of record and it's priority. 
     * The date will be within business hours.  The Trigger will fill this DateTime Type. If priority of the record changes this date can change too.
     * Help : This date is set based on the priority and the type of the record. It can be up to 2 days after the creation of the ticket.
     * Called by : 
     * @Parametters : 
     * @Returns : bolean 
     */
    /**
     * 
     * When the Status of a record type Bug is updated from 'DEV – In Progress' to any other Status, this date is calculated. 
     * This date is set according to the type of record and it's priority. The date will be within business hours.  
     * The Trigger will fill this DateTime Type. If during the life of the ticket either Priority or Status changes, this date can be modified. 
     * This deadling is also influenced by wether the chekbox Bypass is checked or not.
     * Help : This date is set based on the priority and the type of the record. It can be up to 22 days after the creation of the record. 
     * This date depends also on wether there is a bypass or not. 
    */
    /**
     * 
     * Deadline_SLA_Response_Time_On_User_Story__c
     * Description : When a record is created this date is calculated. This date is set according to the type of record and it's priority. 
     * The date will be within business hours.  The Trigger will fill this DateTime Type. If priority of the record changes this date can change too.
     * Help : This date is set based on the priority and the type of the record. It can be up to 6 days after the creation of the ticket.  
     */
    //------------------------------------------------------GETER METHODS ---------------------------------------------
    /** 
     * get Date_Status_New_Starts__c
     * Called by : 
     * @Parametters : 
     * @Returns : DateTime 
     */
    public static DateTime getDateStatusNewStarts(agf__ADM_Work__c workRecord){
        return workRecord.Date_Status_New_Starts__c;
    }
    /** 
     * get Date_Status_Workload_DONE_Ends__c
     * Called by : 
     * @Parametters : 
     * @Returns : DateTime 
     */
    public static DateTime getDateStatusWorkloadDONEEnds(agf__ADM_Work__c workRecord){
        return workRecord.Date_Status_Workload_DONE_Ends__c;
    }
    /** 
     * get Date_Status_DEV_IP_Ends__c
     * Called by : 
     * @Parametters : 
     * @Returns : DateTime 
     */
    public static DateTime getDateStatusDEVIPEnds(agf__ADM_Work__c workRecord){
        return workRecord.Date_Status_DEV_IP_Ends__c;
    }
    /** 
     * get Date_Status_Validated_TBD_Ends__c
     * Called by : 
     * @Parametters : 
     * @Returns : DateTime 
     */
    public static DateTime getDateStatusValidatedTBDEnds(agf__ADM_Work__c workRecord){
        return workRecord.Date_Status_Validated_TBD_Ends__c;
    }
    /**
     * get record type
     * Called by : 
     * @Parametters : 
     * @Returns : String
     */
    public static String getRecordTypeDeveloperName(agf__ADM_Work__c workRecord){
        String recordTypeDeveloperSName = Schema.SObjectType.agf__ADM_Work__c.getRecordTypeInfosById().get(workRecord.recordTypeId).getDeveloperName();
        return recordTypeDeveloperSName;
    }
    /** 
     * get record priority
     * Called by : 
     * @Parametters : 
     * @Returns : String
     */
    public static String getRecordPriority(agf__ADM_Work__c workRecord){
        return workRecord.agf__Priority__c;
    }
    /** 
     * get record status
     * Called by : 
     * @Parametters : 
     * @Returns : String
     */
    public static String getRecordStatus(agf__ADM_Work__c workRecord){
        return workRecord.agf__Status__c;
    }
    /** 
     * get Bypass_For_Corrective_Maintenance_On_Bug__c
     * Called by : 
     * @Parametters : 
     * @Returns : boolean
     */
    public static boolean getRecordBypassForCorrectiveMaintenanceOnBugs(agf__ADM_Work__c workRecord){
        return workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c;
    }
    //------------------------------------------------------METHODS WITH CONSTRUCTOR ---------------------------------------------
    //------------------------------------------------------STATIC METHODS ---------------------------------------------
    //------------------------------------------------------BOOLEAN STATIC METHODS ---------------------------------------------
}
