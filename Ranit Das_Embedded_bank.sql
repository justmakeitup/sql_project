Microsoft Windows [Version 10.0.22621.4317]
(c) Microsoft Corporation. All rights reserved.

C:\Users\hp>mysqlsh
MySQL Shell 8.0.46

Copyright (c) 2016, 2026, Oracle and/or its affiliates.
Oracle is a registered trademark of Oracle Corporation and/or its affiliates.
Other names may be trademarks of their respective owners.

Type '\help' or '\?' for help; '\quit' to exit.
 MySQL  JS > \sql
Switching to SQL mode... Commands end with ;
 MySQL  SQL > \connect root@localhost:3306
Creating a session to 'root@localhost:3306'
Fetching global names for auto-completion... Press ^C to stop.
Your MySQL connection id is 18
Server version: 8.0.46 MySQL Community Server - GPL
No default schema selected; type \use <schema> to set one.
 MySQL  localhost:3306 ssl  SQL > CREATE DATABASE IF NOT EXISTS embedded_bank_db;
Query OK, 1 row affected, 1 warning (0.0161 sec)
Note (code 1007): Can't create database 'embedded_bank_db'; database exists
 MySQL  localhost:3306 ssl  SQL >
 MySQL  localhost:3306 ssl  SQL > USE embedded_bank_db;
Default schema set to `embedded_bank_db`.
Fetching global names, object names from `embedded_bank_db` for auto-completion... Press ^C to stop.
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE TABLE branches (
                                                 ->     branch_id INT AUTO_INCREMENT PRIMARY KEY,
                                                 ->     branch_name VARCHAR(100) NOT NULL,
                                                 ->     city VARCHAR(50) NOT NULL,
                                                 ->     address VARCHAR(200),
                                                 ->     phone VARCHAR(15)
                                                 -> );
ERROR: 1050 (42S01): Table 'branches' already exists
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE TABLE customers (
                                                 ->     customer_id INT AUTO_INCREMENT PRIMARY KEY,
                                                 ->     first_name VARCHAR(50) NOT NULL,
                                                 ->     last_name VARCHAR(50) NOT NULL,
                                                 ->     email VARCHAR(100) UNIQUE,
                                                 ->     phone VARCHAR(15),
                                                 ->     address VARCHAR(200),
                                                 ->     branch_id INT,
                                                 ->     FOREIGN KEY (branch_id)
                                                 ->         REFERENCES branches(branch_id)
                                                 -> );
ERROR: 1050 (42S01): Table 'customers' already exists
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE TABLE accounts (
                                                 ->     account_id INT AUTO_INCREMENT PRIMARY KEY,
                                                 ->     acc_no VARCHAR(20) UNIQUE NOT NULL,
                                                 ->     customer_id INT NOT NULL,
                                                 ->     acc_type VARCHAR(20) NOT NULL,
                                                 ->     balance DECIMAL(12,2) DEFAULT 0.00,
                                                 ->     opening_date DATE,
                                                 ->     status VARCHAR(20) DEFAULT 'Active',
                                                 ->     FOREIGN KEY (customer_id)
                                                 ->         REFERENCES customers(customer_id)
                                                 -> );
ERROR: 1050 (42S01): Table 'accounts' already exists
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE TABLE transactions (
                                                 ->     transaction_id INT AUTO_INCREMENT PRIMARY KEY,
                                                 ->     acc_no VARCHAR(20) NOT NULL,
                                                 ->     transaction_type VARCHAR(20) NOT NULL,
                                                 ->     amount DECIMAL(12,2) NOT NULL,
                                                 ->     transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                                                 ->     description VARCHAR(200),
                                                 ->     FOREIGN KEY (acc_no)
                                                 ->         REFERENCES accounts(acc_no)
                                                 -> );
ERROR: 1050 (42S01): Table 'transactions' already exists
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > INSERT INTO branches
                                                 -> (branch_name, city, address, phone)
                                                 -> VALUES
                                                 -> ('Park Street Branch', 'Kolkata', '12 Park Street', '9876543210'),
                                                 -> ('Salt Lake Branch', 'Kolkata', 'Sector V, Salt Lake', '9876543211'),
                                                 -> ('Howrah Branch', 'Howrah', 'GT Road, Howrah', '9876543212'),
                                                 -> ('Durgapur Branch', 'Durgapur', 'City Centre', '9876543213'),
                                                 -> ('Siliguri Branch', 'Siliguri', 'Hill Cart Road', '9876543214');
Query OK, 5 rows affected (0.0344 sec)

Records: 5  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > INSERT INTO customers
                                                 -> (first_name, last_name, email, phone, address, branch_id)
                                                 -> VALUES
                                                 -> ('Rahul', 'Sharma', 'rahul@gmail.com', '9876500001', 'Kolkata', 1),
                                                 -> ('Priya', 'Das', 'priya@gmail.com', '9876500002', 'Salt Lake', 2),
                                                 -> ('Amit', 'Roy', 'amit@gmail.com', '9876500003', 'Howrah', 3),
                                                 -> ('Arjun', 'Sen', 'arjun@gmail.com', '9876500005', 'Siliguri', 5),
                                                 -> ('Neha', 'Ghosh', 'neha@gmail.com', '9876500006', 'Kolkata', 1),
                                                 -> ('Rohan', 'Paul', 'rohan@gmail.com', '9876500007', 'Howrah', 3),
                                                 -> ('Ananya', 'Bose', 'ananya@gmail.com', '9876500008', 'Salt Lake', 2),
                                                 -> ('Karan', 'Mitra', 'karan@gmail.com', '9876500009', 'Durgapur', 4),
                                                 -> ('Isha', 'Sen', 'isha@gmail.com', '9876500010', 'Siliguri', 5);
ERROR: 1062 (23000): Duplicate entry 'rahul@gmail.com' for key 'customers.email'
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > INSERT INTO accounts
                                                 -> (acc_no, customer_id, acc_type, balance, opening_date, status)
                                                 -> VALUES
                                                 -> ('1000000000', 1, 'Savings', 25000.00, '2025-01-10', 'Active'),
                                                 -> ('1000000001', 2, 'Savings', 35000.00, '2025-02-15', 'Active'),
                                                 -> ('1000000002', 3, 'Current', 50000.00, '2025-03-20', 'Active'),
                                                 -> ('1000000003', 4, 'Savings', 75000.00, '2025-05-12', 'Active'),
                                                 -> ('1000000004', 5, 'Savings', 42000.00, '2025-06-18', 'Active'),
                                                 -> ('1000000005', 6, 'Savings', 15000.00, '2025-07-22', 'Active'),
                                                 -> ('1000000006', 7, 'Current', 60000.00, '2025-08-11', 'Active'),
                                                 -> ('1000000007', 8, 'Savings', 28000.00, '2025-09-14', 'Active'),
                                                 -> ('1000000008', 9, 'Savings', 32000.00, '2025-10-19', 'Active');
ERROR: 1062 (23000): Duplicate entry '1000000000' for key 'accounts.acc_no'
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > INSERT INTO transactions
                                                 -> (acc_no, transaction_type, amount, description)
                                                 -> VALUES
                                                 -> ('1000000000', 'Deposit', 5000, 'Cash deposit'),
                                                 -> ('1000000001', 'Withdrawal', 2000, 'ATM withdrawal'),

                                                 -> ('1000000002', 'Deposit', 10000, 'Salary credited'),
                                                 -> ('1000000003', 'Withdrawal', 3000, 'Cash withdrawal'),
                                                 -> ('1000000004', 'Deposit', 7500, 'Cheque deposit'),
                                                 -> ('1000000005', 'Withdrawal', 1500, 'ATM withdrawal'),

                                                 -> ('1000000006', 'Deposit', 12000, 'Business payment'),

                                                 -> ('1000000007', 'Withdrawal', 4000, 'Online payment'),

                                                 -> ('1000000008', 'Deposit', 6000, 'Cash deposit'),
                                                 -> ('1000000000', 'Withdrawal', 1000, 'Utility bill payment');
Query OK, 10 rows affected (0.0387 sec)

