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
}
