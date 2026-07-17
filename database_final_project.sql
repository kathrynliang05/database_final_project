-- -----------------------------------------------------------
-- LIBRARIAN
-- -----------------------------------------------------------
-- Librarian Table
CREATE TABLE IF NOT EXISTS librarian(
	librarian_id INT PRIMARY KEY,
	f_name VARCHAR(200) NOT NULL,
	l_name VARCHAR(200) NOT NULL,
	street VARCHAR(200) NOT NULL,
	city VARCHAR(100) NOT NULL,
	"state" VARCHAR(2) NOT NULL,
	zip VARCHAR(5) NOT NULL,
	DOB VARCHAR(10) NOT NULL,
	salary NUMERIC(8,2) CHECK (salary >= 0)
);

-- Librarian Insert Statements
INSERT INTO librarian(librarian_id,f_name, l_name, street, city, "state", zip, DOB, salary)
	VALUES(123, 'Kate', 'Liang', '12 Oak Street', 'Cleveland', 'OH', '44113', '01/01/2001', 65000);
INSERT INTO librarian(librarian_id,f_name, l_name, street, city, "state", zip, DOB, salary)
	VALUES(145, 'Suzanne', 'Bratt', '321 McMillan', 'Cincinnati', 'OH', '45219', '08/20/1989', 81000);

-- -----------------------------------------------------------
-- VISITOR
-- -----------------------------------------------------------
-- Visitor Table
CREATE TABLE IF NOT EXISTS visitor(
	visitor_id INT PRIMARY KEY,
	f_name VARCHAR(200) NOT NULL,
	l_name VARCHAR(200) NOT NULL,
	street VARCHAR(200) NOT NULL,
	city VARCHAR(100) NOT NULL,
	"state" VARCHAR(2) NOT NULL,
	zip VARCHAR(5) NOT NULL,
	DOB VARCHAR(10) NOT NULL,
	fines NUMERIC(6,2) CHECK (fines >= 0)
);

-- Visitor Insert Statements
INSERT INTO visitor(visitor_id,f_name, l_name, street, city, "state", zip, DOB, fines)
	VALUES(1115, 'Sally', 'Reads', '9 Beech Court', 'Cincinnati', 'OH', '45219', '12/11/2015', 0),
		(1116, 'Mary', 'Reads', '9 Beech Court', 'Cincinnati', 'OH', '45219', '03/19/1976', 1.50),
		(1129, 'Joseph', 'Liang', '14 Buckeye Street', 'Cleveland', 'OH', '44113', '11/01/1999', 11.20);
		

-- STATUS to be used in BOOK and MOVIE
--executed
CREATE TYPE status AS ENUM ('Available', 'Checked Out', 'Missing', 'To Be Shelved');

-- SHELF_LOCATION to be used in BOOK and MOVIE
--executed
CREATE TYPE shelf_location AS ENUM ('Basement Shelves', 'East Shelves', 'West Shelves');

-- LOCATION to be used in COMMUNITY_ACTIVITY
--executed
CREATE TYPE "location" AS ENUM ('Basement Lounge', 'East Kitchen Room', 'Front Children''s Room');


-- -----------------------------------------------------------
-- BOOK
-- -----------------------------------------------------------
-- Book Table
CREATE TABLE IF NOT EXISTS book (
	book_call_number VARCHAR(50) PRIMARY KEY,
	title VARCHAR(300) NOT NULL,
	author VARCHAR(300) NOT NULL,
	publishing_year INT NOT NULL,
	"status" status NOT NULL DEFAULT 'Available',
	"shelf_location" shelf_location NOT NULL DEFAULT 'Basement Shelves'
);

-- Book Insert Statements
INSERT INTO book(book_call_number, title, author, publishing_year, "status", "shelf_location")
	VALUES('PR6113.I2645 S55 2019', 'The Silent Patient', 'Alex Michaelides', 2019, 'Checked Out', 'East Shelves'),
		('PS8635.E33', 'Heated Rivalry', 'Rachel Reid', 2019, 'Available', 'West Shelves'),
		('PS3613.C4365 N48 2023', 'Never Lie', 'Freida McFadden', 2023, 'To Be Shelved', 'Basement Shelves'),
		('PS3562.O78745', 'The Dangers of Deceiving a Viscount', 'Julia London', 2007, 'Missing', 'West Shelves'),
		('PS3605.M36 E34 2023', 'The Edge of Sleep', 'Jake Emanuel', 2023, 'Available', 'Basement Shelves');



