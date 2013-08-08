global class ListStream implements TokenStream
{
    @TestVisible List<String> tokens;

    global ListStream( List<String> tokens )
    {
        this.tokens = tokens.clone();
    }

    global Boolean isDone()
    {
        return tokens.isEmpty();
    }

    global String getToken()
    {
        return tokens.remove(0);
    }
}
