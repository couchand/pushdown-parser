@isTest
global class ParserTest
{
    private static testMethod void testNoInput()
    {
        TokenStream noInput = new ListStream( new List<String>() );
        Parser testParser = new Parser( noInput );

        Exception caughtException;

        Test.startTest();

        try
        {
            testParser.parse();
        }
        catch ( Exception ex )
        {
            caughtException = ex;
        }

        Test.stopTest();

        System.assertNotEquals( null, caughtException,
            'An exception should be thrown on empty input' );
    }

    private static testMethod void testIdentifier()
    {
        TokenStream identifier = new ListStream( new List<String>{ 'foobar' } );
        Parser testParser = new Parser( identifier );

        Test.startTest();

            Object parsed = testParser.parse();

        Test.stopTest();

        System.assertEquals( 'foobar', parsed,
            'Single identifiers should be parsed correctly' );
    }

    private static testMethod void testTwoIdentifiers()
    {
        TokenStream twoIdentifiers = new ListStream( new List<String>{ 'foo', 'bar' } );
        Parser testParser = new Parser( twoIdentifiers );

        Exception caughtException;

        Test.startTest();

        try
        {
            testParser.parse();
        }
        catch ( Exception ex )
        {
            caughtException = ex;
        }

        Test.stopTest();

        System.assertNotEquals( null, caughtException,
            'An exception should be thrown for two identifiers in a row' );
    }

    private static testMethod void testFunctionCall()
    {
        TokenStream functionCall = new ListStream( new List<String>{ 'foo', '(', ')' } );
        Parser testParser = new Parser( functionCall );

        Test.startTest();

            Object parsed = testParser.parse();

        Test.stopTest();

        System.assert( parsed instanceof FunctionCall,
            'Function calls should be parsed to nodes' );

        FunctionCall call = (FunctionCall)parsed;
        System.assertEquals( 'foo', call.name,
            'Function names should be parsed' );
        System.assert( call.parameters.isEmpty(),
            'Function calls with no parameters should be recognized as such' );
    }

    private static testMethod void testFunctionParameter()
    {
        TokenStream functionCall = new ListStream( new List<String>{ 'foo', '(', 'bar', ')' } );
        Parser testParser = new Parser( functionCall );

        Test.startTest();

            Object parsed = testParser.parse();

        Test.stopTest();

        System.assert( parsed instanceof FunctionCall,
            'Function calls should be parsed to nodes' );

        FunctionCall call = (FunctionCall)parsed;
        System.assertEquals( 'foo', call.name,
            'Function names should be parsed' );
        System.assertEquals( 1, call.parameters.size(),
            'Function call parameters should be parsed' );
        System.assertEquals( 'bar', call.parameters[0],
            'Function call parameters should pass through' );
    }

    private static testMethod void testFunctionParameters()
    {
        TokenStream functionCall = new ListStream( new List<String>{ 'foo', '(', 'bar', ',', 'baz', ')' } );
        Parser testParser = new Parser( functionCall );

        Test.startTest();

            Object parsed = testParser.parse();

        Test.stopTest();

        System.assert( parsed instanceof FunctionCall,
            'Function calls should be parsed to nodes' );

        FunctionCall call = (FunctionCall)parsed;
        System.assertEquals( 'foo', call.name,
            'Function names should be parsed' );
        System.assertEquals( 2, call.parameters.size(),
            'Function call parameters should be parsed' );
        System.assertEquals( 'bar', call.parameters[0],
            'Function call parameters should be in the right order' );
        System.assertEquals( 'baz', call.parameters[1],
            'Function call parameters should be in the right order' );
    }

    private static testMethod void testTwoParametersNoComma()
    {
        TokenStream twoParameters = new ListStream( new List<String>{ 'foo', '(', 'bar', 'baz', ')' } );
        Parser testParser = new Parser( twoParameters );

        Exception caughtException;

        Test.startTest();

        try
        {
            testParser.parse();
        }
        catch ( Exception ex )
        {
            caughtException = ex;
        }

        Test.stopTest();

        System.assertNotEquals( null, caughtException,
            'An exception should be thrown for two identifiers in a row' );
    }

    private static testMethod void testNestedFunctionCalls()
    {
        TokenStream functionCall = new ListStream( new List<String>{ 'foo', '(', 'bar', '(', ')', ',', 'baz', ')' } );
        Parser testParser = new Parser( functionCall );

        Test.startTest();

            Object parsed = testParser.parse();

        Test.stopTest();

        System.assert( parsed instanceof FunctionCall,
            'Function calls should be parsed to nodes' );

        FunctionCall call = (FunctionCall)parsed;
        System.assertEquals( 'foo', call.name,
            'Function names should be parsed' );
        System.assertEquals( 2, call.parameters.size(),
            'Function call parameters should be parsed' );
        System.assert( call.parameters[0] instanceof FunctionCall,
            'Function call parameters should be in the right order' );
        System.assertEquals( 'baz', call.parameters[1],
            'Function call parameters should be in the right order' );

        FunctionCall nestedCall = (FunctionCall)call.parameters[0];
        System.assertEquals( 'bar', nestedCall.name,
            'Nested functino names should be parsed' );
        System.assert( nestedCall.parameters.isEmpty(),
            'Nested calls with no parameters should be recognized as such' );
    }
}
