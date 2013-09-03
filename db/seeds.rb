# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

db_course = Course.create!(name: 'Databases',
  course_code: 'CS310',
  description:
    %{Even if you don't realize it, databases are everywhere, and they come in many
      flavors.  They're not just in the obvious places like Facebook and Twitter;
      you also have hundreds installed on the phone in your hand, and chances are
      that your life would be easier if you'd built a few for yourself.  This course
      will introduce you to basic database concepts, give you experience using them
      for real-world applications, and demonstrate how one size most certainly does
      not fit all.

      Topics will include:
      * Relational databases
      * SQL wizardry
      * Database design
      * Object-relational mappings (specifically, ActiveRecord in Ruby on Rails)
      * Scalability and concurrency concerns
      * NoSQL systems such as MongoDB and HBase

      Given that relational databases currently rule the roost, the course
      will be weighted towards the first three items on this list, but our
      discussions will be in the context of the entire ecosystem from day one.}
)

db_instructor = Instructor.create!(title: 'Mr.',
  first_name: 'Mason',
  middle_name: 'Fox',
  last_name: 'Matthews',
  email: 'mason.f.matthews@gmail.com',
  photo_url: nil,
  description:
    %{Mason is cool.  TODO: COPY IN FROM SCIMED BIO}
)

CourseInstructor.create!(course_id: db_course.id,
  instructor_id: db_instructor.id,
  primary: true
)

Lesson.create!(course_id: db_course.id,
  parent_course_id: nil,
  name: nil,
  held_at: '2013-11-05 2:55PM',
  description:
    %{TODO}
)

Assignment.create!(name: 'Problem Set 1',
  course_id: db_course.id,
  active_at: '2013-11-12 12:00AM',
  due_at: '2013-11-19 1:00PM',
  students_can_submit: false,
  fraction_of_grade: 0.3
)

Policy.create!(:course_id: db_course.id,
  name: 'Laptop Policy',
  description:
    %{TODO}
)
