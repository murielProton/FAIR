/** *******************************************************************************
 * @Author : Muriel Proton
 * @Company : Modis
 * This class tests the folowing classes : TH_WorkTrigger, I_TriggerHandler, WorkTrigger.Trigger
 * This class is used in class : 
 * @Interface : 
 * @Setup method : getWorkReccordForDateStart(String subjectOnWork), 
 *                  getWorkReccordForDateEnd(String subjectOnWork), 
 *                  getWorkReccordForDuration(String subjectOnWork), 
 *                  setup()
 * 
 ******************************************************************************* */
@IsTest
public without sharing class TH_WorkTrigger_Test {
        
    /**
     * Before each method Test and after the setup we need to find a reccord to test in Test DataBase.
     * method to call in each test to load a reccord.
     * TO USE ONLY IN THIS CLASS!
     * This methodes gets every fields with names Date_Status_XX_Starts__c
     * Called by :  
     * @Parametters : None
     * @Returns : agf__ADM_Work__c
     */
    static agf__ADM_Work__c getWorkReccordForDateStart(String subjectOnWork){
        agf__ADM_Work__c workReccordHoney =[ SELECT Id,
                                                    agf__Status__c,
                                                    agf__Created_On_Date__c, 
                                                    Date_Status_New_Starts__c, 
                                                    Date_Status_Workload_DONE_Starts__c,
                                                    Date_Status_OK_For_DEV_Starts__c,
                                                    Date_Status_DEV_IP_Starts__c,
                                                    Date_Status_DEV_TBT_Starts__c,
                                                    Date_Status_DEV_TBD_UAT_Starts__c,
                                                    Date_Status_UAT_To_Fix_Starts__c,
                                                    Date_Status_UAT_TBD_PROD_Starts__c,
                                                    Date_Status_PROD_To_Fix_Starts__c,
                                                    Date_Status_Validated_TBD_Starts__c
                                             FROM agf__ADM_Work__c
                                             WHERE agf__Subject__c = :subjectOnWork
                                            ];
        return workReccordHoney;
    }
    /**
     * Before each method Test and after the setup we need to find a reccord to test in Test DataBase.
     * method to call in each test to load a reccord.
     * TO USE ONLY IN THIS CLASS!
     * This methodes gets every fields with names Date_Status_XX_Ends__c
     * Called by :
     * @Parametters : None
     * @Returns : agf__ADM_Work__c
     */
    static agf__ADM_Work__c getWorkReccordForDateEnd(String subjectOnWork){
        agf__ADM_Work__c workReccordHoney =[ SELECT Id,
                                                    agf__Status__c,
                                                    agf__Created_On_Date__c, 
                                                    Date_Status_New_Ends__c,
                                                    Date_Status_Workload_DONE_Ends__c,
                                                    Date_Status_OK_For_DEV_Ends__c,
                                                    Date_Status_DEV_IP_Ends__c,
                                                    Date_Status_DEV_TBT_Ends__c,
                                                    Date_Status_DEV_TBD_UAT_Ends__c,
                                                    Date_Status_UAT_To_Fix_Ends__c,
                                                    Date_Status_UAT_TBD_PROD_Ends__c,
                                                    Date_Status_PROD_To_Fix_Ends__c,
                                                    Date_Status_Validated_TBD_Ends__c
                                             FROM agf__ADM_Work__c
                                             WHERE agf__Subject__c = :subjectOnWork
                                            ];
        return workReccordHoney;
    }
    /**
     * Before each method Test and after the setup we need to find a reccord to test in Test DataBase.
     * method to call in each test to load a reccord.
     * TO USE ONLY IN THIS CLASS!
     * This methodes gets every fields with names Duration_MS_Status_XX__c and Duration_String_Status_XX__c
     * Called by :  
     * @Parametters : None
     * @Returns : agf__ADM_Work__c
     */
    static agf__ADM_Work__c getWorkReccordForDurations(String subjectOnWork){
        agf__ADM_Work__c workReccordHoney =[ SELECT Id,
                                                    agf__Status__c,
                                                    agf__Created_On_Date__c, 
                                                    Duration_MS_Status_New__c,
                                                    Duration_String_Status_New__c, 
                                                    Duration_MS_Status_Workload_DONE__c, 
                                                    Duration_MS_Status_OK_For_DEV__c,
                                                    Duration_MS_Status_DEV_IP__c,
                                                    Duration_MS_Status_DEV_TBT__c,
                                                    Duration_MS_Status_DEV_TBD_UAT__c,
                                                    Duration_MS_Status_UAT_To_Fix__c,
                                                    Duration_MS_Status_UAT_TBD_PROD__c,
                                                    Duration_MS_Status_PROD_To_Fix__c,
                                                    Duration_MS_Status_Validated_TBD__c
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
            RecordTypeId = recordTypeIdUS,
            agf__Subject__c = 'honey',
            agf__Status__c = 'New',
            agf__Product_Tag__c = productTagReccord.Id,
            agf__Found_in_Build__c = buildReccord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a reccord on sObject agf__ADM_Work__c Status Workload DONE
        agf__ADM_Work__c workReccordWorkloadMiel = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'miel',
            agf__Status__c = 'Workload DONE',
            agf__Product_Tag__c = productTagReccord.Id,
            agf__Found_in_Build__c = buildReccord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a reccord on sObject agf__ADM_Work__c Status OK For DEV
        agf__ADM_Work__c workReccordOKForDevHonig = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'honig',
            agf__Status__c = 'OK For DEV',
            agf__Product_Tag__c = productTagReccord.Id,
            agf__Found_in_Build__c = buildReccord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a reccord on sObject agf__ADM_Work__c Status OK For DEV
        agf__ADM_Work__c workReccordDevInProgressAsala = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'asala',
            agf__Status__c = 'DEV - In Progress',
            agf__Product_Tag__c = productTagReccord.Id,
            agf__Found_in_Build__c = buildReccord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a reccord on sObject agf__ADM_Work__c Status OK For DEV
        agf__ADM_Work__c workReccordDevInProgressFengMi = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'feng mi',
            agf__Status__c = 'DEV - To Be Tested',
            agf__Product_Tag__c = productTagReccord.Id,
            agf__Found_in_Build__c = buildReccord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a reccord on sObject agf__ADM_Work__c Status DEV - To Be Deployed in UAT
        agf__ADM_Work__c workReccordDevInProgressMiele = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'miele',
            agf__Status__c = 'DEV - To Be Deployed in UAT',
            agf__Product_Tag__c = productTagReccord.Id,
            agf__Found_in_Build__c = buildReccord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a reccord on sObject agf__ADM_Work__c Status UAT - To Fix
        agf__ADM_Work__c workReccordDevInProgressMel = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'mel',
            agf__Status__c = 'UAT - To Fix',
            agf__Product_Tag__c = productTagReccord.Id,
            agf__Found_in_Build__c = buildReccord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a reccord on sObject agf__ADM_Work__c Status UAT - To Be Deployed in PROD
        agf__ADM_Work__c workReccordDevInProgressMiere = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'miere',
            agf__Status__c = 'UAT - To Be Deployed in PROD',
            agf__Product_Tag__c = productTagReccord.Id,
            agf__Found_in_Build__c = buildReccord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a reccord on sObject agf__ADM_Work__c Status 'PROD - To Fix'
        agf__ADM_Work__c workReccordDevInProgressKkul = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'kkul',
            agf__Status__c = 'PROD - To Fix',
            agf__Product_Tag__c = productTagReccord.Id,
            agf__Found_in_Build__c = buildReccord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a reccord on sObject agf__ADM_Work__c Status 'Validated - To Be Deployed'
        agf__ADM_Work__c workReccordDevInProgressTsisNaBitIzh = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'tsis na bit izh',
            agf__Status__c = 'Validated - To Be Deployed',
            agf__Product_Tag__c = productTagReccord.Id,
            agf__Found_in_Build__c = buildReccord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a record on sObject agf__ADM_Work__c Status ???
        List<agf__ADM_Work__c> workRecordsList= new List<agf__ADM_Work__c>();
        workRecordsList.add(workReccordNewHoney);
        workRecordsList.add(workReccordWorkloadMiel);
        workRecordsList.add(workReccordOKForDevHonig);
        workRecordsList.add(workReccordDevInProgressAsala);
        workRecordsList.add(workReccordDevInProgressFengMi);
        workRecordsList.add(workReccordDevInProgressMiele);
        workRecordsList.add(workReccordDevInProgressMel);
        workRecordsList.add(workReccordDevInProgressMiere);
        workRecordsList.add(workReccordDevInProgressKkul);
        workRecordsList.add(workReccordDevInProgressTsisNaBitIzh);
        //Insert a list of record
        insert workRecordsList;
    }
    /**
     * Setup methode for agf__Status__c = '' When testing Starting Dates
     * Called by : checkIfWorkDateStatusStartsFilledAfterUpdate
     * @Parametters : None
     * @Returns : VOID
     */
    static void setupTestForDateStartWhenStatusIs(String statusValue, String nameOfRecording){
         // get reccord of agf__ADM_Work__c
         agf__ADM_Work__c workReccordHoney = getWorkReccordForDateStart(nameOfRecording);
         // Set new value in field agf__Status__c
         workReccordHoney.agf__Status__c = statusValue;
         // update field agf__Status__c on reccord workReccordHoney
         Test.startTest();
         update workReccordHoney;
         Test.stopTest();
    }
    /**
     * Setup methode for agf__Status__c = '' When testing Starting Dates
     * Called by : 
     * @Parametters : None
     * @Returns : VOID
     */
    static void setupTestForDateEndWhenStatusIs(String statusValue, String nameOfRecording){
        // get reccord of agf__ADM_Work__c
        agf__ADM_Work__c workReccordHoney = getWorkReccordForDateEnd(nameOfRecording);
        // Set new value in field agf__Status__c
        workReccordHoney.agf__Status__c = statusValue;
        // update field agf__Status__c on reccord workReccordHoney
        Test.startTest();
        update workReccordHoney;
        Test.stopTest();
   }
   /**
     * Setup methode for agf__Status__c = '' When testing Starting Dates
     * Called by : 
     * @Parametters : None
     * @Returns : VOID
     */
    static void setupTestForDurationWhenStatusIs(String statusValue, String nameOfRecording){
        // get reccord of agf__ADM_Work__c
        agf__ADM_Work__c workReccordHoney = getWorkReccordForDurations(nameOfRecording);
        // Set new value in field agf__Status__c
        workReccordHoney.agf__Status__c = statusValue;
        // update field agf__Status__c on reccord workReccordHoney
        Test.startTest();
        update workReccordHoney;
        Test.stopTest();
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
        agf__ADM_Work__c workReccordHoney = getWorkReccordForDateStart('honey');
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
     * Tests if Date_Status_New_Ends__c is filled with date/time now when the field agf__Status__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusNewEndsFilledAfterUpdate() {
        String nameOfRecording = 'honey';
        String statusValue = 'Workload DONE';
        setupTestForDateEndWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateEnd(nameOfRecording);
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
        String nameOfRecording = 'honey';
        String statusValue = 'Workload DONE';
        setupTestForDurationWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDurations(nameOfRecording);
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
        String nameOfRecording = 'honey';
        String statusValue = 'Workload DONE';
        setupTestForDurationWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDurations(nameOfRecording);
        // get real field Duration_String_Status_New__c
        String realStringDuration = workReccordHoneyAfterUpdate.Duration_String_Status_New__c;
        // check if Duration_String_Status_New__c is a isAlphanumericSpace()
        System.assert(realStringDuration.isAsciiPrintable(),'Duration_String_Status_New__c is not a string.');
    }
    /**
     *
     * Tests if Date_Status_Workload_Done_Starts__c is filled with date/time now when the field agf__Status__c is updated to , 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusWorkloadDoneStartsFilledAfterUpdate() {
        String nameOfRecording = 'honey';
        String statusValue = 'Workload DONE';
        setupTestForDateStartWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateStart(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_Workload_DONE_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status__Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status Workload DONE Starts has not been correctly filled by the Trigger.'
                            );

    }
       /**
     *
     * Tests if Date_Status_Workload_DONE_Ends__c is filled with date/time now when the field agf__Status__c is updated from Workload Done to any other, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusWorkloadDoneEndsFilledAfterUpdate() {
        String nameOfRecording = 'miel';
        String statusValue = 'OK For DEV';
        setupTestForDateEndWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateEnd(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_Workload_DONE_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status__Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status Workload DONE Ends has not been correctly filled by the Trigger.'
                            );

    }
    /**
     *
     * Tests if Date_Status_OK_For_DEV_Starts__c is filled with date/time now when the field agf__Status__c is updated to , 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusOkForDevStartsFilledAfterUpdate() {
        String nameOfRecording = 'miel';
        String statusValue = 'OK For DEV';
        setupTestForDateStartWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateStart(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_OK_For_DEV_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_OK_For_DEV_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status OK For DEV Starts has not been correctly filled by the Trigger.'
                            );
    }
        /**
     *
     * Tests if Date_Status_OK_For_DEV_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusOkForDevEndsFilledAfterUpdate() {
        String nameOfRecording = 'honig';
        String statusValue = 'DEV - In Progress';
        setupTestForDateEndWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateEnd(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_OK_For_DEV_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_OK_For_DEV_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status OK For DEV Ends has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_DEV_IP_Starts__c is filled with date/time now when the field agf__Status__c is updated to DEV - In Progress, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusDEVIPStartsFilledAfterUpdate() {
        String nameOfRecording = 'miel';
        String statusValue = 'DEV - In Progress';
        setupTestForDateStartWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateStart(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_DEV_IP_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_DEV_IP_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status DEV - In Progress Starts has not been correctly filled by the Trigger.'
                            );

    }
    /**
     *
     * Tests if Date_Status_DEV_IP_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusDEVIPEndsFilledAfterUpdate() {
        String nameOfRecording = 'asala';
        String statusValue = 'DEV - To Be Tested';
        setupTestForDateEndWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateEnd(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_DEV_IP_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_DEV_IP_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status DEV - In Progress Ends has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_DEV_TBT_Starts__c is filled with date/time now when the field agf__Status__c is updated to DEV - To Be Tested, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusDEVTBTStartsFilledAfterUpdate() {
        String nameOfRecording = 'asala';
        String statusValue = 'DEV - To Be Tested';
        setupTestForDateStartWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateStart(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_DEV_TBT_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals	Date_Status_DEV_TBT_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status DEV - To Be Tested Starts has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_DEV_TBT_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusDEVTBTEndsFilledAfterUpdate() {
        String nameOfRecording = 'feng mi';
        String statusValue = 'DEV - To Be Deployed in UAT';
        setupTestForDateEndWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateEnd(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_DEV_TBT_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals	Date_Status_DEV_TBT_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status DEV - In Progress Ends has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_DEV_TBD_UAT_Starts__c is filled with date/time now when the field agf__Status__c is updated to DEV - To Be Deployed in UAT, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusDEVTBDUATStartsFilledAfterUpdate() {
        String nameOfRecording = 'feng mi';
        String statusValue = 'DEV - To Be Deployed in UAT';
        setupTestForDateStartWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateStart(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_DEV_TBD_UAT_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_DEV_TBD_UAT_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date DEV - To Be Deployed in UAT Starts has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_DEV_TBD_UAT_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusDEVTBDUATEndsFilledAfterUpdate() {
        String nameOfRecording = 'miele';
        String statusValue = 'UAT - To Fix';
        setupTestForDateEndWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateEnd(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_DEV_TBD_UAT_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals	Date_Status_DEV_TBD_UAT_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status To Be Deployed in UAT Ends has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_UAT_To_Fix_Starts__c is filled with date/time now when the field agf__Status__c is updated to 'UAT - To Fix', 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusUATToFixStartsFilledAfterUpdate() {
        String nameOfRecording = 'miele';
        String statusValue = 'UAT - To Fix';
        setupTestForDateStartWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateStart(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_UAT_To_Fix_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_UAT_To_Fix_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date UAT - To Fix Starts has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_UAT_To_Fix_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusUATToFixEndsFilledAfterUpdate() {
        String nameOfRecording = 'mel';
        String statusValue = 'UAT - To Be Deployed in PROD';
        setupTestForDateEndWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateEnd(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_UAT_To_Fix_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_UAT_To_Fix_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status UAT - To Fix Ends has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_UAT_TBD_PROD_Starts__c is filled with date/time now when the field agf__Status__c is updated to 'UAT - To Be Deployed in PROD', 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusUATTBDPRODStartsFilledAfterUpdate() {
        String nameOfRecording = 'mel';
        String statusValue = 'UAT - To Be Deployed in PROD';
        setupTestForDateStartWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateStart(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_UAT_TBD_PROD_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals 
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date UAT - To Be Deployed in PROD Starts has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_UAT_TBD_PROD_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusUATTBDEndsFilledAfterUpdate() {
        String nameOfRecording = 'miere';
        String statusValue = 'PROD - To Fix';
        setupTestForDateEndWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateEnd(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_UAT_TBD_PROD_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_UAT_TBD_PROD_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status UAT - To Be Deployed in PROD Ends has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_PROD_To_Fix_Starts__c is filled with date/time now when the field agf__Status__c is updated to 'PROD - To Fix', 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusProdToFixStartsFilledAfterUpdate() {
        String nameOfRecording = 'miere';
        String statusValue = 'PROD - To Fix';
        setupTestForDateStartWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateStart(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_PROD_To_Fix_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_PROD_To_Fix_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date PROD - To Fix Starts has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_PROD_To_Fix_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusProdToFixEndsFilledAfterUpdate() {
        String nameOfRecording = 'kkul';
        String statusValue = 'Validated - To Be Deployed';
        setupTestForDateEndWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateEnd(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_PROD_To_Fix_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_PROD_To_Fix_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Status PROD - To Fix Ends has not been correctly filled by the Trigger.'
                            );

    }
    /**
     *
     * Tests if Date_Status_Validated_TBD_Starts__c is filled with date/time now when the field agf__Status__c is updated to 'Validated - To Be Deployed', 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusValidatedTBDtartsFilledAfterUpdate() {
        String nameOfRecording = 'kkul';
        String statusValue = 'Validated - To Be Deployed';
        setupTestForDateStartWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateStart(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_Validated_TBD_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_Validated_TBD_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Validated - To Be Deployed Starts has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_Validated_TBD_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c reccord.
     */
    @isTest
    static void checkIfWorkDateStatusValidatedTBDEndsFilledAfterUpdate() {
        String nameOfRecording = 'tsis na bit izh';
        String statusValue = 'Validated';
        setupTestForDateEndWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workReccordHoneyAfterUpdate = getWorkReccordForDateEnd(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkReccord = workReccordHoneyAfterUpdate.Date_Status_Validated_TBD_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_Validated_TBD_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkReccord, 
                            'On the sObject Work the field Date Validated - To Be Deployed Ends has not been correctly filled by the Trigger.'
                            );

    }
}
