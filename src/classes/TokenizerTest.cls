@isTest
global class TokenizerTest
{
    private static testMethod void testEmptyString()
    {
        assertTokenizes(
            '',
            new List<String>{}
        );
    }

    private static testMethod void testIdentifier()
    {
        assertTokenizes(
            'foobar',
            new List<String>{ 'foobar' }
        );
    }

    private static testMethod void testFunctionCall()
    {
        assertTokenizes(
            'foo()',
            new List<String>{ 'foo', '(', ')' }
        );
    }

    private static testMethod void testFunctionParameter()
    {
        assertTokenizes(
            'foo(bar)',
            new List<String>{ 'foo', '(', 'bar', ')' }
        );
    }

    private static testMethod void testFunctionParameters()
    {
        assertTokenizes(
            'foo(bar,baz)',
            new List<String>{ 'foo', '(', 'bar', ',', 'baz', ')' }
        );
    }

    private static testMethod void testNestedFunctionCall()
    {
        assertTokenizes(
            'foo(bar())',
            new List<String>{ 'foo', '(', 'bar', '(', ')', ')' }
        );
    }

    private static testMethod void testNestedFunctionParameters()
    {
        assertTokenizes(
            'foo(bar(baz,boom))',
            new List<String>{ 'foo', '(', 'bar', '(', 'baz', ',', 'boom', ')', ')' }
        );
    }

    private static testMethod void testNestedFunctionCalls()
    {
        assertTokenizes(
            'foo(bar(),baz())',
            new List<String>{ 'foo', '(', 'bar', '(', ')', ',', 'baz', '(', ')', ')' }
        );
    }

    private static testMethod void testMultipleNestedFunctionParameters()
    {
        assertTokenizes(
            'foo(bar(a,b),baz(c,d))',
            new List<String>{ 'foo', '(', 'bar', '(', 'a', ',', 'b', ')', ',', 'baz', '(', 'c', ',', 'd', ')', ')' }
        );
    }

    private static testMethod void testIgnoreSpace()
    {
        assertTokenizes(
            ' foo (\n\tbar  (  a ,  b  )  ,\n\tbaz ( c ,  d )\n)  ',
            new List<String>{ 'foo', '(', 'bar', '(', 'a', ',', 'b', ')', ',', 'baz', '(', 'c', ',', 'd', ')', ')' }
        );
    }

    global static void assertTokenizes( String input, List<String> expectedTokens )
    {
        Test.startTest();

            Tokenizer testTokenizer = new Tokenizer( input );

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
