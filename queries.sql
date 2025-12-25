-- create users table

-- CREATE TABLE IF NOT EXISTS users (
-- user_id SERIAL PRIMARY KEY,
-- name VARCHAR(50) NOT NULL,
-- email VARCHAR(50) UNIQUE NOT NULL,
-- password TEXT NOT NULL,
-- phone VARCHAR(15) NOT NULL,
-- role VARCHAR(20) NOT NULL CHECK (role IN ('Admin', 'Customer'))
-- );


-- insert user data

-- insert into
-- users (name, email, phone, role, password)
-- values
-- (
-- 'Alice',
-- 'alice@gmail.com',
-- '1234567890',
-- 'Customer',
-- '12345'
-- ),
-- (
-- 'Bob',
-- 'bob@gmail.com',
-- '0987654321',
-- 'Admin',
-- '12345'
-- ),
-- (
-- 'Charlie',
-- 'charlie',
-- '0123456789',
-- 'Customer',
-- '54321'
-- ),
-- (
-- 'Rahim',
-- 'rahim@gmail.com',
-- '01712345',
-- 'Customer',
-- '54321'
-- ),
-- ('karim', 'karim', '0183456789', 'Admin', '584747');


-- create vehicle table

-- CREATE TABLE IF NOT EXISTS vehicles (
-- vehicle_id SERIAL PRIMARY KEY,
-- name VARCHAR(50) NOT NULL,
-- type VARCHAR(20) NOT NULL CHECK (type IN ('car', 'bike', 'truck')),
-- model VARCHAR(20) NOT NULL,
-- registration_number VARCHAR(100) UNIQUE NOT NULL,
-- rental_price INT NOT NULL,
-- status VARCHAR(30) NOT NULL CHECK (status IN ('available', 'rented', 'maintenance','booking'))
-- );

-- insert vehicles data

-- INSERT INTO
-- vehicles (
-- name,
-- type,
-- model,
-- registration_number,
-- rental_price,
-- status
-- )
-- VALUES
-- (
-- 'Toyota Corolla',
-- 'car',
-- '2022',
-- 'DHA-1234',
-- 3500.00,
-- 'available'
-- ),
-- (
-- 'Honda Civic',
-- 'car',
-- '2023',
-- 'DHA-5678',
-- 4000.00,
-- 'maintenance'
-- ),
-- (
-- 'Yamaha R15',
-- 'bike',
-- '2024',
-- 'CTG-1122',
-- 1200.00,
-- 'available'
-- ),
-- (
-- 'Suzuki Gixxer',
-- 'bike',
-- '2025',
-- 'SYL-3344',
-- 1100.00,
-- 'rented'
-- ),

-- (
-- 'Toyota Hiace',
-- 'truck',
-- '2020',
-- 'KHU-7788',
-- 5500.00,
-- 'available'
-- );


  -- create bookings table---

  -- CREATE TABLE IF NOT EXISTS bookings (
  -- booking_id SERIAL PRIMARY KEY,
  -- user_id INT NOT NULL REFERENCES users (user_id) ON DELETE CASCADE,
  -- vehicle_id INT NOT NULL REFERENCES vehicles (vehicle_id) ON DELETE CASCADE,
  -- start_date DATE NOT NULL,
  -- end_date DATE NOT NULL CHECK (end_date > start_date),
  -- status VARCHAR(20) NOT NULL CHECK (
  -- status IN ('pending', 'confirmed', 'completed', 'cancelled')
  -- ),
  -- total_cost INT NOT NULL CHECK (total_cost > 0)
  -- );
  
  -- insert bookings data--

  -- INSERT INTO
  -- bookings (
  -- user_id,
  -- vehicle_id,
  -- start_date,
  -- end_date,
  -- status,
  -- total_cost
  -- )
  -- VALUES
  -- (
  -- '1',
  -- '1',
  -- '2025-01-05',
  -- '2025-01-07',
  -- 'confirmed',
  -- 700
  -- ),
  -- (
  -- '2',
  -- '2',
  -- '2025-01-10',
  -- '2025-01-12',
  -- 'pending',
  -- 800
  -- ),
  -- (
  -- '3',
  -- '3',
  -- '2025-01-15',
  -- '2025-01-18',
  -- 'confirmed',
  -- 100
  -- ),
  -- (
  -- '4',
  -- '4',
  -- '2025-01-20',
  -- '2025-01-22',
  -- 'completed',
  -- 600
  -- ),
  -- (
  -- '5',
  -- '5',
  -- '2025-01-25',
  -- '2025-01-28',
  -- 'cancelled',
  -- 900
  -- );
 
  -- Query 1: JOIN
  -- Requirement: Retrieve booking information along with Customer name and Vehicle name.

  SELECT
  b.booking_id,
  u.name AS customer_name,
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.status
  FROM
  bookings b
  JOIN users u ON b.user_id = u.user_id
  JOIN vehicles v ON b.vehicle_id = v.vehicle_id;

-- Query 2: EXISTS
-- Requirement: Find all vehicles that have never been booked.

  WHERE
  EXISTS (
  SELECT *
  FROM
  bookings
  WHERE
  bookings.vehicle_id = vehicles.vehicle_id
  );

-- Query 3: WHERE
-- Requirement: Retrieve all available vehicles of a specific type (e.g. cars).
SELECT *
 FROM
  vehicles
  WHERE
  type = 'car'
  AND status = 'available';

-- Query 4: GROUP BY and HAVING
-- Requirement: Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

SELECT
v.name AS vehicle_name,
COUNT(b.booking_id) AS total_bookings
FROM vehicles v
JOIN bookings b
ON b.vehicle_id = v.vehicle_id
GROUP BY v.name
HAVING COUNT(b.booking_id) > 2;
