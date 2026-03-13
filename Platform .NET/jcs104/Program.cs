namespace jcs104;

class Program
{
    static void Main(string[] args)
    {
        IntSet s = new IntSet();

        s.Add(1);

        Console.WriteLine(s.Contains(1));
    }
}