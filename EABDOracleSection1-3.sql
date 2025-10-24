-- SECTION 1 ORACLE

-- Un bloc PL/SQL este alcătuit din trei secțiuni:

DECLARE      /* declarative section (opțională), conține declarațiile tuturor variabilelor, constantelor, cursorilor 
             și excepțiilor definite de utilizator la care se face referire în secțiunile executabile și excepții */

BEGIN      /* executable section (obligatorie), conține instrucțiuni SQL pentru a obține date din baza de date și 
           instrucțiuni PL/SQL pentru a manipula datele din bloc, trebuie să conțină cel puțin o instrucțiune */
--statements 

[EXCEPTION]      -- exception section (opțională), specifică acțiunile de efectuat atunci când apar erori și condiții anormale în secțiunea executabilă

END;      -- sfârșitul unui bloc PL/SQL, obligatoriu pentru a delimita codul și a permite compilatorului să știe unde se termină blocul

/* Blocurile anonime PL/SQL:
- un bloc anonim PL/SQL este un bloc de cod care nu are un nume și nu este stocat în baza de date pentru utilizare ulterioară;
- blocurile anonime sunt utilizate pentru a executa sarcini unice, cum ar fi testarea codului sau efectuarea unei operațiuni unice asupra datelor;
- blocurile anonime nu pot fi apelate sau reutilizate;
- fiecare bloc anonim PL/SQL trebuie să conțină o secțiune executabilă;
- secțiunile declarative și de excepții sunt opționale. */

-- Structura unui bloc anonim:

[DECLARE]

BEGIN
-- statements

[EXCEPTION]

END;

-- Exemple de blocuri anonime:

-- Doar secțiunea executabilă (minimum required);

BEGIN
  DBMS_OUTPUT.PUT_LINE('PL/SQL is easy!');
END;

-- Secțiuni declarative și executabile;

DECLARE
  v_date DATE := SYSDATE;
BEGIN
  DBMS_OUTPUT.PUT_LINE(v_date);
END;

-- Secțiuni declarative, executabile si excepții;

DECLARE 
  v_first_name VARCHAR2(25);
  v_last_name VARCHAR2(25);
BEGIN
  SELECT first_name, last_name
    INTO v_first_name, v_last_name
    FROM employees
    WHERE last_name = 'Oswald';
  DBMS_OUTPUT.PUT_LINE('The employee of the month is: ' || v_first_name || ' ' || v_last_name || '.');
EXCEPTION 
  WHEN TOO_MANY_ROWS THEN 
    DBMS_OUTPUT.PUT_LINE('Your select statement retrieved multiple rows. Consider using a cursor or changing the search criteria.');
END;

/* Subprogramele PL/SQL sunt blocuri de cod denumite care pot fi 
stocate în baza de date și apelate ori de câte ori este necesar */

-- Două tipuri de subprograme PL/SQL:

-- 1. Procedure -- efectuează o acțiune:

PROCEDURE name  
IS
  -- variable declarations 
BEGIN
  -- statements 
[EXCEPTION]
END;

-- 2. Function -- calculează și returnează o valoare:

FUNCTION name 
RETURN datatype 
  -- variable declaration(s)
IS
BEGIN
  -- statements
  RETURN value;
[EXCEPTION]
END;

-- Exemple de blocuri de cod de subprograme PL/SQL

-- Bloc de cod pentru crearea unei proceduri numite PRINT_DATE:

CREATE OR REPLACE PROCEDURE print_date IS
  v_date VARCHAR2(30);
  BEGIN
    SELECT TO_CHAR(SYSDATE, 'Mon DD, YYYY')
    INTO v_date
    FROM DUAL;
  DBMS_OUTPUT.PUT_LINE(v_date);
END;

-- Acum putem apela această procedură într-o secțiune executabilă:

BEGIN 
  PRINT_DATE;
END;

