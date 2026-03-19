namespace VelkyUkol1
{
    public struct Field
    {
        public int Row {get; set;}
        public int Col {get; set;}

        public Field(int row, int col)
        {
            Row = row;
            Col = col;
        }
    }
}