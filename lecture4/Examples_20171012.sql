/* 
	����������� SELECT: ������� �������� ����������. (�� ��� �� SET)
	� ������ ������ �� ������� ������� � ��������� ��� ����.
	� ��� ����� �������� ������ � ��������� ����.
	����� ��� ������ ������ ������ SELECT, ������� ����� ���� �������.
*/

-- ����� ��������� ������ ������ �����, �������� � � ������� "execute"

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
	������� c ����������� ��������� � ������������:
*/
DECLARE @T TABLE (id1 int, id2 int, val int)
INSERT INTO @T VALUES (1, 1, 10), (1, 2, 20), (2, 1, 30)

SELECT MIN(val) �������, MAX(val) ��������, 
	COUNT(val) �����1, COUNT(*) �����, 
	SUM(val) ��������, AVG(val) ������
FROM @T

SELECT id1, MIN(val) �������
FROM @T
GROUP BY id1

SELECT id1, id2, MIN(val) �������
FROM @T
GROUP BY id1, id2

GO

/* ��� ������ �������� �����������*/

DECLARE @��������� TABLE (���� int, ���_ID int, ����� float)
INSERT INTO @���������
VALUES (1, 1, 1), (2, 3, 10), (3, 2, 14), (4, 1, 20), (5, 2, 21)

SELECT COUNT(���_ID) �����, COUNT (distinct ���_ID) ���������������
FROM @���������

SELECT ���_ID, MIN(�����) ��������, SUM(�����) ���������
FROM @���������
GROUP BY ���_ID

GO

/*
	���� �� ������� � ��������?
*/

-- ������� �� ��, ��� ����. �������� ���� ���������� ��� �������� ��������� � ������� ����� �������
/* �������� ��������, ��� ����� ��������� ������ ����� �������, ������� ������ ����� 
(�� �������� �������� � ���������� �������)
*/
DECLARE @��������� TABLE (���� int, ���_ID int, ����� float)
INSERT INTO @���������
VALUES (1, 1, 1), (2, 3, 10), (3, 2, 14), (4, 1, 20), (5, 2, 21)

SELECT ���_ID
FROM @���������
GROUP BY ���_ID

SELECT distinct ���_ID
FROM @���������

GO

/*
	��� ������� �������:
*/

DECLARE @��������� TABLE (���� int, ���_ID int, ����� float)
INSERT INTO @���������
VALUES (1, 1, 1), (2, 3, 10), (3, 2, 14), (4, 1, 20), (5, 2, 21)

SELECT ���_ID, SUM (�����) as S
FROM @���������
GROUP BY ���_ID

SELECT SUM (�����) as S
FROM @���������
GROUP BY ���_ID

SELECT SUM (�����)
FROM @���������

SELECT ���_ID, ����, SUM(�����) 
FROM @��������� 
GROUP BY ���_ID, ����

GO

/*
	������������� WHERE � HAVING
	���� �� �������?
*/

DECLARE @��������� TABLE (���� int, ���_ID int, ����� float)
INSERT INTO @���������
VALUES (1, 1, 1), (2, 3, 10), (3, 2, 14), (4, 1, 20), (5, 2, 21)

SELECT ���_ID, SUM (�����)
FROM @���������
WHERE ���_ID = 1
GROUP BY ���_ID

SELECT ���_ID, SUM (�����)
FROM @���������
GROUP BY ���_ID
HAVING ���_ID = 1

GO

/*
	�������� ����������
*/

DECLARE @��������� TABLE (���� int, ���_ID int, ����� float)
INSERT INTO @���������
VALUES (1, 1, 100), (2, 1, 50), (3, 2, 120) -- ������ ������� ���������� !!!!

SELECT ���_ID, SUM (�����)
FROM @���������
WHERE ����� > 100
GROUP BY ���_ID

SELECT ���_ID, SUM (�����)
FROM @���������
GROUP BY ���_ID
HAVING SUM (�����) > 100

SELECT ���_ID, SUM (�����)
FROM @���������
GROUP BY ���_ID
HAVING MIN (�����) > 100

GO

/*
	��� ����� ����������� ���������� ���������� �������?
*/

DECLARE @T TABLE (id int, val float)
INSERT INTO @T VALUES (1, 10), (2, 15)

SELECT MIN(id)
FROM @T
HAVING SUM(val) > 10

GO

/*
	�������� �����������
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
	������ ����������� ������������ ������� ����� � �����
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
	������ ����������� ������������ ���� ������ ������
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
	�������������� �������� ����������: ����������
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
	�������������� �������� ����������: ��������� ���������� ���������� � ����������
*/

DECLARE @��������� TABLE (���� int, ���_ID int, ����� float)
INSERT INTO @���������
VALUES (1, 1, 1), (2, 3, 10), (3, 2, 14), (4, 1, 20), (5, 2, 21)

DECLARE @count int
SET @count = 
(SELECT COUNT(*) FROM @��������� WHERE ���_ID = 3)

SELECT ���_ID
FROM @���������
GROUP BY ���_ID
HAVING COUNT(*) > @count

SELECT TOP (@count) ���_ID
FROM @���������
GROUP BY ���_ID
HAVING COUNT(*) > @count


GO