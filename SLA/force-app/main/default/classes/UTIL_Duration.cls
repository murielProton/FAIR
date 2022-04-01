/** *******************************************************************************
 * @Author : Muriel Proton
 * @Company : Modis
 * This class includes every methodes computing duration and time.
 * This class is used in class : TH_WorkTrigger in method beforeUpdate()
 * @Interface : 
 * @Constructor : UTIL_Duration(DateTime, DateTime)
 * @Setup class and inner class : 
 * INDEX : GETER METHODS - METHODS WITH CONSTRUCTOR - STATIC METHODS - BOOLEAN STATIC METHODS
 ******************************************************************************* */
public with sharing class UTIL_Duration {
    //COSNTANT Used in this class or in UTIL_Duration_Test
    public static final Long NUMBER_OF_MS_IN_ONE_SECOND = 1000;
    public static final Long NUMBER_OF_MS_IN_ONE_MINUTE = 60000;
    public static final Long NUMBER_OF_MS_IN_ONE_HOUR = 3600000;
    public static final Long NUMBER_OF_MS_IN_ONE_WORK_DAY = 30600000; // initially this constant was : NUMBER_OF_MS_IN_ONE_DAY = 86400000
    public static final Long NUMBER_OF_MS_IN_ONE_WEEK = 153000000;//previously it was 604800000, before we applied business hours standards.
    public static final Long NUMBER_OF_MS_IN_ONE_MONTH = Long.valueOf('673200000');//previously it was 2629800000, before we applied business hours standards.
    public static final Long NUMBER_OF_MS_IN_ONE_YEAR = Long.valueOf('7741800000');//previously it was 31536000000, before we applied business hours standards.
    public static final Time START_TIME_OF_BUSINESS_HOUR = Time.newInstance(9, 0, 0, 0); //TODO : find a way to find this information from ORG
    public static final Time END_TIME_OF_BUSINESS_HOUR = Time.newInstance(17, 30, 0, 0); //TODO : find a way to find this information from ORG

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
    //------------------------------------------------------GETER METHODS---------------------------------------------
     /** 
     * This method will return the ID of Business Hours from org.
     * This method is not tested.
     * WARNING This methode should only be called ONCE in the process !
     * Called by : calculateDurationInfMS()()
     * @Parametters : NONE
     * @Returns : List<BusinessHours> 
     */
    public static BusinessHours getBusinessHours(){
        BusinessHours businessHour = [ SELECT Id 
                                        FROM BusinessHours 
                                       WHERE IsDefault=true];
        return businessHour;
    }
    /** 
     * This method will return the list of holidays from org.
     * This method is not tested.
     * WARNING This methode should only be called ONCE in the process !
     * Called by : calculateDurationInfMS()()
     * @Parametters : NONE
     * @Returns : List<Holiday> 
     */
    public static List<Holiday> getListOfHolidays(){
        List<Holiday> holidayList = new List<Holiday>();
        //Fetch all holiday list from the organization- you can check this from
        //TODO ADD CONDITION WHERE
        //TODO TRY CATCH ??? || laisser pêter ?
        holidayList=[ SELECT ActivityDate, 
                             Description, 
                             EndTimeInMinutes,
                             IsAllDay,
                             IsRecurrence,
                             Name,
                             RecurrenceDayOfMonth,
                             RecurrenceDayOfWeekMask,
                             RecurrenceEndDateOnly,
                             RecurrenceInstance,
                             RecurrenceInterval,
                             RecurrenceMonthOfYear,
                             RecurrenceStartDate,
                             RecurrenceType,
                             StartTimeInMinutes
                        FROM Holiday
                        LIMIT 20];
        return holidayList;
    }
    /**
     * //TODO : find a way to find this information from ORG And put it in constant START_TIME_OF_BUSINESS_HOUR
     * This method gets the legal start of the day for one date time.
     * Called by : UTIL_Duration.calculateNumberOfMSOnStartDateTime(List<Holiday>, BusinessHours) 
     *             UTIL_Duration.calculateNumberOfMSOnEndDateTime(List<Holiday>, BusinessHours) 
     * @Parametters : DateTime anyDateTime
     * @Returns : DateTime
     */
    public static DateTime getThisDayLegalStartOfBusinessHours(DateTime anyDateTime){
        DateTime legalStartOfBusinessHours = DateTime.newInstance(anyDateTime.year(), anyDateTime.month(), anyDateTime.day(), 9, 0, 0);
        return legalStartOfBusinessHours;
    }
    /**
     * //TODO : find a way to find this information from ORG and put it in constant END_TIME_OF_BUSINESS_HOUR
     * This method gets the legal end of the day for one date time.
     * Called by : UTIL_Duration.calculateNumberOfMSOnStartDateTime(List<Holiday>, BusinessHours) 
     *             UTIL_Duration.calculateNumberOfMSOnEndDateTime(List<Holiday>, BusinessHours) 
     * @Parametters : DateTime anyDateTime
     * @Returns : DateTime
     */
    public static DateTime getThisDayLegalEndOfBusinessHours(DateTime anyDateTime){
        DateTime legalEndOfBusinessHours = DateTime.newInstance(anyDateTime.year(), anyDateTime.month(), anyDateTime.day(), 17, 30, 0);
        return legalEndOfBusinessHours;
    }
    //------------------------------------------------------METHODS WITH CONSTRUCTOR---------------------------------------------
    /** 
     * This method will return THE TOTAL number of MS between two dates excluding Holidays and WeekEnds.
     * It adds the exact total of MS on start date and end date to the number of MS separating them.
     * Returned MS = MS on start date + MS between start date and end date + MS on end date
     * It requieres a CONSTRUCTOR.
     * Called by : TH_WorkTrigger.beforeUpdate()
     * @Parametters : NONE
     * @Returns : Long
     */
    public Long calculateDurationInfMS(){
        Date startDate = Date.newInstance(startDateTime.year(), startDateTime.month(), startDateTime.day());
        Date endDate = Date.newInstance(endDateTime.year(), endDateTime.month(), endDateTime.day());
        List<Holiday> listOfHolidays = getListOfHolidays();
        BusinessHours businessHoursID = getBusinessHours();
        Long numberOfMSInStartingDay = calculateNumberOfMSOnStartDateTime(listOfHolidays, businessHoursID);
        Long numberOfMSInEndingDay = calculateNumberOfMSOnEndDateTime(listOfHolidays, businessHoursID);
        Long numberOfMSExcludingEndAndStartDates = calculateMSFromNumberOfFullBusinesDays(listOfHolidays);
        if(startDate == endDate){
            if(!isThisDayAHoliday(endDateTime, listOfHolidays) ){
                return BusinessHours.diff(businessHoursId.Id, startDateTime, endDateTime);
            }
                return long.valueOf('0');
        }else if(isThisDayAHoliday(startDateTime, listOfHolidays) || isThisDayAWeekend(startDateTime)){
            if (isThisDayAHoliday(endDateTime, listOfHolidays) || isThisDayAWeekend(endDateTime)){
                // startEndTime && endDateTime are holidays or weekend's days
                return numberOfMSExcludingEndAndStartDates;
            }else{
                // startEndTime is a holiday or a weekend's day.
                return numberOfMSExcludingEndAndStartDates + numberOfMSInEndingDay;
            }
        }else {
            if(isThisDayAHoliday(endDateTime, listOfHolidays)|| isThisDayAWeekend(endDateTime)){
                // startEndTime is NOT a holiday or a weekend's day BUT endDateTime would be.
                return numberOfMSInStartingDay + numberOfMSExcludingEndAndStartDates;   
            }else{
                return numberOfMSInStartingDay + numberOfMSExcludingEndAndStartDates + numberOfMSInEndingDay;
            }
        }
    }
      /**
     * This method will return a number of days between start and end date that are not holidays nor Weekends.
     * It requieres a CONSTRUCTOR.
     * Called by : calculateMSFromNumberOfFullBusinesDays(List<Holiday>
     * @Parametters : List<Holiday>
     * @Returns : Long 
     */
    public Long calculateNumberOfFullDaysExcludingHolidaysAndWeekends(List<Holiday> listOfHolidays){
        Date startDate = Date.newInstance(startDateTime.year(), startDateTime.month(), startDateTime.day());
        Date endDate = Date.newInstance(endDateTime.year(), endDateTime.month(), endDateTime.day());
        //endDateTime is a special date, which is added after in the process. It needs a finer calculation. Therefor the -1!
        Integer numberOfDaysBetweenStartAndEndDate = startDate.daysBetween(endDate)-1;
        Long numberOfBusinessDaysExcludingHolidays=0;
        // startDateTime is a special date, which is added after in the process. It needs a finer calculation. Therefor the i=1!
        for(Integer i=1 ; i <= numberOfDaysBetweenStartAndEndDate ; i++){ 
            Date dateToTest = startDate.addDays(i);
            // here we use isThisDayAWeekend(dateToTest) and not isThisDateTimeWithinBusinessHours(DateTime dateTimeToTest, BusinessHours businessHoursID)
            // because the first methode will allow any day of the week to pass without dealing with Time.
            if(isThisDayAHoliday(dateToTest, listOfHolidays) || isThisDayAWeekend(dateToTest)){
                continue;
            }else{
                numberOfBusinessDaysExcludingHolidays = numberOfBusinessDaysExcludingHolidays + 1;
            }
        }
        return numberOfBusinessDaysExcludingHolidays;
    }
    /** 
     * This method will return a lenght of time or duration in milliseconds.
     * It will calculate this duration within business hours exluding holidays and weekends.
     * This length of time does not register startDatTime and endDateTime.
     * This length of time is calculated in milliseconds.
     * It requieres a CONSTRUCTOR.
     * Called by : calculateDurationInfMS()
     * @Parametters : List<Holiday>
     * @Returns : Long 
     */
    public Long calculateMSFromNumberOfFullBusinesDays(List<Holiday> listOfHolidays){
        Long numberOfDays = calculateNumberOfFullDaysExcludingHolidaysAndWeekends(listOfHolidays);
        Long numberOfMSExcludingEndAndStartDates = numberOfDays * NUMBER_OF_MS_IN_ONE_WORK_DAY;
        return numberOfMSExcludingEndAndStartDates;
    }
    /**
     * This method will return a number of MS on starting date : stardDateTime.
     * It requieres a CONSTRUCTOR.
     * Called by : calculateDurationInfMS()
     * @Parametters :List<Holiday>, BusinessHours
     * @Returns : Long
     */
    public Long calculateNumberOfMSOnStartDateTime(List<Holiday> listOfHolidays, BusinessHours businessHoursID){
        Long millisecondsToReturn = null;
        DateTime legalStartOfBusinessHours = getThisDayLegalStartOfBusinessHours(startDateTime);
        DateTime legalEndOfBusinessHours = getThisDayLegalEndOfBusinessHours(startDateTime);
        if(isThisDateTimeWithinBusinessHours(startDateTime, businessHoursID) || !isThisDayAHoliday(startDateTime, listOfHolidays)){
            if(isDateTimeBeforeNineOClock(startDateTime)){
                //IF this start date is before 9h.
                //DateTime.newInstance(year, month, day, hour, minute, second);
                return calculateLengthOfTimeInMSBetween(legalStartOfBusinessHours, legalEndOfBusinessHours);
            }
            if(!isDateTimeBeforeFiveThirty(startDateTime)){
                //IF this start date is after 17h30.
                millisecondsToReturn = 0;
                return millisecondsToReturn;
            }
            // IF this start date is within business hours or not a Holiday.
            //DateTime.newInstance(year, month, day, hour, minute, second);
            millisecondsToReturn = calculateLengthOfTimeInMSBetween(startDateTime, legalEndOfBusinessHours );
        }else{
            // IF this start date is a Holiday.
            // IF this Start date is a Weekend.
            millisecondsToReturn = 0;
        }
        return millisecondsToReturn;
    }
    /**
     * This method will return a number of MS on ending date : endDateTime.
     * It requieres a CONSTRUCTOR.
     * Called by : calculateDurationInfMS()
     * @Parametters :List<Holiday>, BusinessHours
     * @Returns : Long
     */
    public Long calculateNumberOfMSOnEndDateTime(List<Holiday> listOfHolidays, BusinessHours businessHoursID){
        DateTime legalStartOfBusinessHours = getThisDayLegalStartOfBusinessHours(endDateTime);
        DateTime legalEndOfBusinessHours = getThisDayLegalEndOfBusinessHours(endDateTime);
        if(!isThisDateTimeWithinBusinessHours(endDateTime, businessHoursID) &&  
                !isThisDayAHoliday(endDateTime, listOfHolidays)){
            if (!isDateTimeBeforeFiveThirty(endDateTime)){
                // IF this end date is after 17h30.
                return calculateLengthOfTimeInMSBetween(legalStartOfBusinessHours, legalEndOfBusinessHours);
            }
            //IF this end date is before 9h.
            return long.valueOf('0');
        }else if(!isDateTimeBeforeNineOClock(endDateTime) && 
                    isDateTimeBeforeFiveThirty(endDateTime) &&
                    isThisDateTimeWithinBusinessHours(endDateTime, businessHoursID) &&
                    !isThisDayAHoliday(endDateTime, listOfHolidays)){
            //IF this end date is after 9h and before 17h30.
            return calculateLengthOfTimeInMSBetween(legalStartOfBusinessHours, endDateTime );
        }
        else{
            // IF this end date is a Holiday.
            // IF this end date is a Weekend.
            //IF this end date is before 9h.
            return long.valueOf('0');
        }   
    }
//------------------------------------------------------STATIC METHODS ---------------------------------------------
    /** 
     * This method will return a String from the number of milliseconds it recives.
     * Called by : TH_WorkTrigger by methode beforeUpdate()
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
                Long numberOfYears = calculateNumberOfYearsFrom(roundedMS);
                roundedMS = roundedMS - (numberOfYears * NUMBER_OF_MS_IN_ONE_YEAR);
                durationInString = durationInString + numberOfYears + ' year(s), ';
            }
            // if the rounded duration in milliseconds is superior to a month.
            if(roundedMS >= NUMBER_OF_MS_IN_ONE_MONTH){
                Long numberOfMonths = calculateNumberOfMonthsFrom(roundedMS);
                roundedMS = roundedMS - (numberOfMonths * NUMBER_OF_MS_IN_ONE_MONTH);
                durationInString = durationInString + numberOfMonths + ' month(s), ';
            }
            // if the rounded duration in milliseconds is superior to a week.
            if(roundedMS >= NUMBER_OF_MS_IN_ONE_WEEK){
                Long numberOfWeeks = calculateNumberOfWeeksFrom(roundedMS);
                roundedMS = roundedMS - (numberOfWeeks * NUMBER_OF_MS_IN_ONE_WEEK);
                durationInString = durationInString + numberOfWeeks + ' week(s), ';
            }
            // if the rounded duration in milliseconds is superior to a day.
            if(roundedMS >= NUMBER_OF_MS_IN_ONE_WORK_DAY){
                Long numberOfDays = calculateNumberOfDaysFrom(roundedMS);
                roundedMS = roundedMS - (numberOfDays * NUMBER_OF_MS_IN_ONE_WORK_DAY);
                durationInString = durationInString + numberOfDays + ' day(s), ';
            }
            // if the rounded duration in milliseconds is superior to a hour.
            if(roundedMS >= NUMBER_OF_MS_IN_ONE_HOUR){
                Long numberOfHours = calculateNumberOfHoursFrom(roundedMS);
                roundedMS = roundedMS - (numberOfHours * NUMBER_OF_MS_IN_ONE_HOUR);
                durationInString = durationInString + numberOfHours + ' hour(s), ';
            }
            // if the rounded duration in milliseconds is superior to a minute.
            if(roundedMS >= NUMBER_OF_MS_IN_ONE_MINUTE){
                Long numberOfMinutes = calculateNumberOfMinutesFrom(roundedMS);
                roundedMS = roundedMS - (numberOfMinutes * NUMBER_OF_MS_IN_ONE_MINUTE);
                durationInString = durationInString + numberOfMinutes + ' minute(s), ' ;
            }
            // if the rounded duration in milliseconds is superior to a second.
            if(roundedMS >= NUMBER_OF_MS_IN_ONE_SECOND){
                Long numberOfSeconds = calculateNumberOfSecondsFrom(roundedMS);
                durationInString = durationInString + numberOfSeconds + ' second(s)';
                roundedMS = roundedMS - (numberOfSeconds * NUMBER_OF_MS_IN_ONE_SECOND);
            }
            return durationInString;
        }else{
            return null;
        } 
    }
    /**
     * This method computes a duration in Milliseconds.
     * Called by : UTIL_Duration.calculateNumberOfMSOnStartDateTime(List<Holiday>, BusinessHours) 
     *             UTIL_Duration.calculateNumberOfMSOnEndDateTime(List<Holiday>, BusinessHours) 
     * @Parametters : DateTime aDateTimeToStart, DateTime aDateTimeToEnd
     * @Returns : Long
     */
    public static Long calculateLengthOfTimeInMSBetween(DateTime aDateTimeToStart, DateTime aDateTimeToEnd ){
        Long longStartDateTime = aDateTimeToStart.getTime();
        Long longEndDateTime = aDateTimeToEnd.getTime();
        Long durationMS = longEndDateTime - longStartDateTime;
        return durationMS;
    }

    /**
     * This method computes a number of seconds within a duration expressed in milliseconds.
     * It takes a length of time in milliseconds as parametter.
     * Called by : generateAStringFromMS(Long)
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateNumberOfSecondsFrom(Long timeInMilliseconds){
        Long numberOfSeconds = timeInMilliseconds / NUMBER_OF_MS_IN_ONE_SECOND;
        return numberOfSeconds;
    }
    /**
     * This method computes a number of minutes within a duration expressed in milliseconds.
     * It takes a length of time in milliseconds as parametter.
     * Called by : generateAStringFromMS(Long)
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateNumberOfMinutesFrom(Long timeInMilliseconds){
        Long numberOfMinutes = timeInMilliseconds / NUMBER_OF_MS_IN_ONE_MINUTE;
        return numberOfMinutes;
    }
    /**
     * This method computes a number of hours within a duration expressed in milliseconds.
     * It takes a length of time in milliseconds as parametter.
     * Called by : generateAStringFromMS(Long)
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateNumberOfHoursFrom(Long timeInMilliseconds){
        Long numberOfHours = timeInMilliseconds / NUMBER_OF_MS_IN_ONE_HOUR;
        return numberOfHours;
    }
    /**
     * This method computes a number of Days within a duration expressed in milliseconds.
     * It takes a length of time in milliseconds as parametter.
     * Called by : generateAStringFromMS(Long)
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateNumberOfDaysFrom(Long timeInMilliseconds){
        Long numberOfDays = timeInMilliseconds / NUMBER_OF_MS_IN_ONE_WORK_DAY;
        return numberOfDays;
    }
    /**
     * This method computes a number of weeks within a duration expressed in milliseconds.
     * It takes a length of time in milliseconds as parametter.
     * Called by : generateAStringFromMS(Long)
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateNumberOfWeeksFrom(Long timeInMilliseconds){
        Long numberOfWeeks = timeInMilliseconds / NUMBER_OF_MS_IN_ONE_WEEK;
        return numberOfWeeks;
    }
    /**
     * This method computes a number of months within a duration expressed in milliseconds.
     * It takes a length of time in milliseconds as parametter.
     * Called by : generateAStringFromMS(Long) 
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateNumberOfMonthsFrom(Long timeInMilliseconds){
        Long numberOfMonths = timeInMilliseconds / NUMBER_OF_MS_IN_ONE_MONTH;
        return numberOfMonths;
    }
    /**
     * This method computes a number of years within a duration expressed in milliseconds.
     * It takes a length of time in milliseconds as parametter.
     * Called by : generateAStringFromMS(Long)
     * @Parametters : Long
     * @Returns : Long
     */
    public static Long calculateNumberOfYearsFrom(Long timeInMilliseconds){
        Long numberOfYears = timeInMilliseconds / NUMBER_OF_MS_IN_ONE_YEAR;
        return numberOfYears;
    }
    //------------------------------------------------------BOOLEAN STATIC METHODS ---------------------------------------------
   
    /** 
     * This method will return a boolean.
     * If the date is contained by the list of Holidays it will return true.
     * WARNING some holiday will have activity dates that have a start and an end point. This method will not work in that case.
     * Called by : calculateNumberOfFullDaysExcludingHolidaysAndWeekends(List<Holiday>)
     *             calculateNumberOfMSOnStartDateTime(List<Holiday>, BusinessHours)
     *             calculateNumberOfMSOnEndDateTime(List<Holiday>, BusinessHours)
     *             calculateDurationInfMS()
     * @Parametters : DateTime, List<Holiday>
     * @Returns : bolean 
     */
    public static boolean isThisDayAHoliday(DateTime dateToConvert, List<Holiday> listOfHolidays){
        Date thisDay = Date.newInstance(dateToConvert.year(), dateToConvert.month(), dateToConvert.day());
        for(Holiday curentHoliday : listOfHolidays){
            Date dateOfThisHoliday = curentHoliday.ActivityDate;
            if(dateOfThisHoliday == thisDay){
                return true;
            }
        }
        return false;
    }
    /** 
     * This method will return a boolean.
     * It if the date is within Business Hours it will return true.
     * You have to use this methode and note CONSTANTS beacause an Administrator can change working hours from the org.
     * Called by : calculateNumberOfMSOnStartDateTime(List<Holiday>, BusinessHours)
     *             calculateNumberOfMSOnEndDateTime(List<Holiday>, BusinessHours)
     * @Parametters : DateTime, List<BusinessHours>
     * @Returns : bolean 
     */
    public static boolean isThisDateTimeWithinBusinessHours(DateTime dateTimeToTest, BusinessHours businessHoursID){
        if(BusinessHours.isWithin(businessHoursID.id, dateTimeToTest)){
            return true;
        }
        return false;
    }
    /** 
     * This method will return a boolean.
     * It if the date is a Saturday or a Sunday it will return true.
     * Called by : calculateNumberOfFullDaysExcludingHolidaysAndWeekends(List<Holiday>)
     *             calculateDurationInfMS()
     * @Parametters : Date
     * @Returns : bolean 
     */
    public static boolean isThisDayAWeekend(DateTime dateTimeToSetToWeekDay){
        boolean valueToReturn = null;
        String dayOfWeek = dateTimeToSetToWeekDay.format('EEEE');
        if(dayOfWeek == 'Saturday'|| dayOfWeek == 'Sunday'){
            valueToReturn = true;
            return true;
        }
        valueToReturn = false;
        return false;
    }

    /** 
     * TODO link it with START_TIME_OF_BUSINESS_HOUR
     * TODO Rename it to isDateTimeBeforeOpeningHours
     * This method will return a boolean.
     * It will return true if the time of this date is before 9 H.
     * Called by : calculateNumberOfMSOnStartDateTime(List<Holiday>, BusinessHours)
     *             calculateNumberOfMSOnEndDateTime(List<Holiday>, BusinessHours)
     * @Parametters : DateTime
     * @Returns : bolean 
     */
    public static boolean isDateTimeBeforeNineOClock(DateTime dateToTest){
        Integer dateToTestYear = dateToTest.year();
        Integer dateToTestMonth = dateToTest.month();
        Integer dateToTestDay = dateToTest.day();
        //Datetime newInstance(Integer year, Integer month, Integer day, Integer hour, Integer minute, Integer second)
        DateTime thisDateTimeOfNineOClock = Datetime.newInstance(dateToTestYear, dateToTestMonth, dateToTestDay, 9, 0, 0);  
        return dateToTest < thisDateTimeOfNineOClock;
    }
    /** 
     * TODO link it with END_TIME_OF_BUSINESS_HOUR
     * TODO Rename it to isDateTimeBeforeClosingHours
     * This method will return a boolean.
     * It it will return true if the time of this date is before 17 H 30.
     * Called by : calculateNumberOfMSOnStartDateTime(List<Holiday>, BusinessHours)
     *             calculateNumberOfMSOnEndDateTime(List<Holiday>, BusinessHours)
     * @Parametters : DateTime
     * @Returns : bolean 
     */
    public static boolean isDateTimeBeforeFiveThirty(DateTime dateToTest){
        Integer dateToTestYear = dateToTest.year();
        Integer dateToTestMonth = dateToTest.month();
        Integer dateToTestDay = dateToTest.day();
        //Datetime newInstance(Integer year, Integer month, Integer day, Integer hour, Integer minute, Integer second)
        DateTime thisDateTimeOfFiveThirty = Datetime.newInstance(dateToTestYear, dateToTestMonth, dateToTestDay, 17, 30, 0);     
        return dateToTest < thisDateTimeOfFiveThirty;
    }

  
    
    
}