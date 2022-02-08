trigger WorkTrigger on agf__ADM_Work__c (before insert, before update) {
    new TH_WorkTrigger().run();
}