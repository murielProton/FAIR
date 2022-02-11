/** *******************************************************************************
 * @Author : Kevin O'Hara
 * @Company : 
 * Adapted and commented by Muriel Proton from Modis
 * This class tests the folowing classe(s) : I_TriggerHandler
 * This class is used in class : 
 * @Interface : I_TriggerHandler
 * @Setup method : from line 14 to 25 
 * @Setup class and inner class : TestHandler
 * 
 ******************************************************************************* */
@isTest
private class I_TriggerHandler_Test {

  private static final String TRIGGER_CONTEXT_ERROR = 'Trigger handler called outside of Trigger execution';

  private static String lastMethodCalled;

  private static I_TriggerHandler_Test.TestHandler handler;

  static {
    handler = new I_TriggerHandler_Test.TestHandler();
    // override its internal trigger detection
    handler.isTriggerExecuting = true;
  }

  /*********************************************************************************************************
   * unit tests
   ********************************************************************************************************/

  //The folowing methodes check the context.---------------------------------------------------------------

  // 
  /**
  * This method cheks that the last method called was beforeInsertMode(), when beforeInsertMode() is called.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  static void testBeforeInsert() {
    beforeInsertMode();
    handler.run();
    System.assertEquals('beforeInsert', lastMethodCalled, 'last method should be beforeInsert');
  }

  /**
  * This method cheks that the last method called was beforeUpdate(), when beforeUpdateMode() is called.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  static void testBeforeUpdate() {
    beforeUpdateMode();
    handler.run();
    System.assertEquals('beforeUpdate', lastMethodCalled, 'last method should be beforeUpdate');
  }

  /**
  * This method cheks that the last method called was beforeDelete(), when beforeDeleteMode() is called.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  static void testBeforeDelete() {
    beforeDeleteMode();
    handler.run();
    System.assertEquals('beforeDelete', lastMethodCalled, 'last method should be beforeDelete');
  }

  /**
  * This method cheks that the last method called was afterInsert(), when afterInsertMode() is called.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  static void testAfterInsert() {
    afterInsertMode();
    handler.run();
    System.assertEquals('afterInsert', lastMethodCalled, 'last method should be afterInsert');
  }

  /**
  * This method cheks that the last method called was afterUpdate(), when afterUpdateMode() is called.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  static void testAfterUpdate() {
    afterUpdateMode();
    handler.run();
    System.assertEquals('afterUpdate', lastMethodCalled, 'last method should be afterUpdate');
  }

  /**
  * This method cheks that the last method called was afterDelete(), when afterDeleteMode() is called.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  static void testAfterDelete() {
    afterDeleteMode();
    handler.run();
    System.assertEquals('afterDelete', lastMethodCalled, 'last method should be afterDelete');
  }

  /**
  * This method cheks that the last method called was afterUndelete(), when afterUndeleteMode() is called.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  static void testAfterUndelete() {
    afterUndeleteMode();
    handler.run();
    System.assertEquals('afterUndelete', lastMethodCalled, 'last method should be afterUndelete');
  }
  /**
  * This method cheks if the exception was properly thrown.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest 
  static void testNonTriggerContext() {
    try{
      handler.run();
      // check if the exception was thrown.
      System.assert(false, 'the handler ran but should have thrown');
    } catch(I_TriggerHandler.I_TriggerHandlerException te) {
      //check for the right message.
      System.assertEquals(TRIGGER_CONTEXT_ERROR, te.getMessage(), 'the exception message should match');
    } catch(Exception e) {
      // if it was not the expected message please throw an exception.
      System.assert(false, 'the exception thrown was not expected: ' + e.getTypeName() + ': ' + e.getMessage());
    }
  }

  // The folowing methodes test bypass api---------------------------------------------------------------------------
  /**
  * 
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  static void testBypassAPI() {
    afterUpdateMode();
    // test a bypass and run handler
    I_TriggerHandler.bypass('TestHandler');
    handler.run();
    System.assertEquals(null, lastMethodCalled, 'last method should be null when bypassed');
    System.assertEquals(true, I_TriggerHandler.isBypassed('TestHandler'), 'test handler should be bypassed');
    resetTest();

    // clear that bypass and run handler
    I_TriggerHandler.clearBypass('TestHandler');
    handler.run();
    System.assertEquals('afterUpdate', lastMethodCalled, 'last method called should be afterUpdate');
    System.assertEquals(false, I_TriggerHandler.isBypassed('TestHandler'), 'test handler should be bypassed');
    resetTest();

    // test a re-bypass and run handler
    I_TriggerHandler.bypass('TestHandler');
    handler.run();
    System.assertEquals(null, lastMethodCalled, 'last method should be null when bypassed');
    System.assertEquals(true, I_TriggerHandler.isBypassed('TestHandler'), 'test handler should be bypassed');
    resetTest();

    // clear all bypasses and run handler
    I_TriggerHandler.clearAllBypasses();
    handler.run();
    System.assertEquals('afterUpdate', lastMethodCalled, 'last method called should be afterUpdate');
    System.assertEquals(false, I_TriggerHandler.isBypassed('TestHandler'), 'test handler should be bypassed');
    resetTest();
  }

  // instance method tests-----------------------------------------------------------------------------------
  /**
  * Tests if LoopCount is working correctly.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  static void testLoopCount() {
    beforeInsertMode();
    
    // set the max loops to 2
    handler.setMaxLoopCount(2);

    // run the handler twice
    handler.run();
    handler.run();

    // clear the tests
    resetTest();

    try {
      // try running it. This should exceed the limit.
      handler.run();
      System.assert(false, 'the handler should throw on the 3rd run when maxloopcount is 3');
    } catch(I_TriggerHandler.I_TriggerHandlerException te) {
      // we're expecting to get here
      System.assertEquals(null, lastMethodCalled, 'last method should be null');
    } catch(Exception e) {  
      System.assert(false, 'the exception thrown was not expected: ' + e.getTypeName() + ': ' + e.getMessage());
    }

    // clear the tests
    resetTest();

    // now clear the loop count
    handler.clearMaxLoopCount();

    try {
      // re-run the handler. We shouldn't throw now.
      handler.run();
      System.assertEquals('beforeInsert', lastMethodCalled, 'last method should be beforeInsert');
    } catch(I_TriggerHandler.I_TriggerHandlerException te) {
      System.assert(false, 'running the handler after clearing the loop count should not throw');
    } catch(Exception e) {  
      System.assert(false, 'the exception thrown was not expected: ' + e.getTypeName() + ': ' + e.getMessage());
    }
  }
  /**
  * Tests if LoopCount is working correctly.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest
  static void testLoopCountClass() {
    I_TriggerHandler.LoopCount lc = new I_TriggerHandler.LoopCount();
    System.assertEquals(5, lc.getMax(), 'max should be five on init');
    System.assertEquals(0, lc.getCount(), 'count should be zero on init');

    lc.increment();
    System.assertEquals(1, lc.getCount(), 'count should be 1');
    System.assertEquals(false, lc.exceeded(), 'should not be exceeded with count of 1');

    lc.increment();
    lc.increment();
    lc.increment();
    lc.increment();
    System.assertEquals(5, lc.getCount(), 'count should be 5');
    System.assertEquals(false, lc.exceeded(), 'should not be exceeded with count of 5');

    lc.increment();
    System.assertEquals(6, lc.getCount(), 'count should be 6');
    System.assertEquals(true, lc.exceeded(), 'should not be exceeded with count of 6');
  }

  /**
  * Tests if getHandlerName() returns the right name.
  * Called by :
  * @Parametters : None
  * @Returns : VOID
  */
  @isTest 
  static void testGetHandlerName() {
    System.assertEquals('TestHandler', handler.getHandlerName(), 'handler name should match class name');
  }

