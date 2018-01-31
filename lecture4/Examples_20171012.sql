/* 
	Возможности SELECT: задание значения переменных. (см так же SET)
	В данном случае мы выведем полином в привычном Вам виде.
	В БДЗ можно выводить просто в табличном виде.
	Здесь это просто пример работы SELECT, который может быть полезен.
*/

-- чтобы запустить только первую часть, выделите её и нажмите "execute"

DECLARE @Polinom TABLE (id int, pow int, coeff float, primary key(id, pow))
INSERT INTO @Polinom
VALUES (1, 2, 1), (1, 1, 2),  (1, 0, 1)

DECLARE @n INT, @txt nvarchar(100)
SET @n = 0
SET @txt = ''

SELECT @n = @n + pow
FROM @Polinom 

SELECT @n

SELECT @txt = @txt + CAST(coeff as nvarchar(5)) + '*x^' + CAST(pow as nvarchar(5)) + '+'
FROM @Polinom 
WHERE id = 1

SELECT @txt

SELECT REVERSE(STUFF(REVERSE(@txt),1,1,''))

GO

/*
	Запросы c агрегатными функциями и группировкой:
*/
DECLARE @T TABLE (id1 int, id2 int, val int)
INSERT INTO @T VALUES (1, 1, 10), (1, 2, 20), (2, 1, 30)

SELECT MIN(val) МинЗнач, MAX(val) МаксЗнач, 
	COUNT(val) Колво1, COUNT(*) Строк, 
	SUM(val) СуммЗнач, AVG(val) СрЗнач
FROM @T

SELECT id1, MIN(val) МинЗнач
FROM @T
GROUP BY id1

SELECT id1, id2, MIN(val) МинЗнач
FROM @T
GROUP BY id1, id2

GO

/* Еще больше примеров группировки*/

DECLARE @Документы TABLE (Ндок int, Пок_ID int, Сумма float)
INSERT INTO @Документы
VALUES (1, 1, 1), (2, 3, 10), (3, 2, 14), (4, 1, 20), (5, 2, 21)

SELECT COUNT(Пок_ID) Строк, COUNT (distinct Пок_ID) УникПокупателей
FROM @Документы

SELECT Пок_ID, MIN(Сумма) МинСумма, SUM(Сумма) СуммСумма
FROM @Документы
GROUP BY Пок_ID

GO

/*
	Есть ли разница в запросах?
*/

-- таблица та же, что выше. Вынесена сюда специально для удобства просмотра и запуска части запроса
/* обратите внимание, что можно запускать только часть скрипта, выделив нужное место 
(не забудьте выделить и объявление таблицы)
*/
DECLARE @Документы TABLE (Ндок int, Пок_ID int, Сумма float)
INSERT INTO @Документы
VALUES (1, 1, 1), (2, 3, 10), (3, 2, 14), (4, 1, 20), (5, 2, 21)

SELECT Пок_ID
FROM @Документы
GROUP BY Пок_ID

SELECT distinct Пок_ID
FROM @Документы

GO

/*
	Что выдадут запросы:
*/

DECLARE @Документы TABLE (Ндок int, Пок_ID int, Сумма float)
INSERT INTO @Документы
VALUES (1, 1, 1), (2, 3, 10), (3, 2, 14), (4, 1, 20), (5, 2, 21)

SELECT Пок_ID, SUM (Сумма) as S
FROM @Документы
GROUP BY Пок_ID

SELECT SUM (Сумма) as S
FROM @Документы
GROUP BY Пок_ID

SELECT SUM (Сумма)
FROM @Документы

SELECT Пок_ID, ндок, SUM(Сумма) 
FROM @Документы 
GROUP BY Пок_ID, ндок

GO

/*
	Использование WHERE и HAVING
	Есть ли разница?
*/

DECLARE @Документы TABLE (Ндок int, Пок_ID int, Сумма float)
INSERT INTO @Документы
VALUES (1, 1, 1), (2, 3, 10), (3, 2, 14), (4, 1, 20), (5, 2, 21)

