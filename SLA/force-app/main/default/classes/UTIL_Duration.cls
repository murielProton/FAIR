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
    public static final Long NUMBER_OF_MS_IN_ONE_WORK_DAY = 30600000;
    public static final Long NUMBER_OF_MS_IN_ONE_DAY = 86400000;
    public static final Long NUMBER_OF_MS_IN_ONE_WEEK = 604800000;
    public static final Long NUMBER_OF_MS_IN_ONE_MONTH = Long.valueOf('2629800000');
    public static final Long NUMBER_OF_MS_IN_ONE_YEAR = Long.valueOf('31536000000');
    public static final Time START_TIME_OF_BUSINESS_HOUR = Time.newInstance(9, 0, 0, 0);
    public static final Time END_TIME_OF_BUSINESS_HOUR = Time.newInstance(17, 30, 0, 0);

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
    public static Long calculateLengthOfTimeInMSBetween(DateTime aDateTimeToStart, DateTime aDateTimeToEnd ){
        Long longStartDateTime = aDateTimeToStart.getTime();
        Long longEndDateTime = aDateTimeToEnd.getTime();
        Long durationMS = longEndDateTime - longStartDateTime;
        return durationMS;
    }
    /**
     * This method gets the legal start of the day for one date time.
     * Called by : 
     * @Parametters : DateTime anyDateTime
     * @Returns : DateTime
     */
    public DateTime getThisDayLegalStartOfBusinessHours(DateTime anyDateTime){
        DateTime legalStartOfBusinessHours = DateTime.newInstance(anyDateTime.year(), anyDateTime.month(), anyDateTime.day(), 9, 0, 0);
        return legalStartOfBusinessHours;
    }
    /**
     * This method gets the legal end of the day for one date time.
     * Called by : 
     * @Parametters : DateTime anyDateTime
     * @Returns : DateTime
     */
    public DateTime getThisDayLegalEndOfBusinessHours(DateTime anyDateTime){
        DateTime legalEndOfBusinessHours = DateTime.newInstance(anyDateTime.year(), anyDateTime.month(), anyDateTime.day(), 17, 30, 0);
        return legalEndOfBusinessHours;
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
            //System.debug('fin ->' + durationInString+'}');
            return durationInString;
        }else{
            return null;
        } 
    }
    public static BusinessHours getBusinessHourID(){
        BusinessHours businessHour = [SELECT Id 
                                        FROM BusinessHours 
                                       WHERE IsDefault=true];
        System.debug('businessHour Id - '+businessHour.Id);
        return businessHour;
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
        BusinessHours businessHoursId = getBusinessHourID();
        Long durationOfBusinessHoursSpent = BusinessHours.diff(businessHoursId.Id, startDateTime, endDateTime);
        System.debug('durationOfBusinessHoursSpent - '+durationOfBusinessHoursSpent);
        return durationOfBusinessHoursSpent;
    }
    /** 
     * This method will return the list of holidays.
     * This method is not tested.
     * Called by : calculateNumberOfBusinessHoursExcludingHolidaysSpentInMS()
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
     * This method will return a boolean.
     * It if the date is contained by the list of Holidays it will return true.
     * WARNING some holiday will have activity dates that have a start and an end point. This method will not work in that case.
     * Called by : calculateNumberOfDaysExcludingHolidaysAndWeekends()
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
     * Called by : 
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
     * WARNING some holiday will have activity dates that have a start and an end point. This method will not work in that case.
     * Called by : calculateNumberOfDaysExcludingHolidaysAndWeekends()
     * @Parametters : Date, List<Holiday>
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
     * This method will return a boolean.
     * It will return true if the time of this date is before 9 H.
     * NEEDS CONSTRUCTOR
     * Called by : 
     * @Parametters : 
     * @Returns : bolean 
     */
    public boolean isDateTimeBeforeNineOClock(DateTime dateToTest){
        Integer dateToTestYear = dateToTest.year();
        Integer dateToTestMonth = dateToTest.month();
        Integer dateToTestDay = dateToTest.day();
        //Datetime newInstance(Integer year, Integer month, Integer day, Integer hour, Integer minute, Integer second)
        DateTime thisDateTimeOfNineOClock = Datetime.newInstance(dateToTestYear, dateToTestMonth, dateToTestDay, 9, 0, 0);
        System.debug('before 9 dateToTest = '+dateToTest); 
        System.debug('thisDateTimeOfNineOClock = '+thisDateTimeOfNineOClock);        
        return dateToTest < thisDateTimeOfNineOClock;
    }
    /** 
     * This method will return a boolean.
     * It it will return true if the time of this date is before 17 H 30.
     * NEEDS CONSTRUCTOR
     * Called by : 
     * @Parametters : 
     * @Returns : bolean 
     */
    public boolean isDateTimeBeforeFiveThirty(DateTime dateToTest){
        Integer dateToTestYear = dateToTest.year();
        Integer dateToTestMonth = dateToTest.month();
        Integer dateToTestDay = dateToTest.day();
        //Datetime newInstance(Integer year, Integer month, Integer day, Integer hour, Integer minute, Integer second)
        DateTime thisDateTimeOfFiveThirty = Datetime.newInstance(dateToTestYear, dateToTestMonth, dateToTestDay, 17, 30, 0);
        System.debug('before 17h30 dateToTest = '+dateToTest); 
        System.debug('thisDateTimeOfFiveThirty = '+thisDateTimeOfFiveThirty);        
        return dateToTest < thisDateTimeOfFiveThirty;
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
        System.debug('doesStartDateEqualEndDate - startDate = '+startDate);
        System.debug('doesStartDateEqualEndDate - endDate = '+endDate);
        if(startDate == endDate){
            return true;
        }
        return false;
    }
    /**
     * TODO : the system still does not heed the fact that I have implemented weekends.
     * This method will return a number of days between start and end date that are not holidays or Weekends.
     * It requieres a CONSTRUCTOR.
     * Called by : 
     * @Parametters : List<Holiday> listOfHolidays
     * @Returns : Long 
     */
    public Long calculateNumberOfFullDaysExcludingHolidaysAndWeekends(List<Holiday> listOfHolidays){
        Date startDate = Date.newInstance(startDateTime.year(), startDateTime.month(), startDateTime.day());
        Date endDate = Date.newInstance(endDateTime.year(), endDateTime.month(), endDateTime.day());
        //endDateTime is a special date, which is added after in the process. It needs a finer calculation. Therefor the -1!
        Integer numberOfDaysBetweenStartAndEndDate = startDate.daysBetween(endDate)-1;
        System.debug('startDate.daysBetween(endDate) = '+startDate.daysBetween(endDate));
        System.debug('numberOfDaysBetweenStartAndEndDate = '+numberOfDaysBetweenStartAndEndDate);
        Long numberOfBusinessDaysExcludingHolidays=0;
        // startDateTime is a special date, which is added after in the process. It needs a finer calculation. Therefor the i=1!
        for(Integer i=1 ; i <= numberOfDaysBetweenStartAndEndDate ; i++){ 
            Date dateToTest = startDate.addDays(i);
            System.debug('dateToTest '+dateToTest);
            // here we use isThisDayAWeekend(dateToTest) and not isThisDateTimeWithinBusinessHours(DateTime dateTimeToTest, BusinessHours businessHoursID)
            // because the first methode will allow any day of the week to pass without dealing with Time.
            if(isThisDayAHoliday(dateToTest, listOfHolidays) || isThisDayAWeekend(dateToTest)){
                continue;
            }else{
                System.debug('numberOfBusinessDaysExcludingHolidays '+numberOfBusinessDaysExcludingHolidays);
                numberOfBusinessDaysExcludingHolidays = numberOfBusinessDaysExcludingHolidays + 1;
            }
        }
        return numberOfBusinessDaysExcludingHolidays;
    }
    /** 
     * This method will return a lenght of time or duration milliseconds.
     * It will calculate this duration within business hours exluding holidays and weekends.
     * This length of time does not register startDatTime and endDateTime.
     * This length of time is calculated in milliseconds.
     * Called by : 
     * @Parametters : List<Holiday> listOfHolidays 
     * @Returns : Long 
     */
    public Long calculateMSFromNumberOfFullBusinesDaysWithoutEndAndStartDates(List<Holiday> listOfHolidays){
        Long numberOfDays = calculateNumberOfFullDaysExcludingHolidaysAndWeekends(listOfHolidays);
        Long numberOfMSExcludingEndAndStartDates = numberOfDays * NUMBER_OF_MS_IN_ONE_WORK_DAY;
        return numberOfMSExcludingEndAndStartDates;
    }
    /**
     * This method will return a number of MS on starting date : stardDateTime.
     * TODO put 2 parameters : BusinessHours businessHoursID = getBusinessHourID() and List<Holiday> listOfHolidays = getListOfHolidays();
     * NEEDS A CONSTRUCTOR
     * Called by : 
     * @Parametters :
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

                System.debug('SatartDATETIME is a day of busines but before business hours.');
                return calculateLengthOfTimeInMSBetween(legalStartOfBusinessHours, legalEndOfBusinessHours);
            }
            if(!isDateTimeBeforeFiveThirty(startDateTime)){
                //IF this start date is after 17h30.
                millisecondsToReturn = 0;
                System.debug('SatartDATETIME is a day of business but after business hours.');
                return millisecondsToReturn;
            }
            // IF this start date is within business hours or not a Holiday.
            //DateTime.newInstance(year, month, day, hour, minute, second);
            millisecondsToReturn = calculateLengthOfTimeInMSBetween(startDateTime, legalEndOfBusinessHours );
            System.debug('SatartDATETIME is a day of business and NOT a holiday');
        }else{
            // IF this start date is a Holiday.
            // IF this Start date is a Weekend.
            millisecondsToReturn = 0;
            System.debug('I am zero');
        }
        System.debug('Retruning millisecondsToReturn = '+millisecondsToReturn);
        return millisecondsToReturn;
    }
    /**
     * This method will return a number of MS on ending date : endDateTime.
     * NEEDS A CONSTRUCTOR
     * Called by : 
     * @Parametters :
     * @Returns : Long
     */
    public Long calculateNumberOfMSOnEndDateTime(List<Holiday> listOfHolidays, BusinessHours businessHoursID){
        DateTime legalStartOfBusinessHours = getThisDayLegalStartOfBusinessHours(endDateTime);
        DateTime legalEndOfBusinessHours = getThisDayLegalEndOfBusinessHours(endDateTime);
        if(!isThisDateTimeWithinBusinessHours(endDateTime, businessHoursID) &&  
                !isThisDayAHoliday(endDateTime, listOfHolidays)){
            if (!isDateTimeBeforeFiveThirty(endDateTime)){
                // IF this end date is after 17h30.
                System.debug('End date time is a business day after 17h30.');
                return calculateLengthOfTimeInMSBetween(legalStartOfBusinessHours, legalEndOfBusinessHours);
            }
            //IF this end date is before 9h.
            return long.valueOf('0');
        }else if(!isDateTimeBeforeNineOClock(endDateTime) && 
                    isDateTimeBeforeFiveThirty(endDateTime) &&
                    isThisDateTimeWithinBusinessHours(endDateTime, businessHoursID) &&
                    !isThisDayAHoliday(endDateTime, listOfHolidays)){
            //IF this end date is after 9h and before 17h30.
            System.debug('End date time is a business day within business hours.');
            return calculateLengthOfTimeInMSBetween(legalStartOfBusinessHours, endDateTime );
        }
        else{
            // IF this end date is a Holiday.
            // IF this end date is a Weekend.
            //IF this end date is before 9h.
            System.debug('calculateNumberOfMSOnEndDateTime zero');
            return long.valueOf('0');
        }   
    }
    /** 
     * This method will return THE TOTAL number of MS between two dates excluding Holidays and WeekEnds.
     * It also counts startDateTime and endDateTime.
     * Called by : 
     * @Parametters :
     * @Returns : String
     */
    public Long calculateDurationInfMS(){
        Date startDate = Date.newInstance(startDateTime.year(), startDateTime.month(), startDateTime.day());
        Date endDate = Date.newInstance(endDateTime.year(), endDateTime.month(), endDateTime.day());
        List<Holiday> listOfHolidays = getListOfHolidays();
        BusinessHours businessHoursID = getBusinessHourID();
        Long numberOfMSInStartingDay = calculateNumberOfMSOnStartDateTime(listOfHolidays, businessHoursID);
        Long numberOfMSInEndingDay = calculateNumberOfMSOnEndDateTime(listOfHolidays, businessHoursID);
        Long numberOfMSExcludingEndAndStartDates = calculateMSFromNumberOfFullBusinesDaysWithoutEndAndStartDates(listOfHolidays);
        if(startDate == endDate){
            if(!isThisDayAHoliday(endDateTime, listOfHolidays) ){
                System.debug('startDate == endDate && within business hours');
                return BusinessHours.diff(businessHoursId.Id, startDateTime, endDateTime);
            }
            System.debug('startDate == endDate');
                return long.valueOf('0');
        }else if(isThisDayAHoliday(startDateTime, listOfHolidays) || isThisDayAWeekend(startDateTime)){
            if (isThisDayAHoliday(endDateTime, listOfHolidays) || isThisDayAWeekend(endDateTime)){
                // startEndTime && endDateTime are holidays or weekend's days
                System.debug('startDate && endDate are holidays');
                return numberOfMSExcludingEndAndStartDates;
            }else{
                // startEndTime is a holiday or a weekend's day.
                System.debug('startDate is a holiday BUT endDate is not a holiday.');
                return numberOfMSExcludingEndAndStartDates + numberOfMSInEndingDay;
            }
        }else {
            if(isThisDayAHoliday(endDateTime, listOfHolidays)|| isThisDayAWeekend(endDateTime)){
                // startEndTime is NOT a holiday or a weekend's day BUT endDateTime would be.
                System.debug('startDate is not a holiday but endate is');
                return numberOfMSInStartingDay + numberOfMSExcludingEndAndStartDates;   
            }else{
                System.debug('BOth are NOT Holidays');
                return numberOfMSInStartingDay + numberOfMSExcludingEndAndStartDates + numberOfMSInEndingDay;
            }
        }
    }
    
}