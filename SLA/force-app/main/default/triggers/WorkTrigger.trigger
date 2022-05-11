/** ***********************************************************************************************************************************
 * @Author : Muriel Proton
 * @Company : Modis
 * This trigger runs on the objetc agf__ADM_Work__c every time a reccord is inserted or updated
 * @Parametters : before insert, before update
 * @Version : 2022 04 12
 *********************************************************************************************************************************** */
trigger WorkTrigger on agf__ADM_Work__c (before insert, before update) {
    new TH_WorkTrigger().run();
}