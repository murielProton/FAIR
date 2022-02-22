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
    /**
     * This method computes a duration in years.
     * Called by : 
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateTimeInYears(Long timeInMilliseconds){
        Long numberOfMSInAYear = Long.valueOf('31536000000');
        Long timeInYears = timeInMilliseconds / numberOfMSInAYear;
        return timeInYears;
    }
    /** 
     * This method will return a String from the number of milliseconds it recives.
     * Called by : 
     * @Parametters : Long
     * @Returns : String 
     */
    public static String generateAStringFromMS(Long timeInMilliseconds){
        String durationInString = '';
        Long numberOfMSInOneSecond = 1000;
        Long numberOfMSInOneMinute = 60000;
        Long numberOfMSInOneHour = 3600000;
        Long numberOfMSInOneDay = 86400000;
        Long numberOfMSInOneWeek = 604800000;
        Long numberOfMSInOneMonth = Long.valueOf('2629800000');
        Long numberOfMSInOneYear = Long.valueOf('31536000000');

        if (timeInMilliseconds!=null){
            Long roundedMS = timeInMilliseconds;
            //1- if the duration in milliseconds is inferior to a second.
            // AND DONE. NOTHING ELSE TO DO.
            if(roundedMS < numberOfMSInOneSecond){
                return 'under a second.';
            }
            // Warning Conditions order is important here ! ORDER DESC
            // 6- if the rounded duration in milliseconds is superior to a week.
            if(roundedMS >= numberOfMSInOneWeek){
                Long numberOfWeeks = calculateTimeInWeeks(roundedMS);
                roundedMS = roundedMS - (numberOfWeeks * numberOfMSInOneWeek);
                durationInString = durationInString + numberOfWeeks + ' weeks(s), ';
            }
            // 5- if the rounded duration in milliseconds is superior to a day.
            if(roundedMS >= numberOfMSInOneDay){
                Long numberOfDays = calculateTimeInDays(roundedMS);
                roundedMS = roundedMS - (numberOfDays * numberOfMSInOneDay);
                durationInString = durationInString + numberOfDays + ' day(s), ';
            }
            // 4- if the rounded duration in milliseconds is superior to a hour.
            if(roundedMS >= numberOfMSInOneHour){
                Long numberOfHours = calculateTimeInHours(roundedMS);
                roundedMS = roundedMS - (numberOfHours * numberOfMSInOneHour);
                durationInString = durationInString + numberOfHours + ' hour(s), ';
            }
            // 3- if the rounded duration in milliseconds is superior to a minute.
            if(roundedMS >= numberOfMSInOneMinute){
                Long numberOfMinutes = calculateTimeInMinutes(roundedMS);
                roundedMS = roundedMS - (numberOfMinutes * numberOfMSInOneMinute);
                durationInString = durationInString + numberOfMinutes + ' minute(s), ' ;
            }
            //2- if the rounded duration in milliseconds is superior to a second.
            if(roundedMS >= numberOfMSInOneSecond){
                Long numberOfSeconds = calculateTimeInSeconds(roundedMS);
                durationInString = durationInString + numberOfSeconds + ' second(s)';
                roundedMS = roundedMS - (numberOfSeconds * numberOfMSInOneSecond);
            }
            System.debug('fin ->' + durationInString+'}');
            return durationInString;
        }else{
            return null;
        }
        
    }
}
