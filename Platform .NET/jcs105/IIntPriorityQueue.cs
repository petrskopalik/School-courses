using System.Text;
using System.Linq;

namespace jcs105
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
        private int[] vals;
        private int[] priorities;
        private int max_size;
        private int count;

        public IntPriorityQueue()
        {
            this.vals = new int[10];
            this.priorities = new int[10];
            this.max_size = 10;
            this.count = 0;
        }

        private int[] Vals()
        {
            return this.vals;
        }

        private int[] Priorities()
        {
            return this.priorities;
        }

        public bool IsEmpty()
        {
            return this.count == 0;
        }

        private void ResizeDataStructure()
        {
            int[] nextVals = new int[this.max_size * 2];
            int[] nextPrioties = new int[this.max_size * 2];
            Vals().CopyTo(nextVals, 0);
            Priorities().CopyTo(nextPrioties, 0);
            this.vals = nextVals;
            this.priorities = nextPrioties;
            this.max_size = this.max_size * 2;
        }

        public void InsertWithPriority(int value, int priority)
        {
            if (this.count == max_size)
            {
                ResizeDataStructure();
            }

            this.vals[count] = value;
            this.priorities[count] = priority;
            this.count++;
        }

        private int TopPriority()
        {
            int index = 0;
            int priority = this.priorities.Take(this.count).Max();
            for (int i = 0; i < this.count; i++)
            {
                if (this.priorities[i] == priority)
                {
                    index = i;
                    break;
                }
            }
            return index;
        }

        public bool PopNextValue(out int val)
        {
            if (IsEmpty())
            {
                val = default;
                return false;
            }

            int index = TopPriority();
            val = Vals()[index];

            this.vals[index] = Vals()[this.count - 1];
            this.priorities[index] = Priorities()[this.count - 1];

            this.count--;
            return true;
        }

        public bool PeekNextValue(out int val)
        {
            if (IsEmpty())
            {
                val = default;
                return false;
            }

            val = Vals()[TopPriority()];

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

            for (int i = 0; i < this.count; i++)
            {
                sb.Append($"Value: {this.vals[i]}, priority: {this.priorities[i]}\n");
            }

            return sb.ToString();
        }
    }
}
