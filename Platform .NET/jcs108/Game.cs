namespace VelkyUkol1
{
    public class Game
    {
        private Board Board = new Board();
        public Player CurrentPlayer = Player.White;
        public Field Cursor = new Field(0, 0);
        private bool RunGame = true;
        public void EndGame()
        {
            RunGame = false;
        }
        public void Start()
        {
            ConsoleKeyInfo PressedKey;

            while (RunGame)
            {
                Board.DrawBoard(Cursor, CurrentPlayer, new Field(-1, -1));
                Console.WriteLine($"Na tahu je hráč {CurrentPlayer}");
                Console.WriteLine("Esc - Ukončit hru");
                Console.WriteLine("Enter - Výběr políčka s vlastněným kamínkem");
                Console.WriteLine("Šipky - pohyb po šachovnici");

                PressedKey = Console.ReadKey(true);

                switch (PressedKey.Key)
                {
                    case ConsoleKey.UpArrow:
                        Cursor.Row = Math.Max(0, Cursor.Row - 1);
                        break;
                    case ConsoleKey.DownArrow:
                        Cursor.Row = Math.Min(7, Cursor.Row + 1);
                        break;
                    case ConsoleKey.LeftArrow:
                        Cursor.Col = Math.Max(0, Cursor.Col - 1);
                        break;
                    case ConsoleKey.RightArrow:
                        Cursor.Col = Math.Min(7, Cursor.Col + 1);
                        break;
                    case ConsoleKey.Enter:
                        List <Field> Moves = Board.GetAvailableMoves(Cursor, CurrentPlayer);
                        if (Moves.Count() == 0) break;
                        Moving(Moves);
                        break;
                    case ConsoleKey.Escape:
                        Console.Clear();
                        Console.WriteLine("Hra byla ukončena.");
                        EndGame();
                        break;
                }

                Player? Winner = Board.CheckWinner();
                if (Winner is not null)
                {
                    Console.Clear();
                    Console.WriteLine($"Hra je ukonce, vítězem je hráč {Winner}.");
                    EndGame();
                }
            }
        }
        private void Moving(List <Field> Moves)
        {
            ConsoleKeyInfo PressedKey;
            int MoveIndex = 0;
            int Count = Moves.Count;
            bool Run = true;
            while (Run)
            {
                Board.DrawBoard(Cursor, CurrentPlayer, Moves[MoveIndex]);
                Console.WriteLine("Esc - Ukončit výběr tahu");
                Console.WriteLine("Enter - Potvrzení výběru tahu");
                Console.WriteLine("Šipky - Výběr tahu");

                PressedKey = Console.ReadKey(true);

                switch (PressedKey.Key)
                {
                    case ConsoleKey.RightArrow:
                        MoveIndex = PlusIndex(Count, MoveIndex);
                        break;
                    case ConsoleKey.LeftArrow:
                        MoveIndex = MinusIndex(Count, MoveIndex);
                        break;
                    case ConsoleKey.UpArrow:
                        MoveIndex = PlusIndex(Count, MoveIndex);
                        break;
                    case ConsoleKey.DownArrow:
                        MoveIndex = MinusIndex(Count, MoveIndex);
                        break;
                    case ConsoleKey.Enter:
                        CurrentPlayer = Board.Move(Cursor, Moves[MoveIndex], CurrentPlayer);
                        Run = false;
                        break;
                    case ConsoleKey.Escape:
                        Run = false;
                        break;
                }
            }
        }
        private int PlusIndex(int Count, int Index)
        {
            return (Index + 1 == Count) ? 0 : Index + 1;
        }

        private int MinusIndex(int Count, int Index)
        {
            return (Index - 1 < 0) ? Count - 1 : Index - 1;
        }
    }
}