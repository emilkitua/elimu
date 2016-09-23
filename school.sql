-- ROLES --
DROP TABLE roles CASCADE;
CREATE TABLE roles (
	role_id   serial PRIMARY KEY NOT NULL ,
	title 	  char(15)  NOT NULL CONSTRAINT unique_role_title UNIQUE CHECK ( title <> '')
);

-- USERS --
DROP TABLE users CASCADE;
CREATE TABLE  users (
	user_id 	char(15) NOT NULL CONSTRAINT userid PRIMARY KEY,
	password	text NOT NULL,
	name		char(50) NOT NULL,
	email		char(40) NOT NULL CONSTRAINT unique_user_email UNIQUE,
	phone		char(25) NOT NULL CONSTRAINT unique_user_phone UNIQUE,
	role		integer NOT NULL CONSTRAINT matches_role REFERENCES  roles( role_id ),
	time		timestamp DEFAULT CURRENT_TIMESTAMP,
	active		boolean DEFAULT true 
);

-- STREAMS --
DROP TABLE streams CASCADE;
CREATE TABLE streams (
	stream_id char(15) NOT NULL PRIMARY KEY	,
	active	  boolean DEFAULT true
);

-- LEVELS --
DROP TABLE levels CASCADE;
CREATE TABLE levels (
	level_id 	smallserial PRIMARY KEY,
	title		char(20) NOT NULL,
	active		boolean DEFAULT true
);

-- CLASSES --
DROP TABLE classes CASCADE;
CREATE TABLE classes (
	class_id	bigserial PRIMARY KEY NOT NULL,
	level 		smallint NOT NULL CONSTRAINT is_valid_level REFERENCES levels( level_id ),
	stream		char(15) NOT NULL CONSTRAINT is_valid_stream REFERENCES streams(stream_id),
	teacher 	char(15) NOT NULL CONSTRAINT is_existing_teacher REFERENCES users(user_id),
	active		boolean DEFAULT true,
	time		timestamp DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT class_not_repeated UNIQUE (level,stream),
	CONSTRAINT unique_class_teacher UNIQUE( level,stream,teacher )
);

-- PARENTS --
DROP TABLE parents CASCADE;
CREATE TABLE parents (
	parent_id	bigserial PRIMARY KEY NOT NULL,
	name		char(35) NOT NULL,
	username	char(15) NOT NULL CONSTRAINT unique_parent_username UNIQUE,
	password 	text NOT NULL,
	email		char(40) NOT NULL CONSTRAINT unique_parent_email UNIQUE,
	phone		char(25) NOT NULL CONSTRAINT unique_parent_phone UNIQUE,
	time		timestamp DEFAULT CURRENT_TIMESTAMP,
	active		boolean DEFAULT true
);

-- STUDENTS --
DROP TABLE students CASCADE;
CREATE TABLE students (
	student_id	char(15) PRIMARY KEY NOT NULL,
	f_name		char(35) NOT NULL,
	m_name		char(35) NOT NULL,
	l_name		char(35) NOT NULL,
	password	text NOT NULL,
	email		char(40) NOT NULL CONSTRAINT unique_student_email UNIQUE,
	class		bigint CONSTRAINT belongs_to_a_class REFERENCES classes( class_id ),
	parents     bigint[] DEFAULT '{}',
	parent1		bigint CONSTRAINT parent1_exists REFERENCES parents( parent_id ),
	parent2		bigint CONSTRAINT parent2_exists REFERENCES parents( parent_id ),
	active		boolean DEFAULT true,
	time		timestamp DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT parent_not_repeated CHECK ( parent1 <> parent2 )
);
CREATE index idx_parents ON students USING GIN(parents);

-- PASSMARKS --
DROP TABLE passmarks CASCADE;
CREATE TABLE passmarks (
	passmark_id smallserial	PRIMARY KEY NOT NULL,
	grade		text[] DEFAULT '{}'
);

