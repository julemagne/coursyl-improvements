# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

db_course = Course.create!(name: 'Databases',
  course_code: 'CS310',
  color: '#BECADF',
  period: 'F Block, M T W F',
  started_on: '2013-11-05',
  ended_on: '2014-02-13',
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
  video_url: 'http://www.youtube.com/watch?v=lHog5f7J2mw',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{What is data?},
  outline:
    %{Binary, Text, XML, JSON, Tabular, and Graph.}
)
lessons[:real_world] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:data],
  name: "Real-World Problems",
  held_at: '2013-11-06 1:50PM',
  lead_in_reading: 'http://www.kickstarter.com/discover/categories/open%20software/successful?ref=more#p1',
  lead_in_question: %{1. Which three of the projects on this page seem to be the most data-heavy?
2. Give two examples of problems or tasks in your life that would benefit from software.},
  description:
    %{What do you do or know of in life that generates or uses a lot of data?},
  outline:
    %{Stories of real-world problems, apps, and systems (including Facebook statistics).  Initial project discussions and planning.}
)

#Week: DB Design/Relational (4 days, F-W)
lessons[:design1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:real_world],
  name: "Design",
  held_at: '2013-11-08 12:55PM',
  video_url: 'http://www.youtube.com/watch?v=NClkuBwnXDo',
  lead_in_reading: 'http://danielazwan.files.wordpress.com/2013/10/sorry-meme-generator-oops-i-m-sorry-72129c.gif',
  lead_in_question: 'Did you do anything fun with your extra 50 minutes?',
  description:
    %{Modeling the real world as tabular data.},
  outline:
    %{Data-heavy apps on Kickstarter:

- Massive Log Data Aggregation, Processing and Visualization
- LIBRARY FOR ALL: a digital library for the developing world
- Wildlife Rehabilitation MD: A Medical Database for Wildlife
- Open Source bike registry
- Trekkable, rating hotels for accessi12:55bility.
- JS Git : A javascript offline git management system
- WildHelp
- Ghost
- Nimbus
- AppsAmuck
- Learn Java Programming
- Clubhouse

Defend your Kickstarter choice!

The point: It's amazing that you all picked different ones.  You're all right that databases are really behind everything (although I can't tell you which one has the most.).

Back to it.  Here's the quote for the class:

"Databases are organized to model relevant aspects of reality in a way that supports the processes requiring their data."

Look back at the example we did in Excel.  Discuss:

- Tables
- Columns (fields)
- Rows
- Values
- Domains

Mason creates example single-table database of students and their grades across classes, considering: Students, class name, class code, grade, instructor name

Analyze Trekkable, considering: Hotels, addresses, Accessibility Areas (ramps, bathrooms, doorways), Ratings.

- First, each pair creates a Google spreadsheet and shares with me.
- 5 minutes, one table.

Why are these suboptimal?

1. Update anomalies.  What if the instructor changes?
1. Insertion/deletion anomalies.  What if a student is added with no classes or removed from all classes?
1. Make the data model more informative to users.  Is this clear to read?
1. Space?  Sure, space.

Mason splits classes and instructors into another table.

Try the same thing for Trekkable:

- 10 minutes in pairs, TWO tables.
- What limitations are still there?
- Talk about primary keys?

Look back at original example, talk about many-to-many?
}
)
lessons[:design2] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:design1],
  name: "Design: Normal Forms I",
  held_at: '2013-11-11 2:20PM',
  video_url: 'http://www.youtube.com/watch?v=69FWiPBZBmU',
  lead_in_reading: 'http://www.onextrapixel.com/2011/03/17/the-basics-of-good-database-design-in-web-development/',
  lead_in_question:
    %{1. Did anything in the article not make sense?
1. What do you think this article gets wrong?  Anything strike you as being off?
1. Please install MySQL Workbench on your computer from this link: http://dev.mysql.com/downloads/tools/workbench/},
  description:
    %{Showing Excel who's boss.},
  outline:
    %{Look back at the 0NF spreadsheet.

- Go through definitions again.
  + Table
  + Record
  + Field
  + Value
  + Domain
- Ask what was wrong with this one.
- Show ALT spreadsheet and ask what was wrong with this

Review things to do when building a data structure:

- Avoid update anomalies
- Avoid insert and delete anomalies
- Save space
- Make the data model more informative to users
- Minimize redesign when extending capabilities
- GREY AREA: Don't build a data structure for only one type of querying

Introduce spectrum of Normal Forms. 1, 2, 3, BCNF, 4, 5, 6

We're going through these one at a time, but you don't start developinga design at 1, then 2, etc.  You typically design at ~3 to start.

ALT is already in 1NF, but we'll move on from that because it limits future extensibility.

Show 1NF.  Show 1NF Clean.  Launch into definitions:

- Super Key (or "key"): a set of fields that will allow you to look up any record uniquely.
- Examples of a Super Key?  (All fields is one example)
- Candidate Key: a Super Key for which no subset of fields is also a Super Key.
- What is a Candidate Key on 1NF Clean?
- Non-prime field: a field which is not a part of any candidate key.  Which on this table?

2NF: No non-prime field is dependent on only a subset of a candidate key.  Show 2NF.

Ask for an example of a table with two DIFFERENT candidate keys.

Show 2NF Alt.  Still 2NF?  Subject to update anomalies?

3NF: Transitive property.  Tag line: "[Every] non-key [attribute] must provide a fact about the key, the whole key, and nothing but the key." A common variation supplements this definition with the oath: "so help me Codd"

Show MySQL Workbench examples.  Say "THIS is a data structure.  Been using the phrase a lot, but it's a definition of tables, columns, and domains.  This is what you want to build right, and this is what will be hardest to change later."

Types of joins?

Closing of class: things in your life that you said would benefit from databases:

- schedules
- homework(s)
- Online Thesauruses
- Organization of files on computer
- An app that allows me to input when I have assignments or other tasks to do and shows it all on a calendar
- An app that contained all of the known holidays and allows the user to input other important days that are not holidays

Fill students in on Dr. Warshaw's answer to Kickstarter.  Kickstarter's perspective:

- "*Parents and teachers can launch projects in collaboration with children under 18 only if the adult registers for the Kickstarter and payments accounts and is in charge of running the project itself."
}
)
lessons[:design3] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:design2],
  name: "Design: Normal Forms II",
  held_at: '2013-11-12 3:25PM',
  video_url: 'http://youtu.be/8wn9YOvvFMw',
  lead_in_reading: nil,
  lead_in_question: "Give an example of a table with two overlapping candidate keys.  Describe all fields and their domains, then indicate which two sets of fields are candidate keys.",
  description:
    %{Very possibly taking it too far.},
  outline:
    %{Give everyone access to Day 5 spreadsheet.  Ask them to work in pairs and make this table 3NF.

Review results.

Review responses to daily question.

Define BNF, 4NF, 5NF... as far as I can get in the day.}
)
lessons[:design3ish] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:design3],
  name: "Design: Data Structure Diagrams",
  held_at: '2013-11-13 1:50PM',
  video_url: 'http://youtu.be/mlg58yqELyQ',
  lead_in_reading: "http://net.tutsplus.com/tutorials/databases/visual-database-creation-with-mysql-workbench/",
  lead_in_question: 'Read down through the "Go Visual" section.  What is an EER Diagram, and why is it useful?',
  description:
    %{Relational Algebra, Relations, Attributes, Tuples, Domains.},
  outline:
    %{Wish I could have had them read through section 2.2 of this: http://buzzard.ups.edu/courses/2012spring/projects/wenholz-relational-algebra-ups-434-2012.pdf}
)

