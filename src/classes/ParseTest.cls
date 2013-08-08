@isTest
global class ParseTest
{
    private static testMethod void testFlow()
    {
        String input = 'foo(bar(a,b),baz(c,d))';

        Test.startTest();

            Object output = Parse.expression( input );

        Test.stopTest();

        System.assert( output instanceof FunctionCall );

        FunctionCall foo = (FunctionCall)output;

        System.assertEquals( 'foo', foo.name );
        System.assert( foo.parameters[0] instanceof FunctionCall );
        System.assert( foo.parameters[1] instanceof FunctionCall );

        FunctionCall bar = (FunctionCall)foo.parameters[0];
        FunctionCall baz = (FunctionCall)foo.parameters[1];

        System.assertEquals( 'bar', bar.name );
        System.assertEquals( 'baz', baz.name );

        System.assertEquals( 'a', bar.parameters[0] );
        System.assertEquals( 'b', bar.parameters[1] );
        System.assertEquals( 'c', baz.parameters[0] );
        System.assertEquals( 'd', baz.parameters[1] );
    }
}