-- COURSES --
DROP TABLE courses CASCADE;
CREATE TABLE courses (
	course_id		char(10) PRIMARY KEY NOT NULL,
	title			char(25) UNIQUE,
	frequency		smallint CONSTRAINT class_frequency_required NOT NULL,
	maxhours		smallint CONSTRAINT maxhours_required NOT NULL,
	minclass_level	smallint NOT NULL CONSTRAINT minimum_class_exists REFERENCES levels( level_id ),
	maxclass_level 	smallint NOT NULL CONSTRAINT maximum_class_level_exists REFERENCES levels( level_id ),
	excluded_class	bigint[] DEFAULT '{}',
	excluded_stream text[] DEFAULT '{}',
	passmark		integer	CONSTRAINT passmark_is_defined REFERENCES passmarks( passmark_id ),	
	time			timestamp DEFAULT CURRENT_TIMESTAMP,
	active			boolean DEFAULT true
);

-- DAYS --
DROP TABLE days CASCADE;
CREATE TABLE days (
	day_id		char(9) PRIMARY KEY NOT NULL	
);


-- TEACHERS --
DROP TABLE teachers CASCADE;
CREATE TABLE teachers (
	teacher_id char(15) NOT NULL CONSTRAINT teacher_exists REFERENCES users( user_id ),
	course	   char(10) NOT NULL CONSTRAINT course_exists REFERENCES courses( course_id ),
	maxload	   smallint,
	active	   boolean DEFAULT true,
	unavailable_days text[] DEFAULT '{}',
	CONSTRAINT unique_course_per_teacher UNIQUE( teacher_id, course )
);

-- TERMS --
DROP TABLE terms CASCADE;
CREATE TABLE terms (
	term_id 	bigserial PRIMARY KEY NOT NULL,
	title		char(45) NOT NULL,
	year		integer	NOT NULL,
	active		boolean DEFAULT true,
	time		timestamp DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT unique_term UNIQUE( title,year )	
);


-- TIMES --
DROP TABLE times CASCADE;
CREATE TABLE times (
	time_id		smallserial	PRIMARY KEY NOT NULL,
	time_start	integer NOT NULL CONSTRAINT start_time_defined CHECK ( time_start > 0 ),
	time_stop	integer NOT NULL CONSTRAINT end_after_start CHECK ( time_stop > time_start ),
	day			char(9) NOT NULL CONSTRAINT is_valid_day REFERENCES days( day_id ),
	active		boolean DEFAULT true
);

-- ONGOING_COURSES --
DROP TABLE ongoing_courses CASCADE;
CREATE TABLE ongoing_courses (
	ongoing_course_id	bigserial PRIMARY KEY NOT NULL,
	course				char(10) NOT NULL CONSTRAINT course_exists REFERENCES courses( course_id ),
	teacher				char(15) NOT NULL CONSTRAINT teacher_exists REFERENCES users( user_id ),
	course_time			integer NOT NULL CONSTRAINT course_time_is_valid REFERENCES times( time_id ),
	term				bigint	NOT NULL CONSTRAINT belongs_to_a_term REFERENCES terms( term_id ),
	class				integer NOT NULL CONSTRAINT belongs_to_a_class REFERENCES classes( class_id ),
	time				timestamp DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT unique_teacher_time_term UNIQUE( teacher,course_time,term ),
	CONSTRAINT unique_time_term_class UNIQUE( course_time,term,class )
);

-- COURSE_ENROLLMENTS --
DROP TABLE course_enrollments CASCADE;
CREATE TABLE course_enrollments (
	course_enrollment_id 	bigserial PRIMARY KEY NOT NULL,
	student 				char(15) NOT NULL CONSTRAINT valid_student_enrolled REFERENCES students( student_id ),
	course 					char(10) NOT NULL CONSTRAINT valid_course_enrolled REFERENCES courses( course_id ),
	time					timestamp DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT course_not_repeated UNIQUE( student,course )
);

-- TESTS --
DROP TABLE tests CASCADE;
CREATE TABLE tests (
	test_id 	smallserial PRIMARY KEY,
	title 		char(40) NOT NULL UNIQUE,
	active		boolean DEFAULT true
);

