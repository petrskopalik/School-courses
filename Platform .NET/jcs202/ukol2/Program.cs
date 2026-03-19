using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
class Ukol
{
    // TEACHER'S CODE FOR TASK 
    public record Course(int Id, string Code, string Title, int Credits, string Department);
    public record Lecturer(int Id, string FullName, string Department);
    public record Room(int Id, string Building, string RoomNumber, int Capacity);
    public record ClassSlot(int Id, int CourseId, int LecturerId, int RoomId,
                            DayOfWeek Day, TimeSpan Start, TimeSpan End, string Type); // Type: "Lecture", "Lab", "Seminar"
    public record Enrollment(int StudentId, int CourseId, int Year, string Program);
    public record Student(int Id, string FullName, string Program, int Year);
    static void Main()
    {
        // --- Data ---

        var courses = new List<Course> {
            new(1, "CS101", "Intro to Programming", 6, "CS"),
            new(2, "CS205", "Data Structures", 5, "CS"),
            new(3, "MATH201", "Linear Algebra", 5, "MATH"),
            new(4, "PHY110", "Physics I", 4, "PHY"),
            new(5, "CS310", "Databases", 5, "CS"),
            new(6, "MATH310", "Probability", 5, "MATH"),
            new(7, "CS330", "Operating Systems", 6, "CS"),
            new(8, "HUM101", "Academic Writing", 3, "HUM"),
        };

        var lecturers = new List<Lecturer> {
            new(1, "Mgr. Adam Novák", "CS"),
            new(2, "Ing. Petra Svobodová", "CS"),
            new(3, "Doc. Jan Dvořák", "MATH"),
            new(4, "PhDr. Eva Horáková", "HUM"),
            new(5, "RNDr. Tomáš Bartoš", "PHY"),
            new(6, "Ing. Karel Krátký", "CS"),
        };

        var rooms = new List<Room> {
            new(1, "B3", "105", 32),
            new(2, "B3", "205", 24),
            new(3, "C1", "014", 40),
            new(4, "A2", "301", 8),   // malá kapacita pro test přeplnění
            new(5, "C1", "120", 50),
            new(6, "B4", "010", 28),
        };

        var classSlots = new List<ClassSlot> {
            new(1,  1, 1, 1, DayOfWeek.Monday,    TimeSpan.Parse("09:00"), TimeSpan.Parse("10:30"), "Lecture"),
            new(2,  2, 2, 4, DayOfWeek.Monday,    TimeSpan.Parse("11:00"), TimeSpan.Parse("12:30"), "Lecture"),
            new(3,  3, 3, 3, DayOfWeek.Tuesday,   TimeSpan.Parse("08:00"), TimeSpan.Parse("09:30"), "Lecture"),
            new(4,  5, 2, 2, DayOfWeek.Tuesday,   TimeSpan.Parse("11:00"), TimeSpan.Parse("13:00"), "Lab"),
            new(5,  7, 6, 6, DayOfWeek.Wednesday, TimeSpan.Parse("09:00"), TimeSpan.Parse("10:30"), "Lecture"),
            new(6,  7, 6, 2, DayOfWeek.Tuesday,   TimeSpan.Parse("10:00"), TimeSpan.Parse("12:00"), "Lab"),
            new(7,  8, 4, 1, DayOfWeek.Thursday,  TimeSpan.Parse("13:00"), TimeSpan.Parse("14:30"), "Seminar"),
            new(8,  4, 5, 3, DayOfWeek.Friday,    TimeSpan.Parse("08:30"), TimeSpan.Parse("10:00"), "Lecture"),
            new(9,  6, 3, 5, DayOfWeek.Monday,    TimeSpan.Parse("15:00"), TimeSpan.Parse("16:30"), "Lecture"),
            new(10, 5, 2, 5, DayOfWeek.Thursday,  TimeSpan.Parse("09:00"), TimeSpan.Parse("10:30"), "Lecture"),
            new(11, 2, 2, 4, DayOfWeek.Wednesday, TimeSpan.Parse("14:00"), TimeSpan.Parse("15:30"), "Seminar"),
            new(12, 1, 1, 1, DayOfWeek.Monday,    TimeSpan.Parse("12:00"), TimeSpan.Parse("13:30"), "Seminar"),
            new(13, 5, 2, 5, DayOfWeek.Friday,    TimeSpan.Parse("15:30"), TimeSpan.Parse("17:00"), "Seminar"),
        };

        var students = new List<Student> {
            new(1,  "Alice Nováková",  "INF", 1),
            new(2,  "Bob Šrámek",      "INF", 1),
            new(3,  "Cyril Dvořák",    "INF", 2),
            new(4,  "Dana Veselá",     "INF", 2),
            new(5,  "Ema Horáková",    "INF", 3),
            new(6,  "Filip Král",      "INF", 3),
            new(7,  "Gita Malá",       "MAT", 2),
            new(8,  "Hynek Pokorný",   "MAT", 1),
            new(9,  "Ivana Procházková","HUM", 1),
            new(10, "Jakub Beneš",     "PHY", 2),
            new(11, "Karolína Černá",  "MAT", 3),
            new(12, "Lukáš Urban",     "INF", 1),
        };

        var enrollments = new List<Enrollment> {
            // CS101
            new(1, 1, 2025, "INF"), new(2, 1, 2025, "INF"), new(3, 1, 2025, "INF"), new(4, 1, 2025, "INF"),
            // CS205 (přeplněná místnost A2/301 kapacita 8) – 10 zápisů
            new(1, 2, 2025, "INF"), new(2, 2, 2025, "INF"), new(3, 2, 2025, "INF"), new(4, 2, 2025, "INF"),
            new(5, 2, 2025, "INF"), new(6, 2, 2025, "INF"), new(7, 2, 2025, "INF"), new(8, 2, 2025, "INF"),
            new(9, 2, 2025, "INF"), new(10, 2, 2025, "INF"),
            // MATH201
            new(11, 3, 2025, "MAT"), new(12, 3, 2025, "MAT"),
            // CS310
            new(5, 5, 2025, "INF"), new(6, 5, 2025, "INF"),
            // MATH310
            new(7, 6, 2025, "MAT"), new(8, 6, 2025, "MAT"),
            // HUM101
            new(9, 8, 2025, "HUM"),
            // PHY110
            new(10, 4, 2025, "PHY"),
        };
        // END TEACHER'S CODE


        // MY CODE
        var one = classSlots
            .Where( cs => cs.Type == "Lab" && cs.Start >= TimeSpan.Parse("10:00") && cs.End <= TimeSpan.Parse("14:00"))
            .Join(courses, cs => cs.CourseId, c => c.Id, (cs, c) => new
            {
                c.Code, cs.RoomId, cs.Start, cs.End
            })
            .Join(rooms, cs => cs.RoomId, r => r.Id, (cs, r) => new
            {
                cs.Code, r.Building, r.RoomNumber, cs.Start, cs.End
            })
            .ToList();

        foreach (var item in one)
        {
            Console.WriteLine($"Laborky z předměty {item.Code} v místnosti {item.Building}/{item.RoomNumber} od {item.Start } do {item.End}");
        }
        Console.WriteLine();

        var two = classSlots
            .OrderBy( cs => cs.Day )
            .ThenBy( cs => cs.Start)
            .Join(courses, cs => cs.CourseId, c => c.Id, (cs, c) => new
            {
                cs.Day, cs.Start, c.Code
            })
            .Take(10)
            .ToList();

        foreach (var item in two)
        {
            Console.WriteLine($"{item.Day} {item.Start} {item.Code}");
        }
        Console.WriteLine();

        var three = classSlots
            .Join(courses, cs => cs.CourseId, c => c.Id, (cs, c) => new
            {
                c.Code,  cs.Type, cs.Day, cs.Start, cs.End, cs.LecturerId, cs.RoomId
            })
            .Join(lecturers, cs => cs.LecturerId, l => l.Id, (cs, l) => new
            {
             cs.Code, cs.Type, cs.Day, cs.Start, cs.End, l.FullName, cs.RoomId   
            })
            .Join(rooms, cs => cs.RoomId, r => r.Id, (cs, r) => new
            {
             cs.Code, cs.Type, cs.Day, cs.Start, cs.End, cs.FullName, r.Building, r.RoomNumber   
            })
            .ToList();

        foreach (var item in three)
        {
            Console.WriteLine($"{item.Code}-{item.Type}-{item.Day} {item.Start}-{item.End}-{item.FullName}-{item.Building}/{item.RoomNumber}");
        }
        Console.WriteLine();

        var four = enrollments
            .Join(courses, e => e.CourseId, c => c.Id, (e, c) => new
            {
                e.Program, c.Credits
            })
            .GroupBy( c => new
            {
                c.Program
            })
            .Select( g => new
            {
                g.Key.Program,
                SumCredits = g.Sum( g => g.Credits)
            })
            .ToList();
        
        foreach (var item in four)
        {
            Console.WriteLine($"Program {item.Program}:{item.SumCredits}");
        }
        Console.WriteLine();

        var five = classSlots
            .Join(courses, cs => cs.CourseId, c => c.Id, (cs, c) => new
            {
                cs.RoomId, c.Id
            })
            .Join(rooms, cs => cs.RoomId, r => r.Id, (cs, r) => new
            {
                r.Capacity, cs.Id
            })
            .Select(item => enrollments.Count( e => e.CourseId == item.Id) > item.Capacity)
            .Any();

        Console.WriteLine(five);
        Console.WriteLine();

        var RoomsB3 = rooms
            .Where(r => r.Building == "B3")
            .Select(r => r.Id)
            .ToList();
        
        var RoomsC1 = rooms
            .First(r => r.Building == "C1");

        var NewClassSlots = classSlots
            .Select(cs => RoomsB3.Contains(cs.RoomId)
                ? cs with { RoomId = RoomsC1.Id }
                : cs)
            .Join(courses, cs => cs.CourseId, c => c.Id, (cs, c) => new
            {
                cs.RoomId, c.Code, cs.Day, cs.Start
            })
            .Join(rooms, cs => cs.RoomId, r => r.Id, (cs, r) => new
            {
                cs.Code, r.Building, r.RoomNumber, cs.Day, cs.Start
            })
            .ToList();

        foreach (var item in NewClassSlots)
        {
            Console.WriteLine($"{item.Code} v {item.Building}/{item.RoomNumber} v {item.Day} od {item.Start}");
        }
        Console.WriteLine();
    }
}