-- Bloc de cod pentru a crea o funcție numită TOMORROW:

CREATE OR REPLACE FUNCTION tomorrow (p_today IN DATE)
  RETURN DATE IS 
  v_tomorrow DATE;
BEGIN 
  SELECT p_today + 1 INTO v_tomorrow 
    FROM DUAL;
  RETURN v_tomorrow;
END;

-- Putem apela funcția folosind fie o instrucțiune SQL, fie un bloc PL/SQL:

SELECT TOMORROW(SYSDATE) AS "Tomorrow's Date"
FROM DUAL;

BEGIN 
DBMS_OUTPUT.PUT_LINE(TOMORROW(SYSDATE));
END;

-- DBMS_OUTPUT.PUT_LINE ne permite să afișăm rezultate, astfel încât să putem verifica dacă blocul nostru funcționează corect

-- Ne permite să afișăm câte un șir de caractere pe rând, deși acesta poate fi concatenat

DECLARE
  v_emp_count NUMBER;
BEGIN
  DBMS_OUTPUT.PUT_LINE('PL/SQL is easy so far!');
  SELECT COUNT(*) INTO v_emp_count FROM employees;
  DBMS_OUTPUT.PUT_LINE('There are ' || v_emp_count || 'rows in the employees table');
END;

-- SECTION 2 ORACLE 

-- Inițializarea variabilelor 

DECLARE 
  v_counter INTEGER := 0;
BEGIN 
  v_counter := v_counter + 1;
  DBMS_OUTPUT.PUT_LINE(v_counter);
END;

-- Declararea și inițializarea de variabile 

-- Exemplul 1:

DECLARE 
  fam_birthdate DATE;
  fam_size NUMBER(1) NOT NULL := 3;
  fam_location VARCHAR2(15) := 'Râmnicu Vâlcea';
  fam_bank CONSTANT NUMBER := 50000;
  fam_name VARCHAR2(20) DEFAULT 'Dinu';
  fam_party_size CONSTANT PLS_INTEGER := 3;

-- Exemplul 2:

DECLARE
  v_emp_hiredate DATE;      -- VARIABILE 
  v_emp_deptno NUMBER(2) NOT NULL := 10;
  v_location VARCHAR2(15) := 'Râmnicu Vâlcea';
  c_comm CONSTANT NUMBER := 1400;      -- CONSTANTE 
  v_population INTEGER;
  v_book_type VARCHAR2(20) DEFAULT 'fiction';
  v_artist_name VARCHAR2(50);
  v_firstname VARCHAR2(20) := 'Alexandra';
  v_lastname VARCHAR2(20) DEFAULT 'Dinu';
  c_display_no CONSTANT PLS_INTEGER := 20; 

-- Atribuirea de valori în secțiunea executabilă 

-- Exemplul 1:

DECLARE 
  v_myname VARCHAR2(20);
  BEGIN
  DBMS_OUTPUT.PUT_LINE('My name is: ' || v_myname);
  v_myname := 'Alexandra';
  DBMS_OUTPUT.PUT_LINE('My name is: ' || v_myname);
END;

/* Output: My name is:
           My name is: Alexandra */

-- Exemplul 2:

DECLARE
  v_myname VARCHAR2(20) := 'Alexandra';
BEGIN 
  v_myname := 'Dinu';
  DBMS_OUTPUT.PUT_LINE('My name is: ' || v_myname);
END;

-- Output: My name is Dinu

-- Transmiterea variabilelor ca parametri către subprograme PL/SQL:

DECLARE 
  v_date VARCHAR2(30);
BEGIN
  SELECT TO_CHAR(SYSDATE) INTO v_date FROM DUAL;
  DBMS_OUTPUT.PUT_LINE(v_date);
END;

-- Atribuirea de variabile la ieșirea subprogramului PL/SQL:

FUNCTION num_characters (p_string IN VARCHAR2)
  RETURN INTEGER IS
    v_num_characters INTEGER;
