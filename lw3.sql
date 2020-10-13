use lw3

SET DATEFORMAT YMD;

-- 1.INSERT
---- 1.1 Без указания списка полей
INSERT INTO official_city VALUES(34, 'Волгоград', 'Волгоградская', 212087);
INSERT INTO official_city VALUES(74, 'Красноярск', 'Красноярская', 231124);
INSERT INTO official_city VALUES(28, 'Казань', 'Татарстан', 243244);
INSERT INTO official_city VALUES(98, 'Чебоксары', 'Чувашская Республика', 212987);
INSERT INTO official VALUES(13, 'Алексей', 'Иванов', 'ООО "Мебель"', 'ул. Прохорова, д.12, офис 43', 50000, 34, 535125);
INSERT INTO official VALUES(12, 'Александр', 'Иванов', 'ООО "Мебель"', 'ул. Прохорова, д.12, офис 43', 40000, 34, 635211);
INSERT INTO official VALUES(93, 'Сергей', 'Петров', 'ООО "ДомСтрой"', 'ул. Панфилова, д.2, офис 3', 60000, 74, 735121);
INSERT INTO official VALUES(92, 'Андрей', 'Петров', 'ООО "ДомСтрой"', 'ул. Панфилова, д.2, офис 3', 10000, 74, 812462);
INSERT INTO official VALUES(91, 'Алексей', 'Петров', 'ООО "ДомСтрой"', 'ул. Панфилова, д.2, офис 3', 110000, 74, 946422);
INSERT INTO official VALUES(63, 'Андрей', 'Губов', 'ООО "Авокадо"', 'ул. Сталина, д.6, офис 12', 70000, 28, 646234);
INSERT INTO official VALUES(64, 'Сергей', 'Губов', 'ООО "Авокадо"', 'ул. Сталина, д.6, офис 12', 80000, 28, 798474);
INSERT INTO official VALUES(15, 'Надежда', 'Любовная', 'ООО "Белая птица"', 'ул. Гоголя, д.8, офис 65', 50000, 98, 809459);
INSERT INTO orders VALUES(23, 'Иван', 'Петров', '01-01-2019', 243244)
INSERT INTO orders VALUES(76, 'Петр', 'Сергеев', '02-02-2020', 212087);
INSERT INTO orders VALUES(65, 'Екатерина', 'Полова', '03-03-2021', 212987);
INSERT INTO orders VALUES(534, 'Екатерина', 'Макова', '04-04-2022', 231124);
INSERT INTO order_sender VALUES(43, 'Управляющая компания', 'ул. Ленина, д.3, офис 3', 32, 312412)
INSERT INTO order_sender VALUES(238, 'Управление Строительством', 'ул. Петрова, д.27, офис 28', 32, 413241)
INSERT INTO order_sender VALUES(532, 'Администрация', 'ул. Карла Маркса, д.29, офис 12', 44, 523131)
INSERT INTO order_sender VALUES(356, 'Местное Управление', 'ул. Крылова, д.63, офис 74', 54, 535312)
INSERT INTO mailing_to_officials VALUES(43, '05-05-2023', 'Иван Алексеев', 76, 93, 74, 238);
INSERT INTO mailing_to_officials VALUES(63, '06-06-2024', 'Иван Иванов', 65, 63, 28, 532);
INSERT INTO mailing_to_officials VALUES(47, '07-07-2025', 'Петр Полов', 534, 15, 98, 356);
---- 1.2 С указание списка полей
INSERT INTO official_city(id, title, area, postal_code) VALUES (3, 'Москва', 'Московская', 652345);
---- 1.3 С чтением значений из другой таблицы
INSERT INTO order_sender(id, sender_organisation_title, sender_address, sender_city_id, sender_postal_code)
	SELECT id, official_company, official_address, official_city_id, official_postal_code FROM official;

-- 2.DELETE
---- 2.1 Всех записей
DELETE mailing_to_officials;
---- 2.2 По условию
DELETE FROM orders WHERE id = 23;
---- 2.3 Очистить таблица
TRUNCATE TABLE mailing_to_officials;

