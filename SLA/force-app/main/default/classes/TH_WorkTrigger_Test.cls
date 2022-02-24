/** *******************************************************************************
 * @Author : Muriel Proton
 * @Company : Modis
 * This class tests the folowing classes : TH_WorkTrigger, I_TriggerHandler, WorkTrigger.Trigger
 * This class is used in class : 
 * @Interface : 
 * @Setup method : getWorkReccord(), setup()
 * 
 ******************************************************************************* */
@IsTest
public without sharing class TH_WorkTrigger_Test {
        
    /**
     * Before each method Test and after the setup we need to find a reccord to test in Test DataBase.
     * method to call in each test to load a reccord.
     * TO USE ONLY IN THIS CLASS!
     * Called by :  checkIfWorkDateStatusNewStartFilledBeforeInsert()
     *              checkIfWorkDateStatusNewEndsFilledAfterUpdate()
     * @Parametters : None
     * @Returns : agf__ADM_Work__c
     */
    static agf__ADM_Work__c getWorkReccord(String subjectOnWork){
        agf__ADM_Work__c workReccordHoney =[ SELECT Id, 
                                                    agf__Created_On_Date__c, 
                                                    Date_Status_New_Starts__c , 
                                                    agf__Status__c, 
                                                    Date_Status_New_Ends__c,
                                                    Duration_MS_Status_New__c,
                                                    Duration_String_Status_New__c,
                                                    Date_Status_To_Fix_Starts__c,
                                                    Date_Status_To_Fix_Ends__c,
                                                    Duration_MS_Status_To_Fix__c
                                             FROM agf__ADM_Work__c
                                             WHERE agf__Subject__c = :subjectOnWork
                                            ];
        return workReccordHoney;
    }
    /**
     * Before each method Test insert a reccord in agf__ADM_Work__c.
     * setup method
     * Called before : All method of this class
     * NB : if you create a methode that doesn't need this setup, you must implement this methode in an other class.
     * @Parametters : None
     * @Returns : VOID
     */
    @testSetup
    static void setup() {
        // creating a reccord of agf__ADM_Scrum_Team__c before creating a agf__ADM_Product_Tag__c is mandatory
        agf__ADM_Scrum_Team__c teamReccord = new agf__ADM_Scrum_Team__c(
            Name = 'Hive'
        );
        insert teamReccord;
        // creating a reccord of agf__ADM_Product_Tag__c before creating a agf__ADM_Work__c is mandatory
        agf__ADM_Product_Tag__c productTagReccord = new agf__ADM_Product_Tag__c(
            Name = 'FAIR',
            agf__Team__c = teamReccord.Id
        );
        insert productTagReccord; 
        // creating a reccord of agf__ADM_Build__c before creating a agf__ADM_Work__c is mandatory
        agf__ADM_Build__c buildReccord = new agf__ADM_Build__c(
            Name = 'hexagonal'
        );
        insert buildReccord; 
        // to fill the field on agf__ADM_Work__c named RecordType you need a RecordType ID.
        Id recordTypeIdBug = Schema.SObjectType.agf__ADM_Work__c.getRecordTypeInfosByName().get('Bug').getRecordTypeId();
        Id recordTypeIdUS = Schema.SObjectType.agf__ADM_Work__c.getRecordTypeInfosByName().get('User Story').getRecordTypeId();
        // creating a reccord on sObject agf__ADM_Work__c Status New
        agf__ADM_Work__c workReccordNewHoney = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'honey',
            agf__Status__c = 'New',
            agf__Product_Tag__c = productTagReccord.Id,
            agf__Found_in_Build__c = buildReccord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a reccord on sObject agf__ADM_Work__c Status To Fix
        agf__ADM_Work__c workReccordToFixHoney = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdUS,
            agf__Subject__c = 'to fix honey',
            agf__Status__c = 'To Fix',
            agf__Product_Tag__c = productTagReccord.Id,
            agf__Found_in_Build__c = buildReccord.Id,
            agf__Priority__c = 'P0'
        );
        List<agf__ADM_Work__c> workRecordsList= new List<agf__ADM_Work__c>();
        workRecordsList.add(workReccordNewHoney);
        workRecordsList.add(workReccordToFixHoney);
        for(agf__ADM_Work__c curentRecord : workRecordsList ){
            insert curentRecord;
        }
    }
    /**
     * Tests if Date_Status_New_Starts__c is filled with date/time now when I insert a reccord in agf__ADM_Work__c.
     * Called by :
     * @Parametters : None
     * @Returns : VOID
     */
    @isTest
    static void checkIfWorkDateStatusNewStartFilledBeforeInsert() {
        //get reccord of agf__ADM_Work__c
        agf__ADM_Work__c workReccordHoney = getWorkReccord('honey');
        Test.startTest();
        // convert DateTime into Date cause agf__Created_On_Date__c is a formula and registers time 00:00:00. ( not on real time !)
        DateTime expectedDateTime = workReccordHoney.agf__Created_On_Date__c;
        DateTime dateTimeOFWorkReccord = workReccordHoney.Date_Status_New_Starts__c;
        Date expectedDate = Date.newInstance(expectedDateTime.year(), expectedDateTime.month(), expectedDateTime.day());
        Date dateTotest = Date.newInstance(dateTimeOFWorkReccord.year(), dateTimeOFWorkReccord.month(), dateTimeOFWorkReccord.day());
        Test.stopTest();
        //check if agf__Created_On_Date__c equals Date_Status_New_Starts__c
        System.assertEquals(expectedDate, 
                            dateTotest, 
                            'On the sObject Work the field Date Status New Starts has not been correctly filled by the Trigger.'
                            );
    }

     /**
     *
     * Tests if Date_Status_New_Ends__c is filled with date/time now when the field agf__Status__c is updated on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusNewEndsFilledAfterUpdate() {
        // get reccord of agf__ADM_Work__c
        agf__ADM_Work__c workReccordHoney = getWorkReccord('honey');
        // Set new value in field agf__Status__c
        workReccordHoney.agf__Status__c = 'To Fix';
        // update field agf__Status__c on reccord workReccordHoney
        Test.startTest();
		update 	workReccordHoney;
        Test.stopTest();
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccord('honey');
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_New_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_New_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status New Ends has not been correctly filled by the Trigger.'
                            );

    }

    /**
     *
     * Tests if Duration_MS_Status_New__c is filled with a Long when the Date_Status_New_Ends__c is updated on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDurationMSStatusNewIsFilledAfterUpdate() {
        // get reccord of agf__ADM_Work__c
        agf__ADM_Work__c workReccordHoney = getWorkReccord('honey');
        // Set new value in field agf__Status__c and Date_Status_New_Ends__c
        workReccordHoney.agf__Status__c = 'To Fix';
        // update field agf__Status__c on reccord workReccordHoney
        Test.startTest();
		update 	workReccordHoney;
        Test.stopTest();
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccord('honey');
        // get real field Duration_MS_Status_New__c
        Long realDuration = (Long)workReccordHoneyAfterUpdate.Duration_MS_Status_New__c;
        // convert field Duration_MS_Status_New__c so it can be tested
        String realDurationToTest = String.valueOf(realDuration);
        // check if Duration_MS_Status_New__c is a number
        System.assert(realDurationToTest.isNumeric(),'Duration_MS_Status_New__c is not a number.');
    }
        /**
     *
     * Tests if Duration_String_Status_New__c is filled with a Long when the Date_Status_New_Ends__c is updated on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDurationStringStatusNewIsFilledAfterUpdate() {
        // get reccord of agf__ADM_Work__c
        agf__ADM_Work__c workReccordHoney = getWorkReccord('honey');
        // Set new value in field agf__Status__c and Date_Status_New_Ends__c
        workReccordHoney.agf__Status__c = 'To Fix';
        // update field agf__Status__c on reccord workReccordHoney
        Test.startTest();
		update 	workReccordHoney;
        Test.stopTest();
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccord('honey');
        // get real field Duration_String_Status_New__c
        String realStringDuration = workReccordHoneyAfterUpdate.Duration_String_Status_New__c;
        // check if Duration_String_Status_New__c is a isAlphanumericSpace()
        System.assert(realStringDuration.isAsciiPrintable(),'Duration_String_Status_New__c is not a string.');
    }
/** --------------------------------------- TEST STATUS TO FIX --------------------------------------- */
    /**
     *
     * Tests if Date_Status_To_Fix_Starts__c is filled with date/time now when the field agf__Status__c is updated to To Fix, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusToFixStartsFilledAfterUpdate() {
        // get reccord of agf__ADM_Work__c
        agf__ADM_Work__c workReccordHoney = getWorkReccord('honey');
        // Set new value in field agf__Status__c
        workReccordHoney.agf__Status__c = 'To Fix';
        // update field agf__Status__c on reccord workReccordHoney
        Test.startTest();
		update 	workReccordHoney;
        Test.stopTest();
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccord('honey');
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_To_Fix_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_To_Fix_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status To Fix Starts has not been correctly filled by the Trigger.'
                            );

    }
       /**
     *
     * Tests if Date_Status_To_Fix_Ends__c is filled with date/time now when the field agf__Status__c is updated from To Fix to any other, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusToFixEndsFilledAfterUpdate() {
        // get reccord of agf__ADM_Work__c
        agf__ADM_Work__c workReccordHoneyToFix = getWorkReccord('to fix honey');
        System.debug(workReccordHoneyToFix);
        // Set new value in field agf__Status__c
        workReccordHoneyToFix.agf__Status__c = 'DEV – In Progress';
        // update field agf__Status__c on reccord workReccordHoneyToFix
        Test.startTest();
		update 	workReccordHoneyToFix;
        Test.stopTest();
        agf__ADM_Work__c workReccordHoneyToFixAfterUpdate = getWorkReccord('to fix honey');
        System.debug(workReccordHoneyToFixAfterUpdate);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyToFixAfterUpdate.Date_Status_To_Fix_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_To_Fix_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status To Fix Ends has not been correctly filled by the Trigger.'
                            );

    }
}
