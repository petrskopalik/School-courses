namespace jcs106;

class Program 
{
    static void Main(string[] args)
    {
        Console.WriteLine("jcs106");
        GenericSet<int> col = new GenericSet<int>();

        col.Add(2);  

        foreach (int item in col)
        {
            Console.WriteLine(item);
        }
    }
}
