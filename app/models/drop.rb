class Drop < ActiveRecord::Base

  validates_presence_of :today, :getup_at, :sleep_at, :step, :km, :kcal, :pp, :xx
  validates_numericality_of :step, :km, :kcal, :pp, :xx, greater_than_or_equal_to: 0
  validates_uniqueness_of :today

  has_many :segments, dependent: :destroy
  has_many :meals, dependent: :destroy

  has_and_belongs_to_many :weathers

  # have total, have segments, then calculate the missing: total - sum(segments)
  def update_alignment

    inital_params = {is_valid:0, step: step, km: km, kcal: kcal}
    new_align = segments.create_with(inital_params).find_or_create_by(is_valid: 0)

    total_valid = segments.select("sum(step) as step, sum(km) as km, sum(kcal) as kcal").where("is_valid = 1").first

    unless total_valid.step.nil?
      new_align.step = step - total_valid.step
      new_align.km = km - total_valid.km
      new_align.kcal = kcal - total_valid.kcal
    end

    new_align.save!(:validate => false)
  end


  def self.multi_copy(ids, fm_dt, to_dt)
    selected_item = find(ids).first

    cnt = 0

    (fm_dt .. to_dt).each do |target_dt|
      new_drop = selected_item.dup
      new_drop.today = target_dt
      new_drop.save

      selected_item.segments.each do |seg|
        new_seg = seg.dup
        new_seg.drop = new_drop
        new_seg.save
      end

      cnt += 1
    end

    cnt
  end

  def self.to_csv
    # export_cols = ["id","today","getup_at","sleep_at","step","km","kcal","pp","xx","comment","is_alarm"]
    export_cols = %w{ id today getup_at sleep_at step km kcal pp xx comment is_alarm
    CSV.generate do |csv|
      csv << export_cols
      all.each do |line|
        csv << line.attributes.values_at(*export_cols)
      end
    end
  end

end
