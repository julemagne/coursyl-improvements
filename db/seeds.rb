# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

tiy = School.create(name: "The Iron Yard")

term = Term.create!(school: tiy,
        name: "Cohort Alpha",
        starts_on: Time.now - 2.months,
        ends_on: Time.now + 2.months)

db_course = Course.create!(name: 'Databases',
  course_code: 'TIY300',
  term: term,
  color: '#BECADF',
  period: 'All the Time',
  description:
    %{Even if you don't realize it, databases are everywhere, and they come in
many flavors.  They're not just in the obvious places like Facebook and Twitter;
you also have hundreds installed on the phone in your hand, and chances are
that your life would be easier if you'd built a few for yourself.  This course
will introduce you to database concepts, give you experience using them
for real-world applications, and demonstrate how one size most certainly does
not fit all.

Approximately 60% of the course will be devoted to relational databases and DB
design.  The remaining 40% will cover NoSQL options such as MongoDB and Riak.}
)

GradeThreshold.create!(course: db_course,
  grade: 90,
  letter: "A"
)
GradeThreshold.create!(course: db_course,
  grade: 80,
  letter: "B"
)
GradeThreshold.create!(course: db_course,
  grade: 70,
  letter: "C"
)
GradeThreshold.create!(course: db_course,
  grade: 0,
  letter: "D"
)

db_instructor = User.create!(title: 'Mr.',
  first_name: 'Mason',
  middle_name: 'Fox',
  last_name: 'Matthews',
  email: 'mason.matthews@theironyard.com',
  password: 'password',
  phone: '(919) 302-5139',
  office: 'That Room',
  office_hours: 'All the Time',
  photo_url: nil,
  instructor: true,
  admin: true,
  description:
    %{Mr. Matthews started coding at thirteen, but now he spends most of his time working with clients, enabling developers to do their best work, and volunteer teaching.  He hopes to one day prove that anyone can code, and he believes that if you don't learn something new every day, you're not paying attention.

He is a firm believer in autonomy, mastery, purpose, and the Oxford comma.

So-called "expertise:"

* Algorithms and machine learning
* Using SQL for more things than you'd expect
* Minimizing user confusion
* Process improvement
* Genetics and immunology
* Predicting the future}
)

CourseInstructor.create!(course_id: db_course.id,
  instructor_id: db_instructor.id,
  primary: true
)

assignments = {}
Assignment.create!(course_id: db_course.id,
  name: 'Daily Questions',
  active_at: '2013-11-05 4:15PM',
  due_at: '2014-02-07 12:55PM',
  students_can_submit: false,
  grades_released: true,
  percent_of_grade: 10
)
Assignment.create!(course_id: db_course.id,
  name: 'Class Project',
  active_at: '2013-12-06 12:00AM',
  due_at: '2016-01-31 12:55PM',
  students_can_submit: false,
  percent_of_grade: 30
)
Assignment.create!(course_id: db_course.id,
  name: '"Midterm" Exam',
  active_at: '2013-12-11 1:50PM',
  due_at: '2013-12-11 3:20PM',
  students_can_submit: false,
  grades_released: true,
  percent_of_grade: 20
)

