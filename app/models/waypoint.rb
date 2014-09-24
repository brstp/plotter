class Waypoint < ActiveRecord::Base
  belongs_to :rounds
  
  def to_s
    self.name
  end
  
  def latlng
    [self.latitude,self.longitude]
  end
  
end
