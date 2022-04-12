public with sharing class UTIL_DurationDiscarded {
    public static final Time START_TIME_OF_BUSINESS_HOUR = Time.newInstance(9, 0, 0, 0); //TODO : find a way to find this information from ORG
    public static final Time END_TIME_OF_BUSINESS_HOUR = Time.newInstance(17, 30, 0, 0); //TODO : find a way to find this information from ORG
    public UTIL_DurationDiscarded() {

    }
    /** 
     * This method will return a boolean.
     * It it will return true if the time is between 9h and 17 H 30.
     * Called by : 
     * @Parametters : DateTime dateToTest
     * @Returns : bolean 
     */
    public static boolean isTimeWithinBusinessHours(DateTime dateToTest){
        Integer startTimeHours = dateToTest.hour();
        Integer startTimeMinutes = dateToTest.minute();
        Integer startTimeSeconds = dateToTest.second();
        Integer startTimeMS = dateToTest.millisecond();
        Time timeToTest = Time.newInstance(startTimeHours, startTimeMinutes, startTimeSeconds, startTimeMS);
        if(START_TIME_OF_BUSINESS_HOUR <= timeToTest && timeToTest <= END_TIME_OF_BUSINESS_HOUR){
            return true;
        }
        return false;
    }
    /** 
     * This method will return a lenght of time or duration milliseconds.
     * It will calculate this duration within business hours.
     * It requieres a CONSTRUCTOR.
     * Called by : calculateNumberOfBusinessHoursExcludingHolidaysSpentInMS()
     * @Parametters : Long
     * @Returns : Long 
     */
    public Long calculateNumberOfBusinessHoursSpentInMS(){
        BusinessHours businessHoursId = getBusinessHours();
        Long durationOfBusinessHoursSpent = BusinessHours.diff(businessHoursId.Id, startDateTime, endDateTime);
        System.debug('durationOfBusinessHoursSpent - '+durationOfBusinessHoursSpent);
        return durationOfBusinessHoursSpent;
    }
        /** 
     * This method will return a boolean.
     * It it will return true if the startDate equals endDate.
     * NEEDS CONSTRUCTOR
     * Called by : 
     * @Parametters : 
     * @Returns : bolean 
     */
    public boolean doesStartDateEqualEndDate(){
        Date startDate = Date.newInstance(startDateTime.year(), startDateTime.month(), startDateTime.day());
        Date endDate = Date.newInstance(endDateTime.year(), endDateTime.month(), endDateTime.day());
        if(startDate == endDate){
            return true;
        }
        return false;
    }
}
