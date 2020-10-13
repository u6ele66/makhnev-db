use lw3

SET DATEFORMAT YMD;

-- 1.INSERT
---- 1.1 ��� �������� ������ �����
INSERT INTO official_city VALUES(34, '���������', '�������������', 212087);
INSERT INTO official_city VALUES(74, '����������', '������������', 231124);
INSERT INTO official_city VALUES(28, '������', '���������', 243244);
INSERT INTO official_city VALUES(98, '���������', '��������� ����������', 212987);
INSERT INTO official VALUES(13, '�������', '������', '��� "������"', '��. ���������, �.12, ���� 43', 50000, 34, 535125);
INSERT INTO official VALUES(12, '���������', '������', '��� "������"', '��. ���������, �.12, ���� 43', 40000, 34, 635211);
INSERT INTO official VALUES(93, '������', '������', '��� "��������"', '��. ���������, �.2, ���� 3', 60000, 74, 735121);
INSERT INTO official VALUES(92, '������', '������', '��� "��������"', '��. ���������, �.2, ���� 3', 10000, 74, 812462);
INSERT INTO official VALUES(91, '�������', '������', '��� "��������"', '��. ���������, �.2, ���� 3', 110000, 74, 946422);
INSERT INTO official VALUES(63, '������', '�����', '��� "�������"', '��. �������, �.6, ���� 12', 70000, 28, 646234);
INSERT INTO official VALUES(64, '������', '�����', '��� "�������"', '��. �������, �.6, ���� 12', 80000, 28, 798474);
INSERT INTO official VALUES(15, '�������', '��������', '��� "����� �����"', '��. ������, �.8, ���� 65', 50000, 98, 809459);
INSERT INTO orders VALUES(23, '����', '������', '01-01-2019', 243244)
INSERT INTO orders VALUES(76, '����', '�������', '02-02-2020', 212087);
INSERT INTO orders VALUES(65, '���������', '������', '03-03-2021', 212987);
INSERT INTO orders VALUES(534, '���������', '������', '04-04-2022', 231124);
INSERT INTO order_sender VALUES(43, '����������� ��������', '��. ������, �.3, ���� 3', 32, 312412)
INSERT INTO order_sender VALUES(238, '���������� ��������������', '��. �������, �.27, ���� 28', 32, 413241)
INSERT INTO order_sender VALUES(532, '�������������', '��. ����� ������, �.29, ���� 12', 44, 523131)
INSERT INTO order_sender VALUES(356, '������� ����������', '��. �������, �.63, ���� 74', 54, 535312)
INSERT INTO mailing_to_officials VALUES(43, '05-05-2023', '���� ��������', 76, 93, 74, 238);
INSERT INTO mailing_to_officials VALUES(63, '06-06-2024', '���� ������', 65, 63, 28, 532);
INSERT INTO mailing_to_officials VALUES(47, '07-07-2025', '���� �����', 534, 15, 98, 356);
---- 1.2 � �������� ������ �����
INSERT INTO official_city(id, title, area, postal_code) VALUES (3, '������', '����������', 652345);
---- 1.3 � ������� �������� �� ������ �������
INSERT INTO order_sender(id, sender_organisation_title, sender_address, sender_city_id, sender_postal_code)
	SELECT id, official_company, official_address, official_city_id, official_postal_code FROM official;

-- 2.DELETE
---- 2.1 ���� �������
DELETE mailing_to_officials;
---- 2.2 �� �������
DELETE FROM orders WHERE id = 23;
---- 2.3 �������� �������
TRUNCATE TABLE mailing_to_officials;

-- 3.UPDATE
---- 3.1 ���� �������
UPDATE official_city SET title = '���������';
---- 3.2 �� �������, �������� ���� �������
UPDATE official_city SET title = '������' WHERE id = 3;
---- 3.3 �� ������� �������� ��������� ���������
UPDATE official_city SET title = '�����', area = '��������' WHERE id = 74;


