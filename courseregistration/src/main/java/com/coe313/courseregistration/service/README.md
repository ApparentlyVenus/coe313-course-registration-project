# Service Layer — Implementation Guide

Your job is to fill in the TODO blocks in each service file.
Controllers, config, and infrastructure are already done — don't touch those.

---

## Project Structure
```
src/main/java/com/coe313/courseregistration/
├── config/         → DO NOT TOUCH
├── controller/     → DO NOT TOUCH
├── dto/            → DO NOT TOUCH
├── entity/         → DO NOT TOUCH
├── exception/      → DO NOT TOUCH
├── repository/     → DO NOT TOUCH
└── service/        → YOUR CODE GOES HERE
```

---

## How Repositories Work

You never write SQL. Call repository methods directly.

Every repository has these built in:
```java
repository.findAll()              // get all rows
repository.findById(id)           // returns Optional<T>
repository.save(entity)           // INSERT or UPDATE
repository.delete(entity)         // DELETE
repository.existsById(id)         // returns boolean
```

For Optional, always unwrap like this:
```java
Course course = courseRepository.findById(id)
    .orElseThrow(() -> new IllegalArgumentException("Course not found"));
```

Custom methods per repository are documented in each repository file.

---

## How to Throw Errors

GlobalExceptionHandler catches these automatically:
```java
throw new IllegalArgumentException("message");  // 404 — resource doesn't exist
throw new IllegalStateException("message");     // 409 — business rule violated
```

---

## How to Map Entity → DTO

Never return raw entities. Convert to the response DTO manually by
calling getters on the entity and setters on the DTO.

For nested objects (e.g. course.getDepartment().getName()) just drill in.
For collections (e.g. prerequisites) use .stream().map().collect().

---

## EnrollmentService

`enroll()` is the most important method. implement checks in this order:

1. **Duplicate check** — is student already in this course this semester?
2. **Prerequisite check** — has student completed all prereqs? traverse the prereq graph recursively (BFS/DFS). `course.getPrerequisites()` gives direct prereqs, each of those has their own.
3. **Schedule conflict** — do any existing enrolled sections overlap on the same day? overlap condition: `A.start < B.end AND A.end > B.start`
4. **Capacity check** — count enrolled (not waitlisted) students. if count < capacity → enrolled, otherwise → waitlisted

`drop()` — after dropping, check if anyone is waitlisted for that section. if yes, promote the one with the earliest `enrolledAt` (FIFO queue).

---

## Which Repositories Each Service Needs

| Service | Repositories |
|---|---|
| CourseService | CourseRepository, DepartmentRepository |
| SectionService | SectionRepository, CourseRepository, ProfessorRepository, SemesterRepository, EnrollmentRepository |
| ScheduleService | ScheduleRepository, SectionRepository |
| EnrollmentService | EnrollmentRepository, SectionRepository, StudentRepository, UserRepository, CourseRepository |
| StudentService | StudentRepository |

---

## Resolving Email → Student

Student-facing methods receive the logged-in user's email.
Use UserRepository to find the User, then StudentRepository to find the Student.
Both repositories have the methods you need — check the repository files.

---

## Enrollment Status Reference

Enrollment status is just an enum in the Enrollment entity.

```java
Enrollment.Status.enrolled
Enrollment.Status.waitlisted
Enrollment.Status.dropped
```
