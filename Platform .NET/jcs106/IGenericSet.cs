namespace jcs106;

interface IGenericSet<T> : IEnumerable<T>
{
    public int Size();
    public bool Contains(T i);
    public void Add(T i);
    public void Remove(T i);
    public GenericSet<T> Union(GenericSet<T> other);
    public GenericSet<T> Intersection(GenericSet<T> other);
    public GenericSet<T> Subtract(GenericSet<T> other);
    public bool AreEqual(GenericSet<T> other);
    public bool IsSubsetOf(GenericSet<T> other);

    public bool IsEmpty();
}
