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
     * TODO get Date_Status_New_Starts__c
     * Called by : 
     * @Parametters : 
     * @Returns : DateTime 
     */
    public static DateTime getDateStatusNewStarts(String subjectOnWork){
    agf__ADM_Work__c workRecord =null;
        try{
            workRecord =[ SELECT Date_Status_New_Starts__c
                               FROM agf__ADM_Work__c
                               WHERE agf__Subject__c = :subjectOnWork
                               ];
        } catch(DMLException e){
            System.debug('You could not get Date_Status_New_Starts__c on the record named : '+subjectOnWork+'.');
        }
        return workRecord.Date_Status_New_Starts__c;
    }
    /**
     * 
     * TODO get record type
     * Called by : 
     * @Parametters : 
     * @Returns : String
     */
    /** 
     * TODO get record priority
     * Called by : 
     * @Parametters : 
     * @Returns : Integer
     */
    /** 
     * TODO get record status
     * Called by : 
     * @Parametters : 
     * @Returns : String
     */
    /** 
     * TODO get Bypass_For_Corrective_Maintenance_On_Bug__c
     * Called by : 
     * @Parametters : 
     * @Returns : boolean
     */
    //------------------------------------------------------METHODS WITH CONSTRUCTOR ---------------------------------------------
    //------------------------------------------------------STATIC METHODS ---------------------------------------------
    //------------------------------------------------------BOOLEAN STATIC METHODS ---------------------------------------------
}
