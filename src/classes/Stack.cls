global class Stack
{
    @TestVisible List<Object> data = new List<Object>();

    global Stack() {}

    global Stack( List<Object> newData )
    {
        data.addAll( newData );
    }

    global Integer size()
    {
        return data.size();
    }

    global Boolean isEmpty()
    {
        return data.isEmpty();
    }

    global Object peek()
    {
        return data[data.size()-1];
    }

    global void push( Object newObj )
    {
        data.add( newObj );
    }

    global Object pop()
    {
        return data.remove( data.size()-1 );
    }
}