BEGIN
  SELECT LENGTH(p_string) INTO v_num_characters FROM DUAL;
  RETURN v_num_characters;
END;

-- Se apelează funcția num_characters și se afișează rezultatul:

DECLARE
  v_length_of_string INTEGER;
BEGIN
  v_length_of_string := num_characters('Oracle Corporation');
  DBMS_OUTPUT.PUT_LINE(v_length_of_string);
END;

-- Exemplu de utilizare a funcției ADD_MONTHS:

DECLARE
  v_date DATE;
BEGIN
  SELECT ADD_MONTHS(SYSDATE,3) INTO v_date FROM DUAL;
END;

/* An identifier is the name given to a PL/SQL object, including any of the following: Procedure, 
Function, Variable, Exception, Constant, Package, Record, PL/SQL table, Cursor */

/* Identifier Properties:
− maximum 30 characters in length;
− must begin with a letter;
− may include $ (dollar sign), _ (underscore), or # (hashtag);
− may not contain spaces;
− identifiers are NOT case sensitive. */

/* Delimiters:

• Delimiters are symbols that have special meaning. 

Simple delimiters consist of one character:

Symbol Meaning
+      addition operator
-      subtraction/negation operator
*      multiplication operator
/      division operator
=      equality operator
'      character string delimiter
;      statement terminator 

• Compound delimiters consist of two characters:

Symbol Meaning
<>     inequality operator
!=     inequality operator
||     concatenation operator
--     single-line comment indicator
/*     beginning comment delimiter
*/     ending comment delimiter
**     exponent
:=     assignment operator */

/* Literals:

• A literal is an explicit numeric, character string, date, or boolean value that might be stored in a variable (constant or used directly in an expression).

• Literals are classified as:
− Character (also known as string literals);
− Numeric;
− Boolean.

Character Literals: */

DECLARE
  v_firstname VARCHAR2(30) := 'Alexandra';
  v_classroom VARCHAR2(4) := '12F';
  v_course_id VARCHAR2(8) := 'CS 101';
BEGIN
…

Numeric Literals:

DECLARE
  v_classroom NUMBER(3) := 327;
  v_grade NUMBER(3) := 95;
  v_price NUMBER(5) := 150;
  v_salary NUMBER(8) := 2E5;
  c_pi CONSTANT NUMBER(7,6) := 3.141592;
BEGIN
…

Boolean Literals:

DECLARE
  v_new_customer BOOLEAN := FALSE;
  v_fee_paid BOOLEAN := TRUE;
  v_diploma BOOLEAN := NULL;
BEGIN
…

/* 
COMMENTS

Syntax for Commenting Code:

Two ways to indicate comments in PL/SQL:
•When commenting a single line, use two dashes (--)
•When commenting multiple lines, begin the comment with /* and end the comment with */

Exemplu:
*/

DECLARE
-- converts monthly salary to annual salary
  v_montly_sal NUMBER(9,2);
  v_annual_sal NUMBER(9,2);
BEGIN -- begin executable section
/* Compute the annual salary based on the
monthly salary input from the user */
  v_annual_sal := v_monthly_sal * 12;
END; -- end block */

/* Tipuri de date PL/SQL

Tipuri de date scalare:
- Character;
- Numeric;
- Date/Time;
- Boolean.

• SCALAR CHARACTER data types:
− CHAR[(maximum_length)];      Tip de dată cu lungime fixă!
− VARCHAR2(maximum_length);    Tip de dată cu lungime variabilă!
− LONG.                        Tip de dată depreciat! De evitat! Trebuie utilizat CLOB în locul acestuia! 

Exemplu: 
*/ 

v_first_name VARCHAR2(20) := 'Alexandra';

/*
• SCALAR NUMERIC data types:
− NUMBER;
- NUMBER(p,s);
- NUMBER(p);
− FLOAT;
− BINARY_FLOAT;
− BINARY_DOUBLE;
− INTEGER;
− PLS_INTEGER.

Exemplu: 
*/

