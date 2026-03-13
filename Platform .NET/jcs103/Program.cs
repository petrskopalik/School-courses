namespace jcs103;

class Program
{
    static void Main(string[] args)
    {
        IntMatrix prvni = new IntMatrix(2, 2);
        prvni.SetVal(0, 0, 2); prvni.SetVal(0, 1, 4);
        prvni.SetVal(1, 0, 6); prvni.SetVal(1, 1, 8);
        prvni.Print();

        Console.WriteLine();

        IntMatrix druha = new IntMatrix(2, 2);
        druha.SetVal(0, 0, 1); druha.SetVal(0, 1, 3);
        druha.SetVal(1, 0, 5); druha.SetVal(1, 1, 7);
        druha.Print();

        Console.WriteLine();

        IntMatrix treti = prvni.AddMatrix(druha);
        treti.Print();

        Console.WriteLine();

        Console.WriteLine(treti.SumOfVals()); 
        Console.WriteLine(treti.NonZero()); 
        treti.SetVal(0, 0, 0);
        Console.WriteLine(treti.NonZero());

        Console.WriteLine();

        IntMatrix one = IntMatrix.Ones(3, 3);
        one.Print();

        /*
        var a = new IntMatrix(2, 3);
        var b = new IntMatrix(3, 2);
        a.AddMatrix(b);

        var c = new IntMatrix(4, 3);
        var d = new IntMatrix(5, 3);
        c.MulMatrix(d);
        */
    }
}