assignments[1] = Assignment.create!(course_id: db_course.id,
  name: 'Assignment 1: Database Design',
  active_at: '2013-11-08 2:25PM',
  due_at: '2013-11-15 12:55PM',
  students_can_submit: true,
  grades_released: true,
  percent_of_grade: 5
)
AssignmentQuestion.create!(assignment: assignments[1],
  order_number: 1,
  points: 10,
  question:
    %{For each of the following categories, choose the correct naming convention (when using Rails and MySQL):

- Name of a table containing student records: Student, Students, student, students
- Name of the primary key on this table: id, student _ id, students _ id
- Name of the foreign key for a student referenced by a different table: id, student _ id, students _ id }
)
AssignmentQuestion.create!(assignment: assignments[1],
  order_number: 2,
  points: 20,
  question:
    %{Give a specific example of a real-world scenario where database normalization is at odds with our directive to build databases which "support the processes requiring their data."}
)
AssignmentQuestion.create!(assignment: assignments[1],
  order_number: 3,
  points: 20,
  question:
    %{Give an example of a table which conforms to 2NF, but which is still subject to update anomalies.}
)
AssignmentQuestion.create!(assignment: assignments[1],
  order_number: 4,
  points: 50,
  question:
    %{Design two versions of a data structure for tracking all due dates for all assignments for all students across the school.

- The first version should be totally denormalized (i.e. not even conform to 1NF).  Break every rule.
- The second version should be "normalized" (i.e. conform to 3NF).  Use numerical primary keys.

Use appropriate naming conventions and explictly define all fields, including their domains.}
)
AssignmentQuestion.create!(assignment: assignments[1],
  order_number: 5,
  points: 20,
  question:
    %{Design a normalized data structure to store the nodes of a binary tree (feel free to ask Mason to clarify if you don't know what a "binary tree" is).}
)



assignments[2] = Assignment.create!(course_id: db_course.id,
  name: 'Assignment 2: Basic SQL',
  active_at: '2013-11-15 2:25PM',
  due_at: '2013-11-22 12:55PM',
  students_can_submit: true,
  grades_released: true,
  percent_of_grade: 5
)
AssignmentQuestion.create!(assignment: assignments[2],
  order_number: 1,
  points: 30,
  question:
    %{Create a 3NF data structure for keeping track of all of the foods you eat in each day and all of the exercises
that you do in each day.  For food, you should track how many calories are in each type of food, how much you ate, and where
you bought it.  For exercise, keep track of how many calories you burned and what type of activity it was.}
)
AssignmentQuestion.create!(assignment: assignments[2],
  order_number: 2,
  points: 30,
  question:
    %{Write SQL CREATE statements to generate the 3NF version of the data structure at
<a href='https://docs.google.com/spreadsheet/ccc?key=0AteOLFPOMuwPdE5jaTVUbUdyX2JqMGVVd1JqekxDQnc&usp=sharing' target='blank'>this link</a>.
Then write SQL queries to add just one record to each of the tables.}
)
AssignmentQuestion.create!(assignment: assignments[2],
  order_number: 3,
  points: 30,
  question:
    %{Refer to the data structure in Question 2.  Write an SQL query to change all the values of 100 in the "efficacy" column of the "test_results"
table to 99 unless the bug tested was a Mosquito.}
)
AssignmentQuestion.create!(assignment: assignments[2],
  order_number: 4,
  points: 30,
  question:
    %{Write SQL queries to return the following results from the data structure created in Question 2:

- Return all of the efficacy numbers above 50.
- Return the id of the bug named "Moth".
- Return all of the test results for tests performed after 3/1/2013. Include the name of the bug.}
)


assignments[3] = Assignment.create!(course_id: db_course.id,
  name: 'Assignment 3: Intermediate SQL',
  active_at: '2013-11-22 2:25PM',
  due_at: '2013-12-06 12:55PM',
  students_can_submit: true,
  grades_released: true,
  percent_of_grade: 5
)
AssignmentQuestion.create!(assignment: assignments[3],
  order_number: 1,
  points: 30,
  question:
    %{Design the data structure that you believe is being used for the Snapchat database.  Think about all the things
that the application and service do, not just a flat data structure to store photos.}
)
AssignmentQuestion.create!(assignment: assignments[3],
  order_number: 2,
  points: 30,
  question:
    %{For this question, assume that you have an existing table with many records in it.  The table structure could be
created using the following SQL command:

CREATE TABLE people (id INT AUTO _ INCREMENT, name VARCHAR(255), PRIMARY KEY (id));

(a) Write a query which returns all the names which appear more than once.  This query must use a GROUP BY.

(b) Rewrite the query without using GROUP BY.}
)
AssignmentQuestion.create!(assignment: assignments[3],
  order_number: 3,
  points: 30,
  question:
    %{(a) Create a data structure for storing all of your grades on your assignments in all of your classes.
Store the numerical grade which you received in the table of assignments.  Create a second table which will let
you determine what letter grade you got on each assignment.  Keep in mind that some classes will have 10-point
scales while others have 7-point scales.  Do NOT store 100 records per class in this second table.

(b) Write a query to return all numerical grades paired with the corresponding letter grades for all assignments.}
)
AssignmentQuestion.create!(assignment: assignments[3],
  order_number: 4,
  points: 30,
  question:
    %{Assume that you have a table with the following structure:

CREATE TABLE discovered_genes (id INT AUTO_INCREMENT, number INT, name VARCHAR(255), PRIMARY KEY (id));

The "id" field is an incrementing field with no gaps.  However, the "number" field was copied in from an old (sloppy)
database, and it has gaps.  In other words, its records look something like this:

- 1
- 2
- 4
- 5
- 8

Write a query to return all of the numbers that are MISSING from the number field.  In the case above, your query should
return 3, 6, and 7.

If this is too difficult, you'll receive most of the points if you can create a query which returns the FIRST missing
number rather than all of them.
}
)


Assignment.create!(course_id: db_course.id,
  name: 'Assignment 4: Key-Value Databases (Riak)',
  active_at: '2013-12-13 2:25PM',
  due_at: '2013-12-18 1:50PM',
  students_can_submit: true,
  grades_released: true,
  percent_of_grade: 5
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 5: ORMs (Active Record)',
  active_at: '2014-01-06 3:10PM',
  due_at: '2014-01-10 12:55PM',
  students_can_submit: true,
  grades_released: true,
  percent_of_grade: 5
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 6: Document Databases (MongoDB)',
  active_at: '2014-01-10 2:25PM',
  due_at: '2014-01-17 12:55PM',
  students_can_submit: true,
  grades_released: true,
  percent_of_grade: 5
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 7: Columnar Databases (HBase)',
  active_at: '2014-01-17 2:25PM',
  due_at: '2014-01-24 12:55PM',
  students_can_submit: true,
  grades_released: true,
  percent_of_grade: 5
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 8: Advanced SQL',
  active_at: '2014-01-31 2:25PM',
  due_at: '2014-02-07 12:55PM',
  students_can_submit: true,
  grades_released: true,
  percent_of_grade: 5
)


Policy.create!(course_id: db_course.id,
  name: 'Prerequisites',
  order_number: -3,
  description:
    %{No course catalog prerequisites.  Just an interest in keeping track of and leveraging
      what we know about the world around us.}
)

Policy.create!(course_id: db_course.id,
  name: 'Goals and Objectives',
  order_number: -2,
  description:
    %{Course Objectives:

* Learn the fundamentals of database design.
* Understand the differences between relational, document, key-value, columnar, and graph databases.
* Appreciate the deep theoretical underpinnings of modern databases.
* Learn about current implementations of database types and their acceptance levels in industry.
* Communicate with others about real-world modeling using standard language.
* Appreciate the role that databases play in all levels of technology.
* Equip students with a series of tools which they can use in future endeavors to:
 * save time
 * retain knowledge or information that they discover/invent, and
 * think more critically about problems which they encounter in everyday life.

Upon successful completion of this course, you will be able to:

* Design a data structure to model real-world objects and information (CS Goal 1.d.)
* Select the appropriate database paradigm for various real-world situations (CS Goal 1.f.)
* Build SQL statements to create, modify, and read from relational databases (CS Goal 1.e.)
* Configure databases responsibly through transactions and indexing (CS Goal 1.d.)
* Work together to control relational databases through the Ruby on Rails framework (CS Goal 3)
* Balance theoretical and practical trade-offs such as consistency, availability, and partition tolerance (CS Goal 1.e.)
* Apply a few advanced techniques for allowing databases to scale to millions of users (CS Goal 1.f.)
}
)

Policy.create!(course_id: db_course.id,
  name: 'Course Materials',
  order_number: -1,
  description:
    %{* Laptop capable of running an Ubuntu Virtual Box
* Lots and lots of Internet
* No textbook is required for this course, although if you are interested in
having a good reference to keep around after the class, I'd suggest the
Pragmatic Programmer's [7 Databases in 7 Weeks](http://pragprog.com/book/rwdata/seven-databases-in-seven-weeks)
by Eric Redmond and Jim R. Wilson}
)
