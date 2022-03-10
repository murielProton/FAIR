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
  * This method cheks if calculateTimeInMS() returns the right number of Milliseconds.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  public static void testCalculateTimeInMS(){
    Test.startTest();
    DateTime dateTimeStart = Datetime.newInstance(2022, 2, 15);
    DateTime dateTimeEnd = dateTimeStart.addSeconds(1);
    UTIL_Duration utilDurationForTest = new UTIL_Duration(dateTimeStart, dateTimeEnd);
    Long realDurationToTest =  utilDurationForTest.calculateTimeInMS();
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
    System.assertEquals(1, realDurationToTest, 'It is not the right number of days.');
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
    System.assertEquals(1, realDurationToTest, 'It is not the right number of weeks.');
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
    System.assertEquals(1, realDurationToTest, 'It is not the right number of months.');
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
    System.assertEquals(1, realDurationToTest, 'It is not the right number of years.');
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
    System.assertEquals('1 day(s), 4 minute(s), 21 second(s)', realStringToTest, 'The string is not right for an input set to more than 1 day.');
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
    System.assertEquals('1 week(s), 3 hour(s), 5 minute(s), 10 second(s)', realStringToTest, 'The string is not right for an input set to more than 1 week.');
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
    System.assertEquals('1 month(s), 2 day(s), 7 hour(s), 44 minute(s), 21 second(s)', realStringToTest, 'The string is not right for an input set to more than 1 month.');
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
    System.assertEquals('1 year(s), 1 week(s), 5 day(s), 20 hour(s), 38 minute(s), 31 second(s)', realStringToTest, 'The string is not right for an input set to more than 1 year.');
  }
  /**
  * This methode tests calculateNumberOfBuisnessHoursSpentInMS.
  * If the start date and end date take in a weekend will it return 172800000 MS ?
  * As the tested method doese not exlcude holidays it will return 48h. 
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  * 
  */
  @isTest
  public static void testCalculateNumberOfBuisnessHoursSpentInMSOnAWeekend(){
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 2, 4, 18, 00, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 2, 7, 9, 00, 00);
    Long expectedDuration = 172800000;
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realDuration = utilDuration.calculateNumberOfBuisnessHoursSpentInMS();
    Test.stopTest();
    System.assertEquals(expectedDuration,realDuration,'The duration calculated by UTIL_Duration.testCalculateNumberOfBuisnessHoursSpentInMS is not right.');
  }
  /**
  * This methode tests calculateNumberOfBuisnessHoursSpentInMS.
  * If the start date and end date are within 48h range will it return 30600000 MS ?
  * As the tested method doese not exlcude holidays it will return 48h. 
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  * 
  */
  @isTest
  public static void testCalculateNumberOfBuisnessHoursSpentInMSOnWorkDay(){
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 3, 28, 09, 00, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 3, 28, 17, 30, 00);
    Long expectedDuration = 30600000;
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realDuration = utilDuration.calculateNumberOfBuisnessHoursSpentInMS();
    Test.stopTest();
    System.assertEquals(expectedDuration,realDuration,'The duration calculated by UTIL_Duration.testCalculateNumberOfBuisnessHoursSpentInMS is not right.');
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
   * This method tests calculateNumberOfDaysExcludingHolidays().
   * It requieres a CONSTRUCTOR.
   * Called by : 
   * @Parametters : 
   * @Returns : 
   */
  @isTest
  public static void testCalculateNumberOfDaysExcludingHolidays(){
    //DateTime.newInstance(year, month, day, hour, minute, second);
    DateTime startDateTime = DateTime.newInstance(2022, 7, 11, 09, 00, 00);
    DateTime endDateTime = DateTime.newInstance(2022, 7, 17, 17, 30, 00);
    Test.startTest();
    UTIL_Duration utilDuration = new UTIL_Duration(startDateTime, endDateTime);
    Long realNumberOfDays = utilDuration.calculateNumberOfDaysExcludingHolidays();
    System.debug('realNumberOfDays = ' + realNumberOfDays);
    Test.stopTest();
    System.assertEquals(4, realNumberOfDays);
  }

 
}
