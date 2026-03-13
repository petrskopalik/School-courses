namespace jcs109
{
    class IntMatrix
    {
        private int rows;
        private int columns;
        public int[,] Matrix;

        public IntMatrix(int Rows, int Columns)
        {
            this.rows = Columns;
            this.columns = Rows;
            Matrix = new int[Columns, Rows];
            // rows = Rows;
            // columns = Columns;
            // Matrix = new int[Rows, Columns];
        }

        public int NRows()
        {
            return this.rows;
        }

        public int NCols()
        {
            return this.columns;
        }

        public int GetVal(int x, int y)
        {
            return Matrix[x,y];
        }

        public void SetVal(int x, int y, int val)
        {
            Matrix[x,y] = val;
        }

        public int NonZero()
        {
            int count = 0;

            foreach (int num in Matrix)
            {
                if (num != 0)
                {
                    count++;   
                }
            }

            return count;
        }

        public int SumOfVals()
        {
            int sum = 0;

            foreach (int num in Matrix)
            {
                sum += num;
            }

            return sum;
        }

        public IntMatrix AddMatrix(IntMatrix mat)
        {
            if (mat.NCols() != this.rows || mat.NCols() != this.columns)
            {
                return new IntMatrix(0,0);
            }
            IntMatrix NewMatrix = new IntMatrix(this.columns, this.rows);

            for (int x = 0; x < this.rows; x++)
            {
                for (int y = 0; y < this.columns; y++)
                {
                    int val = Matrix[x, y] + mat.Matrix[x, y];
                    NewMatrix.SetVal(x, y, val);
                }
            }

            return NewMatrix;
        }

        public IntMatrix MulMatrix(IntMatrix mat)
        {
            if (this.columns != mat.NRows())
            {
                return new IntMatrix(0, 0);
            }

            IntMatrix NewMatrix = new IntMatrix(mat.NCols(), this.rows);

            for (int row = 0; row < this.rows; row++)
            {
                for (int col = 0; col < mat.NCols(); col++)
                {
                    int val = 0;
                    for (int i = 0; i < this.columns; i++)
                    {
                        val += this.GetVal(row, i) * mat.GetVal(i, col);
                    }
                    NewMatrix.SetVal(row, col, val);
                }
            }

            return NewMatrix;
        }

        public void Print()
        {
            int times = 0;

            foreach (int num in Matrix)
            {
                Console.Write(num + " ");
                times++;
                if (times == this.columns)
                {
                    Console.WriteLine();
                    times = 0;
                }
            }
        }

        public static IntMatrix Ones(int nRows, int nCols)
        {
            IntMatrix NewMatrix = new IntMatrix(nCols, nRows);
            for (int y = 0; y < nRows; y++)
            {
                for (int x = 0; x < nCols; x++)
                {
                    NewMatrix.SetVal(x, y, 1);
                }
            }

            return NewMatrix;
        }

        public static bool operator ==(IntMatrix a, IntMatrix b)
        {
            if (a.NRows() != b.NRows() || a.NCols() != b.NCols())
                return false;

            for (int i = 0; i < a.NRows(); i++)
                for (int j = 0; j < a.NCols(); j++)
                    if (a.Matrix[i, j] != b.Matrix[i, j])
                        return false;

            return true;
        }

        public static bool operator !=(IntMatrix a, IntMatrix b)
        {
            return !(a == b);
        }

        public static bool operator <(IntMatrix a, IntMatrix b)
        {
            return a.SumOfVals() < b.SumOfVals();
        }

        public static bool operator >(IntMatrix a, IntMatrix b)
        {
            return a.SumOfVals() > b.SumOfVals();
        }

        public static bool operator <=(IntMatrix a, IntMatrix b)
        {
            return a.SumOfVals() <= b.SumOfVals();
        }

        public static bool operator >=(IntMatrix a, IntMatrix b)
        {
            return a.SumOfVals() >= b.SumOfVals();
        }

        public static IntMatrix operator +(IntMatrix a, IntMatrix b)
        {
            return a.AddMatrix(b);
        }

        public static IntMatrix operator -(IntMatrix a, IntMatrix b)
        {
            IntMatrix NewMatrix = new IntMatrix(a.columns, a.rows);

            for (int x = 0; x < a.rows; x++)
            {
                for (int y = 0; y < a.columns; y++)
                {
                    NewMatrix.SetVal(x, y, a.GetVal(x, y) - b.GetVal(x, y));
                }
            }

            return NewMatrix;
        }

        public static IntMatrix operator *(IntMatrix a, IntMatrix b)
        {
            return a.MulMatrix(b);
        }

        public static IntMatrix operator ++(IntMatrix a)
        {
            for (int i = 0; i < a.rows; i++)
                for (int j = 0; j < a.columns; j++)
                    a.SetVal(i, j, a.GetVal(i, j) + 1);

            return a;
        }

        public static IntMatrix operator --(IntMatrix a)
        {
            for (int i = 0; i < a.rows; i++)
                for (int j = 0; j < a.columns; j++)
                    a.SetVal(i, j, a.GetVal(i, j) - 1);

            return a;
        }

        public delegate int MathOperation(int x, int y);

        public static int[] MapMathOperation(int[] array1, int[] array2, MathOperation op)
        {
            int[] result = new int[array1.Length];

            for (int i = 0; i < array1.Length; i++)
            {
                result[i] = op(array1[i], array2[i]);
            }

            return result;
        }

        public static int Add(int x, int y)
        {
            return x + y;
        }

        public static int Multiply(int x, int y)
        {
            return x * y;
        }

    }
}