v_salary NUMBER(8,2) := 9999.99;

/*
• SCALAR DATE data types:
− DATE;
− TIMESTAMP;
− TIMESTAMP WITH TIME ZONE.

Exemplu: 
*/

v_hire_date DATE := '15-Apr-2015';

/*
• SCALAR BOOLEAN data type:
- TRUE;
- FALSE;
- NULL.

Exemplu: 
*/

v_control BOOLEAN := TRUE;

/*
Tipuri de date compuse:
- RECORD;
- TABLE;
- VARRAY.

Composite data types have internal components, sometimes 
called elements, that can be manipulated individually.

Tip de date LOB (Large Object):
- CLOB (Character Large Object);      Tip de dată folosit pentru a stoca cantități foarte mari de text!
- BLOB (Binary Large Object);
- BFILE (Binary File);
- NCLOB (National Character Large Object). 
*/

-- Declaring Character Variables:

DECLARE
  v_country_id CHAR(2);      
  v_country_name VARCHAR2(70);
  v_country_rpt CLOB;

-- Declaring Number Variables:

DECLARE
  v_employee_id NUMBER(6,0);
  v_loop_count INTEGER := 0;
  c_tax_rate CONSTANT NUMBER(3,2) := 8.25;  

-- Declaring Date Variables:

DECLARE
  v_date1 DATE := '05-Apr-2015';
  v_date2 DATE := v_date1 + 7;
  v_date3 TIMESTAMP := SYSDATE;
  v_date4 TIMESTAMP WITH TIME ZONE := SYSDATE;
BEGIN
  DBMS_OUTPUT.PUT_LINE(v_date1);
  DBMS_OUTPUT.PUT_LINE(v_date2);
  DBMS_OUTPUT.PUT_LINE(v_date3);
  DBMS_OUTPUT.PUT_LINE(v_date4);
END;

-- Declaring Boolean Variables:

DECLARE
  v_valid1 BOOLEAN := TRUE;
  v_valid2 BOOLEAN;
  v_valid3 BOOLEAN NOT NULL := FALSE;
BEGIN
  IF v_valid1 THEN
    DBMS_OUTPUT.PUT_LINE('Test is TRUE');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Test is FALSE');
END IF;
END;

/* Defining Variables with the %TYPE Attribute

In the EMPLOYEES table, the column first_name is defined as VARCHAR2(20).
In a PL/SQL block, you could define a matching variable with either: */

v_first_name VARCHAR2(20);
-- OR
v_first_name employees.last_name%TYPE;

/* Using the %TYPE attribute ensures that the variable always matches the data 
type of the database column, even if the column's data type is changed later. */

DECLARE
  v_first_name employees.first_name%TYPE;
BEGIN
  SELECT first_name
    INTO v_first_name
    FROM employees
    WHERE last_name = 'Dinu';
  DBMS_OUTPUT.PUT_LINE(v_first_name);
END;

-- Using the %TYPE Attribute
-- • Syntax:

identifier table_name.column_name%TYPE;
indentifier identifier%TYPE;

-- • Examples:

DECLARE
  v_first_name employees.first_name%TYPE;
  v_salary employess.salary%TYPE;

DECLARE
  v_old_salary v_salary%TYPE;
  v_new_salary v_salary%TYPE;

DECLARE
  v_balance NUMBER(10,2);
  v_min_balance v_balance%TYPE := 1000;

-- Assigning New Values to Variables (:=)

-- • Character and date literals must be enclosed in single quotation marks:

v_name := 'Dinu Alexandra';
v_start_date := '18-Feb-2004';

-- • Statements can continue over several lines:

v_quote := 'The only thing that we can know is that we know nothing and that is the highest flight of human reason.';

-- • Numbers can be simple values or scientific notation (2E5 meaning 2x10 to the power of 5 = 200,000):

