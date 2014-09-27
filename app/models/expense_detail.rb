class ExpenseDetail < ActiveRecord::Base
  belongs_to :expense_type
  belongs_to :payment_type

  validates_presence_of :today, :amount, :expense_type_id, :payment_type_id
  validates_numericality_of :amount, :greater_than_or_equal_to => 0

  def CopyWholeDay(target_date) 
    same_day_itms = ExpenseDetail.where(today: today)
    
    same_day_itms.each do |it| 
      new_it = it.dup
      new_it.today = target_date
      new_it.save
    end 
  end   

  def BundleCopy(src_date, fm_date, to_date)
    src_itms = ExpenseDetail.where(today: src_date)
    
    target_date = fm_date 
    while target_date <= to_date
      src_itms.each do |it| 
        new_it = it.dup
        new_it.today = target_date
        new_it.save
      end 

      target_date.addOneDay
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