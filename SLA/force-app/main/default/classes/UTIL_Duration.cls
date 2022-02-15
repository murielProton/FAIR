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
     * This method computes a duration in Millisecond.
     * It needs the constructor to compute !
     * Called by : TH_WorkTrigger in method beforeUpdate()
     * @Parametters : None
     * @Returns : Decimal
     */
    public Decimal calculateTimeInMS(){
        Decimal longStartDateTime = startDateTime.getTime();
        Decimal longEndDateTime = endDateTime.getTime();
        Decimal durationMS = longEndDateTime - longStartDateTime;
        return durationMS;
    }
}
