using System.Text;

class Program 
{
    static void Main()
    {
        var Dir = "./random_text/";
        var Files = Directory.GetFiles(Dir, "*.txt");
        int FileCount = Files.Length;
        long Size = 0;
        int AllLinesCount = 0;
        int AllWordsCount = 0;

        foreach (var filepath in Directory.EnumerateFiles(Dir, "*.txt"))
        {
            var fi = new FileInfo(filepath);
            Size += fi.Length;
        }
        
        Console.WriteLine($"Počet souborů: {FileCount}");
        Console.WriteLine($"Velikost souborů: {Size}");

        using var Fs = new FileStream("analysis.csv", FileMode.Create, FileAccess.Write, FileShare.Read);
        using var Writer = new StreamWriter(Fs, Encoding.UTF8, bufferSize: 1024);

        string TopAllWord = "";
        int MaxOccurence = 0;

        foreach (var Filepath in Directory.EnumerateFiles(Dir, "*.txt"))
        {
            var Fi = new FileInfo(Filepath);

            string Name = Fi.Name;
            int LinesCount = File.ReadAllLines(Filepath).Length;

            int LettersCount =  File.ReadAllText(Filepath).Count(c => !char.IsWhiteSpace(c));

            int WordsCount = 0;
            Dictionary<string, int> AllWords = [];
            using var FsTxt = new FileStream(Filepath, FileMode.Open, FileAccess.Read);
            using var TxtReader = new StreamReader(FsTxt, Encoding.UTF8, bufferSize: 1024);

            string? line;
            while ((line = TxtReader.ReadLine()) != null)
            {
                string[] WordsInLine = line.Split(" ");
                foreach (string word in WordsInLine)
                {
                    string StripWord = word.StripPunctuation();
                    if (StripWord == "") continue;
                    if (AllWords.ContainsKey(StripWord))
                    {
                        AllWords[StripWord] += 1;
                    }
                    else
                    {
                        AllWords[StripWord] = 1;
                    }
                }
                WordsCount += WordsInLine.Length;
            }

            Dictionary<string, int> TopTenWords = AllWords.OrderByDescending(w => w.Value).Take(10).ToDictionary();
            List<string> TenWords = [];
            foreach (var word in TopTenWords)
            {
                TenWords.Add(word.Key);
                if (word.Value > MaxOccurence)
                {
                    TopAllWord = word.Key;
                    MaxOccurence = word.Value;
                }
            }

            AllLinesCount += LinesCount;
            AllWordsCount += WordsCount;

            Writer.WriteLine($"{Name},{WordsCount},{LinesCount},{LettersCount},{string.Join(" ", TenWords)}");
        }

        using var FsSummary = new FileStream("summary.txt", FileMode.Create, FileAccess.Write, FileShare.None);
        using var WriterSummary = new StreamWriter(FsSummary, Encoding.UTF8, bufferSize: 1024);

        WriterSummary.WriteLine($"Analyzováno souborů: {FileCount}");
        WriterSummary.WriteLine($"Celkem řádků: {AllLinesCount}");
        WriterSummary.WriteLine($"Celkem slov: {AllWordsCount}");
        WriterSummary.WriteLine($"Nejčastější slovo: {TopAllWord}");
    }
}