v_my_integer := 100;
v_my_sci_not := 2E5;

-- SQL Functions in PL/SQL

-- • You are already familiar with functions in SQL statements, for example:

SELECT LAST_DAY(SYSDATE)
FROM DUAL;

-- • You can also use these functions in PL/SQL procedural statements, for example:

DECLARE
  v_last_day DATE;
BEGIN
  v_last_day := LAST_DAY(SYSDATE);
  DBMS_OUTPUT.PUT_LINE(v_last_day);
END;

/* • SQL functions help you to manipulate data. They fall into the following categories:
− Character;
− Number;
− Date;
− Conversion;
− Miscellaneous. */

-- Examples of Character Functions:

-- • Get the length of a string:

v_desc_size INTEGER(5);
v_prod_description VARCHAR2(70) := 'You can use this product with your radios for higher frequency';
v_desc_size:= LENGTH(v_prod_description);

-- • Convert the name of the country capitol to upper case:

v_capitol_name := UPPER(v_capitol_name);

-- • Concatenate the first and last names:

v_emp_name := v_first_name || ' ' || v_last_name;

-- Examples of Number Functions:

-- • Get the sign of a number:

DECLARE
  v_my_num BINARY_INTEGER := -56664;
BEGIN
  DBMS_OUTPUT.PUT_LINE(SIGN(v_my_num));
END;

-- • Round a number to 0 decimal places:

DECLARE
v_median_age NUMBER(6,2);
BEGIN
  SELECT median_age INTO v_median_age
  FROM countries
  WHERE country_id = 27;
  DBMS_OUTPUT.PUT_LINE(ROUND(v_median_age,0));
END;

-- Examples of Date Functions:

-- • Add months to a date:

DECLARE
  v_new_date DATE;
  v_num_months NUMBER := 6;
BEGIN
  v_new_date := ADD_MONTHS(SYSDATE, v_num_months);
  DBMS_OUTPUT.PUT_LINE(v_new_date);
END;

-- • Calculate the number of months between two dates:

DECLARE
  v_no_months PLS_INTEGER := 0;
BEGIN
  v_no_months := MONTHS_BETWEEN('18-Feb-2004', '18-Feb-2025');
  DBMS_OUTPUT.PUT_LINE(v_no_months);
END;

-- Data-Type Conversion:

-- Example of Implicit Conversion:

• In this example, the variable v_sal_increase is of type VARCHAR2.
While calculating the total salary, PL/SQL first converts
v_sal_increase to NUMBER and then performs the
operation. The result of the operation is the NUMBER type:

DECLARE
  v_salary NUMBER(6) := 6000;
  v_sal_increase VARCHAR2(5) := '1000';
  v_total_salary v_salary%TYPE;
BEGIN
  v_total_salary := v_salary + v_sal_increase;
  DBMS_OUTPUT.PUT_LINE(v_total_salary);
END;

Examples of Explicit Conversions

• TO_CHAR:

BEGIN
  DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE,'Month YYYY'));
END;

• TO_DATE:

BEGIN
  DBMS_OUTPUT.PUT_LINE(TO_DATE('April-1999','Month-YYYY'));
END;

• TO_NUMBER:

DECLARE
  v_a VARCHAR2(10) := '-123456';
  v_b VARCHAR2(10) := '+987654';
  v_c PLS_INTEGER;
BEGIN
  v_c := TO_NUMBER(v_a) + TO_NUMBER(v_b);
  DBMS_OUTPUT.PUT_LINE(v_c);
END;


• Note that the DBMS_OUTPUT.PUT_LINE procedure expects
an argument with a character type such as VARCHAR2;
• Variable v_c is a number, therefore we should explicitly
code: DBMS_OUTPUT.PUT_LINE(TO_CHAR(v_c)).

Data Type Conversion Examples:

• Example #1:

