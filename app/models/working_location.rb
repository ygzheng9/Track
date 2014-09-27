class WorkingLocation < ActiveRecord::Base
  belongs_to :site

  delegate :city, :to => :site, :allow_nil => true

  mattr_accessor :city_id

  validates_presence_of :today, :site_id, :Taxi
  validates_numericality_of :Taxi, greater_than_or_equal_to: 0

  def city_id
    if site == nil 
      nil
    else
      "#{site.city.id}"
    end     
  end 

  def CopyWholeDay(target_date)    
    same_day_itms = WorkingLocation.where(today: today)
    
    same_day_itms.each do |it| 
      new_it = it.dup
      new_it.today = target_date
      new_it.save
    end 
  end 

  def self.multi_copy(ids, fm_dt, to_dt)
    selected_items = find(ids)

    cnt = 0

    (fm_dt .. to_dt).each do |target_dt|
      selected_items.each do |it| 
        new_it = it.dup
        new_it.today = target_dt
        new_it.save

        cnt += 1
      end 
    end 

    cnt
  end    
    
end
