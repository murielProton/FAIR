/** *******************************************************************************
 * @Author : Muriel Proton
 * @Company : Modis
 * This interface holds the code witch set how a Trigger will act.
 * This class is used by all triggers
 * @Interface : 
 * @Constructor : 
 * @Parametters : 
 ******************************************************************************* */
public abstract class I_TriggerHandler{
    // this methode sets the conditions of triggers.
    public virtual void run() {
        if(Trigger.isInsert && Trigger.isBefore){
            beforeInsert();
        }
        if(Trigger.isUpdate && Trigger.isBefore){
            beforeUpdate();
        }
    }
    // List of all of the 8 methods used by triggers in general.
    // they are abstract and have no body. Their body will be define in TH_*Sobject*Trigger.
    public abstract void beforeInsert() ;
    public abstract void beforeUpdate() ;
   
}