-- GRADES --
DROP TABLE grades CASCADE;
CREATE TABLE grades (
	grade_id		bigserial PRIMARY KEY,
	student			char(15) NOT NULL CONSTRAINT valid_student_graded REFERENCES students( student_id ),
	ongoing_course	bigint NOT NULL CONSTRAINT valid_ongoing_course REFERENCES ongoing_courses( ongoing_course_id ),
	marks			smallint DEFAULT 0,
	test			smallint NOT NULL CONSTRAINT valid_test_defined REFERENCES tests( test_id ),
	time			timestamp DEFAULT CURRENT_TIMESTAMP,
	recorded_by		char(15) NOT NULL CONSTRAINT valid_teacher REFERENCES users( user_id ),
	CONSTRAINT prevent_multiple_marks UNIQUE( student,ongoing_course,test )		 	
);

-- SCHOOL_DETAILS --
DROP TABLE school_details CASCADE;
CREATE TABLE school_details (
	school_name 	char(150) NOT NULL,
	motto 			text NULL,
	logo 			text NULL,
	head			char(15) CONSTRAINT valid_head_of_school REFERENCES users( user_id ),   
	deputy			char(15) CONSTRAINT valid_deputy_of_school REFERENCES users( user_id ),  
	mission			text,
	grading		    text[] DEFAULT '{}',
	time			timestamp DEFAULT CURRENT_TIMESTAMP
); 

-- STUDENT HISTORY
DROP TABLE student_history CASCADE;
CREATE TABLE student_history (
	student_history_id		bigserial PRIMARY KEY NOT NULL,
	student 				char(15) CONSTRAINT student_history REFERENCES students( student_id ),
	content					text NOT NULL,
	recorded_by				char(15) CONSTRAINT history_recorded_by REFERENCES users( user_id ),
	time		timestamp DEFAULT CURRENT_TIMESTAMP
);

-- MESSAGES --
DROP TABLE messages CASCADE;
CREATE TABLE messages (
	message_id	bigserial PRIMARY KEY,
	tutor		char(15) CONSTRAINT tutor_id REFERENCES users( user_id ),
	parent		bigint CONSTRAINT parent_id REFERENCES parents( parent_id ),
	messages	text NOT NULL,
	time		timestamp DEFAULT CURRENT_TIMESTAMP
);

-- -- -- VIEWS -- -- --

-------------------------------------------------------------------------------------------------------------------------------------------------

-- CLASSES **active
CREATE OR REPLACE VIEW vw_classes AS
SELECT classes.class_id, levels.title AS level , streams.stream_id AS stream, users.name  AS teacher, classes.active
	FROM classes 
	JOIN levels 
		ON classes.level = levels.level_id
	JOIN streams 
		ON classes.stream = streams.stream_id
	JOIN users
		ON classes.teacher = users.user_id;
	
-------------------------------------------------------------------------------------------------------------------------------------------------

-- STUDENTS **active
CREATE OR REPLACE VIEW vw_students AS 
SELECT students.student_id, students.f_name,students.m_name,students.l_name, students.email, levels.title AS level, classes.stream, users.name AS teacher,
 students.parent1, p1.name AS parent1_name, p1.email AS parent1_email,  p1.phone AS parent1_phone,
 --students.parent2, p2.name AS parent2_name, p2.email AS parent2_email,  p2.phone AS parent2_phone,
 students.active
	FROM 
	( SELECT parents.name AS name, parents.email AS email, parents.phone AS phone FROM students JOIN parents ON students.parent1 = parents.parent_id ) p1, 
	--( SELECT parents.name AS name, parents.email AS email, parents.phone AS phone  FROM students JOIN parents ON students.parent2 = parents.parent_id ) p2,
	
	students
	JOIN classes
		ON  students.class = classes.class_id
	JOIN users
		ON classes.teacher = users.user_id
	JOIN parents
		ON students.parent1 = parents.parent_id OR students.parent2 = parents.parent_id
	JOIN levels
		ON classes.level = levels.level_id;

-------------------------------------------------------------------------------------------------------------------------------------------------
	
