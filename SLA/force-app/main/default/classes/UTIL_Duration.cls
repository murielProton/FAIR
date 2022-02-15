public with sharing class UTIL_Duration {
    DateTime startDateTime;
    DateTime endDateTime;
    public UTIL_Duration(DateTime startDateTime, DateTime endDateTime) {
        this.startDateTime = startDateTime;
        this.endDateTime = endDateTime;
    }
    public Decimal calculateTimeInMS(){
        Decimal longStartDateTime = startDateTime.getTime();
        Decimal longEndDateTime = endDateTime.getTime();
        Decimal durationMS = longEndDateTime - longStartDateTime;
        return durationMS;
    }
}
