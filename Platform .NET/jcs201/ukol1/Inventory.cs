using System.Collections;

namespace ukol1
{
    class Inventory : IEnumerable<Product>
    {
        public List<Product> ProductList {get; set;}
        public Dictionary<string, int> ProductQuantity {get; set;}
        public Inventory()
        {
            ProductList = [];
            ProductQuantity = [];
        }
        public Product this[int i]
        {
            get => ProductList[i];
            set => ProductList.Insert(i, value);
        }
        public void AddProduct(Product p, int quantity){
            ProductList.Add(p);
            SetProductQuantity(p, quantity);
        }
        public int Quantity()
        {
            int result = 0;
            foreach (Product p in ProductList)
            {
                result += ProductQuantity[p.Code];
            }
            return result;
        }
        public int this[string code]
        {
            get => ProductQuantity[code];
            set => ProductQuantity[code] = value;
        }
        public void SetProductQuantity(Product p, int quantity)
        {
            ProductQuantity[p.Code] = quantity;
            StockChanged?.Invoke(this, new StockChangedEventArgs(p.Code, quantity));
        }
        public IEnumerator<Product> GetEnumerator()
        {
            return ProductList.GetEnumerator();
        }
        IEnumerator IEnumerable.GetEnumerator()
        {
            return GetEnumerator();
        }
        public static Inventory operator +(Inventory A, Inventory B)
        {
            Inventory NewInventory = new()
            {
                ProductList = [.. A.ProductList],
                ProductQuantity = new Dictionary<string, int>(A.ProductQuantity)
            };

            foreach (Product product in B.ProductList)
            {
                if (!NewInventory.ProductList.Contains(product))
                {
                    NewInventory.ProductList.Add(product);
                    NewInventory.SetProductQuantity(product, B.ProductQuantity[product.Code]);
                }
                else
                {
                    int q = B.ProductQuantity[product.Code] + NewInventory.ProductQuantity[product.Code];
                    NewInventory.SetProductQuantity(product, q);
                }
            }
            return NewInventory;
        }
        public static Inventory operator -(Inventory A, Inventory B)
        {
            Inventory NewInventory = new()
            {
                ProductList = A.ProductList,
                ProductQuantity = A.ProductQuantity
            };

            foreach (Product product in B.ProductList)
            {
                if (NewInventory.ProductList.Contains(product))
                {
                    // Console.WriteLine(product.Name);
                    int NewQuantity = NewInventory.ProductQuantity[product.Code] - B.ProductQuantity[product.Code];
                    NewInventory.SetProductQuantity(product, NewQuantity);
                }
            }
            return NewInventory;
        }
        public static bool operator <(Inventory A, Inventory B)
        {
            return A.Quantity() < B.Quantity();
        }
        public static bool operator >(Inventory A, Inventory B)
        {
            return A.Quantity() > B.Quantity();
        }
        public event EventHandler<StockChangedEventArgs>? StockChanged; 
    }
}