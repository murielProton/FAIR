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
    Long expectedDurationInMS = 1000;
    Test.stopTest();
    System.assertEquals(expectedDurationInMS, realDurationToTest, 'It is not the right number of milliseconds.');
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
    System.assertEquals('moins de 1 secondes.', realStringToTest, 'The string is not right for an input set to less than 1 second.');
  }
  /**
  * This methode tests generateAStringFromMS.
  * If the parametters injected are inferior to a second will it return the right String ?
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
    System.assertEquals('1 seconde(s).', realStringToTest, 'The string is not right for an input set to more than 1 second.');
  }
}
