using System.Text.Json.Serialization;
using System.Text.RegularExpressions;

namespace jcs205
{
    public partial class Book
    {
        private string _title = "";
        [JsonPropertyName("title")]
        public string Title
        {
            get => _title;
            init
            {
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentException("Empty title");
                }
                _title = value;
            }
        }
        private string _author = "";
        [JsonPropertyName("author")]
        public string Author
        {
            get => _author;
            init
            {
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentException("Empty author");
                }
                _author = value;
            }
        }
        private int _year;
        [JsonPropertyName("year")]
        public int Year
        { 
            get => _year; 
            init
            {
                if (value < 1450 && value > DateTime.Now.Year)
                {
                    throw new ArgumentException("Year should be between 1450 and actual year");
                }

                _year = value;
            }
        }
        [GeneratedRegex(@"^((97[89]\d{10})|(\d{9}[\dX]))$")]
        private static partial Regex MyRegex();
        private string _isbn = "";
        [JsonPropertyName("isbn")]
        public string ISBN
        { 
            get => _isbn; 
            init
            {
                if (!MyRegex().IsMatch(value))
                {
                    throw new ArgumentException("Invalid ISBN");
                }

                _isbn = value;
            } 
        }
        private string _genre = "";
        [JsonPropertyName("genre")]
        public string Genre
        {
            get => _genre;
            init
            {
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentException("Empty genre");
                }
                _genre = value;
            }
        }
        private float _rating;
        [JsonPropertyName("rating")]
        public float Rating
        {
            get => _rating;
            init
            {
                if (value < 0 && value > 10)
                {
                    throw new ArgumentException("Rating is out of range");
                }

                _rating = value;
            }
        }
        private int _pages;
        [JsonPropertyName("pages")]
        public int Pages
        {
            get => _pages;
            init
            {
                if (value < 1)
                {
                    throw new ArgumentException("Value of Pages is out of range");
                }
                _pages = value;
            }
        }
    }
}