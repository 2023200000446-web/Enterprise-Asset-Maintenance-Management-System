CREATE TABLE Department (
    Department_ID NUMBER PRIMARY KEY,
    Department_Name VARCHAR2(15) NOT NULL,
    Address VARCHAR2(20)
);
CREATE TABLE Role (
    Role_ID NUMBER PRIMARY KEY,
    Role_Name VARCHAR2(20) NOT NULL
);
CREATE TABLE Asset_Category (
    Category_ID NUMBER PRIMARY KEY,
    Category_Name VARCHAR2(100) NOT NULL
);
CREATE TABLE Vendor (
    Vendor_ID NUMBER PRIMARY KEY,
    Vendor_Name VARCHAR2(100) NOT NULL,
    Contact_Number VARCHAR2(20),
    Email VARCHAR2(100),
    Address VARCHAR2(200)
);
CREATE TABLE Employee (
    Employee_ID NUMBER PRIMARY KEY,
    First_Name VARCHAR2(50) NOT NULL,
    Last_Name VARCHAR2(50) NOT NULL,
    Email VARCHAR2(100) UNIQUE,
    Phone_Number VARCHAR2(20),
    Position VARCHAR2(50),
    Department_ID NUMBER,
    Role_ID NUMBER,
    CONSTRAINT FK_EMP_DEPARTMENT
        FOREIGN KEY (Department_ID)
        REFERENCES Department(Department_ID),
    CONSTRAINT FK_EMP_ROLE
        FOREIGN KEY (Role_ID)
        REFERENCES Role(Role_ID)
);
CREATE TABLE Asset (
    Asset_ID NUMBER PRIMARY KEY,
    Asset_Name VARCHAR2(100) NOT NULL,
    Serial_Number VARCHAR2(100) UNIQUE,
    Purchase_Date DATE,
    Purchase_Cost NUMBER(10,2),
    Asset_Status VARCHAR2(30),
    Category_ID NUMBER,
    Vendor_ID NUMBER,
    CONSTRAINT FK_ASSET_CATEGORY
        FOREIGN KEY (Category_ID)
        REFERENCES Asset_Category(Category_ID),
    CONSTRAINT FK_ASSET_VENDOR
        FOREIGN KEY (Vendor_ID)
        REFERENCES Vendor(Vendor_ID)
);
CREATE TABLE Maintenance_Request (
    Request_ID NUMBER PRIMARY KEY,
    Request_Date DATE NOT NULL,
    Issue_Description VARCHAR2(300) NOT NULL,
    Request_Status VARCHAR2(30),
    Asset_ID NUMBER,
    Employee_ID NUMBER,
    CONSTRAINT FK_REQUEST_ASSET
        FOREIGN KEY (Asset_ID)
        REFERENCES Asset(Asset_ID),
    CONSTRAINT FK_REQUEST_EMPLOYEE
        FOREIGN KEY (Employee_ID)
        REFERENCES Employee(Employee_ID)
);

CREATE TABLE Maintenance (
    Maintenance_ID NUMBER PRIMARY KEY,
    Employee_ID NUMBER,
    Request_ID NUMBER,    
    Start_Date DATE,
    Completion_Date DATE,
    Maintenance_Cost NUMBER(10,2),
    Remarks VARCHAR2(300),
    CONSTRAINT FK_MAINT_REQUEST
        FOREIGN KEY (Request_ID)
        REFERENCES Maintenance_Request(Request_ID),
    CONSTRAINT FK_MAINT_Employee
        FOREIGN KEY (Employee_ID)
        REFERENCES Employee(Employee_ID)
);

CREATE TABLE Asset_Assignment (
    Assignment_ID NUMBER PRIMARY KEY,
    Assigned_Date DATE NOT NULL,
    Return_Date DATE,
    Status VARCHAR2(30),
    Employee_ID NUMBER,
    Asset_ID NUMBER,
    CONSTRAINT FK_ASSIGN_EMPLOYEE
        FOREIGN KEY (Employee_ID)
        REFERENCES Employee(Employee_ID),
    CONSTRAINT FK_ASSIGN_ASSET
        FOREIGN KEY (Asset_ID)
        REFERENCES Asset(Asset_ID)
);

