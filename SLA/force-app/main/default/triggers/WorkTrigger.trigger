trigger WorkTrigger on agf__ADM_Work__c (after insert) {
    new TH_WorkTrigger().run();
}