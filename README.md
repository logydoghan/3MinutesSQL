# 3MinutesSQL
三分钟SQL

URL here

## 1 安装

```bash
docker-compose up -d
```

## 数据库

### 2 展示，创建与更新数据库

```sql
SHOW DATABASES;
```

```sql
CREATE DATABASE bookshelf_db;
```

```sql
DROP DATABASE bookshelf_db;
```

```sql
USE bookshelf_db
```

```sql
SELECT database();
```

## 表
在关系型数据库中，每个数据库是由一张或数张表组成

### 数据类型
```sql
VARCHAR(<最大长度>)
```

### 3 创建表
```sql
CREATE TABLE cats 
( 
    姓名 VARCHAR(50), 
    年龄 INT 
);
```

### 4 展示表属性

```sql
DESCRIBE cats;
```

```sql
SHOW COLUMNS FROM cats;
```

### 删除表
```sql
DROP TABLE cats;
```

### 5 将数据插入表
```sql
INSERT INTO cats(姓名, 年龄)
VALUES('小兰', 1);
```

检查一下:

```sql
SELECT * from cats;
```

### 将多个数据插入表
```sql
INSERT INTO cats(姓名, 年龄)
VALUES ('翠花', 2),
       ('点点', 4),
       ('沫沫', 7);
```

### 6 主键 Primary Key
数据库表中对储存数据对象予以唯一和完整标识的数据列或属性的组合。 一个数据表只能有一个主键，且主键的取值不能缺失，即不能为空值（Null）。

```sql
CREATE TABLE unique_cats( 
  编号 INT NOT NULL, 
  姓名 VARCHAR(100), 
  年龄 INT, 
  PRIMARY KEY (编号)
);
```

结果 (DESCRIBE unique_cats;)
```
+--------+--------------+------+-----+---------+-------+
| Field  | Type         | Null | Key | Default | Extra |
+--------+--------------+------+-----+---------+-------+
| 编号    | int(11)      | NO   | PRI | NULL    |       |
| 姓名    | varchar(100) | YES  |     | NULL    |       |
| 年龄    | int(11)      | YES  |     | NULL    |       |
+--------+--------------+------+-----+---------+-------+
```

主键必须是唯一值，否则就会报错：

```sql
INSERT INTO unique_cats(编号, 姓名, 年龄) VALUES(1, '小胖', 23);
INSERT INTO unique_cats(编号, 姓名, 年龄) VALUES(1, '大胖', 3);
```
```
ERROR: 1062 (23000): Duplicate entry '1' for key 'PRIMARY'
```
使用id作为主键是很常见的一种操作，但是如果每一行我们都要手动打一遍就会非常麻烦，所以我们可以使用

`AUTO_INCREMENT` 来帮助我们处理这个问题：

```sql
CREATE TABLE unique_cats2( 
  编号 INT NOT NULL AUTO_INCREMENT, 
  姓名 VARCHAR(100), 
  年龄 INT, 
  PRIMARY KEY (编号)
);
```

现在我们就可以插入多行数据了：
```sql
INSERT INTO unique_cats2 (姓名, 年龄) VALUES('小胖', 4) ;
INSERT INTO unique_cats2 (姓名, 年龄) VALUES('大胖', 3) ;
INSERT INTO unique_cats2 (姓名, 年龄) VALUES('大胖', 3) ;
```

每一行数据现在就是一个独立的记录


### 7 NULL 和NOT NULL
如果没有明确声明属性不能是空的话，MySQL都会默认这个属性可以是空。除非声明NOT NULL

```sql
CREATE TABLE cats 
( 
    姓名 VARCHAR(50) NOT NULL, 
    年龄 INT NOT NULL 
);
```

这里面如果没有另外设定的话，年龄的默认值为0

### 设置默认值
```sql
CREATE TABLE cats3( 姓名 VARCHAR(100) DEFAULT '未命名', 年龄 INT DEFAULT 99);
INSERT INTO cats3(年龄) VALUES(13);
```

表将会长这样：（使用 SELECT * FROM cats3; 来检查表内容，之后我们会讲到SELECT语句）

