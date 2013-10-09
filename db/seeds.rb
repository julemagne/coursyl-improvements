# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

db_course = Course.create!(name: 'Databases',
  course_code: 'CS310',
  period: 'F Block, M T W F',
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

db_instructor = User.create!(title: 'Mr.',
  first_name: 'Mason',
  middle_name: 'Fox',
  last_name: 'Matthews',
  email: 'matthews@ncssm.edu',
  password: 'password',
  phone: '(919) 302-5139',
  office: 'E&T Conference Room',
  office_hours: '3:30-4:30 on Mondays (or by appointment)',
  photo_url: nil,
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


lessons = Hash.new

#Week: Intro (2 days, T-W)
lessons[:data] = Lesson.create!(course_id: db_course.id,
  parent_lesson: nil,
  name: "Data",
  held_at: '2013-11-05 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{What is data?  Binary, Text, XML, JSON, Tabular, and Graph.}
)
lessons[:real_world] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:data],
  name: "Real-World Problems",
  held_at: '2013-11-06 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{What do you do in life that generates or uses a lot of data?  Stories
      of real-world problems, apps, and systems (including Facebook statistics).
      Initial project discussions and planning.}
)

#Week: DB Design/Relational (4 days, F-W)
lessons[:design1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:real_world],
  name: "Design",
  held_at: '2013-11-08 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{The [Address Book] Problem. Modeling the real world as tabular data.}
)
lessons[:design2] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:design1],
  name: "Design: Normal Forms I",
  held_at: '2013-11-11 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{Showing Excel who's boss.}
)
lessons[:design3] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:design2],
  name: "Design: Normal Forms II",
  held_at: '2013-11-12 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{Very possibly taking it too far.}
)
lessons[:relational1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:real_world],
  name: "Relational Databases",
  held_at: '2013-11-13 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{Relational Algebra, Tables, Columns, Rows, Domains/Data Types, Keys.}
)

#Week: PostgreSQL/SQL (4 days, F-W)
lessons[:postgres1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:relational1],
  name: "PostgreSQL",
  held_at: '2013-11-15 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{Finally, we touch our computers.}
)
lessons[:sql1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:relational1],
  name: "SQL",
  held_at: '2013-11-18 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{How you would write a language to store, edit, and delete tabular data?
      CREATE, INSERT, DELETE.}
)
lessons[:sql2] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:sql1],
  name: "SQL: Querying for Data",
  held_at: '2013-11-19 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{Now that we can put data in a database, how do we get it out? SELECT,
      FROM, WHERE}
)
lessons[:sql3] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:sql2],
  name: "SQL: Merging Data",
  held_at: '2013-11-20 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{Sure, we can pull from one table, but how do we recreate [something
      complex from more than one table]? JOINS}
)

#Week: Design/SQL (4 days, F-W)
lessons[:sql4] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:sql3],
  name: "SQL: Grouping Data",
  held_at: '2013-11-22 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{How do we use the tools in our toolbox to get rid of duplicates?
      GROUP BY, HAVING}
)
lessons[:design4] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:design3],
  name: "Design: Hierarchies",
  held_at: '2013-12-02 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{How would you design a database to keep track of [your family tree]?}
)
lessons[:design5] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:design4],
  name: "Design: Polymorphism",
  held_at: '2013-12-03 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{How would you design a database to keep track of [ratings on songs AND albums AND artists]?}
)
lessons[:breather] = Lesson.create!(course_id: db_course.id,
  parent_lesson: nil,
  name: "Breathing Room",
  held_at: '2013-12-04 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{Catch our breath and allow for extra questions on prior topics.
      Intermediate project discussion.}
)

#Week: Indexing/Transactions (3 days, F-T)
lessons[:postgres2] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:postgres1],
  name: "PostgreSQL: Transactions",
  held_at: '2013-12-06 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{How do you keep from losing money if your ATM is struck by lightning?}
)
lessons[:postgres3] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:postgres2],
  name: "PostgreSQL: Indexing I",
  held_at: '2013-12-09 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{How can you look up a row in a reasonable time when you have
      billions of records?}
)
lessons[:postgres4] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:postgres3],
  name: "PostgreSQL: Indexing II",
  held_at: '2013-12-10 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{Must-have indexing, indexing across multiple columns.}
)
Lesson.create!(course_id: db_course.id,
  parent_lesson: nil,
  name: '"Midterm" Exam',
  held_at: '2013-12-11 2:30PM',
  description: 'The "Midterm" exam will be held during class.'
)

