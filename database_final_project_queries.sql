-- Part 5: SQL Queries
-- Write at least 3 SQL queries, with at least one multi-table query. 
-- Example: Show the names of customers along with the names of the products they purchased where product price > $100.

-- Query 1: Create a table of all missing books and the people who checked them out last
-- Display book title, visitor first/last name, check out date
-- Multi table: missing_items (VIEW), visitor, book_records

	SELECT mi.title, v.f_name, v.l_name, br.date_time_out
	FROM missing_items AS mi
	JOIN book_records AS br
	ON mi.call_number = br.book_call_number
	JOIN visitor AS v
	ON br.visitor_id = v.visitor_id
	WHERE item_type = 'Book';

-- Query 2: Create a table that displays the names of the librarians facilitating
-- 		community activities
-- Display community activity name, librarian first name/last name
-- multi table: librarian, community_activity

	SELECT ca.title, l.f_name, l.l_name
	FROM community_activity AS ca
	JOIN librarian AS l
	ON ca.librarian_id = l.librarian_id;

-- Query 3: Create a table of all movies checked out
-- Display movie title, visitor first name/last name, checkout date
-- Multi table: Visitor, movie, Movie_records

	SELECT m.title, v.f_name, v.l_name, mr.date_time_out
	FROM (
		SELECT *
		FROM movie
		WHERE status = 'Checked Out'
	) as m
	JOIN movie_records AS mr
	ON m.movie_call_number = mr.movie_call_number
	JOIN visitor AS v
	ON mr.visitor_id = v.visitor_id;


