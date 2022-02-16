/** *******************************************************************************
 * @Author : Muriel Proton
 * @Company : Modis
 * This class includes every methodes computing duration and time.
 * This class is used in class : TH_WorkTrigger in method beforeUpdate()
 * @Interface : 
 * @Constructor : UTIL_Duration(DateTime, DateTime)
 * @Setup method : from line 13 to 14
 * @Setup class and inner class : 
 * 
 ******************************************************************************* */
public with sharing class UTIL_Duration {
    DateTime startDateTime;
    DateTime endDateTime;
    /**
     * This constructor takes two dates as parametter, because it will help to build durations.
     * @CONSTRUCTOR
     * Called by : TH_WorkTrigger in method beforeUpdate()
     * @Parametters : DateTime, DateTime
     *
     */
    public UTIL_Duration(DateTime startDateTime, DateTime endDateTime) {
        this.startDateTime = startDateTime;
        this.endDateTime = endDateTime;
    }
    /**
     * This method computes a duration in Milliseconds.
     * It needs the constructor to compute !
     * Called by : TH_WorkTrigger in method beforeUpdate()
     * @Parametters : None
     * @Returns : Long
     */
    public Long calculateTimeInMS(){
        Long longStartDateTime = startDateTime.getTime();
        Long longEndDateTime = endDateTime.getTime();
        Long durationMS = longEndDateTime - longStartDateTime;
        return durationMS;
    }
    /**
     * This method computes a duration in seconds.
     * Called by : 
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateTimeInSeconds(Long timeInMilliseconds){
        Long timeInSeconds = timeInMilliseconds / 1000;
        return timeInSeconds;
    }
    /**
     * This method computes a duration in minutes.
     * Called by : 
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateTimeInMinutes(Long timeInMilliseconds){
        Long timeInMinutes = timeInMilliseconds / 60000;
        return timeInMinutes;
    }
    /**
     * This method computes a duration in hours.
     * Called by : 
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateTimeInHours(Long timeInMilliseconds){
        Long timeInHours = timeInMilliseconds / 3600000;
        return timeInHours;
    }
    /**
     * This method computes a duration in days.
     * Called by : 
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateTimeInDays(Long timeInMilliseconds){
        Long timeInDays = timeInMilliseconds / 86400000;
        return timeInDays;
    }
    /**
     * This method computes a duration in weeks.
     * Called by : 
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateTimeInWeeks(Long timeInMilliseconds){
        Long timeInWeeks = timeInMilliseconds / 604800000;
        return timeInWeeks;
    }
    /**
     * This method computes a duration in months.
     * Called by : 
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateTimeInMonths(Long timeInMilliseconds){
        Long numberOfMSInAMonth = Long.valueOf('2629800000');
        Long timeInMonths = timeInMilliseconds / numberOfMSInAMonth;
        return timeInMonths;
    }
}
