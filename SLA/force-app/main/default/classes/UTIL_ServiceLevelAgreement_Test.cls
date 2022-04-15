/** *******************************************************************************
 * @Author : Muriel Proton
 * @Company : Modis
 * This class tests the folowing class : UTIL_ServiceLevelAgreement
 * This class is used in class : 
 * @Interface : 
 * @Setup method : 
 * Version : 2022 04 12
 ******************************************************************************* */
@IsTest
public with sharing class UTIL_ServiceLevelAgreement_Test {
    public static DateTime dateTimeCreation = DateTime.newInstance(2022, 4, 1, 10, 8, 16);
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
                                      Date_Status_New_Ends__c,
                                      Date_Status_Workload_DONE_Ends__c,
                                      Date_Status_DEV_IP_Ends__c,
                                      Date_Status_Validated_TBD_Ends__c,
                                      agf__Priority__c,
                                      Bypass_For_Corrective_Maintenance_On_Bug__c,
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
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        
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
        // creating a record on sObject agf__ADM_Work__c Status OK For DEV
        agf__ADM_Work__c workRecordOKForDEVAsala = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdUS,
            agf__Subject__c = 'asala',
            agf__Status__c = 'OK For DEV',
            Duration_MS_Status_New__c = 30600000,
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P1'
        );
        // creating a record on sObject agf__ADM_Work__c Status 'Workload DONE'
        agf__ADM_Work__c workRecordWorkloadDONEMed = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdUS,
            agf__Subject__c = 'med',
            agf__Status__c = 'Workload DONE',
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            Duration_MS_Status_New__c = 30600000,
            Duration_MS_Status_Workload_DONE__c = 30600000,
            agf__Priority__c = 'P2'
        );
        // creating a record on sObject agf__ADM_Work__c Status 'Validated'
        agf__ADM_Work__c workRecordValidatedHonung = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdUS,
            agf__Subject__c = 'honung',
            agf__Status__c = 'Validated',
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            Duration_MS_Status_New__c = 30600000,
            Duration_MS_Status_Workload_DONE__c = 30600000,
            Duration_MS_Status_OK_For_DEV__c = 30600000,
            agf__Priority__c = 'P3'
        );
        // creating a record on sObject agf__ADM_Work__c Status DEV - In Progress
        agf__ADM_Work__c workRecordDevInProgressMilain = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'milain',
            agf__Status__c = 'DEV - In Progress',
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            Date_Status_New_Starts__c = dateTimeCreation,
            Date_Status_New_Ends__c = dateTimeCreation.addHours(1),
            Duration_MS_Status_New__c = 3600000,
            agf__Priority__c = 'P1'
        );
        // creating a record on sObject agf__ADM_Work__c Status DEV - To Be Deployed in UAT
        agf__ADM_Work__c workRecordDEVToBeTestedFengMi = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'feng mi',
            agf__Status__c = 'DEV - To Be Deployed in UAT',
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            Date_Status_New_Starts__c = dateTimeCreation,
            Date_Status_New_Ends__c = dateTimeCreation.addHours(1),
            Duration_MS_Status_New__c = 3600000,
            Duration_MS_Status_DEV_IP__c = 3600000,
            Duration_MS_Status_DEV_TBT__c = 3600000,
            agf__Priority__c = 'P1',
            Bypass_For_Corrective_Maintenance_On_Bug__c = true
        );
        // creating a record on sObject agf__ADM_Work__c Status UAT - To Fix
        agf__ADM_Work__c workRecordDEVTBDeployedUATHoning = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'honing',
            agf__Status__c = 'UAT - To Fix',
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            Date_Status_New_Starts__c = dateTimeCreation,
            Date_Status_New_Ends__c = dateTimeCreation.addDays(1),
            Duration_MS_Status_New__c = 30600000,
            Duration_MS_Status_DEV_IP__c = 30600000,
            Duration_MS_Status_DEV_TBT__c = 30600000,
            Duration_MS_Status_DEV_TBD_UAT__c = 30600000,
            agf__Priority__c = 'P2',
            Bypass_For_Corrective_Maintenance_On_Bug__c = true
        );
        // creating a record on sObject agf__ADM_Work__c Status UAT - To Be Deployed in PROD
        agf__ADM_Work__c workRecordUATToFixMel = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'mel',
            agf__Status__c = 'UAT - To Be Deployed in PROD',
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            Duration_MS_Status_New__c = 30600000,
            Duration_MS_Status_DEV_IP__c = 30600000,
            Duration_MS_Status_DEV_TBT__c = 30600000,
            Duration_MS_Status_DEV_TBD_UAT__c = 30600000,
            Duration_MS_Status_UAT_To_Fix__c = 30600000,
            agf__Priority__c = 'P3',
            Bypass_For_Corrective_Maintenance_On_Bug__c = true
        );
        // creating a record on sObject agf__ADM_Work__c Status PROD - To Fix
        agf__ADM_Work__c workRecordPRODToFixMiere = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'miere',
            agf__Status__c = 'PROD - To Fix',
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            Duration_MS_Status_New__c = 30600000,
            Duration_MS_Status_DEV_IP__c = 30600000,
            Duration_MS_Status_DEV_TBT__c = 30600000,
            Duration_MS_Status_DEV_TBD_UAT__c = 30600000,
            Duration_MS_Status_UAT_To_Fix__c = 30600000,
            Duration_MS_Status_UAT_TBD_PROD__c = 30600000,
            agf__Priority__c = 'P1'
        );
        // creating a record on sObject agf__ADM_Work__c Status 'Validated - To Be Deployed'
        agf__ADM_Work__c workRecordValidatedToBeDeployedKkul = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'kkul',
            agf__Status__c = 'Validated - To Be Deployed',
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            Duration_MS_Status_New__c = 30600000,
            Duration_MS_Status_DEV_IP__c = 30600000,
            Duration_MS_Status_DEV_TBT__c = 30600000,
            Duration_MS_Status_DEV_TBD_UAT__c = 30600000,
            Duration_MS_Status_UAT_To_Fix__c = 30600000,
            Duration_MS_Status_UAT_TBD_PROD__c = 30600000,
            Duration_MS_Status_PROD_To_Fix__c = 30600000,
            agf__Priority__c = 'P2'
        );

        // creating a record on sObject agf__ADM_Work__c Status Validated - To Be Deployed
        agf__ADM_Work__c workRecordValidatedTBDTsisNaBitIzh = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'tsis na bit izh',
            agf__Status__c = 'Validated - To Be Deployed',
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            Duration_MS_Status_New__c = 30600000,
            Duration_MS_Status_DEV_IP__c = 30600000,
            Duration_MS_Status_DEV_TBT__c = 30600000,
            Duration_MS_Status_DEV_TBD_UAT__c = 30600000,
            Duration_MS_Status_UAT_To_Fix__c = 30600000,
            Duration_MS_Status_UAT_TBD_PROD__c = 30600000,
            Duration_MS_Status_PROD_To_Fix__c = 30600000,
            Duration_MS_Status_Validated_TBD__c = 30600000,
            agf__Priority__c = 'P3'
        );
        // creating a list of records on sObject agf__ADM_Work__c
        List<agf__ADM_Work__c> workRecordsList= new List<agf__ADM_Work__c>();
        workRecordsList.add(workRecordNewHoney);
        workRecordsList.add(workRecordNewMiel);
        workRecordsList.add(workRecordOKForDEVAsala);
        workRecordsList.add(workRecordWorkloadDONEMed);
        workRecordsList.add(workRecordValidatedHonung);
        workRecordsList.add(workRecordDevInProgressMilain);
        workRecordsList.add(workRecordDEVToBeTestedFengMi);
        workRecordsList.add(workRecordDEVTBDeployedUATHoning);
        workRecordsList.add(workRecordUATToFixMel);
        workRecordsList.add(workRecordPRODToFixMiere);
        workRecordsList.add(workRecordValidatedToBeDeployedKkul);
        workRecordsList.add(workRecordValidatedTBDTsisNaBitIzh);
        try{
            //Insert a list of record
            insert workRecordsList;
        }catch (ListException e){
            System.debug('In tests run on UTIL_ServiceLevelAgreement, the list of records on the sObject Work was not inserted. ref : workRecordsList');
        }
    }