#Week: Key-Value (4 days, F-W)
lessons[:nosql] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:real_world],
  name: "NoSQL",
  held_at: '2013-12-13 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:kv1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:nosql],
  name: "Key-Value DBs (Riak)",
  held_at: '2013-12-16 12:55PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:cap] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:real_world],
  name: "CAP Theorem",
  held_at: '2013-12-17 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:kv2] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:kv1],
  name: "Key-Value: Mapreduce",
  held_at: '2013-12-18 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)

#Week: ActiveRecord (3 days, M-W)
lessons[:orm1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:postgres1],
  name: "ORMs",
  held_at: '2014-01-06 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:orm2] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:orm1],
  name: "ORMs: Active Record",
  held_at: '2014-01-07 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:orm3] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:orm2],
  name: "ORMs: TBD",
  held_at: '2014-01-08 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)

#Week: Document DBs (4 days, F-W)
lessons[:doc1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:nosql],
  name: "Document DBs (MongoDB)",
  held_at: '2014-01-10 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:acid] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:real_world],
  name: "ACID Compliance",
  held_at: '2014-01-13 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:doc2] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:doc1],
  name: "Document DBs: TDB",
  held_at: '2014-01-14 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:doc3] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:doc2],
  name: "Document DBs: TBD",
  held_at: '2014-01-15 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)

#Week: Columnar Databases (3 days, F-W)
lessons[:col1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:nosql],
  name: "Columnar DBs (HBase)",
  held_at: '2014-01-17 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:col2] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:col1],
  name: "Columnar/Graph DBs: TBD",
  held_at: '2014-01-21 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:col3] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:col2],
  name: "Columnar/Graph DBs: TBD",
  held_at: '2014-01-22 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)

#Week: DBMS-Specific SQL (3 days, M-W)
lessons[:sql5] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:sql4],
  name: "SQL: Regex",
  held_at: '2014-01-27 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:sql6] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:sql5],
  name: "SQL: Text Search",
  held_at: '2014-01-28 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:sql7] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:sql6],
  name: "SQL: TBD",
  held_at: '2014-01-29 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
Lesson.create!(course_id: db_course.id,
  parent_lesson: nil,
  name: 'Project Turn-in and Discussion',
  held_at: '2014-01-31 1:35PM',
  description: "Projects will be due, and we'll look back at the class so far."
)

#Week: Scalability/Case Studies (3 days, M-W)
lessons[:scale1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:real_world],
  name: "Scalability: TBD",
  held_at: '2014-02-03 2:20PM',
  lead_in_reading: "https://fbcdn-dragon-a.akamaihd.net/hphotos-ak-ash3/851560_196423357203561_929747697_n.pdf",
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:scale2] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:scale1],
  name: "Scalability: TBD",
  held_at: '2014-02-04 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:scale3] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:scale2],
  name: "Scalability: TBD",
  held_at: '2014-02-05 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
Lesson.create!(course_id: db_course.id,
  parent_lesson: nil,
  name: "Final Exam Prep",
  held_at: '2014-02-07 1:35PM',
  description: "Review of course material in preparation for final exam."
)


