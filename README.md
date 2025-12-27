 <!-- SELECT
  b.booking_id,
  u.name AS customer_name,
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.status
  FROM
  bookings b
  JOIN users u ON b.user_id = u.user_id
  JOIN vehicles v ON b.vehicle_id = v.vehicle_id; -->

  এই query টি bookings, users এবং vehicles টেবিল join করে
প্রতিটি booking এর সাথে customer name ও vehicle name দেখায়।
 JOIN ব্যবহার করায় যেসব booking এর valid user ও vehicle আছে শুধুমাত্র সেগুলোই দেখানো হয়।
 <!-- --------------------------------------------------------- -->

  <!-- WHERE
  EXISTS (
  SELECT *
  FROM
  bookings
  WHERE
  bookings.vehicle_id = vehicles.vehicle_id
  ); -->

  EXISTS শুধু চেক করে booking  আছে কি না ।
  যেসব vehicle  এর জন্য bookings  টেবিলে অন্তত একটি row আছে সেগুলো আউটপুট এ আসে ।

  <!-- ------------------------------------------------------------ -->
  <!-- SELECT *
 FROM
  vehicles
  WHERE
  type = 'car'
  AND status = 'available'; -->

  এই query শুধুমাত্র সেইসব vehicle দেখায়:
যাদের type = car
যাদের status = available

<!-- ---------------------------------------------------------- -->

<!-- SELECT
v.name AS vehicle_name,
COUNT(b.booking_id) AS total_bookings
FROM vehicles v
JOIN bookings b
ON b.vehicle_id = v.vehicle_id
GROUP BY v.name
HAVING COUNT(b.booking_id) > 2; -->


এই query:

প্রতিটি vehicle অনুযায়ী booking গুলো group করে

মোট booking সংখ্যা গণনা করে

HAVING ব্যবহার করে শুধুমাত্র ২টির বেশি booking থাকা vehicle দেখায়