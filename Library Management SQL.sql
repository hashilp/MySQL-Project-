CREATE DATABASE Library;
USE Library;
#Create the branch table
CREATE TABLE Branch(
Branch_no INT PRIMARY KEY,
Manager_Id INT,
Branch_address VARCHAR(100),
Contact_no VARCHAR(30)
);

#Insert values into the Branche table.
INSERT INTO Branch VALUES
(1,1001, 'VKD-Kondotty',987456),
(2,1002,'Mavoor-Calicut',987455),
(3,1003,'Ponnani-Tirur',987454),
(4,1004,'Angadipuram-Perinthalmanna',987453),
(6,1005,'MLP-Malappuram',987452);
SELECT * FROM Branch;

#Create employee table
CREATE TABLE Employee(
Emp_Id INT PRIMARY KEY,
Emp_name VARCHAR(30),
Position VARCHAR(30),
Salary DECIMAL(10,2),
Branch_no INT,
FOREIGN KEY(Branch_no) REFERENCES Branch(Branch_no)
);
#Insert values into the Employee table.
INSERT INTO Employee VALUES
(2001,'ABU1','Sales',15000,1),
(2002,'RANI1','HR',20000,2),
(2003,'RAVI1','IT',25000,3),
(2004,'ROONEY1','ASST',30000,4),
(2005,'SONU1','MARKETING',35000,6),
(2006,'ABU2','HR',40000,3),
(2007,'RANI2','IT',25000,1),
(2008,'ROONEY2','MARKETING',30000,4),
(2009,'RAVI2','OFFICE',15000,3),
(2010,'SONU2','ASST',50000,2);
SELECT * FROM Employee;

#Create Customer table
CREATE TABLE Customer(
Customer_Id INT PRIMARY KEY,
Customer_name VARCHAR(40),
Customer_address VARCHAR(40),
Reg_date DATE
);

#Insert values into the Customer table.

INSERT INTO Customer VALUES
(2501,'EVAN-1','00a-St-1','2023-01-13'),
(2502,'EVAN-2','00b-St-2','2022-09-23'),
(2503,'EVAN-3','00c-St-3','2023-01-03'),
(2504,'EVAN-4','00d-St-4','2021-06-13'),
(2505,'EVAN-5','00e-St-5','2023-05-25'),
(2506,'EVAN-6','00f-St-6','2020-07-05'),
(2507,'EVAN-7','00g-St-7','2023-08-13'),
(2508,'EVAN-8','00h-St-8','2023-09-10'),
(2509,'EVAN-9','00i-St-9','2019-12-20'),
(2510,'EVAN-10','00j-St-10','2023-11-18');
SELECT * FROM Customer;

#Create Issue Status
CREATE TABLE IssueStatus(
Issue_Id INT PRIMARY KEY,
Issued_cust INT,
Issue_book_name VARCHAR(50),
Issue_date DATE,
ISBN_Book VARCHAR(50),
FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
FOREIGN KEY(ISBN_Book) REFERENCES Books(ISBN)
);
#Insert values into the IssueStatus table.

INSERT INTO IssueStatus VALUES
(3001,2501,'Book01','2022-08-02','ISBN001'), 
(3002,2502,'Book02','2022-11-04','ISBN002'), 
(3003,2503,'Book03','2022-02-08','ISBN003'), 
(3004,2504,'Book04','2022-08-10','ISBN004'), 
(3005,2505,'Book05','2022-08-13','ISBN005'), 
(3006,2506,'Book06','2022-05-16','ISBN006'), 
(3007,2507,'Book07','2022-08-19','ISBN007'), 
(3008,2508,'Book08','2022-08-24','ISBN008'), 
(3009,2509,'Book09','2022-06-28','ISBN009'), 
(3010,2510,'Book10','2022-11-29','ISBN010');
SELECT * FROM IssueStatus;

#Create the Returnstatus table.
CREATE TABLE Returnstatus(
Return_Id INT PRIMARY KEY,
Return_Cust INT,
Return_book_name VARCHAR(50),
Return_date DATE,
ISBN_Book2 VARCHAR(50),
FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
FOREIGN KEY (ISBN_Book2) REFERENCES Books(ISBN)
);
#Insert values into the Returnstatus table.

INSERT INTO Returnstatus VALUES
(4001,2501,'Book01','2022-12-01','ISBN001'),
(4002,2502,'Book02','2022-12-09','ISBN002'),
(4003,2503,'Book03','2022-12-06','ISBN003'),
(4004,2504,'Book04','2022-12-11','ISBN004'),
(4005,2505,'Book05','2022-12-15','ISBN005'),
(4006,2506,'Book06','2022-12-18','ISBN006'),
(4007,2507,'Book07','2022-12-20','ISBN007'),
(4008,2508,'Book08','2022-12-24','ISBN008'),
(4009,2509,'Book09','2022-12-28','ISBN009'),
(4010,2510,'Book10','2022-12-30','ISBN010');
SELECT * FROM Returnstatus;
#Create the Books.
CREATE TABLE Books(
ISBN VARCHAR(25)  PRIMARY KEY,
Book_title VARCHAR(40),
Category VARCHAR(40),
Rental_Price DECIMAL(15,4),
Status VARCHAR(5),
Author VARCHAR(50),
Publisher VARCHAR(50)
);
DROP TABLE Books;
#Insert values into the Books table.
INSERT INTO Books VALUES
('ISBN001','Book01','Science',5.99,'Yes','Author01','Publisher01'),
('ISBN002','Book02','Fiction',7.99,'Yes','Author02','Publisher02'),
('ISBN003','Book03','No-Fiction',6.99,'Yes','Author03','Publisher03'),
('ISBN004','Book04','Mystery',8.99,'Yes','Author04','Publisher04'),
('ISBN005','Book05','History',9.99,'Yes','Author05','Publisher05'),
('ISBN006','Book06','OR',4.99,'Yes','Author06','Publisher06'),
('ISBN007','Book07','Maths',5.99,'Yes','Author07','Publisher07'),
('ISBN008','Book08','Romance',6.99,'Yes','Author08','Publisher08'),
('ISBN009','Book09','Thriller',7.99,'Yes','Author09','Publisher09'),
('ISBN010','Book10','Self-Help',8.99,'Yes','Author10','Publisher10');
SELECT * FROM Books;
#Q1 Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price FROM Books ;

#Q2  List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

#Q3 Retrieve the book titles and the corresponding customers who have issued those books.

SELECT Issue_book_name, Customer_name
FROM IssueStatus
JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_Id;

#Q4 Display the total count of books in each category
SELECT Category, COUNT(*) AS Total_Count FROM Books GROUP BY Category;

#Q5 Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000
SELECT Emp_name, Position FROM Employee WHERE Salary > 50000;

#Q6 List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_Name  FROM Customer  WHERE Reg_date < '2022-01-01'
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus );

#Q7  Display the branch numbers and the total count of employees in each branch.
SELECT Branch_no, COUNT(*) AS Total_Employees FROM Employee GROUP BY Branch_no;

#Q8 Display the names of customers who have issued books in the month of June 2023.
SELECT Customer_Name FROM Customer WHERE Customer_Id  IN (SELECT Issued_cust FROM IssueStatus WHERE MONTH(Issue_date) = 6 AND year(Issue_date) = 2023);

#Q9 Retrieve book_title from book table containing history.
SELECT Book_title FROM Books WHERE Category = 'History';

#Q10 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT Branch_no, COUNT(*) AS Total_Employees FROM Employee GROUP BY Branch_no HAVING COUNT(*) > 5;
