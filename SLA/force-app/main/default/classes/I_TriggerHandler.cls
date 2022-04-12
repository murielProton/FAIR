/** *******************************************************************************
 * @Author : Kevin O'Hara
 * @Company : 
 * Adapted and commented by Muriel Proton from Modis
 * This interface holds the code witch set how a Trigger will act.
 * This class is used by all triggers
 * @Overiden by : TH_WorkTrigger
 * @Interface : 
 * @Constructor : I_TriggerHandler()
 * @Parametters :
 * @Inner class : LoopCount
 * @Exception class : I_TriggerHandlerException (native interface Exception)
 * Setup for test class : TriggerContext
 * Version : 2022 04 12
 ******************************************************************************* */
public abstract class I_TriggerHandler{

    // static map of handlername, times run() was invoked
    private static Map<String, LoopCount> loopCountMap;
    private static Set<String> bypassedHandlers;
  
    // the current context of the trigger, overridable in tests
    @TestVisible
    private TriggerContext context;
  
    // the current context of the trigger, overridable in tests
    @TestVisible
    private Boolean isTriggerExecuting;
  
    // static initialization
    static {
      loopCountMap = new Map<String, LoopCount>();
      bypassedHandlers = new Set<String>();
    }

    /**
     * This is the CONSTRUCTOR method.
     * Called by : 
     * @Parametters : None
     * @Returns : the context of the trigger.
     */
    public I_TriggerHandler() {
      this.setTriggerContext();
    }
  
    /***************************************
     * public instance methods
     ***************************************/
  
    /**
     * This is the main method.
     * Called by : WorkTrigger
     * @Parametters : None
     * @Returns : the context of the trigger.
     */
    public void run() {
  
      if(!validateRun()) {
        return;
      }
  
      addToLoopCount();
  
      // dispatch to the correct handler method
      switch on this.context {
        when BEFORE_INSERT {
          this.beforeInsert();
        }
        when BEFORE_UPDATE {
          this.beforeUpdate();
        }
        when BEFORE_DELETE {
          this.beforeDelete();
        }
        when AFTER_INSERT {
          this.afterInsert();
        }
        when AFTER_UPDATE {
          this.afterUpdate();
        }
        when AFTER_DELETE {
          this.afterDelete();
        }
        when AFTER_UNDELETE {
          this.afterUndelete();
        }
      }
    }
    /**
     * This method sets the maximum of times a Trigger can enter a loop.
     * Called by : 
     * @Parametters : Integer
     * @Returns : Void
     */
    public void setMaxLoopCount(Integer max) {
      String handlerName = getHandlerName();
      if(!I_TriggerHandler.loopCountMap.containsKey(handlerName)) {
        I_TriggerHandler.loopCountMap.put(handlerName, new LoopCount(max));
      } else {
        I_TriggerHandler.loopCountMap.get(handlerName).setMax(max);
      }
    }
        /**
     * This method resets the maximum of times a Trigger can enter a loop.
     * Called by : 
     * @Parametters : None
     * @Returns : Void
     */
    public void clearMaxLoopCount() {
      this.setMaxLoopCount(-1);
    }
  
    /***************************************
     * public static methods
     ***************************************/
    //bypass methods
        /**
     * This method .
     * Called by : 
     * @Parametters : None
     * @Returns : Void
     */
    public static void bypass(String handlerName) {
      I_TriggerHandler.bypassedHandlers.add(handlerName);
    }
      /**
     * This method .
     * Called by : 
     * @Parametters : None
     * @Returns : Void
     */
    public static void clearBypass(String handlerName) {
      I_TriggerHandler.bypassedHandlers.remove(handlerName);
    }
      /**
     * This method .
     * Called by : 
     * @Parametters : None
     * @Returns : Void
     */
    public static Boolean isBypassed(String handlerName) {
      return I_TriggerHandler.bypassedHandlers.contains(handlerName);
    }
    /**
     * This method .
     * Called by : 
     * @Parametters : None
     * @Returns : Void
     */
    public static void clearAllBypasses() {
      I_TriggerHandler.bypassedHandlers.clear();
    }
  
