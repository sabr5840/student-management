namespace StudentManagement.Models
{
    public class Instructor
    {
        public int Id { get; set; }
        public string FirstName { get; set; } = string.Empty;
        public string LastName { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public DateTime HireDate { get; set; }

        
        public ICollection<Course> Courses { get; set; } = new List<Course>();
    }
}
