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
     * @Returns : Integer
     */
    public Integer calculateTimeInMS(){
        Long longStartDateTime = startDateTime.getTime();
        Long longEndDateTime = endDateTime.getTime();
        Integer startDateTime = longStartDateTime.intValue();
        Integer endDateTime = longEndDateTime.intValue();
        Integer durationMS = endDateTime - startDateTime;
        return durationMS;
    }
    /**
     * This method computes a duration in seconds.
     * Called by : 
     * @Parametters : Integer
     * @Returns : Integer
     */
    public static Integer calculateTimeInSeconds(Integer timeInMilliseconds){
        Integer timeInSeconds = timeInMilliseconds / 1000;
        return timeInSeconds;
    }
    /**
     * This method computes a duration in minutes.
     * Called by : 
     * @Parametters : Integer
     * @Returns : Integer
     */
    public static Integer calculateTimeInMinutes(Integer timeInMilliseconds){
        Integer timeInMinutes = timeInMilliseconds / 60000;
        return timeInMinutes;
    }
}
