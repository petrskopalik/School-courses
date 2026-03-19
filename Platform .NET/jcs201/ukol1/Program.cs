namespace ukol1;

class Program 
{
    static void Main()
    {
        Inventory A = new();
        Inventory B = new();

        Product Kakako = new("1", "Kakako", 20);
        Product Mleko = new("2", "Mleko", 12);
        Product Hrnek = new("3", "Hrnek", 10);
        Product Lzicka = new("10", "Lzicka", 1);

        A.AddProduct(Kakako, 3);
        A.AddProduct(Mleko, 10);
        A.AddProduct(Hrnek, 11);

        B.AddProduct(Hrnek, 10);
        B.AddProduct(Lzicka, 7);

        A.SetProductQuantity(Kakako, 5);

        Console.WriteLine(A.Quantity());
        Console.WriteLine(B.Quantity());

        Console.WriteLine(A < B);
        Console.WriteLine(A > B);

        Inventory C = A + B;
        Console.WriteLine(C.Quantity());

        Inventory D = A - B;
        Console.WriteLine(D.Quantity());

    }
}
