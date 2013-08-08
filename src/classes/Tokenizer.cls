global class Tokenizer
{
    @TestVisible String stringToTokenize;

    global Tokenizer( String stringToTokenize )
    {
        this.stringToTokenize = stringToTokenize;
    }

    global Boolean isDone()
    {
        return stringToTokenize == '';
    }

    global String getToken()
    {
        String token = stringToTokenize;
        stringToTokenize = '';

        Integer lParenIndex = token.indexOf('(');
        Integer rParenIndex = token.indexOf(')');
        Integer commaIndex = token.indexOf(',');

        Integer firstIndex = token.indexOfAny('(),');

        if ( -1 == firstIndex )
        {
            return token;
        }

        if ( 0 == lParenIndex )
        {
            stringToTokenize = token.substring(1);
            token = '(';
        }
        else if ( 0 == rParenIndex )
        {
            stringToTokenize = token.substring(1);
            token = ')';
        }
        else if ( 0 == commaIndex )
        {
            stringToTokenize = token.substring(1);
            token = ',';
        }
        else if ( firstIndex == lParenIndex )
        {
            stringToTokenize = token.substring( lParenIndex );
            token = token.substring( 0, lParenIndex );
        }
        else if ( firstIndex == commaIndex )
        {
            stringToTokenize = token.substring( commaIndex );
            token = token.substring( 0, commaIndex );
        }
        else if ( firstIndex == rParenIndex )
        {
            stringToTokenize = token.substring( rParenIndex );
            token = token.substring( 0, rParenIndex );
        }

        return token;
    }
}
