public with sharing class UTIL_Duration {
    DateTime startDateTime;
    DateTime endDateTime;
    public UTIL_Duration(DateTime startDateTime, DateTime endDateTime) {
        this.startDateTime = startDateTime;
        this.endDateTime = endDateTime;
    }
    public Long calculateTimeInMS(){
        Long longStartDateTime = startDateTime.getTime();
        Long longEndDateTime = endDateTime.getTime();
        Long durationMS = longEndDateTime - longStartDateTime;
        return durationMS;
    }
}
