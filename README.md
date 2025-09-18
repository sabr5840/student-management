# Student Management – Database Schema Migrations

## Introduction

Dette projekt demonstrerer arbejdet med database schema migrationer ved hjælp af to forskellige strategier:

1. **EF Code-First (change-based migrations)**  
   Her anvendes Entity Framework Core (EF) til at oprette og udvikle databasen gennem kodeændringer i C#-modellerne. Når modellerne ændres, genererer EF migrations, som trin for trin opdaterer databasen.

2. **State-based migrations**  
   Her beskrives den ønskede sluttilstand direkte i SQL-scripts. Ændringer håndteres ved at oprette versionerede SQL-filer (f.eks. `V1__InitialSchema.sql`, `V2__AddMiddleNameToStudent.sql`), der kan køres på databasen for at bringe den i den ønskede tilstand.

Projektet tager udgangspunkt i et simpelt _Student Management System_, der håndterer studerende, kurser, tilmeldinger, undervisere og afdelinger.

---

## Git branching strategy

For at holde EF Code-First og State-based adskilt, blev der oprettet særskilte branches for hver delopgave:

- `feat/schema-changes-ef` indeholder EF Code-First migrationerne.
- `feat/schema-changes-state` og tilhørende feature-branches (fx `feat/schema-changes-state-instructor`) indeholder de SQL-baserede migrationer.

På denne måde er hele arbejdsprocessen dokumenteret i Git-historikken, og det er tydeligt, hvilke ændringer der hører til hvilken strategi.

---

## Schema Changes – EF Code-First

### V1: Initial schema

De første entiteter blev defineret i C#-modeller:

- **Student** (Id, FirstName, LastName, Email, EnrollmentDate)
- **Course** (Id, Title, Credits)
- **Enrollment** (Id, StudentId, CourseId, Grade)

Migrations:

```bash
dotnet ef migrations add InitialSchema
dotnet ef database update
```

### V2: Add MiddleName

Tilføjede en `MiddleName`-kolonne til _Student_.  
Migration: `dotnet ef migrations add AddMiddleNameToStudent`

### V3: Add Instructor relation

Tilføjede en ny _Instructor_ tabel (Id, FirstName, LastName, Email, HireDate) og en relation til _Course_ via `InstructorId`.

### V4: Rename Grade → FinalGrade

Kolonnen _Grade_ i _Enrollment_ blev omdøbt til _FinalGrade_.  
Dette blev håndteret med en migration, der ændrede kolonnenavnet.

### V5: Add Department relation

Tilføjede en _Department_ tabel (Id, Name, Budget, StartDate).  
Derudover blev der defineret en relation, så en DepartmentHead altid er en Instructor.

### V6: Modify Course Credits

Kolonnen _Credits_ i _Course_ blev ændret fra `INTEGER` til `DECIMAL(5,2)` for at give mere fleksibilitet.

---

## Schema Changes – State-based

I denne strategi blev der manuelt oprettet SQL-filer under `MigrationsSql/`, én per versionsændring.

### V1\_\_InitialSchema.sql

Opretter tabellerne _Students_, _Courses_ og _Enrollments_ inkl. primærnøgler og fremmednøgler.

### V2\_\_AddMiddleNameToStudent.sql

Tilføjer `MiddleName` til _Students_.

### V3\_\_AddInstructor.sql

Opretter tabellen _Instructor_ og tilføjer relationen til _Courses_.

### V4\_\_RenameGradeToFinalGrade.sql

Ændrer kolonnenavnet i _Enrollments_ fra `Grade` til `FinalGrade`.

### V5\_\_AddDepartment.sql

Opretter tabellen _Department_ og definerer relation til _Instructor_ som DepartmentHead.

### V6\_\_ModifyCourseCredits.sql

Ændrer datatypen for _Credits_ i _Courses_ fra `INTEGER` til `DECIMAL(5,2)`.

---

## Destructive vs. Non-destructive changes

### Rename Grade → FinalGrade

Her er det valgt at køre en direkte omdøbning af kolonnen.  
Dette er en **destructive ændring**, da man ikke bevarer en kopi af den gamle kolonne. Fordelen er, at man undgår redundans og holder skemaet simpelt. Ulempen er, at man mister historikken for navngivningen.

### Modify Course Credits

Ændringen fra `INTEGER` til `DECIMAL(5,2)` kan potentielt være **destructive**, fordi eksisterende data kan ændre type og fortolkning. I praksis er det dog non-destructive, så længe værdierne stadig kan repræsenteres i den nye type. Her er det valgt at ændre typen direkte for at undgå at have dobbeltkolonner og migration scripts, der flytter data.

---

## How to run the project

1. Klon repository.
2. Naviger til `StudentManagement` mappen.
3. Kør:
   ```bash
   dotnet restore
   dotnet ef database update
   dotnet run
   ```

---

## Conclusion

Dette projekt har vist to forskellige måder at håndtere databaseændringer på:

- **EF Code-First (change-based):** godt til inkrementelle ændringer og hurtig udvikling, hvor migrationerne afspejler hvert enkelt trin i udviklingen.
- **State-based:** godt til at dokumentere og kontrollere den endelige database-struktur, især i større teams og produktion, hvor scripts skal kunne køres præcist og reproducerbart.

Begge tilgange har fordele og ulemper, og i praksis kombineres de ofte i professionelle projekter.