#Week: MySQL/SQL (4 days, F-W)
lessons[:postgres1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:real_world],
  name: "Getting Practical: MySQL",
  held_at: '2013-11-15 12:55PM',
  video_url: 'http://youtu.be/ifaXJhi2gR8',
  lead_in_reading: 'http://courses.masonfmatthews.com/assignments/4',
  lead_in_question: 'Do assignment 1!',
  description:
    %{Finally, we touch our computers.},
  outline:
    %{Ask if there are any questions on the homework?  Show the example.

Potentially catch up on project ideas?

Show the diagram of web application infrastructure: http://docs.oracle.com/cd/E38689_01/pt853pbr0/eng/pt/tsvt/img/ia2cf27cn-7b64.png

Explain that I gave up on the VM idea, as the infrastructure to run the VM was as complicated as the db itself.

Ask, if they want to create a language to interact with these "database" things, what would it look like?  List activities that you'd need to do.}
)
lessons[:sql1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:real_world],
  name: "SQL I: Building Structures",
  held_at: '2013-11-18 2:20PM',
  video_url: 'http://www.youtube.com/watch?v=2YaLYVQEIH0',
  lead_in_reading: 'http://net.tutsplus.com/tutorials/tools-and-tips/relational-databases-for-dummies/',
  lead_in_question:
    %{Install MySQL on your machine.  I would suggest using these links, but feel free to use other methods if you would like:

- Mac: http://www.macminivault.com/mysql-mavericks/
- Windows or Linux: http://dev.mysql.com/downloads/mysql/#downloads

The question: Did you have any problems during this installation?},
  description:
    %{System setup.  How you would write a language to store, edit, and delete tabular data?

CREATE, DROP, USE, SHOW, DESCRIBE, INSERT.}
)
lessons[:sql2] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:sql1],
  name: "SQL II: Manipulating Data",
  held_at: '2013-11-19 3:25PM',
  video_url: 'http://youtu.be/Wawg2gXMBAQ',
  lead_in_reading: 'http://dev.mysql.com/doc/refman/5.0/en/data-type-overview.html',
  lead_in_question:
    %{Read sections 11.1.1-11.1.3 of the daily reading.

Email me the SQL statements needed to create two tables: one for companies and one for employees.
The table of companies should include (at least) name, address, number of years in business, and mission statement.
The table of employees should include (at least) first name, last name, and date of hire.
There should also be a foreign key relating the two tables.},
  description:
    %{Let's get some data up in those tables.

INSERT, UPDATE, DELETE, WHERE.}
)
lessons[:sql3] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:sql2],
  name: "SQL III: Querying for Data",
  held_at: '2013-11-20 1:50PM',
  video_url: 'http://youtu.be/2I7ZxBhq2MQ',
  lead_in_reading: 'http://www.mysqltutorial.org/mysql-select-statement-query-data.aspx',
  lead_in_question: %{Improve on the CREATE TABLE statements that you wrote yesterday.  Make sure to include
primary and foreign keys.  Then create a SELECT statement which will give me the names of all of the companies which
have hired an employee with the last name of "Smith."

Send me all three SQL commands.  Don't worry if this is hard; we haven't talked about it in class yet, so I'm seeing
if you can put together something new.  As always, you get credit for solid attempts.'},
  description:
    %{Databases aren't any good if you can only put things in!

SELECT, FROM, WHERE, AS, CROSS JOIN, INNER JOIN.}
)

