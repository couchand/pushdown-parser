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
        if ( 0 == lParenIndex )
        {
            stringToTokenize = token.substring(1);
            token = '(';
        }
        else if ( -1 != lParenIndex )
        {
            stringToTokenize = token.substring( lParenIndex );
            token = token.substring( 0, lParenIndex );
        }

        return token;
    }
}
