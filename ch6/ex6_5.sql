select * from bookings where total_amount = 1000;

-- сеанс 1
begin;

set transaction isolation level repeatable read;

update bookings
set total_amount = 2 * total_amount
where total_amount = 1000; 

-- сеанс 2
begin;

insert into bookings(book_ref, book_date, total_amount)
values ('ex6_5', now(), 1000);

end;

-- сеанс 1
update bookings
set total_amount = 2 * total_amount
where total_amount = 1000; 

end;

select * from bookings
where book_ref = 'ex6_5';

-- строки не обновляются, т.к. при уровне изоляции repeatable read
-- повторное выполнение операций поиска и выборки данных дает такие 
-- же результаты, как первое