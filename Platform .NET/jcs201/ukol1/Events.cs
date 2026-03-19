namespace ukol1
{
    public sealed class StockChangedEventArgs : EventArgs
    {
        public string Code { get; }
        public int Quantity { get; }
        public StockChangedEventArgs(string code, int quantity)
        {
            Code = code;
            Quantity = quantity;
            Console.WriteLine($"StockChange: {code} {quantity}");
        }
    }
}