-- -----------------------------------------------------------
-- MOVIE
-- -----------------------------------------------------------
-- Movie Table
CREATE TABLE IF NOT EXISTS movie (
	movie_call_number VARCHAR(50) PRIMARY KEY,
	title VARCHAR(300) NOT NULL,
	director VARCHAR(300) NOT NULL,
	release_year INT NOT NULL,
	"status" status NOT NULL DEFAULT 'Available',
	"shelf_location" shelf_location NOT NULL DEFAULT 'Basement Shelves'
);

-- Movie Insert Statements
INSERT INTO movie(movie_call_number, title, director, release_year, "status", "shelf_location")
	VALUES('CGD 3928-3932', 'Spy Kids', 'Robert Rodriguez', 2001, 'Available', 'Basement Shelves'),
		('CGD 9606-9612', 'Brokeback Mountain', 'Ang Lee', 2005, 'Checked Out', 'West Shelves'),
		('DVE 6045', 'The Shining', 'Stanley Kubrick', 1980, 'Missing', 'East Shelves'),
		('DVE 7448', 'Who Framed Roger Rabbit', 'Robert Zemeckis', 1988, 'To Be Shelved', 'Basement Shelves'),
		('VAC 1193', 'Paris is Burning', 'Jennie Livingston', 1990, 'Checked Out', 'West Shelves');


-- -----------------------------------------------------------
-- COMMUNITY ACTIVITY
-- -----------------------------------------------------------
-- Community_Activity Table
CREATE TABLE IF NOT EXISTS community_activity (
	community_activity_id INT PRIMARY KEY,
	title VARCHAR(300) NOT NULL,
	description VARCHAR(500) NOT NULL,
	date_time TIMESTAMPTZ DEFAULT NOW(),
	"location" "location" NOT NULL DEFAULT 'Front Children''s Room',
	"librarian_id" INT NOT NULL,
	capacity INT NULL CHECK (capacity > 0),
	demographic VARCHAR(100),

	FOREIGN KEY ("librarian_id") REFERENCES librarian(librarian_id)
);

-- Community_Activity Insert Statements
INSERT INTO community_activity(community_activity_id, title, description, date_time, "location", "librarian_id", capacity, demographic)
	VALUES(88092, 'Reading is Fun!', 'Learn to read with head librarian, Suzanne Bratt, with fun stories such as The Rainbow Fish, Goodnight Moon, and The Very Hungry Caterpillar!',
		'2026-12-15 10:00:00', 'Front Children''s Room', 145, 18, 'Ages 1-4'),
	(99082, 'Greek Mythology: Becoming Heros', 'Calling all Percy Jackson fans!  Let''s get to know his godly family with the help of Percy and friends and D''Aulaires'' Book of Greek Myths.',
		'2026-12-15 15:00:00', 'Basement Lounge', 123, 14, 'Ages 9-13'),
	(99093, 'Learning to Play Majong: Come Learn!', 'Come learn to play Majong with us!  Anyone of any skill level is welcome.',
		'2026-11-13 08:30:00', 'East Kitchen Room', 145, 10, 'Ages 25+');


-- -----------------------------------------------------------
-- SECONDARY TABLES
-- -----------------------------------------------------------

-- Librarian_Emails
CREATE TABLE IF NOT EXISTS librarian_emails (
	"librarian_id" INT,
	email VARCHAR(200) NOT NULL UNIQUE,

	PRIMARY KEY ("librarian_id", email),
	FOREIGN KEY ("librarian_id") REFERENCES librarian(librarian_id)
);

-- Librarian Emails Insert Statements
INSERT INTO librarian_emails(librarian_id, email)
	VALUES(123, 'kate@gmail.com'),
		(123, 'kate@hotmail.com'),
		(145, 'sbratt@gmail.com');


-- Visitor_Emails
CREATE TABLE IF NOT EXISTS visitor_emails (
	"visitor_id" INT,
	email VARCHAR(200) NOT NULL UNIQUE,

	PRIMARY KEY ("visitor_id", email),
	FOREIGN KEY ("visitor_id") REFERENCES visitor(visitor_id)
);

-- Visitor Emails Insert Statements
--not executed yet
INSERT INTO visitor_emails(visitor_id, email)
	VALUES(1115, 'tempemail@roadrunner.com'),
		(1116, 'mom2010@roadrunner.com'),
		(1129, 'jj1199@gmail.com'),
		(1129, 'jjwork@workplace.com');


