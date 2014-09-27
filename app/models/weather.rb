class Weather < ActiveRecord::Base

  validates_presence_of :condition

  validates_uniqueness_of :condition

  has_and_belongs_to_many :drops
  
end