  // This test methode fails the sfdx command : deploy this source to org.
  // Abract classes cannot be constructed:I_TriggerHandler(195:26)
  
 /*@isTest
  static void testVirtualMethods() {
    I_TriggerHandler h = new I_TriggerHandler();
    h.beforeInsert();
    h.beforeUpdate();
    h.beforeDelete();
    h.afterInsert();
    h.afterUpdate();
    h.afterDelete();
    h.afterUndelete();
  }*/

  /*********************************************************************************************************
   * testing utilities - To use only within this class
   *********************************************************************************************************/
  /**
  * ressets the variable lastMethodCalled.
  * In this class called by : testLoopCount(), testBypassAPI(),
  * @Parametters : None
  * @Returns : VOID
  */
  private static void resetTest() {
    lastMethodCalled = null;
  }

  /**
  * ensures the test to be in context before insert.
  * In this class called by : testBeforeInsert()
  * @Parametters : None
  * @Returns : VOID
  */
  private static void beforeInsertMode() {
    handler.setTriggerContext('before insert', true);
  }
  /**
  * ensures the test to be in context before update.
  * In this class called by : testBeforeUpdate()
  * @Parametters : None
  * @Returns : VOID
  */
  private static void beforeUpdateMode() {
    handler.setTriggerContext('before update', true);
  }
  /**
  * ensures the test to be in context before delete.
  * In this class called by : testBeforeDelete()
  * @Parametters : None
  * @Returns : VOID
  */
  private static void beforeDeleteMode() {
    handler.setTriggerContext('before delete', true);
  }
  /**
  * ensures the test to be in context after insert.
  * In this class called by : testAfterInsert()
  * @Parametters : None
  * @Returns : VOID
  */
  private static void afterInsertMode() {
    handler.setTriggerContext('after insert', true);
  }
  /**
  * ensures the test to be in context after update.
  * In this class called by : testAfterUpdate()
  * @Parametters : None
  * @Returns : VOID
  */
  private static void afterUpdateMode() {
    handler.setTriggerContext('after update', true);
  }
  /**
  * ensures the test to be in context after delete.
  * In this class called by : testAfterDelete()
  * @Parametters : None
  * @Returns : VOID
  */
  private static void afterDeleteMode() {
    handler.setTriggerContext('after delete', true);
  }
  /**
  * ensures the test to be in context after undelete.
  * In this class called by : testAfterUndelete()
  * @Parametters : None
  * @Returns : VOID
  */
  private static void afterUndeleteMode() {
    handler.setTriggerContext('after undelete', true);
  }

  /**
  * test implementation of the I_TriggerHandler, this is a setup methode for the tests.
  * In this class called by : testAfterUndelete()
  * @Parametters : None
  * @Returns : VOID
  */
  private class TestHandler extends I_TriggerHandler {

    public override void beforeInsert() {
      I_TriggerHandler_Test.lastMethodCalled = 'beforeInsert';
    }

    public override void  beforeUpdate() {
      I_TriggerHandler_Test.lastMethodCalled = 'beforeUpdate';
    }

    public override void beforeDelete() {
      I_TriggerHandler_Test.lastMethodCalled = 'beforeDelete';
    }

    public override void afterInsert() {
      I_TriggerHandler_Test.lastMethodCalled = 'afterInsert';
    }

    public override void afterUpdate() {
      I_TriggerHandler_Test.lastMethodCalled = 'afterUpdate';
    }

    public override void afterDelete() {
      I_TriggerHandler_Test.lastMethodCalled = 'afterDelete';
    }

    public override void afterUndelete() {
      I_TriggerHandler_Test.lastMethodCalled = 'afterUndelete';
    }

  }
	
}