#Week: Design/SQL (4 days, F-W)
lessons[:sql4] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:sql3],
  name: "SQL IV: Joins",
  held_at: '2013-11-22 12:55PM',
  video_url: 'http://youtu.be/EsjvEGIh7-A',
  lead_in_reading: nil,
  lead_in_question: 'Complete assignment 2!',
  description:
    %{If we only needed data from one table, we'd just use Microsoft products!

JOIN, LEFT JOIN, OUTER JOIN, ORDER.  Subselects and IN.},
  outline:
    %{Show Avi the SET GLOBAL command.

Make sure that everyone ran the query from the pre-class e-mail.

Get them to select all the names of games and their ratings.

Get them to list all the consoles with all the games that they have.  All consoles should appear at least once, even if they don't have games.

Introduce LEFT JOIN.

I want them ordered by console name, alphabetically, then by game name, alphabetically.

Talk through a Trace-like solution of a subselect and an IN.}
)
lessons[:sql4ish] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:sql4],
  name: "SQL V: Grouping",
  held_at: '2013-12-02 2:20PM',
  lead_in_reading: nil,
  lead_in_question: "No questions today, as I'm not allowed to give you anything due less than 24 hours after you get back from break.  You win.",
  description:
    %{Time to think in the aggregate.

DISTINCT, GROUP BY, HAVING.}
)
lessons[:design4] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:design3ish],
  name: "Design: Hierarchies",
  held_at: '2013-12-03 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{How would you design a database to keep track of [your family tree]?}
)
lessons[:design5] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:design4],
  name: "Design: Polymorphism",
  held_at: '2013-12-04 1:50PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{How would you design a database to keep track of [ratings on songs AND albums AND artists]?}
)

#Week: Indexing/Transactions (3 days, F-T)
lessons[:postgres2] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:postgres1],
  name: "MySQL: Transactions",
  held_at: '2013-12-06 12:55PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{How do you keep from losing money if your ATM is struck by lightning?}
)
lessons[:postgres3] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:postgres2],
  name: "MySQL: Indexing I",
  held_at: '2013-12-09 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{How can you look up a row in a reasonable time when you have
      billions of records?}
)
lessons[:postgres4] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:postgres3],
  name: "MySQL: Indexing II",
  held_at: '2013-12-10 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{Must-have indexing, indexing across multiple columns.}
)
Lesson.create!(course_id: db_course.id,
  parent_lesson: nil,
  name: '"Midterm" Exam',
  held_at: '2013-12-11 1:50PM',
  description: 'The "Midterm" exam will be held during class.'
)

