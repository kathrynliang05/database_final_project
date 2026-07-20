# Database Final Project
# Part 5: Database Interaction, Business Logic

# Based on code from: https://www.geeksforgeeks.org/postgresql/how-to-connect-and-run-sql-queries-to-a-postgresql-database-from-python/

''''
Menu options:
✔ 1) View all librarian information - here will also have emails printed
✔ 2) View all visitor information - here will also have emails printed
✔ 3) View individual visitor records
    If choosing, another menu will pop up with a list of names and id's
    Admin must enter an ID to see all information for that visitor
    Information includes:
        Currently checked out/missing books
        Previously returned books
        Currently checked out/missing movies
        Previously returned movies
        Activities the visitor has signed up for
4) View community activities
    Will print a list of all activities and their information
✔ 5) Quit
'''

import psycopg2
import textwrap

conn = None
try:
    # connect to the PostgreSQL server
    print('Connecting to the PostgreSQL database...')
    conn = psycopg2.connect(
        host = 'localhost',
        #dbname = 'FPostgreSQL 18',
        dbname = 'library_final_project',
        user = 'postgres',
        password = 'Lia@Pos9453',
        port = 5432
    )

    active = True

    while active:
        print()
        print()
        print("Welcome to the Administrator Library Management System!")
        print()
        print("Please select an option:")
        print("1. View all librarians")
        print("2. View all visitors")
        print("3. View individual visitor records")
        print("4. View community activities")
        print("5. Quit")
        choice = input("Enter your choice (1, 2, 3, 4, or 5): ")

        if choice == '1': # View all librarian information
            # Execute a query to view all librarians
            cur = conn.cursor()
            cur.execute('SELECT * FROM librarian;')
            records = cur.fetchall()

            print(
                f'{"ID":<5} | {"FName":<12} | {"LName":<12} | '
                f'{"Street":<20} | {"City":<15} | {"State":<8} | '
                f'{"Zip":<10} | {"DOB":<12} | {"Salary":<10}'
            )
            print("-" * 132)

            for row in records:
                print(
                    f'{row[0]:<5} | {row[1]:<12} | {row[2]:<12} | '
                    f'{row[3]:<20} | {row[4]:<15} | {row[5]:<8} | '
                    f'{row[6]:<10} | {str(row[7]):<12} | {row[8]:>10}'
                )

            #Print out a separate email table for librarians
            cur.execute('SELECT f_name, l_name, librarian_emails.email, email FROM librarian_emails JOIN librarian ON librarian_emails.librarian_id = librarian.librarian_id;')
            records = cur.fetchall()

            print()
            print("Librarian Emails:")
            print(
                f'{"FName":<12} | {"LName":<12} | {"Email":<25}'
            )
            print("-" * 50)

            for row in records:
                print(
                    f'{row[0]:<12} | {row[1]:<12} | {row[2]:<25}'
                )
                
            cur.close()

        elif choice == '2': # View all visitor information
            # Execute a query to view all visitors
            cur = conn.cursor()
            cur.execute('SELECT * FROM visitor;')
            records = cur.fetchall()

            print(
                f'{"ID":<5} | {"FName":<12} | {"LName":<12} | '
                f'{"Street":<20} | {"City":<15} | {"State":<8} | '
                f'{"Zip":<10} | {"DOB":<12} | {"Fines":<10}'
            )
            print("-" * 132)

            for row in records:
                print(
                    f'{row[0]:<5} | {row[1]:<12} | {row[2]:<12} | '
                    f'{row[3]:<20} | {row[4]:<15} | {row[5]:<8} | '
                    f'{row[6]:<10} | {str(row[7]):<12} | {row[8]:<10}'
                )

            #Print out a separate email table for visitors
            cur.execute('SELECT f_name, l_name, visitor_emails.email, email FROM visitor_emails JOIN visitor ON visitor_emails.visitor_id = visitor.visitor_id;')
            records = cur.fetchall()

            print()
            print("Visitor Emails:")
            print(
                f'{"FName":<12} | {"LName":<12} | {"Email":<25}'
            )
            print("-" * 50)

            for row in records:
                print(
                    f'{row[0]:<12} | {row[1]:<12} | {row[2]:<25}'
                )
                
            cur.close()

        elif choice == '3': # View individual visitor records
            # Execute a query to view individual visitor records
            cur = conn.cursor()
            cur.execute('SELECT visitor_id, f_name, l_name FROM visitor;')
            records = cur.fetchall()

            # Print a list of visitor names and IDs, admin will then choose from that list
            print()
            print('Visitor List:')
            print(
                f'{"ID":<5} | {"FName":<12} | {"LName":<12}'
            )
            print("-" * 30)

            for row in records:
                print(
                    f'{row[0]:<5} | {row[1]:<12} | {row[2]:<12}'
                )
            visitor_id = input("Select a visitor by entering their ID: ")

            # Book records for the selected visitor
            print()
            print(f'Book Records for Visitor ID: {visitor_id}')
            cur.execute('SELECT visitor_id, book_call_number, date_time_out, date_time_returned FROM book_records WHERE visitor_id = %s;', (visitor_id,))
            records = cur.fetchall()

            print(
                f'{"ID":<5} | {"Call Number":<25} | {"Date/Time Out":<25} | '
                f'{"Date/Time Returned":<25}'
            )
            print("-" * 90)

            for row in records:
                print(
                    f'{row[0]:<5} | {row[1]:<25} | {str(row[2]):<25} | '
                    f'{str(row[3]):<25}'
                )

            # Movie records for the selected visitor
            print()
            print(f'Movie Records for Visitor ID: {visitor_id}')
            cur.execute('SELECT visitor_id, movie_call_number, date_time_out, date_time_returned FROM movie_records WHERE visitor_id = %s;', (visitor_id,))
            records = cur.fetchall()

            print(
                f'{"ID":<5} | {"Call Number":<25} | {"Date/Time Out":<25} | '
                f'{"Date/Time Returned":<25}'
            )
            print("-" * 90)

            for row in records:
                print(
                    f'{row[0]:<5} | {row[1]:<25} | {str(row[2]):<25} | '
                    f'{str(row[3]):<25}'
                )
            
            # Community activities for the selected visitor
            print()
            print(f'Community Activities for Visitor ID: {visitor_id}')
            cur.execute('SELECT visitor_id, community_activity_id FROM activity_attendance WHERE visitor_id = %s;', (visitor_id,))
            records = cur.fetchall()

            print(
                f'{"ID":<5} | {"Activity ID":<12}'
            )
            print("-" * 20)

            for row in records:
                print(
                    f'{row[0]:<5} | {row[1]:<12}'
                )

            cur.close()

        elif choice == '4': # View community activities
            # Execute a query to view community activities
            cur = conn.cursor()
            cur.execute('SELECT * FROM community_activity;')
            records = cur.fetchall()

            print(
                f'{"ID":<5} | {"Title":<36} | {"Description":<50} | '
                f'{"Date/Time":<25} | {"Location":<25} | {"Librarian ID":<12} | '
                f'{"Capacity":<8} | {"Demographic":<8}'
            )
            print("-" * 194)

            # for row in records:
            #     print(
            #         f'{row[0]:<5} | {row[1]:<36} | {row[2]:<100} | '
            #         f'{str(row[3]):<25} | {row[4]:<25} | {row[5]:<5} | '
            #         f'{row[6]:<2} | {row[7]:<8}'
            #     )
            for row in records:
                description_lines = textwrap.wrap(row[2], width=50)  # Wrap at 50 characters

                # Print the first line with all the other columns
                print(
                    f'{row[0]:<5} | {row[1]:<36} | {description_lines[0]:<50} | '
                    f'{str(row[3]):<25} | {row[4]:<25} | {row[5]:<12} | '
                    f'{row[6]:<8} | {row[7]:<8}'
                )

                # Print any remaining description lines
                for line in description_lines[1:]:
                    print(
                        f'{"":<5} | {"":<36} | {line:<50} | '
                        f'{"":<25} | {"":<25} | {"":<12} | '
                        f'{"":<8} | {"":<8}'
                    )

            cur.close()

        elif choice == '5': # Quit
            active = False
            print("Exiting the Administrator Library Management System.")
            print()
            print()
        else:
            print("Invalid choice. Please try again.")
    
    # Close the connection
    cur.close()
    
except(Exception, psycopg2.DatabaseError) as error:
    print(error)
finally:
    if conn is not None:
        conn.close()
        print('Database connection closed.')