```
+---------+-----+
| 姓名     |  年龄|
+---------+-----+
| 未命名   |  13 |
+---------+-----+
```


## 8 基本CRUD操作 增加(Create)、查询(Retrieve)（重新得到数据）、更新(Update)和删除(Delete)


### 示例数据

```sql
-- 让我们现在先把cats删去:
DROP TABLE cats;
-- 再重新建一个cats表：
CREATE TABLE cats 
  ( 
     编号 INT NOT NULL AUTO_INCREMENT, 
     姓名 VARCHAR(100), 
     品种 VARCHAR(100), 
     年龄 INT, 
     PRIMARY KEY (编号) 
  ); 

-- 检查一下cats表
DESCRIBE cats;

-- 插入数据
INSERT INTO cats(姓名, 品种, 年龄) 
VALUES ('丘吉尔', '英短', 4),
       ('居鲁士', '波斯', 10),
       ('亚历山大', '波斯', 11),
       ('斯图亚特', '折耳', 4),
       ('罗斯福', '美短', 13),
       ('康斯坦丁', '折耳', 9),
       ('巴沙', '暹罗', 7);
```

## C(R)UD 查询

```sql
SELECT * FROM cats;
```
此操作会返回cats的所有属性的数据。

## 8 SELECT FROM 语句

```sql
SELECT 姓名, 年龄 FROM cats;
```

## 使用`WHERE`进行筛选
```sql
SELECT * FROM cats WHERE 年龄=4;
```

可以得到：
```
+--------+-------+---------+-----+
| 编号     |姓名    |品种       |年龄  |
+--------+-------+---------+-----+
|      1 | 丘吉尔|       英短|   4 |
|      4 | 斯图亚特|      折耳|   4 |
+--------+-------+---------+-----+
```


`WHERE` 语句可以用来比较两个不同的属性
```sql
SELECT * FROM cats WHERE 编号=年龄 ;
```
以上操作将会返回所有`编号`等于`年龄`的cats

## 9 DISTINCT 语句

DISTINCT 找出表格内的不同资料值的情况

找到不同的品种。

```sql
SELECT DISTINCT 品种 FROM cats;
```


## 10 CR(U)D Update 更新数据

我们如何修改现有的数据？

我们想把所有美短品种的cats变成英短品种
```sql
UPDATE cats SET 品种='英短' WHERE 品种='美短';
```

*使用`SELECT` 语句来检查`UPDATE` 语句的运行结果*  

### 比如
```sql
SELECT * FROM cats;
```

## CRU(D) Delete 删除数据
```sql
-- 将姓名叫做亚历山大的cats删去
DELETE FROM cats WHERE 姓名='亚历山大';
-- 删掉cats中的所有数据
DELETE FROM cats;
```

*使用`SELECT` 语句来检查`DELETE` 语句的运行结果*  

### 比如
```sql
SELECT * FROM cats;
```

## 11 AND OR 语句

AND 和 OR 可在 WHERE 子语句中把两个或多个条件结合起来。
如果第一个条件和第二个条件都成立，则 AND 运算符显示一条记录。
如果第一个条件和第二个条件中只要有一个成立，则 OR 运算符显示一条记录。

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

SELECT 书名 FROM books WHERE 作者姓 = '余' OR 作者姓 = '金';
SELECT 书名 FROM books WHERE 作者姓 = '余' AND 作者姓 = ‘金';

## 11 IN NOT IN 语句

IN 操作符允许我们在 WHERE 子句中规定多个值。

```sql
SELECT 书名 FROM books WHERE 发售年份 IN (1899, 1945);
```

## 12 BETWEEN AND 语句

操作符 BETWEEN ... AND 会选取介于两个值之间的数据范围。这些值可以是数值、文本或者日期。

```sql
SELECT 书名 FROM books WHERE 发售年份 BETWEEN 1899 AND 1945;
```

## 13 LIKE 语句


LIKE 操作符用于在 WHERE 子句中搜索列中的指定模式。

* % 可以通配多个字符
* _ 只能通配一个字符


