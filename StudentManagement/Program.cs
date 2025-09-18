using StudentManagement.Data;
using StudentManagement.Models;

using (var context = new StudentContext())
{
    context.Database.EnsureCreated();

    if (!context.Students.Any())
    {
        var student = new Student
        {
            FirstName = "Sabrina",
            LastName = "Hammersichebbesen",
            Email = "sabrina@example.com",
            EnrollmentDate = DateTime.Now,
            DateOfBirth = new DateTime(2001, 8, 19), 
            PhoneNumber = "12345678",                
            Address = "123 Main St, City, Country",
            Gender = "Female"   
        };

        context.Students.Add(student);
        context.SaveChanges();

        Console.WriteLine("✅ New information added to database!");
    }
    else
    {
        var student = context.Students.First();
        student.PhoneNumber = "12345678";
        student.Address = "123 Main St, City, Country";
        context.SaveChanges();

        Console.WriteLine("✅ Existing student updated with phone and address!");
    }

}
