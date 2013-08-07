@isTest
global class TokenizerTest
{
    private static testMethod void testEmptyString()
    {
        Test.startTest();

            Tokenizer testTokenizer = new Tokenizer('');

        Test.stopTest();

        System.assert( testTokenizer.isDone(),
            'Empty strings should tokenize into no input' );
    }

    private static testMethod void testIdentifier()
    {
        Test.startTest();

            Tokenizer testTokenizer = new Tokenizer('Foobar');

        Test.stopTest();

        System.assertEquals( 'Foobar', testTokenizer.getToken(),
            'Identifiers should be tokenized whole' );
        System.assert( testTokenizer.isDone(),
            'Successfully tokenized identifiers should be removed from the input' );
    }

    private static testMethod void testFunctionCall()
    {
        Test.startTest();

            Tokenizer testTokenizer = new Tokenizer('baz()');

        Test.stopTest();

        System.assertEquals( 'baz', testTokenizer.getToken(),
            'Function names should be tokenized whole' );
        System.assertEquals( '(', testTokenizer.getToken(),
            'Function call parens should be tokenized individually' );
        System.assertEquals( ')', testTokenizer.getToken(),
            'Function call parens should be tokenized individually' );
        System.assert( testTokenizer.isDone(),
            'Successfully tokenized identifiers should be removed from the input' );
    }

    private static testMethod void testFunctionParameter()
    {
        Test.startTest();

            Tokenizer testTokenizer = new Tokenizer('foo(bar)');

        Test.stopTest();

        System.assertEquals( 'foo', testTokenizer.getToken(),
            'Function names should be tokenized whole' );
        System.assertEquals( '(', testTokenizer.getToken(),
            'Function call parens should be tokenized individually' );
        System.assertEquals( 'bar', testTokenizer.getToken(),
            'Function params should be tokenized whole' );
        System.assertEquals( ')', testTokenizer.getToken(),
            'Function call parens should be tokenized individually' );
        System.assert( testTokenizer.isDone(),
            'Successfully tokenized identifiers should be removed from the input' );
    }
}
