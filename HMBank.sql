-------------------- TASK 1 -------------------

create database HMBank;
use HMBank;

create table Customers(
	CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName varchar(20) NOT NULL,
    LastName varchar(20) NOT NULL,
    DOB DATE,
    Email varchar(30) UNIQUE NOT NULL,
    PhoneNumber bigint,
    Address TEXT,
    City varchar(20),
    CreatedAt DATE
);

create table Accounts(
	AccountID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    AccountType ENUM('Savings','Current','Zero_balance') NOT NULL,
    Balance DECIMAL(15,2) DEFAULT(0.00),
    FOREIGN KEY(CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

create table Transactions(
	TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    AccountID INT NOT NULL,
    TransactionType ENUM('Deposit','Withdrawal','Transfer') NOT NULL,
    Amount DECIMAL(15,2) NOT NULL,
    TransactionDate DATE,
    FOREIGN KEY(AccountID) REFERENCES Accounts(AccountID) ON DELETE CASCADE
);
drop table Transactions;

------------------------- TASK 2 ------------------------

INSERT INTO Customers (FirstName, LastName, DOB, Email, PhoneNumber, Address, City, CreatedAt) VALUES 
('John', 'Doe', '1990-05-15', 'john.doe@email.com', 9876543210, '123 Main St', 'New York', '2024-03-20'),
('Jane', 'Smith', '1985-08-20', 'jane.smith@email.com', 8765432109, '456 Elm St', 'Los Angeles', '2024-03-21'),
('Alice', 'Brown', '1992-12-10', 'alice.brown@email.com', 7654321098, '789 Oak St', 'Chicago', '2024-03-22'),
('Bob', 'Williams', '1988-03-25', 'bob.williams@email.com', 6543210987, '321 Pine St', 'Miami', '2024-03-20'),
('Charlie', 'Miller', '1995-07-14', 'charlie.miller@email.com', 5432109876, '987 Cedar St', 'Seattle', '2024-03-23'),
('David', 'Johnson', '1991-09-30', 'david.johnson@email.com', 4321098765, '654 Spruce St', 'New York', '2024-03-24'),
('Eve', 'Davis', '1983-06-05', 'eve.davis@email.com', 3210987654, '369 Birch St', 'Los Angeles', '2024-03-25'),
('Frank', 'Moore', '1987-11-22', 'frank.moore@email.com', 2109876543, '753 Maple St', 'San Francisco', '2024-03-21'),
('Grace', 'Lee', '1994-02-18', 'grace.lee@email.com', 1098765432, '852 Redwood St', 'Houston', '2024-03-26'),
('Henry', 'Wilson', '1980-04-07', 'henry.wilson@email.com', 1987654321, '951 Palm St', 'Seattle', '2024-03-27');

INSERT INTO Accounts (CustomerID, AccountType, Balance) VALUES 
(1, 'Savings', 1500.50),
(1, 'Current', 2500.75),
(1, 'Zero_balance', 0.00),
(2, 'Savings', 3200.00),
(2, 'Current', 1800.40),
(2, 'Zero_balance', 0.00),
(3, 'Savings', 5000.25),
(3, 'Current', 7200.00),
(3, 'Zero_balance', 0.00),
(4, 'Savings', 4100.90),
(5, 'Current', 2300.00),
(6, 'Zero_balance', 0.00),
(7, 'Savings', 3500.30),
(8, 'Current', 2800.50),
(9, 'Zero_balance', 0.00),
(10, 'Savings', 6000.75);

INSERT INTO Transactions (AccountID, TransactionType, Amount, TransactionDate) VALUES 
(1, 'Deposit', 2000.00, '2024-03-25'),
(1, 'Withdrawal', 500.00, '2024-03-25'),
(1, 'Transfer', 300.00, '2024-03-25'),
(4, 'Deposit', 1500.00, '2024-03-25'),
(4, 'Withdrawal', 700.00, '2024-03-25'),
(4, 'Transfer', 400.00, '2024-03-25'),
(7, 'Deposit', 2500.00, '2024-03-25'),
(7, 'Withdrawal', 900.00, '2024-03-25'),
(7, 'Transfer', 500.00, '2024-03-25'),
(2, 'Deposit', 3000.00, '2024-03-26'),
(3, 'Withdrawal', 1200.00, '2024-03-27'),
(5, 'Transfer', 800.00, '2024-03-28'),
(6, 'Deposit', 4500.00, '2024-03-29'),
(8, 'Withdrawal', 2000.00, '2024-03-30'),
(9, 'Transfer', 600.00, '2024-03-31'),
(10, 'Deposit', 5000.00, '2024-04-01');


-- 1. Write a SQL query to retrieve the name, account type and email of all customers.
SELECT c.FirstName, c.LastName, c.Email, a.AccountType
FROM Customers c
JOIN Accounts a USING(CustomerID);

-- 2. Write a SQL query to list all transaction corresponding customer.
SELECT c.FirstName, c.LastName, t.TransactionID, t.TransactionType, t.Amount, t.TransactionDate
FROM Transactions t
JOIN Accounts a ON t.AccountID = a.AccountID
JOIN Customers c ON a.CustomerID = c.CustomerID;

-- 3. Write a SQL query to increase the balance of a specific account by a certain amount.
UPDATE Accounts
SET Balance = Balance + 1000.00;  

-- 4. Write a SQL query to Combine first and last names of customers as a full_name.
select concat(FirstName," ",LastName) AS FullName
FROM Customers;

-- 5. Write a SQL query to remove accounts with a balance of zero where the account type is savings.
DELETE FROM Accounts 
WHERE BALANCE = 0.00 AND AccountType = "Savings";

-- 6. Write a SQL query to Find customers living in a specific city.
select * From Customers 
where City = "New York";

-- 7. Write a SQL query to Get the account balance for a specific account.
select balance 
from accounts
where AccountID = 2;

-- 8. Write a SQL query to List all current accounts with a balance greater than $1,000.
select AccountID,Balance
from accounts
where AccountType = "Current" AND Balance > 1000;

-- 9. Write a SQL query to Retrieve all transactions for a specific account.
select * from Transactions
where AccountID = 5;

-- 10. Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.
select AccountID,CustomerID,Balance,(Balance * 0.05) AS IntrestAccured
from Accounts
Where AccountType = "Savings";

-- 11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.
select AccountID,CustomerID 
from Accounts
where Balance < -1000;

-- 12. Write a SQL query to Find customers not living in a specific city.
select * from Customers
where Address != "New York" ;

--------------------------- TASK 3 ------------------------
-- 1. Write a SQL query to Find the average account balance for all customers.
select avg(Balance) as AverageBalance 
from Accounts;

-- 2. Write a SQL query to Retrieve the top 10 highest account balances.
select AccountID,Balance
from Accounts
order by (Balance) desc limit 10;

-- 3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
update Transactions set TransactionDate = '2024-03-15' where AccountID = 1;
update Transactions set TransactionDate = '2024-03-15' where AccountID = 6;
select sum(Amount) as TotalDeposits
from Transactions
where TransactionType = "Deposits" and TransactionDate = 2024-03-15;


-- 4. Write a SQL query to Find the Oldest and Newest Customers.
select CustomerID,FirstName,LastName,CreatedAt
from Customers
order by CreatedAt desc;

-- 5. Write a SQL query to Retrieve transaction details along with the account type.
select a.AccountType,t.TransactionID,t.TransactionType,t.AccountID,t.TransactionDate
from Transactions t
join Accounts a using (AccountID);

-- 6. Write a SQL query to Get a list of customers along with their account details.
select c.FirstName,c.LastName,c.CustomerID,a.AccountID
from Customers c
join Accounts a using(CustomerID);

-- 7. Write a SQL query to Retrieve transaction details along with customer information for a specific account.
select t.TransactionID,a.AccountID,t.TransactionType,t.Amount,t.TransactionDate,
c.FirstName,c.LastName,c.DOB,c.Email,c.PhoneNumber,c.Address
from transactions t
join accounts a using(AccountID)
join customers c using(CustomerID);

-- 8. Write a SQL query to Identify customers who have more than one account.
select a.CustomerID,count(a.AccountID) as AccountCount,c.FirstName,c.LastName
from Accounts a
join Customers c using(CustomerID)
Group by CustomerID
having AccountCount > 1;

-- 9. Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.
select AccountID, 
    sum(case when TransactionType = 'Deposit' then Amount else 0 end) - 
    sum(case when TransactionType = 'Withdrawal' then Amount else 0 end) as AmountDifference
from Transactions
group by AccountID;
 
-- 10. Write a SQL query to Calculate the average daily balance for each account over a specified period.
select AccountID, AVG(DailyBalance) AS AvgDailyBalance
from (
    select 
        t.AccountID, 
        date(t.TransactionDate) as TransactionDate, 
        sum(a.Balance) as DailyBalance
    from Transactions t
    join Accounts a using(AccountID)
    where t.TransactionDate between '2024-03-25' and '2024-03-31'
    group by t.AccountID, date(t.TransactionDate)
) as DailyBalances
group by AccountID;

-- 11. Calculate the total balance for each account type.
select sum(balance) as TotalBalance 
from Accounts
group by  AccountType;

-- 12. Identify accounts with the highest number of transactions order by descending order.
select AccountID, count(TransactionID) as TransactionCount
from Transactions
group by AccountID
order by TransactionCount desc;

-- 13. List customers with high aggregate account balances, along with their account types.
SELECT c.CustomerID,c.FirstName,c.LastName,a.AccountType,SUM(a.Balance) AS TotalBalance
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, a.AccountType
ORDER BY TotalBalance DESC;

-- 14. Identify and list duplicate transactions based on transaction amount, date, and account.
select Amount,TransactionDate,AccountID,count(*) as DuplicateTransaction
from Transactions
group by TransactionDate,Amount,AccountID
having count(*) > 1
order by DuplicateTransaction desc, TransactionDate desc;

------------------------- TASK 4 -----------------------------

-- 1. Retrieve the customer(s) with the highest account balance.
select c.CustomerID,c.FirstName,c.LastName,Balance
from Customers c
join Accounts a using(CustomerID)
order by Balance desc;

-- 2. Calculate the average account balance for customers who have more than one account.
select a.CustomerID,c.FirstName,c.LastName,avg(balance) as AvgBalance
from Accounts a
join Customers c using(CustomerID)
where a.CustomerID in(
	select CustomerID
    from Accounts
    group by CustomerID
    having count(AccountID) > 1
)
group by a.CustomerID,c.FirstName,c.LastName;

-- 3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
select a.AccountID, avg(Amount) as AvgAmount
from Transactions
where Amount > AvgAmount ;

-- 4. Identify customers who have no recorded transactions.
SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customers c
JOIN Accounts a ON c.CustomerID = a.CustomerID
LEFT JOIN Transactions t ON a.AccountID = t.AccountID
WHERE t.TransactionID IS NULL;


-- 5. Calculate the total balance of accounts with no recorded transactions.
SELECT SUM(a.Balance) AS TotalBalance
FROM Accounts a
LEFT JOIN Transactions t ON a.AccountID = t.AccountID
WHERE t.TransactionID IS NULL;
 
-- 6. Retrieve transactions for accounts with the lowest balance.
select t.* ,a.balance
from Transactions t
join Accounts a using (AccountID)
where AccountID in (
	select AccountID
    from Accounts 
    order by Balance);
    
-- 7. Identify customers who have accounts of multiple types.
select c.CustomerId,c.FirstName,c.LastName,count(a.AccountID)
from Customers c
join Accounts a using(CustomerID)
where c.CustomerID in (
	select CustomerID
    from Accounts
    group by CustomerID
    having count(AccountID) > 1
    )
group by CustomerID;

-- 8. Calculate the percentage of each account type out of the total number of accounts.
select AccountType,count(AccountID) as TotalAccounts,
(count(AccountID) * 100.0 / (select count(*) from Accounts)) as Percentage
from Accounts
group by AccountType;

-- 9. Retrieve all transactions for a customer with a given customer_id.
select t.* , c.CustomerID
from Transactions t 
join Accounts a using(AccountID)
join Customers c using(CustomerID)
where AccountID in (
	 select CustomerID
     from Customers
     where CustomerID = 1
);

-- 10. Calculate the total balance for each account type, including a subquery within the SELECT clause.
select AccountType,
	(select sum(Balance)
    from Accounts a2
    where a2.AccountType = a1.AccountType) as TotalBalance
from Accounts a1
group by AccountType;
    





