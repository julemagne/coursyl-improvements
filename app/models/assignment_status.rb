class AssignmentStatus
  attr_accessor :name
  attr_accessor :fraction

  COMPLETE = "Complete"
  IN_PROGRESS = "In Progress"
  OVERDUE = "Overdue"
  FUTURE = "Future"

  def self.all_statuses_ordered
    [new(name: COMPLETE), new(name: IN_PROGRESS), new(name: OVERDUE), new(name: FUTURE)]
  end

  def self.complete_string
    COMPLETE
  end

  def initialize(options)
    @fraction = 0
    if options[:name]
      @name = options[:name]
    else
      @name = COMPLETE
      if options[:assignment].active_at > Time.now
        @name = FUTURE
      elsif options[:assignment].due_at > Time.now
        @name = IN_PROGRESS
      end
    end
  end

  def label_class
    emphases = {COMPLETE => "label-success",
      IN_PROGRESS => "label-warning",
      OVERDUE => "label-important",
      FUTURE => "label-info"}
    emphases[@name]
  end

  def text_class
    emphases = {COMPLETE => "text-success",
      IN_PROGRESS => "text-warning",
      OVERDUE => "text-error",
      FUTURE => "text-info"}
    emphases[@name]
  end

  def bar_class
    emphases = {COMPLETE => "bar-success",
      IN_PROGRESS => "bar-warning",
      OVERDUE => "bar-danger",
      FUTURE => ""}
    emphases[@name]
  end
end