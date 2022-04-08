/** *******************************************************************************
 * @Author : Muriel Proton
 * @Company : Modis
 * This class tests the folowing classes : TH_WorkTrigger, I_TriggerHandler, WorkTrigger.Trigger
 * This class is used in class : 
 * @Interface : 
 * @Setup method : getWorkRecordWithSubjectName(String subjectOnWork),
 *                  setup()
 * 
 ******************************************************************************* */
@IsTest
public without sharing class TH_WorkTrigger_Test {
    //Variables needed in more than one test
    //DateTime.newInstance(YEAR, Mo, Da, HH, mi, se);
    public final static DateTime dateTimeRandom = DateTime.newInstance(2022, 4, 6, 9, 39, 3);
    /**
     * Before each method Test and after the setup we need to find a record to test in Test DataBase.
     * method to call in each test to load a record.
     * TO USE ONLY IN THIS CLASS!
     * This methodes gets every fields with names Date_Status_XX_Starts__c
     * It is not the same as the one on UTIL_ServiceLevelAgreement_Test as this class tests for other things.
     * Called by :  
     * @Parametters : None
     * @Returns : agf__ADM_Work__c
     */
    static agf__ADM_Work__c getWorkRecordWithSubjectName(String subjectOnWork){
        agf__ADM_Work__c workRecordHoney =null;
        try{
            workRecordHoney =[ SELECT Id,
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
                                        Date_Status_Validated_TBD_Starts__c,
                                        Date_Status_New_Ends__c,
                                        Date_Status_Workload_DONE_Ends__c,
                                        Date_Status_OK_For_DEV_Ends__c,
                                        Date_Status_DEV_IP_Ends__c,
                                        Date_Status_DEV_TBT_Ends__c,
                                        Date_Status_DEV_TBD_UAT_Ends__c,
                                        Date_Status_UAT_To_Fix_Ends__c,
                                        Date_Status_UAT_TBD_PROD_Ends__c,
                                        Date_Status_PROD_To_Fix_Ends__c,
                                        Date_Status_Validated_TBD_Ends__c,
                                        Duration_MS_Status_New__c,
                                        Duration_MS_Status_Workload_DONE__c, 
                                        Duration_MS_Status_OK_For_DEV__c,
                                        Duration_MS_Status_DEV_IP__c,
                                        Duration_MS_Status_DEV_TBT__c,
                                        Duration_MS_Status_DEV_TBD_UAT__c,
                                        Duration_MS_Status_UAT_To_Fix__c,
                                        Duration_MS_Status_UAT_TBD_PROD__c,
                                        Duration_MS_Status_PROD_To_Fix__c,
                                        Duration_MS_Status_Validated_TBD__c,
                                        Duration_String_Status_New__c,
                                        Duration_String_Status_Workload_DONE__c,
                                        Duration_String_Status_OK_For_DEV__c,
                                        Duration_String_Status_DEV_IP__c,
                                        Duration_String_Status_DEV_TBT__c,
                                        Duration_String_Status_DEV_TBD_UAT__c,
                                        Duration_String_Status_UAT_To_Fix__c,
                                        Duration_String_Status_UAT_TBD_PROD__c,
                                        Duration_String_Status_PROD_To_Fix__c,
                                        Duration_String_Status_Validated_TBD__c,
                                        Duration_In_MS_To_Respond_To_A_US__c,
                                        Duration_In_MS_To_Respond_To_A_Bug__c,
                                        Duration_In_MS_To_Correct_A_Bug__c,
                                        Duration_In_String_To_Respond_To_A_US__c,
                                        Duration_In_String_To_Respond_To_A_Bug__c,
                                        Duration_In_String_To_Correct_A_Bug__c
                                FROM agf__ADM_Work__c
                                WHERE agf__Subject__c = :subjectOnWork
                                ];
        
        } catch(DMLException e){
            System.debug('You could not get the record named : '+subjectOnWork+'.');
        }
        return workRecordHoney;
    }
    /**
     * Before each method Test insert a record in agf__ADM_Work__c.
     * setup method
     * Called before : All method of this class
     * NB : if you create a methode that doesn't need this setup, you must implement this methode in an other class.
     * @Parametters : None
     * @Returns : VOID
     */
    @testSetup
    static void setup() {
        // creating a record of agf__ADM_Scrum_Team__c before creating a agf__ADM_Product_Tag__c is mandatory
        agf__ADM_Scrum_Team__c teamRecord = new agf__ADM_Scrum_Team__c(
            Name = 'Hive'
        );
        insert teamRecord;
        // creating a record of agf__ADM_Product_Tag__c before creating a agf__ADM_Work__c is mandatory
        agf__ADM_Product_Tag__c productTagRecord = new agf__ADM_Product_Tag__c(
            Name = 'FAIR',
            agf__Team__c = teamRecord.Id
        );
        insert productTagRecord; 
        // creating a record of agf__ADM_Build__c before creating a agf__ADM_Work__c is mandatory
        agf__ADM_Build__c buildRecord = new agf__ADM_Build__c(
            Name = 'hexagonal'
        );
        insert buildRecord; 
        // to fill the field on agf__ADM_Work__c named RecordType you need a RecordType ID.
        Id recordTypeIdBug = Schema.SObjectType.agf__ADM_Work__c.getRecordTypeInfosByName().get('Bug').getRecordTypeId();
        Id recordTypeIdUS = Schema.SObjectType.agf__ADM_Work__c.getRecordTypeInfosByName().get('User Story').getRecordTypeId();
        // Creating a Date to set starting date of a status on futur records
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String dateToSet = dateTimeNow.format('yyyy/MM/dd hh:mm');
        // creating a record on sObject agf__ADM_Work__c Status New
        agf__ADM_Work__c workRecordNewHoney = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'honey',
            agf__Status__c = 'New',
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a record on sObject agf__ADM_Work__c Status New and the record type User Story
        agf__ADM_Work__c workRecordNewMilain = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdUS,
            agf__Subject__c = 'milain',
            agf__Status__c = 'New',
            Date_Status_New_Starts__c = dateTimeRandom,
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a record on sObject agf__ADM_Work__c Status Workload DONE
        agf__ADM_Work__c workRecordWorkloadMiel = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdUS,
            agf__Subject__c = 'miel',
            agf__Status__c = 'Workload DONE',
            Date_Status_New_Starts__c = dateTimeRandom,
            Date_Status_New_Ends__c = dateTimeRandom.addHours(1),
            Duration_MS_Status_New__c = 3600000,
            Date_Status_Workload_DONE_Starts__c = dateTimeRandom.addHours(1),
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a record on sObject agf__ADM_Work__c Status OK For DEV
        agf__ADM_Work__c workRecordOKForDevHonig = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdUS,
            agf__Subject__c = 'honig',
            agf__Status__c = 'OK For DEV',
            Date_Status_New_Starts__c = dateTimeRandom,
            Date_Status_New_Ends__c = dateTimeRandom.addHours(1),
            Duration_MS_Status_New__c = 3600000,
            Date_Status_Workload_DONE_Starts__c = dateTimeRandom.addHours(1),
            Date_Status_Workload_DONE_Ends__c = dateTimeRandom.addHours(2),
            Duration_MS_Status_Workload_DONE__c = 3600000,
            Date_Status_OK_For_DEV_Starts__c = dateTimeRandom.addHours(2),
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a record on sObject agf__ADM_Work__c Status 'DEV - In Progress'
        agf__ADM_Work__c workRecordDevInProgressAsala = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'asala',
            agf__Status__c = 'DEV - In Progress',
            Date_Status_DEV_IP_Starts__c = dateTimeNow,
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a record on sObject agf__ADM_Work__c Status OK For DEV
        agf__ADM_Work__c workRecordDevInProgressFengMi = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'feng mi',
            agf__Status__c = 'DEV - To Be Tested',
            Date_Status_DEV_TBT_Starts__c = dateTimeNow,
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a record on sObject agf__ADM_Work__c Status DEV - To Be Deployed in UAT
        agf__ADM_Work__c workRecordDevInProgressMiele = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'miele',
            agf__Status__c = 'DEV - To Be Deployed in UAT',
            Date_Status_DEV_TBD_UAT_Starts__c = dateTimeNow,
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a record on sObject agf__ADM_Work__c Status UAT - To Fix
        agf__ADM_Work__c workRecordDevInProgressMel = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'mel',
            agf__Status__c = 'UAT - To Fix',
            Date_Status_UAT_To_Fix_Starts__c = dateTimeNow,
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a record on sObject agf__ADM_Work__c Status UAT - To Be Deployed in PROD
        agf__ADM_Work__c workRecordDevInProgressMiere = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'miere',
            agf__Status__c = 'UAT - To Be Deployed in PROD',
            Date_Status_UAT_TBD_PROD_Starts__c = dateTimeNow,
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a record on sObject agf__ADM_Work__c Status 'PROD - To Fix'
        agf__ADM_Work__c workRecordDevInProgressKkul = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'kkul',
            agf__Status__c = 'PROD - To Fix',
            Date_Status_PROD_To_Fix_Starts__c = dateTimeNow,
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a record on sObject agf__ADM_Work__c Status 'Validated - To Be Deployed'
        agf__ADM_Work__c workRecordDevInProgressTsisNaBitIzh = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'tsis na bit izh',
            agf__Status__c = 'Validated - To Be Deployed',
            Date_Status_Validated_TBD_Starts__c = dateTimeNow,
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a record on sObject agf__ADM_Work__c Status 'Validated - To Be Deployed'
        agf__ADM_Work__c workRecordDevTBTHachimitsu = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'hachimitsu',
            agf__Status__c = 'DEV - To Be Tested',
            Date_Status_New_Starts__c = dateTimeRandom, 
            Date_Status_New_Ends__c = dateTimeRandom.addHours(1),
            Duration_MS_Status_New__c = 3600000,  
            Duration_String_Status_New__c = Util_Duration.generateAStringFromMS(3600000),            
            Date_Status_DEV_IP_Starts__c = dateTimeRandom.addHours(1),
            Date_Status_DEV_IP_Ends__c = dateTimeRandom.addHours(2),
            Duration_MS_Status_DEV_IP__c = 3600000,
            Duration_String_Status_DEV_IP__c = Util_Duration.generateAStringFromMS(3600000),  
            Date_Status_DEV_TBT_Starts__c = dateTimeRandom.addHours(3),                         
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a record on sObject agf__ADM_Work__c Status Validated - To Be Deployed
        agf__ADM_Work__c workRecordDEVTBDUATDevach = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'devach',
            agf__Status__c = 'DEV - To Be Deployed in UAT',
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            Date_Status_New_Starts__c = dateTimeRandom, 
            Date_Status_New_Ends__c = dateTimeRandom.addHours(1),
            Duration_MS_Status_New__c = 3600000,
            Duration_String_Status_New__c = Util_Duration.generateAStringFromMS(3600000),            
            Date_Status_DEV_IP_Starts__c = dateTimeRandom.addHours(1),
            Date_Status_DEV_IP_Ends__c = dateTimeRandom.addHours(2),
            Duration_MS_Status_DEV_IP__c = 3600000,
            Duration_String_Status_DEV_IP__c = Util_Duration.generateAStringFromMS(3600000),  
            Date_Status_DEV_TBT_Starts__c = dateTimeRandom.addHours(2),
            Date_Status_DEV_TBT_Ends__c = dateTimeRandom.addHours(3),
            Duration_MS_Status_DEV_TBT__c = 3600000,
            Date_Status_DEV_TBD_UAT_Starts__c = dateTimeRandom.addHours(3), 
            agf__Priority__c = 'P0'
        );
        // creating a list of records on sObject agf__ADM_Work__c
        List<agf__ADM_Work__c> workRecordsList= new List<agf__ADM_Work__c>();
        workRecordsList.add(workRecordNewHoney);
        workRecordsList.add(workRecordWorkloadMiel);
        workRecordsList.add(workRecordOKForDevHonig);
        workRecordsList.add(workRecordDevInProgressAsala);
        workRecordsList.add(workRecordDevInProgressFengMi);
        workRecordsList.add(workRecordDevInProgressMiele);
        workRecordsList.add(workRecordDevInProgressMel);
        workRecordsList.add(workRecordDevInProgressMiere);
        workRecordsList.add(workRecordDevInProgressKkul);
        workRecordsList.add(workRecordDevInProgressTsisNaBitIzh);
        workRecordsList.add(workRecordNewMilain);
        workRecordsList.add(workRecordDevTBTHachimitsu);
        workRecordsList.add(workRecordDEVTBDUATDevach);
        try{
            //Insert a list of record
            insert workRecordsList;
        }catch (ListException e){
            System.debug('In tests run on TH_WorkTrigger, the list of records on the sObject Work was not inserted. ref : workRecordsList');
        }
    }
    /**
     * Setup methode for agf__Status__c = '' When testing Starting Dates
     * Called by : checkIfWorkDateStatusStartsFilledAfterUpdate
     * @Parametters : None
     * @Returns : VOID
     */
    static void setupTestWhenStatusIs(String statusValue, String nameOfRecording){
         // get record of agf__ADM_Work__c
         agf__ADM_Work__c workRecordHoney = getWorkRecordWithSubjectName(nameOfRecording);
         // Set new value in field agf__Status__c
         workRecordHoney.agf__Status__c = statusValue;
         // update field agf__Status__c on record workRecordHoney
        //  Test.startTest();
         update workRecordHoney;
        //  Test.stopTest();
    }
    //----------------------------------------------------- CHECK Date_Status_***_Starts__c-------------------------------------------------
    /**
     * Tests if Date_Status_New_Starts__c is filled with date/time now when I insert a record in agf__ADM_Work__c.
     * Called by :
     * @Parametters : None
     * @Returns : VOID
     */
    @isTest
    static void checkIfWorkDateStatusNewStartFilledBeforeInsert() {
        //get record of agf__ADM_Work__c
        agf__ADM_Work__c workRecordHoney = getWorkRecordWithSubjectName('honey');
        Test.startTest();
        // convert DateTime into Date cause agf__Created_On_Date__c is a formula and registers time 00:00:00. ( not on real time !)
        DateTime expectedDateTime = workRecordHoney.agf__Created_On_Date__c;
        DateTime dateTimeOFWorkRecord = workRecordHoney.Date_Status_New_Starts__c;
        Date expectedDate = Date.newInstance(expectedDateTime.year(), expectedDateTime.month(), expectedDateTime.day());
        Date dateTotest = Date.newInstance(dateTimeOFWorkRecord.year(), dateTimeOFWorkRecord.month(), dateTimeOFWorkRecord.day());
        Test.stopTest();
        //check if agf__Created_On_Date__c equals Date_Status_New_Starts__c
        System.assertEquals(expectedDate, 
                            dateTotest, 
                            'On the sObject Work the field Date Status New Starts has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_Workload_Done_Starts__c is filled with date/time now when the field agf__Status__c is updated to , 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusWorkloadDoneStartsFilledAfterUpdate() {
        String nameOfRecording = 'milain';
        String statusValue = 'Workload DONE';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_Workload_DONE_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status__Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Status Workload DONE Starts has not been correctly filled by the Trigger.'
                            );

    }
    /**
     *
     * Tests if Date_Status_OK_For_DEV_Starts__c is filled with date/time now when the field agf__Status__c is updated to , 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusOkForDevStartsFilledAfterUpdate() {
        String nameOfRecording = 'miel';
        String statusValue = 'OK For DEV';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_OK_For_DEV_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_OK_For_DEV_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Status OK For DEV Starts has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_DEV_IP_Starts__c is filled with date/time now when the field agf__Status__c is updated to DEV - In Progress, 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusDEVIPStartsFilledAfterUpdate() {
        String nameOfRecording = 'honey';
        String statusValue = 'DEV - In Progress';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_DEV_IP_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_DEV_IP_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Status DEV - In Progress Starts has not been correctly filled by the Trigger.'
                            );

    }
    /**
     *
     * Tests if Date_Status_DEV_TBT_Starts__c is filled with date/time now when the field agf__Status__c is updated to DEV - To Be Tested, 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusDEVTBTStartsFilledAfterUpdate() {
        String nameOfRecording = 'asala';
        String statusValue = 'DEV - To Be Tested';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_DEV_TBT_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals	Date_Status_DEV_TBT_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Status DEV - To Be Tested Starts has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_DEV_TBD_UAT_Starts__c is filled with date/time now when the field agf__Status__c is updated to DEV - To Be Deployed in UAT, 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusDEVTBDUATStartsFilledAfterUpdate() {
        String nameOfRecording = 'feng mi';
        String statusValue = 'DEV - To Be Deployed in UAT';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_DEV_TBD_UAT_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_DEV_TBD_UAT_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date DEV - To Be Deployed in UAT Starts has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_UAT_To_Fix_Starts__c is filled with date/time now when the field agf__Status__c is updated to 'UAT - To Fix', 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusUATToFixStartsFilledAfterUpdate() {
        String nameOfRecording = 'miele';
        String statusValue = 'UAT - To Fix';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_UAT_To_Fix_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_UAT_To_Fix_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date UAT - To Fix Starts has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_UAT_TBD_PROD_Starts__c is filled with date/time now when the field agf__Status__c is updated to 'UAT - To Be Deployed in PROD', 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusUATTBDPRODStartsFilledAfterUpdate() {
        String nameOfRecording = 'mel';
        String statusValue = 'UAT - To Be Deployed in PROD';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_UAT_TBD_PROD_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals 
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date UAT - To Be Deployed in PROD Starts has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_PROD_To_Fix_Starts__c is filled with date/time now when the field agf__Status__c is updated to 'PROD - To Fix', 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusProdToFixStartsFilledAfterUpdate() {
        String nameOfRecording = 'miere';
        String statusValue = 'PROD - To Fix';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_PROD_To_Fix_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_PROD_To_Fix_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date PROD - To Fix Starts has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_Validated_TBD_Starts__c is filled with date/time now when the field agf__Status__c is updated to 'Validated - To Be Deployed', 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusValidatedTBDtartsFilledAfterUpdate() {
        String nameOfRecording = 'kkul';
        String statusValue = 'Validated - To Be Deployed';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_Validated_TBD_Starts__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_Validated_TBD_Starts__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Validated - To Be Deployed Starts has not been correctly filled by the Trigger.'
                            );
    }
//----------------------------------------------------- CHECK Date_Status_***_Ends__c-------------------------------------------------
     /**
     *
     * Tests if Date_Status_New_Ends__c is filled with date/time now when the field agf__Status__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusNewEndsFilledAfterUpdate() {
        String nameOfRecording = 'honey';
        String statusValue = 'Workload DONE';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_New_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_New_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Status New Ends has not been correctly filled by the Trigger.'
                            );

    }
    /**
     *
     * Tests if Date_Status_Workload_DONE_Ends__c is filled with date/time now when the field agf__Status__c is updated from Workload Done to any other, 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusWorkloadDoneEndsFilledAfterUpdate() {
        String nameOfRecording = 'miel';
        String statusValue = 'OK For DEV';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_Workload_DONE_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status__Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Status Workload DONE Ends has not been correctly filled by the Trigger.'
                            );

    }
    
        /**
     *
     * Tests if Date_Status_OK_For_DEV_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusOkForDevEndsFilledAfterUpdate() {
        String nameOfRecording = 'honig';
        String statusValue = 'DEV - In Progress';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_OK_For_DEV_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_OK_For_DEV_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Status OK For DEV Ends has not been correctly filled by the Trigger.'
                            );
    }
    
    /**
     *
     * Tests if Date_Status_DEV_IP_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusDEVIPEndsFilledAfterUpdate() {
        String nameOfRecording = 'asala';
        String statusValue = 'DEV - To Be Tested';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_DEV_IP_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_DEV_IP_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Status DEV - In Progress Ends has not been correctly filled by the Trigger.'
                            );
    }
    
    /**
     *
     * Tests if Date_Status_DEV_TBT_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusDEVTBTEndsFilledAfterUpdate() {
        String nameOfRecording = 'feng mi';
        String statusValue = 'DEV - To Be Deployed in UAT';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_DEV_TBT_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals	Date_Status_DEV_TBT_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Status DEV - In Progress Ends has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_DEV_TBD_UAT_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusDEVTBDUATEndsFilledAfterUpdate() {
        String nameOfRecording = 'miele';
        String statusValue = 'UAT - To Fix';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_DEV_TBD_UAT_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals	Date_Status_DEV_TBD_UAT_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Status To Be Deployed in UAT Ends has not been correctly filled by the Trigger.'
                            );
    }

    /**
     *
     * Tests if Date_Status_UAT_To_Fix_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusUATToFixEndsFilledAfterUpdate() {
        String nameOfRecording = 'mel';
        String statusValue = 'UAT - To Be Deployed in PROD';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_UAT_To_Fix_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_UAT_To_Fix_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Status UAT - To Fix Ends has not been correctly filled by the Trigger.'
                            );
    }
    
    /**
     *
     * Tests if Date_Status_UAT_TBD_PROD_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusUATTBDEndsFilledAfterUpdate() {
        String nameOfRecording = 'miere';
        String statusValue = 'PROD - To Fix';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_UAT_TBD_PROD_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_UAT_TBD_PROD_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Status UAT - To Be Deployed in PROD Ends has not been correctly filled by the Trigger.'
                            );
    }
    /**
     *
     * Tests if Date_Status_PROD_To_Fix_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusProdToFixEndsFilledAfterUpdate() {
        String nameOfRecording = 'kkul';
        String statusValue = 'Validated - To Be Deployed';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_PROD_To_Fix_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_PROD_To_Fix_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Status PROD - To Fix Ends has not been correctly filled by the Trigger.'
                            );

    }
    /**
     *
     * Tests if Date_Status_Validated_TBD_Ends__c is filled with date/time now when the field agf__Status__c is updated to any other, 
     * on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDateStatusValidatedTBDEndsFilledAfterUpdate() {
        String nameOfRecording = 'tsis na bit izh';
        String statusValue = 'Validated';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // set a DateTime to now.
        DateTime dateTimeNow = DateTime.now();
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDate = dateTimeNow.format('yyyy/MM/dd hh:mm');
        String dateTimeOFWorkRecord = workRecordHoneyAfterUpdate.Date_Status_Validated_TBD_Ends__c.format('yyyy/MM/dd hh:mm');
        // check if dateTimeNow equals Date_Status_Validated_TBD_Ends__c
        System.assertEquals(expectedDate, 
                            dateTimeOFWorkRecord, 
                            'On the sObject Work the field Date Validated - To Be Deployed Ends has not been correctly filled by the Trigger.'
                            );

    }
    //----------------------------------------------------- CHECK Duration_MS_Status_***-------------------------------------------------
    /**
     *
     * Tests if Duration_MS_Status_New__c is filled with a Long when the Date_Status_New_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationMSStatusNewIsFilledAfterUpdate() {
        String nameOfRecording = 'honey';
        String statusValue = 'Workload DONE';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_MS_Status_New__c
        Long realDuration = (Long)workRecordHoneyAfterUpdate.Duration_MS_Status_New__c;
        // convert field Duration_MS_Status_New__c so it can be tested
        String realDurationToTest = String.valueOf(realDuration);
        // check if Duration_MS_Status_New__c is a number
        System.assert(realDurationToTest.isNumeric(),'Duration_MS_Status_New__c is not a number.');
    }
    /**
     *
     * Tests if Duration_MS_Status_Workload_DONE__c is filled with a Long when the Date_Status_New_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationMSStatusWorkLoadDoneIsFilledAfterUpdate() {
        String nameOfRecording = 'miel';
        String statusValue = 'OK For DEV';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_MS_Status_Workload_DONE__c
        Long realDuration = (Long)workRecordHoneyAfterUpdate.Duration_MS_Status_Workload_DONE__c;
        // convert field Duration_MS_Status_Workload_DONE__c so it can be tested
        String realDurationToTest = String.valueOf(realDuration);
        // check if Duration_MS_Status_Workload_DONE__c is a number
        System.assert(realDurationToTest.isNumeric(),'Duration_MS_Status_Workload_DONE__c is not a number.');
    }
    /**
     *
     * Tests if Duration_MS_Status_OK_For_DEV__c is filled with a Long when the Date_Status_OK_For_DEV_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationMSStatusOKForDEVIsFilledAfterUpdate() {
        String nameOfRecording = 'honig';
        String statusValue = 'DEV - In Progress';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_MS_Status_OK_For_DEV__c
        Long realDuration = (Long)workRecordHoneyAfterUpdate.Duration_MS_Status_OK_For_DEV__c;
        // convert field Duration_MS_Status_OK_For_DEV__c so it can be tested
        String realDurationToTest = String.valueOf(realDuration);
        // check if Duration_MS_Status_OK_For_DEV__c is a number
        System.assert(realDurationToTest.isNumeric(),'Duration_MS_Status_OK_For_DEV__c is not a number.');
    }
    /**
     *
     * Tests if Duration_MS_Status_DEV_IP__c is filled with a Long when the Date_Status_DEV_IP_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationMSStatusDEVInProgressIsFilledAfterUpdate() {
        String nameOfRecording = 'asala';
        String statusValue = 'DEV - To Be Tested';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_MS_Status_DEV_IP__c
        Long realDuration = (Long)workRecordHoneyAfterUpdate.Duration_MS_Status_DEV_IP__c;
        // convert field Duration_MS_Status_DEV_IP__c so it can be tested
        String realDurationToTest = String.valueOf(realDuration);
        // check if Duration_MS_Status_DEV_IP__c is a number
        System.assert(realDurationToTest.isNumeric(),'Duration_MS_Status_DEV_IP__c is not a number.');
    }
    /**
     *
     * Tests if Duration_MS_Status_DEV_TBT__c is filled with a Long when the Date_Status_DEV_TBT_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationMSStatusDEVToBeTestedIsFilledAfterUpdate() {
        String nameOfRecording = 'feng mi';
        String statusValue = 'DEV - To Be Deployed in UAT';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_MS_Status_DEV_TBT__c
        Long realDuration = (Long)workRecordHoneyAfterUpdate.Duration_MS_Status_DEV_TBT__c;
        // convert field Duration_MS_Status_DEV_TBT__c so it can be tested
        String realDurationToTest = String.valueOf(realDuration);
        // check if Duration_MS_Status_DEV_TBT__c is a number
        System.assert(realDurationToTest.isNumeric(),'Duration_MS_Status_DEV_TBT__c is not a number.');
    }
    /**
     *
     * Tests if Duration_MS_Status_DEV_TBD_UAT__c is filled with a Long when the Date_Status_***_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationMSStatusDEVToBeDeployedUATIsFilledAfterUpdate() {
        String nameOfRecording = 'miele';
        String statusValue = 'UAT - To Fix';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_MS_Status_DEV_TBD_UAT__c
        Long realDuration = (Long)workRecordHoneyAfterUpdate.Duration_MS_Status_DEV_TBD_UAT__c;
        // convert field Duration_MS_Status_DEV_TBD_UAT__c so it can be tested
        String realDurationToTest = String.valueOf(realDuration);
        // check if Duration_MS_Status_DEV_TBD_UAT__c is a number
        System.assert(realDurationToTest.isNumeric(),'Duration_MS_Status_DEV_TBD_UAT__c is not a number.');
    }
    /**
     *
     * Tests if Duration_MS_Status_UAT_To_Fix__c is filled with a Long when the Date_Status_***_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationMSStatusUATToFixIsFilledAfterUpdate() {
        String nameOfRecording = 'mel';
        String statusValue = 'UAT - To Be Deployed in PROD';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_MS_Status_UAT_To_Fix__c
        Long realDuration = (Long)workRecordHoneyAfterUpdate.Duration_MS_Status_UAT_To_Fix__c;
        // convert field Duration_MS_Status_UAT_To_Fix__c so it can be tested
        String realDurationToTest = String.valueOf(realDuration);
        // check if Duration_MS_Status_UAT_To_Fix__c is a number
        System.assert(realDurationToTest.isNumeric(),'Duration_MS_Status_UAT_To_Fix__c is not a number.');
    }
    /**
     *
     * Tests if Duration_MS_Status_UAT_TBD_PROD__c is filled with a Long when the Date_Status_***_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationMSStatusUATTBDPRODIsFilledAfterUpdate() {
        String nameOfRecording = 'miere';
        String statusValue = 'PROD - To Fix';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_MS_Status_UAT_TBD_PROD__c
        Long realDuration = (Long)workRecordHoneyAfterUpdate.Duration_MS_Status_UAT_TBD_PROD__c;
        // convert field Duration_MS_Status_UAT_TBD_PROD__c so it can be tested
        String realDurationToTest = String.valueOf(realDuration);
        // check if Duration_MS_Status_UAT_TBD_PROD__c is a number
        System.assert(realDurationToTest.isNumeric(),'Duration_MS_Status_UAT_TBD_PROD__c is not a number.');
    }
    /**
     *
     * Tests if Duration_MS_Status_PROD_To_Fix__c is filled with a Long when the Date_Status_***_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationMSStatusPRODToFixIsFilledAfterUpdate() {
        String nameOfRecording = 'kkul';
        String statusValue = 'Validated - To Be Deployed';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_MS_Status_PROD_To_Fix__c
        Long realDuration = (Long)workRecordHoneyAfterUpdate.Duration_MS_Status_PROD_To_Fix__c;
        // convert field Duration_MS_Status_PROD_To_Fix__c so it can be tested
        String realDurationToTest = String.valueOf(realDuration);
        // check if Duration_MS_Status_PROD_To_Fix__c is a number
        System.assert(realDurationToTest.isNumeric(),'Duration_MS_Status_PROD_To_Fix__c is not a number.');
    }
    /**
     *
     * Tests if Duration_MS_Status_Validated_TBD__c is filled with a Long when the Date_Status_***_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationMSStatusValidatedTBDIsFilledAfterUpdate() {
        String nameOfRecording = 'tsis na bit izh';
        String statusValue = 'Validated';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_MS_Status_Validated_TBD__c
        Long realDuration = (Long)workRecordHoneyAfterUpdate.Duration_MS_Status_Validated_TBD__c;
        // convert field Duration_MS_Status_Validated_TBD__c so it can be tested
        String realDurationToTest = String.valueOf(realDuration);
        // check if Duration_MS_Status_Validated_TBD__c is a number
        System.assert(realDurationToTest.isNumeric(),'Duration_MS_Status_Validated_TBD__c is not a number.');
    }
//----------------------------------------------------- CHECK Duration_String_Status_***-------------------------------------------------
    /**
     *
     * Tests if Duration_String_Status_New__c is filled with a Long when the Date_Status_New_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationStringStatusNewIsFilledAfterUpdate() {
        String nameOfRecording = 'honey';
        String statusValue = 'Workload DONE';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_String_Status_New__c
        String realStringDuration = workRecordHoneyAfterUpdate.Duration_String_Status_New__c;
        // check if Duration_String_Status_New__c is a isAlphanumericSpace()
        System.assert(realStringDuration.isAsciiPrintable(),'Duration_String_Status_New__c is not a string.');
    }
    /**
     *
     * Tests if Duration_String_Status_Workload_DONE__c is filled with a Long when the Date_Status_Workload_DONE_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationStringStatusWorkloadDoneIsFilledAfterUpdate() {
        String nameOfRecording = 'miel';
        String statusValue = 'OK For DEV';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_String_Status_Workload_DONE__c
        String realStringDuration = workRecordHoneyAfterUpdate.Duration_String_Status_Workload_DONE__c;
        // check if Duration_String_Status_Workload_DONE__c is a isAlphanumericSpace()
        System.assert(realStringDuration.isAsciiPrintable(),'Duration_String_Status_Workload_DONE__c is not a string.');
    }
    /**
     *
     * Tests if Duration_String_Status_OK_For_DEV__c is filled with a Long when the Date_Status_OK_For_DEV_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationStringStatusOKForDevIsFilledAfterUpdate() {
        String nameOfRecording = 'honig';
        String statusValue = 'DEV - In Progress';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_String_Status_OK_For_DEV__c
        String realStringDuration = workRecordHoneyAfterUpdate.Duration_String_Status_OK_For_DEV__c;
        // check if Duration_String_Status_OK_For_DEV__c is a isAlphanumericSpace()
        System.assert(realStringDuration.isAsciiPrintable(),'Duration_String_Status_OK_For_DEV__c is not a string.');
    }
    /**
     *
     * Tests if Duration_String_Status_DEV_IP__c is filled with a Long when the Date_Status_DEV_IP_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationStringStatusDEVInProgressIsFilledAfterUpdate() {
        String nameOfRecording = 'asala';
        String statusValue = 'DEV - To Be Tested';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_String_Status_DEV_IP__c
        String realStringDuration = workRecordHoneyAfterUpdate.Duration_String_Status_DEV_IP__c;
        // check if Duration_String_Status_DEV_IP__c is a isAlphanumericSpace()
        System.assert(realStringDuration.isAsciiPrintable(),'Duration_String_Status_DEV_IP__c is not a string.');
    }
    /**
     *
     * Tests if Duration_String_Status_DEV_TBT__c is filled with a Long when the Date_Status_DEV_TBT_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationStringStatusDEVToBeTestedIsFilledAfterUpdate() {
        String nameOfRecording = 'feng mi';
        String statusValue = 'DEV - To Be Deployed in UAT';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_String_Status_DEV_TBT__c
        String realStringDuration = workRecordHoneyAfterUpdate.Duration_String_Status_DEV_TBT__c;
        // check if Duration_String_Status_DEV_TBT__c is a isAlphanumericSpace()
        System.assert(realStringDuration.isAsciiPrintable(),'Duration_String_Status_DEV_TBT__c is not a string.');
    }
    /**
     *
     * Tests if Duration_String_Status_DEV_TBD_UAT__c is filled with a Long when the Date_Status_DEV_TBD_UAT_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationStringStatusDEVToBeDeployedInUATIsFilledAfterUpdate() {
        String nameOfRecording = 'miele';
        String statusValue = 'UAT - To Fix';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_String_Status_DEV_TBD_UAT__c
        String realStringDuration = workRecordHoneyAfterUpdate.Duration_String_Status_DEV_TBD_UAT__c;
        // check if Duration_String_Status_DEV_TBD_UAT__c is a isAlphanumericSpace()
        System.assert(realStringDuration.isAsciiPrintable(),'Duration_String_Status_DEV_TBD_UAT__c is not a string.');
    }
    /**
     *
     * Tests if Duration_String_Status_UAT_To_Fix__c is filled with a Long when the Date_Status_UAT_To_Fix_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationStringStatusUATToFixIsFilledAfterUpdate() {
        String nameOfRecording = 'mel';
        String statusValue = 'UAT - To Be Deployed in PROD';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_String_Status_UAT_To_Fix__c
        String realStringDuration = workRecordHoneyAfterUpdate.Duration_String_Status_UAT_To_Fix__c;
        // check if Duration_String_Status_UAT_To_Fix__c is a isAlphanumericSpace()
        System.assert(realStringDuration.isAsciiPrintable(),'Duration_String_Status_UAT_To_Fix__c is not a string.');
    }
    /**
     *
     * Tests if Duration_String_Status_UAT_TBD_PROD__c is filled with a Long when the Date_Status_UAT_TBD_PROD_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationStringStatusUATTBeDeployedInPRODIsFilledAfterUpdate() {
        String nameOfRecording = 'miere';
        String statusValue = 'PROD - To Fix';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_String_Status_UAT_TBD_PROD__c
        String realStringDuration = workRecordHoneyAfterUpdate.Duration_String_Status_UAT_TBD_PROD__c;
        // check if Duration_String_Status_UAT_TBD_PROD__c is a isAlphanumericSpace()
        System.assert(realStringDuration.isAsciiPrintable(),'Duration_String_Status_UAT_TBD_PROD__c is not a string.');
    }
    /**
     *
     * Tests if Duration_String_Status_PROD_To_Fix__c is filled with a Long when the Date_Status_PROD_To_Fix_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationStringStatusPRODToFixIsFilledAfterUpdate() {
        String nameOfRecording = 'kkul';
        String statusValue = 'Validated - To Be Deployed';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_String_Status_PROD_To_Fix__c
        String realStringDuration = workRecordHoneyAfterUpdate.Duration_String_Status_PROD_To_Fix__c;
        // check if Duration_String_Status_PROD_To_Fix__c is a isAlphanumericSpace()
        System.assert(realStringDuration.isAsciiPrintable(),'Duration_String_Status_PROD_To_Fix__c is not a string.');
    }
    /**
     *
     * Tests if Duration_String_Status_Validated_TBD__c is filled with a Long when the Date_Status_Validated_TBD_Ends__c is updated on agf__ADM_Work__c record.
     */
    @isTest
    static void checkIfWorkDurationStringStatusValidatedToBeDeployedInPRODIsFilledAfterUpdate() {
        String nameOfRecording = 'tsis na bit izh';
        String statusValue = 'Validated';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // get real field Duration_String_Status_Validated_TBD__c
        String realStringDuration = workRecordHoneyAfterUpdate.Duration_String_Status_Validated_TBD__c;
        // check if Duration_String_Status_Validated_TBD__c is a isAlphanumericSpace()
        System.assert(realStringDuration.isAsciiPrintable(),'Duration_String_Status_Validated_TBD__c is not a string.');
    }
    //----------------------------------------------------- CHECK the differences between RecordType 'User_Story' and 'Bug' -------------------------------------------------
    /**
     * Tests if Date_Status_Workload_DONE_Starts__c is NOT filled when the record type is 'Bug'
     */
    @isTest
    static void checkThatDurationDateStatusWorkloadDoneStartIsNOTFilledWhenRecordTypeIsBug(){
        String nameOfRecording = 'honey';
        String statusValue = 'Workload DONE';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // check if Date_Status_Workload_DONE_Starts__c is null
        System.assertEquals(null, workRecordHoneyAfterUpdate.Date_Status_Workload_DONE_Starts__c, 'Date_Status_Workload_DONE_Starts__c has been filled, it shouldn\'t have been.');
    }
    /**
     * Tests if Date_Status_OK_For_DEV_Starts__c is NOT filled when the record type is 'Bug'
     */
    @isTest
    static void checkThatDateStatusOKForDevStartsIsNOTFilledWhenRecordTypeIsBug(){
        String nameOfRecording = 'honey';
        String statusValue = 'OK For DEV';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // check if Date_Status_Workload_DONE_Starts__c is null
        System.assertEquals(null, workRecordHoneyAfterUpdate.Date_Status_OK_For_DEV_Starts__c, 'Date_Status_OK_For_DEV_Starts__c has been filled, it shouldn\'t have been.');
    }
    /**
     * Tests if Date_Status_DEV_IP_Starts__c is NOT filled when the record type is 'User_Story'
     */
    @isTest
    static void checkThatDateStatusDEVIPStartsIsNOTFilledWhenRecordTypeIsUserStory(){
        String nameOfRecording = 'milain';
        String statusValue = 'DEV - In Progress';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // check if Date_Status_Workload_DONE_Starts__c is null
        System.assertEquals(null, workRecordHoneyAfterUpdate.Date_Status_DEV_IP_Starts__c, 'Date_Status_DEV_IP_Starts__c has been filled, it shouldn\'t have been.');
    }
    /**
     * Tests if Date_Status_DEV_TBT_Starts__c is NOT filled when the record type is 'User_Story'
     */
    @isTest
    static void checkThatDateStatusDEVTBTStartsIsNOTFilledWhenRecordTypeIsUserStory(){
        String nameOfRecording = 'honig';
        String statusValue = 'DEV - To Be Tested';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // check if Date_Status_DEV_TBT_Starts__c is null
        System.assertEquals(null, workRecordHoneyAfterUpdate.Date_Status_DEV_TBT_Starts__c, 'Date_Status_DEV_TBT_Starts__c has been filled, it shouldn\'t have been.');
    }
    /**
     * Tests if Date_Status_DEV_TBD_UAT_Starts__c is NOT filled when the record type is 'User_Story'
     */
    @isTest
    static void checkThatDateStatusDEVTBDUATStartsIsNOTFilledWhenRecordTypeIsUserStory(){
        String nameOfRecording = 'honig';
        String statusValue = 'DEV - To Be Deployed in UAT';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // check if Date_Status_DEV_TBD_UAT_Starts__c is null
        System.assertEquals(null, workRecordHoneyAfterUpdate.Date_Status_DEV_TBD_UAT_Starts__c, 'Date_Status_DEV_TBD_UAT_Starts__c has been filled, it shouldn\'t have been.');
    }
    /**
     * Tests if Date_Status_UAT_To_Fix_Starts__c is NOT filled when the record type is 'User_Story'
     */
    @isTest
    static void checkThatDateStatusUATToFixStartsIsNOTFilledWhenRecordTypeIsUserStory(){
        String nameOfRecording = 'honig';
        String statusValue = 'UAT - To Fix';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // check if Date_Status_UAT_To_Fix_Starts__c is null
        System.assertEquals(null, workRecordHoneyAfterUpdate.Date_Status_UAT_To_Fix_Starts__c, 'Date_Status_UAT_To_Fix_Starts__c has been filled, it shouldn\'t have been.');
    }
    /**
     * Tests if Date_Status_UAT_TBD_PROD_Starts__c is NOT filled when the record type is 'User_Story'
     */
    @isTest
    static void checkThatDateStatusUATTBDInProdStartsIsNOTFilledWhenRecordTypeIsUserStory(){
        String nameOfRecording = 'honig';
        String statusValue = 'UAT - To Be Deployed in PROD';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // check if Date_Status_UAT_TBD_PROD_Starts__c is null
        System.assertEquals(null, workRecordHoneyAfterUpdate.Date_Status_UAT_TBD_PROD_Starts__c, 'Date_Status_UAT_TBD_PROD_Starts__c has been filled, it shouldn\'t have been.');
    }
    /**
     * Tests if Date_Status_PROD_To_Fix_Starts__c is NOT filled when the record type is 'User_Story'
     */
    @isTest
    static void checkThatDateStatusPRODToFixStartsIsNOTFilledWhenRecordTypeIsUserStory(){
        String nameOfRecording = 'honig';
        String statusValue = 'PROD - To Fix';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // check if Date_Status_PROD_To_Fix_Starts__c is null
        System.assertEquals(null, workRecordHoneyAfterUpdate.Date_Status_PROD_To_Fix_Starts__c, 'Date_Status_PROD_To_Fix_Starts__c has been filled, it shouldn\'t have been.');
    }
    /**
     * Tests if Date_Status_Validated_TBD_Starts__c is NOT filled when the record type is 'User_Story'
     */
    @isTest
    static void checkThatDateStatusValidatedTBDStartsIsNOTFilledWhenRecordTypeIsUserStory(){
        String nameOfRecording = 'honig';
        String statusValue = 'Validated - To Be Deployed';
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        agf__ADM_Work__c workRecordHoneyAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        // check if Date_Status_Validated_TBD_Starts__c is null
        System.assertEquals(null, workRecordHoneyAfterUpdate.Date_Status_Validated_TBD_Starts__c, 'Date_Status_Validated_TBD_Starts__c has been filled, it shouldn\'t have been.');
    }
    //----------------------------------------------------- CHECK Duration_In_MS_***-------------------------------------------------
    /**
     *
     * Tests if Duration_In_MS_To_Respond_To_A_US__c is filled with a Long when at least the field Duration_MS_Status_New__c is filled.
     */
    @isTest
    static void checkIfWorkDurationInMSToRespondToUSIsFilledWhenDurationStatusNew() {
        String nameOfRecording = 'honig';
        String statusValue = 'OK For DEV';
        Test.startTest();
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        Test.stopTest();
        agf__ADM_Work__c workRecordAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDurationToRespondToUS = (Long)workRecordAfterUpdate.Duration_In_MS_To_Respond_To_A_US__c;
        Long expectedDuration = 7200000;
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToUS, 
                            'The field Duration_In_MS_To_Respond_To_A_US__c on agf__ADM_Work__c is not filed correctly.'
                            );
    }
    /**
     *
     * Tests if Duration_In_MS_To_Respond_To_A_US__c is filled with a Long when at least the field Duration_MS_Status_New__c 
     * and Duration_MS_Status_OK_For_DEV__c are filled.
     */
    @isTest
    static void checkIfWorkDurationInMSToRespondToUSIsFilledWhenDurationStatusNewAndOKForDev() {
        String nameOfRecording = 'miel';
        String statusValue = 'Workload DONE';
        Test.startTest();
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        Test.stopTest();
        agf__ADM_Work__c workRecordAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDurationToRespondToUS = (Long)workRecordAfterUpdate.Duration_In_MS_To_Respond_To_A_US__c;
        Long expectedDuration = 3600000;
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToUS, 
                            'The field Duration_In_MS_To_Respond_To_A_US__c on agf__ADM_Work__c is not filed correctly.'
                            );
    }
        /**
     *
     * Tests if Duration_In_MS_To_Respond_To_A_US__c is filled with a Long when at least the field Duration_MS_Status_New__c 
     * and Duration_MS_Status_OK_For_DEV__c and Duration_MS_Status_Workload_DONE__c are filled.
     */
    @isTest
    static void checkIfWorkDurationInMSToRespondToUSIsFilledWhen3DurationsAreFilled() {
        String nameOfRecording = 'miel';
        String statusValue = 'OK For DEV';
        Test.startTest();
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        Test.stopTest();
        agf__ADM_Work__c workRecordAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDurationToRespondToUS = (Long)workRecordAfterUpdate.Duration_In_MS_To_Respond_To_A_US__c;
        //  Date_Status_Workload_DONE_Ends__c = is set to today so realDurationToRespondToUS can realy reach a high number as dateTimeRandom is set in 2022
        boolean actualResponse = 3600000 < realDurationToRespondToUS;
        System.debug('Realduration 3 filling= '+realDurationToRespondToUS);
        System.assertEquals(true, 
                            actualResponse, 
                            'The field Duration_In_MS_To_Respond_To_A_US__c on agf__ADM_Work__c is not filed correctly.'
                            );
    }
    /**
     *
     * Tests if Duration_In_MS_To_Respond_To_A_Bug__c is filled with a Long when the Duration_MS_Status_New__c is filled.
     */
    @isTest
    static void checkIfWorkDurationInMSToRespondToABugIsFilled() {
        String nameOfRecording = 'hachimitsu';
        String statusValue = 'DEV - To Be Tested';
        agf__ADM_Work__c workRecordHatchimitsu = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        Test.stopTest();
        agf__ADM_Work__c workRecordHatchimitsuAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDurationToRespondToABug = (Long)workRecordHatchimitsuAfterUpdate.Duration_In_MS_To_Respond_To_A_Bug__c;
        Long expectedDuration = 3600000;
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToABug, 
                            'The field Duration_In_MS_To_Respond_To_A_Bug__c on agf__ADM_Work__c is not filed correctly.'
                            );
    }
    /**
     *
     * Tests if Duration_In_MS_To_Correct_A_Bug__c is filled with a Long when at least the field Duration_MS_Status_DEV_TBT__c is filled.
     */
    @isTest
    static void checkIfWorkDurationInMSToCorrectABugIsFilled() {
        String nameOfRecording = 'devach';
        agf__ADM_Work__c workRecordDevach = getWorkRecordWithSubjectName(nameOfRecording);
        String statusValue = 'DEV - To Be Deployed in UAT';
        Test.startTest();
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        Test.stopTest();
        agf__ADM_Work__c workRecordDevachAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDurationToCorrectABug = (Long)workRecordDevachAfterUpdate.Duration_In_MS_To_Correct_A_Bug__c;
        Long expectedDuration = 3600000;
        System.assertEquals(expectedDuration, 
                            realDurationToCorrectABug, 
                            'The field Duration_In_MS_To_Correct_A_Bug__c on agf__ADM_Work__c is not filed correctly.'
                            );
    }
