public abstract class I_TriggerHandler{
    public virtual void run() {
        if(Trigger.isInsert && Trigger.isBefore){
            beforeInsert();
        }
        if(Trigger.isUpdate && Trigger.isBefore){
            beforeUpdate();
        }
    }
    public abstract void beforeInsert() ;
    public abstract void beforeUpdate() ;
   
}
