/** *******************************************************************************
 * @Author : Muriel Proton
 * @Company : Modis
 * This class tests the folowing classe(s) : UTIL_Duration
 * This class is used in class : 
 * @Interface : 
 * @Setup method : from line 
 * @Setup class and inner class : 
 * 
 ******************************************************************************* */
@isTest
public with sharing class UTIL_Duration_Test {
  //THE CONSTANTS OF THIS CLASS are stored in class UTIL_Duration
  /**
  * This method cheks if calculateLengthOfTimeInMSBetween() returns the right number of Milliseconds.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testCalculateLengthOfTimeInMSBetween(){
    Test.startTest();
    DateTime dateTimeStart = Datetime.newInstance(2022, 2, 15);
    DateTime dateTimeEnd = dateTimeStart.addSeconds(1);
    Long realDurationToTest =  UTIL_Duration.calculateLengthOfTimeInMSBetween(dateTimeStart, dateTimeEnd);
    Test.stopTest();
    System.assertEquals(UTIL_Duration.NUMBER_OF_MS_IN_ONE_SECOND, realDurationToTest, 'It is not the right number of milliseconds.');
  }
  /**
  * This method cheks if calculateTimeInSeconds() returns the right number of seconds.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testCalculateTimeInSeconds(){
    Test.startTest();
    Long realDurationToTest =  UTIL_Duration.calculateTimeInSeconds(1230);
    Test.stopTest();
    System.assertEquals(1, realDurationToTest, 'It is not the right number of seconds.');
  }
  /**
  * This method cheks if calculateTimeInMinutes() returns the right number of minutes.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testCalculateTimeInMinutes(){
    Test.startTest();
    Long realDurationToTest =  UTIL_Duration.calculateTimeInMinutes(61230);
    Test.stopTest();
    System.assertEquals(1, realDurationToTest, 'It is not the right number of minutes.');
  }
  /**
  * This method cheks if calculateTimeInHours() returns the right number of hours.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testCalculateTimeInHours(){
    Test.startTest();
    Long realDurationToTest =  UTIL_Duration.calculateTimeInHours(3691230);
    Test.stopTest();
    System.assertEquals(1, realDurationToTest, 'It is not the right number of hours.');
  }
  /**
  * This method cheks if calculateTimeInDays() returns the right number of days.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testCalculateTimeInDays(){
    Test.startTest();
    Long realDurationToTest =  UTIL_Duration.calculateTimeInDays(87691230);
    Test.stopTest();
    System.assertEquals(2, realDurationToTest, 'It is not the right number of days.');
  }
  /**
  * This method cheks if calculateTimeInWeeks() returns the right number of weeks.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testCalculateTimeInWeeks(){
    Test.startTest();
    Long realDurationToTest =  UTIL_Duration.calculateTimeInWeeks(687691230);
    Test.stopTest();
    System.assertEquals(4, realDurationToTest, 'It is not the right number of weeks.');
  }
  /**
  * This method cheks if calculateTimeInMonths() returns the right number of months.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testCalculateTimeInMonths(){
    Long nubmberOfMSToTest = long.valueOf('2630691230');
    Test.startTest();
    Long realDurationToTest = UTIL_Duration.calculateTimeInMonths(nubmberOfMSToTest);
    Test.stopTest();
    System.assertEquals(3, realDurationToTest, 'It is not the right number of months.');
  }
  /**
  * This method cheks if calculateTimeInMonths() returns the right number of years.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testCalculateTimeInYears(){
    Long nubmberOfMSToTest = long.valueOf('32630691230');
    Test.startTest();
    Long realDurationToTest = UTIL_Duration.calculateTimeInYears(nubmberOfMSToTest);
    Test.stopTest();
    System.assertEquals(4, realDurationToTest, 'It is not the right number of years.');
  }
/**
  * This methode tests generateAStringFromMS.
  * If the parametters injected are inferior to a second will it return the right String ?
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testGenerateAStringFromMSInferiorToOneSecond(){
    Long nubmberOfMSToTest = long.valueOf('900');
    Test.startTest();
    String realStringToTest = UTIL_Duration.generateAStringFromMS(nubmberOfMSToTest);
    Test.stopTest();
    System.assertEquals('under a second.', realStringToTest, 'The string is not right for an input set to less than 1 second.');
  }
  /**
  * This methode tests generateAStringFromMS.
  * If the parametters injected are superior to a second will it return the right String ?
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testGenerateAStringFromMSSuperiorToOneSecond(){
    Long nubmberOfMSToTest = long.valueOf('1200');
    Test.startTest();
    String realStringToTest = UTIL_Duration.generateAStringFromMS(nubmberOfMSToTest);
    Test.stopTest();
    System.assertEquals('1 second(s)', realStringToTest, 'The string is not right for an input set to more than 1 second.');
  }
    /**
  * This methode tests generateAStringFromMS.
  * If the parametters injected are superior to a minute will it return the right String ?
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testGenerateAStringFromMSSuperiorToOneMinute(){
    Long nubmberOfMSToTest = long.valueOf('61200');
    Test.startTest();
    String realStringToTest = UTIL_Duration.generateAStringFromMS(nubmberOfMSToTest);
    Test.stopTest();
    System.assertEquals('1 minute(s), 1 second(s)', realStringToTest, 'The string is not right for an input set to more than 1 minute.');
  }
  /**
  * This methode tests generateAStringFromMS.
  * If the parametters injected are superior to an hour will it return the right String ?
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testGenerateAStringFromMSSuperiorToOneHour(){
    Long nubmberOfMSToTest = long.valueOf('3661200');
    Test.startTest();
    String realStringToTest = UTIL_Duration.generateAStringFromMS(nubmberOfMSToTest);
    Test.stopTest();
    System.assertEquals('1 hour(s), 1 minute(s), 1 second(s)', realStringToTest, 'The string is not right for an input set to more than 1 hour.');
  }
  /**
  * This methode tests generateAStringFromMS.
  * If the parametters injected are superior to a day will it return the right String ?
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testGenerateAStringFromMSSuperiorToOneDay(){
    Long nubmberOfMSToTest = long.valueOf('86661200');
    Test.startTest();
    String realStringToTest = UTIL_Duration.generateAStringFromMS(nubmberOfMSToTest);
    Test.stopTest();
    System.assertEquals('2 day(s), 7 hour(s), 4 minute(s), 21 second(s)', realStringToTest, 'The string is not right for an input set to more than 1 day.');
  }
  /**
  * This methode tests generateAStringFromMS.
  * If the parametters injected are equal to a week will it return the right String ?
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testGenerateAStringFromMSSuperiorToAWeek(){
    Long nubmberOfMSToTest = long.valueOf('615910000');
    Test.startTest();
    String realStringToTest = UTIL_Duration.generateAStringFromMS(nubmberOfMSToTest);
    Test.stopTest();
    System.assertEquals('4 week(s), 1 hour(s), 5 minute(s), 10 second(s)', realStringToTest, 'The string is not right for an input set to more than 1 week.');
  }
  /**
  * This methode tests generateAStringFromMS.
  * If the parametters injected are superior to a month will it return the right String ?
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  * ! DO NOT PASS TODO Find what to do ?
  */
  @isTest
  public static void testGenerateAStringFromMSSuperiorToOneMonth(){
    Long nubmberOfMSToTest = long.valueOf('2830461200');
    Test.startTest();
    String realStringToTest = UTIL_Duration.generateAStringFromMS(nubmberOfMSToTest);
    Test.stopTest();
    System.assertEquals('4 month(s), 4 day(s), 4 hour(s), 14 minute(s), 21 second(s)', realStringToTest, 'The string is not right for an input set to more than 1 month.');
  }
    /**
  * This methode tests generateAStringFromMS.
  * If the parametters injected are superior to a year will it return the right String ?
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  * ! DO NOT PASS TODO Find what to do ?
  */
  @isTest
  public static void testGenerateAStringFromMSSuperiorToOneYear(){
    Long nubmberOfMSToTest = long.valueOf('32647111111');
    Test.startTest();
    String realStringToTest = UTIL_Duration.generateAStringFromMS(nubmberOfMSToTest);
    Test.stopTest();
    System.assertEquals('4 year(s), 2 month(s), 2 week(s), 7 hour(s), 38 minute(s), 31 second(s)', realStringToTest, 'The string is not right for an input set to more than 1 year.');
  }
  /**
   * This method tests isThisDayAHoliday(Date thisDay, List<Holiday> listOfHolidays)
   * It requieres a CONSTRUCTOR.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testIsThisDayAHoliday(){
    //DateTime.newInstance(year, month, day, hour, minute, second);
    Date thisDay = Date.newInstance(2022, 7, 14);
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    Test.startTest();
    boolean isItAHoliday;
    isItAHoliday = UTIL_Duration.isThisDayAHoliday(thisDay, listOfHolidays);
    Test.stopTest();
    System.assertEquals(true, isItAHoliday);
  }
    /**
   * This method tests isThisDayAHoliday(Date thisDay, List<Holiday> listOfHolidays)
   * It requieres a CONSTRUCTOR.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testIsThisDayAWeekend(){
    //DateTime.newInstance(year, month, day, hour, minute, second);
    Date dateToTestWeekday = Date.newInstance(2022, 7, 14);
    Date dateToTestSunday = Date.newInstance(2022, 6, 12);
    Date dateToTestSaturday = Date.newInstance(2022, 6, 11);
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    Test.startTest();
    boolean isItAWeekEnd1 = UTIL_Duration.isThisDayAWeekend(dateToTestWeekday);
    boolean isItAWeekEnd2 = UTIL_Duration.isThisDayAWeekend(dateToTestSunday);
    boolean isItAWeekEnd3 = UTIL_Duration.isThisDayAWeekend(dateToTestSaturday);
    Test.stopTest();
    System.assertEquals(false, isItAWeekEnd1);
    System.assertEquals(true, isItAWeekEnd2);
    System.assertEquals(true, isItAWeekEnd3);
  }
    /**
   * This method tests isThisDateTimeWithinBusinessHours(DateTime, List<BusinessHours>)
   * It requieres a CONSTRUCTOR.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testisThisDateTimeWithinBusinessHours(){
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime dateTimeToTestTooEarly = Datetime.newInstance(2022, 3, 16, 8, 0, 0);
    DateTime dateTimeToTestTooLate = Datetime.newInstance(2022, 3, 16, 19, 0, 0);
    DateTime dateTimeToTestSaturday = Datetime.newInstance(2022, 3, 5, 8, 0, 0);
    DateTime dateTimeToTestTrue = Datetime.newInstance(2022, 3, 16, 10, 0, 0);
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    Test.startTest();
    boolean testTooEarly = UTIL_Duration.isThisDateTimeWithinBusinessHours(dateTimeToTestTooEarly,businessHoursID);
    boolean testTooLate = UTIL_Duration.isThisDateTimeWithinBusinessHours(dateTimeToTestTooLate,businessHoursID);
    boolean testSaturday = UTIL_Duration.isThisDateTimeWithinBusinessHours(dateTimeToTestSaturday,businessHoursID);
    boolean testTrue = UTIL_Duration.isThisDateTimeWithinBusinessHours(dateTimeToTestTrue,businessHoursID);
    Test.stopTest();
    System.assertEquals(false, testTooEarly);
    System.assertEquals(false, testTooLate);
    System.assertEquals(false, testSaturday);
    System.assertEquals(true, testTrue);
  }
  /**
   * This method tests isDateTimeBeforeNineOClock
   * It requieres a CONSTRUCTOR.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testIsStartTimeBeforeNineOClock(){
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = Datetime.newInstance(2022, 3, 14, 8, 0, 0);
    DateTime endDateTime = Datetime.newInstance(2022, 3, 14, 10, 0, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    boolean testBeforeNine = utilDuration.isDateTimeBeforeNineOClock(startDateTime);
    Test.stopTest();
    System.assertEquals(true, testBeforeNine);
  }
  /**
   * This method tests isDateTimeBeforeFiveThirty()
   * It requieres a CONSTRUCTOR.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testIsEndTimeBeforeFiveThirty(){
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = Datetime.newInstance(2022, 3, 14, 8, 0, 0);
    DateTime endDateTime = Datetime.newInstance(2022, 3, 14, 17, 40, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    boolean testAfterFiveThirty = utilDuration.isDateTimeBeforeFiveThirty(endDateTime);
    Test.stopTest();
    System.assertEquals(false, testAfterFiveThirty);
  }
  
  /**
   * This method tests calculateNumberOfFullDaysExcludingHolidaysAndWeekends(List<Holiday> listOfHolidays).
   * TODO : the system still does not heed the fact that I have implemented weekends.
   * It requieres a CONSTRUCTOR.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testcalculateNumberOfFullDaysExcludingHolidaysAndWeekendsForAWeekInJuly(){
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 7, 11, 09, 00, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 7, 17, 17, 30, 00);
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOfDays = utilDuration.calculateNumberOfFullDaysExcludingHolidaysAndWeekends(listOfHolidays);
    Test.stopTest();
    Long expectedNumber = 3;
    System.assertEquals(expectedNumber, realNumberOfDays);
  }
  /**
   * This method tests calculateNumberOfFullDaysExcludingHolidaysAndWeekends(List<Holiday> listOfHolidays).
   * I need to verify that in a year this method takes notice of ALL the 11 holidays set in my org.
   * It requieres a CONSTRUCTOR.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   * TODO MAKE IT WORK
   */
  @isTest
  public static void testcalculateNumberOfFullDaysExcludingHolidaysAndWeekendsForAYear(){
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 1, 1, 09, 00, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 12, 31, 17, 30, 00);
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOfDays = utilDuration.calculateNumberOfFullDaysExcludingHolidaysAndWeekends(listOfHolidays);
    Test.stopTest();
    // in 2022 the last and first day of the year are saturdays.
    // numbers of holidays on week days = 7
    // number of Saturdays = 53
    // number of sundays = 52
    Long expectedNumber = 253;
    System.assertEquals(expectedNumber, realNumberOfDays);
  }
  /**
   * This method tests calculateNumberOfFullDaysExcludingHolidaysAndWeekends(List<Holiday> listOfHolidays).
   * I need to verify that in a howl buisness week this method will chop off startDateTime and endDateTime.
   * It requieres a CONSTRUCTOR.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   * TODO MAKE IT WORK
   */
  @isTest
  public static void testcalculateNumberOfFullDaysExcludingHolidaysAndWeekendsForAWeek(){
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 3, 7, 09, 00, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 3, 11, 17, 30, 00);
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    System.debug('endDateTime = '+endDateTime);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOfDays = utilDuration.calculateNumberOfFullDaysExcludingHolidaysAndWeekends(listOfHolidays);
    Test.stopTest();
    Long expectedNumber = 3;
    System.assertEquals(expectedNumber, realNumberOfDays);
  }
  
  /**
   * This method tests calculateNumberOfBuisinessHoursExcludingHolidaysAndWeekendsSpentInMS(List<Holiday> listOfHolidays).
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateMSFromNumberOfFullBusinesDaysWithoutEndAndStartDatesForAYear(){
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 1, 1, 09, 00, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 12, 31, 17, 30, 00);
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays(); 
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOfMS = utilDuration.calculateMSFromNumberOfFullBusinesDaysWithoutEndAndStartDates(listOfHolidays);
    System.debug('realNumberOfMS in a year = ' + realNumberOfMS);
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('7741800000');
    System.assertEquals(expectedNumberOfMS, realNumberOfMS);
  }
    /**
   * This method tests calculateNumberOfBuisinessHoursExcludingHolidaysAndWeekendsSpentInMS(List<Holiday> listOfHolidays).
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateMSFromNumberOfFullBusinesDaysWithoutEndAndStartDatesForAWeek(){
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 9, 26, 09, 00, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 9, 30, 17, 30, 00);
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays(); 
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOfMS = utilDuration.calculateMSFromNumberOfFullBusinesDaysWithoutEndAndStartDates(listOfHolidays);
    System.debug('realNumberOfMS in a year = ' + realNumberOfMS);
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('91800000');
    System.assertEquals(expectedNumberOfMS, realNumberOfMS);
  }
  /**
   * 
   * This method tests calculateNumberOfMSOnStartDateTime(startDateTime, endDateTime).
   * The date is within working hours.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateNumberOfMSOnStartDateTimeWhenStartDayIsWithinBusinessHours(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 3, 15, 09, 30, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 12, 31, 17, 30, 00);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateNumberOfMSOnStartDateTime(listOfHolidays, businessHoursID);
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('28800000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * 
   * This method tests calculateNumberOfMSOnStartDateTime(startDateTime, endDateTime).
   * The date is NOT within working hours, it is earlier.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateNumberOfMSOnStartDateTimeWhenStartDayIsEarlierThanNine(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 3, 15, 7, 30, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 12, 31, 17, 30, 00);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateNumberOfMSOnStartDateTime(listOfHolidays, businessHoursID);
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('30600000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
    /**
   * 
   * This method tests calculateNumberOfMSOnStartDateTime(startDateTime, endDateTime).
   * The date is NOT within working hours, it is a holiday.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateNumberOfMSOnStartDateTimeWhenStartDayIsHoliday(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 7, 14, 7, 30, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 12, 31, 17, 30, 00);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateNumberOfMSOnStartDateTime(listOfHolidays, businessHoursID);
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('0');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * 
   * This method tests calculateNumberOfMSOnStartDateTime(startDateTime, endDateTime).
   * The date is NOT within working hours. It is after 17h30, but it is a day of business.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateNumberOfMSOnStartDateTimeWhenStartDayIsAferFiveThirty(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 3, 15, 18, 30, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 12, 31, 17, 30, 00);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateNumberOfMSOnStartDateTime(listOfHolidays, businessHoursID);
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('0');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * 
   * This method tests calculateNumberOfMSOnStartDateTime(startDateTime, endDateTime).
   * The date is NOT within working hours. It is weekend, a Saturday.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateNumberOfMSOnStartDateTimeWhenStartDayIsASaturday(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 3, 19, 18, 30, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 12, 31, 17, 30, 00);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateNumberOfMSOnStartDateTime(listOfHolidays, businessHoursID);
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('0');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * 
   * This method tests calculateNumberOfMSOnEndDateTime(List<Holiday> listOfHolidays, BusinessHours businessHoursID)
   * The date is NOT within working hours. It is a holiday.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateNumberOfMSOnEndDateTimeWhenHoliday(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 3, 19, 18, 30, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 7, 14, 12, 30, 00);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateNumberOfMSOnEndDateTime(listOfHolidays, businessHoursID);
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('0');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * 
   * This method tests calculateNumberOfMSOnEndDateTime(List<Holiday> listOfHolidays, BusinessHours businessHoursID)
   * The date is within working hours. It is not holiday, but it is before 9h.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateNumberOfMSOnEndDateTimeWhenWithinWorkingHoursBeforeNine(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 3, 19, 18, 30, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 3, 21, 7, 30, 00);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateNumberOfMSOnEndDateTime(listOfHolidays, businessHoursID);
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('0');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * 
   * This method tests calculateNumberOfMSOnEndDateTime(List<Holiday> listOfHolidays, BusinessHours businessHoursID)
   * The date is within working hours. It is not holiday, but it is after 17h30.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateNumberOfMSOnEndDateTimeWhenWithinWorkingHoursAfterFiveThirty(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 3, 19, 18, 30, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 3, 21, 19, 30, 00);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateNumberOfMSOnEndDateTime(listOfHolidays, businessHoursID);
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('30600000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * This method tests calculateNumberOfMSOnEndDateTime(List<Holiday> listOfHolidays, BusinessHours businessHoursID)
   * The date is within working hours. It is not holiday, but a saturday.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateNumberOfMSOnEndDateTimeWhenSaturday(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 3, 15, 18, 30, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 3, 19, 7, 30, 00);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateNumberOfMSOnEndDateTime(listOfHolidays, businessHoursID);
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('0');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * 
   * This method tests calculateNumberOfMSOnEndDateTime(List<Holiday> listOfHolidays, BusinessHours businessHoursID)
   * The date is within working hours. It is not holiday.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateNumberOfMSOnEndDateTimeWhenWithinWorkingHours(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 3, 19, 18, 30, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 3, 17, 16, 20, 15);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateNumberOfMSOnEndDateTime(listOfHolidays, businessHoursID);
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('26415000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * 
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate == endDate
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateMSIfStartDateEqualsEndDateWhenStartDateIsAHoliday(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 8, 15, 9, 00, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 8, 15, 17, 30, 15);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('0');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
    /**
   * 
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate == endDate
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateMSIfStartDateEqualsEndDateWhenStartAndEndTimeAreBeforeNine(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 5, 4, 7, 00, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 5, 4, 8, 30, 15);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('0');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * 
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate == endDate
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfStartDateEqualsEndDateWhenStartAndEndTimeAreAfterFiveThirty(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 5, 4, 17, 31, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 5, 4, 19, 30, 15);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('0');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * 
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate == endDate
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfStartDateEqualsEndDateWhenStartTimeIsBeforeNine(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 5, 4, 8, 31, 0);
    DateTime endDateTime = DateTime.newInstance(2022, 5, 4, 17, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('30600000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * 
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate == endDate
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfStartDateEqualsEndDateWhenStartTimeIsNine(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 5, 4, 9, 0, 0);
    DateTime endDateTime = DateTime.newInstance(2022, 5, 4, 17, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('30600000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * 
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate == endDate
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfStartDateEqualsEndDateWhenEndTimeIsAfterFiveThirty(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 5, 4, 9, 0, 0);
    DateTime endDateTime = DateTime.newInstance(2022, 5, 4, 19, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('30600000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * 
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate == endDate
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfStartDateEqualsEndDate(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 5, 4, 10, 0, 15);
    DateTime endDateTime = DateTime.newInstance(2022, 5, 4, 15, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('19785000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate different endDate
   * endDateTime is a holiday.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfEndDateIsAHoliday(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 11, 7, 10, 0, 15);
    DateTime endDateTime = DateTime.newInstance(2022, 11, 11, 15, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('118785000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate different endDate
   * startDateTime is a holiday.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfStartDateIsAHoliday(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 6, 6, 10, 0, 15);
    DateTime endDateTime = DateTime.newInstance(2022, 6, 10, 15, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('115200000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate different endDate
   * end time is before 9h
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfEndTimeIsBeforeNine(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 4, 11, 10, 0, 15);
    DateTime endDateTime = DateTime.newInstance(2022, 4, 15, 7, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('118785000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate different endDate
   * start Time is before 9h.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfStartTimeIsBeforeNine(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 4, 11, 6, 0, 15);
    DateTime endDateTime = DateTime.newInstance(2022, 4, 15, 15, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('145800000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate different endDate
   * end time is after 17h30
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfEndTimeIsAfterFiveThirty(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 4, 11, 10, 0, 15);
    DateTime endDateTime = DateTime.newInstance(2022, 4, 15, 19, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('149385000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate different endDate
   * start Time is after 17h30.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfStartTimeIsAfterFiveThirty(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 4, 11, 21, 0, 15);
    DateTime endDateTime = DateTime.newInstance(2022, 4, 15, 15, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('115200000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate different endDate
   * start Date is a Saturday
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfStartDateIsASaturday(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 4, 9, 10, 0, 15);
    DateTime endDateTime = DateTime.newInstance(2022, 4, 15, 15, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('145800000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
 /**
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate different endDate
   * start Date is a Sunday
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfStartDateIsASunday(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 4, 10, 10, 0, 15);
    DateTime endDateTime = DateTime.newInstance(2022, 4, 15, 15, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('145800000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate different endDate
   * end Date is a Saturday
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfEndDateIsASaturday(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 4, 11, 10, 0, 15);
    DateTime endDateTime = DateTime.newInstance(2022, 4, 16, 15, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('149385000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate different endDate
   * end Date is a Sunday
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMSIfEndDateIsASunday(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 4, 11, 10, 0, 15);
    DateTime endDateTime = DateTime.newInstance(2022, 4, 17, 15, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('149385000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
  /**
   * This method tests calculateDurationInfMS()
   * IMPORTANT startDate different endDate
   * startDateTime and endDateTime are not holidays and within working hours.
   * The stretch of time has got a weekend in it.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateFinalTotalOfMS(){
    List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
    BusinessHours businessHoursID = UTIL_Duration.getBusinessHourID();
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 10, 5, 10, 0, 15);
    DateTime endDateTime = DateTime.newInstance(2022, 10, 12, 15, 30, 0);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOFMS = utilDuration.calculateDurationInfMS();
    Test.stopTest();
    Long expectedNumberOfMS = long.valueOf('172785000');
    System.assertEquals(expectedNumberOfMS, realNumberOFMS);
  }
}