#Week: Key-Value (4 days, F-W)
lessons[:nosql] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:real_world],
  name: "NoSQL",
  held_at: '2013-12-13 12:55PM',
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
  held_at: '2013-12-18 1:50PM',
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
  held_at: '2014-01-08 1:50PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)

#Week: Document DBs (4 days, F-W)
lessons[:doc1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:nosql],
  name: "Document DBs (MongoDB)",
  held_at: '2014-01-10 12:55PM',
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
  held_at: '2014-01-15 1:50PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)

#Week: Columnar Databases (3 days, F-W)
lessons[:col1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:nosql],
  name: "Columnar DBs (HBase)",
  held_at: '2014-01-17 12:55PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:col2] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:col1],
  name: "Columnar/Graph DBs: TBD",
  held_at: '2014-01-21 2:50PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{[Longer Class]}
)
lessons[:col3] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:col2],
  name: "Columnar/Graph DBs: TBD",
  held_at: '2014-01-23 1:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{[Longer Class]}
)

#Week: DBMS-Specific SQL (3 days, M-W)
lessons[:sql5] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:sql4ish],
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
  held_at: '2014-01-29 1:50PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)
Lesson.create!(course_id: db_course.id,
  parent_lesson: nil,
  name: 'Project Turn-in and Discussion',
  held_at: '2014-01-31 12:55PM',
  description: "Projects will be due, and we'll demo them to the class and discuss."
)

#Week: Scalability/Case Studies (3 days, M-W)
Lesson.create!(course_id: db_course.id,
  parent_lesson: nil,
  name: 'Project Discussion',
  held_at: '2014-02-03 2:20PM',
  description: "We'll continue the demos and discussion of class projects."
)
lessons[:scale1] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:real_world],
  name: "Scalability: TBD",
  held_at: '2014-02-04 3:45PM',
  lead_in_reading: 'http://expandedramblings.com/index.php/by-the-numbers-17-amazing-facebook-stats/',
  lead_in_question: 'Which statistic is most surprising?',
  description:
    %{TBD}
)
lessons[:scale2] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:scale1],
  name: "Scalability: TBD",
  held_at: '2014-02-05 1:50PM',
  lead_in_reading: "https://fbcdn-dragon-a.akamaihd.net/hphotos-ak-ash3/851560_196423357203561_929747697_n.pdf",
  lead_in_question: nil,
  description:
    %{TBD}
)
lessons[:scale3] = Lesson.create!(course_id: db_course.id,
  parent_lesson: lessons[:scale2],
  name: "Scalability: TBD",
  held_at: '2014-02-07 12:55PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TBD}
)

assignments = {}
Assignment.create!(course_id: db_course.id,
  name: 'Daily Questions',
  active_at: '2013-11-05 4:15PM',
  due_at: '2014-02-07 12:55PM',
  students_can_submit: false,
  fraction_of_grade: 0.1
)
Assignment.create!(course_id: db_course.id,
  name: 'Class Project',
  active_at: '2013-12-06 12:00AM',
  due_at: '2014-01-31 12:55PM',
  students_can_submit: false,
  fraction_of_grade: 0.3
)
Assignment.create!(course_id: db_course.id,
  name: '"Midterm" Exam',
  active_at: '2013-12-11 1:50PM',
  due_at: '2013-12-11 3:20PM',
  students_can_submit: false,
  fraction_of_grade: 0.2
)

