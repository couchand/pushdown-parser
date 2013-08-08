@isTest
global class ListStreamTest
{
    private static testMethod void testEmptyStream()
    {
        assertTokenizes(
            new List<String>{}
        );
    }

    private static testMethod void testIdentifier()
    {
        assertTokenizes(
            new List<String>{ 'foobar' }
        );
    }

    private static testMethod void testMultipleNestedFunctionParameters()
    {
        assertTokenizes(
            new List<String>{ 'foo', '(', 'bar', '(', 'a', ',', 'b', ')', ',', 'baz', '(', 'c', ',', 'd', ')', ')' }
        );
    }

    global static void assertTokenizes( List<String> expectedTokens )
    {
        Test.startTest();

            ListStream testTokenizer = new ListStream( expectedTokens );

        Test.stopTest();

        for ( String expectedToken : expectedTokens )
        {
            System.assert( !testTokenizer.isDone(),
                'Not enough tokens found' );
            System.assertEquals( expectedToken, testTokenizer.getToken(),
                'Wrong token found' );
        }

        System.assert( testTokenizer.isDone(),
            'Too many tokens found' );
    }
}
