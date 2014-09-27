class Meal < ActiveRecord::Base
  validates_presence_of :start, :end, :spot_id, :amount, :is_paid
  validates_numericality_of :amount, greater_than_or_equal_to: 0

  belongs_to :drop
  belongs_to :spot
  belongs_to :key_person, class_name: :Colleague
  belongs_to :additional_person, class_name: :Colleague

  has_many :meal_dishes
end
