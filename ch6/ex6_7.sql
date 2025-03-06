-- Сеанс 1
begin;
set transaction isolation level serializable;

select count(*) from bookings
where total_amount = 20000;


-- Сеанс 2
begin;
set transaction isolation level serializable;

select count(*) from bookings
where total_amount = 30000;


-- Сеанс 1
insert into bookings(book_ref, book_date, total_amount)
values ('ex6_71', now(), 30000);

select count(*) from bookings
where total_amount = 20000;


-- Сеанс 2
insert into bookings(book_ref, book_date, total_amount)
values ('ex6_72', now(), 20000);

select count(*) from bookings
where total_amount = 30000;


-- Сеанс 1
end;


-- Сеанс 2
end;

-- При попытке завершить вторую транзакцию падает ошибка,
-- т.к. транзакции несериализуемые