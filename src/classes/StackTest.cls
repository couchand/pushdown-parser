@isTest
global class StackTest
{
    private static testMethod void testSize_Empty()
    {
        Stack testStack = new Stack();

        Test.startTest();

            Integer size = testStack.size();
            Boolean isEmpty = testStack.isEmpty();

        Test.stopTest();

        System.assertEquals( 0, size,
            'When the stack is empty the size should be zero' );
        System.assert( isEmpty,
            'The stack should recognize the empty state' );
    }

    private static testMethod void testSize_NonEmpty()
    {
        Stack testStack = new Stack( new List<Integer>{ 1, 2, 3, 4, 5 } );

        Test.startTest();

            Integer size = testStack.size();
            Boolean isEmpty = testStack.isEmpty();

        Test.stopTest();

        System.assertEquals( 5, size,
            'When the stack is non-empty the size should be the number of elements' );
        System.assertEquals( false, isEmpty,
            'The stack should recognize the non-empty state' );
    }

    private static testMethod void testPeek()
    {
        Stack testStack = new Stack( new List<Integer>{ 1, 2, 3, 4, 5 } );

        Test.startTest();

            Integer topElement = (Integer)testStack.peek();

        Test.stopTest();

        System.assertEquals( 5, topElement,
            'Peek should return the top element of the stack' );
    }

//  private static testMethod void testPeek_Empty

    private static testMethod void testPush()
    {
        Stack testStack = new Stack();

        Test.startTest();

            testStack.push( 1 );

        Test.stopTest();

        System.assertEquals( 1, testStack.size(),
            'Pushing an element should add one to the stack size' );
        System.assertEquals( 1, testStack.peek(),
            'The element pushed should be on top of the stack' );
    }

    private static testMethod void testPop()
    {
        Stack testStack = new Stack( new List<Integer>{ 42 } );

        Test.startTest();

            Integer poppedElement = (Integer)testStack.pop();

        Test.stopTest();

        System.assertEquals( 42, poppedElement,
            'The popped element should be returned' );
        System.assertEquals( 0, testStack.size(),
            'The popped element should be removed from the stack' );
    }

//  private static testMethod void testPop_Empty
}
