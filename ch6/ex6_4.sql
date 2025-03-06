select * from bookings where total_amount = 1000;

-- сеанс 1
begin;

update bookings
set total_amount = 2 * total_amount
where total_amount = 1000; 

-- сеанс 2
begin;

insert into bookings(book_ref, book_date, total_amount)
values ('ex6_4', now(), 1000);

end;

-- сеанс 1
update bookings
set total_amount = 2 * total_amount
where total_amount = 1000; 

end;

select * from bookings
where book_ref = 'ex6_4';

-- Нет, т.к. при уровне изоляции Read Committed в транзакции 1 
-- видны изменения, зафиксированные транзакцией 2