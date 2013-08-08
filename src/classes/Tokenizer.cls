global class Tokenizer implements TokenStream
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

        Integer firstIndex = token.indexOfAny('(),');

        if ( 0 == firstIndex )
        {
            stringToTokenize = token.substring(1);
            token = token.substring(0, 1);
        }
        else if ( -1 != firstIndex )
        {
            stringToTokenize = token.substring( firstIndex );
            token = token.substring( 0, firstIndex );
        }

        return token;
    }
}
