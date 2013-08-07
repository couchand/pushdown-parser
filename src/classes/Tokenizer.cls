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
        else if ( -1 != lParenIndex )
        {
            stringToTokenize = token.substring( lParenIndex );
            token = token.substring( 0, lParenIndex );
        }
        else if ( -1 != commaIndex )
        {
            stringToTokenize = token.substring( commaIndex );
            token = token.substring( 0, commaIndex );
        }
        else if ( -1 != rParenIndex )
        {
            stringToTokenize = token.substring( rParenIndex );
            token = token.substring( 0, rParenIndex );
        }

        return token;
    }
}