INSERT INTO Department VALUES
    (1,'IT','Building A, Floor 2'),
    (2,'Human Resources','Building B, Floor 1'),
    (3,'Finance','Building C, Floor 3'),
    (4,'Administration','Building D, Floor 1');
    
INSERT INTO Role VALUES
    (1,'Manager'),
    (2,'Technician'),
    (3,'HR Executive'),
    (4,'Accountant'),
    (5,'IT Officer');
    
    INSERT INTO Asset_Category VALUES
    (1,'Laptop'),
    (2,'Desktop'),
    (3,'Printer'),
    (4,'Projector'),
    (5,'Router'); 


INSERT INTO Vendor VALUES
    (1,'Star Tech','01711111111','contact@startech.com','Dhaka'),
    (2,'Ryans Computers','01822222222','info@ryans.com','Dhaka'),
    (3,'Dell Bangladesh','01933333333','support@dell.com','Dhaka'),
    (4,'TechLand BD','01644444444','sales@techland.com','Dhaka');   
    
    
INSERT INTO Employee VALUES
    (101,'Mahim','Howlader','mahim@company.com','01710000001','Senior IT Support Officer',1,5),
    (102,'Rahim','Ahmed','rahim@company.com','01710000002','Maintenance Engineer',1,2),
    (103,'Karim','Hasan','karim@company.com','01710000003','HR Officer',2,3),
    (104,'Sakib','Islam','sakib@company.com','01710000004','IT Department Manager',1,1),
    (105,'Nusrat','Jahan','nusrat@company.com','01710000005','Accounts Officer',3,4);
    
 
INSERT INTO Asset VALUES
    (1001,'Dell Latitude 5540','DL55402026001',DATE '2026-01-15',85000,'Assigned',1,3),
    (1002,'HP LaserJet Pro','HPLJ2026002',DATE '2026-02-10',35000,'Available',3,1),
    (1003,'Cisco Router','CSR2026003',DATE '2026-03-01',42000,'Under Maintenance',5,2),
    (1004,'Lenovo ThinkPad E16','LN2026004',DATE '2026-04-18',78000,'Assigned',1,4);
    
    
    INSERT INTO Maintenance_Request VALUES
        (1,DATE '2026-07-20','Laptop overheating frequently','Pending',1001,101),
        (2,DATE '2026-07-21','Router not connecting to network','Approved',1003,104),
        (3,DATE '2026-07-22','Printer paper jam issue','Pending',1002,103);
        
        
INSERT INTO Maintenance VALUES
    (1,102,1,DATE '2026-07-20',DATE '2026-07-20',1500,'Cooling fan cleaned'),
    (2,102,1,DATE '2026-07-21',DATE '2026-07-22',2500,'Thermal paste replaced'),
    (3,102,2,DATE '2026-07-21',NULL,1200,'Router diagnosis in progress'),
    (4,102,3,DATE '2026-07-22',NULL,800,'Printer roller cleaned');
            
            
INSERT INTO Asset_Assignment VALUES
    (1,DATE '2026-01-20',NULL,'Assigned',101,1001),
    (2,DATE '2026-02-15',DATE '2026-06-10','Returned',104,1002),
    (3,DATE '2026-06-15',NULL,'Assigned',102,1003),
    (4,DATE '2026-05-10',NULL,'Assigned',105,1004);
    
    
    
 SELECT * FROM Department;
SELECT * FROM Role;
SELECT * FROM Asset_Category;
SELECT * FROM Vendor;
SELECT * FROM Employee;
SELECT * FROM Asset;
SELECT * FROM Maintenance_Request;
SELECT * FROM Maintenance;
SELECT * FROM Asset_Assignment;

AND
SELECT *
FROM Employee
WHERE Department_ID = 1
AND Role_ID = 5;

-- OR Operator
SELECT Asset_ID,
       Asset_Name,
       Asset_Status
FROM Asset
WHERE Asset_Status='Assigned'
OR Asset_Status='Under Maintenance';

NOT Operator
SELECT Request_ID,
       Issue_Description,
       Request_Status
FROM Maintenance_Request
WHERE NOT Request_Status='Pending';

UNION

SELECT Employee_ID
FROM Asset_Assignment
UNION
SELECT Employee_ID
FROM Maintenance_Request;

UNION ALL