```sql
SELECT 书名 FROM books WHERE 作者名 LIKE '%斯';
SELECT 书名 FROM books WHERE 作者名 LIKE '_树';
```


## 14 ORDER BY 语句

ORDER BY 语句用于根据指定的列对结果集进行排序。
* ORDER BY 语句默认按照升序对记录进行排序。
* 如果您希望按照降序对记录进行排序，可以使用 DESC 关键字。

```sql
SELECT * FROM books ORDER BY 发售年份;
```


### 15 GROUP BY 语句

GROUP BY 语句用于结合合计函数，根据一个或多个列对结果集进行分组。

比如我们想查看每个作者都写了几本书：

```sql
SELECT 作者名, COUNT(*) FROM books GROUP BY 作者名;
```

我们也可以按照多个栏位进行分组：

```sql
SELECT 作者姓, 作者名, COUNT(*) FROM books GROUP BY 作者姓, 作者名;
```

## 16 LIMIT 语句

如果返回的结果众多，我们可以通过LIMIT语句来限制返回的行数。

```sql
SELECT * FROM books LIMIT 1;
```

返回第二到第五行
```sql
SELECT * FROM books LIMIT 2,5;
```

### 17 别名 Aliases

通过使用 SQL，可以为列名称和表名称指定别名（Alias）。
我们可以将sql返回的结果用as保存起来：

```sql
SELECT COUNT(*) as '书本数量' FROM books;
```

你会发现返回结果中的栏名变成了书本数量


## 聚合函数 Aggregate functions

Aggregate 函数的操作面向一系列的值，并返回一个单一的值。

### 18 COUNT

COUNT() 函数返回匹配指定条件的行数。

```sql
SELECT COUNT(*) as '书本数量' FROM books;
```

得到：
```
+-----------------------------+
| 书本数量 			|
+-----------------------------+
|                          16 |
+-----------------------------+

```

我们可以将COUNT和DISTINCT组合起来使用：

```sql
SELECT COUNT(DISTINCT 作者名) as '作者不重复书本数量' FROM books;
```

得到:
```
+--------------------------------------+
| 作者不重复书本数量			 |
+--------------------------------------+
|                                   10 |
+--------------------------------------+

```


### 19 MIN and MAX


MIN 函数返回一列中的最小值。NULL 值不包括在计算中。

```sql
SELECT MIN(发售年份) FROM books;
```

MAX 函数返回一列中的最大值。NULL 值不包括在计算中。

```sql
SELECT MAX(发售年份) FROM books;
```

找到页数最少的书：
```sql
SELECT * FROM books WHERE 页数 = (SELECT Min(页数) FROM books);
```
我们之后会讲到子查询，但是SQL语句将会先返回右边的结果然后再执行左边的结果。这样做效率并不高，我们也可以按下面这种方式写：

```sql
SELECT 书名, 页数 FROM books ORDER BY 页数 LIMIT 1;
```

### 19 MIN， MAX 和 GROUP BY 一起使用

得到最早发售的书：
```sql
SELECT 作者姓, 作者名, MIN(发售年份) 
FROM books 
GROUP BY 作者姓, 作者名;
```

### 20 SUM

SUM 函数返回数值列的总数（总额）。

```sql
SELECT SUM(页数) from books;
```

返回所有书页数的总和：
```sql
SELECT 作者姓, 作者名, SUM(页数) from books GROUP BY 作者姓, 作者名;
```

### 20 AVG

AVG 函数返回数值列的平均值。NULL 值不包括在计算中。

返回所有书发售年份的平均值：
```sql
SELECT AVG(发售年份) from books;
```

找到每个发售年份的书的平均存量：
```sql
SELECT 发售年份, AVG(存量) from books GROUP BY 发售年份;
```

找到每个作者的书籍的平均页数：
```sql
SELECT 作者姓, 作者名, AVG(页数) FROM books GROUP BY 作者姓, 作者名;
```

### 21 Having 语句

HAVING 对函数产生的值来设定条件：

```sql
SELECT 作者姓, 作者名, AVG(页数) FROM books GROUP BY 作者姓, 作者名 HAVING AVG(页数) > 300;
```

### 22 Foreign Key 外来键

