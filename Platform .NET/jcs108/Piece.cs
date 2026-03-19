namespace VelkyUkol1
{
    public enum PieceType {Stone, Queen}
    public enum Player {Black, White}
    public class Piece
    {
        public Player Owner {get; set;}
        public PieceType Type {get; set;}
        public Piece(Player owner)
        {
            Owner = owner;
            Type = PieceType.Stone;
        }
        public static string RenderPiece(Piece? p)
        {
            if (p == null) return "   ";

            if (p.Owner == Player.White)
                return p.Type == PieceType.Stone ? " ⛀ " : " ⛁ ";
            else
                return p.Type == PieceType.Stone ? " ⛂ " : " ⛃ ";
        }
    }
}