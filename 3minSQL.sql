SHOW DATABASES;
CREATE DATABASE bookshelf_db;
DROP DATABASE bookshelf_db;
USE bookshelf_db;
CREATE TABLE cats 
( 
    姓名 VARCHAR(50), 
    年龄 INT 
);
DESCRIBE cats;
SHOW COLUMNS FROM cats;
DROP TABLE cats;
INSERT INTO cats(姓名, 年龄) VALUES('小兰', 1);
SELECT * from cats;
INSERT INTO cats(姓名, 年龄)
VALUES ('翠花', 2),
       ('点点', 4),
       ('沫沫', 7);
CREATE TABLE unique_cats( 
  编号 INT NOT NULL, 
  姓名 VARCHAR(100), 
  年龄 INT, 
  PRIMARY KEY (编号)
);
INSERT INTO unique_cats(编号, 姓名, 年龄) VALUES(1, '小胖', 23);
INSERT INTO unique_cats(编号, 姓名, 年龄) VALUES(1, '大胖', 3);
CREATE TABLE unique_cats2( 
  编号 INT NOT NULL AUTO_INCREMENT, 
  姓名 VARCHAR(100), 
  年龄 INT, 
  PRIMARY KEY (编号)
);
INSERT INTO unique_cats2 (姓名, 年龄) VALUES('小胖', 4) ;
INSERT INTO unique_cats2 (姓名, 年龄) VALUES('大胖', 3) ;
INSERT INTO unique_cats2 (姓名, 年龄) VALUES('大胖', 3) ;
CREATE TABLE books 
	(
		编号 INT NOT NULL AUTO_INCREMENT,
		书名 VARCHAR(100),
		作者姓 VARCHAR(100),
		作者名 VARCHAR(100),
		发售年份 INT,
		存量 INT,
		页数 INT,
		PRIMARY KEY(编号)
	);
INSERT INTO books (书名, 作者姓, 作者名, 发售年份, 存量, 页数)
VALUES
('活着', '余', '华', 1993, 32, 235),
('在细雨中呼喊', '余', '华',1993, 43, 322),
('永别了，武器', '欧内斯特', '海明威', 1929, 12, 336),
('老人与海', '欧内斯特', '海明威', 1952, 97, 140),
('雪国', '川端', '康成', 1947, 154, 352),
('伊豆的舞女', '川端', '康成', 1926, 26, 504),
('射雕英雄传', '金', '庸', 1957, 68, 634),
('天龙八部', '金', '庸', 1963, 55, 304),
('权力的游戏', '乔治', 'RR马丁', 1996, 104, 694),
('1Q84', '村上', '春树', 2009, 100, 1055),
('挪威的森林', '村上', '春树', 1987, 23, 384),
('羊脂球', '居伊', '莫泊桑', 1880, 12, 526),
('大卫科波菲尔', '查尔斯', '狄更斯', 1850, 49, 320),
('雾都孤儿', '查尔斯', '狄更斯', 1945, 95, 123),
('梦的解析', '西格蒙德', '佛洛依德', 1899, 172, 329),
('君主论', '尼克罗', '马基雅维利', 1532, 92, 343);
DESCRIBE books;
SELECT 书名 FROM books WHERE 作者姓 = '余' OR 作者姓 = '金';
SELECT 书名 FROM books WHERE 作者姓 = '余' AND 作者姓 = '金';
SELECT 书名 FROM books WHERE 发售年份 IN (1899, 1945);
SELECT 书名 FROM books WHERE 发售年份 BETWEEN 1899 AND 1945;
SELECT 书名 FROM books WHERE 作者名 LIKE '%斯';
SELECT 书名 FROM books WHERE 作者名 LIKE '_树';
SELECT * FROM books ORDER BY 发售年份;
SELECT 作者名, COUNT(*) FROM books GROUP BY 作者名;
SELECT 作者姓, 作者名, COUNT(*) FROM books GROUP BY 作者姓, 作者名;
SELECT COUNT(*) as '书本数量' FROM books;
SELECT COUNT(DISTINCT 作者名) as '作者不重复书本数量' FROM books;
SELECT MIN(发售年份) FROM books;
SELECT MAX(发售年份) FROM books;
SELECT * FROM books WHERE 页数 = (SELECT Min(页数) FROM books);
SELECT 书名, 页数 FROM books ORDER BY 页数 LIMIT 1;
SELECT 作者姓, 作者名, MIN(发售年份) 
FROM books 
GROUP BY 作者姓, 作者名;
SELECT SUM(页数) from books;
SELECT 作者姓, 作者名, SUM(页数) from books GROUP BY 作者姓, 作者名;
SELECT AVG(发售年份) from books;
SELECT 发售年份, AVG(存量) from books GROUP BY 发售年份;
SELECT 作者姓, 作者名, AVG(页数) FROM books GROUP BY 作者姓, 作者名;
SELECT 作者姓, 作者名, AVG(页数) FROM books GROUP BY 作者姓, 作者名 HAVING AVG(页数) > 300;
SELECT CONCAT(作者姓, 作者名) as '作者' from books;
SELECT SUBSTRING('Hello World', 1, 4);
DROP TABLE cats;
CREATE TABLE cats 
  ( 
     编号 INT NOT NULL AUTO_INCREMENT, 
     姓名 VARCHAR(100), 
     品种 VARCHAR(100), 
     年龄 INT, 
     PRIMARY KEY (编号) 
  ); 