assignments[1] = Assignment.create!(course_id: db_course.id,
  name: 'Assignment 1: Database Design',
  active_at: '2013-11-08 2:25PM',
  due_at: '2013-11-15 12:55PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
AssignmentQuestion.create!(assignment_id: assignments[1].id,
  order_number: 1,
  points: 10,
  question:
    %{For each of the following categories, choose the correct naming convention (when using Rails and MySQL):

- Name of a table containing student records: Student, Students, student, students
- Name of the primary key on this table: id, student _ id, students _ id
- Name of the foreign key for a student referenced by a different table: id, student _ id, students _ id }
)
AssignmentQuestion.create!(assignment_id: assignments[1].id,
  order_number: 2,
  points: 20,
  question:
    %{Give a specific example of a real-world scenario where database normalization is at odds with our directive to build databases which "support the processes requiring their data."}
)
AssignmentQuestion.create!(assignment_id: assignments[1].id,
  order_number: 3,
  points: 20,
  question:
    %{Give an example of a table which conforms to 2NF, but which is still subject to update anomalies.}
)
AssignmentQuestion.create!(assignment_id: assignments[1].id,
  order_number: 4,
  points: 50,
  question:
    %{Design two versions of a data structure for tracking all due dates for all assignments for all students across the school.

- The first version should be totally denormalized (i.e. not even conform to 1NF).  Break every rule.
- The second version should be "normalized" (i.e. conform to 3NF).  Use numerical primary keys.

Use appropriate naming conventions and explictly define all fields, including their domains.}
)
AssignmentQuestion.create!(assignment_id: assignments[1].id,
  order_number: 5,
  points: 20,
  question:
    %{Design a normalized data structure to store the nodes of a binary tree (feel free to ask Mason to clarify if you don't know what a "binary tree" is).}
)


assignments[2] = Assignment.create!(course_id: db_course.id,
  name: 'Assignment 2: Basic SQL',
  active_at: '2013-11-15 2:25PM',
  due_at: '2013-11-22 12:55PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
AssignmentQuestion.create!(assignment_id: assignments[2].id,
  order_number: 1,
  points: 30,
  question:
    %{Create a 3NF data structure for keeping track of all of the foods you eat in each day and all of the exercises
that you do in each day.  For food, you should track how many calories are in each type of food, how much you ate, and where
you bought it.  For exercise, keep track of how many calories you burned and what type of activity it was.}
)
AssignmentQuestion.create!(assignment_id: assignments[2].id,
  order_number: 2,
  points: 30,
  question:
    %{Write SQL CREATE statements to generate the 3NF version of the data structure at
<a href='https://docs.google.com/spreadsheet/ccc?key=0AteOLFPOMuwPdE5jaTVUbUdyX2JqMGVVd1JqekxDQnc&usp=sharing' target='blank'>this link</a>.
Then write SQL queries to add just one record to each of the tables.}
)
AssignmentQuestion.create!(assignment_id: assignments[2].id,
  order_number: 3,
  points: 30,
  question:
    %{Refer to the data structure in Question 2.  Write an SQL query to change all the values of 100 in the "efficacy" column of the "test_results"
table to 99 unless the bug tested was a Mosquito.}
)
AssignmentQuestion.create!(assignment_id: assignments[2].id,
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
  students_can_submit: false,
  fraction_of_grade: 0.05
)
AssignmentQuestion.create!(assignment_id: assignments[3].id,
  order_number: 1,
  points: 30,
  question:
    %{Design the data structure that you believe is being used for the Snapchat database.  Think about all the things
that the application and service do, not just a flat data structure to store photos.}
)
AssignmentQuestion.create!(assignment_id: assignments[3].id,
  order_number: 2,
  points: 30,
  question:
    %{For this question, assume that you have an existing table with many records in it.  The table structure could be
created using the following SQL command:

CREATE TABLE people (id INT AUTO_INCREMENT, name VARCHAR(255), PRIMARY KEY (id));

(a) Write a query which returns all the names which appear more than once.  This query must use a GROUP BY.

(b) Rewrite the query without using GROUP BY.}
)
AssignmentQuestion.create!(assignment_id: assignments[3].id,
  order_number: 3,
  points: 30,
  question:
    %{(a) Create a data structure for storing all of your grades on your assignments in all of your classes.
Store the numerical grade which you received in the table of assignments.  Create a second table which will let
you determine what letter grade you got on each assignment.  Keep in mind that some classes will have 10-point
scales while others have 7-point scales.  Do NOT store 100 records per class in this second table.

(b) Write a query to return all numerical grades paired with the corresponding letter grades for all assignments.}
)
AssignmentQuestion.create!(assignment_id: assignments[3].id,
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
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 5: ORMs (Active Record)',
  active_at: '2014-01-06 3:10PM',
  due_at: '2014-01-10 12:55PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 6: Document Databases (MongoDB)',
  active_at: '2014-01-10 2:25PM',
  due_at: '2014-01-17 12:55PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 7: Columnar Databases (HBase)',
  active_at: '2014-01-17 2:25PM',
  due_at: '2014-01-24 12:55PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 8: Advanced SQL',
  active_at: '2014-01-31 2:25PM',
  due_at: '2014-02-07 12:55PM',
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
