# 🎓 Student Management – EF Core Migrations Demo

Dette projekt demonstrerer brugen af **Entity Framework Core (EF Core)** med både  
**change-based migrations** (Code-First) og **state-based migrations** (SQL-scripts).

Projektet er bygget som en simpel **.NET Console Application**.

---

## 🚀 Core Concepts & Setup

### 1. Projektinitialisering

Projektet blev startet med:

```bash
dotnet new console -n StudentManagement
```

Herefter blev et Git repository oprettet, og `.gitignore` blev genereret med:

```bash
dotnet new gitignore
```

### 2. Data model

Projektet har tre centrale entiteter:

- **Student**

  - Id
  - FirstName
  - LastName
  - Email
  - EnrollmentDate
  - DateOfBirth
  - PhoneNumber
  - Address
  - Gender

- **Course**

  - Id
  - Title
  - Credits

- **Enrollment**
  - Id
  - StudentId
  - CourseId
  - Grade

Disse entiteter er defineret i mappen `Models/`.

### 3. DbContext

`StudentContext` er defineret i `Data/StudentContext.cs` og konfigureret til SQLite:

```csharp
protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
{
    optionsBuilder.UseSqlite("Data Source=studentmanagement.db");
}
```

---

## 🔀 Change-based migrations (EF Core Code-First)

EF Core CLI bruges til at generere migrations, som repræsenterer ændringer i datamodellen.

### Eksempelkommandoer

```bash
dotnet ef migrations add InitialCreate
dotnet ef database update
```

### Oprettede migrationer i dette projekt

1. **InitialCreate** – Opretter tabellerne `Students`, `Courses`, `Enrollments`
2. **AddDateOfBirthToStudent** – Tilføjer feltet `DateOfBirth`
3. **AddPhoneToStudent** – Tilføjer feltet `PhoneNumber`
4. **AddAddressToStudent** – Tilføjer feltet `Address`
5. **AddGenderToStudent** – Tilføjer feltet `Gender`

### Resultat

Hver gang en migration blev oprettet og databasen opdateret, blev tabellen `Students` udvidet med nye felter.

Programmet (`Program.cs`) indsætter automatisk en **teststudent** eller opdaterer en eksisterende student med de nyeste felter.

---

## 📜 State-based migrations (SQL-scripts)

Udover change-based migrations kan man generere SQL-scripts, som repræsenterer  
databasens tilstand mellem to specifikke migrationer.

### Hele migrationshistorikken som SQL

```bash
dotnet ef migrations script -o migration.sql
```

Dette genererer et fuldt script fra **første migration** til den seneste.

### Incrementelt script mellem to migrationer

```bash
dotnet ef migrations script AddPhoneToStudent AddGenderToStudent -o StudentUpdate.sql
```

Dette script viser kun ændringen, hvor `Gender` blev tilføjet efter `PhoneNumber`.

---

## ✅ Kørselsoutput

Når programmet køres med `dotnet run`, ser man enten:

- Første gang:

  ```
  ✅ New information added to database!
  ```

- Efterfølgende kørsel (opdaterer eksisterende student):
  ```
  ✅ Existing student updated with phone and address!
  ```

---

## 📚 Erfaring og konklusion

- **Change-based migrations** giver et revisionsspor, hvor man kan se hvornår felter er tilføjet.
- **State-based migrations** er nyttige til at generere scripts til produktion, f.eks. ved kun at deploye ændringer mellem to specifikke migrationer.
- Kombinationen af begge tilgange giver fleksibilitet:
  - Change-based → god til udvikling
  - State-based → god til deployment

---

## 🔧 Teknologistak

- .NET 9 Console Application
- Entity Framework Core
- SQLite database
- EF Core CLI
