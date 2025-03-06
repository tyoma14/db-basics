-- Сеанс 1
begin;
set transaction isolation level repeatable read;

select count(*) from bookings
where total_amount = 20000;


-- Сеанс 2
begin;
set transaction isolation level repeatable read;

select count(*) from bookings
where total_amount = 30000;


-- Сеанс 1
insert into bookings(book_ref, book_date, total_amount)
values ('ex6_61', now(), 30000);

select count(*) from bookings
where total_amount = 20000;


-- Сеанс 2
insert into bookings(book_ref, book_date, total_amount)
values ('ex6_62', now(), 20000);

select count(*) from bookings
where total_amount = 30000;


-- Сеанс 1
end;


-- Сеанс 2
end;

-- Соответствует. Сериализовать транзакции нельзя. При параллельном выполнении 
-- транзакций вычисляемое кол-во бронирований в обеих тразакциях останется тем же, 
-- т.к. добавленные бронирования ещё не были зафиксированы. При последовательном 
-- выполнении одна из транзакций будет зафиксирована и во второй транзакции вычисляемое 
-- кол-во бронирований будет на единицу больше.