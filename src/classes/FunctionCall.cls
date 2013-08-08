global class FunctionCall
{
    global String name;
    global List<Object> parameters;

    global FunctionCall( String name, List<Object> parameters )
    {
        this.name = name;
        this.parameters = parameters;
    }
}
