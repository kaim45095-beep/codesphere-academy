# CodeSphere Academy

CodeSphere Academy is a coursework web application for browsing and enrolling in programming courses. It uses **C#**, **ASP.NET Web Forms**, **.NET Framework 4.7.2**, and **SQL Server**.

## Features

- Browse and search the course catalogue, register a learner account, and view your enrolled courses.
- Complete a simulated checkout to create a time-limited enrolment, then open the course portal.
- Manage the course catalogue and user accounts from administrator pages.

## Run locally on Windows

### Prerequisites

- Visual Studio with the **ASP.NET and web development** workload, IIS Express, and support for `.slnx` solution files.
- The **.NET Framework 4.7.2 Developer Pack** or targeting pack.
- **SQL Server Express LocalDB** and either SQL Server Management Studio (SSMS) or `sqlcmd`.

### Set up the database

Open `setup.sql` in SSMS, connect to `(localdb)\MSSQLLocalDB` using Windows Authentication, and execute the script. You can also run this command from the repository root with `sqlcmd` installed:

```powershell
sqlcmd -S '(localdb)\MSSQLLocalDB' -E -b -i setup.sql
```

The script creates `CodeSphereAcademyDemo` with two sample courses and empty `Users` and `Enrollments` tables. If you use a different local SQL Server instance, run the script there and update `CodeSphereConn` in `CodeSphereAcademy/Web.config` to point to it.

### Start the application

1. Open `CodeSphereAcademy.slnx` in Visual Studio.
2. Right-click the solution in Solution Explorer and choose **Restore NuGet Packages**.
3. Set **CodeSphereAcademy** as the startup project if needed. Select **IIS Express** and press **F5**. If Visual Studio opens a directory page, open `Default.aspx` on the local site.
4. Register with a local demo account, open **Courses**, and choose a sample course. Confirm the simulated checkout, then open the course from the **My Courses** tab.

### Try the administrator pages

Register a separate local demo account using `admin-demo@example.test`. In SSMS, connect to your demo database and run:

```sql
USE [CodeSphereAcademyDemo];

UPDATE dbo.Users
SET Role = N'Admin'
WHERE Email = N'admin-demo@example.test';
```

Sign out and sign back in with that account to see the administrator dashboard.

## Project files

- `CodeSphereAcademy/` contains the Web Forms pages, C# code-behind, styles, and project configuration.
- `CodeSphereAcademy.slnx` is the Visual Studio solution.
- `setup.sql` creates the local demo database and sample course catalogue.

Use sample credentials for local demonstrations. This coursework version stores passwords in plain text and uses simulated checkout. A public deployment would require secure password storage.