v_date_of_joining DATE := '02-Feb-2014';

• Example #2:

v_date_of_joining DATE := 'February 02, 2014';

• Example #3:

v_date_of_joining DATE := TO_DATE('February 02, 2014', 'Month DD, YYYY');

Operators in PL/SQL:

• The following table shows the default order of
operations from high priority to low priority:

Operator Operation
**       Exponentiation
+, -     Identity, negation
*, /     Multiplication, division
+, -, || Addition, subtraction, concatenation
=, <, >, <=, >=, <>, !=, ~=, ^=, IS NULL, LIKE, BETWEEN, IN Comparison
NOT      Logical negation
AND      Conjunction
OR       Inclusion

Blocuri imbricate:

• Blocurile imbricate sunt blocuri de cod plasate în alte blocuri de cod.
• Există un bloc exterior și un bloc interior.
• Puteți imbrica blocuri în blocuri de câte ori este nevoie; nu există o limită practică a adâncimii imbricarii permise de Oracle.

Nested Block Example:

DECLARE
  v_outer_variable VARCHAR2(20):='GLOBAL VARIABLE';
BEGIN
  DECLARE
    v_inner_variable VARCHAR2(20):='LOCAL VARIABLE';
  BEGIN
    DBMS_OUTPUT.PUT_LINE(v_inner_variable);
    DBMS_OUTPUT.PUT_LINE(v_outer_variable);
  END;
  DBMS_OUTPUT.PUT_LINE(v_outer_variable);
END; */

-- 2.6 !!!!

-- SECTION 3 ORACLE 