-- COURSES **active
CREATE OR REPLACE VIEW vw_courses AS
SELECT courses.course_id, courses.title, 
(SELECT levels.title AS minclass FROM levels WHERE courses.minclass_level = levels.level_id ),
(SELECT levels.title AS maxclass FROM levels WHERE courses.maxclass_level = levels.level_id ),
courses.excluded_class, courses.excluded_stream, passmarks.grade  AS grading , courses.frequency, courses.maxhours,
courses.active
FROM courses
JOIN passmarks
	ON courses.passmark = passmarks.passmark_id; 



-------------------------------------------------------------------------------------------------------------------------------------------------

-- TEACHERS **active
CREATE OR REPLACE VIEW vw_teachers AS
SELECT teachers.teacher_id, users.name, courses.course_id AS course, courses.title AS course_title, teachers.maxload, teachers.unavailable_days, teachers.active
	FROM teachers
	JOIN users
		ON teachers.teacher_id = users.user_id
	JOIN courses
		ON teachers.course = courses.course_id;
		
-------------------------------------------------------------------------------------------------------------------------------------------------

-- ONGOING COURSES **active
CREATE OR REPLACE VIEW vw_ongoing_courses AS
SELECT ongoing_courses.ongoing_course_id, users.name AS teacher, courses.course_id, courses.title AS course, 
levels.title AS level , classes.stream, times.time_start, times.time_stop, times.day, terms.title AS term, terms.year AS year, terms.active
	FROM ongoing_courses
	JOIN courses 
		ON ongoing_courses.course = courses.course_id
	JOIN users
		ON ongoing_courses.teacher = users.user_id
	JOIN terms 
		ON ongoing_courses.term = terms.term_id 
	JOIN classes
		ON ongoing_courses.class = classes.class_id
	JOIN levels
		ON classes.level = levels.level_id
	JOIN times 
		ON ongoing_courses.course_time = times.time_id;

-------------------------------------------------------------------------------------------------------------------------------------------------

-- COURSE ENROLLMENT **active
CREATE OR REPLACE VIEW vw_course_enrollments AS
SELECT students.student_id, students.f_name,students.m_name,students.l_name, courses.course_id AS course, courses.title AS course_title, 
levels.title AS level, classes.stream, 
users.name AS teacher, students.active
	FROM course_enrollments
	JOIN students 
		ON course_enrollments.student = students.student_id
	JOIN courses
		ON course_enrollments.course = courses.course_id
	JOIN classes
		ON students.class = classes.class_id
	JOIN levels
		ON classes.level = levels.level_id
	JOIN users
		ON classes.teacher = users.user_id;
	
-------------------------------------------------------------------------------------------------------------------------------------------------

-- GRADES **term **active
CREATE OR REPLACE VIEW vw_grades AS
SELECT grades.grade_id , students.student_id, students.f_name,students.m_name,students.l_name, 
courses.course_id, courses.title AS course, grades.marks AS grade, users.user_id AS teacher_id, users.name AS teacher,
terms.title as term, terms.year, grades.recorded_by, grades.time, passmarks.grade AS grading, students.active
	FROM grades
	JOIN students 
		ON grades.student = students.student_id
	JOIN ongoing_courses
		ON grades.ongoing_course = ongoing_courses.ongoing_course_id
	JOIN courses
		ON ongoing_courses.course = courses.course_id
	JOIN passmarks 
		ON courses.passmark = passmarks.passmark_id
	JOIN users
		ON ongoing_courses.teacher	= users.user_id
	JOIN terms
		ON ongoing_courses.term = terms.term_id;
	
-------------------------------------------------------------------------------------------------------------------------------------------------

-- PARENTS **active
CREATE OR REPLACE VIEW vw_parents AS 
SELECT parents.parent_id, parents.name, parents.email, parents.phone, students.student_id, students.f_name,students.m_name,students.l_name, levels.title AS level, classes.stream AS stream, students.active
	FROM parents 
	JOIN students 
		ON students.parent1 = parents.parent_id OR students.parent2 = parents.parent_id
	JOIN classes
		ON  students.class = classes.class_id
	JOIN levels 
		ON classes.level = levels.level_id;
		
-------------------------------------------------------------------------------------------------------------------------------------------------
