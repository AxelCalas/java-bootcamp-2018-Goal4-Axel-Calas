mysql -r -s -u root -ppassword;

DROP DATABASE IF EXISTS highSchoolDb; 
CREATE DATABASE highSchoolDb;
USE highSchoolDb;

-- Create T
CREATE TABLE Student (
    registration_num SMALLINT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birthdate CHAR(10), 
    PRIMARY KEY (registration_num)
);

CREATE TABLE Teacher (
    id SMALLINT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    birthdate CHAR(10),
    PRIMARY KEY (id)
);

CREATE TABLE Course (
    course_id SMALLINT NOT NULL AUTO_INCREMENT,
    course_name VARCHAR(30), 
    assigned_teacher SMALLINT, 
    hours_by_week INT, 
    schedule_time VARCHAR(10),
    PRIMARY KEY (course_id),
    FOREIGN KEY (assigned_teacher) REFERENCES Teacher (id)
);

CREATE TABLE Stud_Course (
    registration_num1 SMALLINT,
    course_id1 SMALLINT,
    note1 SMALLINT,
    note2 SMALLINT,
    note3 SMALLINT,
    final_note SMALLINT,
    FOREIGN KEY (registration_num1) REFERENCES Student (registration_num),
    FOREIGN KEY (course_id1) REFERENCES Course (course_id)
);   

CREATE TABLE Weekly_Diagram(
    num_index INT NOT NULL AUTO_INCREMENT,
    course_id2 SMALLINT,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'),
    start_time TIME,
    ending_time TIME,
    PRIMARY KEY (num_index),
    FOREIGN KEY (course_id2) REFERENCES Course (course_id)
);


-- Insert values in tables.

INSERT INTO Student (first_name,last_name,birthdate) VALUES
    ('Jared','Johnson','12/26/1985'),
    ('Phillip','Bynum','01/09/1992'),
    ('Lorenzo','Torres','06/01/1996'),
    ('Marco','Cerutti','05-08-1999'),
    ('Valeria','Cuaranta','27-12-1997'),
    ('Tania','Aguirre','29-06-1984'),
    ('Julieta','Koch','21-12-1986'),
    ('Hector','Contreras','13-11-1986'),
    ('Amir','Eujanian','31-08-1983'),
    ('Abigail','Antinori','16-11-1999'),
    ('Rocio','Marquez','16-04-1984'),
    ('Natalia','Salani','11-03-1992'),
    ('Juan','Pomares','25-12-1996'),
    ('Milena','Albiero','20-10-1983'),
    ('Melina','Castro','23-07-1982'),
    ('Juan Cruz','Gandia','06-04-1995'),
    ('Fernando','Dualhde','22-01-1980'),
    ('Roberto','Conti','13-09-1983'),
    ('Daniel','Layus','06-11-1983'),
    ('Mario','Gattas','21-06-1987');

INSERT INTO Teacher (first_name,last_name,birthdate) VALUES
    ('Pablo','Martinez','06/01/1968'),
    ('Roberto','Gutierrez','26/12/1985'),
    ('Hernan','Gutierrez','22/11/1974'),
    ('Roberto','Perez','06/01/1958'),
    ('Florencia','Cabrera','12/10/1979');
    

INSERT INTO Course (course_name,assigned_teacher,hours_by_week,schedule_time) VALUES
    ('Fisica',1,4,'Anual'),
    ('Matematica',1,4,'Anual'),
    ('Informatica',2,6,'Semestral'),
    ('Algebra',3,6,'Semestral'),
    ('Analisis Matematico',4,8,'Semestral');

INSERT INTO Stud_Course (registration_num1,course_id1,note1,note2,note3,final_note) VALUES
    (1,1,9,4,6,7),
    (2,1,4,7,8,6),
    (3,1,5,4,7,6),
    (4,1,3,8,9,7),
    (5,1,9,7,8,7),
    (6,1,7,7,5,6),
    (7,1,9,8,10,9),
    (8,1,6,5,8,6),
    (9,1,7,6,7,7),
    (10,1,8,9,9,9),
    (1,2,3,6,4,5),
    (5,2,6,7,8,7),
    (6,2,9,9,8,9),
    (9,2,10,8,7,8),
    (10,2,9,4,6,7),
    (11,2,8,6,9,8),
    (12,2,4,6,7,6),
    (13,2,4,6,6,6),
    (14,2,6,7,7,7),
    (15,2,2,9,4,5),
    (2,3,9,4,6,7),
    (3,3,9,8,10,9),
    (6,3,3,6,4,5),
    (9,3,6,7,8,7),
    (11,3,9,9,8,9),
    (16,3,6,7,7,7),
    (17,3,7,6,6,7),
    (16,3,10,8,7,8),
    (19,3,4,6,7,6),
    (20,3,9,9,9,9);

