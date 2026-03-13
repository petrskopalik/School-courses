using System.Collections;
namespace jcs106;

class GenericSet<T> : IGenericSet<T>
{
    private T[] _set;
    private int _size;
    private int _max_size;

    public GenericSet()
    {
        this._set = new T[10];
        this._max_size = 10;
        this._size = 0;
    }

    private T[] Set()
    {
        return this._set;
    }

    public int Size()
    {
        return this._size;
    }

    private int MaxSize()
    {
        return this._max_size;
    }

    private void SizePlus()
    {
        this._size++;
    }

    private void SizeMinus()
    {
        this._size--;
    }

    public bool Contains(T i)
    {
        for (int x = 0; x < Size(); x++)
        {
            if (EqualityComparer<T>.Default.Equals(this._set[x], i))
            {
                return true;
            }
        }
        return false;
    }

    private void ResizeDataStructure()
    {
        T[] nextData = new T[MaxSize() * 2];
        Set().CopyTo(nextData, 0);
        this._set = nextData;
        this._max_size *= 2;
    }

    public void Add(T i)
    {
        if (!Contains(i))
        {
            if (Size() >= MaxSize())
            {
                ResizeDataStructure();
            }
            this._set[Size()] = i;
            SizePlus();
        }
    }

    public void Remove(T i)
    {
        for (int x = 0; x < Size(); x++)
        {
            if (EqualityComparer<T>.Default.Equals(this._set[x], i))
            {
                for (int y = x; y < Size() - 1; y++)
                {
                    _set[y] = _set[y + 1];
                }
                SizeMinus();
                return;
            }
        }
    }

    public GenericSet<T> Union(GenericSet<T> other)
    {
        GenericSet<T> res = new GenericSet<T>();

        for (int i = 0; i < Size(); i++)
        {
            res.Add(_set[i]);
        }

        for (int i = 0; i < other.Size(); i++)
        {
            T num = other.Set()[i];
            if (!res.Contains(num))
            {
                res.Add(num);
            }
        }

        return res;
    }

    public GenericSet<T> Intersection(GenericSet<T> other)
    {
        GenericSet<T> res = new GenericSet<T>();

        for (int i = 0; i < Size(); i++)
        {
            T num = _set[i];
            if (other.Contains(num))
            {
                res.Add(num);
            }
        }

        return res;
    }

    public GenericSet<T> Subtract(GenericSet<T> other)
    {
        GenericSet<T> res = new GenericSet<T>();

        for (int i = 0; i < Size(); i++)
        {
            T num = _set[i];
            if (!other.Contains(num))
            {
                res.Add(num);
            }
        }

        return res;
    }

    public bool AreEqual(GenericSet<T> other)
    {
        if (Size() != other.Size())
        {
            return false;
        }

        for (int i = 0; i < Size(); i++)
        {
            T num = _set[i];
            if (!other.Contains(num))
            {
                return false;
            }
        }

        return true;
    }

    public bool IsSubsetOf(GenericSet<T> other)
    {
        if (Size() == 0)
        {
            return true;
        }

        for (int i = 0; i < Size(); i++)
        {
            T num = _set[i];
            if (!other.Contains(num))
            {
                return false;
            }
        }

        return true;
    }

    public bool IsEmpty()
    {
        return this._size == 0;
    }


    public IEnumerator<T> GetEnumerator()
    {
        return new GenericSetEnumerator<T>(this._set, this._size);
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return GetEnumerator();
    }
}


public class GenericSetEnumerator<T> : IEnumerator<T>
{
    private T[] _set;
    private int _position = -1;
    private int _size;
    public GenericSetEnumerator(T[] _set, int _size)
    {
        this._set = _set;
        this._size = _size;
    }

    public T Current => _set[_position];

    object IEnumerator.Current => Current;

    public void Dispose()
    {

    }

    public bool MoveNext()
    {
        _position++;
        return _position < _size;
    }

    public void Reset()
    {
        _position = -1;
    }
}