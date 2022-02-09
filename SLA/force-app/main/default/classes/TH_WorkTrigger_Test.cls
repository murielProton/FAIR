@IsTest
public without sharing class TH_WorkTrigger_Test {
    /**
     * Before each insert a reccord in agf__ADM_Work__c.
     * setup method
     */
    @testSetup
    static void setup() {
        // creating a reccord of agf__ADM_Scrum_Team__c before creating a agf__ADM_Product_Tag__c is mandatory
        List<agf__ADM_Scrum_Team__c> teamReccordsList = new List<agf__ADM_Scrum_Team__c>();
        agf__ADM_Scrum_Team__c teamReccord = new agf__ADM_Scrum_Team__c(
            Name = 'Hive'
        );
        teamReccordsList.add(teamReccord);
        insert teamReccordsList;
        // creating a reccord of agf__ADM_Product_Tag__c before creating a agf__ADM_Work__c is mandatory
        List<agf__ADM_Product_Tag__c> productTagReccordsList = new List<agf__ADM_Product_Tag__c>();
        agf__ADM_Product_Tag__c productTagReccord = new agf__ADM_Product_Tag__c(
            Name = 'FAIR',
            agf__Team__c = teamReccord.Id
        );
        productTagReccordsList.add(productTagReccord);
        insert productTagReccordsList; 
        // creating a reccord of agf__ADM_Build__c before creating a agf__ADM_Work__c is mandatory
        List<agf__ADM_Build__c> buildReccordsList = new List<agf__ADM_Build__c>();
        agf__ADM_Build__c buildReccord = new agf__ADM_Build__c(
            Name = 'hexagonal'
        );
        buildReccordsList.add(buildReccord);
        insert buildReccordsList; 
        // to fill the field on agf__ADM_Work__c named RecordType you need a RecordType ID.
        Id recordTypeId = Schema.SObjectType.agf__ADM_Work__c.getRecordTypeInfosByName().get('Bug').getRecordTypeId();
        // creating a reccord on sObject agf__ADM_Work__c
        List<agf__ADM_Work__c> workReccordsList = new List<agf__ADM_Work__c>();
        agf__ADM_Work__c workReccord = new agf__ADM_Work__c(
            RecordTypeId = recordTypeId,
            agf__Subject__c = 'honey',
            agf__Status__c = 'New',
            agf__Product_Tag__c = productTagReccord.Id,
            agf__Found_in_Build__c = buildReccord.Id,
            agf__Priority__c = 'P0'
        );
        workReccordsList.add(workReccord);
        insert workReccordsList;        
    }
    /**
     * TODO
     * Test if Date_Status_New_Starts__c is filled with date/time now when I insert a reccord in agf__ADM_Work__c.
     */
    @isTest
    static void checkIfWorkDateStatusNewStartFilledBeforeInsert() {
        //get reccord of agf__ADM_Work__c
        agf__ADM_Work__c workReccordHoney =[ SELECT Id, agf__Created_On_Date__c, Date_Status_New_Starts__c 
                                                FROM agf__ADM_Work__c
                                                WHERE agf__Subject__c ='honey'
                                            ];
        //check if agf__Created_On_Date__c equals Date_Status_New_Starts__c
        System.assertEquals(agf__ADM_Work__c.agf__Created_On_Date__c, 
                                agf__ADM_Work__c.Date_Status_New_Starts__c, 
                                'On the sObject Work the field Date Status New Start has not been correctly filled by the Trigger.');

    }

     /**
      * TODO
     * Test if Date_Status_New_Ends__c is filled with date/time now when I update the field agf__Status__c on agf__ADM_Work__c reccord.
     */

}
