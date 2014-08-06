Coursyl
=======

Coursyl is a Rails app originally developed to manage <b>cour</b>se <b>syl</b>labi.  Over time, it expanded to include:

* Student logins
* Assignment taking
* Assignment grading (including anonymity!)
* Grade forecasting
* Lesson planning
* Media/link repositories
* Visual, topic-based trees
* Class meeting management
* Student feedback
* Achievement-based grading

It's true that there are hundreds of course management software packages out there, so it may not be for you.  However, it's written by teachers, used by teachers, and being iteratively developed, so it might have something that you like.  Feel free to use it!

Why Become a Coursyl User?
-------

(at https://coursyl.herokuapp.com)

If you're a student you might use Coursyl because you can:

* See your current grade
* See your final grade if you ace everything else
* See your final grade if you move to Maui now
* Submit assignments and get grades fast
* View upcoming lessons in a cool topical tree
* Watch lectures, review slides, and catch up on what you may have missed

If you're an instructor you might use Coursyl because you can:

* Create beautiful, sharable syllabi
* Grade anonymously
* Quickly adapt schedules for extra time on a lesson, delays due to snow, or a different group of students next semester

Semi-technical Details
-------

Technologies used:

* GPL v2 License
* Ruby
* Rails
* MySQL and PostgreSQL
* REST where sensible
* SCSS (flavor of Sass)
* redcarpet (Markdown)
* Bootstrap
* font-awesome
* d3-rails (d3.js)
* hint.css
* Devise

Tools for the coding process:

* VirtualBox, Vagrant, Ubuntu
* chruby
* TextMate
	* Strip Whitespace on Save
	* Soft Tabs: 2
* git
* github
* Heroku
* Heroku Toolkit
* Ctrl-Tab keyboard shortcut for switching terminal tabs
* Ctrl-Tab keyboard shortcut for switching TextMate tabs

Contributing to Coursyl
-------

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

Next Steps for Coursyl
-------

New Features:

* Timesheet functionality.
* Feedback for each class meeting.
* Emailing
  * Forgot password functionality (add '=' back to Forgot Password line in _links)
* Browser/Device compatibility
  * Header bar moves on Chrome print view
  * DLs don't print appropriately from Chrome
  * iPhone compatibility (works on iPad!)
* Drag and Drop
  * Drag and drop ordering of questions on assignments and readings on lessons.
  * Allow lessons to be dragged onto/between meetings
* Big-ish features
  * Students can submit daily questions.
  * Ordering meeting_lessons within a meeting
  * Instructors can make assignment submissions for students
  * Report of all grades for one student
  * Allow omit questions and omit assignments to remove them from numerator and denominator.
* Achievement reporting pages

Fixes/Improvements:

* Better Date/Datetime selectors
* Awful redirect flash message on every logout
* Be consistent about number_with_precision vs. int_if_possible
* user.grade_on_question and meeting_lesson.shift_later break Demeter.  Need better app-wide solution for looking these things up.
* Lock questions from being edited/deleted if aqgs exist.
* When completing modals, hide modal, keep background.
* More default scope orderings?  (e.g. readings?)
* Need a prettier/better home/index
* Make modals be contextual with JS (rather than rendering 100 of them)
* Any better way to do grade/letter_grade/min_grade, etc in user.rb?  Lots of duplication.
* Need advice on my turn_in action in the assignments controller. Not to mention the form_tag in the view. And should this be a post?
* assignments/turn_in and meeting_lessons/create: do I have to look for the text of the button?  Ugh.
* Warn on leaving grading pages without saving
* Beef up grade report with some stats
* course_student.max_grade assumes 100 point scale.  So does the last line of current_grade
* Assignments are assumed to have the same total number of points as the course itself.  Perhaps scale assignments up to the max of the course's scale?
* Get rid of daily questions altogether (although watch out availability of historical data).