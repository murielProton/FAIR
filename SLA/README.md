# What was this project for ?
This project was developped to meet functionnal needs on Service Level Agreements. It highlights the time a ticket takes to pass from one status to an other. It is a Salesforce project based on the sObject agf__ADM_Work__c.

## Durations || Length of Time || period

As you probably know, Apex does not have the variable type Duration yet. The project uses long. There you'd think it's a simple minus application. But no, because this project also takes into account Business Hours and Holidays !
Apex permits calculation of a lengths of time within Business Hours. No native method in Apex to calculate durations without Holidays. 
In this project you'll find several methods to calculate periods of time within Business Hours and exluding Holidays. You'll find this sort of methods within the class  UTIL_Duration. The method calculateDurationInfMS() calculates a lenght of time within Business Hours and without Holidays, using a constructor.
All calculations are done with milliseconds, using type long.

## Service Level Agreement || SLA

Every structure needs to monitor the lives of tickets. Modis has it's own SLA. The class UTIL_ServiceLevelAgreement deals with this type of data.

## Package Salesforce Agile Accelerator 1.158

The master beam of this project is the package Agile Accelerator. All the developpement has it's roots on the sObjcet agf__ADM_Work__c, which is a component of this package. You'll find informations on how to install this projects int the documentation-sObject-agf_work__c.html file.

## Business Hours and Holidays

Business Hours and Holidays are special native Salesforce sObjects. 
You can learn more on Business Hours : https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_classes_businesshours.htm.
If you are interested in the sObject Holidays : https://developer.salesforce.com/docs/atlas.en-us.object_reference.meta/object_reference/sforce_api_objects_holiday.htm.
This project has helping informations on both matters :
- documentation-business_hours.html
- documentation-holidays.html
