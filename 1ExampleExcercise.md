

---

### **Schema Overview**

#### Tables from the PDF:
1. **Employee Table**:
   | Column       | Type       | Notes                              |
   |--------------|------------|------------------------------------|
   | ssn          | INT        | Primary Key                       |
   | fname        | VARCHAR(15)| First Name                        |
   | minit        | VARCHAR(2) | Middle Initial                    |
   | lname        | VARCHAR(15)| Last Name                         |
   | salary       | INT        | Salary                            |
   | dno          | INT        | Foreign Key to `department.dnumber`|

2. **Department Table**:
   | Column       | Type        | Notes                             |
   |--------------|-------------|-----------------------------------|
   | dnumber      | INT         | Primary Key                      |
   | dname        | VARCHAR(15) | Department Name                  |
   | mgrssn       | INT         | Manager SSN (Foreign Key to `employee.ssn`)|
   | mgrstartdate | DATE        | Manager's Start Date             |

3. **Dependent Table**:
   | Column         | Type       | Notes                             |
   |----------------|------------|-----------------------------------|
   | essn           | INT        | Foreign Key to `employee.ssn`    |
   | dependent_name | VARCHAR(15)| Dependent's Name                 |
   | relationship   | VARCHAR(15)| Relationship to Employee         |

---

### **Queries and Examples**

#### **1. CREATE TABLE**
**Query**:
```sql
CREATE TABLE department (
  dname VARCHAR(15),
  dnumber INT NOT NULL,
  mgrssn INT,
  mgrstartdate DATE,
  PRIMARY KEY (dnumber)
);
```

#### **2. INSERT DATA**
**Query**:
```sql
-- Insert into department
INSERT INTO department VALUES ('HR', 1, 101, '2020-01-01');
INSERT INTO department VALUES ('IT', 2, 102, '2019-03-15');

-- Insert into employee
INSERT INTO employee VALUES (101, 'Salman', 'A', 'Rahman', '1980-06-10', 'Dhaka', 'M', 50000, NULL, 1);
INSERT INTO employee VALUES (102, 'Sakib', 'B', 'Hasan', '1990-08-12', 'Chittagong', 'M', 60000, 101, 2);
```

#### **3. SELECT Queries**
- **Retrieve All Data**:
  ```sql
  SELECT * FROM employee;
  ```
  **Result**:
  | ssn  | fname  | lname  | salary | dno |
  |------|--------|--------|--------|-----|
  | 101  | Salman | Rahman | 50000  | 1   |
  | 102  | Sakib  | Hasan  | 60000  | 2   |

- **Conditional Select**:
  ```sql
  SELECT fname, lname FROM employee WHERE salary > 50000;
  ```
  **Result**:
  | fname | lname |
  |-------|-------|
  | Sakib | Hasan |

---

#### **4. UPDATE Queries**
**Query**:
```sql
UPDATE employee SET salary = 55000 WHERE ssn = 101;
```
**Effect**:
- Updates Salman Rahman's salary to 55000.

---

#### **5. DELETE Queries**
**Query**:
```sql
DELETE FROM employee WHERE ssn = 102;
```
**Effect**:
- Removes Sakib Hasan from the `employee` table.

---

#### **6. DROP TABLE**
- **Attempt to Drop Employee Table**:
  ```sql
  DROP TABLE employee;
  ```
  **Error**:
  - MySQL will not allow it because `dependent.essn` references `employee.ssn`.

- **Correct Order to Drop Tables**:
  ```sql
  DROP TABLE dependent;
  DROP TABLE employee;
  DROP TABLE department;
  ```

---

#### **7. JOINS**
- **Inner Join**: List employees with their department name.
  ```sql
  SELECT e.fname, e.lname, d.dname 
  FROM employee e
  JOIN department d ON e.dno = d.dnumber;
  ```
  **Result**:
  | fname  | lname  | dname |
  |--------|--------|-------|
  | Salman | Rahman | HR    |
  | Sakib  | Hasan  | IT    |

---

#### **8. GROUP BY and HAVING**
- **Group by Department with Average Salary**:
  ```sql
  SELECT dno, AVG(salary) AS avg_salary 
  FROM employee 
  GROUP BY dno;
  ```
  **Result**:
  | dno | avg_salary |
  |-----|------------|
  | 1   | 50000      |
  | 2   | 60000      |

- **Filter Departments with High Average Salary**:
  ```sql
  SELECT dno, AVG(salary) AS avg_salary 
  FROM employee 
  GROUP BY dno 
  HAVING AVG(salary) > 55000;
  ```
  **Result**:
  | dno | avg_salary |
  |-----|------------|
  | 2   | 60000      |

---

#### **9. AGGREGATE FUNCTIONS**
- **Count Employees**:
  ```sql
  SELECT COUNT(*) AS total_employees FROM employee;
  ```
  **Result**:
  | total_employees |
  |-----------------|
  | 2               |

- **Find Maximum Salary**:
  ```sql
  SELECT MAX(salary) AS max_salary FROM employee;
  ```
  **Result**:
  | max_salary |
  |------------|
  | 60000      |

---

#### **10. DISTINCT**
- **List Unique Department Numbers**:
  ```sql
  SELECT DISTINCT dno FROM employee;
  ```
  **Result**:
  | dno |
  |-----|
  | 1   |
  | 2   |

---

#### **11. PATTERN MATCHING**
- **Find Names Starting with 'S'**:
  ```sql
  SELECT fname FROM employee WHERE fname LIKE 'S%';
  ```
  **Result**:
  | fname |
  |-------|
  | Salman|
  | Sakib |

---

#### **12. LIMIT**
- **Get Top Two Salaries**:
  ```sql
  SELECT fname, salary FROM employee ORDER BY salary DESC LIMIT 2;
  ```
  **Result**:
  | fname  | salary |
  |--------|--------|
  | Sakib  | 60000  |
  | Salman | 55000  |

---

#### **13. CASCADE DELETE**
- **Enable Cascade Delete**:
  ```sql
  CREATE TABLE dependent (
    essn INT,
    dependent_name VARCHAR(15),
    relationship VARCHAR(15),
    FOREIGN KEY (essn) REFERENCES employee(ssn) ON DELETE CASCADE
  );
  ```

- **Delete Employee and Cascade**:
  ```sql
  DELETE FROM employee WHERE ssn = 101;
  ```
  **Effect**:
  - Salman's dependents are also removed from the `dependent` table.

---