//------------------------------------------------------TEST FOR STATIC METHODS ---------------------------------------------
    /**
     *
     * Tests if howLongTillResponsIsMandatoryForUS(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testHowLongTillResponseIsMandatoryForUSP0Scenario(){
        String nameOfRecording = 'miel';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDuration = UTIL_ServiceLevelAgreement.howLongTillResponseIsMandatoryForUS(workRecord);
        Long expectedDuration = null;
        System.debug('workRecord.agf__Priority__c -> '+workRecord.agf__Priority__c);
        System.assertEquals(expectedDuration, 
                            realDuration, 
                            'howLongTillResponsIsMandatoryForUS(agf__ADM_Work__c workRecord) does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if howLongTillResponsIsMandatoryForUS(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testHowLongTillResponsIsMandatoryForUSP1Scenario(){
        String nameOfRecording = 'asala';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDuration = UTIL_ServiceLevelAgreement.howLongTillResponseIsMandatoryForUS(workRecord);
        Long expectedDuration = 61200000;
        System.debug('workRecord.agf__Priority__c -> '+workRecord.agf__Priority__c);
        System.assertEquals(expectedDuration, 
                            realDuration, 
                            'howLongTillResponsIsMandatoryForUS(agf__ADM_Work__c workRecord) does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if howLongTillResponseIsMandatoryForUS(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testHowLongTillResponsIsMandatoryForUSP2Scenario(){
        String nameOfRecording = 'med';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDuration = UTIL_ServiceLevelAgreement.howLongTillResponseIsMandatoryForUS(workRecord);
        Long expectedDuration = 183600000;
        System.debug('workRecord.agf__Priority__c -> '+workRecord.agf__Priority__c);
        System.assertEquals(expectedDuration, 
                            realDuration, 
                            'howLongTillResponsIsMandatoryForUS(agf__ADM_Work__c workRecord) does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if howLongTillResponseIsMandatoryForBug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testHowLongTillResponsIsMandatoryForBugP1Scenario(){
        String nameOfRecording = 'feng mi';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDuration = UTIL_ServiceLevelAgreement.howLongTillResponseIsMandatoryForBug(workRecord);
        Long expectedDuration = 7200000;
        System.debug('workRecord.agf__Priority__c -> '+workRecord.agf__Priority__c);
        System.assertEquals(expectedDuration, 
                            realDuration, 
                            'howLongTillResponseIsMandatoryForBug(agf__ADM_Work__c workRecord) does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if howLongTillResponseIsMandatoryForBug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testHowLongTillResponsIsMandatoryForBugP2Scenario(){
        String nameOfRecording = 'honing';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDuration = UTIL_ServiceLevelAgreement.howLongTillResponseIsMandatoryForBug(workRecord);
        Long expectedDuration = 30600000;
        System.debug('workRecord.agf__Priority__c -> '+workRecord.agf__Priority__c);
        System.assertEquals(expectedDuration, 
                            realDuration, 
                            'howLongTillResponseIsMandatoryForBug(agf__ADM_Work__c workRecord) does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if howLongTillResponseIsMandatoryForBug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testHowLongTillResponsIsMandatoryForBugP3Scenario(){
        String nameOfRecording = 'mel';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDuration = UTIL_ServiceLevelAgreement.howLongTillResponseIsMandatoryForBug(workRecord);
        Long expectedDuration = 61200000;
        System.debug('workRecord.agf__Priority__c -> '+workRecord.agf__Priority__c);
        System.assertEquals(expectedDuration, 
                            realDuration, 
                            'howLongTillResponseIsMandatoryForBug(agf__ADM_Work__c workRecord) does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if howLongTillCorrectionIsMandatoryForBug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testHowLongTillResponsIsMandatoryForBugP1ScenarioBypassTrue(){
        String nameOfRecording = 'feng mi';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDuration = UTIL_ServiceLevelAgreement.howLongTillCorrectionIsMandatoryForBug(workRecord);
        Long expectedDuration = 30600000*4;
        
        System.debug('workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c -> '+workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c);
        System.debug('workRecord.agf__Priority__c -> '+workRecord.agf__Priority__c);
        System.assertEquals(expectedDuration, 
                            realDuration, 
                            'howLongTillCorrectionIsMandatoryForBug(agf__ADM_Work__c workRecord) does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if howLongTillCorrectionIsMandatoryForBug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testHowLongTillResponsIsMandatoryForBugP2ScenarioBypassTrue(){
        String nameOfRecording = 'honing';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDuration = UTIL_ServiceLevelAgreement.howLongTillCorrectionIsMandatoryForBug(workRecord);
        Long expectedDuration = 30600000*15;
        
        System.debug('workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c -> '+workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c);
        System.debug('workRecord.agf__Priority__c -> '+workRecord.agf__Priority__c);
        System.assertEquals(expectedDuration, 
                            realDuration, 
                            'howLongTillCorrectionIsMandatoryForBug(agf__ADM_Work__c workRecord) does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if howLongTillCorrectionIsMandatoryForBug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testHowLongTillResponsIsMandatoryForBugP3ScenarioBypassTrue(){
        String nameOfRecording = 'mel';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDuration = UTIL_ServiceLevelAgreement.howLongTillCorrectionIsMandatoryForBug(workRecord);
        Long expectedDuration = 30600000*22;
        System.debug('workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c -> '+workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c);
        System.debug('workRecord.agf__Priority__c -> '+workRecord.agf__Priority__c);
        System.assertEquals(expectedDuration, 
                            realDuration, 
                            'howLongTillCorrectionIsMandatoryForBug(agf__ADM_Work__c workRecord) does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if howLongTillCorrectionIsMandatoryForBug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testHowLongTillResponsIsMandatoryForBugP1ScenarioBypassFalse(){
        String nameOfRecording = 'miere';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDuration = UTIL_ServiceLevelAgreement.howLongTillCorrectionIsMandatoryForBug(workRecord);
        Long expectedDuration = 30600000*2;
        
        System.debug('workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c -> '+workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c);
        System.debug('workRecord.agf__Priority__c -> '+workRecord.agf__Priority__c);
        System.assertEquals(expectedDuration, 
                            realDuration, 
                            'howLongTillCorrectionIsMandatoryForBug(agf__ADM_Work__c workRecord) does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if howLongTillCorrectionIsMandatoryForBug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testHowLongTillResponsIsMandatoryForBugP2ScenarioBypassFalse(){
        String nameOfRecording = 'kkul';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDuration = UTIL_ServiceLevelAgreement.howLongTillCorrectionIsMandatoryForBug(workRecord);
        Long expectedDuration = 30600000*8;
        
        System.debug('workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c -> '+workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c);
        System.debug('workRecord.agf__Priority__c -> '+workRecord.agf__Priority__c);
        System.assertEquals(expectedDuration, 
                            realDuration, 
                            'howLongTillCorrectionIsMandatoryForBug(agf__ADM_Work__c workRecord) does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if howLongTillCorrectionIsMandatoryForBug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testHowLongTillResponsIsMandatoryForBugP3ScenarioBypassFalse(){
        String nameOfRecording = 'tsis na bit izh';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Long realDuration = UTIL_ServiceLevelAgreement.howLongTillCorrectionIsMandatoryForBug(workRecord);
        Long expectedDuration = 30600000*12;
        System.debug('workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c -> '+workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c);
        System.debug('workRecord.agf__Priority__c -> '+workRecord.agf__Priority__c);
        System.assertEquals(expectedDuration, 
                            realDuration, 
                            'howLongTillCorrectionIsMandatoryForBug(agf__ADM_Work__c workRecord) does not compute correctly.'
                            );
    }
    /**
     *
     * Tests calculateDeadlineForABugInNeedOfCorrection(agf__ADM_Work__c workRecord, String businessHoursId, List<Holiday> listOfHolidays)
     * 
     */
    @isTest
    static void testCalculateDeadlineForABugInNeedOfCorrectionP1(){
        String nameOfRecording = 'milain';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
        String businessHoursId = UTIL_Duration.getBusinessHours().Id;
        DateTime realDateTime = UTIL_ServiceLevelAgreement.calculateDeadlineForABugInNeedOfCorrection(workRecord, businessHoursId, listOfHolidays);
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime expectedDateTime = DateTime.newInstance(2022, 4, 5, 11, 8, 00);
        System.assertEquals(expectedDateTime, 
                            realDateTime, 
                            'calculateDeadlineForABugInNeedOfCorrection does not return the right DateTime for a P1 with no bypass.'
                            );
    }
    /**
     *
     * Tests calculateDeadlineForABugInNeedOfCorrection(agf__ADM_Work__c workRecord, String businessHoursId, List<Holiday> listOfHolidays)
     * 
     */
    @isTest
    static void testCalculateDeadlineForABugInNeedOfCorrectionP1WithABipass(){
        String nameOfRecording = 'milain';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c = true;
        update workRecord;
        agf__ADM_Work__c workRecordAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
        String businessHoursId = UTIL_Duration.getBusinessHours().Id;
        DateTime realDateTime = UTIL_ServiceLevelAgreement.calculateDeadlineForABugInNeedOfCorrection(workRecordAfterUpdate, businessHoursId, listOfHolidays);
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime expectedDateTime = DateTime.newInstance(2022, 4, 7, 11, 8, 00);
        System.assertEquals(expectedDateTime, 
                            realDateTime, 
                            'calculateDeadlineForABugInNeedOfCorrection does not return the right DateTime for a P1 with a bypass.'
                            );
    }
     /**
     *
     * Tests calculateDeadlineForABugInNeedOfCorrection(agf__ADM_Work__c workRecord, String businessHoursId, List<Holiday> listOfHolidays)
     * 
     */
    @isTest
    static void testCalculateDeadlineForABugInNeedOfCorrectionP2(){
        String nameOfRecording = 'honing';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
        String businessHoursId = UTIL_Duration.getBusinessHours().Id;
        workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c = false;
        update workRecord;
        agf__ADM_Work__c workRecordAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        DateTime realDateTime = UTIL_ServiceLevelAgreement.calculateDeadlineForABugInNeedOfCorrection(workRecordAfterUpdate, businessHoursId, listOfHolidays);
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime expectedDateTime = DateTime.newInstance(2022, 4, 14, 9, 0, 00);
        System.assertEquals(expectedDateTime, 
                            realDateTime, 
                            'calculateDeadlineForABugInNeedOfCorrection does not return the right DateTime for a P2 with no bypass.'
                            );
    }
    /**
     *
     * Tests calculateDeadlineForABugInNeedOfCorrection(agf__ADM_Work__c workRecord, String businessHoursId, List<Holiday> listOfHolidays)
     * 
     */
    @isTest
    static void testCalculateDeadlineForABugInNeedOfCorrectionP2WithABypass(){
        String nameOfRecording = 'honing';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
        String businessHoursId = UTIL_Duration.getBusinessHours().Id;
        workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c = true;
        update workRecord;
        agf__ADM_Work__c workRecordAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        DateTime realDateTime = UTIL_ServiceLevelAgreement.calculateDeadlineForABugInNeedOfCorrection(workRecordAfterUpdate, businessHoursId, listOfHolidays);
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime expectedDateTime = DateTime.newInstance(2022, 4, 26, 9, 0, 00);
        System.assertEquals(expectedDateTime, 
                            realDateTime, 
                            'calculateDeadlineForABugInNeedOfCorrection does not return the right DateTime for a P2 with a bypass.'
                            );
    }
     /**
     *
     * Tests calculateDeadlineForABugInNeedOfCorrection(agf__ADM_Work__c workRecord, String businessHoursId, List<Holiday> listOfHolidays)
     * 
     */
    @isTest
    static void testCalculateDeadlineForABugInNeedOfCorrectionP3(){
        String nameOfRecording = 'mel';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
        String businessHoursId = UTIL_Duration.getBusinessHours().Id;
        workRecord.Date_Status_New_Ends__c = dateTimeCreation;
        workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c = false;
        update workRecord;
        agf__ADM_Work__c workRecordAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        DateTime realDateTime = UTIL_ServiceLevelAgreement.calculateDeadlineForABugInNeedOfCorrection(workRecordAfterUpdate, businessHoursId, listOfHolidays);
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime expectedDateTime = DateTime.newInstance(2022, 4, 20, 9, 0, 0);
        System.debug('workRecord - '+workRecord);
        System.debug('workRecordAfterUpdate - '+workRecordAfterUpdate);
        System.assertEquals(expectedDateTime, 
                            realDateTime, 
                            'calculateDeadlineForABugInNeedOfCorrection does not return the right DateTime for a P3 with no bypass.'
                            );
    }
         /**
     *
     * Tests calculateDeadlineForABugInNeedOfCorrection(agf__ADM_Work__c workRecord, String businessHoursId, List<Holiday> listOfHolidays)
     * 
     */
    @isTest
    static void testCalculateDeadlineForABugInNeedOfCorrectionP3WithABypass(){
        String nameOfRecording = 'mel';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
        String businessHoursId = UTIL_Duration.getBusinessHours().Id;
        workRecord.Date_Status_New_Ends__c = dateTimeCreation;
        workRecord.Bypass_For_Corrective_Maintenance_On_Bug__c = true;
        update workRecord;
        agf__ADM_Work__c workRecordAfterUpdate = getWorkRecordWithSubjectName(nameOfRecording);
        DateTime realDateTime = UTIL_ServiceLevelAgreement.calculateDeadlineForABugInNeedOfCorrection(workRecordAfterUpdate, businessHoursId, listOfHolidays);
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime expectedDateTime = DateTime.newInstance(2022, 5, 4, 9, 0, 0);
        System.debug('workRecord - '+workRecord);
        System.debug('workRecordAfterUpdate - '+workRecordAfterUpdate);
        System.assertEquals(expectedDateTime, 
                            realDateTime, 
                            'calculateDeadlineForABugInNeedOfCorrection does not return the right DateTime for a P3 with a bypass.'
                            );
    }
    /**
     *
     * Tests calculateADateTimeWithinBHNotHolidayAdding(Long numberOfDays,String businessHoursId, List<Holiday> listOfHolidays, DateTime dateTimeInitial)
     * 
     */
    @isTest
    static void testCalculateDateTimeWithinBusinessHoursNOTAHolidayAddingFromHoliday() {
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime dateTimeInitial = DateTime.newInstance(2022, 4, 18, 8, 21, 16);
        DateTime expectedDateTime = DateTime.newInstance(2022, 6, 1, 9, 0, 0);
        List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
        String businessHoursId = UTIL_Duration.getBusinessHours().Id;
        Long numberOfDays = 30;
        Test.startTest();
        DateTime realDateTime = UTIL_ServiceLevelAgreement.calculateADateTimeWithinBHNotHolidayAdding(numberOfDays, businessHoursId, listOfHolidays, dateTimeInitial );
        Test.stopTest();
        System.assertEquals(expectedDateTime, 
                            realDateTime, 
                            'calculateADateTimeWithinBHNotHolidayAdding does not return the right date after adding 30 days.'
                            );

    }
    /**
     *
     * Tests if calculateADateTimeWithinBHNotHolidayAdding(Long numberOfDays,String businessHoursId, List<Holiday> listOfHolidays, DateTime dateTimeInitial)
     * 
     */
    @isTest
    static void testCalculateDateTimeWithinBusinessHoursNOTAHolidayAddingFromNormalDay() {
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime dateTimeInitial = DateTime.newInstance(2022, 4, 4, 9, 21, 16);
        DateTime expectedDateTime = DateTime.newInstance(2022, 4, 6, 9, 21, 0);
        List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
        String businessHoursId = UTIL_Duration.getBusinessHours().Id;
        Long numberOfDays = 2;
        Test.startTest();
        DateTime realDateTime = UTIL_ServiceLevelAgreement.calculateADateTimeWithinBHNotHolidayAdding(numberOfDays, businessHoursId, listOfHolidays, dateTimeInitial );
        Test.stopTest();
        System.assertEquals(expectedDateTime, 
                            realDateTime, 
                            'calculateADateTimeWithinBHNotHolidayAdding does not return the right date after adding 30 days.'
                            );
    }
    /**getingNextDateTimeWithinBusinessHoursNOTAHoliday
     *
     * Tests if getingNextDateTimeWithinBusinessHoursNOTAHoliday(String businessHoursId, List<Holiday> listOfHolidays, DateTime dateTimeInitial)
     * 
     */
    @isTest
    static void testIfGetingNextDateTimeWithinBusinessHoursNOTAHoliday() {
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime dateTimeToConvert = DateTime.newInstance(2022, 6, 3, 17, 32, 16);
        List<Holiday> listOfHolidays = UTIL_Duration.getListOfHolidays();
        BusinessHours businessHours = UTIL_Duration.getBusinessHours();
        String businessHoursId = businessHours.Id;
        Test.startTest();
        DateTime realDateTime = UTIL_ServiceLevelAgreement.getingNextDateTimeWithinBusinessHoursNOTAHoliday(businessHoursId, listOfHolidays, dateTimeToConvert);
        Test.stopTest();
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime expectedDateTime = DateTime.newInstance(2022, 6, 7, 9, 0, 0);
        System.assertEquals(expectedDateTime, 
                            realDateTime, 
                            'On the sObject Work the field record Bypass_For_Corrective_Maintenance_On_Bug__c could not be retrieved correctly.'
                            );

    }
    /**
     *
     * Tests if calculateDurationInMSToRespondToAUS(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testCalculateDurationInMSToRespondToAUSWhen1FieldIsSet(){
        Long expectedDuration = long.valueOf('30600000');
        String nameOfRecording = 'asala';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        Long realDurationToRespondToAUS = (Long)UTIL_ServiceLevelAgreement.calculateDurationInMSToRespondToAUS(workRecord);
        Test.stopTest();
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToAUS, 
                            'method calculateDurationInMSToRespondToAUS - The adition of the 3 fields : Duration_MS_Status_New__c + '+
                            'Duration_MS_Status_OK_For_DEV__c + Duration_MS_Status_Workload_DONE__c are filled, does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if calculateDurationInMSToRespondToAUS(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testCalculateDurationInMSToRespondToAUSWhen2FieldsAreSet(){
        Long expectedDuration = long.valueOf('61200000');
        String nameOfRecording = 'med';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        Long realDurationToRespondToAUS = (Long)UTIL_ServiceLevelAgreement.calculateDurationInMSToRespondToAUS(workRecord);
        Test.stopTest();
        System.debug('workRecord.Duration_MS_Status_New__c = ' + workRecord.Duration_MS_Status_New__c);
        System.debug('workRecord.Duration_MS_Status_Workload_DONE__c = ' + workRecord.Duration_MS_Status_Workload_DONE__c);
        System.debug('workRecord.Duration_MS_Status_OK_For_DEV__c = ' + workRecord.Duration_MS_Status_OK_For_DEV__c);
        
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToAUS, 
                            'method calculateDurationInMSToRespondToAUS - The adition of the 3 fields : Duration_MS_Status_New__c + '+
                            'Duration_MS_Status_OK_For_DEV__c + Duration_MS_Status_Workload_DONE__c are filled, does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if calculateDurationInMSToRespondToAUS(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testCalculateDurationInMSToRespondToAUSWhen3FieldsAreSet(){
        Long expectedDuration = long.valueOf('61200000');
        String nameOfRecording = 'Honung';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        Long realDurationToRespondToAUS = (Long)UTIL_ServiceLevelAgreement.calculateDurationInMSToRespondToAUS(workRecord);
        Test.stopTest();
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToAUS, 
                            'method calculateDurationInMSToRespondToAUS - The adition of the 3 fields : Duration_MS_Status_New__c + '+
                            'Duration_MS_Status_OK_For_DEV__c + Duration_MS_Status_Workload_DONE__c are filled, does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if calculateDurationInMSToRespondToABug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testCalculateDurationInMSToRespondToABug(){
        Long expectedDuration = long.valueOf('3600000');
        String nameOfRecording = 'milain';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        Long realDurationToRespondToABug = (Long)UTIL_ServiceLevelAgreement.calculateDurationInMSToRespondToABug(workRecord);
        Test.stopTest();
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToABug, 
                            'The method calculateDurationInMSToRespondToABug does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if calculateDurationInMSToRespondToABug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testCalculateDurationInMSToRespondToABugWhenThereAreMoreFieldsCompleted(){
        Long expectedDuration = long.valueOf('3600000');
        String nameOfRecording = 'feng mi';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        Long realDurationToRespondToABug = (Long)UTIL_ServiceLevelAgreement.calculateDurationInMSToRespondToABug(workRecord);
        Test.stopTest();
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToABug, 
                            'The method calculateDurationInMSToRespondToABug does not compute correctly.'
                            );
    }
    /**
     *
     * Tests if addingDurationInMSToCorrectBug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testAddingDurationInMSToCorrectBug(){
        Long expectedDuration = long.valueOf('214200000');
        String nameOfRecording = 'tsis na bit izh';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        Long realDurationToRespondToABug = (Long)UTIL_ServiceLevelAgreement.addingDurationInMSToCorrectBug(workRecord);
        Test.stopTest();
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToABug, 
                            'method addingDurationInMSToCorrectBug - The adition of the 7 fields : Duration_MS_Status_DEV_IP__c, Duration_MS_Status_DEV_TBT__c , Duration_MS_Status_DEV_TBD_UAT__c , '+
                            'Duration_MS_Status_UAT_To_Fix__c, Duration_MS_Status_UAT_TBD_PROD__c , Duration_MS_Status_PROD_To_Fix__c ,'+
                            ' and Duration_MS_Status_Validated_TBD__c, is not correct.'
                            );
    }
    /**
     *
     * Tests if calculateDurationInMSToCorrectABug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testCalculateDurationInMSToCorrectBug1ValueFiled(){
        Long expectedDuration = long.valueOf('7200000');
        String nameOfRecording = 'feng mi';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        Long realDurationToRespondToABug = (Long)UTIL_ServiceLevelAgreement.calculateDurationInMSToCorrectABug(workRecord);
        Test.stopTest();
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToABug, 
                            'The method calculateDurationInMSToCorrectABug does not calculate correctly.'
                            );
    }
        /**
     *
     * Tests if calculateDurationInMSToCorrectABug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testCalculateDurationInMSToCorrectBug2ValueFiled(){
        Long expectedDuration = long.valueOf('91800000');
        String nameOfRecording = 'honing';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        Long realDurationToRespondToABug = (Long)UTIL_ServiceLevelAgreement.calculateDurationInMSToCorrectABug(workRecord);
        Test.stopTest();
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToABug, 
                            'The method calculateDurationInMSToCorrectABug does not calculate correctly, adding Duration_MS_Status_DEV_IP__c and Duration_MS_Status_DEV_TBT__c'+
                            ' to Duration_MS_Status_DEV_TBD_UAT__c.'
                            );
    }
    /**
     *
     * Tests if calculateDurationInMSToCorrectABug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testCalculateDurationInMSToCorrectABugWhen4ValuesFilled(){
        Long expectedDuration = long.valueOf('122400000');
        String nameOfRecording = 'mel';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        Long realDurationToRespondToABug = (Long)UTIL_ServiceLevelAgreement.calculateDurationInMSToCorrectABug(workRecord);
        Test.stopTest();
        System.debug('test 4 -> '+workRecord.Duration_MS_Status_DEV_IP__c);
        System.debug('test 4 -> '+workRecord.Duration_MS_Status_DEV_TBT__c);
        System.debug('test 4 -> '+workRecord.Duration_MS_Status_DEV_TBD_UAT__c);
        System.debug('test 4 -> '+workRecord.Duration_MS_Status_UAT_To_Fix__c);
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToABug, 
                            'The method calculateDurationInMSToCorrectABug does not calculate correctly, when adding 4 values : Duration_MS_Status_DEV_IP__c, Duration_MS_Status_DEV_TBT__c , Duration_MS_Status_DEV_TBD_UAT__c , '+
                            'Duration_MS_Status_UAT_To_Fix__c.'
                            );
    }
    /**
     *
     * Tests if calculateDurationInMSToCorrectABug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testCalculateDurationInMSToCorrectABugWhen5ValuesFilled(){
        Long expectedDuration = long.valueOf('153000000');
        String nameOfRecording = 'miere';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        Long realDurationToRespondToABug = (Long)UTIL_ServiceLevelAgreement.calculateDurationInMSToCorrectABug(workRecord);
        Test.stopTest();
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToABug, 
                            'The method calculateDurationInMSToCorrectABug does not calculate correctly, when adding 5 values : Duration_MS_Status_DEV_IP__c, Duration_MS_Status_DEV_TBT__c , Duration_MS_Status_DEV_TBD_UAT__c , '+
                            'Duration_MS_Status_UAT_To_Fix__c, Duration_MS_Status_UAT_TBD_PROD__c.'
                            );
    }
    /**
     *
     * Tests if calculateDurationInMSToCorrectABug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testCalculateDurationInMSToCorrectABugWhen6ValuesFilled(){
        Long expectedDuration = long.valueOf('183600000');
        String nameOfRecording = 'kkul';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        Long realDurationToRespondToABug = (Long)UTIL_ServiceLevelAgreement.calculateDurationInMSToCorrectABug(workRecord);
        Test.stopTest();
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToABug, 
                            'The method calculateDurationInMSToCorrectABug does not calculate correctly, when adding 6 values : Duration_MS_Status_DEV_IP__c, Duration_MS_Status_DEV_TBT__c , Duration_MS_Status_DEV_TBD_UAT__c , '+
                            'Duration_MS_Status_UAT_To_Fix__c, Duration_MS_Status_UAT_TBD_PROD__c, Duration_MS_Status_PROD_To_Fix__c.'
                            );
    }
    /**
     *
     * Tests if calculateDurationInMSToCorrectABug(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testCalculateDurationInMSToCorrectABugWhen7ValuesFilled(){
        Long expectedDuration = long.valueOf('214200000');
        String nameOfRecording = 'tsis na bit izh';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        Long realDurationToRespondToABug = (Long)UTIL_ServiceLevelAgreement.calculateDurationInMSToCorrectABug(workRecord);
        Test.stopTest();
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToABug, 
                            'The method calculateDurationInMSToCorrectABug does not calculate correctly, when adding 7 values : Duration_MS_Status_DEV_IP__c, Duration_MS_Status_DEV_TBT__c , Duration_MS_Status_DEV_TBD_UAT__c , '+
                            'Duration_MS_Status_UAT_To_Fix__c, Duration_MS_Status_UAT_TBD_PROD__c, Duration_MS_Status_PROD_To_Fix__c,'+
                            ' and Duration_MS_Status_Validated_TBD__c.'
                            );
    }
    /**
     *
     * Tests if addingDurationInMSToRespondToAUS(agf__ADM_Work__c workRecord)
     * 
     */
    @isTest
    static void testAddingDurationInMSToRespondToAUS(){
        Long expectedDuration = 61200000;
        String nameOfRecording = 'honung';
        agf__ADM_Work__c workRecord = getWorkRecordWithSubjectName(nameOfRecording);
        Test.startTest();
        Long realDurationToRespondToAUS = (Long)UTIL_ServiceLevelAgreement.addingDurationInMSToRespondToAUS(workRecord);
        Test.stopTest();
        System.assertEquals(expectedDuration, 
                            realDurationToRespondToAUS, 
                            'The adition of the two fields : Duration_MS_Status_New__c, Duration_MS_Status_OK_For_DEV__c and Duration_MS_Status_Workload_DONE__c.'
                            );
    }
    //------------------------------------------------------TEST BOOLEAN STATIC METHODS -----------------------------------------------
    
}