-- Book_Records
CREATE TABLE IF NOT EXISTS book_records (
	"book_call_number" VARCHAR(50),
	"visitor_id" INT,
	date_time_out TIMESTAMPTZ DEFAULT NOW(),
	librarian_id_check_out INT NOT NULL,
	date_time_returned TIMESTAMPTZ,
	librarian_id_return INT,

	PRIMARY KEY ("book_call_number", "visitor_id", date_time_out),
	FOREIGN KEY ("book_call_number") REFERENCES book(book_call_number),
	FOREIGN KEY ("visitor_id") REFERENCES visitor(visitor_id),
	FOREIGN KEY (librarian_id_check_out) REFERENCES librarian(librarian_id),
	FOREIGN KEY (librarian_id_return) REFERENCES librarian(librarian_id)
);

-- Book Records Insert Statements
INSERT INTO book_records(book_call_number, visitor_id, date_time_out, librarian_id_check_out, date_time_returned, librarian_id_return)
	VALUES('PS3562.O78745', 1116, '2026-11-24 14:02:00', 123, NULL, NULL),
		('PS3613.C4365 N48 2023', 1116, '2026-11-24 14:04:00', 123, '2026-11-26 11:02:00', 145),
		('PS3605.M36 E34 2023', 1129, '2026-10-01 13:41:00', 145, '2026-10-10 08:51:00', 145),
		('PS8635.E33', 1116, '2023-01-03 15:33:00', 145, NULL, NULL);


-- Movie_Records
CREATE TABLE IF NOT EXISTS movie_records (
	"movie_call_number" VARCHAR(50),
	"visitor_id" INT,
	date_time_out TIMESTAMPTZ DEFAULT NOW(),
	librarian_id_check_out INT NOT NULL,
	date_time_returned TIMESTAMPTZ,
	librarian_id_return INT,
	
	PRIMARY KEY ("movie_call_number", "visitor_id", date_time_out),
	FOREIGN KEY ("movie_call_number") REFERENCES movie(movie_call_number),
	FOREIGN KEY ("visitor_id") REFERENCES visitor(visitor_id),
	FOREIGN KEY (librarian_id_check_out) REFERENCES librarian(librarian_id),
	FOREIGN KEY (librarian_id_return) REFERENCES librarian(librarian_id)
);

-- Movie Records Insert Statements
INSERT INTO movie_records(movie_call_number, visitor_id, date_time_out, librarian_id_check_out, date_time_returned, librarian_id_return)
	VALUES('CGD 9606-9612', 1129, '2026-10-01 11:00:00', 145, NULL, NULL),
		('CGD 3928-3932', 1115, '2026-11-24 14:06:00', 123, '2026-11-29 13:13:00', 145),
		('DVE 7448', 1115, '2026-11-24 14:05:00', 123, '2026-11-29 15:02:00', 123),
		('DVE 6045', 1116, '2021-02-05 09:01:00', 145, NULL, NULL),
		('VAC 1193', 1115, '2026-11-24 14:05:00', 123, NULL, NULL);

-- Activity_Attendance
CREATE TABLE IF NOT EXISTS activity_attendance (
	"community_activity_id" INT,
	"visitor_id" INT,

	PRIMARY KEY ("community_activity_id", "visitor_id"),
	FOREIGN KEY ("community_activity_id") REFERENCES community_activity(community_activity_id),
	FOREIGN KEY ("visitor_id") REFERENCES visitor(visitor_id)
);

-- Activity Attendance Insert Statements
INSERT INTO activity_attendance(community_activity_id, visitor_id)
	VALUES(99093, 1129),
		(99082, 1115),
		(99082, 1116),
		(88092, 1116);


-- VIEWS

-- View with all missing books and movies
CREATE OR REPLACE VIEW missing_items AS
	SELECT 
	    book_call_number AS call_number,
	    title,
	    author AS creator,
	    publishing_year AS release_or_pub_year,
	    status,
	    shelf_location,
	    'Book' AS item_type
	FROM book
	WHERE status = 'Missing'
	
	UNION ALL
	
	SELECT 
	    movie_call_number AS call_number,
	    title,
	    director AS creator,
	    release_year AS release_or_pub_year,
	    status,
	    shelf_location,
	    'Movie' AS item_type
	FROM movie
	WHERE status = 'Missing';



