namespace VelkyUkol1
{
    public class Board
    {
        public Piece?[,] ChessBoard;
        private int WhiteCount = 12;
        private int BlackCount = 12;
        public Board()
        {
            ChessBoard = new Piece[8,8];
            CreateBoard();
        }
        private void MinusWhiteCount()
        {
            WhiteCount--;
        }
        private void MinusBlackCount()
        {
            BlackCount--;
        }
        public Player? CheckWinner()
        {
            if (WhiteCount == 0) return Player.Black;
            if (BlackCount == 0) return Player.White;
            return null;
        }
        public Piece? GetPiece(int Row, int Col)
        {
            return ChessBoard[Row, Col];
        }
        public void SetPiece(int Row, int Col, Piece? p)
        {
            ChessBoard[Row, Col] = p;
        }
        private void CreateBoard()
        {
            for (int row = 0; row < 3; row++)
            {
                for (int col = 0; col < 8; col++)
                {
                    if ((col+row ) % 2 == 0)
                    {
                        SetPiece(row, col, new Piece(Player.White));
                    } 
                }
            }

            for (int row = 5; row < 8; row++)
            {
                for (int col = 0; col < 8; col++)
                {
                    if ((col+row ) % 2 == 0)
                    {
                        SetPiece(row, col, new Piece(Player.Black));
                    } 
                }
            }
        }
        private bool InBoardInterval(int x)
        {
            return x >= 0 && x <= 7;
        }
        public List<Field> GetAvailableMoves(Field Cursor, Player CurrentPlayer)
        {
            List<Field> AvailableMoves = new();

            Piece? p = GetPiece(Cursor.Row, Cursor.Col);
            if (p is null || p.Owner != CurrentPlayer) return AvailableMoves;

            int Row, Col;
            bool CanJump = true;

            if (p.Type == PieceType.Queen)
            {
                for (int x = -1; x < 2; x += 2)
                {
                    for (int y = -1; y < 2; y += 2)
                    {
                        for (int times = 1; times < 8; times++)
                        {
                            Row = Cursor.Row + x * times;
                            Col = Cursor.Col + y * times;

                            if (InBoardInterval(Row) && InBoardInterval(Col)){
                                Piece? OnDiagonal = GetPiece(Row, Col);

                                if (OnDiagonal is null) {AvailableMoves.Add(new Field(Row, Col));}
                                else if (CanJump && OnDiagonal.Owner != CurrentPlayer) {CanJump = false;}
                                else{break;}
                            }
                        }
                        CanJump = true;
                    }
                }
            }
            else
            {
                for (int x = -1; x < 2; x += 2)
                {
                    for (int y = -1; y < 2; y += 2)
                    {
                        if (CurrentPlayer == Player.White && Cursor.Row + x < Cursor.Row) break;
                        if (CurrentPlayer == Player.Black && Cursor.Row + x > Cursor.Row) break;

                        if (InBoardInterval(Cursor.Row + x) && InBoardInterval(Cursor.Col + y))
                        {
                            Piece? Corner = GetPiece(Cursor.Row + x, Cursor.Col + y);

                            if (Corner is null) 
                            {
                                AvailableMoves.Add(new Field(Cursor.Row + x, Cursor.Col + y));
                            }
                            else if (InBoardInterval(Cursor.Row + 2 * x) && InBoardInterval(Cursor.Col + 2 * y))
                            {
                                Piece? FurtherCorner = GetPiece(Cursor.Row + 2 * x, Cursor.Col + 2 * y);
                                if (FurtherCorner is null && Corner.Owner != CurrentPlayer)
                                {
                                    AvailableMoves.Add(new Field(Cursor.Row + 2 * x, Cursor.Col + 2 * y));   
                                }
                            }   
                        }
                    }
                }     
            }

            return AvailableMoves;
        }
        private void CheckAvailableMoves(Field Actual, Field Cursor, Player CurrentPlayer, Field JumpTo)
        {
            Piece? p = GetPiece(Cursor.Row, Cursor.Col);
            if (p is null || p.Owner != CurrentPlayer) return;

            p = GetPiece(Actual.Row, Actual.Col);

            List<Field> JumpFields = GetAvailableMoves(Cursor, CurrentPlayer);

            if (JumpFields.Count() == 0) return;

            if (p is null && JumpFields.Contains(Actual))
            {
                if (JumpTo.Row == Actual.Row && JumpTo.Col == Actual.Col)
                {
                    Console.BackgroundColor = ConsoleColor.Cyan;
                }
                else
                {
                    Console.BackgroundColor = ConsoleColor.DarkMagenta;   
                }
                return;
            }
        }
        public void DrawBoard(Field Cursor, Player CurrentPlayer, Field JumpTo)
        {
            Console.Clear();
            Piece? p;
            for (int row = 0; row < 8; row++)
            {
                for (int col = 0; col < 8; col++)
                {
                    if (row == Cursor.Row && col == Cursor.Col)
                    {
                        Console.BackgroundColor = ConsoleColor.DarkYellow;
                    }
                    else if ((col+row ) % 2 == 0)
                    {
                        Console.BackgroundColor = ConsoleColor.White;
                        CheckAvailableMoves(new Field(row, col), Cursor, CurrentPlayer, JumpTo);
                    }
                    else
                    {
                        Console.BackgroundColor = ConsoleColor.DarkGray;
                    }

                    p = GetPiece(row, col);
                    Console.Write(Piece.RenderPiece(p));
                }

                Console.ResetColor();
                Console.WriteLine();
            }
        }
        public Player Move(Field Cursor, Field Destination, Player CurrentPlayer)
        {
            Piece? p = GetPiece(Cursor.Row, Cursor.Col);
            if (p is null || p.Owner != CurrentPlayer) return CurrentPlayer;

            int RowStep = (Destination.Row > Cursor.Row) ? RowStep = 1 : RowStep = -1;
            int ColStep = (Destination.Col > Cursor.Col) ? ColStep = 1 : ColStep = -1;

            int row = 0;
            int col = 0;
            int times = 1;
            bool Take = false;
            Piece? OnDiagonal;

            while (times * RowStep + Cursor.Row != Destination.Row)
            {
                row = times * RowStep + Cursor.Row;
                col = times * ColStep + Cursor.Col;
                OnDiagonal = GetPiece(row, col);
                if (OnDiagonal is not null)
                {
                    Take = true;
                    break;
                }
                
                times++;
            }

            bool CanTake = CanTake(CurrentPlayer);

            if (Take == CanTake)
            {
                if (Take) SetPiece(row, col, null);
                SetPiece(Cursor.Row, Cursor.Col, null);
                SetPiece(Destination.Row, Destination.Col, p);

                Piece? DestinationPiece = GetPiece(Destination.Row, Destination.Col);
                if (
                    DestinationPiece is not null &&
                    ((Destination.Row == 0 && CurrentPlayer == Player.Black) ||
                     (Destination.Row == 7 && CurrentPlayer == Player.White)) &&
                    DestinationPiece.Type == PieceType.Stone)
                {
                    DestinationPiece.Type = PieceType.Queen;
                }

                if (CanTake)
                {
                    if (CurrentPlayer == Player.White)
                    {
                        MinusBlackCount();
                    }
                    else
                    {
                        MinusWhiteCount();
                    }
                }
            }
            else
            {
                SetPiece(Cursor.Row, Cursor.Col, null);
            }

            return (CurrentPlayer == Player.White) ? Player.Black : Player.White;
        }
        private bool CanTake(Player CurrentPlayer)
        {
            List<Field> Moves;
            Piece? p;
            for (int row = 0; row < 8; row++)
            {
                for (int col = 0; col < 8; col++)
                {
                    p = GetPiece(row, col);
                    if (p is null || p.Owner != CurrentPlayer) continue;

                    Moves = GetAvailableMoves(new Field(row, col), CurrentPlayer);

                    if (p.Type == PieceType.Stone)
                    {
                        foreach (Field move in Moves)
                        {
                            if (move.Row - 2 == row || move.Row + 2 == row) return true;
                        }
                    }
                    else
                    {
                        int JumpRow, JumpCol;
                        int Times = 1;
                        bool MightJump = false;
                        bool Land = false;
                        Piece? JumpTo;
                        for (int rowstep = -1; rowstep < 2; rowstep += 2)
                        {
                            for (int colstep = -1; colstep < 2; colstep += 2)
                            {
                                while (InBoardInterval(Times * rowstep + row) && InBoardInterval(Times * colstep + col))
                                {
                                    JumpRow = Times * rowstep + row;
                                    JumpCol = Times * colstep + col;
                                    JumpTo = GetPiece(JumpRow, JumpCol);
                                    if (JumpTo is not null)
                                    {
                                        Land = false;
                                        if (JumpTo.Owner == CurrentPlayer)
                                        {
                                            MightJump = false;
                                            break;
                                        }
                                        else if (MightJump)
                                        {
                                            MightJump = false;
                                            break;
                                        }
                                        else{MightJump = true;}
                                    }
                                    else{Land = true;}
                                    
                                    if (MightJump && Land) return true;

                                    Times++;
                                }
                            }
                        }
                    }
                }
            }
            return false;
        }
    }
}