一个表中的 FOREIGN KEY 指向另一个表中的 PRIMARY KEY。
外来键是一个(或数个)指向另外一个表格主键的栏位。外来键的目的是确定资料的参考完整性(referential integrity)。换言之，只有被准许的资料值才会被存入数据库内。

假设我们有两个表格：一个 books 表格，里面记录了所有书目的资料；另一个 orders 表格，里面记录了所有订单的资料。在这里的一个限制，就是所有的订单中的书的编号，都一定是要跟在 books 表格中存在。在这里，我们就会在 orders 表格中设定一个外来键，而这个外来键是指向 books 表格中的主键。这样一来，我们就可以确定所有在 orders 表格中的书编号都存在 books 表格中。换句话说，orders表格之中，不能有任何书的编号是不存在于 books 表格中的资料。 

创建orders表：

CREATE TABLE orders
	(
		订单号 INT NOT NULL AUTO_INCREMENT,
		编号 INT,
		价格 INT,
		PRIMARY KEY(订单号),
               FOREIGN KEY(编号) REFERENCES books(编号)
		
	);

DESCRIBE books;

```sql
+--------+--------------+------+-----+---------+-------+
| Field  | Type         | Null | Key | Default | Extra |
+--------+--------------+------+-----+---------+-------+
| 编号      | int            | NO  | PRI | NULL     |autoincrement|
| 姓名      | varchar(100)    | YES |     | NULL     |      |
| 作者姓   | varchar(100)    | YES |     | NULL     |      |
| 作者名  | varchar(100)   | YES |     | NULL     |       |
| 发售年份  | int            | YES |     | NULL     |      |
| 存量     | int            | YES  |     | NULL    |      |
| 页数     | int            | YES  |     | NULL    |      |
+————+———————+———+——+————+——————+————————————————————————
```

DESCRIBE orders;

```sql
+--------+--------------+------+-----+---------+-------+
| Field  | Type         | Null | Key | Default | Extra |
+--------+--------------+------+-----+---------+-------+
| 订单号      | int         | NO  | PRI  | NULL     |autoincrement |
| 书编号      | int         | YES | MUL  | NULL     |      |
| 价格         |int          | YES  |      | NULL     |      |
+————+———————+———+——+————+——————+————————————————————————
```



## 23 INNER JOIN (JOIN) 语句

内部连接 (inner join)，在这个情况下，要两个表格内都有同样的值，那一笔资料才会被选出。

在表中存在至少一个匹配时，INNER JOIN 关键字返回行。


```sql
SELECT column_name(s)
FROM table_name1
INNER JOIN table_name2 
ON table_name1.column_name=table_name2.column_name
```

```sql
SELECT 书名, 编号, 价格
FROM books
INNER JOIN orders
ON books.编号=orders.书编号;
```


隐式内部链接
```sql
SELECT 书名, 编号, 价格
FROM books, orders
WHERE books.编号=orders.书编号;
```


显式内部链接
```sql
SELECT 书名, 编号, 价格
FROM books
INNER JOIN orders
ON books.编号=orders.书编号;
```


## 24 LEFT JOIN

LEFT JOIN 关键字会从左表 (table_name1) 那里返回所有的行，即使在右表 (table_name2) 中没有匹配的行。

```sql
SELECT 书名, 编号, 价格
FROM books
LEFT JOIN orders
ON books.编号=orders.书编号;
```

## 24 FULL JOIN

只要其中某个表存在匹配，FULL JOIN 关键字就会返回行。

```sql
SELECT 书名, 编号, 价格
FROM orders
FULL JOIN books
ON books.编号=orders.书编号;
```

* MYSQL 不支持FULL JOIN

## Strings Functions

### 25 CONCAT 语句
CONCAT方法用于连接两个字段

#### 将作者姓和作者名连接成一个作者的字段
```sql
SELECT CONCAT(作者姓, 作者名) as '作者' from books;
```


## 26 SUBSTRING 语句

取字符串的片段：
```sql
SELECT SUBSTRING('Hello World', 1, 4);
```

