namespace StudentManagement.Models
{
    public class Enrollment
    {
        public int Id { get; set; }
        public int StudentId { get; set; }
        public int CourseId { get; set; }
        public string FinalGrade { get; set; } = string.Empty;


        public Student? Student { get; set; }
        public Course? Course { get; set; }
    }
}