//----------------------------------------------------- CHECK Duration_In_String_***-------------------------------------------------
    
    /**
     *
     * Tests if Duration_In_String_To_Respond_To_A_Bug__c is filled with a String when the Duration_In_MS_To_Respond_To_A_Bug__c is filled.
     */
    @isTest
    static void checkIfWorkDurationInStringToRespondBugIsFilled() {
        String nameOfRecording = 'hachimitsu';
        String statusValue = 'DEV - To Be Tested';
        agf__ADM_Work__c workRecordHatchimitsu = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        Test.stopTest();
        agf__ADM_Work__c workRecordHatchimitsuAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        //WARNING White noises to add +' '
        String realDurationToRespondToABug = workRecordHatchimitsuAfterUpdate.Duration_In_String_To_Respond_To_A_Bug__c+' ';
        String expectedDuration = UTIL_Duration.generateAStringFromMS(3600000);
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToABug, 
                            'The field Duration_In_String_To_Respond_To_A_Bug__c on agf__ADM_Work__c is not filed correctly.'
                            );
    }
    /**
     *
     * Tests if Duration_In_String_To_Correct_A_Bug__c is filled with a String when the Duration_In_MS_To_Correct_A_Bug__c is filled.
     */
    @isTest
    static void checkIfWorkDurationInStringToCorrectBugIsFilled() {
        String nameOfRecording = 'devach';
        String statusValue = 'DEV - To Be Deployed in UAT';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        setupTestWhenStatusIs(statusValue, nameOfRecording);
        Test.stopTest();
        agf__ADM_Work__c workRecordAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        //WARNING White noises to add +' '
        String realDurationToCorrectoABug = workRecordAfterUpdate.Duration_In_String_To_Correct_A_Bug__c+' ';
        String expectedDuration = UTIL_Duration.generateAStringFromMS(3600000);
        System.debug('hachimitsu DurationString To correct a bug ->'+workRecordAfterUpdate.Duration_In_MS_To_Correct_A_Bug__c);
        System.debug('hachimitsu DurationString generated to respond to a bug ->'+expectedDuration+'<');
        System.debug('hachimitsu DurationString real to respond to a bug ->'+realDurationToCorrectoABug+'<');
        System.assertEquals(expectedDuration, 
                            realDurationToCorrectoABug, 
                            'The field Duration_In_String_To_Correct_A_Bug__c on agf__ADM_Work__c is not filed correctly.'
                            );
    }
}