SELECT Пок_ID, SUM (Сумма)
FROM @Документы
WHERE Пок_ID = 1
GROUP BY Пок_ID

SELECT Пок_ID, SUM (Сумма)
FROM @Документы
GROUP BY Пок_ID
HAVING Пок_ID = 1

GO

/*
	Сравните результаты
*/

DECLARE @Документы TABLE (Ндок int, Пок_ID int, Сумма float)
INSERT INTO @Документы
VALUES (1, 1, 100), (2, 1, 50), (3, 2, 120) -- другая таблица Документов !!!!

SELECT Пок_ID, SUM (Сумма)
FROM @Документы
WHERE Сумма > 100
GROUP BY Пок_ID

SELECT Пок_ID, SUM (Сумма)
FROM @Документы
GROUP BY Пок_ID
HAVING SUM (Сумма) > 100

SELECT Пок_ID, SUM (Сумма)
FROM @Документы
GROUP BY Пок_ID
HAVING MIN (Сумма) > 100

GO

/*
	Что будет результатом выполнения следующего запроса?
*/

DECLARE @T TABLE (id int, val float)
INSERT INTO @T VALUES (1, 10), (2, 15)

SELECT MIN(id)
FROM @T
HAVING SUM(val) > 10

GO

/*
	Полезные конструкции
*/
DECLARE @T TABLE (id int, val float)
INSERT INTO @T 
VALUES (1, -1), (2, 0), (3, 1), (4, -4), (5, 6)

SELECT SUM(1), COUNT(*), MIN(val), -MAX(-val), MAX(val), -MIN(-val), 
SUM(CASE WHEN val > 0 THEN 1 ELSE 0 END),
SUM(CASE WHEN val > 0 THEN power(val, 2) ELSE 0 END)
FROM @T

GO

/*
	Пример декартового произведения таблицы самой с собой
*/

DECLARE @T TABLE (id int primary key, val int)
INSERT INTO @T 
VALUES (1, 2), (2, 4), (3, 6)

SELECT *
FROM @T as T1, @T as T2

SELECT *
FROM @T T1, @T T2
WHERE T1.id = T2.id 

GO

/*
	Пример декартового произведения двух разных таблиц
*/

DECLARE @A TABLE (id int)
INSERT INTO @A VALUES (1), (2), (3)

DECLARE @B TABLE (id int)
INSERT INTO @B VALUES (2), (4)

SELECT T1.id as Aid, T2.id as Bid
FROM @A as T1, @B as T2

SELECT T1.id as Aid, T2.id as Bid
FROM @A as T1, @B as T2
WHERE T1.id + 2 = T2.id

GO

/*
	Дополнительная полезная информация: подзапросы
*/
DECLARE @A TABLE (id int)
INSERT INTO @A VALUES (1), (2), (3)

DECLARE @B TABLE (id int)
INSERT INTO @B VALUES (2), (4)

SELECT *
FROM (
	SELECT T1.id Aid, T2.id Bid
	FROM @A as T1, @B as T2
) as T
WHERE T.Aid = 1 AND T.Bid = 2

SELECT *
FROM @A as T1
WHERE T1.id = (SELECT MIN(id) FROM @B)

GO

/*
	Дополнительная полезная информация: помещение результата подзапроса в переменную
*/

DECLARE @Документы TABLE (Ндок int, Пок_ID int, Сумма float)
INSERT INTO @Документы
VALUES (1, 1, 1), (2, 3, 10), (3, 2, 14), (4, 1, 20), (5, 2, 21)

DECLARE @count int
SET @count = 
(SELECT COUNT(*) FROM @Документы WHERE Пок_ID = 3)

SELECT Пок_ID
FROM @Документы
GROUP BY Пок_ID
HAVING COUNT(*) > @count

SELECT TOP (@count) Пок_ID
FROM @Документы
GROUP BY Пок_ID
HAVING COUNT(*) > @count


GO