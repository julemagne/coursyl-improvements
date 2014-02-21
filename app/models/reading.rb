class Reading < ActiveRecord::Base
  belongs_to :lesson

  scope :pre, -> { where("before_lesson = ?", true) }
  scope :post, -> { where("before_lesson != ?", true) }
end