会得到:
```
+-------------------------------+
| SUBSTRING('Hello World', 1, 4) |
+-------------------------------+
| Hell                          |
+-------------------------------+
```

取第7位到最后：
```sql
SELECT SUBSTRING('Hello World', 7);
```

会得到:
```
+-----------------------------+
| SUBSTRING('Hello World', 7) |
+-----------------------------+
| World                       |
+-----------------------------+
```


## 27 UNION 语句

UNION 操作符用于合并两个或多个 SELECT 语句的结果集。

```sql
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
```

```sql
INSERT INTO kidbooks (书名, 作者姓, 作者名, 发售年份, 存量, 页数)
VALUES
('哈利波特与魔法石', 'JK', '罗琳', 1998, 12, 301),
('汤姆索亚历险记', '马克', '吐温',1876, 43, 322),
('西游记', '吴', '承恩', 1500, 19, 336),
('小时代', '郭', '敬明', 2008, 67, 225),
('哈利波特与魔法石', 'JK', '罗琳', 2007, 112, 759);
```

```sql
select 书名 from books
union
select 书名 from kidbooks;
```

## 28 CASE 语句

CASE 语句可以帮助我们通过一些限制条件而对结果进行筛选

SQL 用来做为 if-then-else 之类逻辑的关键字。 CASE 的语法如下：

```sql
SELECT 书名, 存量,
CASE  
  WHEN 存量 > 30 THEN '存量大于30'
  WHEN 存量 = 30 THEN '存量为30'
  ELSE '存量小于30'
END AS
"存货信息"
FROM books;
```

"存货信息" 是用到 CASE 那个字段的字段别名。

## 29 Subquery 子查询

我们可以在一个 SQL 语句中放入另一个 SQL 语句。当我们在 WHERE 子句或 HAVING 子句中插入另一个 SQL 语句时，我们就有一个子查询 (subquery) 的架构。 子查询的作用是什么呢？它可以被用来连接表格。有的时候子查询是唯一能够连接两个表格的方式。 子查询（Sub Query）或者说内查询（Inner Query），也可以称作嵌套查询（Nested Query），是一种嵌套在其他 SQL 查询的 WHERE 子句中的查询。子查询用于为主查询返回其所需数据，或者对检索数据进行进一步的限制。

比如我们想找到在orders表格内价格大于30的书编号，并得到这些书发售年份的平均值：

```sql
SELECT avg(发售年份) FROM books AS 平均年份 WHERE 编号 IN 
(SELECT 书编号 FROM orders WHERE 价格 > 30);
```

## 30 View 视图


视图或者视观表 (Views) 可以被当作是虚拟表格。它跟表格的不同是，表格中有实际储存资
料，而视观表是建立在表格之上的一个架构，它本身并不实际储存资料。

在 SQL 中，视图是基于 SQL 语句的结果集的可视化的表。
视图包含行和列，就像一个真实的表。视图中的字段就是来自一个或多个数据库中的真实的
表中的字段。我们可以向视图添加 SQL 函数、WHERE 以及 JOIN 语句，我们也可以提交数
据，就像这些来自于某个单一的表。

注释：数据库的设计和结构不会受到视图中的函数、where 或 join 语句的影响。

```sql
CREATE VIEW 示例视图 AS 
SELECT 书名 FROM books WHERE 作者名 LIKE '_树';
```

```sql
SELECT * FROM 示例视图;
```

## 30 Index 索引

索引是一种特殊的查询表，可以被数据库搜索引擎用来加速数据的检索。简单说来，索引就是指向表中数据的指针。数据库的索引同书籍后面的索引非常相像。

例如，如果想要查阅一本书中与某个特定主题相关的所有页面，你会先去查询索引（索引按照字母表顺序列出了所有主题），然后从索引中找到一页或者多页与该主题相关的页面。

索引能够提高 SELECT 查询和 WHERE 子句的速度，但是却降低了包含 UPDATE 语句或 INSERT 语句的数据输入过程的速度。索引的创建与删除不会对表中的数据产生影响。


```sql
CREATE INDEX IDX_书名索引 ON books (书名);
```

```sql
SELECT 书名 FROM books;
```
