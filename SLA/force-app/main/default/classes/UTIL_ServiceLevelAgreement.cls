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
    //CONSTANT Used in this class or in UTIL_ServiceLevelAgreement
    // constants for bugs
    public static final Long NUMBER_HOURS_BUG_P1_RESPONSE_TIME = 2;
    public static final Long NUMBER_DAYS_BUG_P2_RESPONSE_TIME = 1;
    public static final Long NUMBER_DAYS_BUG_P3_RESPONSE_TIME = 2;
    public static final Long NUMBER_DAYS_BUG_P1_CORRECTIVE_MAINTENANCE = 2;
    public static final Long NUMBER_DAYS_BUG_P2_CORRECTIVE_MAINTENANCE = 8;
    public static final Long NUMBER_DAYS_BUG_P3_CORRECTIVE_MAINTENANCE = 12;
    public static final Long NUMBER_DAYS_BUG_P1_CORRECTIVE_MAINTENANCE_WITH_BYPASS = 4;
    public static final Long NUMBER_DAYS_BUG_P2_CORRECTIVE_MAINTENANCE_WITH_BYPASS = 15;
    public static final Long NUMBER_DAYS_BUG_P3_CORRECTIVE_MAINTENANCE_WITH_BYPASS = 22;
    public static final Long NUMBER_MS_BUG_P1_RESPONSE_TIME = NUMBER_HOURS_BUG_P1_RESPONSE_TIME * UTIL_Duration.NUMBER_OF_MS_IN_ONE_HOUR;
    public static final Long NUMBER_MS_BUG_P2_RESPONSE_TIME = NUMBER_DAYS_BUG_P2_RESPONSE_TIME * UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY;
    public static final Long NUMBER_MS_BUG_P3_RESPONSE_TIME = NUMBER_DAYS_BUG_P3_RESPONSE_TIME * UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY;
    public static final Long NUMBER_MS_BUG_P1_CORRECTIVE_MAINTENANCE = NUMBER_DAYS_BUG_P1_CORRECTIVE_MAINTENANCE * UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY;
    public static final Long NUMBER_MS_BUG_P2_CORRECTIVE_MAINTENANCE = NUMBER_DAYS_BUG_P2_CORRECTIVE_MAINTENANCE * UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY;
    public static final Long NUMBER_MS_BUG_P3_CORRECTIVE_MAINTENANCE = NUMBER_DAYS_BUG_P3_CORRECTIVE_MAINTENANCE * UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY;
    public static final Long NUMBER_MS_BUG_P1_CORRECTIVE_MAINTENANCE_WITH_BYPASS = NUMBER_DAYS_BUG_P1_CORRECTIVE_MAINTENANCE_WITH_BYPASS * UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY;
    public static final Long NUMBER_MS_BUG_P2_CORRECTIVE_MAINTENANCE_WITH_BYPASS = NUMBER_DAYS_BUG_P2_CORRECTIVE_MAINTENANCE_WITH_BYPASS * UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY;
    public static final Long NUMBER_MS_BUG_P3_CORRECTIVE_MAINTENANCE_WITH_BYPASS = NUMBER_DAYS_BUG_P3_CORRECTIVE_MAINTENANCE_WITH_BYPASS * UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY;
    //constantes for user stories
    public static final Long NUMBER_DAYS_USER_STORY_P1_RESPONSE_TIME = 2;
    public static final Long NUMBER_DAYS_USER_STORY_P2_RESPONSE_TIME = 2;
    public static final Long NUMBER_DAYS_USER_STORY_P3_RESPONSE_TIME = 6;
    public static final Long NUMBER_MS_USER_STORY_P1_RESPONSE_TIME = NUMBER_DAYS_USER_STORY_P1_RESPONSE_TIME * UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY;
    public static final Long NUMBER_MS_USER_STORY_P2_RESPONSE_TIME = NUMBER_DAYS_USER_STORY_P2_RESPONSE_TIME * UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY;
    public static final Long NUMBER_MS_USER_STORY_P3_RESPONSE_TIME = NUMBER_DAYS_USER_STORY_P3_RESPONSE_TIME * UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY;
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
    //------------------------------------------------------STATIC METHODS -------------------------------------------------------
    /**
     * returning a DateTime within Business Hours and taking into account Holidays
     * This methode test one day at a time. It makes sure the day you test is a day within Business Hours and not a Holiday.
     * Called by : 
     * @Parametters : 
     * @Returns : Datetime
     */
    public static DateTime getingNextDateTimeWithinBusinessHoursNOTAHoliday(String businessHoursId, List<Holiday> listOfHolidays, DateTime dateTimeToConvert){
        DateTime dateTimeToReturn = dateTimeToConvert;
        // either it is a holiday, either it is not within Business hours
        while(UTIL_Duration.isThisDayAHoliday(dateTimeToReturn, listOfHolidays)
            || !BusinessHours.isWithin(businessHoursId, dateTimeToReturn)
            ){
            // Test again if it is a not within business hour
            if (!BusinessHours.isWithin(businessHoursId, dateTimeToReturn)){
                // find next day within buisiness hour, WARNING it can be a holiday.
                dateTimeToReturn = BusinessHours.nextStartDate(businessHoursId, dateTimeToReturn);
            } else {
                // if it is indeed a Holiday, then add a day and find next day within Business Hours
                dateTimeToReturn = DateTime.newInstance(dateTimeToReturn.year(), dateTimeToReturn.month(), dateTimeToReturn.day(), 0, 0, 0)
                    .addDays(1);
                dateTimeToReturn = BusinessHours.nextStartDate(businessHoursId, dateTimeToReturn);
            }
            System.debug('New date -> '+dateTimeToReturn);
            System.debug('isWithin Business Hours -> '+BusinessHours.isWithin(businessHoursId, dateTimeToReturn));
            System.debug('is holiday -> '+UTIL_Duration.isThisDayAHoliday(dateTimeToReturn, listOfHolidays));
        }
        return dateTimeToReturn;
    }
    
    /**
     * returning a number of MS to fill in field Duration_In_MS_To_Respond_To_A_Bug__c.
     * It makes sure that this field is filled as soon as Duration_MS_Status_New__c is set.
     * Called by : 
     * @Parametters : 
     * @Returns : Long
     */
    public static Long calculateDurationInMSToRespondToABug(agf__ADM_Work__c workRecord){
        Long valueToReturn=null;
        if(workRecord.Duration_MS_Status_New__c != null && workRecord.Duration_MS_Status_DEV_IP__c == null){
            valueToReturn = (Long)workRecord.Duration_MS_Status_New__c;
            return valueToReturn;
        }
        if(workRecord.Duration_MS_Status_New__c != null && workRecord.Duration_MS_Status_DEV_IP__c != null){
            valueToReturn = addingDurationInMSToRespondToABug(workRecord);
            return valueToReturn;
        }
        return valueToReturn;
    }
    /**
     * returning a number of MS to fill in field Duration_In_MS_To_Correct_A_Bug__c.
     * It makes sure that this field is filled as soon as Duration_MS_Status_DEV_TBT__c is set.
     * Called by : 
     * @Parametters : 
     * @Returns : Long
     */
    public static Long calculateDurationInMSToCorrectABug(agf__ADM_Work__c workRecord){
        Long valueToReturn=null;
        //1 if only Duration_MS_Status_DEV_TBT__c is filled
        if(workRecord.Duration_MS_Status_DEV_TBT__c != null && workRecord.Duration_MS_Status_DEV_TBD_UAT__c == null
        && workRecord.Duration_MS_Status_UAT_To_Fix__c == null && workRecord.Duration_MS_Status_UAT_TBD_PROD__c == null
        && workRecord.Duration_MS_Status_PROD_To_Fix__c == null && workRecord.Duration_MS_Status_Validated_TBD__c == null){
            valueToReturn = (Long)workRecord.Duration_MS_Status_DEV_TBT__c;
            System.debug('Duration_MS_Status_DEV_TBT__c exists -> '+valueToReturn);
            return valueToReturn;
        }
        //2 if only Duration_MS_Status_DEV_TBT__c and Duration_MS_Status_DEV_TBD_UAT__c are filled
        if(workRecord.Duration_MS_Status_DEV_TBT__c != null && workRecord.Duration_MS_Status_DEV_TBD_UAT__c != null
        && workRecord.Duration_MS_Status_UAT_To_Fix__c == null && workRecord.Duration_MS_Status_UAT_TBD_PROD__c == null
        && workRecord.Duration_MS_Status_PROD_To_Fix__c == null && workRecord.Duration_MS_Status_Validated_TBD__c == null){
            valueToReturn = (Long)workRecord.Duration_MS_Status_DEV_TBT__c +  (Long)workRecord.Duration_MS_Status_DEV_TBD_UAT__c;
            System.debug('if only Duration_MS_Status_DEV_TBT__c and Duration_MS_Status_DEV_TBD_UAT__c are filled -> '+valueToReturn);
            return valueToReturn;
        }
        /* 3 if only Duration_MS_Status_DEV_TBT__c, Duration_MS_Status_DEV_TBD_UAT__c and Duration_MS_Status_UAT_To_Fix__c are filled
        */
        if(workRecord.Duration_MS_Status_DEV_TBT__c != null && workRecord.Duration_MS_Status_DEV_TBD_UAT__c != null
        && workRecord.Duration_MS_Status_UAT_To_Fix__c != null && workRecord.Duration_MS_Status_UAT_TBD_PROD__c == null
        && workRecord.Duration_MS_Status_PROD_To_Fix__c == null && workRecord.Duration_MS_Status_Validated_TBD__c == null){
            valueToReturn = (Long)workRecord.Duration_MS_Status_DEV_TBT__c +  (Long)workRecord.Duration_MS_Status_DEV_TBD_UAT__c +
            (Long)workRecord.Duration_MS_Status_UAT_To_Fix__c;
            System.debug('if only Duration_MS_Status_DEV_TBT__c, Duration_MS_Status_DEV_TBD_UAT__c and Duration_MS_Status_UAT_To_Fix__c are filled -> '+valueToReturn);
            return valueToReturn;
        }
        /* 4 if only Duration_MS_Status_DEV_TBT__c, Duration_MS_Status_DEV_TBD_UAT__c, Duration_MS_Status_UAT_To_Fix__c
        * and Duration_MS_Status_UAT_TBD_PROD__c are filled
        */
        if(workRecord.Duration_MS_Status_DEV_TBT__c != null && workRecord.Duration_MS_Status_DEV_TBD_UAT__c != null
        && workRecord.Duration_MS_Status_UAT_To_Fix__c != null && workRecord.Duration_MS_Status_UAT_TBD_PROD__c != null
        && workRecord.Duration_MS_Status_PROD_To_Fix__c == null && workRecord.Duration_MS_Status_Validated_TBD__c == null){
            valueToReturn = (Long)workRecord.Duration_MS_Status_DEV_TBT__c +  (Long)workRecord.Duration_MS_Status_DEV_TBD_UAT__c +
            (Long)workRecord.Duration_MS_Status_UAT_To_Fix__c + (Long)workRecord.Duration_MS_Status_UAT_TBD_PROD__c;
            System.debug('if only Duration_MS_Status_DEV_TBT__c, Duration_MS_Status_DEV_TBD_UAT__c and Duration_MS_Status_UAT_To_Fix__c, Duration_MS_Status_UAT_TBD_PROD__c are filled -> '+valueToReturn);
            return valueToReturn;
        }
        /* 5 if Duration_MS_Status_Validated_TBD__c is the ony null factor
        */
        if(workRecord.Duration_MS_Status_DEV_TBT__c != null && workRecord.Duration_MS_Status_DEV_TBD_UAT__c != null
        && workRecord.Duration_MS_Status_UAT_To_Fix__c != null && workRecord.Duration_MS_Status_UAT_TBD_PROD__c != null
        && workRecord.Duration_MS_Status_PROD_To_Fix__c != null && workRecord.Duration_MS_Status_Validated_TBD__c == null){
            valueToReturn = (Long)workRecord.Duration_MS_Status_DEV_TBT__c +  (Long)workRecord.Duration_MS_Status_DEV_TBD_UAT__c +
            (Long)workRecord.Duration_MS_Status_UAT_To_Fix__c + (Long)workRecord.Duration_MS_Status_UAT_TBD_PROD__c +
            (Long)workRecord.Duration_MS_Status_PROD_To_Fix__c;
            System.debug('5 if Duration_MS_Status_Validated_TBD__c is the ony null factor -> '+valueToReturn);
            return valueToReturn;
        }
        /* 6 if no durations are null
        * 
        */
        if(workRecord.Duration_MS_Status_DEV_TBT__c != null && workRecord.Duration_MS_Status_DEV_TBD_UAT__c != null
        && workRecord.Duration_MS_Status_UAT_To_Fix__c != null && workRecord.Duration_MS_Status_UAT_TBD_PROD__c != null
        && workRecord.Duration_MS_Status_PROD_To_Fix__c != null && workRecord.Duration_MS_Status_Validated_TBD__c != null){
            valueToReturn = (Long)addingDurationInMSToCorrectBug(workRecord);
            System.debug('6 if no durations are null -> '+valueToReturn);
            return valueToReturn;
        }
        /*else nothting of the above is true */
        System.debug('just before return -> '+valueToReturn);
        return valueToReturn;
    }
    /**
     * returning a number of MS adding Duration_MS_Status_New__c and Duration_MS_Status_DEV_IP__c.
     * Called by : 
     * @Parametters : 
     * @Returns : Long
     */
    public static Long addingDurationInMSToRespondToABug(agf__ADM_Work__c workRecord){
        Long numberOfMSToRespondToABug = (Long)workRecord.Duration_MS_Status_New__c + (Long)workRecord.Duration_MS_Status_DEV_IP__c;
        return numberOfMSToRespondToABug;
    }
    /**
     * returning a number of MS adding Duration_MS_Status_DEV_TBT__c , Duration_MS_Status_DEV_TBD_UAT__c , 
     * Duration_MS_Status_UAT_To_Fix__c, Duration_MS_Status_UAT_TBD_PROD__c , Duration_MS_Status_PROD_To_Fix__c , 
     * and Duration_MS_Status_Validated_TBD__c.
     * Called by : 
     * @Parametters : 
     * @Returns : Long
     */
    public static Long addingDurationInMSToCorrectBug(agf__ADM_Work__c workRecord){
        Long numberOfMSToCorrectABug = (Long)workRecord.Duration_MS_Status_DEV_TBT__c + (Long)workRecord.Duration_MS_Status_DEV_TBD_UAT__c +
        (Long)workRecord.Duration_MS_Status_UAT_To_Fix__c + (Long)workRecord.Duration_MS_Status_UAT_TBD_PROD__c + 
        (Long)workRecord.Duration_MS_Status_PROD_To_Fix__c + (Long)workRecord.Duration_MS_Status_Validated_TBD__c;
        return numberOfMSToCorrectABug;
    }
    /**
     * returning a number of MS adding Duration_MS_Status_New__c, Duration_MS_Status_OK_For_DEV__c and Duration_MS_Status_Workload_DONE__c.
     * Called by : 
     * @Parametters : 
     * @Returns : Long
     */
    public static Long addingDurationInMSToRespondToAUS(agf__ADM_Work__c workRecord){
        Long numberOfMSToRespondToAUS = (Long)workRecord.Duration_MS_Status_New__c + (Long)workRecord.Duration_MS_Status_OK_For_DEV__c +
        (Long)workRecord.Duration_MS_Status_Workload_DONE__c;
        return numberOfMSToRespondToAUS;
    }
    /** TODO
     * Adding MS to a DateTime within Business Hours and taking into account Holidays
     * Called by : 
     * @Parametters : 
     * @Returns : Datetime
     */
    /*public static DateTime searchingForDeadline(String businessHoursId, Datetime startDateTime, Long lengthOfTimeToAddInMS, List<Holiday> listOfHolidays){
        DateTime startDateTimeToTest = startDateTime;
        DateTime deadlineToTest;
        //If lengthOfTimeToAddInMS is inferior to a Day (UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY)
        if(lengthOfTimeToAddInMS < UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY){
           
            return startDateTimeToTest;
        }else if (lengthOfTimeToAddInMS > UTIL_Duration.NUMBER_OF_MS_IN_ONE_WORK_DAY){

        }else {
            System.debug('lengthOfTimeToAddInMS was not defined in UTIL_ServiceLevelAgreement.searchingForDeadline.')
        }

    }*/
    /** TODO
     * Adding Days to a DateTime within Business Hours and taking into account Holidays
     * Called by : 
     * @Parametters : 
     * @Returns : Datetime
     */
    //------------------------------------------------------BOOLEAN STATIC METHODS -----------------------------------------------
   
}