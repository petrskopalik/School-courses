using System.Text;

namespace jcs107
{
    public interface IIntPriorityQueue
    {
        bool IsEmpty();
        void InsertWithPriority(int value, int priority);
        bool PopNextValue(out int val);
        bool PeekNextValue(out int val);
    }

    public class IntPriorityQueue : IIntPriorityQueue
    {
        private int[] _vals;
        private int[] _priorities;
        private int _max_size;
        private int _count;

        public IntPriorityQueue()
        {
            _vals = new int[10];
            _priorities = new int[10];
            _max_size = 10;
            _count = 0;
        }

        private int[] Vals()
        {
            return _vals;
        }

        private int[] Priorities()
        {
            return _priorities;
        }

        public bool IsEmpty()
        {
            return _count == 0;
        }

        private void ResizeDataStructure()
        {
            int[] nextVals = new int[_max_size * 2];
            int[] nextPrioties = new int[_max_size * 2];
            _vals.CopyTo(nextVals, 0);
            _priorities.CopyTo(nextPrioties, 0);
            _vals = nextVals;
            _priorities = nextPrioties;
            _max_size = _max_size * 2;
        }

        private int CloserLowerPriority(int n)
        {
            int closer = n - 1;

            while (closer >= _priorities.Min())
            {
                if (!_priorities.Contains(closer))
                {
                    return closer;
                }

                closer--;
            }

            throw new Exception("CloserLowerPriority neexistuje!");
        }

        private int CloserHigherPriority(int n)
        {
            int closer = n + 1;

            while (closer <= _priorities.Max())
            {
                if (!_priorities.Contains(closer))
                {
                    return closer;
                }

                closer++;
            }
            
            throw new Exception("CloserHigherPriority neexistuje!");
        }

        public void InsertWithPriority(int value, int priority)
        {
            if (_count == _max_size)
            {
                ResizeDataStructure();
            }

            if (_priorities.Contains(priority))
            {
                throw new Exception($"Priority okolo jsou: {CloserLowerPriority(priority)} a {CloserHigherPriority(priority)}");
            }

            _vals[_count] = value;
            _priorities[_count] = priority;
            _count++;
        }

        private int TopPriority()
        {
            int index = 0;
            int priority = _priorities.Take(_count).Max();
            for (int i = 0; i < _count; i++)
            {
                if (_priorities[i] == priority)
                {
                    index = i;
                    break;
                }
            }
            return index;
        }

        public bool PopNextValue(out int val)
        {
            try
            {
                int index = TopPriority();
                val = _vals[index];

                _vals[index] = _vals[_count - 1];
                _priorities[index] = _priorities[_count - 1];

                _count--;

                return true;
            }
            catch (Exception e)
            {
                val = default;
                throw new Exception("Chyba: " + e);
            }
        }

        public bool PeekNextValue(out int val)
        {
            if (IsEmpty())
            {
                val = default;
                return false;
            }

            val = _vals[TopPriority()];

            return true;
        }

        public override string ToString()
        {
            if (IsEmpty())
            {
                return "Fronta je prázdná";
            }

            StringBuilder sb = new StringBuilder();
            sb.Append("Obsah prioritní fronty:\n");

            for (int i = 0; i < _count; i++)
            {
                sb.Append($"Value: {_vals[i]}, priority: {_priorities[i]}\n");
            }

            return sb.ToString();
        }
    }
}
