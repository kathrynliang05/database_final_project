# database_final_project

Final project for database class: a library database.

---

Kate Liang 

CS 4092 – Database Design / Development 

Dr. Hrishikesh Bhide 

# Requirements Document – Library Database 

 

The library database should support 2 main user roles: 

* Librarians: Responsible for checking out/returning books and movies, responsible for leading community activities, and responsible for maintaining the records/organization of the books/movies/CDs. 

* Visitors: Can check out and return books and movies, and can attend community events. 

There will be the following strong entities: 

* Librarian
  * Librarian ID
  * Name
  * Address (Street, City, State, Zip Code)
  * DOB
      * Derived: age 
  * Salary
  * Email (multi-value) 

* Visitor 
  * Visitor ID
  * Name
  * Address (Street, City, State, Zip Code)
  * DOB
  * Derived: age
  * Email (multi-value)
  * Fines 

* Book 
  * Book Call Number (Library of Congress Call Number)
  * Title
  * Author
  * Publishing Year
  * Status (checked out, to be shelved, available, missing)
  * Location (east shelves, west shelves, basement shelves) 

* Movie 
  * Movie Call Number (Library of Congress Call Number)
  * Title
  * Director
  * Release Year
  * Status (checked out, to be shelved, available, missing)
  * Location (east shelves, west shelves, basement shelves) 

* Community Activities 
  * Community Activity ID
  * Title
  * Description
  * Time
  * Date
  * Location
  * Librarian ID (Librarian leading the activity)
  * Capacity
  * Demographic

There will be the following relationships: 

* Customer checks out a book (Librarian checks them out) 
  * Also checks out Movie
* Customer returns a book (Librarian checks them in) 
  * Also returns Movie 
* Customer attends a Community Activity led by a Librarian 
* Books have a record of Customers who have checked them out previously 
* Movies have a record of Customers who have checked them out previously 
