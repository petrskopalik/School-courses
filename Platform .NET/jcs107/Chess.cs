namespace jcs107;

public enum ChessPiece
{
    None,
    WhitePawn,
    WhiteRook,
    WhiteKnight,
    WhiteBishop,
    WhiteQueen,
    WhiteKing,
    BlackPawn,
    BlackRook,
    BlackKnight,
    BlackBishop,
    BlackQueen,
    BlackKing
}

class Chess
{
    public static ChessPiece[,] GetBoard()
    {
        ChessPiece[,] board = new ChessPiece[8, 8];

        for (int i = 0; i < 8; i++)
        {
            board[1, i] = ChessPiece.WhitePawn;
            board[6, i] = ChessPiece.BlackPawn;

            if (i == 0 || i == 7)
            {
                board[0, i] = ChessPiece.WhiteRook;
                board[7, i] = ChessPiece.BlackRook;
            }
            else if (i == 1 || i == 6)
            {
                board[0, i] = ChessPiece.WhiteKnight;
                board[7, i] = ChessPiece.BlackKnight;
            }
            else if (i == 2 || i == 5)
            {
                board[0, i] = ChessPiece.WhiteBishop;
                board[7, i] = ChessPiece.BlackBishop;
            }
            else if (i == 3)
            {
                board[0, i] = ChessPiece.WhiteQueen;
                board[7, i] = ChessPiece.BlackQueen;
            }
            else
            {
                board[0, i] = ChessPiece.WhiteKing;
                board[7, i] = ChessPiece.BlackKing;
            }
        }

        return board;
    }
}