Assignment.create!(course_id: db_course.id,
  name: 'Daily Questions',
  active_at: '2013-11-05 4:15PM',
  due_at: '2014-02-07 2:25PM',
  students_can_submit: false,
  fraction_of_grade: 0.1
)
Assignment.create!(course_id: db_course.id,
  name: 'Class Project',
  active_at: '2013-12-06 12:00AM',
  due_at: '2014-02-07 2:25PM',
  students_can_submit: false,
  fraction_of_grade: 0.2
)
Assignment.create!(course_id: db_course.id,
  name: '"Midterm" Exam',
  active_at: '2013-12-11 2:30PM',
  due_at: '2013-12-11 3:20PM',
  students_can_submit: false,
  fraction_of_grade: 0.15
)
Assignment.create!(course_id: db_course.id,
  name: 'Final Exam',
  active_at: '2014-02-13 1:30PM',
  due_at: '2014-02-13 3:30PM',
  students_can_submit: false,
  fraction_of_grade: 0.15
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 1: Database Design',
  active_at: '2013-11-08 2:25PM',
  due_at: '2013-11-15 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 2: Basic SQL',
  active_at: '2013-11-15 2:25PM',
  due_at: '2013-11-22 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 3: Intermediate SQL',
  active_at: '2013-11-22 2:25PM',
  due_at: '2013-12-06 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 4: Key-Value Databases (Riak)',
  active_at: '2013-12-13 2:25PM',
  due_at: '2013-12-18 2:30PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 5: ORMs (Active Record)',
  active_at: '2014-01-06 3:10PM',
  due_at: '2014-01-10 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 6: Document Databases (MongoDB)',
  active_at: '2014-01-10 2:25PM',
  due_at: '2014-01-17 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 7: Columnar Databases (HBase)',
  active_at: '2014-01-17 2:25PM',
  due_at: '2014-01-24 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 8: Advanced SQL',
  active_at: '2014-01-31 2:25PM',
  due_at: '2014-02-07 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
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

Policy.create!(course_id: db_course.id,
  name: 'Grading Scale',
  order_number: 0,
  description:
    %{* A: [90-100]
* B: [80-90)
* C: [70-80)
* D: Below 70}
)

Policy.create!(course_id: db_course.id,
  name: 'Attendance',
  order_number: 1,
  description:
    %{Class meets four times a week.  You are expected to attend every class, and
you are expected to be on time.  As is the case with the outside world, if
you arrive after the start time of the class (at all), you will be considered
tardy. If you are more than 10 minutes late, you will be considered
severely tardy.  If you are more than 15 minutes late, you will be considered
absent.

On the flip side, classes will not run late.  If I do keep talking beyond the
end of the period, you are encouraged to yell at me and/or stand up and walk
out.}
)
Policy.create!(course_id: db_course.id,
  name: 'Daily Activities',
  order_number: 2,
  description:
    %{Every lesson will be accompanied by an article from the web, and it should be
read **before** the we meet to discuss the topic.  To ensure that you read the
article (and to get you thinking along the right lines), one question will be
posted in advance of the lesson, and must be answered at least one hour before
the class begins. The question will be removed at that time, so no partial
credit will be given for late submissions.

You will also be asked to "grade" each lesson. I will give out slips of paper
during each class (unless you all consistently bring your laptops, then we'll
do it online), and you will (a) consider how well you understood the material,
(b) rate it between 0 and 10 (10 meaning perfect clarity, 0 meaning you would have
learned more by sleeping), and (c) turn it in at the end of class.

Note that this is only meant to judge how well the lesson conveyed the
material. If you have other issues with the course, please do let me know by
other means!}
)
Policy.create!(course_id: db_course.id,
  name: 'Weekly Assignments',
  order_number: 3,
  description:
    %{Each week (except for the midterm week and the project week), a set of
exercises will be due at the beginning of class on the last class day of the
week. For these assignments, discussion among students is permitted, but
students MUST write up solutions independently and list those with whom
they worked.

The Internet is a welcome (and obvious) resource for assisting you with your
assignments, although for a few problems, I may explicitly ask you not to
look.  Somtimes beating your head against a problem has learning value.
However should you happen to find an exact solution to one of the questions
while surfing the webz, then don't copy it. Hopefully I've gotten creative
enough to avoid that, and I know I shouldn't have to say it.  See the
"Academic Honesty" policy.

If you have an excused absence on the day an assignment is due, you will
be allowed to turn in your assignment 24 hours after your return without
penalty.  Unexcused absences will not extend the due date.  For every day
or part of a day that an assignment is overdue, 10 points (out of 100)
will be deducted from your grade on that assignment.}
)
Policy.create!(course_id: db_course.id,
  name: 'Projects and Tests',
  order_number: 4,
  description:
    %{If you have an excused absence on the day an project is due, you will
be allowed to turn in your assignment 24 hours after your return without
penalty.  Unexcused absences will not extend the due date.  For every day
or part of a day that an assignment is overdue, 10 points (out of 100)
will be deducted from your grade on that assignment.

If you know that you will have an excused absence on the day of a
scheduled test, please make arrangements to take the test
prior to your absence.  If you miss a test due to an unexcused
absence, you will receive a zero on that test.

If, across all of your classes, you have more than 2 major assignments due
on the same day (and one of them is in this class), please let me know and
contact Academic Programs at least 48 hours in advance.}
)
Policy.create!(course_id: db_course.id,
  name: 'Laptop Usage Policy',
  order_number: 5,
  description:
    %{Laptops are an integral part of this course, and you should bring them to
every class.  Some days, however, will be spent discussing fundamentals and
concepts, so using them for anything other than note-taking on those days
will be in poor taste.}
)
Policy.create!(course_id: db_course.id,
  name: 'Academic Honesty',
  order_number: 6,
  description:
    %{You are responsible for reading the academic honesty policy in the NCSSM
handbook.  If you violate the academic honesty policy on an assignment,
you will receive a zero on that assignment and will also be subject to
disciplinary action as outlined in the NCSSM handbook.}
)
Policy.create!(course_id: db_course.id,
  name: 'Other Policies',
  order_number: 7,
  description:
    %{**The policies described here for this course are superseded by NCSSM
school-wide policies.** In the case of any disagreement, NCSSM
school-wide policies are correct, and these course policies are wrong.

For information on school-wide policies, please refer to the current
version of the “Student Handbook” available in the “NCSSM” folder under the
“Documents & Forms” section of [My NCSSM](https://my.ncssm.edu).  It is your
responsibility to be familiar with these policies.}
)
