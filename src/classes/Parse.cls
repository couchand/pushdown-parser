global class Parse
{
    global static Object expression( String input )
    {
        return new Parser( new Tokenizer( input ) ).parse();
    }
}
