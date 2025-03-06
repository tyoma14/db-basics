insert into tickets(ticket_no, book_ref, passenger_id, passenger_name)
values ('9876543212345', 'abc123', '98765432123456789', 'Mikhail Nikitin');

end;

select * from bookings where book_ref='abc123';
select * from tickets where book_ref='abc123';