SELECT Employee_ID
FROM Asset_Assignment
UNION ALL
SELECT Employee_ID
FROM Maintenance_Request;

INTERSECT

SELECT Employee_ID
FROM Asset_Assignment
INTERSECT
SELECT Employee_ID
FROM Maintenance_Request;

MINUS

SELECT Employee_ID
FROM Asset_Assignment
MINUS
SELECT Employee_ID
FROM Maintenance_Request;

Join

 SELECT E.Employee_ID,
        E.First_Name,
        E.Last_Name,
        A.Asset_Name
 FROM Employee E
JOIN Asset_Assignment AA
 ON E.Employee_ID = AA.Employee_ID
 JOIN Asset A
 ON AA.Asset_ID = A.Asset_ID;

Group By

SELECT Department_ID,
       COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Department_ID;

Having

SELECT Department_ID,
       COUNT(*) AS Total_Employees
FROM Employee
GROUP BY Department_ID
HAVING COUNT(*) > 1;

In

SELECT Employee_ID,
       First_Name,
       Last_Name,
       Department_ID
FROM Employee
WHERE Department_ID IN (
    SELECT Department_ID
    FROM Department
    WHERE Department_Name IN ('IT', 'Human Resources')
);

Not In

SELECT Employee_ID,
       First_Name,
       Last_Name,
       Department_ID
FROM Employee
WHERE Department_ID NOT IN (
    SELECT Department_ID
    FROM Department
    WHERE Department_Name IN ('IT', 'Human Resources')
);

Any

SELECT Asset_ID,
       Asset_Name,
       Purchase_Cost
FROM Asset
WHERE Purchase_Cost > ANY (
    SELECT Purchase_Cost
    FROM Asset
    WHERE Vendor_ID = 1
);

Exists 

SELECT E.Employee_ID,
       E.First_Name,
       E.Last_Name
FROM Employee E
WHERE EXISTS (
    SELECT 1
    FROM Asset_Assignment AA
    WHERE AA.Employee_ID = E.Employee_ID
);

NOT EXISTS

SELECT E.Employee_ID,
       E.First_Name,
       E.Last_Name
FROM Employee E
WHERE NOT EXISTS (
    SELECT 1
    FROM Asset_Assignment AA
    WHERE AA.Employee_ID = E.Employee_ID
);
INNER JOIN

SELECT E.Employee_ID,
       E.First_Name,
       E.Last_Name,
       A.Asset_Name
FROM Employee E
JOIN Asset_Assignment AA
ON E.Employee_ID = AA.Employee_ID
JOIN Asset A
ON AA.Asset_ID = A.Asset_ID;

NATURAL JOIN

SELECT Employee_ID,
       First_Name,
       Last_Name,
       Assignment_ID,
       Asset_ID,
       Status
FROM Employee
NATURAL JOIN Asset_Assignment;

LEFT JOIN

SELECT E.Employee_ID,
       E.First_Name,
       E.Last_Name,
       A.Asset_Name
FROM Employee E
LEFT JOIN Asset_Assignment AA
ON E.Employee_ID = AA.Employee_ID
LEFT JOIN Asset A
ON AA.Asset_ID = A.Asset_ID;

RIGHT JOIN

SELECT E.Employee_ID,
       E.First_Name,
       E.Last_Name,
       A.Asset_ID,
       A.Asset_Name
FROM Employee E
RIGHT JOIN Asset_Assignment AA
ON E.Employee_ID = AA.Employee_ID
RIGHT JOIN Asset A
ON AA.Asset_ID = A.Asset_ID;

Count 

SELECT COUNT(*) AS Total_Employees
FROM Employee;

Sum 

SELECT SUM(Purchase_Cost) AS Total_Purchase_Cost
FROM Asset;

Avg 

SELECT AVG(Purchase_Cost) AS Average_Purchase_Cost
FROM Asset;

Max 

SELECT MAX(Purchase_Cost) AS Highest_Purchase_Cost
FROM Asset;

Min

SELECT MIN(Purchase_Cost) AS Lowest_Purchase_Cost
FROM Asset;

Create View

CREATE VIEW Asset_View AS
SELECT Asset_ID, Asset_Name, Purchase_Cost, Asset_Status
FROM Asset;

Use View

SELECT *
FROM Asset_View;




