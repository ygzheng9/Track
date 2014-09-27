class Project < ActiveRecord::Base
  belongs_to :client

  validates_presence_of :client_id, :code, :name 

  def full_name
    "#{client.name} - #{name} - #{code}"
  end   

  def self.get_all_available
    Project.where("is_available = 1 or is_available = 't' or is_available is null").order("client_id asc, name, code")
  end 

  def self.get_all_closed
    get_all(0)
  end 

  def self.mark_closed(ids)
    update_all("is_available = 0", id: ids)
  end 

  def self.mark_reopen(ids)
    update_all("is_available = 1", id: ids)
  end 

private 
  def self.get_all(is_available)
    Project.where("is_available = ?", is_available).order("client_id asc, name, code")
  end 

end
