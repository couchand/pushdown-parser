global class Parser
{
    @TestVisible TokenStream input;
    @TestVisible Stack stack;

    global Parser( TokenStream input )
    {
        this.input = input;
        this.stack = new Stack();
    }

    global Object parse()
    {
        while( !input.isDone() )
        {
            stack.push( input.getToken() );
        }

        if ( stack.isEmpty() )
        {
            throw new SyntaxException('No input found');
        }

        Object value = stack.pop();

        if ( !stack.isEmpty() )
        {
            throw new SyntaxException('Too much input found (missing comma? missing paren? extra space?)');
        }

        return value;
    }

    global class SyntaxException extends Exception {}
}
