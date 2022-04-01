/** *******************************************************************************
 * @Author : Muriel Proton
 * @Company : Modis
 * This class tests the folowing class : UTIL_ServiceLevelAgreement
 * This class is used in class : 
 * @Interface : 
 * @Setup method : 
 * 
 ******************************************************************************* */
@IsTest
public with sharing class UTIL_ServiceLevelAgreement_Test {
    /**
     * Before each method Test and after the setup we need to find a record to test in Test DataBase.
     * method to call in each test to load a record.
     * TO USE ONLY IN THIS CLASS!
     * This methodes gets every fields with names Date_Status_XX_Starts__c
     * It is not the same as the one on TH_WorkTrigger_Test as this class tests for other things.
     * Called by :  
     * @Parametters : None
     * @Returns : agf__ADM_Work__c
     */
    static agf__ADM_Work__c getWorkRecordWithSubjectName(String subjectOnWork){
        agf__ADM_Work__c workRecordHoney =null;
        try{
            workRecordHoney =[ SELECT Id,
                                      RecordTypeId,
                                      agf__Status__c,
                                      agf__Created_On_Date__c, 
                                      Date_Status_New_Starts__c,
                                      Date_Status_Workload_DONE_Ends__c,
                                      Date_Status_DEV_IP_Ends__c,
                                      Date_Status_Validated_TBD_Ends__c,
                                      agf__Priority__c,
                                      Bypass_For_Corrective_Maintenance_On_Bug__c
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
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime dateTimeCreation = DateTime.newInstance(2022, 4, 1, 10, 8, 16);
        DateTime dateTimeWorkloadDoneEnds = DateTime.newInstance(2022, 4, 1, 12, 22, 16);
        DateTime dateTimeInProgressEnds = DateTime.newInstance(2022, 4, 1, 11, 8, 16);
        DateTime dateTimeValidatedTBDEnds = DateTime.newInstance(2022, 4, 1, 13, 22, 16);
        // creating a record on sObject agf__ADM_Work__c Status New
        agf__ADM_Work__c workRecordNewHoney = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'honey',
            agf__Status__c = 'New',
            Date_Status_New_Starts__c = dateTimeCreation,
            Date_Status_DEV_IP_Ends__c = dateTimeInProgressEnds,
            Date_Status_Validated_TBD_Ends__c = dateTimeValidatedTBDEnds,
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0',
            Bypass_For_Corrective_Maintenance_On_Bug__c = false
        );
        // creating a record on sObject agf__ADM_Work__c Status New
        agf__ADM_Work__c workRecordNewMiel = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdUS,
            agf__Subject__c = 'miel',
            agf__Status__c = 'New',
            Date_Status_Workload_DONE_Ends__c = dateTimeWorkloadDoneEnds,
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a list of records on sObject agf__ADM_Work__c
        List<agf__ADM_Work__c> workRecordsList= new List<agf__ADM_Work__c>();
        workRecordsList.add(workRecordNewHoney);
        workRecordsList.add(workRecordNewMiel);
        try{
            //Insert a list of record
            insert workRecordsList;
        }catch (ListException e){
            System.debug('In tests run on UTIL_ServiceLevelAgreement, the list of records on the sObject Work was not inserted. ref : workRecordsList');
        }
    }
    /**
     *
     * Tests if getDateStatusNewStarts(String subjectOnWork) returns the right DateTime
     */
    @isTest
    static void testIfGetDateStatusNewStartsReturnsTheRightDate() {
        String nameOfRecording = 'honey';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        DateTime realDateTimeToTest = UTIL_ServiceLevelAgreement.getDateStatusNewStarts(workRecord);
        Test.stopTest();
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime expectedDateTime = DateTime.newInstance(2022, 4, 1, 10, 8, 16);
        System.assertEquals(expectedDateTime, 
                            realDateTimeToTest, 
                            'On the sObject Work the field Date_Status_New_Starts__c could not be retrieved correctly.'
                            );
    }
    /**
     *
     * Tests if getDateStatusWorkloadDONEEnds(String subjectOnWork) returns the right DateTime
     */
    @isTest
    static void testIfGetDateStatusWorkloadDONEEndsReturnsTheRightDate() {
        String nameOfRecording = 'miel';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        DateTime realDateTimeToTest = UTIL_ServiceLevelAgreement.getDateStatusWorkloadDONEEnds(workRecord);
        Test.stopTest();
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime expectedDateTime = DateTime.newInstance(2022, 4, 1, 12, 22, 16);
        System.assertEquals(expectedDateTime, 
                            realDateTimeToTest, 
                            'On the sObject Work the field Date_Status_Workload_DONE_Ends__c could not be retrieved correctly.'
                            );

    }
    /**
     *
     * Tests if getDateStatusDEVIPEnds(String subjectOnWork) returns the right DateTime
     */
    @isTest
    static void testIfGetDateStatusDEVIPEndsReturnsTheRightDate() {
        String nameOfRecording = 'honey';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        DateTime realDateTimeToTest = UTIL_ServiceLevelAgreement.getDateStatusDEVIPEnds(workRecord);
        Test.stopTest();
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime expectedDateTime = DateTime.newInstance(2022, 4, 1, 11, 8, 16);
        System.assertEquals(expectedDateTime, 
                            realDateTimeToTest, 
                            'On the sObject Work the field Date_Status_DEV_IP_Ends__c could not be retrieved correctly.'
                            );

    }
    /**
     *
     * Tests if getDateStatusValidatedTBDEnds(String subjectOnWork) returns the right DateTime
     */
    @isTest
    static void testIfGetDateStatusValidatedTBDEndsReturnsTheRightDate() {
        String nameOfRecording = 'honey';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        DateTime realDateTimeToTest = UTIL_ServiceLevelAgreement.getDateStatusValidatedTBDEnds(workRecord);
        Test.stopTest();
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime expectedDateTime = DateTime.newInstance(2022, 4, 1, 13, 22, 16);
        System.assertEquals(expectedDateTime, 
                            realDateTimeToTest, 
                            'On the sObject Work the field Date_Status_Validated_TBD_Ends__c could not be retrieved correctly.'
                            );

    }
    /**
     *
     * Tests if getRecordTypeDeveloperName(String subjectOnWork) returns the right String
     */
    @isTest
    static void testIfGetRecordTypeDeveloperNameReturnsTheRightString() {
        String nameOfRecording = 'honey';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        String realString = UTIL_ServiceLevelAgreement.getRecordTypeDeveloperName(workRecord);
        Test.stopTest();
        String expectedString = 'Bug';
        System.assertEquals(expectedString, 
                            realString, 
                            'On the sObject Work the field record Type developer\'s name could not be retrieved correctly.'
                            );

    }
    /**
     *
     * Tests if getRecordPriority(String subjectOnWork) returns the right String
     */
    @isTest
    static void testIfGetRecordPriorityReturnsTheRightString() {
        String nameOfRecording = 'honey';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        String realString = UTIL_ServiceLevelAgreement.getRecordPriority(workRecord);
        Test.stopTest();
        String expectedString = 'P0';
        System.assertEquals(expectedString, 
                            realString, 
                            'On the sObject Work the field record agf__Priority__c could not be retrieved correctly.'
                            );

    }
    /**
     *
     * Tests if getRecordStatus(agf__ADM_Work__c workRecord) returns the right String
     */
    @isTest
    static void testIfGetRecordStatusReturnsTheRightString() {
        String nameOfRecording = 'honey';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        String realString = UTIL_ServiceLevelAgreement.getRecordStatus(workRecord);
        Test.stopTest();
        String expectedString = 'New';
        System.assertEquals(expectedString, 
                            realString, 
                            'On the sObject Work the field record agf__Priority__c could not be retrieved correctly.'
                            );

    }
    /**
     *
     * Tests if getRecordBypassForCorrectiveMaintenanceOnBugs(agf__ADM_Work__c workRecord) returns the right String
     */
    @isTest
    static void testIfgetRecordBypassForCorrectiveMaintenanceOnBugsReturnsFalse() {
        String nameOfRecording = 'honey';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        boolean realBoolean = UTIL_ServiceLevelAgreement.getRecordBypassForCorrectiveMaintenanceOnBugs(workRecord);
        Test.stopTest();
        boolean expectedBoolean = false;
        System.assertEquals(expectedBoolean, 
                            realBoolean, 
                            'On the sObject Work the field record Bypass_For_Corrective_Maintenance_On_Bug__c could not be retrieved correctly.'
                            );

    }
}
