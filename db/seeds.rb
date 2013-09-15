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

db_instructor = Instructor.create!(title: 'Mr.',
  first_name: 'Mason',
  middle_name: 'Fox',
  last_name: 'Matthews',
  email: 'matthews@ncssm.edu',
  phone: '(919) 302-5139 (cell)',
  office: 'E&T Conference Room',
  office_hours: '3:30-4:30 on Mondays (or by appointment)',
  photo_url: nil,
  description:
    %{Mr. Matthews started coding at thirteen, but now he spends most of his
time working with clients, enabling developers to do their best work,
and volunteer teaching.  He hopes to one day prove that anyone can code,
and he believes that if you don't learn something new every day, you're
not paying attention.

He is a firm believer in autonomy, mastery, purpose, and the Oxford comma.

So-called "expertise:"

* Algorithms and machine learning
* Using SQL for more things than you'd expect
* Minimizing user surprise
* Process improvement
* Genetics and immunology
* Predicting the future}
)

CourseInstructor.create!(course_id: db_course.id,
  instructor_id: db_instructor.id,
  primary: true
)


lessons = Hash.new

#Intro Week (2 days, T-W)
lessons[:what_is_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: "What is Data?",
  held_at: '2013-11-05 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:what_are_databases] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: lessons[:what_is_data],
  name: "What are Databases?",
  held_at: '2013-11-06 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)

#DB Types, Intro to Relational
lessons[:types] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: lessons[:what_are_databases],
  name: "Types of Database Systems",
  held_at: '2013-11-08 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:relational] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: lessons[:what_are_databases],
  name: nil,
  held_at: '2013-11-11 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-11-12 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-11-13 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-11-15 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-11-18 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-11-19 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-11-20 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-11-22 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-12-02 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-12-03 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-12-04 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-12-06 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-12-09 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-12-10 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
Lesson.create!(course_id: db_course.id,
  parent_lesson_id: lessons[:what_are_databases],
  name: '"Midterm" Exam',
  held_at: '2013-12-11 2:30PM',
  description: 'The "Midterm" exam will be held during class.'
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-12-13 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-12-16 12:55PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-12-17 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2013-12-18 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-01-06 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-01-07 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-01-08 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-01-10 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-01-13 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-01-14 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-01-15 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-01-17 1:35PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-01-21 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-01-22 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-01-27 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-01-28 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-01-29 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
Lesson.create!(course_id: db_course.id,
  parent_lesson_id: lessons[:what_are_databases],
  name: 'Project Turn-in and Discussion',
  held_at: '2014-01-31 1:35PM',
  description: "Projects will be due, and we'll look back at the class so far."
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-02-03 2:20PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-02-04 3:25PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
lessons[:intro_to_data] = Lesson.create!(course_id: db_course.id,
  parent_lesson_id: nil,
  name: nil,
  held_at: '2014-02-05 2:30PM',
  lead_in_reading: nil,
  lead_in_question: nil,
  description:
    %{TODO}
)
Lesson.create!(course_id: db_course.id,
  parent_lesson_id: lessons[:what_are_databases],
  name: "Final Exam Prep",
  held_at: '2014-02-07 1:35PM',
  description: "Review of course material in preparation for final exam."
)


Assignment.create!(course_id: db_course.id,
  name: 'Daily Questions',
  active_at: '2013-11-05 4:15PM',
  due_at: '2014-02-07 2:25PM',
  students_can_submit: false,
  fraction_of_grade: 0.12
)
Assignment.create!(course_id: db_course.id,
  name: 'Class Project',
  active_at: '2013-11-06 12:00AM',
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
  name: 'Assignment 1: TODO',
  active_at: '2013-11-08 2:25PM',
  due_at: '2013-11-15 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 2: TODO',
  active_at: '2013-11-15 2:25PM',
  due_at: '2013-11-22 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 3: TODO',
  active_at: '2013-11-22 2:25PM',
  due_at: '2013-12-06 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 4: TODO',
  active_at: '2013-12-13 2:25PM',
  due_at: '2013-12-18 2:30PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 5: TODO',
  active_at: '2014-01-06 3:10PM',
  due_at: '2014-01-10 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 6: TODO',
  active_at: '2014-01-10 2:25PM',
  due_at: '2014-01-17 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 7: TODO',
  active_at: '2014-01-17 2:25PM',
  due_at: '2014-01-24 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)
Assignment.create!(course_id: db_course.id,
  name: 'Assignment 8: TODO',
  active_at: '2014-01-31 2:25PM',
  due_at: '2014-02-07 1:35PM',
  students_can_submit: false,
  fraction_of_grade: 0.05
)


Policy.create!(course_id: db_course.id,
  name: 'Prerequisites',
  order_number: -3,
  description:
    %{* None.}
)

Policy.create!(course_id: db_course.id,
  name: 'Course Objectives',
  order_number: -2,
  description:
    %{* TODO
*	Goals: the broad statements about what the students will gain from the course—knowledge, skills, attitudes, etc.
*	Objectives: more specific statements (each related to a particular goal) about something assessable and measureable that students should be able to do by the end of the course (use specific verbs, such as describe, define, identify, explain, compare, contrast, evaluate, list, write, apply, solve, argue, support, construct, synthesize, articulate, differentiate, design, build, publish, post, integrate, interpret, relate, locate, map, trace, assess, etc.)
*	Goals and Objectives should be written in terms of what students will do and how they will demonstrate what they have learned.}
)

Policy.create!(course_id: db_course.id,
  name: 'Course Materials',
  order_number: -1,
  description:
    %{* Laptop capable of running an Ubuntu Virtual Box.
* Lots and lots of Internet.
* No textbook is required for this course, although if you are interested in
having a good reference to keep around after the class, I'd suggest the
Pragmatic Programmer's [7 Databases in 7 Weeks](http://pragprog.com/book/rwdata/seven-databases-in-seven-weeks)
by Eric Redmond and Jim R. Wilson.}
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
tardy. If you are more than 15 minutes late, you will be considered
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
(b) rate it between 0 and 10 (10 being perfect clarity), and (c) turn it in at
the end of class.

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