-- 3.UPDATE
---- 3.1 Всех записей
UPDATE official_city SET title = 'Чебоксары';
---- 3.2 По условию, обновляя один атрибут
UPDATE official_city SET title = 'Москва' WHERE id = 3;
---- 3.3 По условию обновляя несколько атрибутов
UPDATE official_city SET title = 'Тверь', area = 'Тверская' WHERE id = 74;


-- 4.SELECT
---- 4.1 С определенным набором извлекаемых атрибутов (SELECT atr1, atr2 FROM...)
SELECT official_name, official_surname FROM official;
---- 4.2 Со всеми атрибутами (SELECT * FROM...)
SELECT * FROM orders;
---- 4.3 С условием по атрибуту (SELECT * FROM ... WHERE atr1 = "")
SELECT * FROM order_sender WHERE id = 238;

-- 5. SELECT ORDER BY + TOP (LIMIT)
---- 5.1 С сортировкой по возрастанию ASC + ограничение вывода количества записей
SELECT * FROM order_sender ORDER BY sender_city_id ASC;
---- 5.2 С сортировкой по убыванию DESC
SELECT * FROM order_sender WHERE id < 32 ORDER BY sender_city_id DESC;
---- 5.3 С сортировкой по двум атрибутам + ограничение вывода количества записей
SELECT * FROM order_sender WHERE id >= 238 ORDER BY sender_organisation_title, sender_address; 
---- 5.4 С сортировкой по первому атрибуту, из списка извлекаемых
SELECT * FROM official_city ORDER BY id;

-- 6. Работа с датами. Необходимо, чтобы одна из таблиц содержала атрибут с типом DATETIME.
---- 6.1 WHERE по дате
SELECT * FROM orders WHERE date_of_order = '01-01-2019';
---- 6.2 Извлечь из таблицы не всю дату, а только год. Например, год рождения автора.
SELECT YEAR(date_of_order) AS year_birthday FROM orders;	


-- 7. SELECT GROUP BY с функциями агрегации
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
----8.1 Написать 3 разных запроса с использованием GROUP BY + HAVING

SELECT official_surname, count(official_salary) AS count_salary FROM official GROUP BY official_surname HAVING count(official_salary) < 3;

SELECT official_surname, avg(official_salary) AS avg_salary FROM official GROUP BY official_surname HAVING avg(official_salary) <= 50000;

SELECT official_surname, min(official_salary) AS min_salary FROM official GROUP BY official_surname HAVING min(official_salary) <= 40000;    

-- 9. SELECT JOIN
---- 9.1 LEFT JOIN двух таблиц и WHERE по одному из атрибутов
SELECT order_recipient_surname, order_number FROM orders LEFT JOIN official_city ON order_number = postal_code;
---- 9.2 RIGHT JOIN. Получить такую же выборку, как и в 5.1
SELECT sender_organisation_title, sender_address, sender_city_id FROM order_sender RIGHT JOIN official ON official_city_id = sender_city_id;
---- 9.3 LEFT JOIN трех таблиц + WHERE по атрибуту из каждой таблицы
SELECT * FROM orders 
LEFT JOIN official_city ON order_number = postal_code 
LEFT JOIN official ON official_postal_code > postal_code 
WHERE order_number >= 230000 AND area = 'Тверская' AND official_salary >= 60000;
---- 9.4 FULL OUTER JOIN двух таблиц
SELECT * FROM orders FULL OUTER JOIN official_city ON order_number = postal_code;

-- 10. Подзапросы
---- 10.1 Написать запрос с WHERE IN (подзапрос)
SELECT order_number
FROM orders 
WHERE order_number IN (SELECT postal_code FROM official_city);

---- 10.2 Написать запрос SELECT atr1, atr2, (подзапрос) FROM ...
SELECT order_recipient_name, order_recipient_surname, date_of_order,
(SELECT postal_code FROM official_city WHERE postal_code = order_number) AS order_number FROM orders;
