class Segment < ActiveRecord::Base

  validates_presence_of :step, :km, :kcal
  validates_numericality_of :step, :km, :kcal, greater_than_or_equal_to: 0

  belongs_to :drop
  # delegete :today to :drop

end
