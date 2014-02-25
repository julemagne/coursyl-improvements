class Reading < ActiveRecord::Base
  belongs_to :lesson

  validates :order_number, presence: true
  validates :url, format: {with: /\Ahttps?:\/\//, message: "must start with http:// or https://"}, allow_blank: true

  scope :pre, -> { where("before_lesson = ?", true) }
  scope :post, -> { where("before_lesson != ?", true) }
end
