begin;

insert into bookings(book_ref, book_date, total_amount)
values ('abc123', now(), 100500.88);
select * from bookings where book_ref='abc123';

savepoint svp; 

insert into tickets(ticket_no, book_ref, passenger_id, passenger_name)
values ('1234567898765', 'abc123', '12345678987654321', 'Max Petrov');

savepoint svp; 

insert into tickets(ticket_no, book_ref, passenger_id, passenger_name)
values ('9876543212345', 'abc123', '98765432123456789', 'Mikhail Nikitin');

select * from tickets where book_ref='abc123';

rollback to svp;

select * from bookings where book_ref='abc123';
select * from tickets where book_ref='abc123';