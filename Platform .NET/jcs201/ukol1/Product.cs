namespace ukol1
{
    class Product : IEquatable<Product>
    {
        public string Code {get; set;}
        public string Name {get; set;}
        private decimal _price;
        public decimal Price
        {
            get => _price;
            set {
                if (value < 0)
                {
                    throw new ArgumentException("Hodnota nesmí být záporná");
                }

                _price = value;
            }
        }
        public Product(string Code, string Name, decimal Price)
        {
            this.Code = Code;
            this.Name = Name;
            this.Price = Price;
        }
        public bool Equals(Product? other)
        {
            if (other is null) return false;
            return Code == other.Code && Name == other.Name && Price == other.Price;
        }
        public override bool Equals(object? obj)
        {
            return Equals(obj);
        }
        public override int GetHashCode()
        {
            return HashCode.Combine(Code, Name);
        }
        public static bool operator ==(Product A, Product B)
        {
            return A.Code == B.Code;
        }
        public static bool operator !=(Product A, Product B)
        {
            return A.Code != B.Code;
        }
        public override string ToString()
        {
            return $"{Code} - {Name} ({Price} Kč)";
        }
    }
}