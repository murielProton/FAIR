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
                                      agf__Status__c,
                                      agf__Created_On_Date__c, 
                                      Date_Status_New_Starts__c
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
        DateTime dateTimeRandom = DateTime.newInstance(2022, 4, 1, 10, 8, 16);
        // Make sure the two DatTime are the same
        // convert DateTime into String in a specified format to ensure they are equal.
        String dateToSet = dateTimeRandom.format('yyyy/MM/dd hh:mm');
        // creating a record on sObject agf__ADM_Work__c Status New
        agf__ADM_Work__c workRecordNewHoney = new agf__ADM_Work__c(
            RecordTypeId = recordTypeIdBug,
            agf__Subject__c = 'honey',
            agf__Status__c = 'New',
            Date_Status_New_Starts__c = dateTimeRandom,
            agf__Product_Tag__c = productTagRecord.Id,
            agf__Found_in_Build__c = buildRecord.Id,
            agf__Priority__c = 'P0'
        );
        // creating a list of records on sObject agf__ADM_Work__c
        List<agf__ADM_Work__c> workRecordsList= new List<agf__ADM_Work__c>();
        workRecordsList.add(workRecordNewHoney);
        try{
            //Insert a list of record
            insert workRecordsList;
        }catch (ListException e){
            System.debug('In tests run on UTIL_ServiceLevelAgreement, the list of records on the sObject Work was not inserted. ref : workRecordsList');
        }
    }
    /**
     *
     * Tests if getDateStatusNewStarts(String subjectOnWork) returns the right date 
     */
    @isTest
    static void testIfGetDateStatusNewStartsReturnsTheRightDate() {
        String nameOfRecording = 'honey';
        // set a DateTime a date (yyyy, m, d, h, min, sec)
        DateTime dateTimeToFormat = DateTime.newInstance(2022, 4, 1, 10, 8, 16);
        // convert DateTime into String in a specified format to ensure they are equal.
        String expectedDateTime = dateTimeToFormat.format('yyyy/MM/dd hh:mm');
        Test.startTest();
        DateTime realTimeToSetToString = UTIL_ServiceLevelAgreement.getDateStatusNewStarts(nameOfRecording);
        String realTimeToTest = realTimeToSetToString.format('yyyy/MM/dd hh:mm');
        Test.stopTest();
        // check if date equals Date_Status__Starts__c
        System.assertEquals(expectedDateTime, 
                            realTimeToTest, 
                            'On the sObject Work the field Date_Status_New_Starts__c could not be retrieved correctly.'
                            );

    }
}
