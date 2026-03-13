namespace jcs105;

public interface IIntSet
{
    public int Size();
    public bool Contains(int i);
    public void Add(int i);
    public void Remove(int i);
    public IntSet Union(IntSet other);
    public IntSet Intersection(IntSet other);
    public IntSet Subtract(IntSet other);
    public bool AreEqual(IntSet other);
    public bool IsSubsetOf(IntSet other);
}

public class IntSet : IIntSet
{
    private int[] set;
    private int size;
    private int max_size;


    public IntSet()
    {
        this.set = new int[10];
        this.max_size = 10;
        this.size = 0;
    }

    private int[] Set()
    {
        return this.set;
    }

    public int Size()
    {
        return this.size;
    }

    private int MaxSize()
    {
        return this.max_size;
    }

    private void SizePlus()
    {
        this.size++;
    }

    private void SizeMinus()
    {
        this.size--;
    }

    public bool Contains(int i)
    {
        for (int x = 0; x < Size(); x++)
        {
            if (set[x] == i)
            {
                return true;
            }
        }
        return false;
    }

    private void ResizeDataStructure()
    {
        int[] nextData = new int[MaxSize() * 2];
        Set().CopyTo(nextData, 0);
        this.set = nextData;
    }

    public void Add(int i)
    {
        if (!Contains(i))
        {
            if (Size() >= MaxSize())
            {
                ResizeDataStructure();
            }
            this.set[Size()] = i;
            SizePlus();
        }
    }

    public void Remove(int i)
    {
        for (int x = 0; x < Size(); x++)
        {
            if (set[x] == i)
            {
                for (int y = x; y < Size() - 1; y++)
                {
                    set[y] = set[y + 1];
                }
                SizeMinus();
                return;
            }
        }
    }

    public IntSet Union(IntSet other)
    {
        IntSet res = new IntSet();

        for (int i = 0; i < Size(); i++)
        {
            res.Add(set[i]);
        }

        for (int i = 0; i < other.Size(); i++)
        {
            int num = other.Set()[i];
            if (!res.Contains(num))
            {
                res.Add(num);
            }
        }

        return res;
    }

    public IntSet Intersection(IntSet other)
    {
        IntSet res = new IntSet();

        for (int i = 0; i < Size(); i++)
        {
            int num = set[i];
            if (other.Contains(num))
            {
                res.Add(num);
            }
        }

        return res;
    }

    public IntSet Subtract(IntSet other)
    {
        IntSet res = new IntSet();

        for (int i = 0; i < Size(); i++)
        {
            int num = set[i];
            if (!other.Contains(num))
            {
                res.Add(num);
            }
        }

        return res;
    }

    public bool AreEqual(IntSet other)
    {
        if (Size() != other.Size())
        {
            return false;
        }

        for (int i = 0; i < Size(); i++)
        {
            int num = set[i];
            if (!other.Contains(num))
            {
                return false;
            }
        }

        return true;
    }

    public bool IsSubsetOf(IntSet other)
    {
        if (Size() == 0)
        {
            return true;
        }

        for (int i = 0; i < Size(); i++)
        {
            int num = set[i];
            if (!other.Contains(num))
            {
                return false;
            }
        }

        return true;
    }

    public bool IsEmpty()
    {
        return this.size == 0;
    }

}