/* Limbaj de Manipulare a Datelor (DML)
• Putem utiliza comenzi DML pentru a adăuga rânduri, a șterge rânduri
și a modifica datele dintr-un rând
• Comenzile DML sunt INSERT, UPDATE, DELETE și MERGE

INSERT
• Instrucțiunea INSERT se utilizează pentru a adăuga rânduri noi într-un
tabel
• Necesită cel puțin două elemente:
−Numele tabelului
−Valorile pentru fiecare coloană din tabel
−(Opțional, dar recomandat) Numele coloanelor care
vor primi o valoare atunci când rândul este inserat
−Dacă se utilizează această opțiune, atunci lista de valori trebuie să corespundă cu
lista de coloane
•Cel puțin, trebuie să listați și să inițializați cu o
valoare fiecare coloană care nu poate fi NULL

INSERT Explicit Syntax

Sintaxa afișată listează explicit fiecare coloană din
tabel care nu poate fi NULL plus coloana pentru
prenumele angajatului
• Valorile pentru fiecare coloană trebuie listate în aceeași
ordine în care sunt listate coloanele

INSERT INTO employees (employee_id, first_name,
last_name, email, hire_date, job_id)
VALUES (305, 'Kareem', 'Naser',
'naserk@oracle.com', SYSDATE, 'SR_SA_REP');

• Când inserați un rând într-un tabel, trebuie să furnizați o
valoare pentru fiecare coloană, care nu poate fi NULL
• De asemenea, puteți insera noul angajat listând toate
coloanele din tabel și incluzând NULL în lista
de valori care nu sunt cunoscute în acest moment și pot
fi actualizate ulterior

INSERT INTO employees (employee_id, first_name, last_name,
email, phone_number, hire_date, job_id, salary,
commission_pct, manager_id, department_head)
VALUES (305, 'Kareem', 'Naser', 'naserk@oracle.com',
'111-222-3333',SYSDATE,'SR_SA_REP',7000,NULL,NULL,NULL);

INSERT Implicit Syntax

• O altă modalitate de a insera valori într-un tabel este de a le adăuga implicit
fără a lista numele coloanelor
• Valorile trebuie să corespundă ordinii în care coloanele
apar în tabel și trebuie furnizată o valoare pentru
fiecare coloană

INSERT INTO employees
VALUES (305, 'Kareem', 'Naser',
'naserk@oracle.com', '111-222-3333', SYSDATE,
'SR_SA_REP', 7000, NULL, NULL, NULL, NULL);

UPDATE
• Instrucțiunea UPDATE este utilizată pentru a modifica rândurile existente
într-un tabel
• Necesită cel puțin trei elemente:
−Numele tabelului
−Numele a cel puțin unei coloane de modificat
−O valoare pentru fiecare coloană modificată
−(Opțional) o clauză WHERE care identifică rândul sau rândurile care
trebuie modificate
−Dacă clauza WHERE este omisă, TOATE rândurile vor fi modificate
−Aveți mare grijă când rulați o instrucțiune UPDATE fără o
clauză WHERE!


UPDADTE Syntax

O singură coloană poate fi modificată
• Clauza WHERE identifică rândul care trebuie modificat
UPDATE employees
SET salary = 11000
WHERE employee_id = 176;

• O instrucțiune UPDATE poate modifica mai multe coloane
UPDATE employees
SET salary = 11000, commission_pct = .3
WHERE employee_id = 176;


DELETE
• Instrucțiunea DELETE se utilizează pentru a elimina rânduri existente
într-un tabel
• Instrucțiunea necesită cel puțin un element:
−Numele tabelului
−(Opțional) o clauză WHERE care identifică rândul sau rândurile care
trebuie șterse
• Rețineți că, dacă clauza WHERE este omisă, TOATE rândurile
vor fi șterse
• Fiți foarte atenți când executați o instrucțiune DELETE
fără o clauză WHERE
• Situațiile care necesită acest lucru vor fi rare

DELETE Syntax

Clauza WHERE identifică rândul sau rândurile care trebuie
șterse
DELETE FROM employees
WHERE employee_id = 149;
DELETE FROM employees
WHERE department_id = 80;

• Atenție la instrucțiunea DELETE
• Dacă clauza WHERE este omisă, TOATE rândurile vor fi
șterse
• Foarte puține situații vor necesita o instrucțiune DELETE
fără o clauză WHERE

MERGE
• Instrucțiunea MERGE va INSERTA un rând nou într-un
tabel țintă sau va ACTUALIZA date existente într-un tabel țintă,
pe baza unei comparații a datelor din cele două tabele
• Clauza WHEN determină acțiunea care trebuie întreprinsă
• De exemplu, dacă un anumit rând există în tabelul sursă,
dar nu există un rând corespunzător în tabelul țintă,
rândul din tabelul sursă va fi inserat în
tabelul țintă
• Dacă rândul corespunzător există în tabelul țintă,
dar unele date din tabelul sursă sunt diferite pentru acel rând,
tabelul țintă poate fi actualizat cu datele diferite

MERGE Usage and Syntax

Pentru a configura exemplul nostru MERGE, să luăm în considerare o situație
în care trebuie să calculăm bonusurile anuale pentru
angajații care câștigă mai puțin de 10.000 USD
• Mai întâi, creăm un tabel numit bonusuri

CREATE TABLE bonuses
(employee_id NUMBER(6,0) NOT NULL,
bonus NUMBER(8,2) DEFAULT 0);

Apoi populăm tabelul cu ID-urile tuturor angajaților cu un salariu mai mic de 10.000 USD.

INSERT INTO bonuses(employee_id)
(SELECT employee_id FROM employees
WHERE salary < 10000);

Fiecare angajat cu un salariu mai mic de 10.000 USD va primi
un bonus de 5% din salariul său
• Pentru a utiliza coloana salarii din tabelul angajaților pentru a
calcula valoarea bonusului și a actualiza
coloana bonusuri din tabelul bonusuri, folosim
următoarea instrucțiune MERGE

MERGE INTO bonuses b
USING employees e
ON (b.employee_id = e.employee_id)
WHEN MATCHED THEN
UPDATE SET b.bonus = e.salary * .05;