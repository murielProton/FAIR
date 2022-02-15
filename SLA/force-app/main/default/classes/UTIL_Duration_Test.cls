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
    Integer realDurationToTest =  utilDurationForTest.calculateTimeInMS();
    Integer expectedDurationInMS = 1000;
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
    Integer realDurationToTest =  UTIL_Duration.calculateTimeInSeconds(1230);
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
    Integer realDurationToTest =  UTIL_Duration.calculateTimeInMinutes(61230);
    Test.stopTest();
    System.assertEquals(1, realDurationToTest, 'It is not the right number of seconds.');
  }
}