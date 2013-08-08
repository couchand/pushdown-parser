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
            String token = input.getToken();

            if ( token == ')' )
            {
                List<Object> params = new List<Object>();
                String function;
                Object param;

                while ( !stack.isEmpty() )
                {
                    param = stack.pop();

                    if ( param == '(' )
                    {
                        break;
                    }
                    if ( param == ',' )
                    {
                        continue;
                    }
                    if ( stack.peek() != '(' && stack.peek() != ',' )
                    {
                        throw new SyntaxException('Too much input found (missing comma? missing paren? extra space?)');
                    }

                    if ( params.isEmpty() )
                    {
                        params.add( param );
                    }
                    else
                    {
                        params.add( 0, param );
                    }
                }

                function = (String)stack.pop();

                stack.push( new FunctionCall( function, params ) );
            }
            else
            {
                stack.push( token );
            }
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
