-- =========================================================================
-- 1. CREATE USERS TABLE
-- =========================================================================
create table users (
user_id int primary key,
full_name varchar(100) not null,
email varchar(100) unique not null,
role varchar(30) not null,
phone_number varchar(20),

constraint chk_user_role
check (role in ('Ticket Manager', 'Football Fan'))

);

-- =========================================================================
-- 2. CREATE MATCHES TABLE
-- =========================================================================
create table matches (
  match_id int primary key,
  fixture varchar(150) not null,
  tournament_category varchar(100) not null,
  base_ticket_price decimal(10, 2) not null,
  match_status varchar(30) not null,
  constraint chk_ticket_price check (base_ticket_price >= 0),
  constraint chk_match_status check (
    match_status in (
      'Available',
      'Selling Fast',
      'Sold Out',
      'Postponed'
    )
  )
);

-- =========================================================================
-- 3. CREATE BOOKINGS TABLE
-- =========================================================================
create table bookings (
booking_id int primary key,
user_id int not null,
match_id int not null,
seat_number varchar(20),
payment_status varchar(20),
total_cost decimal(10,2) not null,

constraint fk_booking_user
foreign key (user_id)
references users(user_id),

constraint fk_booking_match
foreign key (match_id)
references matches(match_id),

constraint chk_total_cost
check (total_cost >= 0),

constraint chk_payment_status
check (
    payment_status in (
        'Pending',
        'Confirmed',
        'Cancelled',
        'Refunded'
    )
    or payment_status is null
)

);