Records: 10  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT * FROM branches;
+-----------+--------------------+----------+---------------------+------------+
| branch_id | branch_name        | city     | address             | phone      |
+-----------+--------------------+----------+---------------------+------------+
|         1 | Park Street Branch | Kolkata  | 12 Park Street      | 9876543210 |
|         2 | Salt Lake Branch   | Kolkata  | Sector V, Salt Lake | 9876543211 |
|         3 | Howrah Branch      | Howrah   | GT Road, Howrah     | 9876543212 |
|         4 | Durgapur Branch    | Durgapur | City Centre         | 9876543213 |
|         5 | Siliguri Branch    | Siliguri | Hill Cart Road      | 9876543214 |
|         6 | Park Street Branch | Kolkata  | 12 Park Street      | 9876543210 |
|         7 | Salt Lake Branch   | Kolkata  | Sector V, Salt Lake | 9876543211 |
|         8 | Howrah Branch      | Howrah   | GT Road, Howrah     | 9876543212 |
|         9 | Durgapur Branch    | Durgapur | City Centre         | 9876543213 |
|        10 | Siliguri Branch    | Siliguri | Hill Cart Road      | 9876543214 |
+-----------+--------------------+----------+---------------------+------------+
10 rows in set (0.0012 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT * FROM customers;
+-------------+------------+-----------+------------------+------------+-----------+-----------+
| customer_id | first_name | last_name | email            | phone      | address   | branch_id |
+-------------+------------+-----------+------------------+------------+-----------+-----------+
|           1 | Rahul      | Sharma    | rahul@gmail.com  | 9876500001 | Kolkata   |         1 |
|           2 | Priya      | Das       | priya@gmail.com  | 9876500002 | Salt Lake |         2 |
|           3 | Amit       | Roy       | amit@gmail.com   | 9876500003 | Howrah    |         3 |
|           4 | Arjun      | Sen       | arjun@gmail.com  | 9876500005 | Siliguri  |         5 |
|           5 | Neha       | Ghosh     | neha@gmail.com   | 9876500006 | Kolkata   |         1 |
|           6 | Rohan      | Paul      | rohan@gmail.com  | 9876500007 | Howrah    |         3 |
|           7 | Ananya     | Bose      | ananya@gmail.com | 9876500008 | Salt Lake |         2 |
|           8 | Karan      | Mitra     | karan@gmail.com  | 9876500009 | Durgapur  |         4 |
|           9 | Isha       | Sen       | isha@gmail.com   | 9876500010 | Siliguri  |         5 |
+-------------+------------+-----------+------------------+------------+-----------+-----------+
9 rows in set (0.0009 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT * FROM accounts;
+------------+------------+-------------+----------+----------+--------------+--------+
| account_id | acc_no     | customer_id | acc_type | balance  | opening_date | status |
+------------+------------+-------------+----------+----------+--------------+--------+
|          1 | 1000000000 |           1 | Savings  | 28500.00 | 2025-01-10   | Active |
|          2 | 1000000001 |           2 | Savings  | 36000.00 | 2025-02-15   | Active |
|          3 | 1000000002 |           3 | Current  | 60000.00 | 2025-03-20   | Active |
|          4 | 1000000003 |           4 | Savings  | 72000.00 | 2025-05-12   | Active |
|          5 | 1000000004 |           5 | Savings  | 49500.00 | 2025-06-18   | Active |
|          6 | 1000000005 |           6 | Savings  | 13500.00 | 2025-07-22   | Active |
|          7 | 1000000006 |           7 | Current  | 72000.00 | 2025-08-11   | Active |
|          8 | 1000000007 |           8 | Savings  | 24000.00 | 2025-09-14   | Active |
|          9 | 1000000008 |           9 | Savings  | 38000.00 | 2025-10-19   | Active |
+------------+------------+-------------+----------+----------+--------------+--------+
9 rows in set (0.0005 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT * FROM transactions;
+----------------+------------+------------------+----------+---------------------+----------------------------------+
| transaction_id | acc_no     | transaction_type | amount   | transaction_date    | description                      |
+----------------+------------+------------------+----------+---------------------+----------------------------------+
|              1 | 1000000000 | Deposit          |  5000.00 | 2026-11-19 13:55:45 | Cash deposit                     |
|              2 | 1000000001 | Withdrawal       |  2000.00 | 2026-11-19 13:55:45 | ATM withdrawal                   |
|              3 | 1000000002 | Deposit          | 10000.00 | 2026-11-19 13:55:45 | Salary credited                  |
|              4 | 1000000003 | Withdrawal       |  3000.00 | 2026-11-19 13:55:45 | Cash withdrawal                  |
|              5 | 1000000004 | Deposit          |  7500.00 | 2026-11-19 13:55:45 | Cheque deposit                   |
|              6 | 1000000005 | Withdrawal       |  1500.00 | 2026-11-19 13:55:45 | ATM withdrawal                   |
|              7 | 1000000006 | Deposit          | 12000.00 | 2026-11-19 13:55:45 | Business payment                 |
|              8 | 1000000007 | Withdrawal       |  4000.00 | 2026-11-19 13:55:45 | Online payment                   |
|              9 | 1000000008 | Deposit          |  6000.00 | 2026-11-19 13:55:45 | Cash deposit                     |
|             10 | 1000000000 | Withdrawal       |  1000.00 | 2026-11-19 13:55:45 | Utility bill payment             |
|             11 | 1000000000 | Deposit          |  5000.00 | 2026-11-19 13:55:45 | Trigger test deposit             |
|             12 | 1000000000 | Withdrawal       |  2000.00 | 2026-11-19 13:55:45 | Trigger test withdrawal          |
|             13 | 1000000000 | Withdrawal       |  3000.00 | 2026-11-19 13:55:45 | Transfer to account 1000000001   |
|             14 | 1000000001 | Deposit          |  3000.00 | 2026-11-19 13:55:45 | Transfer from account 1000000000 |
|             16 | 1000000000 | Withdrawal       |   500.00 | 2026-11-19 13:55:46 | Valid withdrawal test            |
|             17 | 1000000000 | Deposit          |  5000.00 | 2026-11-19 14:05:59 | Cash deposit                     |
|             18 | 1000000001 | Withdrawal       |  2000.00 | 2026-11-19 14:05:59 | ATM withdrawal                   |
|             19 | 1000000002 | Deposit          | 10000.00 | 2026-11-19 14:05:59 | Salary credited                  |
|             20 | 1000000003 | Withdrawal       |  3000.00 | 2026-11-19 14:05:59 | Cash withdrawal                  |
|             21 | 1000000004 | Deposit          |  7500.00 | 2026-11-19 14:05:59 | Cheque deposit                   |
|             22 | 1000000005 | Withdrawal       |  1500.00 | 2026-11-19 14:05:59 | ATM withdrawal                   |
|             23 | 1000000006 | Deposit          | 12000.00 | 2026-11-19 14:05:59 | Business payment                 |
|             24 | 1000000007 | Withdrawal       |  4000.00 | 2026-11-19 14:05:59 | Online payment                   |
|             25 | 1000000008 | Deposit          |  6000.00 | 2026-11-19 14:05:59 | Cash deposit                     |
|             26 | 1000000000 | Withdrawal       |  1000.00 | 2026-11-19 14:05:59 | Utility bill payment             |
+----------------+------------+------------------+----------+---------------------+----------------------------------+
25 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT first_name, last_name, email
                                                 -> FROM customers;
+------------+-----------+------------------+
| first_name | last_name | email            |
+------------+-----------+------------------+
| Rahul      | Sharma    | rahul@gmail.com  |
| Priya      | Das       | priya@gmail.com  |
| Amit       | Roy       | amit@gmail.com   |
| Arjun      | Sen       | arjun@gmail.com  |
| Neha       | Ghosh     | neha@gmail.com   |
| Rohan      | Paul      | rohan@gmail.com  |
| Ananya     | Bose      | ananya@gmail.com |
| Karan      | Mitra     | karan@gmail.com  |
| Isha       | Sen       | isha@gmail.com   |
+------------+-----------+------------------+
9 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM customers
                                                 -> WHERE address = 'Kolkata';
+-------------+------------+-----------+-----------------+------------+---------+-----------+
| customer_id | first_name | last_name | email           | phone      | address | branch_id |
+-------------+------------+-----------+-----------------+------------+---------+-----------+
|           1 | Rahul      | Sharma    | rahul@gmail.com | 9876500001 | Kolkata |         1 |
|           5 | Neha       | Ghosh     | neha@gmail.com  | 9876500006 | Kolkata |         1 |
+-------------+------------+-----------+-----------------+------------+---------+-----------+
2 rows in set (0.0019 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM accounts
                                                 -> WHERE balance > 30000;
+------------+------------+-------------+----------+----------+--------------+--------+
| account_id | acc_no     | customer_id | acc_type | balance  | opening_date | status |
+------------+------------+-------------+----------+----------+--------------+--------+
|          2 | 1000000001 |           2 | Savings  | 36000.00 | 2025-02-15   | Active |
|          3 | 1000000002 |           3 | Current  | 60000.00 | 2025-03-20   | Active |
|          4 | 1000000003 |           4 | Savings  | 72000.00 | 2025-05-12   | Active |
|          5 | 1000000004 |           5 | Savings  | 49500.00 | 2025-06-18   | Active |
|          7 | 1000000006 |           7 | Current  | 72000.00 | 2025-08-11   | Active |
|          9 | 1000000008 |           9 | Savings  | 38000.00 | 2025-10-19   | Active |
+------------+------------+-------------+----------+----------+--------------+--------+
6 rows in set (0.0013 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM accounts
                                                 -> WHERE balance < 30000;
+------------+------------+-------------+----------+----------+--------------+--------+
| account_id | acc_no     | customer_id | acc_type | balance  | opening_date | status |
+------------+------------+-------------+----------+----------+--------------+--------+
|          1 | 1000000000 |           1 | Savings  | 28500.00 | 2025-01-10   | Active |
|          6 | 1000000005 |           6 | Savings  | 13500.00 | 2025-07-22   | Active |
|          8 | 1000000007 |           8 | Savings  | 24000.00 | 2025-09-14   | Active |
+------------+------------+-------------+----------+----------+--------------+--------+
3 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM accounts
                                                 -> WHERE status = 'Active';
+------------+------------+-------------+----------+----------+--------------+--------+
| account_id | acc_no     | customer_id | acc_type | balance  | opening_date | status |
+------------+------------+-------------+----------+----------+--------------+--------+
|          1 | 1000000000 |           1 | Savings  | 28500.00 | 2025-01-10   | Active |
|          2 | 1000000001 |           2 | Savings  | 36000.00 | 2025-02-15   | Active |
|          3 | 1000000002 |           3 | Current  | 60000.00 | 2025-03-20   | Active |
|          4 | 1000000003 |           4 | Savings  | 72000.00 | 2025-05-12   | Active |
|          5 | 1000000004 |           5 | Savings  | 49500.00 | 2025-06-18   | Active |
|          6 | 1000000005 |           6 | Savings  | 13500.00 | 2025-07-22   | Active |
|          7 | 1000000006 |           7 | Current  | 72000.00 | 2025-08-11   | Active |
|          8 | 1000000007 |           8 | Savings  | 24000.00 | 2025-09-14   | Active |
|          9 | 1000000008 |           9 | Savings  | 38000.00 | 2025-10-19   | Active |
+------------+------------+-------------+----------+----------+--------------+--------+
9 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM accounts
                                                 -> WHERE acc_type = 'Savings';
+------------+------------+-------------+----------+----------+--------------+--------+
| account_id | acc_no     | customer_id | acc_type | balance  | opening_date | status |
+------------+------------+-------------+----------+----------+--------------+--------+
|          1 | 1000000000 |           1 | Savings  | 28500.00 | 2025-01-10   | Active |
|          2 | 1000000001 |           2 | Savings  | 36000.00 | 2025-02-15   | Active |
|          4 | 1000000003 |           4 | Savings  | 72000.00 | 2025-05-12   | Active |
|          5 | 1000000004 |           5 | Savings  | 49500.00 | 2025-06-18   | Active |
|          6 | 1000000005 |           6 | Savings  | 13500.00 | 2025-07-22   | Active |
|          8 | 1000000007 |           8 | Savings  | 24000.00 | 2025-09-14   | Active |
|          9 | 1000000008 |           9 | Savings  | 38000.00 | 2025-10-19   | Active |
+------------+------------+-------------+----------+----------+--------------+--------+
7 rows in set (0.0012 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM accounts
                                                 -> ORDER BY balance ASC;
+------------+------------+-------------+----------+----------+--------------+--------+
| account_id | acc_no     | customer_id | acc_type | balance  | opening_date | status |
+------------+------------+-------------+----------+----------+--------------+--------+
|          6 | 1000000005 |           6 | Savings  | 13500.00 | 2025-07-22   | Active |
|          8 | 1000000007 |           8 | Savings  | 24000.00 | 2025-09-14   | Active |
|          1 | 1000000000 |           1 | Savings  | 28500.00 | 2025-01-10   | Active |
|          2 | 1000000001 |           2 | Savings  | 36000.00 | 2025-02-15   | Active |
|          9 | 1000000008 |           9 | Savings  | 38000.00 | 2025-10-19   | Active |
|          5 | 1000000004 |           5 | Savings  | 49500.00 | 2025-06-18   | Active |
|          3 | 1000000002 |           3 | Current  | 60000.00 | 2025-03-20   | Active |
|          4 | 1000000003 |           4 | Savings  | 72000.00 | 2025-05-12   | Active |
|          7 | 1000000006 |           7 | Current  | 72000.00 | 2025-08-11   | Active |
+------------+------------+-------------+----------+----------+--------------+--------+
9 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM accounts
                                                 -> ORDER BY balance DESC;
+------------+------------+-------------+----------+----------+--------------+--------+
| account_id | acc_no     | customer_id | acc_type | balance  | opening_date | status |
+------------+------------+-------------+----------+----------+--------------+--------+
|          4 | 1000000003 |           4 | Savings  | 72000.00 | 2025-05-12   | Active |
|          7 | 1000000006 |           7 | Current  | 72000.00 | 2025-08-11   | Active |
|          3 | 1000000002 |           3 | Current  | 60000.00 | 2025-03-20   | Active |
|          5 | 1000000004 |           5 | Savings  | 49500.00 | 2025-06-18   | Active |
|          9 | 1000000008 |           9 | Savings  | 38000.00 | 2025-10-19   | Active |
|          2 | 1000000001 |           2 | Savings  | 36000.00 | 2025-02-15   | Active |
|          1 | 1000000000 |           1 | Savings  | 28500.00 | 2025-01-10   | Active |
|          8 | 1000000007 |           8 | Savings  | 24000.00 | 2025-09-14   | Active |
|          6 | 1000000005 |           6 | Savings  | 13500.00 | 2025-07-22   | Active |
+------------+------------+-------------+----------+----------+--------------+--------+
9 rows in set (0.0012 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT DISTINCT acc_type
                                                 -> FROM accounts;
+----------+
| acc_type |
+----------+
| Savings  |
| Current  |
+----------+
2 rows in set (0.0005 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM customers
                                                 -> WHERE first_name LIKE 'A%';
+-------------+------------+-----------+------------------+------------+-----------+-----------+
| customer_id | first_name | last_name | email            | phone      | address   | branch_id |
+-------------+------------+-----------+------------------+------------+-----------+-----------+
|           3 | Amit       | Roy       | amit@gmail.com   | 9876500003 | Howrah    |         3 |
|           4 | Arjun      | Sen       | arjun@gmail.com  | 9876500005 | Siliguri  |         5 |
|           7 | Ananya     | Bose      | ananya@gmail.com | 9876500008 | Salt Lake |         2 |
+-------------+------------+-----------+------------------+------------+-----------+-----------+
3 rows in set (0.0005 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM customers
                                                 -> WHERE first_name LIKE '%a';
+-------------+------------+-----------+------------------+------------+-----------+-----------+
| customer_id | first_name | last_name | email            | phone      | address   | branch_id |
+-------------+------------+-----------+------------------+------------+-----------+-----------+
|           2 | Priya      | Das       | priya@gmail.com  | 9876500002 | Salt Lake |         2 |
|           5 | Neha       | Ghosh     | neha@gmail.com   | 9876500006 | Kolkata   |         1 |
|           7 | Ananya     | Bose      | ananya@gmail.com | 9876500008 | Salt Lake |         2 |
|           9 | Isha       | Sen       | isha@gmail.com   | 9876500010 | Siliguri  |         5 |
+-------------+------------+-----------+------------------+------------+-----------+-----------+
4 rows in set (0.0005 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM customers
                                                 -> WHERE first_name LIKE '%an%';
+-------------+------------+-----------+------------------+------------+-----------+-----------+
| customer_id | first_name | last_name | email            | phone      | address   | branch_id |
+-------------+------------+-----------+------------------+------------+-----------+-----------+
|           6 | Rohan      | Paul      | rohan@gmail.com  | 9876500007 | Howrah    |         3 |
|           7 | Ananya     | Bose      | ananya@gmail.com | 9876500008 | Salt Lake |         2 |
|           8 | Karan      | Mitra     | karan@gmail.com  | 9876500009 | Durgapur  |         4 |
+-------------+------------+-----------+------------------+------------+-----------+-----------+
3 rows in set (0.0005 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT COUNT(*) AS total_customers
                                                 -> FROM customers;
+-----------------+
| total_customers |
+-----------------+
|               9 |
+-----------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT COUNT(*) AS total_accounts
                                                 -> FROM accounts;
+----------------+
| total_accounts |
+----------------+
|              9 |
+----------------+
1 row in set (0.0004 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT SUM(balance) AS total_bank_balance
                                                 -> FROM accounts;
+--------------------+
| total_bank_balance |
+--------------------+
|          393500.00 |
+--------------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT MAX(balance) AS highest_balance
                                                 -> FROM accounts;
+-----------------+
| highest_balance |
+-----------------+
|        72000.00 |
+-----------------+
1 row in set (0.0004 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT MIN(balance) AS lowest_balance
                                                 -> FROM accounts;
+----------------+
| lowest_balance |
+----------------+
|       13500.00 |
+----------------+
1 row in set (0.0003 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT AVG(balance) AS average_balance
                                                 -> FROM accounts;
+-----------------+
| average_balance |
+-----------------+
|    43722.222222 |
+-----------------+
1 row in set (0.0007 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT acc_type, COUNT(*) AS total_accounts
                                                 -> FROM accounts
                                                 -> GROUP BY acc_type;
+----------+----------------+
| acc_type | total_accounts |
+----------+----------------+
| Savings  |              7 |
| Current  |              2 |
+----------+----------------+
2 rows in set (0.0005 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT acc_type, SUM(balance) AS total_balance
                                                 -> FROM accounts
                                                 -> GROUP BY acc_type;
+----------+---------------+
| acc_type | total_balance |
+----------+---------------+
| Savings  |     261500.00 |
| Current  |     132000.00 |
+----------+---------------+
2 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT acc_type, COUNT(*) AS total_accounts
                                                 -> FROM accounts
                                                 -> GROUP BY acc_type
                                                 -> HAVING COUNT(*) > 1;
+----------+----------------+
| acc_type | total_accounts |
+----------+----------------+
| Savings  |              7 |
| Current  |              2 |
+----------+----------------+
2 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT branch_id, COUNT(*) AS total_customers
                                                 -> FROM customers
                                                 -> GROUP BY branch_id;
+-----------+-----------------+
| branch_id | total_customers |
+-----------+-----------------+
|         1 |               2 |
|         2 |               2 |
|         3 |               2 |
|         4 |               1 |
|         5 |               2 |
+-----------+-----------------+
5 rows in set (0.0006 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT
                                                 ->     customers.customer_id,
                                                 ->     customers.first_name,
                                                 ->     customers.last_name,
                                                 ->     branches.branch_name,
                                                 ->     branches.city
                                                 -> FROM customers
                                                 -> INNER JOIN branches
                                                 -> ON customers.branch_id = branches.branch_id;
+-------------+------------+-----------+--------------------+----------+
| customer_id | first_name | last_name | branch_name        | city     |
+-------------+------------+-----------+--------------------+----------+
|           1 | Rahul      | Sharma    | Park Street Branch | Kolkata  |
|           2 | Priya      | Das       | Salt Lake Branch   | Kolkata  |
|           3 | Amit       | Roy       | Howrah Branch      | Howrah   |
|           4 | Arjun      | Sen       | Siliguri Branch    | Siliguri |
|           5 | Neha       | Ghosh     | Park Street Branch | Kolkata  |
|           6 | Rohan      | Paul      | Howrah Branch      | Howrah   |
|           7 | Ananya     | Bose      | Salt Lake Branch   | Kolkata  |
|           8 | Karan      | Mitra     | Durgapur Branch    | Durgapur |
|           9 | Isha       | Sen       | Siliguri Branch    | Siliguri |
+-------------+------------+-----------+--------------------+----------+
9 rows in set (0.0006 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT
                                                 ->     customers.first_name,
                                                 ->     customers.last_name,
                                                 ->     accounts.acc_no,
                                                 ->     accounts.acc_type,
                                                 ->     accounts.balance
                                                 -> FROM customers
                                                 -> INNER JOIN accounts
                                                 -> ON customers.customer_id = accounts.customer_id;
+------------+-----------+------------+----------+----------+
| first_name | last_name | acc_no     | acc_type | balance  |
+------------+-----------+------------+----------+----------+
| Rahul      | Sharma    | 1000000000 | Savings  | 28500.00 |
| Priya      | Das       | 1000000001 | Savings  | 36000.00 |
| Amit       | Roy       | 1000000002 | Current  | 60000.00 |
| Arjun      | Sen       | 1000000003 | Savings  | 72000.00 |
| Neha       | Ghosh     | 1000000004 | Savings  | 49500.00 |
| Rohan      | Paul      | 1000000005 | Savings  | 13500.00 |
| Ananya     | Bose      | 1000000006 | Current  | 72000.00 |
| Karan      | Mitra     | 1000000007 | Savings  | 24000.00 |
| Isha       | Sen       | 1000000008 | Savings  | 38000.00 |
+------------+-----------+------------+----------+----------+
9 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT
                                                 ->     customers.first_name,
                                                 ->     customers.last_name,
                                                 ->     accounts.acc_no,
                                                 ->     transactions.transaction_type,
                                                 ->     transactions.amount,
                                                 ->     transactions.description
                                                 -> FROM customers
                                                 -> INNER JOIN accounts
                                                 -> ON customers.customer_id = accounts.customer_id
                                                 -> INNER JOIN transactions
                                                 -> ON accounts.acc_no = transactions.acc_no;
+------------+-----------+------------+------------------+----------+----------------------------------+
| first_name | last_name | acc_no     | transaction_type | amount   | description                      |
+------------+-----------+------------+------------------+----------+----------------------------------+
| Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | Cash deposit                     |
| Rahul      | Sharma    | 1000000000 | Withdrawal       |  1000.00 | Utility bill payment             |
| Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | Trigger test deposit             |
| Rahul      | Sharma    | 1000000000 | Withdrawal       |  2000.00 | Trigger test withdrawal          |
| Rahul      | Sharma    | 1000000000 | Withdrawal       |  3000.00 | Transfer to account 1000000001   |
| Rahul      | Sharma    | 1000000000 | Withdrawal       |   500.00 | Valid withdrawal test            |
| Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | Cash deposit                     |
| Rahul      | Sharma    | 1000000000 | Withdrawal       |  1000.00 | Utility bill payment             |
| Priya      | Das       | 1000000001 | Withdrawal       |  2000.00 | ATM withdrawal                   |
| Priya      | Das       | 1000000001 | Deposit          |  3000.00 | Transfer from account 1000000000 |
| Priya      | Das       | 1000000001 | Withdrawal       |  2000.00 | ATM withdrawal                   |
| Amit       | Roy       | 1000000002 | Deposit          | 10000.00 | Salary credited                  |
| Amit       | Roy       | 1000000002 | Deposit          | 10000.00 | Salary credited                  |
| Arjun      | Sen       | 1000000003 | Withdrawal       |  3000.00 | Cash withdrawal                  |
| Arjun      | Sen       | 1000000003 | Withdrawal       |  3000.00 | Cash withdrawal                  |
| Neha       | Ghosh     | 1000000004 | Deposit          |  7500.00 | Cheque deposit                   |
| Neha       | Ghosh     | 1000000004 | Deposit          |  7500.00 | Cheque deposit                   |
| Rohan      | Paul      | 1000000005 | Withdrawal       |  1500.00 | ATM withdrawal                   |
| Rohan      | Paul      | 1000000005 | Withdrawal       |  1500.00 | ATM withdrawal                   |
| Ananya     | Bose      | 1000000006 | Deposit          | 12000.00 | Business payment                 |
| Ananya     | Bose      | 1000000006 | Deposit          | 12000.00 | Business payment                 |
| Karan      | Mitra     | 1000000007 | Withdrawal       |  4000.00 | Online payment                   |
| Karan      | Mitra     | 1000000007 | Withdrawal       |  4000.00 | Online payment                   |
| Isha       | Sen       | 1000000008 | Deposit          |  6000.00 | Cash deposit                     |
| Isha       | Sen       | 1000000008 | Deposit          |  6000.00 | Cash deposit                     |
+------------+-----------+------------+------------------+----------+----------------------------------+
25 rows in set (0.0010 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT
                                                 ->     customers.first_name,
                                                 ->     customers.last_name,
                                                 ->     accounts.acc_no
                                                 -> FROM customers
                                                 -> LEFT JOIN accounts
                                                 -> ON customers.customer_id = accounts.customer_id;
+------------+-----------+------------+
| first_name | last_name | acc_no     |
+------------+-----------+------------+
| Rahul      | Sharma    | 1000000000 |
| Priya      | Das       | 1000000001 |
| Amit       | Roy       | 1000000002 |
| Arjun      | Sen       | 1000000003 |
| Neha       | Ghosh     | 1000000004 |
| Rohan      | Paul      | 1000000005 |
| Ananya     | Bose      | 1000000006 |
| Karan      | Mitra     | 1000000007 |
| Isha       | Sen       | 1000000008 |
+------------+-----------+------------+
9 rows in set (0.0006 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DELIMITER //
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE TRIGGER check_transaction_amount
                                                 -> BEFORE INSERT ON transactions
                                                 -> FOR EACH ROW
                                                 -> BEGIN
                                                 ->     IF NEW.amount <= 0 THEN
                                                 ->         SIGNAL SQLSTATE '45000'
                                                 ->         SET MESSAGE_TEXT =
                                                 ->         'Transaction amount must be greater than zero';
                                                 ->     END IF;
                                                 -> END //
ERROR: 1359 (HY000): Trigger already exists
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE TRIGGER update_account_balance
                                                 -> AFTER INSERT ON transactions
                                                 -> FOR EACH ROW
                                                 -> BEGIN
                                                 ->
                                                 ->     IF NEW.transaction_type = 'Deposit' THEN
                                                 ->
                                                 ->         UPDATE accounts
                                                 ->         SET balance = balance + NEW.amount
                                                 ->         WHERE acc_no = NEW.acc_no;
                                                 ->
                                                 ->     ELSEIF NEW.transaction_type = 'Withdrawal' THEN
                                                 ->
                                                 ->         UPDATE accounts
                                                 ->         SET balance = balance - NEW.amount
                                                 ->         WHERE acc_no = NEW.acc_no;
                                                 ->
                                                 ->     END IF;
                                                 ->
                                                 -> END //
ERROR: 1359 (HY000): Trigger already exists
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DELIMITER ;
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT acc_no, balance
                                                 -> FROM accounts
                                                 -> WHERE acc_no = '1000000000';
+------------+----------+
| acc_no     | balance  |
+------------+----------+
| 1000000000 | 28500.00 |
+------------+----------+
1 row in set (0.0010 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > INSERT INTO transactions
                                                 -> (acc_no, transaction_type, amount, description)
                                                 -> VALUES
                                                 -> ('1000000000', 'Deposit', 5000, 'Trigger test deposit');
Query OK, 1 row affected (0.0330 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT acc_no, balance
                                                 -> FROM accounts
                                                 -> WHERE acc_no = '1000000000';
+------------+----------+
| acc_no     | balance  |
+------------+----------+
| 1000000000 | 33500.00 |
+------------+----------+
1 row in set (0.0008 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > INSERT INTO transactions
                                                 -> (acc_no, transaction_type, amount, description)
                                                 -> VALUES
                                                 -> ('1000000000', 'Withdrawal', 2000, 'Trigger test withdrawal');
Query OK, 1 row affected (0.0085 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT acc_no, balance
                                                 -> FROM accounts
                                                 -> WHERE acc_no = '1000000000';
+------------+----------+
| acc_no     | balance  |
+------------+----------+
| 1000000000 | 31500.00 |
+------------+----------+
1 row in set (0.0008 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SHOW TRIGGERS;
+--------------------------+--------+--------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
| Trigger                  | Event  | Table        | Statement                                                                                                               | Timing | Created| sql_mode                                                                                                              | Definer        | character_set_client | collation_connection | Database Collation |
+--------------------------+--------+--------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
| check_transaction_amount | INSERT | transactions | BEGIN
    IF NEW.amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Transaction amount must be greater than zero';
    END IF;
END                                          | BEFORE | 2026-11-19 13:55:45.82 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| check_withdrawal_balance | INSERT | transactions | BEGIN

    IF NEW.transaction_type = 'Withdrawal' THEN

        IF NEW.amount > (
            SELECT balance
            FROM accounts
            WHERE acc_no = NEW.acc_no
        ) THEN

            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Insufficient balance! Withdrawal rejected';

        END IF;

    END IF;

END | BEFORE | 2026-11-19 13:55:46.10 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| update_account_balance   | INSERT | transactions | BEGIN

    IF NEW.transaction_type = 'Deposit' THEN

        UPDATE accounts
        SET balance = balance + NEW.amount
        WHERE acc_no = NEW.acc_no;

    ELSEIF NEW.transaction_type = 'Withdrawal' THEN

        UPDATE accounts
        SET balance = balance - NEW.amount
        WHERE acc_no = NEW.acc_no;

    END IF;

END                    | AFTER  | 2026-11-19 13:55:45.83 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
+--------------------------+--------+--------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
3 rows in set (0.0016 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT acc_no, balance
                                                 -> FROM accounts
                                                 -> WHERE acc_no IN ('1000000000', '1000000001');
+------------+----------+
| acc_no     | balance  |
+------------+----------+
| 1000000000 | 31500.00 |
| 1000000001 | 36000.00 |
+------------+----------+
2 rows in set (0.0010 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > START TRANSACTION;
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  ★  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  ★  SQL > INSERT INTO transactions
                                                    -> (acc_no, transaction_type, amount, description)
                                                    -> VALUES
                                                    -> ('1000000000', 'Withdrawal', 3000,
                                                    ->  'Transfer to account 1000000001');
Query OK, 1 row affected (0.0015 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  ★  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  ★  SQL > INSERT INTO transactions
                                                    -> (acc_no, transaction_type, amount, description)
                                                    -> VALUES
                                                    -> ('1000000001', 'Deposit', 3000,
                                                    ->  'Transfer from account 1000000000');
Query OK, 1 row affected (0.0012 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  ★  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  ★  SQL > COMMIT;
Query OK, 0 rows affected (0.0064 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT acc_no, balance
                                                 -> FROM accounts
                                                 -> WHERE acc_no IN ('1000000000', '1000000001');
+------------+----------+
| acc_no     | balance  |
+------------+----------+
| 1000000000 | 28500.00 |
| 1000000001 | 39000.00 |
+------------+----------+
2 rows in set (0.0009 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM transactions
                                                 -> ORDER BY transaction_id DESC
                                                 -> LIMIT 5;
+----------------+------------+------------------+---------+---------------------+----------------------------------+
| transaction_id | acc_no     | transaction_type | amount  | transaction_date    | description                      |
+----------------+------------+------------------+---------+---------------------+----------------------------------+
|             30 | 1000000001 | Deposit          | 3000.00 | 2026-11-19 14:06:01 | Transfer from account 1000000000 |
|             29 | 1000000000 | Withdrawal       | 3000.00 | 2026-11-19 14:06:00 | Transfer to account 1000000001   |
|             28 | 1000000000 | Withdrawal       | 2000.00 | 2026-11-19 14:06:00 | Trigger test withdrawal          |
|             27 | 1000000000 | Deposit          | 5000.00 | 2026-11-19 14:06:00 | Trigger test deposit             |
|             26 | 1000000000 | Withdrawal       | 1000.00 | 2026-11-19 14:05:59 | Utility bill payment             |
+----------------+------------+------------------+---------+---------------------+----------------------------------+
5 rows in set (0.0007 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > START TRANSACTION;
Query OK, 0 rows affected (0.0005 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  ★  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  ★  SQL > INSERT INTO transactions
                                                    -> (acc_no, transaction_type, amount, description)
                                                    -> VALUES
                                                    -> ('1000000000', 'Deposit', 1000,
                                                    ->  'Rollback demonstration');
Query OK, 1 row affected (0.0009 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  ★  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  ★  SQL > ROLLBACK;
Query OK, 0 rows affected (0.0042 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM transactions
                                                 -> WHERE description = 'Rollback demonstration';
Empty set (0.0007 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT * FROM branches;
+-----------+--------------------+----------+---------------------+------------+
| branch_id | branch_name        | city     | address             | phone      |
+-----------+--------------------+----------+---------------------+------------+
|         1 | Park Street Branch | Kolkata  | 12 Park Street      | 9876543210 |
|         2 | Salt Lake Branch   | Kolkata  | Sector V, Salt Lake | 9876543211 |
|         3 | Howrah Branch      | Howrah   | GT Road, Howrah     | 9876543212 |
|         4 | Durgapur Branch    | Durgapur | City Centre         | 9876543213 |
|         5 | Siliguri Branch    | Siliguri | Hill Cart Road      | 9876543214 |
|         6 | Park Street Branch | Kolkata  | 12 Park Street      | 9876543210 |
|         7 | Salt Lake Branch   | Kolkata  | Sector V, Salt Lake | 9876543211 |
|         8 | Howrah Branch      | Howrah   | GT Road, Howrah     | 9876543212 |
|         9 | Durgapur Branch    | Durgapur | City Centre         | 9876543213 |
|        10 | Siliguri Branch    | Siliguri | Hill Cart Road      | 9876543214 |
+-----------+--------------------+----------+---------------------+------------+
10 rows in set (0.0008 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT * FROM customers;
+-------------+------------+-----------+------------------+------------+-----------+-----------+
| customer_id | first_name | last_name | email            | phone      | address   | branch_id |
+-------------+------------+-----------+------------------+------------+-----------+-----------+
|           1 | Rahul      | Sharma    | rahul@gmail.com  | 9876500001 | Kolkata   |         1 |
|           2 | Priya      | Das       | priya@gmail.com  | 9876500002 | Salt Lake |         2 |
|           3 | Amit       | Roy       | amit@gmail.com   | 9876500003 | Howrah    |         3 |
|           4 | Arjun      | Sen       | arjun@gmail.com  | 9876500005 | Siliguri  |         5 |
|           5 | Neha       | Ghosh     | neha@gmail.com   | 9876500006 | Kolkata   |         1 |
|           6 | Rohan      | Paul      | rohan@gmail.com  | 9876500007 | Howrah    |         3 |
|           7 | Ananya     | Bose      | ananya@gmail.com | 9876500008 | Salt Lake |         2 |
|           8 | Karan      | Mitra     | karan@gmail.com  | 9876500009 | Durgapur  |         4 |
|           9 | Isha       | Sen       | isha@gmail.com   | 9876500010 | Siliguri  |         5 |
+-------------+------------+-----------+------------------+------------+-----------+-----------+
9 rows in set (0.0012 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT * FROM accounts;
+------------+------------+-------------+----------+----------+--------------+--------+
| account_id | acc_no     | customer_id | acc_type | balance  | opening_date | status |
+------------+------------+-------------+----------+----------+--------------+--------+
|          1 | 1000000000 |           1 | Savings  | 28500.00 | 2025-01-10   | Active |
|          2 | 1000000001 |           2 | Savings  | 39000.00 | 2025-02-15   | Active |
|          3 | 1000000002 |           3 | Current  | 60000.00 | 2025-03-20   | Active |
|          4 | 1000000003 |           4 | Savings  | 72000.00 | 2025-05-12   | Active |
|          5 | 1000000004 |           5 | Savings  | 49500.00 | 2025-06-18   | Active |
|          6 | 1000000005 |           6 | Savings  | 13500.00 | 2025-07-22   | Active |
|          7 | 1000000006 |           7 | Current  | 72000.00 | 2025-08-11   | Active |
|          8 | 1000000007 |           8 | Savings  | 24000.00 | 2025-09-14   | Active |
|          9 | 1000000008 |           9 | Savings  | 38000.00 | 2025-10-19   | Active |
+------------+------------+-------------+----------+----------+--------------+--------+
9 rows in set (0.0008 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT * FROM transactions;
+----------------+------------+------------------+----------+---------------------+----------------------------------+
| transaction_id | acc_no     | transaction_type | amount   | transaction_date    | description                      |
+----------------+------------+------------------+----------+---------------------+----------------------------------+
|              1 | 1000000000 | Deposit          |  5000.00 | 2026-11-19 13:55:45 | Cash deposit                     |
|              2 | 1000000001 | Withdrawal       |  2000.00 | 2026-11-19 13:55:45 | ATM withdrawal                   |
|              3 | 1000000002 | Deposit          | 10000.00 | 2026-11-19 13:55:45 | Salary credited                  |
|              4 | 1000000003 | Withdrawal       |  3000.00 | 2026-11-19 13:55:45 | Cash withdrawal                  |
|              5 | 1000000004 | Deposit          |  7500.00 | 2026-11-19 13:55:45 | Cheque deposit                   |
|              6 | 1000000005 | Withdrawal       |  1500.00 | 2026-11-19 13:55:45 | ATM withdrawal                   |
|              7 | 1000000006 | Deposit          | 12000.00 | 2026-11-19 13:55:45 | Business payment                 |
|              8 | 1000000007 | Withdrawal       |  4000.00 | 2026-11-19 13:55:45 | Online payment                   |
|              9 | 1000000008 | Deposit          |  6000.00 | 2026-11-19 13:55:45 | Cash deposit                     |
|             10 | 1000000000 | Withdrawal       |  1000.00 | 2026-11-19 13:55:45 | Utility bill payment             |
|             11 | 1000000000 | Deposit          |  5000.00 | 2026-11-19 13:55:45 | Trigger test deposit             |
|             12 | 1000000000 | Withdrawal       |  2000.00 | 2026-11-19 13:55:45 | Trigger test withdrawal          |
|             13 | 1000000000 | Withdrawal       |  3000.00 | 2026-11-19 13:55:45 | Transfer to account 1000000001   |
|             14 | 1000000001 | Deposit          |  3000.00 | 2026-11-19 13:55:45 | Transfer from account 1000000000 |
|             16 | 1000000000 | Withdrawal       |   500.00 | 2026-11-19 13:55:46 | Valid withdrawal test            |
|             17 | 1000000000 | Deposit          |  5000.00 | 2026-11-19 14:05:59 | Cash deposit                     |
|             18 | 1000000001 | Withdrawal       |  2000.00 | 2026-11-19 14:05:59 | ATM withdrawal                   |
|             19 | 1000000002 | Deposit          | 10000.00 | 2026-11-19 14:05:59 | Salary credited                  |
|             20 | 1000000003 | Withdrawal       |  3000.00 | 2026-11-19 14:05:59 | Cash withdrawal                  |
|             21 | 1000000004 | Deposit          |  7500.00 | 2026-11-19 14:05:59 | Cheque deposit                   |
|             22 | 1000000005 | Withdrawal       |  1500.00 | 2026-11-19 14:05:59 | ATM withdrawal                   |
|             23 | 1000000006 | Deposit          | 12000.00 | 2026-11-19 14:05:59 | Business payment                 |
|             24 | 1000000007 | Withdrawal       |  4000.00 | 2026-11-19 14:05:59 | Online payment                   |
|             25 | 1000000008 | Deposit          |  6000.00 | 2026-11-19 14:05:59 | Cash deposit                     |
|             26 | 1000000000 | Withdrawal       |  1000.00 | 2026-11-19 14:05:59 | Utility bill payment             |
|             27 | 1000000000 | Deposit          |  5000.00 | 2026-11-19 14:06:00 | Trigger test deposit             |
|             28 | 1000000000 | Withdrawal       |  2000.00 | 2026-11-19 14:06:00 | Trigger test withdrawal          |
|             29 | 1000000000 | Withdrawal       |  3000.00 | 2026-11-19 14:06:00 | Transfer to account 1000000001   |
|             30 | 1000000001 | Deposit          |  3000.00 | 2026-11-19 14:06:01 | Transfer from account 1000000000 |
+----------------+------------+------------------+----------+---------------------+----------------------------------+
29 rows in set (0.0009 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SHOW TABLES;
+----------------------------+
| Tables_in_embedded_bank_db |
+----------------------------+
| accounts                   |
| branches                   |
| customers                  |
| transactions               |
+----------------------------+
4 rows in set (0.0016 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SHOW TRIGGERS;
+--------------------------+--------+--------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
| Trigger                  | Event  | Table        | Statement                                                                                                               | Timing | Created| sql_mode                                                                                                              | Definer        | character_set_client | collation_connection | Database Collation |
+--------------------------+--------+--------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
| check_transaction_amount | INSERT | transactions | BEGIN
    IF NEW.amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Transaction amount must be greater than zero';
    END IF;
END                                          | BEFORE | 2026-11-19 13:55:45.82 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| check_withdrawal_balance | INSERT | transactions | BEGIN

    IF NEW.transaction_type = 'Withdrawal' THEN

        IF NEW.amount > (
            SELECT balance
            FROM accounts
            WHERE acc_no = NEW.acc_no
        ) THEN

            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Insufficient balance! Withdrawal rejected';

        END IF;

    END IF;

END | BEFORE | 2026-11-19 13:55:46.10 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| update_account_balance   | INSERT | transactions | BEGIN

    IF NEW.transaction_type = 'Deposit' THEN

        UPDATE accounts
        SET balance = balance + NEW.amount
        WHERE acc_no = NEW.acc_no;

    ELSEIF NEW.transaction_type = 'Withdrawal' THEN

        UPDATE accounts
        SET balance = balance - NEW.amount
        WHERE acc_no = NEW.acc_no;

    END IF;

END                    | AFTER  | 2026-11-19 13:55:45.83 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
+--------------------------+--------+--------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
3 rows in set (0.0012 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DELIMITER //
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE TRIGGER check_withdrawal_balance
                                                 -> BEFORE INSERT ON transactions
                                                 -> FOR EACH ROW
                                                 -> BEGIN
                                                 ->
                                                 ->     IF NEW.transaction_type = 'Withdrawal' THEN
                                                 ->
                                                 ->         IF NEW.amount > (
                                                 ->             SELECT balance
                                                 ->             FROM accounts
                                                 ->             WHERE acc_no = NEW.acc_no
                                                 ->         ) THEN
                                                 ->
                                                 ->             SIGNAL SQLSTATE '45000'
                                                 ->             SET MESSAGE_TEXT =
                                                 ->             'Insufficient balance! Withdrawal rejected';
                                                 ->
                                                 ->         END IF;
                                                 ->
                                                 ->     END IF;
                                                 ->
                                                 -> END //
ERROR: 1359 (HY000): Trigger already exists
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DELIMITER ;
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > INSERT INTO transactions
                                                 -> (acc_no, transaction_type, amount, description)
                                                 -> VALUES
                                                 -> ('1000000000', 'Withdrawal', 500, 'Valid withdrawal test');
Query OK, 1 row affected (0.0198 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > INSERT INTO transactions
                                                 -> (acc_no, transaction_type, amount, description)
                                                 -> VALUES
                                                 -> ('1000000000', 'Withdrawal', 9999999, 'Invalid withdrawal test');
ERROR: 1644 (45000): Insufficient balance! Withdrawal rejected
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT acc_no, balance
                                                 -> FROM accounts
                                                 -> WHERE acc_no = '1000000000';
+------------+----------+
| acc_no     | balance  |
+------------+----------+
| 1000000000 | 28000.00 |
+------------+----------+
1 row in set (0.0007 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > USE embedded_bank_db;
Default schema set to `embedded_bank_db`.
Fetching global names, object names from `embedded_bank_db` for auto-completion... Press ^C to stop.
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > UPDATE accounts
                                                 -> SET status = 'Inactive'
                                                 -> WHERE acc_no = '1000000000';
Query OK, 1 row affected (0.0074 sec)

Rows matched: 1  Changed: 1  Warnings: 0
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > -- Verify
Query OK, 0 rows affected (0.0003 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT * FROM accounts
                                                 -> WHERE acc_no = '1000000000';
+------------+------------+-------------+----------+----------+--------------+----------+
| account_id | acc_no     | customer_id | acc_type | balance  | opening_date | status   |
+------------+------------+-------------+----------+----------+--------------+----------+
|          1 | 1000000000 |           1 | Savings  | 28000.00 | 2025-01-10   | Inactive |
+------------+------------+-------------+----------+----------+--------------+----------+
1 row in set (0.0019 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > UPDATE accounts
                                                 -> SET status = 'Active'
                                                 -> WHERE acc_no = '1000000000';
Query OK, 1 row affected (0.0072 sec)

Rows matched: 1  Changed: 1  Warnings: 0
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > ALTER TABLE customers
                                                 -> ADD remarks VARCHAR(200);
Query OK, 0 rows affected (0.0360 sec)

Records: 0  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > UPDATE customers
                                                 -> SET remarks = 'Premium customer'
                                                 -> WHERE customer_id = 1;
Query OK, 1 row affected (0.0065 sec)

Rows matched: 1  Changed: 1  Warnings: 0
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT customer_id, first_name, remarks
                                                 -> FROM customers;
+-------------+------------+------------------+
| customer_id | first_name | remarks          |
+-------------+------------+------------------+
|           1 | Rahul      | Premium customer |
|           2 | Priya      | NULL             |
|           3 | Amit       | NULL             |
|           4 | Arjun      | NULL             |
|           5 | Neha       | NULL             |
|           6 | Rohan      | NULL             |
|           7 | Ananya     | NULL             |
|           8 | Karan      | NULL             |
|           9 | Isha       | NULL             |
+-------------+------------+------------------+
9 rows in set (0.0006 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > INSERT INTO customers
                                                 -> (first_name, last_name, email, phone, address, branch_id, remarks)
                                                 -> VALUES
                                                 -> ('Test', 'Customer', 'testcustomer@gmail.com',
                                                 ->  '9876500099', 'Kolkata', 1, 'Temporary record');
Query OK, 1 row affected (0.0063 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DELETE FROM customers
                                                 -> WHERE email = 'testcustomer@gmail.com';
Query OK, 1 row affected (0.0078 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM customers
                                                 -> WHERE email = 'testcustomer@gmail.com';
Empty set (0.0012 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM accounts
                                                 -> WHERE balance > (
                                                 ->     SELECT AVG(balance)
                                                 ->     FROM accounts
                                                 -> );
+------------+------------+-------------+----------+----------+--------------+--------+
| account_id | acc_no     | customer_id | acc_type | balance  | opening_date | status |
+------------+------------+-------------+----------+----------+--------------+--------+
|          3 | 1000000002 |           3 | Current  | 60000.00 | 2025-03-20   | Active |
|          4 | 1000000003 |           4 | Savings  | 72000.00 | 2025-05-12   | Active |
|          5 | 1000000004 |           5 | Savings  | 49500.00 | 2025-06-18   | Active |
|          7 | 1000000006 |           7 | Current  | 72000.00 | 2025-08-11   | Active |
+------------+------------+-------------+----------+----------+--------------+--------+
4 rows in set (0.0019 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM customers
                                                 -> WHERE customer_id = (
                                                 ->     SELECT customer_id
                                                 ->     FROM accounts
                                                 ->     ORDER BY balance DESC
                                                 ->     LIMIT 1
                                                 -> );
+-------------+------------+-----------+-----------------+------------+----------+-----------+---------+
| customer_id | first_name | last_name | email           | phone      | address  | branch_id | remarks |
+-------------+------------+-----------+-----------------+------------+----------+-----------+---------+
|           4 | Arjun      | Sen       | arjun@gmail.com | 9876500005 | Siliguri |         5 | NULL    |
+-------------+------------+-----------+-----------------+------------+----------+-----------+---------+
1 row in set (0.0015 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM customers
                                                 -> WHERE customer_id IN (
                                                 ->     SELECT customer_id
                                                 ->     FROM accounts
                                                 ->     WHERE acc_type = 'Savings'
                                                 -> );
+-------------+------------+-----------+-----------------+------------+-----------+-----------+------------------+
| customer_id | first_name | last_name | email           | phone      | address   | branch_id | remarks          |
+-------------+------------+-----------+-----------------+------------+-----------+-----------+------------------+
|           1 | Rahul      | Sharma    | rahul@gmail.com | 9876500001 | Kolkata   |         1 | Premium customer |
|           2 | Priya      | Das       | priya@gmail.com | 9876500002 | Salt Lake |         2 | NULL             |
|           4 | Arjun      | Sen       | arjun@gmail.com | 9876500005 | Siliguri  |         5 | NULL             |
|           5 | Neha       | Ghosh     | neha@gmail.com  | 9876500006 | Kolkata   |         1 | NULL             |
|           6 | Rohan      | Paul      | rohan@gmail.com | 9876500007 | Howrah    |         3 | NULL             |
|           8 | Karan      | Mitra     | karan@gmail.com | 9876500009 | Durgapur  |         4 | NULL             |
|           9 | Isha       | Sen       | isha@gmail.com  | 9876500010 | Siliguri  |         5 | NULL             |
+-------------+------------+-----------+-----------------+------------+-----------+-----------+------------------+
7 rows in set (0.0032 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM accounts
                                                 -> WHERE balance > (
                                                 ->     SELECT balance
                                                 ->     FROM accounts
                                                 ->     WHERE acc_no = '1000000000'
                                                 -> );
+------------+------------+-------------+----------+----------+--------------+--------+
| account_id | acc_no     | customer_id | acc_type | balance  | opening_date | status |
+------------+------------+-------------+----------+----------+--------------+--------+
|          2 | 1000000001 |           2 | Savings  | 39000.00 | 2025-02-15   | Active |
|          3 | 1000000002 |           3 | Current  | 60000.00 | 2025-03-20   | Active |
|          4 | 1000000003 |           4 | Savings  | 72000.00 | 2025-05-12   | Active |
|          5 | 1000000004 |           5 | Savings  | 49500.00 | 2025-06-18   | Active |
|          7 | 1000000006 |           7 | Current  | 72000.00 | 2025-08-11   | Active |
|          9 | 1000000008 |           9 | Savings  | 38000.00 | 2025-10-19   | Active |
+------------+------------+-------------+----------+----------+--------------+--------+
6 rows in set (0.0017 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM customers
                                                 -> WHERE customer_id IN (
                                                 ->     SELECT customer_id
                                                 ->     FROM accounts
                                                 ->     WHERE acc_no IN (
                                                 ->         SELECT DISTINCT acc_no
                                                 ->         FROM transactions
                                                 ->     )
                                                 -> );
+-------------+------------+-----------+------------------+------------+-----------+-----------+------------------+
| customer_id | first_name | last_name | email            | phone      | address   | branch_id | remarks          |
+-------------+------------+-----------+------------------+------------+-----------+-----------+------------------+
|           1 | Rahul      | Sharma    | rahul@gmail.com  | 9876500001 | Kolkata   |         1 | Premium customer |
|           2 | Priya      | Das       | priya@gmail.com  | 9876500002 | Salt Lake |         2 | NULL             |
|           3 | Amit       | Roy       | amit@gmail.com   | 9876500003 | Howrah    |         3 | NULL             |
|           4 | Arjun      | Sen       | arjun@gmail.com  | 9876500005 | Siliguri  |         5 | NULL             |
|           5 | Neha       | Ghosh     | neha@gmail.com   | 9876500006 | Kolkata   |         1 | NULL             |
|           6 | Rohan      | Paul      | rohan@gmail.com  | 9876500007 | Howrah    |         3 | NULL             |
|           7 | Ananya     | Bose      | ananya@gmail.com | 9876500008 | Salt Lake |         2 | NULL             |
|           8 | Karan      | Mitra     | karan@gmail.com  | 9876500009 | Durgapur  |         4 | NULL             |
|           9 | Isha       | Sen       | isha@gmail.com   | 9876500010 | Siliguri  |         5 | NULL             |
+-------------+------------+-----------+------------------+------------+-----------+-----------+------------------+
9 rows in set (0.0008 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM accounts
                                                 -> WHERE acc_no NOT IN (
                                                 ->     SELECT acc_no
                                                 ->     FROM transactions
                                                 -> );
Empty set (0.0008 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE OR REPLACE VIEW customer_account_view AS
                                                 -> SELECT
                                                 ->     customers.customer_id,
                                                 ->     customers.first_name,
                                                 ->     customers.last_name,
                                                 ->     customers.email,
                                                 ->     accounts.acc_no,
                                                 ->     accounts.acc_type,
                                                 ->     accounts.balance,
                                                 ->     accounts.status
                                                 -> FROM customers
                                                 -> INNER JOIN accounts
                                                 -> ON customers.customer_id = accounts.customer_id;
Query OK, 0 rows affected (0.0163 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT * FROM customer_account_view;
+-------------+------------+-----------+------------------+------------+----------+----------+--------+
| customer_id | first_name | last_name | email            | acc_no     | acc_type | balance  | status |
+-------------+------------+-----------+------------------+------------+----------+----------+--------+
|           1 | Rahul      | Sharma    | rahul@gmail.com  | 1000000000 | Savings  | 28000.00 | Active |
|           2 | Priya      | Das       | priya@gmail.com  | 1000000001 | Savings  | 39000.00 | Active |
|           3 | Amit       | Roy       | amit@gmail.com   | 1000000002 | Current  | 60000.00 | Active |
|           4 | Arjun      | Sen       | arjun@gmail.com  | 1000000003 | Savings  | 72000.00 | Active |
|           5 | Neha       | Ghosh     | neha@gmail.com   | 1000000004 | Savings  | 49500.00 | Active |
|           6 | Rohan      | Paul      | rohan@gmail.com  | 1000000005 | Savings  | 13500.00 | Active |
|           7 | Ananya     | Bose      | ananya@gmail.com | 1000000006 | Current  | 72000.00 | Active |
|           8 | Karan      | Mitra     | karan@gmail.com  | 1000000007 | Savings  | 24000.00 | Active |
|           9 | Isha       | Sen       | isha@gmail.com   | 1000000008 | Savings  | 38000.00 | Active |
+-------------+------------+-----------+------------------+------------+----------+----------+--------+
9 rows in set (0.0012 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM customer_account_view
                                                 -> WHERE acc_type = 'Savings';
+-------------+------------+-----------+-----------------+------------+----------+----------+--------+
| customer_id | first_name | last_name | email           | acc_no     | acc_type | balance  | status |
+-------------+------------+-----------+-----------------+------------+----------+----------+--------+
|           1 | Rahul      | Sharma    | rahul@gmail.com | 1000000000 | Savings  | 28000.00 | Active |
|           2 | Priya      | Das       | priya@gmail.com | 1000000001 | Savings  | 39000.00 | Active |
|           4 | Arjun      | Sen       | arjun@gmail.com | 1000000003 | Savings  | 72000.00 | Active |
|           5 | Neha       | Ghosh     | neha@gmail.com  | 1000000004 | Savings  | 49500.00 | Active |
|           6 | Rohan      | Paul      | rohan@gmail.com | 1000000005 | Savings  | 13500.00 | Active |
|           8 | Karan      | Mitra     | karan@gmail.com | 1000000007 | Savings  | 24000.00 | Active |
|           9 | Isha       | Sen       | isha@gmail.com  | 1000000008 | Savings  | 38000.00 | Active |
+-------------+------------+-----------+-----------------+------------+----------+----------+--------+
7 rows in set (0.0013 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE OR REPLACE VIEW transaction_history_view AS
                                                 -> SELECT
                                                 ->     transactions.transaction_id,
                                                 ->     customers.first_name,
                                                 ->     customers.last_name,
                                                 ->     transactions.acc_no,
                                                 ->     transactions.transaction_type,
                                                 ->     transactions.amount,
                                                 ->     transactions.transaction_date,
                                                 ->     transactions.description
                                                 -> FROM transactions
                                                 -> INNER JOIN accounts
                                                 -> ON transactions.acc_no = accounts.acc_no
                                                 -> INNER JOIN customers
                                                 -> ON accounts.customer_id = customers.customer_id;
Query OK, 0 rows affected (0.0232 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT * FROM transaction_history_view;
+----------------+------------+-----------+------------+------------------+----------+---------------------+----------------------------------+
| transaction_id | first_name | last_name | acc_no     | transaction_type | amount   | transaction_date    | description                      |
+----------------+------------+-----------+------------+------------------+----------+---------------------+----------------------------------+
|              1 | Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | 2026-11-19 13:55:45 | Cash deposit                     |
|             10 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  1000.00 | 2026-11-19 13:55:45 | Utility bill payment             |
|             11 | Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | 2026-11-19 13:55:45 | Trigger test deposit             |
|             12 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  2000.00 | 2026-11-19 13:55:45 | Trigger test withdrawal          |
|             13 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  3000.00 | 2026-11-19 13:55:45 | Transfer to account 1000000001   |
|             16 | Rahul      | Sharma    | 1000000000 | Withdrawal       |   500.00 | 2026-11-19 13:55:46 | Valid withdrawal test            |
|             17 | Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | 2026-11-19 14:05:59 | Cash deposit                     |
|             26 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  1000.00 | 2026-11-19 14:05:59 | Utility bill payment             |
|             27 | Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | 2026-11-19 14:06:00 | Trigger test deposit             |
|             28 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  2000.00 | 2026-11-19 14:06:00 | Trigger test withdrawal          |
|             29 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  3000.00 | 2026-11-19 14:06:00 | Transfer to account 1000000001   |
|             32 | Rahul      | Sharma    | 1000000000 | Withdrawal       |   500.00 | 2026-11-19 14:06:01 | Valid withdrawal test            |
|              2 | Priya      | Das       | 1000000001 | Withdrawal       |  2000.00 | 2026-11-19 13:55:45 | ATM withdrawal                   |
|             14 | Priya      | Das       | 1000000001 | Deposit          |  3000.00 | 2026-11-19 13:55:45 | Transfer from account 1000000000 |
|             18 | Priya      | Das       | 1000000001 | Withdrawal       |  2000.00 | 2026-11-19 14:05:59 | ATM withdrawal                   |
|             30 | Priya      | Das       | 1000000001 | Deposit          |  3000.00 | 2026-11-19 14:06:01 | Transfer from account 1000000000 |
|              3 | Amit       | Roy       | 1000000002 | Deposit          | 10000.00 | 2026-11-19 13:55:45 | Salary credited                  |
|             19 | Amit       | Roy       | 1000000002 | Deposit          | 10000.00 | 2026-11-19 14:05:59 | Salary credited                  |
|              4 | Arjun      | Sen       | 1000000003 | Withdrawal       |  3000.00 | 2026-11-19 13:55:45 | Cash withdrawal                  |
|             20 | Arjun      | Sen       | 1000000003 | Withdrawal       |  3000.00 | 2026-11-19 14:05:59 | Cash withdrawal                  |
|              5 | Neha       | Ghosh     | 1000000004 | Deposit          |  7500.00 | 2026-11-19 13:55:45 | Cheque deposit                   |
|             21 | Neha       | Ghosh     | 1000000004 | Deposit          |  7500.00 | 2026-11-19 14:05:59 | Cheque deposit                   |
|              6 | Rohan      | Paul      | 1000000005 | Withdrawal       |  1500.00 | 2026-11-19 13:55:45 | ATM withdrawal                   |
|             22 | Rohan      | Paul      | 1000000005 | Withdrawal       |  1500.00 | 2026-11-19 14:05:59 | ATM withdrawal                   |
|              7 | Ananya     | Bose      | 1000000006 | Deposit          | 12000.00 | 2026-11-19 13:55:45 | Business payment                 |
|             23 | Ananya     | Bose      | 1000000006 | Deposit          | 12000.00 | 2026-11-19 14:05:59 | Business payment                 |
|              8 | Karan      | Mitra     | 1000000007 | Withdrawal       |  4000.00 | 2026-11-19 13:55:45 | Online payment                   |
|             24 | Karan      | Mitra     | 1000000007 | Withdrawal       |  4000.00 | 2026-11-19 14:05:59 | Online payment                   |
|              9 | Isha       | Sen       | 1000000008 | Deposit          |  6000.00 | 2026-11-19 13:55:45 | Cash deposit                     |
|             25 | Isha       | Sen       | 1000000008 | Deposit          |  6000.00 | 2026-11-19 14:05:59 | Cash deposit                     |
+----------------+------------+-----------+------------+------------------+----------+---------------------+----------------------------------+
30 rows in set (0.0015 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE INDEX idx_customer_email
                                                 -> ON customers(email);
Query OK, 0 rows affected (0.0558 sec)

Records: 0  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE INDEX idx_account_balance
                                                 -> ON accounts(balance);
Query OK, 0 rows affected (0.0690 sec)

Records: 0  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE INDEX idx_transaction_date
                                                 -> ON transactions(transaction_date);
Query OK, 0 rows affected (0.0668 sec)

Records: 0  Duplicates: 0  Warnings: 0
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SHOW INDEX FROM customers;
+-----------+------------+--------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table     | Non_unique | Key_name           | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+-----------+------------+--------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| customers |          0 | PRIMARY            |            1 | customer_id | A         |           9 |     NULL | NULL   |      | BTREE      |      |               | YES     | NULL       |
| customers |          0 | email              |            1 | email       | A         |           9 |     NULL | NULL   | YES  | BTREE      |      |               | YES     | NULL       |
| customers |          1 | branch_id          |            1 | branch_id   | A         |           5 |     NULL | NULL   | YES  | BTREE      |      |               | YES     | NULL       |
| customers |          1 | idx_customer_email |            1 | email       | A         |           9 |     NULL | NULL   | YES  | BTREE      |      |               | YES     | NULL       |
+-----------+------------+--------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
4 rows in set (0.0074 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SHOW INDEX FROM accounts;
+----------+------------+---------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name            | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+---------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| accounts |          0 | PRIMARY             |            1 | account_id  | A         |           1 |     NULL | NULL   |      | BTREE      |      |               | YES     | NULL       |
| accounts |          0 | acc_no              |            1 | acc_no      | A         |           1 |     NULL | NULL   |      | BTREE      |      |               | YES     | NULL       |
| accounts |          1 | customer_id         |            1 | customer_id | A         |           1 |     NULL | NULL   |      | BTREE      |      |               | YES     | NULL       |
| accounts |          1 | idx_account_balance |            1 | balance     | A         |           8 |     NULL | NULL   | YES  | BTREE      |      |               | YES     | NULL       |
+----------+------------+---------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
4 rows in set (0.0066 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SHOW INDEX FROM transactions;
+--------------+------------+----------------------+--------------+------------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table        | Non_unique | Key_name             | Seq_in_index | Column_name      | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+--------------+------------+----------------------+--------------+------------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| transactions |          0 | PRIMARY              |            1 | transaction_id   | A         |           1 |     NULL | NULL   |      | BTREE      |         |               | YES     | NULL       |
| transactions |          1 | acc_no               |            1 | acc_no           | A         |           1 |     NULL | NULL   |      | BTREE      |         |               | YES     | NULL       |
| transactions |          1 | idx_transaction_date |            1 | transaction_date | A         |           5 |     NULL | NULL   | YES  | BTREE      |         |               | YES     | NULL       |
+--------------+------------+----------------------+--------------+------------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.0050 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DROP PROCEDURE IF EXISTS get_customer_accounts;
Query OK, 0 rows affected, 1 warning (0.0077 sec)
Note (code 1305): PROCEDURE embedded_bank_db.get_customer_accounts does not exist
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DELIMITER //
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE PROCEDURE get_customer_accounts(
                                                 ->     IN p_customer_id INT
                                                 -> )
                                                 -> BEGIN
                                                 ->
                                                 ->     SELECT
                                                 ->         customer_id,
                                                 ->         acc_no,
                                                 ->         acc_type,
                                                 ->         balance,
                                                 ->         status
                                                 ->     FROM accounts
                                                 ->     WHERE customer_id = p_customer_id;
                                                 ->
                                                 -> END //
Query OK, 0 rows affected (0.0123 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DELIMITER ;
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CALL get_customer_accounts(1);
+-------------+------------+----------+----------+--------+
| customer_id | acc_no     | acc_type | balance  | status |
+-------------+------------+----------+----------+--------+
|           1 | 1000000000 | Savings  | 28000.00 | Active |
+-------------+------------+----------+----------+--------+
1 row in set (0.0021 sec)

Query OK, 0 rows affected (0.0021 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DROP FUNCTION IF EXISTS get_customer_balance;
Query OK, 0 rows affected, 1 warning (0.0034 sec)
Note (code 1305): FUNCTION embedded_bank_db.get_customer_balance does not exist
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DELIMITER //
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE FUNCTION get_customer_balance(
                                                 ->     p_customer_id INT
                                                 -> )
                                                 -> RETURNS DECIMAL(12,2)
                                                 -> READS SQL DATA
                                                 -> BEGIN
                                                 ->
                                                 ->     DECLARE total_balance DECIMAL(12,2);
                                                 ->
                                                 ->     SELECT COALESCE(SUM(balance), 0)
                                                 ->     INTO total_balance
                                                 ->     FROM accounts
                                                 ->     WHERE customer_id = p_customer_id;
                                                 ->
                                                 ->     RETURN total_balance;
                                                 ->
                                                 -> END //
Query OK, 0 rows affected (0.0355 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DELIMITER ;
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT
                                                 ->     first_name,
                                                 ->     last_name,
                                                 ->     get_customer_balance(customer_id) AS total_balance
                                                 -> FROM customers;
+------------+-----------+---------------+
| first_name | last_name | total_balance |
+------------+-----------+---------------+
| Rahul      | Sharma    |      28000.00 |
| Priya      | Das       |      39000.00 |
| Amit       | Roy       |      60000.00 |
| Arjun      | Sen       |      72000.00 |
| Neha       | Ghosh     |      49500.00 |
| Rohan      | Paul      |      13500.00 |
| Ananya     | Bose      |      72000.00 |
| Karan      | Mitra     |      24000.00 |
| Isha       | Sen       |      38000.00 |
+------------+-----------+---------------+
9 rows in set (0.0019 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DROP PROCEDURE IF EXISTS transfer_funds;
Query OK, 0 rows affected, 1 warning (0.0042 sec)
Note (code 1305): PROCEDURE embedded_bank_db.transfer_funds does not exist
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DELIMITER //
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CREATE PROCEDURE transfer_funds(
                                                 ->     IN p_sender VARCHAR(20),
                                                 ->     IN p_receiver VARCHAR(20),
                                                 ->     IN p_amount DECIMAL(12,2)
                                                 -> )
                                                 -> BEGIN
                                                 ->
                                                 ->     DECLARE v_balance DECIMAL(12,2);
                                                 ->     DECLARE v_count INT;
                                                 ->     DECLARE EXIT HANDLER FOR SQLEXCEPTION
                                                 ->     BEGIN
                                                 ->         ROLLBACK;
                                                 ->         RESIGNAL;
                                                 ->     END;
                                                 ->
                                                 ->     START TRANSACTION;
                                                 ->     IF p_amount IS NULL OR p_amount <= 0 THEN
                                                 ->         SIGNAL SQLSTATE '45000'
                                                 ->         SET MESSAGE_TEXT = 'Invalid transfer amount';

                                                 ->     END IF;
                                                 ->
                                                 ->     -- Prevent transfer to the same account
                                                 ->     IF p_sender = p_receiver THEN
                                                 ->         SIGNAL SQLSTATE '45000'
                                                 ->         SET MESSAGE_TEXT = 'Sender and receiver cannot be the same';
                                                 ->     END IF;
                                                 ->     SELECT COUNT(*)
                                                 ->     INTO v_count
                                                 ->     FROM accounts
                                                 ->     WHERE acc_no = p_sender;
                                                 ->
                                                 ->     IF v_count = 0 THEN
                                                 ->         SIGNAL SQLSTATE '45000'
                                                 ->         SET MESSAGE_TEXT = 'Sender account does not exist';
                                                 ->     END IF;
                                                 ->     SELECT COUNT(*)
                                                 ->     INTO v_count
                                                 ->     FROM accounts
                                                 ->     WHERE acc_no = p_receiver;
                                                 ->
                                                 ->     IF v_count = 0 THEN
                                                 ->         SIGNAL SQLSTATE '45000'
                                                 ->         SET MESSAGE_TEXT = 'Receiver account does not exist';
                                                 ->     END IF;
                                                 ->     SELECT balance
                                                 ->     INTO v_balance
                                                 ->     FROM accounts
                                                 ->     WHERE acc_no = p_sender
                                                 ->     FOR UPDATE;
                                                 ->     IF v_balance < p_amount THEN
                                                 ->         SIGNAL SQLSTATE '45000'
                                                 ->         SET MESSAGE_TEXT = 'Insufficient balance for transfer';
                                                 ->     END IF;
                                                 ->     INSERT INTO transactions
                                                 ->     (acc_no, transaction_type, amount, description)
                                                 ->     VALUES
                                                 ->     (p_sender, 'Withdrawal', p_amount,
                                                 ->      CONCAT('Transfer to account ', p_receiver));
                                                 ->
                                                 ->     INSERT INTO transactions
                                                 ->     (acc_no, transaction_type, amount, description)
                                                 ->     VALUES
                                                 ->     (p_receiver, 'Deposit', p_amount,
                                                 ->      CONCAT('Transfer from account ', p_sender));
                                                 ->
                                                 ->     COMMIT;
                                                 ->
                                                 -> END //
Query OK, 0 rows affected (0.0242 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > DELIMITER ;
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > CALL transfer_funds(
                                                 ->     '1000000000',
                                                 ->     '1000000001',
                                                 ->     500
                                                 -> );
Query OK, 0 rows affected (0.0091 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT acc_no, balance
                                                 -> FROM accounts
                                                 -> WHERE acc_no IN ('1000000000', '1000000001');
+------------+----------+
| acc_no     | balance  |
+------------+----------+
| 1000000000 | 27500.00 |
| 1000000001 | 39500.00 |
+------------+----------+
2 rows in set (0.0010 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT COUNT(*) AS total_customers
                                                 -> FROM customers;
+-----------------+
| total_customers |
+-----------------+
|               9 |
+-----------------+
1 row in set (0.0007 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT COUNT(*) AS total_accounts
                                                 -> FROM accounts;
+----------------+
| total_accounts |
+----------------+
|              9 |
+----------------+
1 row in set (0.0006 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT SUM(balance) AS total_bank_balance
                                                 -> FROM accounts;
+--------------------+
| total_bank_balance |
+--------------------+
|          396000.00 |
+--------------------+
1 row in set (0.0010 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT SUM(amount) AS total_deposits
                                                 -> FROM transactions
                                                 -> WHERE transaction_type = 'Deposit';
+----------------+
| total_deposits |
+----------------+
|       97500.00 |
+----------------+
1 row in set (0.0010 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT SUM(amount) AS total_withdrawals
                                                 -> FROM transactions
                                                 -> WHERE transaction_type = 'Withdrawal';
+-------------------+
| total_withdrawals |
+-------------------+
|          34500.00 |
+-------------------+
1 row in set (0.0009 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT
                                                 ->     acc_no,
                                                 ->     COUNT(*) AS total_transactions
                                                 -> FROM transactions
                                                 -> GROUP BY acc_no;
+------------+--------------------+
| acc_no     | total_transactions |
+------------+--------------------+
| 1000000000 |                 13 |
| 1000000001 |                  5 |
| 1000000002 |                  2 |
| 1000000003 |                  2 |
| 1000000004 |                  2 |
| 1000000005 |                  2 |
| 1000000006 |                  2 |
| 1000000007 |                  2 |
| 1000000008 |                  2 |
+------------+--------------------+
9 rows in set (0.0006 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT
                                                 ->     acc_no,
                                                 ->     SUM(amount) AS total_deposits
                                                 -> FROM transactions
                                                 -> WHERE transaction_type = 'Deposit'
                                                 -> GROUP BY acc_no;
+------------+----------------+
| acc_no     | total_deposits |
+------------+----------------+
| 1000000000 |       20000.00 |
| 1000000001 |        6500.00 |
| 1000000002 |       20000.00 |
| 1000000004 |       15000.00 |
| 1000000006 |       24000.00 |
| 1000000008 |       12000.00 |
+------------+----------------+
6 rows in set (0.0010 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT
                                                 ->     acc_no,
                                                 ->     SUM(amount) AS total_withdrawals
                                                 -> FROM transactions
                                                 -> WHERE transaction_type = 'Withdrawal'
                                                 -> GROUP BY acc_no;
+------------+-------------------+
| acc_no     | total_withdrawals |
+------------+-------------------+
| 1000000000 |          13500.00 |
| 1000000001 |           4000.00 |
| 1000000003 |           6000.00 |
| 1000000005 |           3000.00 |
| 1000000007 |           8000.00 |
+------------+-------------------+
5 rows in set (0.0008 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM customer_account_view
                                                 -> WHERE balance > 40000;
+-------------+------------+-----------+------------------+------------+----------+----------+--------+
| customer_id | first_name | last_name | email            | acc_no     | acc_type | balance  | status |
+-------------+------------+-----------+------------------+------------+----------+----------+--------+
|           5 | Neha       | Ghosh     | neha@gmail.com   | 1000000004 | Savings  | 49500.00 | Active |
|           3 | Amit       | Roy       | amit@gmail.com   | 1000000002 | Current  | 60000.00 | Active |
|           4 | Arjun      | Sen       | arjun@gmail.com  | 1000000003 | Savings  | 72000.00 | Active |
|           7 | Ananya     | Bose      | ananya@gmail.com | 1000000006 | Current  | 72000.00 | Active |
+-------------+------------+-----------+------------------+------------+----------+----------+--------+
4 rows in set (0.0013 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM transaction_history_view
                                                 -> ORDER BY transaction_date DESC;
+----------------+------------+-----------+------------+------------------+----------+---------------------+----------------------------------+
| transaction_id | first_name | last_name | acc_no     | transaction_type | amount   | transaction_date    | description                      |
+----------------+------------+-----------+------------+------------------+----------+---------------------+----------------------------------+
|             33 | Rahul      | Sharma    | 1000000000 | Withdrawal       |   500.00 | 2026-11-19 14:06:04 | Transfer to account 1000000001   |
|             34 | Priya      | Das       | 1000000001 | Deposit          |   500.00 | 2026-11-19 14:06:04 | Transfer from account 1000000000 |
|             32 | Rahul      | Sharma    | 1000000000 | Withdrawal       |   500.00 | 2026-11-19 14:06:01 | Valid withdrawal test            |
|             30 | Priya      | Das       | 1000000001 | Deposit          |  3000.00 | 2026-11-19 14:06:01 | Transfer from account 1000000000 |
|             27 | Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | 2026-11-19 14:06:00 | Trigger test deposit             |
|             28 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  2000.00 | 2026-11-19 14:06:00 | Trigger test withdrawal          |
|             29 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  3000.00 | 2026-11-19 14:06:00 | Transfer to account 1000000001   |
|             17 | Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | 2026-11-19 14:05:59 | Cash deposit                     |
|             26 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  1000.00 | 2026-11-19 14:05:59 | Utility bill payment             |
|             18 | Priya      | Das       | 1000000001 | Withdrawal       |  2000.00 | 2026-11-19 14:05:59 | ATM withdrawal                   |
|             19 | Amit       | Roy       | 1000000002 | Deposit          | 10000.00 | 2026-11-19 14:05:59 | Salary credited                  |
|             20 | Arjun      | Sen       | 1000000003 | Withdrawal       |  3000.00 | 2026-11-19 14:05:59 | Cash withdrawal                  |
|             21 | Neha       | Ghosh     | 1000000004 | Deposit          |  7500.00 | 2026-11-19 14:05:59 | Cheque deposit                   |
|             22 | Rohan      | Paul      | 1000000005 | Withdrawal       |  1500.00 | 2026-11-19 14:05:59 | ATM withdrawal                   |
|             23 | Ananya     | Bose      | 1000000006 | Deposit          | 12000.00 | 2026-11-19 14:05:59 | Business payment                 |
|             24 | Karan      | Mitra     | 1000000007 | Withdrawal       |  4000.00 | 2026-11-19 14:05:59 | Online payment                   |
|             25 | Isha       | Sen       | 1000000008 | Deposit          |  6000.00 | 2026-11-19 14:05:59 | Cash deposit                     |
|             16 | Rahul      | Sharma    | 1000000000 | Withdrawal       |   500.00 | 2026-11-19 13:55:46 | Valid withdrawal test            |
|              1 | Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | 2026-11-19 13:55:45 | Cash deposit                     |
|             10 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  1000.00 | 2026-11-19 13:55:45 | Utility bill payment             |
|             11 | Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | 2026-11-19 13:55:45 | Trigger test deposit             |
|             12 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  2000.00 | 2026-11-19 13:55:45 | Trigger test withdrawal          |
|             13 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  3000.00 | 2026-11-19 13:55:45 | Transfer to account 1000000001   |
|              2 | Priya      | Das       | 1000000001 | Withdrawal       |  2000.00 | 2026-11-19 13:55:45 | ATM withdrawal                   |
|             14 | Priya      | Das       | 1000000001 | Deposit          |  3000.00 | 2026-11-19 13:55:45 | Transfer from account 1000000000 |
|              3 | Amit       | Roy       | 1000000002 | Deposit          | 10000.00 | 2026-11-19 13:55:45 | Salary credited                  |
|              4 | Arjun      | Sen       | 1000000003 | Withdrawal       |  3000.00 | 2026-11-19 13:55:45 | Cash withdrawal                  |
|              5 | Neha       | Ghosh     | 1000000004 | Deposit          |  7500.00 | 2026-11-19 13:55:45 | Cheque deposit                   |
|              6 | Rohan      | Paul      | 1000000005 | Withdrawal       |  1500.00 | 2026-11-19 13:55:45 | ATM withdrawal                   |
|              7 | Ananya     | Bose      | 1000000006 | Deposit          | 12000.00 | 2026-11-19 13:55:45 | Business payment                 |
|              8 | Karan      | Mitra     | 1000000007 | Withdrawal       |  4000.00 | 2026-11-19 13:55:45 | Online payment                   |
|              9 | Isha       | Sen       | 1000000008 | Deposit          |  6000.00 | 2026-11-19 13:55:45 | Cash deposit                     |
+----------------+------------+-----------+------------+------------------+----------+---------------------+----------------------------------+
32 rows in set (0.0010 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT
                                                 ->     customers.first_name,
                                                 ->     customers.last_name,
                                                 ->     accounts.acc_no,
                                                 ->     accounts.balance
                                                 -> FROM customers
                                                 -> INNER JOIN accounts
                                                 -> ON customers.customer_id = accounts.customer_id
                                                 -> ORDER BY accounts.balance DESC
                                                 -> LIMIT 1;
+------------+-----------+------------+----------+
| first_name | last_name | acc_no     | balance  |
+------------+-----------+------------+----------+
| Ananya     | Bose      | 1000000006 | 72000.00 |
+------------+-----------+------------+----------+
1 row in set (0.0009 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT
                                                 ->     customers.first_name,
                                                 ->     customers.last_name,
                                                 ->     accounts.acc_no,
                                                 ->     accounts.balance
                                                 -> FROM customers
                                                 -> INNER JOIN accounts
                                                 -> ON customers.customer_id = accounts.customer_id
                                                 -> ORDER BY accounts.balance ASC
                                                 -> LIMIT 1;
+------------+-----------+------------+----------+
| first_name | last_name | acc_no     | balance  |
+------------+-----------+------------+----------+
| Rohan      | Paul      | 1000000005 | 13500.00 |
+------------+-----------+------------+----------+
1 row in set (0.0008 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM accounts
                                                 -> WHERE status = 'Inactive';
Empty set (0.0008 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT *
                                                 -> FROM transactions
                                                 -> ORDER BY transaction_date DESC
                                                 -> LIMIT 5;
+----------------+------------+------------------+---------+---------------------+----------------------------------+
| transaction_id | acc_no     | transaction_type | amount  | transaction_date    | description                      |
+----------------+------------+------------------+---------+---------------------+----------------------------------+
|             34 | 1000000001 | Deposit          |  500.00 | 2026-11-19 14:06:04 | Transfer from account 1000000000 |
|             33 | 1000000000 | Withdrawal       |  500.00 | 2026-11-19 14:06:04 | Transfer to account 1000000001   |
|             30 | 1000000001 | Deposit          | 3000.00 | 2026-11-19 14:06:01 | Transfer from account 1000000000 |
|             32 | 1000000000 | Withdrawal       |  500.00 | 2026-11-19 14:06:01 | Valid withdrawal test            |
|             28 | 1000000000 | Withdrawal       | 2000.00 | 2026-11-19 14:06:00 | Trigger test withdrawal          |
+----------------+------------+------------------+---------+---------------------+----------------------------------+
5 rows in set (0.0009 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SHOW TABLES;
+----------------------------+
| Tables_in_embedded_bank_db |
+----------------------------+
| accounts                   |
| branches                   |
| customer_account_view      |
| customers                  |
| transaction_history_view   |
| transactions               |
+----------------------------+
6 rows in set (0.0013 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SHOW TRIGGERS;
+--------------------------+--------+--------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
| Trigger                  | Event  | Table        | Statement                                                                                                               | Timing | Created| sql_mode                                                                                                              | Definer        | character_set_client | collation_connection | Database Collation |
+--------------------------+--------+--------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
| check_transaction_amount | INSERT | transactions | BEGIN
    IF NEW.amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Transaction amount must be greater than zero';
    END IF;
END                                          | BEFORE | 2026-11-19 13:55:45.82 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| check_withdrawal_balance | INSERT | transactions | BEGIN

    IF NEW.transaction_type = 'Withdrawal' THEN

        IF NEW.amount > (
            SELECT balance
            FROM accounts
            WHERE acc_no = NEW.acc_no
        ) THEN

            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT =
            'Insufficient balance! Withdrawal rejected';

        END IF;

    END IF;

END | BEFORE | 2026-11-19 13:55:46.10 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| update_account_balance   | INSERT | transactions | BEGIN

    IF NEW.transaction_type = 'Deposit' THEN

        UPDATE accounts
        SET balance = balance + NEW.amount
        WHERE acc_no = NEW.acc_no;

    ELSEIF NEW.transaction_type = 'Withdrawal' THEN

        UPDATE accounts
        SET balance = balance - NEW.amount
        WHERE acc_no = NEW.acc_no;

    END IF;

END                    | AFTER  | 2026-11-19 13:55:45.83 | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION | root@localhost | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
+--------------------------+--------+--------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------+------------------------+-----------------------------------------------------------------------------------------------------------------------+----------------+----------------------+----------------------+--------------------+
3 rows in set (0.0021 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SHOW PROCEDURE STATUS
                                                 -> WHERE Db = 'embedded_bank_db';
+------------------+-----------------------+-----------+----------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
| Db               | Name                  | Type      | Definer        | Modified            | Created             | Security_type | Comment | character_set_client | collation_connection | Database Collation |
+------------------+-----------------------+-----------+----------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
| embedded_bank_db | get_customer_accounts | PROCEDURE | root@localhost | 2026-11-19 14:06:03 | 2026-11-19 14:06:03 | DEFINER       |         | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
| embedded_bank_db | transfer_funds        | PROCEDURE | root@localhost | 2026-11-19 14:06:04 | 2026-11-19 14:06:04 | DEFINER       |         | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
+------------------+-----------------------+-----------+----------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
2 rows in set (0.0013 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SHOW FUNCTION STATUS
                                                 -> WHERE Db = 'embedded_bank_db';
+------------------+----------------------+----------+----------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
| Db               | Name                 | Type     | Definer        | Modified            | Created             | Security_type | Comment | character_set_client | collation_connection | Database Collation |
+------------------+----------------------+----------+----------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
| embedded_bank_db | get_customer_balance | FUNCTION | root@localhost | 2026-11-19 14:06:04 | 2026-11-19 14:06:04 | DEFINER       |         | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
+------------------+----------------------+----------+----------------+---------------------+---------------------+---------------+---------+----------------------+----------------------+--------------------+
1 row in set (0.0013 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT * FROM customer_account_view;
+-------------+------------+-----------+------------------+------------+----------+----------+--------+
| customer_id | first_name | last_name | email            | acc_no     | acc_type | balance  | status |
+-------------+------------+-----------+------------------+------------+----------+----------+--------+
|           1 | Rahul      | Sharma    | rahul@gmail.com  | 1000000000 | Savings  | 27500.00 | Active |
|           2 | Priya      | Das       | priya@gmail.com  | 1000000001 | Savings  | 39500.00 | Active |
|           3 | Amit       | Roy       | amit@gmail.com   | 1000000002 | Current  | 60000.00 | Active |
|           4 | Arjun      | Sen       | arjun@gmail.com  | 1000000003 | Savings  | 72000.00 | Active |
|           5 | Neha       | Ghosh     | neha@gmail.com   | 1000000004 | Savings  | 49500.00 | Active |
|           6 | Rohan      | Paul      | rohan@gmail.com  | 1000000005 | Savings  | 13500.00 | Active |
|           7 | Ananya     | Bose      | ananya@gmail.com | 1000000006 | Current  | 72000.00 | Active |
|           8 | Karan      | Mitra     | karan@gmail.com  | 1000000007 | Savings  | 24000.00 | Active |
|           9 | Isha       | Sen       | isha@gmail.com   | 1000000008 | Savings  | 38000.00 | Active |
+-------------+------------+-----------+------------------+------------+----------+----------+--------+
9 rows in set (0.0009 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL > SELECT * FROM transaction_history_view;
+----------------+------------+-----------+------------+------------------+----------+---------------------+----------------------------------+
| transaction_id | first_name | last_name | acc_no     | transaction_type | amount   | transaction_date    | description                      |
+----------------+------------+-----------+------------+------------------+----------+---------------------+----------------------------------+
|              1 | Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | 2026-11-19 13:55:45 | Cash deposit                     |
|             10 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  1000.00 | 2026-11-19 13:55:45 | Utility bill payment             |
|             11 | Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | 2026-11-19 13:55:45 | Trigger test deposit             |
|             12 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  2000.00 | 2026-11-19 13:55:45 | Trigger test withdrawal          |
|             13 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  3000.00 | 2026-11-19 13:55:45 | Transfer to account 1000000001   |
|             16 | Rahul      | Sharma    | 1000000000 | Withdrawal       |   500.00 | 2026-11-19 13:55:46 | Valid withdrawal test            |
|             17 | Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | 2026-11-19 14:05:59 | Cash deposit                     |
|             26 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  1000.00 | 2026-11-19 14:05:59 | Utility bill payment             |
|             27 | Rahul      | Sharma    | 1000000000 | Deposit          |  5000.00 | 2026-11-19 14:06:00 | Trigger test deposit             |
|             28 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  2000.00 | 2026-11-19 14:06:00 | Trigger test withdrawal          |
|             29 | Rahul      | Sharma    | 1000000000 | Withdrawal       |  3000.00 | 2026-11-19 14:06:00 | Transfer to account 1000000001   |
|             32 | Rahul      | Sharma    | 1000000000 | Withdrawal       |   500.00 | 2026-11-19 14:06:01 | Valid withdrawal test            |
|             33 | Rahul      | Sharma    | 1000000000 | Withdrawal       |   500.00 | 2026-11-19 14:06:04 | Transfer to account 1000000001   |
|              2 | Priya      | Das       | 1000000001 | Withdrawal       |  2000.00 | 2026-11-19 13:55:45 | ATM withdrawal                   |
|             14 | Priya      | Das       | 1000000001 | Deposit          |  3000.00 | 2026-11-19 13:55:45 | Transfer from account 1000000000 |
|             18 | Priya      | Das       | 1000000001 | Withdrawal       |  2000.00 | 2026-11-19 14:05:59 | ATM withdrawal                   |
|             30 | Priya      | Das       | 1000000001 | Deposit          |  3000.00 | 2026-11-19 14:06:01 | Transfer from account 1000000000 |
|             34 | Priya      | Das       | 1000000001 | Deposit          |   500.00 | 2026-11-19 14:06:04 | Transfer from account 1000000000 |
|              3 | Amit       | Roy       | 1000000002 | Deposit          | 10000.00 | 2026-11-19 13:55:45 | Salary credited                  |
|             19 | Amit       | Roy       | 1000000002 | Deposit          | 10000.00 | 2026-11-19 14:05:59 | Salary credited                  |
|              4 | Arjun      | Sen       | 1000000003 | Withdrawal       |  3000.00 | 2026-11-19 13:55:45 | Cash withdrawal                  |
|             20 | Arjun      | Sen       | 1000000003 | Withdrawal       |  3000.00 | 2026-11-19 14:05:59 | Cash withdrawal                  |
|              5 | Neha       | Ghosh     | 1000000004 | Deposit          |  7500.00 | 2026-11-19 13:55:45 | Cheque deposit                   |
|             21 | Neha       | Ghosh     | 1000000004 | Deposit          |  7500.00 | 2026-11-19 14:05:59 | Cheque deposit                   |
|              6 | Rohan      | Paul      | 1000000005 | Withdrawal       |  1500.00 | 2026-11-19 13:55:45 | ATM withdrawal                   |
|             22 | Rohan      | Paul      | 1000000005 | Withdrawal       |  1500.00 | 2026-11-19 14:05:59 | ATM withdrawal                   |
|              7 | Ananya     | Bose      | 1000000006 | Deposit          | 12000.00 | 2026-11-19 13:55:45 | Business payment                 |
|             23 | Ananya     | Bose      | 1000000006 | Deposit          | 12000.00 | 2026-11-19 14:05:59 | Business payment                 |
|              8 | Karan      | Mitra     | 1000000007 | Withdrawal       |  4000.00 | 2026-11-19 13:55:45 | Online payment                   |
|             24 | Karan      | Mitra     | 1000000007 | Withdrawal       |  4000.00 | 2026-11-19 14:05:59 | Online payment                   |
|              9 | Isha       | Sen       | 1000000008 | Deposit          |  6000.00 | 2026-11-19 13:55:45 | Cash deposit                     |
|             25 | Isha       | Sen       | 1000000008 | Deposit          |  6000.00 | 2026-11-19 14:05:59 | Cash deposit                     |
+----------------+------------+-----------+------------+------------------+----------+---------------------+----------------------------------+
32 rows in set (0.0014 sec)
 MySQL  localhost:3306 ssl  embedded_bank_db  SQL >