    /***************************************
     * TESTS METHODS ! private instancemethods
     ***************************************/
    /**
     * This method setup the test methode. It sets trigger context.
     * Called by : 
     * @Parametters : Integer
     * @Returns : Void
     */
    @TestVisible
    private void setTriggerContext() {
      this.setTriggerContext(null, false);
    }
      /**
     * This method setup trigger context of the test methode. It sets trigger context.
     * Called by : 
     * @Parametters : String, Boolean
     * @Returns : Void
     */
    @TestVisible
    private void setTriggerContext(String ctx, Boolean testMode) {
      if(!Trigger.isExecuting && !testMode) {
        this.isTriggerExecuting = false;
        return;
      } else {
        this.isTriggerExecuting = true;
      }
      
      if((Trigger.isExecuting && Trigger.isBefore && Trigger.isInsert) ||
          (ctx != null && ctx == 'before insert')) {
        this.context = TriggerContext.BEFORE_INSERT;
      } else if((Trigger.isExecuting && Trigger.isBefore && Trigger.isUpdate) ||
          (ctx != null && ctx == 'before update')){
        this.context = TriggerContext.BEFORE_UPDATE;
      } else if((Trigger.isExecuting && Trigger.isBefore && Trigger.isDelete) ||
          (ctx != null && ctx == 'before delete')) {
        this.context = TriggerContext.BEFORE_DELETE;
      } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isInsert) ||
          (ctx != null && ctx == 'after insert')) {
        this.context = TriggerContext.AFTER_INSERT;
      } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isUpdate) ||
          (ctx != null && ctx == 'after update')) {
        this.context = TriggerContext.AFTER_UPDATE;
      } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isDelete) ||
          (ctx != null && ctx == 'after delete')) {
        this.context = TriggerContext.AFTER_DELETE;
      } else if((Trigger.isExecuting && Trigger.isAfter && Trigger.isUndelete) ||
          (ctx != null && ctx == 'after undelete')) {
        this.context = TriggerContext.AFTER_UNDELETE;
      }
    }
  
    /**
     * This method increments the loop count.
     * Called by : 
     * @Parametters : String, Boolean
     * @Returns : Void
     */
    @TestVisible
    private void addToLoopCount() {
      String handlerName = getHandlerName();
      if(I_TriggerHandler.loopCountMap.containsKey(handlerName)) {
        Boolean exceeded = I_TriggerHandler.loopCountMap.get(handlerName).increment();
        if(exceeded) {
          Integer max = I_TriggerHandler.loopCountMap.get(handlerName).max;
          throw new I_TriggerHandlerException('Maximum loop count of ' + String.valueOf(max) + ' reached in ' + handlerName);
        }
      }
    }
  
    /**
     * This method makes sure this trigger should continue to run.
     * Called by : 
     * @Parametters :
     * @Returns : Void
     */
    @TestVisible
    private Boolean validateRun() {
      if(!this.isTriggerExecuting || this.context == null) {
        throw new I_TriggerHandlerException('Trigger handler called outside of Trigger execution');
      }
      return !I_TriggerHandler.bypassedHandlers.contains(getHandlerName());
    }
      /**
     * This method returns the name of the handler.
     * Called by : 
     * @Parametters :
     * @Returns : Void
     */
    @TestVisible
    private String getHandlerName() {
      return String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
    }
  
    /***************************************
     * context methods
     ***************************************/
  
    // context-specific methods for override
    @TestVisible
    protected virtual void beforeInsert(){}
    @TestVisible
    protected virtual void beforeUpdate(){}
    @TestVisible
    protected virtual void beforeDelete(){}
    @TestVisible
    protected virtual void afterInsert(){}
    @TestVisible
    protected virtual void afterUpdate(){}
    @TestVisible
    protected virtual void afterDelete(){}
    @TestVisible
    protected virtual void afterUndelete(){}
  
    /***************************************
     * inner classes
     ***************************************/
  
    /**
     * This inner class detains all methodes conserning LoopCounts.
     * Called by : 
     * @Interface : 
     * @Constructor :LoopCount() 
     * @Parametters :
     *
     */
    @TestVisible
    private class LoopCount {
      private Integer max;
      private Integer count;
        /**
     * CONSTRUCTOR
     * Called by : 
     * @Parametters :
     * @Returns : Void
     */
      public LoopCount() {
        this.max = 5;
        this.count = 0;
      }
  
      public LoopCount(Integer max) {
        this.max = max;
        this.count = 0;
      }
  
      public Boolean increment() {
        this.count++;
        return this.exceeded();
      }
  
      public Boolean exceeded() {
        return this.max >= 0 && this.count > this.max;
      }
  
      public Integer getMax() {
        return this.max;
      }
  
      public Integer getCount() {
        return this.count;
      }
  
      public void setMax(Integer max) {
        this.max = max;
      }
    }
  
    /**
     * This inner class contains constants conserning context.
     * Called by : 
     * @Interface : 
     * @Constructor :
     * @Parametters :
     *
     */
    @TestVisible
    private enum TriggerContext {
      BEFORE_INSERT, BEFORE_UPDATE, BEFORE_DELETE,
      AFTER_INSERT, AFTER_UPDATE, AFTER_DELETE,
      AFTER_UNDELETE
    }
  
    /**
     * This inner Class is the exception class for this class.
     * Called by : 
     * @Interface : 
     * @Constructor :
     * @Parametters :
     *
     */
    public class I_TriggerHandlerException extends Exception {}
  
  }