SELECT SUBSTRING('Hello World', 7);    INSERT INTO cats(姓名, 品种, 年龄) 
VALUES ('丘吉尔', '英短', 4),
       ('居鲁士', '波斯', 10),
       ('亚历山大', '波斯', 11),
       ('斯图亚特', '折耳', 4),
       ('罗斯福', '美短', 13),
       ('康斯坦丁', '折耳', 9),
       ('巴沙', '暹罗', 7);
SELECT DISTINCT 品种 FROM cats;
SELECT * FROM books LIMIT 1;
SELECT * FROM books LIMIT 2,5;
CREATE TABLE orders
	(
		订单号 INT NOT NULL AUTO_INCREMENT,
		书编号 INT,
		价格 INT,
		PRIMARY KEY(订单号),
        FOREIGN KEY(书编号) REFERENCES books(编号)
	);
DROP TABLE orders;
CREATE TABLE kidbooks 
	(
		编号 INT NOT NULL AUTO_INCREMENT,
		书名 VARCHAR(100),
		作者姓 VARCHAR(100),
		作者名 VARCHAR(100),
		发售年份 INT,
		存量 INT,
		页数 INT,
		PRIMARY KEY(编号)
	);

INSERT INTO kidbooks (书名, 作者姓, 作者名, 发售年份, 存量, 页数)
VALUES
('哈利波特与魔法石', 'JK', '罗琳', 1998, 12, 301),
('汤姆索亚历险记', '马克', '吐温',1876, 43, 322),
('西游记', '吴', '承恩', 1500, 19, 336),
('小时代', '郭', '敬明', 2008, 67, 225),
('哈利波特与魔法石', 'JK', '罗琳', 2007, 112, 759);
INSERT INTO orders (书编号, 价格)
VALUES
(1, 31),
(2, 22),
(3, 36),
(4, 25),
(5, 79);

SELECT 书名 from books
UNION
SELECT 书名 from kidbooks;
SELECT 书名, 存量,
CASE  
  WHEN 存量 > 30 THEN '存量大于30'
  WHEN 存量 = 30 THEN '存量为30'
  ELSE '存量小于30'
END AS
"存货信息"
FROM books;

SELECT 书名, 编号, 价格
FROM books
INNER JOIN orders
ON books.编号=orders.书编号;

SELECT 书名, 编号, 价格
FROM books
LEFT JOIN orders
ON books.编号=orders.书编号;

SELECT 书名, 编号, 价格
FROM books, orders
WHERE books.编号=orders.书编号;

SELECT 书名, 编号, 价格
FROM books
RIGHT JOIN orders
ON books.编号=orders.书编号;

SELECT 书名, 编号, 价格
FROM orders
RIGHT JOIN books
ON books.编号=orders.书编号;

SELECT 书名, 编号, 价格
FROM orders
FULL JOIN books
ON orders.书编号=books.编号;

SELECT avg(发售年份) FROM books AS 平均年份 WHERE 编号 IN 
(SELECT 书编号 FROM orders WHERE 价格 > 30);

CREATE VIEW 示例视图 AS 
SELECT 书名 FROM books WHERE 作者名 LIKE '_树';

SELECT * FROM 示例视图;

CREATE INDEX IDX_书名索引 ON books (书名);
SELECT 书名 FROM books;


DESCRIBE orders;
DESCRIBE books;

