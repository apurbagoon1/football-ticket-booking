# Football Ticket Booking System - Database Design & SQL Queries

## Project Overview

This project is a simplified Football Ticket Booking System designed to demonstrate database design concepts, Entity Relationship Diagram (ERD) modeling, and SQL query implementation.

The system manages football fans purchasing tickets for matches, stores match information, and records booking transactions.

---

## Objectives

By completing this project, the following database concepts are demonstrated:

* Database table design
* Primary Key and Foreign Key implementation
* Referential Integrity
* One-to-Many and Many-to-One relationships
* ERD (Entity Relationship Diagram) design
* SQL filtering and searching
* JOIN operations
* NULL handling
* Aggregate functions
* Subqueries
* Pagination using LIMIT and OFFSET

---

## Database Schema

### 1. Users Table

Stores information about platform users including football fans and ticket managers.

| Column       | Description                     |
| ------------ | ------------------------------- |
| user_id      | Unique identifier for each user |
| full_name    | User's full name                |
| email        | User's email address            |
| role         | Ticket Manager or Football Fan  |
| phone_number | Contact phone number            |

---

### 2. Matches Table

Stores football match information and ticket availability.

| Column              | Description                                     |
| ------------------- | ----------------------------------------------- |
| match_id            | Unique identifier for each match                |
| fixture             | Competing teams                                 |
| tournament_category | League or tournament name                       |
| base_ticket_price   | Standard ticket price                           |
| match_status        | Available, Selling Fast, Sold Out, or Postponed |

---

### 3. Bookings Table

Stores ticket booking transactions.

| Column         | Description                             |
| -------------- | --------------------------------------- |
| booking_id     | Unique booking identifier               |
| user_id        | References Users table                  |
| match_id       | References Matches table                |
| seat_number    | Allocated seat                          |
| payment_status | Pending, Confirmed, Cancelled, Refunded |
| total_cost     | Final booking cost                      |

---

## Relationships

### One-to-Many

#### Users → Bookings

One user can create multiple bookings.

```text
Users (1) --------< Bookings (Many)
```

---

#### Matches → Bookings

One match can have multiple bookings.

```text
Matches (1) --------< Bookings (Many)
```

---

### Many-to-One

#### Bookings → Users

Many bookings can belong to one user.

```text
Bookings (Many) --------> Users (1)
```

---

#### Bookings → Matches

Many bookings can belong to one match.

```text
Bookings (Many) --------> Matches (1)
```

---

### Logical One-to-One

Each booking record connects exactly one user to one specific match for a reserved seat.

---

## Constraints Implemented

### Users

* Primary Key: `user_id`
* Unique Constraint: `email`
* Check Constraint on `role`

### Matches

* Primary Key: `match_id`
* Check Constraint on `base_ticket_price`
* Check Constraint on `match_status`

### Bookings

* Primary Key: `booking_id`
* Foreign Key: `user_id`
* Foreign Key: `match_id`
* Check Constraint on `total_cost`
* Check Constraint on `payment_status`

---

## SQL Queries Implemented

### Query 1

Retrieve available Champions League matches.

### Query 2

Search users by name using `ILIKE`.

### Query 3

Handle NULL payment statuses using `COALESCE`.

### Query 4

Retrieve booking details using `INNER JOIN`.

### Query 5

Display all users including those without bookings using `LEFT JOIN`.

### Query 6

Find bookings with total cost above average using a subquery and `AVG()`.

### Query 7

Retrieve the top expensive matches while skipping the highest-priced match using `LIMIT` and `OFFSET`.

---