INSERT INTO Weekly_Diagram (course_id2,day_of_week,start_time,ending_time) VALUES
    (1,'Monday','08:00:00','12:00:00'),
    (1,'Monday','12:00:00','16:30:00'),
    (2,'Tuesday','08:00:00','12:00:00'),
    (2,'Wednesday','13:00:00','15:00:00'),
    (3,'Thursday','08:00:00','12:00:00'),
    (3,'Friday','13:00:00','17:00:00');
    

--Print Students and Teacher from each Curses

DELIMITER $$
DROP PROCEDURE IF EXISTS print_courses_teacher_students$$
CREATE PROCEDURE print_courses_teacher_students()
BEGIN
  DECLARE str VARCHAR(50);
  DECLARE str2 VARCHAR(50);
  DECLARE x SMALLINT;
  DECLARE cantCourses SMALLINT;
 
  SET cantCourses = (SELECT count(course_id) FROM Course);
  SET x = 1;
 
  WHILE x <= cantCourses DO 
    SET str = (SELECT course_name FROM Course WHERE course_id = x);
    SET str = CONCAT('Course: ',str);
    SELECT str AS '';
 
    SET str = (SELECT last_name FROM Course
               INNER JOIN Teacher ON Course.assigned_teacher = id WHERE course_id = x);
    SET str2 = (SELECT first_name FROM Course
               INNER JOIN Teacher ON Course.assigned_teacher = id WHERE course_id = x);
    SET str = CONCAT('Teacher: ',str,', ',str2);
    SELECT str AS '';

    SET str = 'Students: ';
    SELECT str AS '';
    SELECT last_name AS '', first_name AS '' FROM Stud_Course 
        INNER JOIN Student ON Stud_Course.registration_num1 = registration_num 
        WHERE course_id1 = x ORDER BY last_name;
        
    SET x = x+1;
  END WHILE;
END$$
DELIMITER ;


-- Print percentage of students that passed/failed a given cours

DELIMITER $$
DROP PROCEDURE IF EXISTS print_percentage_passed_failed$$
CREATE PROCEDURE print_percentage_passed_failed()
BEGIN
  DECLARE str VARCHAR(50);
  DECLARE cant INT;
  DECLARE x SMALLINT;
  DECLARE cantStudents SMALLINT;
  DECLARE cantCourses SMALLINT;
 
  SET cantCourses = (SELECT count(course_id) FROM Course);
  SET x = 1;
 
  WHILE x <= cantCourses DO 
    SET str = (SELECT course_name FROM Course WHERE course_id = x);
    SET str = CONCAT('Course: ',str);
    SELECT str AS '';
    
    SET cantStudents = (SELECT count(registration_num1) FROM Stud_Course WHERE course_id1 = x);
    SET cant = (SELECT count(final_note) FROM Stud_Course WHERE (course_id1 = x AND final_note >=6));
    SET cant = (cant*100)/cantStudents;
    SET str = CONCAT('% ',cant);
    SELECT str AS 'Passed';
    
    SET cant = (SELECT count(final_note) FROM Stud_Course WHERE (course_id1 = x AND final_note <6));
    SET cant = (cant*100)/cantStudents;
    SET str = CONCAT('% ',cant);
    SELECT str AS 'Failed';
    
    SET x = x+1;
  END WHILE;
END$$
DELIMITER ;


-- Print teacher schedules

DELIMITER $$
DROP PROCEDURE IF EXISTS print_teachers_schedules$$
CREATE PROCEDURE print_teachers_schedules()
BEGIN
  DECLARE x SMALLINT;
  DECLARE y SMALLINT;
  DECLARE cantCourses SMALLINT;
  DECLARE cantDays SMALLINT;
 
  SET cantCourses = (SELECT DISTINCT count(course_id2) FROM Weekly_Diagram );
  SET x = 1;
 
  WHILE x <= cantCourses DO 
    SET CantDays = (SELECT count(num_index) FROM Weekly_Diagram WHERE course_id2 = x);
    WHILE y <= CantDays DO
        SET str = (SELECT TOP day_of_week FROM Weekly_Diagram WHERE course_id2 = x);
    
    END WHILE;
    
  END WHILE;  
    
    SET str = CONCAT('Course: ',str);
    SELECT str AS '';
    
    SET cantStudents = (SELECT count(registration_num1) FROM Stud_Course WHERE course_id1 = x);
    SET cant = (SELECT count(final_note) FROM Stud_Course WHERE (course_id1 = x AND final_note >=6));
    SET cant = (cant*100)/cantStudents;
    SET str = CONCAT('% ',cant);
    SELECT str AS 'Passed';
    
    SET cant = (SELECT count(final_note) FROM Stud_Course WHERE (course_id1 = x AND final_note <6));
    SET cant = (cant*100)/cantStudents;
    SET str = CONCAT('% ',cant);
    SELECT str AS 'Failed';
    
    SET x = x+1;
  END WHILE;
END$$
DELIMITER ;