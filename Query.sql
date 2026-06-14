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


-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO USERS
-- =========================================================================
insert into users (user_id, full_name, email, role, phone_number) values
(1, 'Tanvir Rahman', 'tanvir@mail.com', 'Football Fan', '+8801711111111'),
(2, 'Asif Haque', 'asif@mail.com', 'Football Fan', '+8801722222222'),
(3, 'Sajjad Rahman', 'sajjad@mail.com', 'Ticket Manager', '+8801733333333'),
(4, 'Jannat Ara', 'jannat@mail.com', 'Football Fan', null);

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO MATCHES
-- =========================================================================
insert into matches (match_id, fixture, tournament_category, base_ticket_price, match_status) values
(101, 'Real Madrid vs Barcelona', 'Champions League', 150.00, 'Available'),
(102, 'Man City vs Liverpool', 'Premier League', 120.00, 'Selling Fast'),
(103, 'Bayern Munich vs PSG', 'Champions League', 130.00, 'Available'),
(104, 'AC Milan vs Inter Milan', 'Serie A', 90.00, 'Sold Out'),
(105, 'Juventus vs Roma', 'Serie A', 80.00, 'Available');

-- =========================================================================
-- DATA SEEDING: INSERT SAMPLE DATA INTO BOOKINGS
-- =========================================================================
insert into bookings (booking_id, user_id, match_id, seat_number, payment_status, total_cost) values
(501, 1, 101, 'A-12', 'Confirmed', 150.00),
(502, 1, 102, 'B-04', 'Confirmed', 120.00),
(503, 2, 101, 'A-13', 'Confirmed', 150.00),
(504, 2, 101, null, null, 150.00),
(505, 3, 102, 'C-20', 'Pending', 120.00);



-- Query 1 --

select
match_id,
fixture,
base_ticket_price
from matches
where tournament_category = 'Champions League'
and match_status = 'Available';


-- Query 2 --

select
user_id,
full_name,
email
from users
where full_name ilike 'Tanvir%'
or full_name ilike '%Haque%';


-- Query 3 --

select
booking_id,
user_id,
match_id,
coalesce(payment_status, 'Action Required')
as systematic_status
from bookings
where payment_status is null;


-- Query 4 --

select
  b.booking_id,
  u.full_name,
  m.fixture,
  b.total_cost
from
  bookings as b
  inner join users as u on b.user_id = u.user_id
  inner join matches as m on b.match_id = m.match_id;    


-- Query 5 --

select
  u.user_id,
  u.full_name,
  b.booking_id
from
  users as u
  left join bookings as b on u.user_id = b.user_id
order by
  u.user_id;