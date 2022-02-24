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
    //COSNTANT Used in this class or in UTIL_Duration_Test
    public static final Long NUMBER_OF_MS_IN_ONE_SECOND = 1000;
    public static final Long NUMBER_OF_MS_IN_ONE_MINUTE = 60000;
    public static final Long NUMBER_OF_MS_IN_ONE_HOUR = 3600000;
    public static final Long NUMBER_OF_MS_IN_ONE_DAY = 86400000;
    public static final Long NUMBER_OF_MS_IN_ONE_WEEK = 604800000;
    public static final Long NUMBER_OF_MS_IN_ONE_MONTH = Long.valueOf('2629800000');
    public static final Long NUMBER_OF_MS_IN_ONE_YEAR = Long.valueOf('31536000000');

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
        Long timeInSeconds = timeInMilliseconds / NUMBER_OF_MS_IN_ONE_SECOND;
        return timeInSeconds;
    }
    /**
     * This method computes a duration in minutes.
     * Called by : 
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateTimeInMinutes(Long timeInMilliseconds){
        Long timeInMinutes = timeInMilliseconds / NUMBER_OF_MS_IN_ONE_MINUTE;
        return timeInMinutes;
    }
    /**
     * This method computes a duration in hours.
     * Called by : 
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateTimeInHours(Long timeInMilliseconds){
        Long timeInHours = timeInMilliseconds / NUMBER_OF_MS_IN_ONE_HOUR;
        return timeInHours;
    }
    /**
     * This method computes a duration in days.
     * Called by : 
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateTimeInDays(Long timeInMilliseconds){
        Long timeInDays = timeInMilliseconds / NUMBER_OF_MS_IN_ONE_DAY;
        return timeInDays;
    }
    /**
     * This method computes a duration in weeks.
     * Called by : 
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateTimeInWeeks(Long timeInMilliseconds){
        Long timeInWeeks = timeInMilliseconds / NUMBER_OF_MS_IN_ONE_WEEK;
        return timeInWeeks;
    }
    /**
     * This method computes a duration in months.
     * Called by : 
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateTimeInMonths(Long timeInMilliseconds){
        Long numberOfMSInAMonth = NUMBER_OF_MS_IN_ONE_MONTH;
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
        Long numberOfMSInAYear = NUMBER_OF_MS_IN_ONE_YEAR;
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
       
        if (timeInMilliseconds != null){
            Long roundedMS = timeInMilliseconds;
            // if the duration in milliseconds is inferior to a second.
            // AND DONE. NOTHING ELSE TO DO.
            if(roundedMS < NUMBER_OF_MS_IN_ONE_SECOND){
                return 'under a second.';
            }
            // Warning Conditions order is important here ! ORDER DESC
            // if the rounded duration in milliseconds is superior to a year.
            if(roundedMS >= NUMBER_OF_MS_IN_ONE_YEAR){
                Long numberOfYears = calculateTimeInYears(roundedMS);
                roundedMS = roundedMS - (numberOfYears * NUMBER_OF_MS_IN_ONE_YEAR);
                durationInString = durationInString + numberOfYears + ' year(s), ';
            }
            // if the rounded duration in milliseconds is superior to a month.
            if(roundedMS >= NUMBER_OF_MS_IN_ONE_MONTH){
                Long numberOfMonths = calculateTimeInMonths(roundedMS);
                roundedMS = roundedMS - (numberOfMonths * NUMBER_OF_MS_IN_ONE_MONTH);
                durationInString = durationInString + numberOfMonths + ' month(s), ';
            }
            // if the rounded duration in milliseconds is superior to a week.
            if(roundedMS >= NUMBER_OF_MS_IN_ONE_WEEK){
                Long numberOfWeeks = calculateTimeInWeeks(roundedMS);
                roundedMS = roundedMS - (numberOfWeeks * NUMBER_OF_MS_IN_ONE_WEEK);
                durationInString = durationInString + numberOfWeeks + ' week(s), ';
            }
            // if the rounded duration in milliseconds is superior to a day.
            if(roundedMS >= NUMBER_OF_MS_IN_ONE_DAY){
                Long numberOfDays = calculateTimeInDays(roundedMS);
                roundedMS = roundedMS - (numberOfDays * NUMBER_OF_MS_IN_ONE_DAY);
                durationInString = durationInString + numberOfDays + ' day(s), ';
            }
            // if the rounded duration in milliseconds is superior to a hour.
            if(roundedMS >= NUMBER_OF_MS_IN_ONE_HOUR){
                Long numberOfHours = calculateTimeInHours(roundedMS);
                roundedMS = roundedMS - (numberOfHours * NUMBER_OF_MS_IN_ONE_HOUR);
                durationInString = durationInString + numberOfHours + ' hour(s), ';
            }
            // if the rounded duration in milliseconds is superior to a minute.
            if(roundedMS >= NUMBER_OF_MS_IN_ONE_MINUTE){
                Long numberOfMinutes = calculateTimeInMinutes(roundedMS);
                roundedMS = roundedMS - (numberOfMinutes * NUMBER_OF_MS_IN_ONE_MINUTE);
                durationInString = durationInString + numberOfMinutes + ' minute(s), ' ;
            }
            // if the rounded duration in milliseconds is superior to a second.
            if(roundedMS >= NUMBER_OF_MS_IN_ONE_SECOND){
                Long numberOfSeconds = calculateTimeInSeconds(roundedMS);
                durationInString = durationInString + numberOfSeconds + ' second(s)';
                roundedMS = roundedMS - (numberOfSeconds * NUMBER_OF_MS_IN_ONE_SECOND);
            }
            System.debug('fin ->' + durationInString+'}');
            return durationInString;
        }else{
            return null;
        }
        
    }
}
