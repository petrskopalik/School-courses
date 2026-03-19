using System.Text.Json;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Schema;

namespace jcs205
{
    class Program
    {
        static public int Main()
        {
            string json = File.ReadAllText("books.json");
            var Library = JsonSerializer.Deserialize<List<Book>>(json) ?? throw new ArgumentNullException("Library is null");

            // Test
            // foreach (var book in Library)
            // {
            //     Console.WriteLine($"Title: {book.Title} by author: {book.Author}");
            // }  

            var OrganizedLibrary = Library
                .GroupBy(b => b.Genre)
                .Select(g => new
                {
                    Genre = g.Key,
                    Count = g.Count(),
                    AvgRating = Math.Round(g.Average(b => b.Rating), 2),
                    Books = g.OrderByDescending(b => b.Rating)
                            .ThenBy(b => b.Year)
                            .ToList()
                });
            
            XNamespace xsi = "http://www.w3.org/2001/XMLSchema-instance";

            var xml = new XDocument(
                new XDeclaration("1.0", "utf-8", null),
                new XElement("Library",
                    new XAttribute(XNamespace.Xmlns + "xsi", xsi),
                    new XAttribute(xsi + "noNamespaceSchemaLocation", "http://www.fio.cz//schema/importDB.xsd"),
                    OrganizedLibrary.Select(g =>
                        new XElement("Genre",
                            new XAttribute("name", g.Genre),
                            new XAttribute("count", g.Count),
                            new XAttribute("avgRating", g.AvgRating),
                            g.Books.Select(b =>
                                new XElement("Book",
                                    new XElement("Title", b.Title),
                                    new XElement("Author", b.Author),
                                    new XElement("Year", b.Year),
                                    new XElement("ISBN", b.ISBN),
                                    new XElement("Rating", b.Rating),
                                    new XElement("Pages", b.Pages)
                                )
                            )
                        )
                    )
                )
            );

            var settings = new XmlWriterSettings
            {
                Indent = true,
                IndentChars = "   ",
                Encoding = new System.Text.UTF8Encoding(false)
            };

            using (var writer = XmlWriter.Create("library.xml", settings))
            {
                xml.Save(writer);
            }

            var Schemas = new XmlSchemaSet();
            Schemas.Add(null, "library.xsd");

            var doc = XDocument.Load("library.xml");

            doc.Validate(Schemas, (sendet, e) =>
            {
                throw new XmlException();
            });

            Console.WriteLine("OK");

            return 0;
        }
    }
}