-- 4.SELECT
---- 4.1 � ������������ ������� ����������� ��������� (SELECT atr1, atr2 FROM...)
SELECT official_name, official_surname FROM official;
---- 4.2 �� ����� ���������� (SELECT * FROM...)
SELECT * FROM orders;
---- 4.3 � �������� �� �������� (SELECT * FROM ... WHERE atr1 = "")
SELECT * FROM order_sender WHERE id = 238;

-- 5. SELECT ORDER BY + TOP (LIMIT)
---- 5.1 � ����������� �� ����������� ASC + ����������� ������ ���������� �������
SELECT * FROM order_sender ORDER BY sender_city_id ASC;
---- 5.2 � ����������� �� �������� DESC
SELECT * FROM order_sender WHERE id < 32 ORDER BY sender_city_id DESC;
---- 5.3 � ����������� �� ���� ��������� + ����������� ������ ���������� �������
SELECT * FROM order_sender WHERE id >= 238 ORDER BY sender_organisation_title, sender_address; 
---- 5.4 � ����������� �� ������� ��������, �� ������ �����������
SELECT * FROM official_city ORDER BY id;

-- 6. ������ � ������. ����������, ����� ���� �� ������ ��������� ������� � ����� DATETIME.
---- 6.1 WHERE �� ����
SELECT * FROM orders WHERE date_of_order = '01-01-2019';
---- 6.2 ������� �� ������� �� ��� ����, � ������ ���. ��������, ��� �������� ������.
SELECT YEAR(date_of_order) AS year_birthday FROM orders;	


-- 7. SELECT GROUP BY � ��������� ���������
----7.1 MIN
SELECT official_surname, min(official_salary) AS min_salary FROM official GROUP BY official_surname;
----7.2 MAX
SELECT official_surname, max(official_salary) AS max_salary FROM official GROUP BY official_surname;
----7.3 AVG
SELECT official_surname, avg(official_salary) AS avg_salary FROM official GROUP BY official_surname;
----7.4 SUM
SELECT official_surname, sum(official_salary) AS sum_salary FROM official GROUP BY official_surname;

----7.5 COUNT
SELECT official_surname, count(official_salary) AS count_salary FROM official GROUP BY official_surname;

-- 8. SELECT GROUP BY + HAVING
----8.1 �������� 3 ������ ������� � �������������� GROUP BY + HAVING

SELECT official_surname, count(official_salary) AS count_salary FROM official GROUP BY official_surname HAVING count(official_salary) < 3;

SELECT official_surname, avg(official_salary) AS avg_salary FROM official GROUP BY official_surname HAVING avg(official_salary) <= 50000;

SELECT official_surname, min(official_salary) AS min_salary FROM official GROUP BY official_surname HAVING min(official_salary) <= 40000;    

-- 9. SELECT JOIN
---- 9.1 LEFT JOIN ���� ������ � WHERE �� ������ �� ���������
SELECT order_recipient_surname, order_number FROM orders LEFT JOIN official_city ON order_number = postal_code;
---- 9.2 RIGHT JOIN. �������� ����� �� �������, ��� � � 5.1
SELECT sender_organisation_title, sender_address, sender_city_id FROM order_sender RIGHT JOIN official ON official_city_id = sender_city_id;
---- 9.3 LEFT JOIN ���� ������ + WHERE �� �������� �� ������ �������
SELECT * FROM orders 
LEFT JOIN official_city ON order_number = postal_code 
LEFT JOIN official ON official_postal_code > postal_code 
WHERE order_number >= 230000 AND area = '��������' AND official_salary >= 60000;
---- 9.4 FULL OUTER JOIN ���� ������
SELECT * FROM orders FULL OUTER JOIN official_city ON order_number = postal_code;

-- 10. ����������
---- 10.1 �������� ������ � WHERE IN (���������)
SELECT order_number
FROM orders 
WHERE order_number IN (SELECT postal_code FROM official_city);

---- 10.2 �������� ������ SELECT atr1, atr2, (���������) FROM ...
SELECT order_recipient_name, order_recipient_surname, date_of_order,
(SELECT postal_code FROM official_city WHERE postal_code = order_number) AS order_number FROM orders;
